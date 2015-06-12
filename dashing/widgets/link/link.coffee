class Dashing.Link extends Dashing.Widget
  colors = ["#5294CF", "#F58536", "#759C3E", "#3F9E6F", "#299BB3", "#E05243", "#826CAF", "#AD688B", "#ACACAC", "#464600"]

  @accessor 'image', ->
    "/assets/"+@get('text')+".png"

  ready: ->
    x = Math.floor((Math.random() * 10))
    $(@node).css("background-color", colors[x])

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
    $(@node).fadeOut().fadeIn()