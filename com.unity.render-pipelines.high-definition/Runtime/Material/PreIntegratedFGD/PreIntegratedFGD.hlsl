#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/PreIntegratedFGD/PreIntegratedFGD.cs.hlsl"

TEXTURE2D(_PreIntegratedFGD_GGXDisneyDiffuse);

float FGD_Fit_F(float NdotV, float perceptualRoughness)
{
    const float a0 = 0.02047173f;
    const float b0 = -0.56172166f;
    const float c0 = 0.61822971f;
    const float a1 = -2.64881573f;
    const float b1 = 7.06815052f;
    const float c1 = -4.77466956f;
    const float o = 0.74117866f;

    NdotV -= o;
    perceptualRoughness = max(perceptualRoughness, 0.03);
    float roughness = perceptualRoughness * perceptualRoughness;

    float b = a0 + b0 * perceptualRoughness + c0 * roughness;
    float d = a1 + b1 * perceptualRoughness + c1 * roughness;

    return saturate((b + d * NdotV * NdotV) * NdotV);
}

float FGD_Fit_G(float NdotV, float perceptualRoughness)
{
    const float a0 = 0.9745876192602081f;
    const float a2 = -0.36245015983106055f;
    const float b2 = 0.9008769726821249f;
    const float c2 = -1.233668349677881f;

    NdotV = min(NdotV, 0.87);
    float NdotV2 = NdotV * NdotV;
    float y = perceptualRoughness;

    float a = a2 + c2 * y;
    float b = a * NdotV + b2 * NdotV2;
    return saturate(a0 + b * y);
}

float2 FGD_Lazarov(float NdotV, float perceptualRoughness)
{
    float x = (1-perceptualRoughness)*(1-perceptualRoughness);
    float y = NdotV;

    float b1 = -0.1688;
    float b2 = 1.895;
    float b3 = 0.9903;
    float b4 = -4.853;
    float b5 = 8.404;
    float b6 = -5.069;
    float bias = saturate( min( b1 * x + b2 * x * x, b3 + b4 * y + b5 * y * y + b6 * y * y * y ) );

    float d0 = 0.6045;
    float d1 = 1.699;
    float d2 = -0.5228;
    float d3 = -3.603;
    float d4 = 1.404;
    float d5 = 0.1939;
    float d6 = 2.661;
    float delta = saturate( d0 + d1 * x + d2 * y + d3 * x * x + d4 * x * y + d5 * y * y + d6 * x * x * x );

    return float2(bias, delta);
}

// For image based lighting, a part of the BSDF is pre-integrated.
// This is done both for specular GGX height-correlated and DisneyDiffuse
// reflectivity is  Integral{(BSDF_GGX / F) - use for multiscattering
void GetPreIntegratedFGDGGXAndDisneyDiffuse(float NdotV, float perceptualRoughness, float3 fresnel0, out float3 specularFGD, out float diffuseFGD, out float reflectivity)
{
    // We want the LUT to contain the entire [0, 1] range, without losing half a texel at each side.
    float2 coordLUT = Remap01ToHalfTexelCoord(float2(sqrt(NdotV), perceptualRoughness), FGDTEXTURE_RESOLUTION);

    float3 preFGD = SAMPLE_TEXTURE2D_LOD(_PreIntegratedFGD_GGXDisneyDiffuse, s_linear_clamp_sampler, coordLUT, 0).xyz;

#if HDRP_LITE
    preFGD.x = FGD_Fit_F(NdotV, perceptualRoughness);
    preFGD.y = FGD_Fit_G(NdotV, perceptualRoughness);
    //preFGD.z = 1.0f; // if lambert diffuse
#elif HDRP_LAZAROV
    preFGD.xy = FGD_Lazarov(NdotV, perceptualRoughness);
#endif

    // Pre-integrate GGX FGD
    // Integral{BSDF * <N,L> dw} =
    // Integral{(F0 + (1 - F0) * (1 - <V,H>)^5) * (BSDF / F) * <N,L> dw} =
    // (1 - F0) * Integral{(1 - <V,H>)^5 * (BSDF / F) * <N,L> dw} + F0 * Integral{(BSDF / F) * <N,L> dw}=
    // (1 - F0) * x + F0 * y = lerp(x, y, F0)
    specularFGD = lerp(preFGD.xxx, preFGD.yyy, fresnel0);

    // Pre integrate DisneyDiffuse FGD:
    // z = DisneyDiffuse
    // Remap from the [0, 1] to the [0.5, 1.5] range.
    diffuseFGD = preFGD.z + 0.5;

    reflectivity = preFGD.y;
}

void GetPreIntegratedFGDGGXAndLambert(float NdotV, float perceptualRoughness, float3 fresnel0, out float3 specularFGD, out float diffuseFGD, out float reflectivity)
{
    float2 preFGD = SAMPLE_TEXTURE2D_LOD(_PreIntegratedFGD_GGXDisneyDiffuse, s_linear_clamp_sampler, float2(NdotV, perceptualRoughness), 0).xy;

    // Pre-integrate GGX FGD
    // Integral{BSDF * <N,L> dw} =
    // Integral{(F0 + (1 - F0) * (1 - <V,H>)^5) * (BSDF / F) * <N,L> dw} =
    // (1 - F0) * Integral{(1 - <V,H>)^5 * (BSDF / F) * <N,L> dw} + F0 * Integral{(BSDF / F) * <N,L> dw}=
    // (1 - F0) * x + F0 * y = lerp(x, y, F0)
    specularFGD = lerp(preFGD.xxx, preFGD.yyy, fresnel0);
    diffuseFGD = 1.0;

    reflectivity = preFGD.y;
}

TEXTURE2D(_PreIntegratedFGD_CharlieAndFabric);

void GetPreIntegratedFGDCharlieAndFabricLambert(float NdotV, float perceptualRoughness, float3 fresnel0, out float3 specularFGD, out float diffuseFGD, out float reflectivity)
{
    // Read the texture
    float3 preFGD = SAMPLE_TEXTURE2D_LOD(_PreIntegratedFGD_CharlieAndFabric, s_linear_clamp_sampler, float2(NdotV, perceptualRoughness), 0).xyz;

    specularFGD = lerp(preFGD.xxx, preFGD.yyy, fresnel0) * 2.0f * PI;

    // z = FabricLambert
    diffuseFGD = preFGD.z;

    reflectivity = preFGD.y;
}
