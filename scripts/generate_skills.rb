#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates Flowbite skills from cleaned source documentation.
# Each component gets its own skill directory with SKILL.md and references/.
#
# Usage:
#   ruby scripts/generate_skills.rb                    # Generate all skills
#   ruby scripts/generate_skills.rb modal navbar       # Generate specific skills only

require "fileutils"
require_relative "clean_docs"

SOURCE_BASE = File.expand_path("../flowbite-source/content", __dir__)
SKILLS_DIR = File.expand_path("../skills", __dir__)

# Component mapping: skill_name => { source: relative_path, synonyms: [trigger words] }
COMPONENTS = {
  # --- Components (44) ---
  "flowbite-accordion" => { source: "components/accordion.md", synonyms: %w[accordion collapse expand toggle section] },
  "flowbite-alert" => { source: "components/alerts.md", synonyms: %w[alert notification warning error success info message] },
  "flowbite-avatar" => { source: "components/avatar.md", synonyms: %w[avatar profile picture user image thumbnail] },
  "flowbite-badge" => { source: "components/badge.md", synonyms: %w[badge tag label chip count indicator] },
  "flowbite-banner" => { source: "components/banner.md", synonyms: %w[banner announcement bar notification sticky] },
  "flowbite-bottom-nav" => { source: "components/bottom-navigation.md", synonyms: %w[bottom navigation mobile nav tab bar footer nav] },
  "flowbite-breadcrumb" => { source: "components/breadcrumb.md", synonyms: %w[breadcrumb navigation path trail crumb] },
  "flowbite-buttons" => { source: "components/buttons.md", synonyms: %w[button btn click action submit CTA] },
  "flowbite-button-group" => { source: "components/button-group.md", synonyms: %w[button group toolbar segmented toggle buttons] },
  "flowbite-card" => { source: "components/card.md", synonyms: %w[card panel box container content block tile] },
  "flowbite-carousel" => { source: "components/carousel.md", synonyms: %w[carousel slider slideshow image gallery swipe] },
  "flowbite-chat-bubble" => { source: "components/chat-bubble.md", synonyms: %w[chat bubble message conversation speech] },
  "flowbite-clipboard" => { source: "components/clipboard.md", synonyms: %w[clipboard copy paste copy-to-clipboard] },
  "flowbite-datepicker" => { source: "components/datepicker.md", synonyms: %w[datepicker date picker calendar date-input] },
  "flowbite-device-mockup" => { source: "components/device-mockups.md", synonyms: %w[device mockup phone laptop tablet preview frame] },
  "flowbite-drawer" => { source: "components/drawer.md", synonyms: %w[drawer sidebar off-canvas slide panel sheet] },
  "flowbite-dropdown" => { source: "components/dropdowns.md", synonyms: %w[dropdown menu select popup action-menu context-menu] },
  "flowbite-footer" => { source: "components/footer.md", synonyms: %w[footer bottom page-footer site-footer] },
  "flowbite-forms-overview" => { source: "components/forms.md", synonyms: %w[form overview input layout fieldset form-group] },
  "flowbite-gallery" => { source: "components/gallery.md", synonyms: %w[gallery image grid photo masonry lightbox] },
  "flowbite-indicators" => { source: "components/indicators.md", synonyms: %w[indicator dot status online offline badge notification-dot] },
  "flowbite-jumbotron" => { source: "components/jumbotron.md", synonyms: %w[jumbotron hero banner header CTA landing] },
  "flowbite-kbd" => { source: "components/kbd.md", synonyms: %w[kbd keyboard key shortcut hotkey keybinding] },
  "flowbite-list-group" => { source: "components/list-group.md", synonyms: %w[list group menu item collection] },
  "flowbite-mega-menu" => { source: "components/mega-menu.md", synonyms: %w[mega menu navigation large dropdown multi-column] },
  "flowbite-modal" => { source: "components/modal.md", synonyms: %w[modal dialog popup overlay lightbox confirm] },
  "flowbite-navbar" => { source: "components/navbar.md", synonyms: %w[navbar navigation header top-bar menu-bar nav] },
  "flowbite-pagination" => { source: "components/pagination.md", synonyms: %w[pagination paging page numbers next previous] },
  "flowbite-popover" => { source: "components/popover.md", synonyms: %w[popover popup info hover detail card] },
  "flowbite-progress" => { source: "components/progress.md", synonyms: %w[progress bar loading percentage completion meter] },
  "flowbite-rating" => { source: "components/rating.md", synonyms: %w[rating star review score feedback] },
  "flowbite-sidebar" => { source: "components/sidebar.md", synonyms: %w[sidebar side navigation menu panel drawer] },
  "flowbite-skeleton" => { source: "components/skeleton.md", synonyms: %w[skeleton placeholder loading shimmer wireframe] },
  "flowbite-speed-dial" => { source: "components/speed-dial.md", synonyms: %w[speed dial fab floating action button quick actions] },
  "flowbite-spinner" => { source: "components/spinner.md", synonyms: %w[spinner loading indicator loader animation] },
  "flowbite-stepper" => { source: "components/stepper.md", synonyms: %w[stepper steps wizard progress multi-step timeline] },
  "flowbite-tables" => { source: "components/tables.md", synonyms: %w[table data grid rows columns cells] },
  "flowbite-tabs" => { source: "components/tabs.md", synonyms: %w[tabs tab panel switch toggle content] },
  "flowbite-timeline" => { source: "components/timeline.md", synonyms: %w[timeline history events chronological vertical horizontal] },
  "flowbite-toast" => { source: "components/toast.md", synonyms: %w[toast notification snackbar message popup alert] },
  "flowbite-tooltip" => { source: "components/tooltips.md", synonyms: %w[tooltip hint hover info tip] },
  "flowbite-typography-comp" => { source: "components/typography.md", synonyms: %w[typography text formatting prose content] },
  "flowbite-video" => { source: "components/video.md", synonyms: %w[video player embed media youtube] },
  # --- Forms (13) ---
  "flowbite-input" => { source: "forms/input-field.md", synonyms: %w[input text field form entry] },
  "flowbite-file-input" => { source: "forms/file-input.md", synonyms: %w[file input upload attachment browse] },
  "flowbite-search-input" => { source: "forms/search-input.md", synonyms: %w[search input find filter query] },
  "flowbite-number-input" => { source: "forms/number-input.md", synonyms: %w[number input counter quantity increment decrement] },
  "flowbite-phone-input" => { source: "forms/phone-input.md", synonyms: %w[phone input telephone mobile country-code] },
  "flowbite-select" => { source: "forms/select.md", synonyms: %w[select dropdown option choice picker] },
  "flowbite-textarea" => { source: "forms/textarea.md", synonyms: %w[textarea multiline text comment message] },
  "flowbite-timepicker" => { source: "forms/timepicker.md", synonyms: %w[timepicker time picker clock hour minute] },
  "flowbite-checkbox" => { source: "forms/checkbox.md", synonyms: %w[checkbox check tick toggle multi-select] },
  "flowbite-radio" => { source: "forms/radio.md", synonyms: %w[radio button option single-select choice] },
  "flowbite-toggle" => { source: "forms/toggle.md", synonyms: %w[toggle switch on-off boolean flip] },
  "flowbite-range" => { source: "forms/range.md", synonyms: %w[range slider input value min max] },
  "flowbite-floating-label" => { source: "forms/floating-label.md", synonyms: %w[floating label input animated placeholder] },

  # --- Typography (8) ---
  "flowbite-headings" => { source: "typography/headings.md", synonyms: %w[heading title h1 h2 h3 header] },
  "flowbite-paragraphs" => { source: "typography/paragraphs.md", synonyms: %w[paragraph text body content prose] },
  "flowbite-blockquote" => { source: "typography/blockquote.md", synonyms: %w[blockquote quote citation testimonial] },
  "flowbite-images" => { source: "typography/images.md", synonyms: %w[image picture photo figure caption responsive] },
  "flowbite-lists" => { source: "typography/lists.md", synonyms: %w[list ordered unordered bullet numbered items] },
  "flowbite-links" => { source: "typography/links.md", synonyms: %w[link anchor href url navigation] },
  "flowbite-text" => { source: "typography/text.md", synonyms: %w[text formatting bold italic underline decoration] },
  "flowbite-hr" => { source: "typography/hr.md", synonyms: %w[hr horizontal rule divider separator line] },

  # --- Plugins (3) ---
  "flowbite-charts" => { source: "plugins/charts.md", synonyms: %w[chart graph visualization data plot bar line pie] },
  "flowbite-datatables" => { source: "plugins/datatables.md", synonyms: %w[datatable data table sort filter paginate search] },
  "flowbite-wysiwyg" => { source: "plugins/wysiwyg.md", synonyms: %w[wysiwyg editor rich text markdown formatting toolbar] },
}.freeze

