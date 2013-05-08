unless $('#page_editor').size()
  return

# ---------------------------

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
    console.log 'hoge'
)

#------------------
# Collections
#------------------
Objects = Backbone.Collection.extend(
  model: (attrs, options) ->
    new Rectangle
)

#------------------
# Views
#------------------
ObjectView = Backbone.View.extend(
  tagName: 'div'

  template: _.template($('#item-template').html())

  events:
    "click .toggle"   : "toggleDone"
    "dblclick .view"  : "edit"
    "click a.destroy" : "clear"
    "keypress .edit"  : "updateOnEnter"
    "blur .edit"      : "close"

  initialize: ->
    this.listenTo(this.model, 'change', this.render)
    this.listenTo(this.model, 'destroy', this.remove)

  render: ->
    this.$el.html(this.template(this.model.toJSON()))
    this.$el.toggleClass('done', this.model.get('done'))
    this.input = this.$('.edit')
    return this
)

AppView = Backbone.View.extend(
  tagName: 'div'

  template: _.template($('#item-template').html())

  events:
    "click .toggle"   : "toggleDone"
    "dblclick .view"  : "edit"
    "click a.destroy" : "clear"
    "keypress .edit"  : "updateOnEnter"
    "blur .edit"      : "close"

  initialize: ->
    this.listenTo(this.model, 'change', this.render)
    this.listenTo(this.model, 'destroy', this.remove)

  render: ->
    this.$el.html(this.template(this.model.toJSON()))
    this.$el.toggleClass('done', this.model.get('done'))
    this.input = this.$('.edit')
    return this
)

# kick application
App = new AppView