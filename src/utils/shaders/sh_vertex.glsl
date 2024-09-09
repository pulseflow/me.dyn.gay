#version 100
  precision mediump float;
  
  attribute vec4 aVertexPosition;
  
  uniform vec2 uView;
  
  varying vec2 vUV;
  
  void main() {
	vUV = (aVertexPosition.xy * 0.5 + 0.5) * uView;
	gl_Position = aVertexPosition;
  }
