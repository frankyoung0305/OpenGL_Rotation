#version 300 es
precision highp float;

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float     shininess;
};
struct Light {
    vec3 position;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    
    float constant;
    float linear;
    float quadratic;
};


in vec4 DestinationColor;
in vec3 fragNormal;
in vec2 TexCoordOut;
in vec3 worldPos;

out vec4 FragColor;

uniform sampler2D Texture;

uniform Material material;
uniform Light light;
uniform vec3 lightDirection;
uniform vec3 eyePos;


void main(void) {
    float distance    = length(light.position - worldPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance +
                               light.quadratic * (distance * distance));
    
    
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoordOut));

    
    vec3 norm = normalize(fragNormal);
    vec3 lightDir = normalize(light.position - worldPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoordOut));

    
    float specularStrength = 0.5;
    vec3 viewDir = normalize(eyePos - worldPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoordOut));
    
    
    ambient  *= attenuation;
    diffuse  *= attenuation;
    specular *= attenuation;

    
    vec3 result = (ambient + diffuse + specular) ;
    FragColor = vec4(result, 1.0) ;
}
