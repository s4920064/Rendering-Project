#version 430

// This is passed on from the vertex shader
in vec2 wsTexCoord;
in vec3 wsVertexPosition;
in vec3 wsVertexNormal;


// This is no longer a built-in variable
layout (location=0) out vec4 FragColor;

vec3 LightIntensity;

// Structure for holding light parameters
struct LightInfo {
    vec4 Position; // Light position in eye coords.
    vec3 La; // Ambient light intensity
    vec3 Ld; // Diffuse light intensity
    vec3 Ls; // Specular light intensity
};

// We'll have a single light in the scene with some default values
uniform LightInfo Light = LightInfo(
            vec4(2.0, 2.0, 10.0, 1.0),   // position
            vec3(0.2, 0.2, 0.2),        // La
            vec3(1.0, 1.0, 1.0),        // Ld
            vec3(1.0, 1.0, 1.0)         // Ls
            );

// The material properties of our object
struct MaterialInfo {
    vec3 Ka; // Ambient reflectivity
    vec3 Kd; // Diffuse reflectivity
    vec3 Ks; // Specular reflectivity
    float Shininess; // Specular shininess factor
};

// The object has a material
uniform MaterialInfo Material = MaterialInfo(
            vec3(0.1, 0.1, 0.1),    // Ka
            vec3(1.0, 1.0, 1.0),    // Kd
            vec3(1.0, 1.0, 1.0),    // Ks
            10.0                    // Shininess
            );


void main() {

  // Calculate the light vector
  vec3 s = normalize( vec3(Light.Position) - wsVertexPosition.xyz );

  // Transform your input normal
  vec3 n = normalize( wsVertexNormal );

  // Calculate the vertex position
  vec3 v = normalize(vec3(-wsVertexPosition));

  // Reflect the light about the surface normal
  vec3 r = reflect( -s, n );

  // Compute the light from the ambient, diffuse and specular components
  LightIntensity = (
          Light.La * Material.Ka +
          Light.Ld * Material.Kd * max( dot(s, n), 0.0 ) +
          Light.Ls * Material.Ks * pow( max( dot(r,v), 0.0 ), Material.Shininess ));

  // Set the output color of our current pixel
  FragColor = vec4(LightIntensity,1.0);
}
