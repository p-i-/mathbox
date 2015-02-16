Transform = require './transform'

class Transform4 extends Transform
  @traits = ['node', 'transform', 'transform4']

  make: () ->
    @uniforms =
      transformMatrix: @_attributes.make @_types.mat4()
      transformOffset: @node.attributes['transform4.position']

    @transformMatrix = @uniforms.transformMatrix.value

  unmake: () ->
    delete @uniforms

  change: (changed, touched, init) ->
    return @rebuild() if changed['transform4.pass']
    return unless touched['transform4'] or init

    @pass = @_get 'transform4.pass'

    s = @_get 'transform4.scale'
    m = @_get 'transform4.matrix'

    t = @transformMatrix
    t.copy  m
    t.scale s

  transform: (shader, pass) ->
    shader.pipe 'transform4.position', @uniforms if pass == @pass
    super shader, pass

module.exports = Transform4