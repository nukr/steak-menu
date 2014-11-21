React = require('react')
MealStore = require('../stores/MealStore.coffee')
actions = require('../actions/AppActionCreator.coffee')
{button, label, fieldset, legend, input, h1, form, div} = React.DOM

ControlGroupInput = React.createFactory React.createClass
    render: ->
        div className: 'control-group',
            label className: 'control-label col-lg-2',
                @props.label
            div className: 'col-lg-10',
                input
                    className: 'form-control'
                    name: @props.name
                    placeholder: @props.label

EditMeal = React.createFactory React.createClass
    getInitialState: ->
        meal: MealStore.getEditMeal()

    render: ->
        div {},
            form className: 'form-create-meal form-horizontal',
                fieldset {},
                    legend {},
                        'Create Meal'
                    ControlGroupInput
                        label: 'Name'
                        name: 'name'
                    ControlGroupInput
                        label: 'Price'
                        name: 'price'
                    ControlGroupInput
                        label: 'Category'
                        name: 'category'
                    ControlGroupInput
                        label: 'Remark'
                        name: 'remark'
                    div className: 'control-group',
                        div className: 'col-lg-offset-2 col-lg-10',
                            button
                                onClick: @submit
                                className: 'btn btn-primary',
                                    'Submit'

    submit: (e) ->
        e.preventDefault()
        formData = $('.form-create-meal').serialize()
        actions.createMeal(formData)


module.exports = EditMeal

