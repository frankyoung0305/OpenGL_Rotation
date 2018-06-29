
#version 300 es
precision highp float;

in vec2 TexCoordOut;

uniform sampler2D grassTex;

out vec4 FragColor;

void main(void) {
    
    FragColor = texture(grassTex, TexCoordOut);
    
}
