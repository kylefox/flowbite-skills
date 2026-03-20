---
name: flowbite
description: "Flowbite UI component library index and overview. Use this skill to discover available Flowbite components, understand Flowbite conventions (data attributes, dark mode, Tailwind CSS patterns), and access customization docs (theming, colors, icons, RTL). This skill should be used when the user asks about Flowbite in general, wants to know which components are available, or needs guidance on theming and customization."
---

# Flowbite

Flowbite is a free and open-source UI component library built on top of Tailwind CSS. It provides ready-to-use HTML components with data attributes to enable interactive elements for building modern, responsive websites.

## Prerequisites

Before outputting any Flowbite component code, verify the project has Flowbite configured. Check for the Flowbite plugin in the project's Tailwind CSS config (usually `tailwind.config.js`, `tailwind.config.ts`, or a `@plugin` directive in the main CSS file).

**What to look for:**

Tailwind CSS v4 (CSS-based config):
```css
@plugin "flowbite/plugin";
```

Tailwind CSS v3 (JS-based config):
```js
plugins: [require('flowbite/plugin')]
```

**If Flowbite is not configured**, guide the user through setup before outputting component code:
1. Install: `npm install flowbite`
2. Add the plugin to their Tailwind config (see above)
3. For interactive components, include the JS: add `<script src="../path/to/flowbite/dist/flowbite.min.js"></script>` or `import 'flowbite';` in their entry point

**Why this matters:** Flowbite v4 uses semantic theme classes (`bg-neutral-primary`, `text-heading`, `border-default`, `bg-brand`, `rounded-base`, etc.) that only resolve when the Flowbite plugin is active. Without it, these classes produce no styles.

## Key Concepts

- **Tailwind CSS based**: All components use Tailwind utility classes for styling
- **Semantic theme classes**: Flowbite v4 uses semantic tokens (`text-heading`, `bg-brand`, `border-default`) instead of raw Tailwind colors (`text-gray-900`, `bg-blue-700`)
- **Data attributes**: Interactive components use `data-*` attributes (e.g., `data-modal-toggle`, `data-dropdown-toggle`) — no manual JS initialization needed
- **Dark mode**: Components support dark mode via Tailwind's `dark:` prefix and semantic tokens automatically adapt
- **Responsive**: Components are mobile-first and responsive by default

## Component Directory

