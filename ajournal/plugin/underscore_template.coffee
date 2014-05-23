
# Task          : Plugin.Underscore_template
# Dependencies  : Core.Template
# Description   : Merge underscore template files with posts
# into HTML file
# Author        : Evan Sebastian <evanlhoini@gmail.com>

Underscore_template =
    name: 'underscore_template'
    dependencies: ['template']
    run: (site, error) ->
        fs = require 'fs'
        _ = require 'underscore'
        files = fs.readdirSync site.template
        outputdir = '../' + site.output + '/'
        dir = './' + site.template + '/'
        for f in files
            file = dir + f
            tplte = fs.readFileSync file, site.encoding
            f = (f.split '.')[0]
            posts = _.filter site.posts, (p) -> p.matter.layout is f

            _.each posts, (p) ->
                folder = p.matter.folder or '.'
                title = p.matter.title
                date = p.matter.date or ''
                output_to = outputdir + folder + '/' \
                    + date + title + '.html'
                output = _.template tplte, p
                fs.openSync output_to, 'w'
                fs.writeFile output_to, output

module.exports = Underscore_template

# vim: ts=4 sw=4 et
