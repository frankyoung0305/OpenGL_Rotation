#version 300 es
precision highp float;
in vec4 DestinationColor;
in vec3 fragNormal;
in vec2 TexCoordOut;
in vec3 worldPos;

out vec4 FragColor;

uniform sampler2D Texture;
uniform vec3 lightPos;
uniform vec3 eyePos;
uniform mat4 normalModel;


void main(void) {
    vec3 lightColor = vec3(1.0, 1.0, 1.0);
    
    
    float ambientStrength = 0.1;
    vec3 ambient = ambientStrength * lightColor;
    
    
    vec3 norm = normalize(fragNormal);
    vec3 lightDir = normalize(lightPos - worldPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    
    float specularStrength = 0.5;
    float shininess = 256.0;
    vec3 viewDir = normalize(eyePos - worldPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), shininess);
    vec3 specular = specularStrength * spec * lightColor;
    
    
    
    vec3 result = (ambient + diffuse + specular) ;
    FragColor = vec4(result, 1.0)  * texture(Texture, TexCoordOut);
}
