#version 300 es
precision highp float;
in vec4 DestinationColor;
out vec4 FragColor;

in vec2 TexCoordOut;
uniform sampler2D Texture;

void main(void) {
    FragColor = DestinationColor * texture(Texture, TexCoordOut);
}


