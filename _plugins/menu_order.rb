# frozen_string_literal: true

module Flatfiletxtdb
  module MenuOrder
    MENU_FILE = "_menu"
    EXCLUDED_PATHS = ["404.html", "index.html"].freeze

    def self.apply(site)
      pages = site.pages.select do |page|
        page.title && !page.title.to_s.empty? && !EXCLUDED_PATHS.include?(page.path)
      end

      pages_by_dir = pages.group_by do |page|
        dir = File.dirname(page.path)
        dir == "." ? "" : dir
      end

      pages_by_dir.each do |dir, dir_pages|
        menu_path = File.join(site.source, dir, MENU_FILE)
        menu = read_menu(menu_path)

        available = dir_pages.to_h { |page| [File.basename(page.path), page] }

        if menu
          unknown = menu.reject { |name| available.key?(name) }
          unless unknown.empty?
            raise Jekyll::Errors::FatalException,
              "_menu in #{display_dir(dir)} references missing or non-menu page(s): #{unknown.join(", ")}"
          end
        else
          menu = []
        end

        menu.each_with_index do |name, index|
          if menu[0...index].include?(name)
            raise Jekyll::Errors::FatalException,
              "_menu in #{display_dir(dir)} contains duplicate entry: #{name}"
          end
        end

        menu_rank = menu.each_with_index.to_h

        dir_pages.each do |page|
          name = File.basename(page.path)
          rank = menu_rank.fetch(name, menu.length)

          page.data["menu_rank"] = rank
          page.data["menu_key"] = format(
            "%s/%010d/%s",
            dir,
            rank,
            name
          )
        end
      end
    end

    def self.read_menu(path)
      return nil unless File.file?(path)

      names = File.readlines(path, chomp: true).map(&:strip).reject(&:empty?)
      if names.any? { |name| name.start_with?("#") }
        raise Jekyll::Errors::FatalException,
          "_menu does not support comments: #{path}"
      end

      names
    end

    def self.display_dir(dir)
      dir.empty? ? "." : dir
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  Flatfiletxtdb::MenuOrder.apply(site)
end
