#version 100
  precision mediump float;
  
  uniform sampler2D uSampler;
  
  varying vec2 vUV;
  
  void main() {
	gl_FragColor = texture2D(uSampler, vUV);
  }
