
module.exports = (grunt) ->
    fs = require 'fs'

    grunt.initConfig 
        pkg: grunt.file.readJSON 'package.json'
        coffee:
            options:
                join: true
                bare: true
            all:
                'Gruntfile.js': 'Gruntfile.coffee'
                '_site/ajournal.js': 'ajournal/**/*.coffee'
        coffeelint:
            options:
                force: true
            all:
                'Gruntfile.js': 'Gruntfile.coffee'
                '_site/ajournal.js': 'ajournal/**/*.coffee'
        uglify:
            dist:
                files:
                    '_site/ajournal.min.js' : ['_site/ajournal.js']

    npmTasks = [
        'grunt-contrib-coffee',
        'grunt-contrib-uglify',
        'grunt-coffeelint'
    ]

    for task in npmTasks
        grunt.loadNpmTasks task

    grunt.registerTask 'default' , ['coffeelint:all', 'coffee:all', 'uglify']