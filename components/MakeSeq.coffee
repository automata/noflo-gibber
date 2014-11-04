noflo = require 'noflo'

class MakeSeq extends noflo.Component
  description: 'Make a sequence of notes, frequencies or parameter values'
  icon: 'cog'
  constructor: ->
    @elements = []

    @inPorts =
      elements: new noflo.ArrayPort 'all'

    @inPorts.elements.on 'data', (element, i) =>
      @elements[i] = element
      return unless @outPorts.seq.isAttached()
      @outPorts.seq.send @elements

    @outPorts = new noflo.OutPorts
      seq:
        datatype: 'array'
        required: false

    @outPorts.seq.on 'attach', () =>
      @outPorts.seq.send @elements

exports.getComponent = -> new MakeSeq
