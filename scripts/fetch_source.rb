#!/usr/bin/env ruby
# frozen_string_literal: true

# Fetches/updates the Flowbite source submodule and LLM documentation files.
#
# Usage:
#   ruby scripts/fetch_source.rb           # Update submodule to latest release tag
#   ruby scripts/fetch_source.rb v4.1.0    # Update submodule to a specific tag

require "open-uri"
require "json"
require "fileutils"

ROOT = File.expand_path("..", __dir__)
SUBMODULE_PATH = File.join(ROOT, "flowbite-source")
REPO = "themesberg/flowbite"

LLM_FILES = {
  "llms.txt" => "https://raw.githubusercontent.com/#{REPO}/refs/heads/main/llms.txt",
  "llms-full.txt" => "https://raw.githubusercontent.com/#{REPO}/refs/heads/main/llms-full.txt",
}.freeze

def run(cmd, dir: ROOT)
  output = `cd #{dir} && #{cmd} 2>&1`.strip
  unless $?.success?
    warn "  FAILED: #{cmd}"
    warn "  #{output}"
    exit 1
  end
  output
end

def fetch_latest_tag
  puts "Fetching latest release tag from GitHub..."
  tags_json = URI.open("https://api.github.com/repos/#{REPO}/tags?per_page=1").read
  tags = JSON.parse(tags_json)
  tags.first&.dig("name") || abort("No tags found for #{REPO}")
end

def setup_submodule(tag)
  if Dir.exist?(File.join(SUBMODULE_PATH, ".git")) || File.exist?(File.join(SUBMODULE_PATH, ".git"))
    puts "Submodule exists. Fetching updates..."
    run("git fetch --tags", dir: SUBMODULE_PATH)
  elsif Dir.exist?(SUBMODULE_PATH)
    # Existing directory but not a submodule — check if it's already a git repo
    if Dir.exist?(File.join(SUBMODULE_PATH, ".git"))
      puts "Found existing git repo at #{SUBMODULE_PATH}. Fetching..."
      run("git fetch --tags", dir: SUBMODULE_PATH)
    else
      warn "#{SUBMODULE_PATH} exists but is not a git repo."
      warn "Remove it first, then re-run: rm -rf flowbite-source"
      exit 1
    end
  else
    puts "Adding submodule..."
    run("git submodule add https://github.com/#{REPO}.git flowbite-source")
  end

  current = `cd #{SUBMODULE_PATH} && git describe --tags --exact-match 2>/dev/null`.strip
  if current == tag
    puts "Already at #{tag}."
  else
    puts "Checking out #{tag}..."
    run("git checkout #{tag}", dir: SUBMODULE_PATH)
    puts "Updated from #{current.empty? ? 'unknown' : current} → #{tag}"
  end
end

def download_llm_files
  puts "\nDownloading LLM documentation files..."
  LLM_FILES.each do |filename, url|
    dest = File.join(ROOT, filename)
    print "  #{filename}... "
    content = URI.open(url).read
    File.write(dest, content)
    puts "OK (#{(content.bytesize / 1024.0).round(1)} KB)"
  end
end

def show_doc_summary
  content_dir = File.join(SUBMODULE_PATH, "content")
  return unless Dir.exist?(content_dir)

  puts "\nSource documentation summary:"
  %w[components forms typography plugins customize].each do |category|
    dir = File.join(content_dir, category)
    next unless Dir.exist?(dir)

    files = Dir.glob(File.join(dir, "*.md")).reject { |f| f.include?("_index") }
    puts "  #{category}: #{files.size} files"
  end
end

# --- Main ---

tag = ARGV[0] || fetch_latest_tag
puts "Target version: #{tag}\n\n"

setup_submodule(tag)
download_llm_files
show_doc_summary

puts "\nDone! Run `ruby scripts/generate_skills.rb` to regenerate skills."
