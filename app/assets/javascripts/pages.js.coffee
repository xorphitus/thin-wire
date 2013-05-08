return unless $('#page_editor').size()

# ---------------------------

Backbone.sync = ->

#------------------
# Models
#------------------
Rectangle = Backbone.Model.extend(
  defaults: ->
    x: 0
    y: 0
    height: 100
    width: 100

  initialize: ->

)

#------------------
# Collections
#------------------
ObjectList = Backbone.Collection.extend(
  model: (attrs, options) ->
    new Rectangle
)

Objects = new ObjectList

#------------------
# Views
#------------------
ObjectView = Backbone.View.extend(
  tagName: 'div'

  events: ->

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    model = @model
    @$el.addClass('obj-rectangle').css(
      left: model.get('x')
      top: model.get('y')
      height: model.get('height')
      width: model.get('width')
      border: 'solid 1px'
    ).draggable(
      containment: 'parent'
      stop: (event, ui) ->
        model.set({x: ui.position.left, y: ui.position.top})
    ).resizable(
      stop: (event, ui) ->
        model.set({width: ui.size.width, height: ui.size.height})
    ).selectable()
    return this
)

AppView = Backbone.View.extend(
  el: $('#page_editor')

  events:
    'click #new_rectangle': 'createRectangle'
    'click #save_page': 'savePage'

  initialize: ->
    @listenTo(Objects, 'add', @addOne)

  render: ->
    $('#page_objects').val()
    return this

  addOne: (object) ->
    view = new ObjectView({model: object})
    $('#edit_area').append(view.render().el)

  createRectangle: ->
    Objects.create()

  savePage: ->
    $('#page_objects').val(JSON.stringify(Objects))
)

# kick application
App = new AppView