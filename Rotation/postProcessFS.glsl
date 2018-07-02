#version 300 es
precision highp float;

out vec4 FragColor;

in vec2 TexCoords;

uniform sampler2D screenTexture;

const float offset = 1.0 / 300.0;  //step length(pos to sample

void main()
{
    vec2 offsets[9] = vec2[](
                             vec2(-offset,  offset),// upper left
                             vec2( 0.0f,    offset),// up
                             vec2( offset,  offset),// upper right
                             vec2(-offset,  0.0f),  // left
                             vec2( 0.0f,    0.0f),  // center
                             vec2( offset,  0.0f),  // right
                             vec2(-offset, -offset),// lower left
                             vec2( 0.0f,   -offset),// down
                             vec2( offset, -offset) // lower right
                             );
//    /////////////////////blur
//    float kernel[9] = float[](
//                              1.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0,
//                              2.0 / 16.0, 4.0 / 16.0, 2.0 / 16.0,
//                              1.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0
//                              );
//    /////////////////////sharpen
//    float kernel[9] = float[](
//                              -1.0, -1.0, -1.0,
//                              -1.0,  9.0, -1.0,
//                              -1.0, -1.0, -1.0
//                              );
//    ////////////////////////Edge-detection
    float kernel[9] = float[](
                              1.0,  1.0, 1.0,
                              1.0, -8.0, 1.0,
                              1.0,  1.0, 1.0
                              );
    
    vec3 sampleTex[9];
    for(int i = 0; i < 9; i++)
    {
        sampleTex[i] = vec3(texture(screenTexture, TexCoords.st + offsets[i])); //sample at a pos around origin pos
    }
    vec3 col = vec3(0.0);
    for(int i = 0; i < 9; i++)
        col += sampleTex[i] * kernel[i];

    FragColor = vec4(col, 1.0);
}
