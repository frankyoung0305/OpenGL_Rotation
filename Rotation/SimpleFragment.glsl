#version 300 es
precision highp float;
in vec4 DestinationColor;
in vec2 TexCoordOut;

out vec4 FragColor;

uniform sampler2D Texture;


void main(void) {
    
    FragColor = DestinationColor  * texture(Texture, TexCoordOut);
}
