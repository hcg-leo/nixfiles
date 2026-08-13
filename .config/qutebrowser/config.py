config.load_autoconfig(False) 


c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "g": "https://www.google.com/search?q={}",
    "ddg": "https://duckduckgo.com/?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "gh": "https://github.com/search?q={}",
    "w": "https://en.wikipedia.org/w/index.php?search={}",
}


_newtab = "/home/tsukasa/.config/qutebrowser/newtab.html"
c.url.start_pages = [_newtab]
c.url.default_page = _newtab

# Colorscheme

background = "#272c48"
foreground = "#c9cad1"

regular0 = "#272c48"
regular1 = "#939BC6"
regular2 = "#9AA3CC"
regular3 = "#ABB5D0"
regular4 = "#B0BDE0"
regular5 = "#B7C4D8"
regular6 = "#B5C2E1"
regular7 = "#c9cad1"

bright0 = "#707389"
bright1 = "#939BC6"
bright2 = "#9AA3CC"
bright3 = "#ABB5D0"
bright4 = "#B0BDE0"
bright5 = "#B7C4D8"
bright6 = "#B5C2E1"
bright7 = "#c9cad1"

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True

c.colors.completion.fg = foreground
c.colors.completion.odd.bg = background
c.colors.completion.even.bg = regular0
c.colors.completion.category.fg = bright4
c.colors.completion.category.bg = regular0
c.colors.completion.category.border.top = background
c.colors.completion.category.border.bottom = background
c.colors.completion.item.selected.fg = background
c.colors.completion.item.selected.bg = regular4
c.colors.completion.item.selected.border.top = regular4
c.colors.completion.item.selected.border.bottom = regular4
c.colors.completion.item.selected.match.fg = bright1
c.colors.completion.match.fg = bright1
c.colors.completion.scrollbar.fg = foreground
c.colors.completion.scrollbar.bg = background

c.colors.statusbar.normal.fg = foreground
c.colors.statusbar.normal.bg = background
c.colors.statusbar.insert.fg = background
c.colors.statusbar.insert.bg = regular4
c.colors.statusbar.command.fg = foreground
c.colors.statusbar.command.bg = background
c.colors.statusbar.caret.fg = background
c.colors.statusbar.caret.bg = regular2
c.colors.statusbar.caret.selection.fg = background
c.colors.statusbar.caret.selection.bg = regular5
c.colors.statusbar.progress.bg = regular4
c.colors.statusbar.url.fg = foreground
c.colors.statusbar.url.success.http.fg = regular3
c.colors.statusbar.url.success.https.fg = bright6
c.colors.statusbar.url.error.fg = "#e06c75"       # keep errors legibly red
c.colors.statusbar.url.warn.fg = "#e5c07b"        # and warnings amber, both still fit the palette
c.colors.statusbar.url.hover.fg = bright1

c.colors.tabs.bar.bg = background
c.colors.tabs.even.bg = regular0
c.colors.tabs.odd.bg = regular0
c.colors.tabs.even.fg = foreground
c.colors.tabs.odd.fg = foreground
c.colors.tabs.selected.even.bg = regular4
c.colors.tabs.selected.odd.bg = regular4
c.colors.tabs.selected.even.fg = background
c.colors.tabs.selected.odd.fg = background
c.colors.tabs.indicator.start = bright1
c.colors.tabs.indicator.stop = bright6
c.colors.tabs.indicator.error = "#e06c75"

c.colors.hints.fg = background
c.colors.hints.bg = bright4
c.colors.hints.match.fg = bright1

c.colors.messages.info.fg = foreground
c.colors.messages.info.bg = background
c.colors.messages.warning.fg = background
c.colors.messages.warning.bg = "#e5c07b"
c.colors.messages.error.fg = foreground
c.colors.messages.error.bg = "#e06c75"

c.colors.prompts.fg = foreground
c.colors.prompts.bg = background
c.colors.prompts.border = f"1px solid {background}"
c.colors.prompts.selected.bg = regular4
c.colors.prompts.selected.fg = background

c.colors.downloads.bar.bg = background
c.colors.downloads.start.fg = foreground
c.colors.downloads.start.bg = regular0
c.colors.downloads.stop.fg = foreground
c.colors.downloads.stop.bg = regular4
c.colors.downloads.error.fg = foreground
c.colors.downloads.error.bg = "#e06c75"

c.tabs.position = "top"
c.tabs.show = "always"
c.scrolling.smooth = True
c.content.blocking.method = "both"  



config.set("content.headers.user_agent",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36",
    "https://mail.google.com/*")
