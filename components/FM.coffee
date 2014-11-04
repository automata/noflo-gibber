noflo = require 'noflo'
Gibber = require '../vendor/gibber.lib.min.js'

init = ->
  if not window.GibberRunning?
    console.log 'inicializei gibber'
    window.GibberRunning = true
    Gibber.init({globalize: false})

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cog'
  c.description = 'FM Synthesiser'
  init()
  c.ugen = Gibber.Synths.FM()

  # Add input ports
  c.inPorts.add 'maxvoices',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.ugen.maxVoices = payload

  c.inPorts.add 'fx',
    datatype: 'object'
    addressable: true
    process: (event, payload, i) ->
      return unless event is 'data'
      c.ugen.fx.add payload

  c.inPorts.add 'chord',
    datatype: 'array'
    process: (event, payload) ->
      return unless event is 'data'
      c.ugen.chord payload

  c.inPorts.add 'play',
    datatype: 'array'
    process: (event, payload) ->
      return unless event is 'data'
      c.ugen.play payload

  # Add output ports
  c.outPorts.add 'out',
    datatype: 'string'

  # Finally return the component instance
  c
