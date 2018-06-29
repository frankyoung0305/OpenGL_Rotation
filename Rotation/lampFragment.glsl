
#version 300 es
precision highp float;

in vec2 TexCoordOut;

uniform sampler2D grassTex;

out vec4 FragColor;

void main(void) {

    vec4 texColor = texture(grassTex, TexCoordOut);
    if(texColor.a < 0.1)
        discard;
    
    FragColor = texColor;
    
}
