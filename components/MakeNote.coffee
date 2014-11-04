noflo = require 'noflo'

class MakeNote extends noflo.Component
  description: 'Make a note'
  icon: 'cog'
  constructor: ->
    @inPorts =
      note: new noflo.Port 'string'

    @inPorts.note.on 'data', (data) =>
      return unless @outPorts.note.isAttached()
      @outPorts.note.send data

    @outPorts = new noflo.OutPorts
      note:
        datatype: 'string'

    #@outPorts.note.on 'attach', () =>
    #  @outPorts.note.send @elements

exports.getComponent = -> new MakeNote
