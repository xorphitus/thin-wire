return unless $('#page_editor').size()

# ---------------------------

# FIXME
Backbone.sync = ->

#------------------
# Models
#------------------

defaultProperties = ->
  x: 0
  y: 0
  height: 100
  width: 100

Rectangle = Backbone.Model.extend(
  defaults: ->
    properties = defaultProperties()
    properties['type'] = 'rectangle'
    properties
)

Text = Backbone.Model.extend(
  defaults: ->
    properties = defaultProperties()
    properties['type'] = 'text'
    properties['content'] = 'text'
    properties
)

#------------------
# Collections
#------------------
ObjectList = Backbone.Collection.extend(
  model: (attrs, options) ->
    switch options.type
      when 'rectangle' then new Rectangle(attrs, options)
      when 'text' then new Text(attrs, options)
      else console.error("'#{options.type} is invalid type.")
)

Objects = new ObjectList

#------------------
# Views
#------------------
ObjectView = Backbone.View.extend(
  tagName: 'div'

  events: ->

  initialize: ->
    @listenTo(@model, 'change', @rerender)

  render: ->
    model = @model
    @$el.draggable(
      containment: 'parent'
      stop: (event, ui) ->
        model.set({x: ui.position.left, y: ui.position.top})
    ).resizable(
      stop: (event, ui) ->
        model.set({width: ui.size.width, height: ui.size.height})
    ).selectable()
    @rerender()

  rerender: ->
    @$el.addClass('obj-rectangle').css(
      left: @model.get('x')
      top: @model.get('y')
      height: @model.get('height')
      width: @model.get('width')
    )
    this
)

RectangleView = ObjectView.extend(
  render: ->
    ObjectView.prototype.render.apply(this, arguments)
    @$el.css(border: 'solid 1px')
    this
)

TextView = ObjectView.extend(
  render: ->
    ObjectView.prototype.render.apply(this, arguments)
    model = @model
    @$el.css(border: 'dotted 1px').on 'dblclick', ->
      $self = $(this).hide()
      textarea = $('<textarea>').val(model.get('content')).on 'blur', ->
        $textarea = $(this)
        model.set('content', $textarea.val())
        $textarea.remove()
        $self.show()
      $self.after(textarea)
    this

  rerender: ->
    ObjectView.prototype.rerender.apply(this, arguments)
    @$el.text(@model.get('content'))
    this
)

AppView = Backbone.View.extend(
  el: $('#page_editor')

  events:
    'click #new_rectangle': 'createRectangle'
    'click #new_text': 'createText'
    'click #save_page': 'savePage'

  initialize: ->
    @listenTo(Objects, 'add', @addOne)
    @render()

  render: ->
    self = this
    #JSON.parse($('#page_objects').val()).forEach (obj) ->
    #  self.addOne(new Rectangle(obj))
    return this

  addOne: (object) ->
    switch object.get('type')
      when 'rectangle' then view = new RectangleView({model: object})
      when 'text' then view = new TextView({model: object})
      else console.error("'#{object.type} is invalid type.")
    $('#edit_area').append(view.render().el)

  createRectangle: ->
    Objects.create({}, {type: 'rectangle'})

  createText: ->
    Objects.create({}, {type: 'text'})

  savePage: ->
    $('#page_objects').val(JSON.stringify(Objects))
)

# kick application
App = new AppView