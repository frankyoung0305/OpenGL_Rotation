

#version 300 es
in vec3 Position;

uniform mat4 projection;
uniform mat4 model;
uniform mat4 lookView;

void main()
{
    gl_Position =   projection * lookView * model * vec4(Position, 1.0);
    
}
