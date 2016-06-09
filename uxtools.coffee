# Add the following line to your project in Framer Studio. 
# myModule = require "myModule"
# Reference the contents by name, like myModule.myFunction() or myModule.myVar


exports.toggle = (layer_target, mode="onClick") ->
	if mode == "onClick"
		
		#check for a radio button group
		name_test = layer_target.parent.name.indexOf "_r_"
		if name_test == 0
			for child_index, child_layer of layer_target.parent.children
				#if child_layer.name != layer_target.name
				exports.toggle(child_layer,"radio_off")
		
		fl_visible = false
		visible_index = -1
		for child_index, child_layer of layer_target.children
			child_index = parseInt child_index
			if child_layer.visible
				child_layer.visible = false
				visible_index = child_index - 1
		for child_index, child_layer of layer_target.children
			child_index = parseInt child_index
			if child_index == visible_index
				child_layer.visible = true
				fl_visible = true
		if fl_visible == false
			layer_target.children[layer_target.children.length-1].visible = true
		
	if mode == "radio_off"
		for child_index, child_layer of layer_target.children
			child_index = parseInt child_index
			name_test = child_layer.name.indexOf "off"
			if name_test == 0
				child_layer.visible = true
			else
				child_layer.visible = false

	if mode == "int"
		# only show one of the child layers in the toggle grouping_layer
		# if only one is visible now, keep that options
		# if there are more than one layer shown, the show the front most layer by default
		count_visible = 0
		for child_index, child_layer of layer_target.children
			if child_layer.visible
				count_visible++
		if count_visible > 1
			for child_index, child_layer of layer_target.children
				child_layer.visible = false
			layer_target.children[layer_target.children.length-1].visible = true
		layer_target.onClick ->
			exports.toggle(layer_target)


exports.scroll = (content_layer, mode="int") ->
	target_layer = content_layer.parent
	scroll = new ScrollComponent
	    width: target_layer.width
	    height: target_layer.height * 1
	    x: target_layer.x
	    y: target_layer.y
	    mouseWheelEnabled : true
	    scrollHorizontal : false
	    draggable: false
	
	content_layer.parent = scroll.content
	content_layer.x = 0
	content_layer.y = 0
	content_layer.draggable = false
	
	scroll.on Events.Scroll, ->
		# force no horizontal scrolling
		if @content
	    	@content.x = 0




exports.init = (sketch) ->
	# Remove framer cursor
	document.body.style.cursor = "auto"
	#Framer.Device.fullScreen = false
	
	# loop through the layers and find things named with "_x_" in the beginning of the name
	for key, grouping_layer of sketch
		if key[0] == "_" && key[2] == "_"
			# _r_ means a radio toggle action
			# _t_ means a toggle action
			if key[1] == "t"
				# intialize the toggle action on the layer
				@toggle(grouping_layer, "int")
			# _d_ means a draggable
			if key[1] == "d"
				grouping_layer.draggable.enabled = true
				grouping_layer.draggable.bounce = false
				grouping_layer.draggable.momentum = false
			#_s_ means scrollable
			if key[1] == "s"
				@scroll(grouping_layer, "int")

