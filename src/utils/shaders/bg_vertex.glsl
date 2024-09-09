#version 100
  precision highp float;
  
  attribute vec4 aVertexPosition;
  
  uniform vec2 uView;
  
  uniform vec4 uScaleTimeFadeTimeRaw;
  uniform vec4 uMouseMouseScreen;
  uniform vec4 uModeUNUSEDx3;
  
  varying vec4 vScaleTimeFadeTimeRaw;
  varying vec4 vUVXY;
  varying vec4 vMouseMouseScreen;
  varying vec4 vModeUNUSEDx3;
  
  void main() {
	vScaleTimeFadeTimeRaw = uScaleTimeFadeTimeRaw;
	vUVXY = vec4(aVertexPosition.xy * uView, aVertexPosition.xy);
	vMouseMouseScreen = uMouseMouseScreen;
	vModeUNUSEDx3 = uModeUNUSEDx3;
  
	gl_Position = aVertexPosition;
  }
