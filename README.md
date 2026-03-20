# Flowbite Skills for Claude Code

68 Claude Code skills for the [Flowbite](https://flowbite.com) UI component library. Each component gets its own skill so Claude only loads the docs it needs — no noise, no bloat.

Built from Flowbite v4.0.1 source documentation.

## Install

```bash
# Install all skills
npx skills add your-username/flowbite-skills --skill '*'

# Install specific skills
npx skills add your-username/flowbite-skills --skill flowbite-modal
npx skills add your-username/flowbite-skills --skill flowbite-navbar
```

Install the **index skill** for general Flowbite guidance and component discovery:

```bash
npx skills add your-username/flowbite-skills --skill flowbite
```

## Skills

### Index

| Skill | Description |
|-------|-------------|
| `flowbite` | Component directory, theming, dark mode, colors, icons, RTL |

### Components (43)

| Skill | Description |
|-------|-------------|
| `flowbite-accordion` | Collapse and expand sections |
| `flowbite-alert` | Contextual alert messages |
| `flowbite-avatar` | User profile images |
| `flowbite-badge` | Count and label indicators |
| `flowbite-banner` | Sticky marketing banners |
| `flowbite-bottom-nav` | Mobile bottom navigation bar |
| `flowbite-breadcrumb` | Hierarchical page navigation |
| `flowbite-buttons` | Button styles and variants |
| `flowbite-button-group` | Grouped button toolbar |
| `flowbite-card` | Content cards and panels |
| `flowbite-carousel` | Image slider and slideshow |
| `flowbite-chat-bubble` | Chat message bubbles |
| `flowbite-clipboard` | Copy to clipboard |
| `flowbite-datepicker` | Date picker calendar |
| `flowbite-device-mockup` | Phone/laptop/tablet frames |
| `flowbite-drawer` | Off-canvas sidebar panel |
| `flowbite-dropdown` | Dropdown menus |
| `flowbite-footer` | Page footer sections |
| `flowbite-forms-overview` | Form layout overview |
| `flowbite-gallery` | Image gallery and masonry grid |
| `flowbite-indicators` | Status dots and badges |
| `flowbite-jumbotron` | Hero/landing sections |
| `flowbite-kbd` | Keyboard shortcut display |
| `flowbite-list-group` | List items and menus |
| `flowbite-mega-menu` | Multi-column navigation menu |
| `flowbite-modal` | Dialog and popup overlays |
| `flowbite-navbar` | Top navigation bar |
| `flowbite-pagination` | Page number navigation |
| `flowbite-popover` | Hover/click info popups |
| `flowbite-progress` | Progress bars |
| `flowbite-rating` | Star ratings and reviews |
| `flowbite-sidebar` | Side navigation menu |
| `flowbite-skeleton` | Loading placeholder |
| `flowbite-speed-dial` | Floating action button menu |
| `flowbite-spinner` | Loading spinner animation |
| `flowbite-stepper` | Multi-step wizard |
| `flowbite-tables` | Data tables |
| `flowbite-tabs` | Tabbed content panels |
| `flowbite-timeline` | Chronological event display |
| `flowbite-toast` | Toast notifications |
| `flowbite-tooltip` | Hover tooltips |
| `flowbite-typography-comp` | Typography utilities |
| `flowbite-video` | Video embeds and players |

### Forms (13)

| Skill | Description |
|-------|-------------|
| `flowbite-input` | Text input fields |
| `flowbite-file-input` | File upload input |
| `flowbite-search-input` | Search input with icon |
| `flowbite-number-input` | Number input with controls |
| `flowbite-phone-input` | Phone number input |
| `flowbite-select` | Select dropdown |
| `flowbite-textarea` | Multi-line text input |
| `flowbite-timepicker` | Time picker |
| `flowbite-checkbox` | Checkbox input |
| `flowbite-radio` | Radio button input |
| `flowbite-toggle` | Toggle switch |
| `flowbite-range` | Range slider |
| `flowbite-floating-label` | Animated floating label input |

### Typography (8)

| Skill | Description |
|-------|-------------|
| `flowbite-headings` | Heading styles |
| `flowbite-paragraphs` | Paragraph styles |
| `flowbite-blockquote` | Blockquote styles |
| `flowbite-images` | Image styles and captions |
| `flowbite-lists` | Ordered and unordered lists |
| `flowbite-links` | Link styles |
| `flowbite-text` | Text formatting utilities |
| `flowbite-hr` | Horizontal rule dividers |

### Plugins (3)

| Skill | Description |
|-------|-------------|
| `flowbite-charts` | Chart and graph components |
| `flowbite-datatables` | Sortable, filterable data tables |
| `flowbite-wysiwyg` | Rich text editor |

## Updating skills to a new Flowbite version

This repo includes a build pipeline that regenerates all skills from the Flowbite source. The source is a git submodule pinned to a release tag.

```bash
# Update to latest Flowbite release
ruby scripts/fetch_source.rb

# Or pin to a specific version
ruby scripts/fetch_source.rb v4.1.0

# Regenerate all skills
ruby scripts/generate_skills.rb
```

## How it works

Each skill has a lean `SKILL.md` (~200-500 words) that lists variants and trigger words, plus a `references/` directory with the full cleaned documentation and HTML code examples. This uses Claude Code's progressive disclosure — the SKILL.md loads when triggered, and Claude reads the reference docs only when it needs the actual code.

The source documentation is cleaned from Flowbite's Hugo format: shortcodes are stripped, HTML examples are preserved in fenced code blocks, and all Tailwind CSS classes are kept intact.

## License

Skills are generated from [Flowbite](https://github.com/themesberg/flowbite) documentation, which is MIT licensed.
