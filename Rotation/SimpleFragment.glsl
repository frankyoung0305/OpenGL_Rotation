#version 300 es
precision highp float;
in vec4 DestinationColor;
out vec4 FragColor;

in vec2 TexCoordOut;
uniform sampler2D Texture;

in vec3 fragNormal;
uniform vec3 lightDirection;
uniform mat4 normalModel;


void main(void) {
    vec3 normalizedLightDirection = normalize(-lightDirection);
    vec3 transformedNormal = normalize((normalModel * vec4(fragNormal, 1.0)).xyz);
    
    float diffuseStrength = dot(normalizedLightDirection, transformedNormal);
    diffuseStrength = clamp(diffuseStrength, 0.0, 1.0);
    vec3 diffuse = vec3(diffuseStrength);
    
    vec3 ambient = vec3(0.3);
    
    vec4 finalLightStrength = vec4(ambient + diffuse, 1.0);
    
    FragColor = finalLightStrength * DestinationColor * texture(Texture, TexCoordOut);
}
