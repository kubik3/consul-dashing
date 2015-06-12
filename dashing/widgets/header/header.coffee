class Dashing.Header extends Dashing.Widget

  ready: ->
    $(@node).find(".header-text").html(@get('text'))
    $(@node).find(".header-image img").attr("src", "/assets/#{@get('image')}")
	
  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
    $(@node).find(".header-text").html(@get('text'))
    $(@node).find(".header-image img").attr("src", "/assets/#{@get('image')}")