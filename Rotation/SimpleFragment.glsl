#version 300 es
precision highp float;
in vec4 DestinationColor;
out vec4 FragColor;

void main(void) {
    FragColor = DestinationColor;
}


