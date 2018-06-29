#version 300 es
precision highp float;
#define NR_POINT_LIGHTS 4

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float     shininess;
};
struct SpotLight {
    vec3 position;
    vec3 direction;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    
    float constant;
    float linear;
    float quadratic;

    float cutOff;
    float outerCutOff;
};
struct DirLight {
    vec3 direction;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};
struct PointLight {
    vec3 position;
    
    float constant;
    float linear;
    float quadratic;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};


in vec3 fragNormal;
in vec2 TexCoordOut;
in vec3 worldPos;

out vec4 FragColor;

uniform sampler2D Texture;

uniform Material material;
uniform vec3 eyePos;

uniform SpotLight spotLight;
uniform DirLight dirLight;
uniform PointLight pointLights[NR_POINT_LIGHTS];

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir);
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir);

void main(void) {
    vec3 norm = normalize(fragNormal);
    vec3 viewDir = normalize(eyePos - worldPos);

    vec3 result = CalcDirLight(dirLight, norm, viewDir);

    for(int i = 2; i < NR_POINT_LIGHTS; i++)
        result += CalcPointLight(pointLights[i], norm, worldPos, viewDir);

    result += CalcSpotLight(spotLight, norm, worldPos, viewDir);

    FragColor = vec4(result, 1.0) ;
}

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir)
{
    vec3 lightDir = normalize(-light.direction);

    float diff = max(dot(normal, lightDir), 0.0);

    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    vec3 ambient  = light.ambient  * vec3(texture(material.diffuse, TexCoordOut));
    vec3 diffuse  = light.diffuse  * diff * vec3(texture(material.diffuse, TexCoordOut));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoordOut));
    return (ambient + diffuse + specular);
}

vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
    vec3 lightDir = normalize(light.position - fragPos);

    float diff = max(dot(normal, lightDir), 0.0);

    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    float distance    = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance +
                               light.quadratic * (distance * distance));

    vec3 ambient  = light.ambient  * vec3(texture(material.diffuse, TexCoordOut));
    vec3 diffuse  = light.diffuse  * diff * vec3(texture(material.diffuse, TexCoordOut));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoordOut));
    ambient  *= attenuation;
    diffuse  *= attenuation;
    specular *= attenuation;
    return (ambient + diffuse + specular);
}

vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
    vec3 lightDir = normalize(light.position - fragPos);

    float diff = max(dot(normal, lightDir), 0.0);

    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));

    float theta = dot(lightDir, normalize(-light.direction));
    float epsilon = light.cutOff - light.outerCutOff;
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);

    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoordOut));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoordOut));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoordOut));
    ambient *= attenuation * intensity;
    diffuse *= attenuation * intensity;
    specular *= attenuation * intensity;
    return (ambient + diffuse + specular);
}
