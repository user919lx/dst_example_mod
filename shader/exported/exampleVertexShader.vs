uniform mat4 MatrixP;
uniform mat4 MatrixV;
uniform mat4 MatrixW;

attribute vec4 POS2D_UV;

varying vec3 PS_TEXCOORD;

void main()
{
    vec3 POSITION = vec3(POS2D_UV.xy, 0);
    float samplerIndex = floor(POS2D_UV.z/2.0);
    vec3 TEXCOORD0 = vec3(POS2D_UV.z - 2.0*samplerIndex, POS2D_UV.w, samplerIndex);

    mat4 mtxPVW = MatrixP * MatrixV * MatrixW;
    gl_Position = mtxPVW * vec4( POSITION.xyz, 1.0 );

    PS_TEXCOORD = TEXCOORD0;
}
