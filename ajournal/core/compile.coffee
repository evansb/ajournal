
# Task          : Core.Compile
# Dependencies  : Nothing
# Description   : Parse files from ../#{site.post_dir}/*. to a list of posts.
# A post is defined as a pair of front matter and its content
# Author        : Evan Sebastian <evanlhoini@gmail.com>

Compile =
    name: "compile"
    dependencies : []

    datify: (date) -> date.getDate() + '-' + (1 + date.getMonth()) \
            + '-' + date.getFullYear() + '-'

    verify: (matter, error) ->
        matter.title? or error.throw "Please provide title on matter"
        if matter.date is 'now' then matter.date = @datify new Date
        matter.author = matter.author or "Anonymous"
        return matter

    parse_matter: (matter_string, error) ->
        matter_object = {}
        lines = matter_string.split '\n'
        for line in lines
            words = line.split ':'
            if words.length isnt 2
                error.throw "Format: <variable>:<content> +
                Parse error in front matter"
            else
                matter_object[words[0]] = words[1]
         return @verify matter_object, error

    run: (site, error) ->
        _ = require 'underscore'
        posts = []
        fs = require 'fs'
        for dir in site.post_dir
            dir = './' + dir
            f = fs.readdirSync dir
            for file in f
                path = dir + '/' + file
                error.log "Parsing #{path}"
                matter = '' ; post_data  = ''
                data = fs.readFileSync path, site.encoding
                splitted = data.split '\n---\n'
                matter = splitted[0]
                post_data = splitted[1..].join ''
                matter = @parse_matter matter, error
                posts.push { matter: matter, data: post_data }
        site.posts = posts

module.exports = Compile

# vim: ts=4 sw=4 et
