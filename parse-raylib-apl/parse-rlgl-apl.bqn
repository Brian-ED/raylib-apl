#!/usr/bin/env bqn
⟨ToFFI⋄ParseHeader⟩ ← •Import "parseAPL.bqn"
map ← [
  "RL_ZERO"‿"RLGL_VERSION"
  "RLZERO" ‿"RLGLVersionString"
]

broken_rlVertexBuffer ← 1↓"
typedef struct rlVertexBuffer {
    int elementCount;           // Number of elements in the buffer (QUADS)

    float *vertices;            // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float *texcoords;           // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    float *normals;             // Vertex normal (XYZ - 3 components per vertex) (shader-location = 2)
    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
#if defined(GRAPHICS_API_OPENGL_11) || defined(GRAPHICS_API_OPENGL_33)
    unsigned int *indices;      // Vertex indices (in case vertex data comes indexed) (6 indices per quad)
#endif
#if defined(GRAPHICS_API_OPENGL_ES2)
    unsigned short *indices;    // Vertex indices (in case vertex data comes indexed) (6 indices per quad)
#endif
    unsigned int vaoId;         // OpenGL Vertex Array Object id
    unsigned int vboId[5];      // OpenGL Vertex Buffer Objects id (5 types of vertex data)
} rlVertexBuffer;"

fix1_rlVertexBuffer ← 1↓"
typedef struct rlVertexBuffer {
    int elementCount;           // Number of elements in the buffer (QUADS)

    float *vertices;            // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float *texcoords;           // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    unsigned int *indices;      // Vertex indices (in case vertex data comes indexed) (6 indices per quad)
    unsigned int vaoId;         // OpenGL Vertex Array Object id
    unsigned int vboId[4];      // OpenGL Vertex Buffer Objects id (4 types of vertex data)
} rlVertexBuffer;"

fix2_rlVertexBuffer ← 1↓"
typedef struct rlVertexBuffer {
    int elementCount;           // Number of elements in the buffer (QUADS)

    float *vertices;            // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float *texcoords;           // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    unsigned short *indices;    // Vertex indices (in case vertex data comes indexed) (6 indices per quad)
    unsigned int vaoId;         // OpenGL Vertex Array Object id
    unsigned int vboId[4];      // OpenGL Vertex Buffer Objects id (4 types of vertex data)
} rlVertexBuffer;"

Fix_rlVertexBuffer ← {
  if ← ⊑/broken_rlVertexBuffer⍷𝕩
  il ← if+≠broken_rlVertexBuffer
  (if⊸↑∾fix1_rlVertexBuffer∾il⊸↓)𝕩
}

broken_StatePointer←1↓"
#if defined(GRAPHICS_API_OPENGL_11)
RLAPI void rlEnableStatePointer(int vertexAttribType, void *buffer); // Enable attribute state pointer
RLAPI void rlDisableStatePointer(int vertexAttribType); // Disable attribute state pointer
#endif
"

Fix_StatePointer ← {
  if ← ⊑/broken_StatePointer⍷𝕩
  il ← if+≠broken_StatePointer
  (if⊸↑∾il⊸↓)𝕩
}

file ← •FChars "../lib/rlgl.h"
file Fix_rlVertexBuffer↩
file Fix_StatePointer↩
file ParseHeader˜↩ "RLAPI"
file ToFFI˜↩ map
file ∾˜↩ ":Namespace rlgl"∾@+10
file ∾↩ ":EndNamespace"∾˜@+10
file ∾↩ @+10
destination ← "../link/rlgl.apln"
destination •FChars file
•Out destination∾" successfully generated"
