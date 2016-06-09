# framer js tools
These are utilities I've created to make creating prototypes in FramerJS and Sketch.app more streamlined.

To use 'uxtools.coffee', place it in the 'modules' folder of your FrameJS project

in the main app.coffee file (the file you see in the FramerJS IDE) place the following code:

```coffeescript
# Import file "Example"
sketch = Framer.Importer.load("imported/Example@1x")

uxtools = require "uxtools"
# sketch is the object that the sketch.app file was imported into
uxtools.init sketch
```

the script will look through your sketch file are create toggles (toggle buttons, checkboxes, ect.), toggle groups (radio buttons, tabs, ect.), draggable items and scrolling sections based on some naming and structure conventions.