def generate_skill_md(name, result, config)
  title = result[:title]
  description = result[:description]
  headings = result[:headings]
  requires_js = result[:requires_js]
  synonyms = config[:synonyms]

  trigger_text = synonyms.join(", ")

  skill_description = "This skill provides Flowbite #{title} documentation and code examples. " \
    "Use when implementing #{title.downcase} elements with Flowbite and Tailwind CSS. " \
    "Triggers: #{trigger_text}"

  sections = if headings.any?
    heading_list = headings.map { |h| "- #{h}" }.join("\n")
    <<~MD

      ## Available Variants

      #{heading_list}
    MD
  else
    ""
  end

  js_note = if requires_js
    "\n**Requires JavaScript:** This component uses Flowbite's JS via data attributes for interactivity.\n"
  else
    ""
  end

  <<~SKILL
    ---
    name: #{name}
    description: "#{skill_description}"
    ---

    # Flowbite #{title}

    #{description}
    #{js_note}#{sections}
    ## Usage

    For full documentation with all variants and code examples, read `references/#{reference_filename(name)}.md`.
  SKILL
end

def reference_filename(skill_name)
  skill_name.sub("flowbite-", "")
end

def generate_skill(name, config, cleaner)
  source_path = File.join(SOURCE_BASE, config[:source])

  unless File.exist?(source_path)
    warn "  SKIP #{name}: source not found at #{source_path}"
    return false
  end

  result = cleaner.clean_file(source_path)
  skill_dir = File.join(SKILLS_DIR, name)
  refs_dir = File.join(skill_dir, "references")

  FileUtils.mkdir_p(refs_dir)

  # Write SKILL.md
  skill_content = generate_skill_md(name, result, config)
  File.write(File.join(skill_dir, "SKILL.md"), skill_content)

  # Write reference doc
  ref_name = reference_filename(name)
  File.write(File.join(refs_dir, "#{ref_name}.md"), result[:content])

  true
