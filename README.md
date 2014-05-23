# AJournal

## Description
AJournal is a simple, lightweight, task based (single page) static site generator.

## How it works
AJournal works by performing a sequence of tasks. Here is an example of a simple sequence :

1. **core/compile** parses markdown files in **/post**
2. **plugin/markdown** then compiles them (which is still in markdown) into HTML content
3. **plugin/underscore_template** then render each of them with designated underscore.js template

Such sequences could be easily modified thanks to AJournal's task based nature. Moreover, you don't need to specify them step by step. All you need is to provide the **dependency**, and AJournal will do a topological sort to determine the correct build order.

##Front-Matter
Each post can have their own front-matter, here is an example of a front matter

	title:A Silent Voice
	author:Evan Sebastian
	layout:blog
	---

There should not be any space between the colon, and the number of dash should be exact of three.

##Rendering posts with templates
Once a post is made, it can be rendered (i.e combined with a template to create a finished .html file).
underscore.js is provided, but you can change it to other templating engine easily by writing a task.

Post content is stored in field `content`, make sure you don't confuse it with `data` which contains raw (markdown) file.

## Tasks Folder
* **/ajournal/core** this is where the core, mandatory tasks are stored.
* **/ajournal/plugin** this is where your plugin tasks are stored.
* **/ajournal/config.json** this is your site configuration file. See
  configuration section for more details.
* **/ajournal/template** this is where your templates are stored.

# Prerequisites
## User
- node.js
- underscore.js
- markdown

## Development
- coffee
- grunt
- grunt-contrib-coffee
- grunt-coffeelint
- grunt-contrib-uglify

##Todo
1. Write unit test.
2. Write documentation that someone actually understands.
2. Add more plugins.
3. Separate runtime with development environment.

##FAQ

Q. Why is there an uglify task on gruntfile?

A. See Todo 3. Once everything is stable and properly tested, the minified version is basically unusable.

##Setup
Grab and install

	git clone https://www.github.com/evansb/ajournal
    npm install

Then to generate the site

	grunt
    coffee ajournal/ajournal.coffee

# License
MIT

Copyright (c) 2014 Evan Sebastian

