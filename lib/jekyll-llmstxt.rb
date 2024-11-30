require 'jekyll'

module Jekyll
  class LLMSGenerator < Generator
    safe true
    priority :low

    def generate(site)
      # Create llms.txt file at site root
      site.pages << Jekyll::PageWithoutAFile.new(site, site.source, "", "llms.txt").tap do |file|
        file.content = site.config["title"] ? "# #{site.config["title"]}\n\n" : ""
        file.content += site.config["description"] ? "#{site.config["description"]}\n\n" : ""
        file.content += "## Posts:\n\n"

        site.posts.docs.each do |post|
          file.content += "- [#{post.data["title"]}](#{post.url}index.md)\n"
        end

        file.data["layout"] = nil
      end

    end
  end

  class MarkdownPage < Page
    def initialize(site, base, dir, name, content)
      @site = site
      @base = base
      @dir  = dir
      @name = name

      self.process(name)
      self.content = content
      self.data = {
        "layout" => nil, # Set layout if needed, or leave nil
        "title" => "Generated Markdown File",
      }
    end
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  site.posts.docs.each do |post|
    target_dir = File.join(site.dest, post.url)
    target_path = File.join(target_dir, "index.md")
    FileUtils.cp(post.path, target_path)
  end
end