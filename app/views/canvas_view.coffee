class App.CanvasView extends Mozart.View
  skipTemplate: true
  tag: 'div'

  init: ->
    super
    @rendering = false

    WIDTH = 940
    HEIGHT = 500

    VIEW_ANGLE = 45
    ASPECT = WIDTH / HEIGHT
    NEAR = 0.1
    FAR = 10000

    @renderer = new THREE.WebGLRenderer()
    @camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
    @scene = new THREE.Scene()

    @scene.add @camera
    @camera.position.z = 300

    @renderer.setSize WIDTH, HEIGHT

    # create a point light
    @pointLight = new THREE.PointLight(0xFFFFFF)

    @bind 'change:lightX', => @pointLight.position.x = parseInt(@lightX) if @pointLight?
    @bind 'change:sphereX', => @sphere.position.x = parseInt(@sphereX) if @sphere?
    @bind 'change:radius', @redoSphere
    @bind 'change:colour', @redoSphere

    # set its position
    @set('lightX',0) 
    @set('sphereX',0) 
    @set('radius',50) 
    @set('colour', 0xCC0000)

    @pointLight.position.y = 50
    @pointLight.position.z = 130

    # add to the scene
    @scene.add @pointLight

  redoSphere: =>
    @scene.remove @sphere if @sphere?
    @sphereMaterial = new THREE.MeshLambertMaterial(color: parseInt(@colour))
    @sphere = new THREE.Mesh(new THREE.SphereGeometry(@radius, 16, 16), @sphereMaterial)
    @sphere.position.x = parseInt(@sphereX)
    @scene.add @sphere

  afterRender: =>
    return unless @element
    # attach the render-supplied DOM element
    @element.append @renderer.domElement

    @reqFrame()

  reqFrame: =>
    window.mozRequestAnimationFrame?(@do3DDraw) || 
    window.requestAnimationFrame?(@do3DDraw) ||
    window.webkitRequestAnimationFrame?(@do3DDraw)
    @rendering = true

  do3DDraw: =>
    @renderer.render(@scene, @camera)

    @reqFrame() if @rendering

  release: =>
    window.cancelAnimationFrame?(@do3DDraw) || window.mozCancelAnimationFrame?(@do3DDraw)
    super