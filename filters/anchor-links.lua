-- From Pandoc's website and then modified:
-- https://github.com/jgm/pandoc-website/blob/master/tools/anchor-links.lua
--
-- Adds anchor links to headings with IDs.
function Header (h)
  if h.identifier ~= '' then
    -- wrap with a link to this header
    local anchor_link = pandoc.Link(
      h.content,           -- content
      '#' .. h.identifier, -- href
      '',                  -- title
      {class = 'anchor', ['aria-hidden'] = 'true'} -- attributes
    )
    h.content = anchor_link
    return h
  end
  return h
end
