#version 100
  precision highp float;
  
  #define PI 3.14159
  #define TAU 6.28318
  
  #define round(x) (floor(x + 0.5))
  #define crush(c, x) (floor((x) * (c)) / (c))
  
  varying vec4 vScaleTimeFadeTimeRaw;
  #define vScale (vScaleTimeFadeTimeRaw.x)
  #define vTime (vScaleTimeFadeTimeRaw.y)
  #define vFadeBG (vScaleTimeFadeTimeRaw.z)
  #define vTimeRaw (vScaleTimeFadeTimeRaw.w)
  varying vec4 vUVXY;
  #define vUV (vUVXY.xy)
  #define vXY (vUVXY.zw)
  varying vec4 vMouseMouseScreen;
  #define vMouse (vMouseMouseScreen.xy)
  #define vMouseScreen (vMouseMouseScreen.zw)
  varying vec4 vModeUNUSEDx3;
  #define vMode (vModeUNUSEDx3.x)
  
  float get(vec4 v) {
	float a = cos(crush(v.w, sin(v.x * 3.8) + sin(v.y * 3.8 + v.z * 3.24)));
	float b = sin(crush(v.w, v.x * 2.47 + v.z * 4.0) + sin(v.y * 2.47));
	float c = sin(crush(v.w, v.x - sin(v.y) + v.z));
	float d = sin(crush(v.w, a + b + c + sin(2.0 + 1.0 * cos(a + v.y + v.z) * 4.0 * v.y + a + 4.324 * v.z) + cos(crush(v.w, 4.0 * v.x + c + 1.0 + 0.3 * a - 0.1 * b)) + b));
  
	return 1.0 + 0.2 * a + 0.5 * a * c + 0.4 * c + 0.5 * b * d;
  }
  
  float get2(vec4 v) {
	float a = sin(crush(v.w, 4.9 - cos(v.y * 1.7) + cos(v.x * 1.7 + v.z * 4.24)));
	float b = sin(crush(v.w, 4.0 + v.x * 0.47 - v.z * 3.0) - sin(v.y * 0.47));
	float c = cos(crush(v.w, 2.0 - v.x - sin(v.y) - 1.5 * v.z));
	float d = sin(crush(v.w, 2.0 + a * b - c - sin(2.0 + 1.0 * cos(a + v.y - v.z) * 4.0 * v.y + a + 4.324 * v.z) - cos(crush(v.w, 4.0 * v.x + c + 1.0 + 0.3 * a - 0.1 * b)) + b));
  
	return 1.0 + 0.2 * a + 0.5 * a * c + 0.4 * c + 0.5 * b * d;
  }
  
  vec3 hueShift(vec3 color, float hue) {
	const vec3 k = vec3(0.57735, 0.57735, 0.57735);
	float cosAngle = cos(hue);
	return vec3(color * cosAngle + cross(k, color) * sin(hue) + k * dot(k, color) * (1.0 - cosAngle));
  }
  
  void main() {
	vec2 uv = vUV;
	vec2 xy = vXY;
	float t = vTime;
	float tr = vTimeRaw;
  
	vec2 m = vMouse;
	vec2 ms = vMouseScreen;
  
	uv += 0.01 * m;
  
	uv *= 1.5 + smoothstep(-1.0, 0.5, uv.x + uv.y);
  
	float fcrushr = smoothstep(0.5, 0.02, 0.5 + 0.5 * sin(t * 5.0));
  #define mixcrush(x) floor(mix(65536.0, x, fcrushr) + 0.5)
  #define autocrush(x, c) crush(mixcrush(x), c)
  
	float fcrushm = pow(1.0 - min(1.0, max(0.0, 4.0 * distance(vUV, ms))), 2.0);
	float fcrushmb = get(vec4(uv - 0.25, t * 0.4 + m.x * 0.02 - 1.15, 16.0));
	fcrushm = max(0.0, crush(3.0 + fcrushmb, fcrushm + fcrushmb * 40.6) - fcrushmb * 40.4);
  
	float fcrush = (0.2 + fcrushr * 0.8) * smoothstep(0.3, 1.0, mix(fcrushr, 1.0 - fcrushr, fcrushm));
  
  
	float voffs1 = get(vec4(uv + 0.5, t * 2.0 + m.x * 0.04 - 1.45, mixcrush(16.0)));
	voffs1 = smoothstep(1.3, 2.3, voffs1);
	float voffs2 = voffs1 + 16.0 + 4.0 * sin(uv.x * -0.2 + uv.y * -0.2 + t * -2.0);
	float voffs3 = voffs2 * (1.5 + sin(128.0 * (uv.x + sign(sin(3.0 * t + 3.0 * uv.y + voffs1)) * uv.y + t) - voffs1 * 4.0));
	uv = mix(uv, uv - fract(uv * voffs2) / voffs3, voffs1);
	uv = mix(uv, autocrush(4.0 + 6.0 * voffs3, uv + voffs2 * 0.3) - voffs2 * 0.3, smoothstep(0.0, 2.0, voffs2 * voffs3) * 0.01);
  
	float v1 = get(vec4(uv - fcrush * 0.1, t * 2.0 + m.x * 0.04, 65536.0));
  
	float vshift = get2(vec4(autocrush(16.0 + 16.0 * v1, uv + v1 * 0.1) - v1 * 0.1 * 1.1 + vec2(-0.1, -0.1) * v1, t * 2.0 + m.x * 0.04 + 0.01, mixcrush(4.0 + crush(8.0, v1) * 3.0)));
	vshift = smoothstep(0.0, 3.0, vshift * vshift * vshift * vshift + v1);
	float vcrush = 6.0 + vshift * 65530.0;
  
	float v2 = get(vec4(uv * 0.7 + vec2(0.1, 0.1) * (v1 - fcrush), t * 2.0 + m.x * 0.04 + 0.15 + v1 * 0.01, vcrush * voffs3));
	float v3 = get(vec4(uv * 0.4 + vec2(-0.1, 0.1) * (v2 + fcrush), t * 2.0 + m.x * 0.04 + 0.3 + v1 * 0.02 + v2 * 0.03, mixcrush(vcrush * 0.5)));
	float v4 = get2(vec4(uv * 0.1 + vec2(0.1, -0.1) * (v3 - fcrush), t * 2.0 + m.x * 0.04 + 0.45 + v1 * 0.01 + v2 * 0.02 + v3 * 0.03, mixcrush(10.0 + 10.0 * vshift)));
  
	vec3 cA = 0.4 + 0.4 * sin(2.0 * vec3(v1, v2, v3));
	vec3 cB = 0.3 + 0.2 * sin(2.0 * vec3(v4, v3, v2));
	vec3 cC = 0.1 + 0.1 * sin(3.0 * vec3(v2, v4, v1));
	vec3 cD = max(max(cA, cB) - cC, cC);
	vec3 cE = cD + cA * 0.3;
	vec3 cF = cE + vec3(0.0, 0.0, v4 * max(0.0, 0.7 * autocrush(17.0, 2.0 * smoothstep(0.3, 1.0, v1 * v2 * v3 * v4) + fcrushmb * 0.3) - fcrushmb * 0.3 - 1.0));
	vec3 cZ = hueShift(cF, t * 2.5 + sin(t * 2.5) * 0.5 + v4 - v3 * 0.5 + voffs1 - v1 * 0.2 + smoothstep(0.3, 0.8, vshift * 2.0) * 2.0 + fcrush * 0.05);
  
	// cZ = vec3(cF);
	// cZ = hueShift(vec3(1.0, 0.0, 0.0), t * 2.5 + sin(t * 2.5) * 0.5 + v4 - v3 * v1 * 0.5);
	// cZ = vec3(crush(crush(8.0, (vUV.y + 0.5) * 8.0), vUV.x + 0.5));
	// cZ = vec3(vcrush / 65536.0);
	// cZ = vec3(voffs3 / 8.0);
	// cZ = vec3(fcrush);
	// if (vUV.x > 0.4) { cZ = vec3(fcrush); }
  
	cZ = mix(cZ, hueShift(0.5 - cZ * 0.3, PI), vMode);
  
	gl_FragColor = vec4(cZ, 1.0);
  }
