# AJournal

## Description
AJournal is a simple, lightweight, task based (single page) static site generator.

## How it works
AJournal works by performing a sequence of tasks. For instance, here is the
default workflow provided: 

1. **core/compile** parses posts in **post/**, separating front-matter and
content 
2. **plugin/markdown** then compiles markdown-typed post content to html
3. **plugin/underscore_template** then render each of them with designated underscore.js template

##How to Use

1. Open **config.json** to modify global site-related configuration. Here is an example (without the comments, obviously)

		{
    		"title" : "test site", // Title of your site
    		"author" : "Evan Sebastian", // Your name, appear on post.matter.author
    		"output" : "_site",  // Where the base directory of .html should be kept
    		"post_dir" : ["post"], // Where the posts are located
    		"task_dir" : [ "core", "plugin"] // Plugin folders (e.g ./.ajournal/core)
		}
2. Every posts should be stored in one folder as defined in **config.json**.
Each post consist of front-matter and content. At least , you will need


		title:A Silent Voice
		author:Evan Sebastian
		layout:blog
    	type:markdown
		---
    	This is the content, which will be stored in field 'content' during
    	template rendering
    	There should not be any space between the colon, and the number of dashes in the
    	end should be exactly three.

3. Likewise, template should be stored in one folder as defined in
**config.json**
4. Underscore template is provided, you can add more by writing a plugin.
5. HTML files generated is on format _site/{folder}/{date}-{title}.html

## Folder Organization

* **/.ajournal/core** this is where the core, mandatory tasks are stored.
* **/.ajournal/plugin** this is where your plugin tasks are stored.

# Prerequisites
## User
- node.js
- underscore.js
- markdown

## Development
- grunt
- grunt-contrib-coffee
- grunt-coffeelint

##Todo
1. Write unit test.
2. Improve current task management, especially handling
dependency errors.

##Setup

1. First clone the repo

        git clone http://www.github.com/evansb/ajournal.git

2. Install prerequisites

        npm install

2. To build the site

        node .ajournal/start.js

3. If you are not going to write any plugin, just remove grunt,
grunt-contrib-coffee, and grunt-coffelint

# License
MIT

Copyright (c) 2014 Evan Sebastian

