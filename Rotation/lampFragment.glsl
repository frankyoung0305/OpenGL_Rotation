
#version 300 es
precision highp float;

in vec3 fragNormal;
in vec2 TexCoordOut;
in vec3 worldPos;

out vec4 FragColor;
uniform sampler2D tex;

void main(void) {
    
//    FragColor = vec4(1.0) ;
    FragColor = texture(tex, TexCoordOut);
}