| Component | Category | Skill | Description |
|-----------|----------|-------|-------------|
| Accordion | Components | `flowbite-accordion` | Use the accordion component to show hidden information based on the collapse and ... |
| Alerts | Components | `flowbite-alert` | Show contextual information to your users using alert elements based on Tailwind ... |
| Avatar | Components | `flowbite-avatar` | Use the avatar component to show a visual representation of a user profile using ... |
| Badges | Components | `flowbite-badge` | Use Tailwind CSS badges as elements to show counts or labels separately or inside... |
| Sticky Banner | Components | `flowbite-banner` | Use the banner component to show marketing messages and CTA buttons at the top or... |
| Bottom Navigation | Components | `flowbite-bottom-nav` | Use the bottom navigation bar component to allow users to navigate through your w... |
| Breadcrumbs | Components | `flowbite-breadcrumb` | Show the location of the current page in a hierarchical structure using the Tailw... |
| Buttons | Components | `flowbite-buttons` | Use the Tailwind CSS button component inside forms, as links, and more with suppo... |
| Button Group | Components | `flowbite-button-group` | Button groups are a Tailwind CSS powered set of buttons sticked together in a hor... |
| Cards | Components | `flowbite-card` | Get started with a large variety of Tailwind CSS card examples for your web proje... |
| Carousel | Components | `flowbite-carousel` | Use the carousel component to slide through multiple elements and images using cu... |
| Chat Bubble | Components | `flowbite-chat-bubble` | Use the chat bubble component to show chat messages in your web application inclu... |
| Copy to Clipboard | Components | `flowbite-clipboard` | Use the clipboard component to copy text, data or lines of code to the clipboard ... |
| Datepicker | Components | `flowbite-datepicker` | Start receiving date and time data from your users using this free datepicker ele... |
| Device Mockups | Components | `flowbite-device-mockup` | Use the device mockups component to add content and screenshot previews of your a... |
| Drawer (offcanvas) | Components | `flowbite-drawer` | The Drawer component can be used as a hidden off-canvas sidebar for navigation an... |
| Dropdown | Components | `flowbite-dropdown` | Get started with the dropdown component to show a list of menu items when clickin... |
| Footer | Components | `flowbite-footer` | Use the footer section at the bottom of every page to show valuable information t... |
| Forms | Components | `flowbite-forms-overview` | Use the Tailwind CSS form and input elements such as checkboxes, radios, textarea... |
| Gallery (Masonry) | Components | `flowbite-gallery` | Use the image gallery component based on a masonry grid layout using flex and gri... |
| Indicators | Components | `flowbite-indicators` | Use the indicator component to show a number count, account status, or as a loadi... |
| Jumbotron | Components | `flowbite-jumbotron` | Use the jumbotron component to show a marketing message to your users based on a ... |
| KBD (Keyboard) | Components | `flowbite-kbd` | Use the KBD component as an inline element to denote textual user input from the ... |
| List Group | Components | `flowbite-list-group` | Use the list group component to display a series of items, buttons or links insid... |
| Mega Menu | Components | `flowbite-mega-menu` | Use the mega menu component as a full-width dropdown inside the navbar to show a ... |
| Modal | Components | `flowbite-modal` | Use the modal component to show interactive dialogs and notifications to your web... |
| Navbar | Components | `flowbite-navbar` | The navbar component can be used to show a list of navigation links positioned on... |
| Pagination | Components | `flowbite-pagination` | Use the Tailwind CSS pagination element to indicate a series of content across va... |
| Popover | Components | `flowbite-popover` | Use the popover component to show detailed information inside a pop-up box relati... |
| Progress Bar | Components | `flowbite-progress` | Use the progress bar component to show the completion rate of a data indicator or... |
| Rating | Components | `flowbite-rating` | Use the rating component to show reviews and testimonials from your users using s... |
| Sidebar | Components | `flowbite-sidebar` | Use the sidebar component to show a list of menu items and multi-level menu items... |
| Skeleton | Components | `flowbite-skeleton` | The skeleton component can be used as an alternative loading indicator to the spi... |
| Speed Dial | Components | `flowbite-speed-dial` | The speed dial component can be used as a quick way to show a list of action butt... |
| Spinner | Components | `flowbite-spinner` | Use the spinner component as a loader indicator in your projects when fetching da... |
| Stepper | Components | `flowbite-stepper` | Use the stepper component to show the number of steps required to complete a form... |
| Table | Components | `flowbite-tables` | Use the table component to show text, images, links, and other elements inside a ... |
| Tabs | Components | `flowbite-tabs` | Use these responsive tabs components to create a secondary navigational hierarchy... |
| Timeline | Components | `flowbite-timeline` | Get started with the responsive timeline component to show data in a chronologica... |
| Toast | Components | `flowbite-toast` | Push notifications to your users using the toast component and choose from multip... |
| Tooltip | Components | `flowbite-tooltip` | Use the following Tailwind CSS powered tooltips to show extra content when hoveri... |
| Typography | Components | `flowbite-typography-comp` | Use the typography plugin from Flowbite to apply styles to all inline elements li... |
| Video | Components | `flowbite-video` | Use the video component to configure an embedded video player using native HTML 5... |
| Input Field | Forms | `flowbite-input` | Get started with a collection of input fields built with Tailwind CSS to start ac... |
| File Input | Forms | `flowbite-file-input` | Get started with the file input component to let the user to upload one or more f... |
| Search Input | Forms | `flowbite-search-input` | Use the search input component as a text field to allow users to enter search que... |
| Number Input | Forms | `flowbite-number-input` | Use the number input component to set a numeric value inside a form field based o... |
| Phone Input | Forms | `flowbite-phone-input` | Use the phone number input component from Flowbite to set a phone number inside a... |
| Select | Forms | `flowbite-select` | Get started with the select component to allow the user to choose from one or mor... |
| Textarea | Forms | `flowbite-textarea` | Use the textarea component as a multi-line text field input and use it inside for... |
| Timepicker | Forms | `flowbite-timepicker` | Use the timepicker component from Flowbite to select the time of the day in terms... |
| Checkbox | Forms | `flowbite-checkbox` | Get started with the checkbox component to allow the user to select one or more o... |
| Radio | Forms | `flowbite-radio` | Get started with the radio component to let the user choose a single option from ... |
| Toggle | Forms | `flowbite-toggle` | Use the toggle component to switch between a binary state of true or false using ... |
| Range Slider | Forms | `flowbite-range` | Get started with the range component to receive a number from the user anywhere f... |
| Floating Label | Forms | `flowbite-floating-label` | Use the floating label style for the input field elements to replicate the Materi... |
| Headings | Typography | `flowbite-headings` | The heading component defines six levels of title elements from H1 to H6 that are... |
| Paragraphs | Typography | `flowbite-paragraphs` | Use the paragraph component to create multiple blocks of text separated by blank ... |
| Blockquote | Typography | `flowbite-blockquote` | The blockquote component can be used to quote text content from an external sourc... |
| Images | Typography | `flowbite-images` | The image component can be used to embed images inside the web page in articles a... |
| Lists | Typography | `flowbite-lists` | Use the list component to show an unordered or ordered list of items based on mul... |
| Links | Typography | `flowbite-links` | The link component can be used to set hyperlinks from one page to another or to a... |
| Text | Typography | `flowbite-text` | Learn how to customize text-related styles and properties such as font size, font... |
| Horizontal Line (HR) | Typography | `flowbite-hr` | Create a horizontal line using the HR tag to separate content such as paragraphs,... |
| Charts | Plugins | `flowbite-charts` | Use the chart and graph components from Flowbite built with Tailwind CSS and Apex... |
| Datatables | Plugins | `flowbite-datatables` | Use the datatable component to search, sort, filter, export and paginate table da... |
| WYSIWYG Text Editor | Plugins | `flowbite-wysiwyg` | Use the wysiwyg text editor component from Flowbite to create and modify content ... |

## Customization References

For theming, dark mode, colors, icons, and RTL configuration:

- `references/colors.md`
- `references/configuration.md`
- `references/dark-mode.md`
- `references/icons.md`
- `references/optimization.md`
- `references/rtl.md`
- `references/theming.md`
- `references/variables.md`
