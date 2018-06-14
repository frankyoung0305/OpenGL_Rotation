
#version 300 es
in vec3 Position;
in vec4 SourceColor;
in vec2 TexCoordIn;
in vec3 normal;

out vec2 TexCoordOut;
out vec4 DestinationColor;

uniform mat4 projection;
uniform mat4 modelView;
uniform mat4 lookView;

uniform vec3 lightPos;
uniform vec3 eyePos;

void main()
{
    vec3 fragNormal = mat3(transpose(inverse(modelView))) * normal;
    gl_Position =   projection * lookView * modelView * vec4(Position, 1.0);
    vec3 worldPos = vec3(modelView * vec4(Position, 1.0));
    
    
    vec3 lightColor = vec3(1.0, 1.0, 1.0);
    
    
    float ambientStrength = 0.1;
    vec3 ambient = ambientStrength * lightColor;
    
    
    vec3 norm = normalize(fragNormal);
    vec3 lightDir = normalize(lightPos - worldPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    
    float specularStrength = 0.8;
    float shininess = 256.0;
    vec3 viewDir = normalize(eyePos - worldPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), shininess);
    vec3 specular = specularStrength * spec * lightColor;
    
    
    vec3 result = (ambient + diffuse + specular) ;
    
    
    DestinationColor = vec4(result, 1.0) ;
    TexCoordOut = TexCoordIn;
}
