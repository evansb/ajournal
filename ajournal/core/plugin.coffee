
# Task          : Core.Plugin
# Dependencies  : Core.Template
# Description   : A dummy task to indicate the end of
# plugin tasks. All final tasks after template parsing
# should be appended as its dependency by the end of installation
# Author        : Evan Sebastian <evanlhoini@gmail.com>

Plugin =
    name: 'plugin'
    dependencies: ['template', 'underscore_template']
    run: (site, error) ->
        console.log "Starting misc. plugin"
module.exports = Plugin

# vim: ts=4 sw=4 et
