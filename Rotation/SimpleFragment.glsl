#version 300 es
precision highp float;

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};
struct Light {    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

in vec4 DestinationColor;
in vec3 fragNormal;
in vec2 TexCoordOut;
in vec3 worldPos;

out vec4 FragColor;

uniform sampler2D Texture;

uniform Material material;
uniform Light light;
uniform vec3 lightPos;
uniform vec3 eyePos;


void main(void) {
    
    vec3 ambient  = light.ambient * material.ambient;

    
    vec3 norm = normalize(fragNormal);
    vec3 lightDir = normalize(lightPos - worldPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse  = light.diffuse * (diff * material.diffuse);

    
    float specularStrength = 0.5;
    vec3 viewDir = normalize(eyePos - worldPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = vec3(1.0) * (spec * material.specular);

    
    vec3 result = (ambient + diffuse + specular) ;
    FragColor = vec4(result, 1.0)  * texture(Texture, TexCoordOut);
}
