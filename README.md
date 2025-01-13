# Tan's Tools | Finance

This finance app is for personal use so it's not built for scale (not very useful in company/business setting). I also want to build it with a variety of packages/libraries to speed production. Built in 1 week for the Minimum Viable Product, and then casually maintain it (tbh the primary reason is github stats).

## Concepts
I want to make it a general tool for everyone, so it's built to be as simple and flexible as possible. Like VSCode, Obsidian, and other apps that support plugins/extensions. 

## Components

### Database

The data stored will be simple: ID, Name, Value, Parent.
In finance we need dates and other things, but I believe this data structure is enough as a building block. 
For example: 001, Income, 1000, Parent: null. Then when you want to add a date data, then you can add: 002, Date, 2020-01-01, Parent: 001. 

#### Data Structure

```
{
    "id": "001",
    "name": "Income",
    "value": 1000,
    "parent": null
}
```

#### Data Structure (with date)

```
{
    "id": "002",
    "name": "Date",
    "value": "2020-01-01",
    "parent": "001"
}
```

### Scripting 
I will use C language for the scripting, this will be used for plugins. For this I will need APIs for database manipulation. That is to implement a REST API. It will also have a manifest file to describe the plugin. "manifest.json" will have the following structure:

```
{
    "name": "My Plugin",
    "version": "1.0.0",
    "description": "My first plugin",
    "author": "Tan",
    "license": "MIT",
    "behavior": {
        "execution" : [
            {
                "type": "fireOnEvent", 
                "event": "OnDataView", 
                "target_id": "001",
                "arguments" : [
                            {
                                "name": "", // name of the data
                                "type": "", // type of the data
                            }
                        ]
            }
        ], // fireOnEvent, fireOnInterval, fireOnStartup
        "tools": [ // this will be the floating button 

        ]
    }
}
```

for the execution, the event types will be: OnDataAppend, OnDataView, OnDataDelete, OnPageView, OnPageClose, OnInput, OnComponentPressed, OnComponentLongPressed. On default, the execution will receive a dictionary of data, the data will be the event triggering the plugin. To expose the target components, I will create a class that has a static map of the components, they will be loaded and unloaded on demand. 

There could be a lot more to do with the scripting but I should limit the features for now as this is already a huge feature. So I will implement it last. And I also really need to implement another feature where plugins could manipulate a component, like adding table rows or columns, etc. 



### Default Plugins
Since this will support a plugin system, why not use it to the fullest? For example, when adding an Income data, I will have a default plugin that will add a date data.
Default plugins: Timestamp Appending,
(That's all for now, I will add more as I go along)

### Themes
No much explanation, just that if there are plugins, there is a necessity to have a theme.
Due to this, I will need to need a design philosophy for the app. 

### Pages
Loading Page, Sidebar Menu, Main Page, Add Form, Edit Form, Delete Prompt, etc. 
Loading Page will be a standard page that shows a logo then go to main page. 

The main page is a data table that shows the main items (items with null value on parent). 
It will also have an icon on the top right corner to change the types of data visualization. 
Table, Graph, Plot. 

The add form will be a form that allows you to add a new data. 
The edit form will be a form that allows you to edit an existing data. 
The delete prompt will be a prompt that asks you to confirm the deletion of the data.

The Sidebar Menu will have an item that lets you manage the plugins. 
It will also have an item that lets you manage the themes.





## Packages/Libraries that will be used: 
shadcn_ui - For the UI, uniform design, and can set the theme. 
getx - For flutter management. This takes care of the state, route, and dependency management. 
dart:ffi (C interop) - For the scripting.
sqlite3 - For the database, it uses ffi to provide dirrect access to SQLite. 
