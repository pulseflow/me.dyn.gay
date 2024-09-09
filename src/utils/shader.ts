import { Mesh, PerspectiveCamera, PlaneGeometry, Scene, ShaderMaterial, Vector2, WebGLRenderer } from 'three';
import bgFragShader from './shaders/bg_frag.glsl';
import bgVertexShader from './shaders/bg_vertex.glsl';

export class AnimatedBackground {
	public canvas: HTMLCanvasElement | null = null;
	public renderer: WebGLRenderer | null = null;
	public scene: Scene;
	public camera: PerspectiveCamera;
	public material: ShaderMaterial;
	public mesh: Mesh;
	private renderId: number = 0;

	constructor() {
		this.scene = new Scene();
		this.camera = new PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
		this.camera.position.z = 1;
		this.material = new ShaderMaterial({
			vertexShader: bgVertexShader,
			fragmentShader: bgFragShader,
			uniforms: {
				uTime: { value: 0.0 },
				uMouse: { value: new Vector2(0.5, 0.5) },
				uResolution: { value: new Vector2(window.innerWidth, window.innerHeight) },
			},
		});

		const geo = new PlaneGeometry(2, 2);
		this.mesh = new Mesh(geo, this.material);
		this.scene.add(this.mesh);
		this.render = this.render.bind(this);
	}

	init(canvas: HTMLCanvasElement) {
		this.canvas = canvas;
		this.renderer = new WebGLRenderer({ canvas });
		this.renderer.setSize(window.innerWidth, window.innerHeight);
		this.renderer.setPixelRatio(window.devicePixelRatio);
		window.addEventListener('mousemove', this.onMouseMove.bind(this), false);
		this.animate();
	}

	private onMouseMove(event: MouseEvent) {
		const mouseX = (event.clientX / window.innerWidth) * 2 - 1;
		const mouseY = (event.clientY / window.innerHeight) * 2 + 1;
		this.material.uniforms.uMouse.value.set(mouseX, mouseY);
	}

	private animate() {
		this.renderId = requestAnimationFrame(this.animate.bind(this));
		this.render();
	}

	private stop() {
		cancelAnimationFrame(this.renderId);
	}

	private render() {
		const time = performance.now() * 0.001;
		this.material.uniforms.uTime.value = time;

		if (this.renderer)
			this.renderer.render(this.scene, this.camera);
	}
}