end

def generate_index_skill(cleaner)
  skill_dir = File.join(SKILLS_DIR, "flowbite")
  refs_dir = File.join(skill_dir, "references")
  FileUtils.mkdir_p(refs_dir)

  # Build component directory table
  rows = COMPONENTS.map do |name, config|
    source_path = File.join(SOURCE_BASE, config[:source])
    next unless File.exist?(source_path)

    result = cleaner.clean_file(source_path)
    category = config[:source].split("/").first.capitalize
    "| #{result[:title]} | #{category} | `#{name}` | #{result[:description][0..80]}... |"
  end.compact

  table = "| Component | Category | Skill | Description |\n" \
          "|-----------|----------|-------|-------------|\n" \
          "#{rows.join("\n")}"

  # Clean customization docs into references
  customize_docs = Dir.glob(File.join(SOURCE_BASE, "customize", "*.md")).reject { |f| f.include?("_index") }
  customize_docs.each do |doc_path|
    result = cleaner.clean_file(doc_path)
    basename = File.basename(doc_path, ".md")
    File.write(File.join(refs_dir, "#{basename}.md"), result[:content])
  end

  customize_list = customize_docs.map do |doc_path|
    basename = File.basename(doc_path, ".md")
    "- `references/#{basename}.md`"
  end.join("\n")

  skill_md = <<~SKILL
    ---
    name: flowbite
    description: "Flowbite UI component library index and overview. Use this skill to discover available Flowbite components, understand Flowbite conventions (data attributes, dark mode, Tailwind CSS patterns), and access customization docs (theming, colors, icons, RTL). This skill should be used when the user asks about Flowbite in general, wants to know which components are available, or needs guidance on theming and customization."
    ---

    # Flowbite

    Flowbite is a free and open-source UI component library built on top of Tailwind CSS. It provides ready-to-use HTML components with data attributes to enable interactive elements for building modern, responsive websites.

    ## Key Concepts

    - **Tailwind CSS based**: All components use Tailwind utility classes for styling
    - **Data attributes**: Interactive components use `data-*` attributes (e.g., `data-modal-toggle`, `data-dropdown-toggle`) — no manual JS initialization needed
    - **Dark mode**: Components support dark mode via Tailwind's `dark:` prefix
    - **Responsive**: Components are mobile-first and responsive by default

    ## Component Directory

    #{table}

    ## Customization References

    For theming, dark mode, colors, icons, and RTL configuration:

    #{customize_list}
  SKILL

  File.write(File.join(skill_dir, "SKILL.md"), skill_md)
  puts "  Generated index skill: flowbite/"
end

# --- Main ---

cleaner = CleanDocs.new
filter = ARGV.empty? ? nil : ARGV.map { |a| "flowbite-#{a}" unless a.start_with?("flowbite-") ? a : a }

# If specific skills requested, only generate those
targets = if ARGV.empty?
  COMPONENTS
else
  names = ARGV.map { |a| a.start_with?("flowbite-") ? a : "flowbite-#{a}" }
  COMPONENTS.select { |k, _| names.include?(k) }
end

puts "Generating #{targets.size} component skill(s)..."

generated = 0
skipped = 0
targets.each do |name, config|
  print "  #{name}... "
  if generate_skill(name, config, cleaner)
    puts "OK"
    generated += 1
  else
    skipped += 1
  end
end

# Always generate index skill
puts "\nGenerating index skill..."
generate_index_skill(cleaner)

puts "\nDone! Generated #{generated} skills, skipped #{skipped}."
puts "Skills output: #{SKILLS_DIR}/"
