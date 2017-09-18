require 'middleman-core/renderers/redcarpet'

class MarkdownRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
  def header(title, level)
    renderer = StandardHeaderRenderer.new

    return renderer.render(title, level) unless header_anchors_enabled?

    if left_anchored_level(level)
      anchor_titles_below(nil)
    end

    if header_anchors_enabled.include?(title)
      anchor_titles_below(level)
    end

    if title_should_be_anchored?(level)
      renderer = AnchoredHeaderRenderer.new
    end

    renderer.render(title, level)
  end

  def anchor_titles_below(level)
    @anchor_any_level_under = level
  end

  def title_should_be_anchored?(level)
    @anchor_any_level_under && level > @anchor_any_level_under
  end

  def left_anchored_level(level)
    @anchor_any_level_under && level == @anchor_any_level_under
  end


  def header_anchors_enabled?
    !!header_anchors_enabled
  end

  def header_anchors_enabled
    scope.current_page.data.header_anchors
  end

  class StandardHeaderRenderer
    def render(title, level)
      permalink = title.gsub(/\W+/, '-').downcase
      %(<h#{level} id='#{permalink}'>#{title}</h#{level}>)
    end
  end

  class AnchoredHeaderRenderer
    def render(title, level)
      permalink = title.gsub(/\W+/, '-').downcase
      %(
        <h#{level} id=\"#{permalink}\">
          <a name="#{permalink}" class="anchor" href="##{permalink}">#{anchor_svg}</a>
          #{title}
        </h#{level}>
      )
    end

    def anchor_svg
       <<-eos
         <svg aria-hidden="true" class="octicon octicon-link" height="16" version="1.1" viewBox="0 0 16 16" width="16">
         <path d="M4 9h1v1h-1c-1.5 0-3-1.69-3-3.5s1.55-3.5 3-3.5h4c1.45 0 3 1.69 3 3.5 0 1.41-0.91 2.72-2 3.25v-1.16c0.58-0.45 1-1.27 1-2.09 0-1.28-1.02-2.5-2-2.5H4c-0.98 0-2 1.22-2 2.5s1 2.5 2 2.5z m9-3h-1v1h1c1 0 2 1.22 2 2.5s-1.02 2.5-2 2.5H9c-0.98 0-2-1.22-2-2.5 0-0.83 0.42-1.64 1-2.09v-1.16c-1.09 0.53-2 1.84-2 3.25 0 1.81 1.55 3.5 3 3.5h4c1.45 0 3-1.69 3-3.5s-1.5-3.5-3-3.5z"></path>
         </svg>
       eos
    end
  end
end
