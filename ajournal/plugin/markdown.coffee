
# Task          : Plugin.Markdown
# Dependencies  : Core.Compile
# Description   : Compiles markdown file in site.post_dir to corresponding
# html output in _site/
# Author        : Evan Sebastian <evanlhoini@gmail.com>

Markdown =
    name: 'markdown'
    dependencies: ['compile']
    isMarkdownFile: (post) -> post.matter.type = 'markdown'
    run: (site, error) ->
        _ = require 'underscore'
        markdown = (require 'markdown').markdown
        if not markdown? then throw error + 'markdown.js not installed
            ,please install with npm'
        for post in _.filter site.posts, @isMarkdownFile
            post.content = markdown.toHTML post.data

module.exports = Markdown

# vim: ts=4 sw=4 et
