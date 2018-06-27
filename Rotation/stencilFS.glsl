
#version 300 es
precision highp float;

in vec3 fragNormal;
in vec2 TexCoordOut;
in vec3 worldPos;

out vec4 FragColor;

void main(void) {
    
    FragColor = vec4(0.04, 0.28, 0.26, 1.0);
}

