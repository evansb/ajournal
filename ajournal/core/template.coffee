
# Task          : Core.Template
# Dependencies  : Core.Compile
# Description   : A dummy task to indicate the end of
# markup language (e.g markdown) parsing. All tasks involving template parsing
# should be appended as its dependency by the end of plugin installation
# Author        : Evan Sebastian <evanlhoini@gmail.com>

Template =
    name: 'template'
    dependencies: ['compile', 'markdown']
    run: (site, error) ->

module.exports = Template

# vim: ts=4 sw=4 et
