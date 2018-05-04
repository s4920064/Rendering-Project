#version 430

// The modelview and projection matrices are no longer given in OpenGL 4.2
uniform mat4 MV;
uniform mat4 MVP;
uniform mat3 N; // This is the inverse transpose of the MV matrix

// The vertex position attribute
layout (location=0) in vec3 VertexPosition;

// The texture coordinate attribute
layout (location=1) in vec2 TexCoord;

// The vertex normal attribute
layout (location=2) in vec3 VertexNormal;

// Passed onto the fragment shader
//out vec3 LightIntensity;

out vec2 wsTexCoord;

out vec3 wsVertexPosition;

out vec3 wsVertexNormal;

//out vec3


/************************************************************************************/
void main() {

    // Set the position of the current vertex
    gl_Position = MVP * vec4(VertexPosition, 1.0);

    // Transform your input normal
    wsVertexNormal = normalize( N * VertexNormal );

    // Calculate the vertex position
    wsVertexPosition = vec3(MV * vec4(VertexPosition, 1));

    wsTexCoord = TexCoord;

}

