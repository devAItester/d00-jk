#!/usr/bin/env bash
set -euo pipefail

ruby -I. <<'RUBY'
require "fileutils"
require "tmpdir"
require "jekyll"

load "_plugins/menu_order.rb"

def page_names(source)
  config = Jekyll.configuration(
    "source" => source,
    "destination" => File.join(source, "_site"),
    "quiet" => true
  )
  site = Jekyll::Site.new(config)
  site.read

  site.pages
    .select { |page| page.data["menu_key"] }
    .sort_by { |page| page.data["menu_key"] }
    .map { |page| File.basename(page.path) }
end

def write_page(dir, name, title)
  File.write(
    File.join(dir, name),
    "---\nlayout: default\ntitle: #{title}\n---\n"
  )
end

Dir.mktmpdir("flatfiletxtdb-menu-test") do |root|
  with_menu = File.join(root, "with-menu")
  FileUtils.mkdir_p(with_menu)
  write_page(with_menu, "alpha.md", "alpha")
  write_page(with_menu, "beta.md", "beta")
  write_page(with_menu, "zeta.md", "zeta")
  File.write(File.join(with_menu, "_menu"), "beta.md\n")

  actual = page_names(with_menu)
  expected = %w[beta.md alpha.md zeta.md]
  abort "Partial _menu order failed: #{actual.inspect}" unless actual == expected

  without_menu = File.join(root, "without-menu")
  FileUtils.mkdir_p(without_menu)
  write_page(without_menu, "zeta.md", "zeta")
  write_page(without_menu, "alpha.md", "alpha")
  write_page(without_menu, "beta.md", "beta")

  actual = page_names(without_menu)
  expected = %w[alpha.md beta.md zeta.md]
  abort "Alphabetical fallback failed: #{actual.inspect}" unless actual == expected

  unknown = File.join(root, "unknown")
  FileUtils.mkdir_p(unknown)
  write_page(unknown, "alpha.md", "alpha")
  File.write(File.join(unknown, "_menu"), "missing.md\n")

  begin
    page_names(unknown)
    abort "Unknown _menu entry did not fail"
  rescue Jekyll::Errors::FatalException
  end

  duplicate = File.join(root, "duplicate")
  FileUtils.mkdir_p(duplicate)
  write_page(duplicate, "alpha.md", "alpha")
  File.write(File.join(duplicate, "_menu"), "alpha.md\nalpha.md\n")

  begin
    page_names(duplicate)
    abort "Duplicate _menu entry did not fail"
  rescue Jekyll::Errors::FatalException
  end
end

puts "Menu order tests OK."
RUBY
