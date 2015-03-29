# atom-resizable-panel

Wraps a DOM node or jQuery element in a Panel that provides a scroll area and resize handle.

### Usage

In package.json:
```json
"dependencies": {
  "atom-resizable-panel": "git://github.com/redefiance/atom-resizable-panel.git"
}
```

In .coffee:
```coffee
{ResizablePanel} = require 'atom-resizable-panel'

content = createElement()

panel = new ResizablePanel
  item: content
  position: 'bottom'
```

`item` must be a DOM Node or jQuery element.  
`position` must be either `left`, `right`, `top` or `bottom`. If omitted, it defaults to `bottom`.  
Additional options (`visible`, `priority`) will be relayed to the underlying Panel.

The Panel does not resize automatically when the content changes, so you need to call `height()` or
`width()` manually. Depending on its position the property `.minWidth` or `.minHeight` will default to
50. The resize handler can not be used to make the Panel smaller than this value.
