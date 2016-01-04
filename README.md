Helper / Example extension for automatic html+markdown api docs for flowee 

![Build Status](https://travis-ci.org/coderofsalvation/flowee-doc.svg?branch=master)

## Usage

Assuming you already have your [flowee](https://npmjs.org/flowee) api running/installed:

    npm install flowee-doc

## Usage

    require('flowee-doc')(flowee)                        <------ add this
    app = flowee.init( {model: model, store:true } )

then surf to `/doc` or `/doc/md` for html/markdown output:

<img alt="" src=".doc/apiexplorer.png"/>
