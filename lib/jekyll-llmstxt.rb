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

        site.collections.each do |collection_name, collection|
            # Check if the collection has any documents
            unless collection.docs.empty?

              title_cased_name = collection_name.split.map(&:capitalize).join(' ')
              file.content += "## #{title_cased_name}:\n\n"

              collection.docs.each do |post|
                post_url = site.baseurl ? File.join(site.baseurl, post.url) : post.url
                file.content += "- [#{post.data["title"]}](#{post_url}index.md)\n"
              end
              file.content += "\n\n"
            end
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
  site.collections.each do |collection_name, collection|
    collection.docs.each do |post|
      target_dir = File.join(site.dest, post.url)
      target_path = File.join(target_dir, "index.md")
      FileUtils.cp(post.path, target_path)
    end
  end
end