
module.exports = (grunt) ->
    fs = require 'fs'
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        coffee:
            compile:
                options:
                    expand: true
                    bare: true
                files:
                    'Gruntfile.js': 'Gruntfile.coffee'

                    './.ajournal/core/compile.js' : './ajournal/core/compile.coffee'
                    './.ajournal/core/template.js' : './ajournal/core/template.coffee'
                    './.ajournal/core/plugin.js' : './ajournal/core/plugin.coffee'

                    './.ajournal/plugin/underscore_template.js' : './ajournal/plugin/underscore_template.coffee'
                    './.ajournal/plugin/markdown.js' : './ajournal/plugin/markdown.coffee'

                    './.ajournal/ajournal.js': './ajournal/ajournal.coffee'
                    './.ajournal/start.js' : './ajournal/start.coffee'
        coffeelint:
            options:
                indentation:
                    value: 4
                max_line_length:
                    level: 'warn'
                    value: 160
            all: [ 'Gruntfile.coffee', './ajournal/**/*.coffee']

    npmTasks = [
        'grunt-contrib-coffee',
        'grunt-coffeelint'
    ]

    for task in npmTasks
        grunt.loadNpmTasks task

    grunt.registerTask 'default' , ['coffeelint:all', 'coffee:compile']

# vim: ts=4 sw=4 et
