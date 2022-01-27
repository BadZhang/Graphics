#ifndef UNITY_DOTS_INSTANCING_INCLUDED
#define UNITY_DOTS_INSTANCING_INCLUDED

#ifdef UNITY_DOTS_INSTANCING_ENABLED

#if defined(SHADER_API_GLCORE) || defined(SHADER_API_GLES3)
#define UNITY_DOTS_INSTANCING_UNIFORM_BUFFER
#endif

#if UNITY_OLD_PREPROCESSOR
#error DOTS Instancing requires the new shader preprocessor. Please enable Caching Preprocessor in the Editor settings!
#endif

/*
Here's a bit of python code to generate these repetitive typespecs without
a lot of C macro magic

def print_dots_instancing_typespecs(elem_type, id_char, elem_size):
    print(f"#define UNITY_DOTS_INSTANCING_TYPESPEC_{elem_type} {id_char}{elem_size}")
    for y in range(1, 5):
        for x in range(1, 5):
            rows = "" if y == 1 else f"x{y}"
            size = elem_size * x * y
            print(f"#define UNITY_DOTS_INSTANCING_TYPESPEC_{elem_type}{x}{rows} {id_char}{size}")

for t, c, sz in (
        ('float', 'F', 4),
        ('int',   'I', 4),
        ('uint',  'U', 4),
        ('half',  'H', 2)
        ):
    print_dots_instancing_typespecs(t, c, sz)
*/

#define UNITY_DOTS_INSTANCING_TYPESPEC_float F4
#define UNITY_DOTS_INSTANCING_TYPESPEC_float1 F4
#define UNITY_DOTS_INSTANCING_TYPESPEC_float2 F8
#define UNITY_DOTS_INSTANCING_TYPESPEC_float3 F12
#define UNITY_DOTS_INSTANCING_TYPESPEC_float4 F16
#define UNITY_DOTS_INSTANCING_TYPESPEC_float1x2 F8
#define UNITY_DOTS_INSTANCING_TYPESPEC_float2x2 F16
#define UNITY_DOTS_INSTANCING_TYPESPEC_float3x2 F24
#define UNITY_DOTS_INSTANCING_TYPESPEC_float4x2 F32
#define UNITY_DOTS_INSTANCING_TYPESPEC_float1x3 F12
#define UNITY_DOTS_INSTANCING_TYPESPEC_float2x3 F24
#define UNITY_DOTS_INSTANCING_TYPESPEC_float3x3 F36
#define UNITY_DOTS_INSTANCING_TYPESPEC_float4x3 F48
#define UNITY_DOTS_INSTANCING_TYPESPEC_float1x4 F16
#define UNITY_DOTS_INSTANCING_TYPESPEC_float2x4 F32
#define UNITY_DOTS_INSTANCING_TYPESPEC_float3x4 F48
#define UNITY_DOTS_INSTANCING_TYPESPEC_float4x4 F64
#define UNITY_DOTS_INSTANCING_TYPESPEC_int I4
#define UNITY_DOTS_INSTANCING_TYPESPEC_int1 I4
#define UNITY_DOTS_INSTANCING_TYPESPEC_int2 I8
#define UNITY_DOTS_INSTANCING_TYPESPEC_int3 I12
#define UNITY_DOTS_INSTANCING_TYPESPEC_int4 I16
#define UNITY_DOTS_INSTANCING_TYPESPEC_int1x2 I8
#define UNITY_DOTS_INSTANCING_TYPESPEC_int2x2 I16
#define UNITY_DOTS_INSTANCING_TYPESPEC_int3x2 I24
#define UNITY_DOTS_INSTANCING_TYPESPEC_int4x2 I32
#define UNITY_DOTS_INSTANCING_TYPESPEC_int1x3 I12
#define UNITY_DOTS_INSTANCING_TYPESPEC_int2x3 I24
#define UNITY_DOTS_INSTANCING_TYPESPEC_int3x3 I36
#define UNITY_DOTS_INSTANCING_TYPESPEC_int4x3 I48
#define UNITY_DOTS_INSTANCING_TYPESPEC_int1x4 I16
#define UNITY_DOTS_INSTANCING_TYPESPEC_int2x4 I32
#define UNITY_DOTS_INSTANCING_TYPESPEC_int3x4 I48
#define UNITY_DOTS_INSTANCING_TYPESPEC_int4x4 I64
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint U4
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint1 U4
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint2 U8
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint3 U12
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint4 U16
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint1x2 U8
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint2x2 U16
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint3x2 U24
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint4x2 U32
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint1x3 U12
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint2x3 U24
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint3x3 U36
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint4x3 U48
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint1x4 U16
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint2x4 U32
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint3x4 U48
#define UNITY_DOTS_INSTANCING_TYPESPEC_uint4x4 U64
#define UNITY_DOTS_INSTANCING_TYPESPEC_half H2
#define UNITY_DOTS_INSTANCING_TYPESPEC_half1 H2
#define UNITY_DOTS_INSTANCING_TYPESPEC_half2 H4
#define UNITY_DOTS_INSTANCING_TYPESPEC_half3 H6
#define UNITY_DOTS_INSTANCING_TYPESPEC_half4 H8
#define UNITY_DOTS_INSTANCING_TYPESPEC_half1x2 H4
#define UNITY_DOTS_INSTANCING_TYPESPEC_half2x2 H8
#define UNITY_DOTS_INSTANCING_TYPESPEC_half3x2 H12
#define UNITY_DOTS_INSTANCING_TYPESPEC_half4x2 H16
#define UNITY_DOTS_INSTANCING_TYPESPEC_half1x3 H6
#define UNITY_DOTS_INSTANCING_TYPESPEC_half2x3 H12
#define UNITY_DOTS_INSTANCING_TYPESPEC_half3x3 H18
#define UNITY_DOTS_INSTANCING_TYPESPEC_half4x3 H24
#define UNITY_DOTS_INSTANCING_TYPESPEC_half1x4 H8
#define UNITY_DOTS_INSTANCING_TYPESPEC_half2x4 H16
#define UNITY_DOTS_INSTANCING_TYPESPEC_half3x4 H24
#define UNITY_DOTS_INSTANCING_TYPESPEC_half4x4 H32

#define UNITY_DOTS_INSTANCING_CONCAT2(a, b) a ## b
#define UNITY_DOTS_INSTANCING_CONCAT4(a, b, c, d) a ## b ## c ## d
#define UNITY_DOTS_INSTANCING_CONCAT_WITH_METADATA(metadata_prefix, typespec, name) UNITY_DOTS_INSTANCING_CONCAT4(metadata_prefix, typespec, _Metadata, name)

// Metadata constants for properties have the following name format:
// unity_DOTSInstancing<Type><Size>_Metadata<Name>
// where
// <Type> is a single character element type specifier (e.g. F for float4x4)
//          F = float, I = int, U = uint, H = half
// <Size> is the total size of the property in bytes (e.g. 64 for float4x4)
// <Name> is the name of the property
// NOTE: There is no underscore between 'Metadata' and <Name> to avoid a double
//       underscore in the common case where the property name starts with an underscore.
//       A prefix double underscore is illegal on some platforms like OpenGL.
#define UNITY_DOTS_INSTANCED_METADATA_NAME(type, name) UNITY_DOTS_INSTANCING_CONCAT_WITH_METADATA(unity_DOTSInstancing, UNITY_DOTS_INSTANCING_CONCAT2(UNITY_DOTS_INSTANCING_TYPESPEC_, type), name)

#define UNITY_DOTS_INSTANCING_START(name) cbuffer UnityDOTSInstancing_##name {
#define UNITY_DOTS_INSTANCING_END(name)   }
#define UNITY_DOTS_INSTANCED_PROP(type, name) uint UNITY_DOTS_INSTANCED_METADATA_NAME(type, name);

#define UNITY_ACCESS_DOTS_INSTANCED_PROP(type, var) LoadDOTSInstancedData_##type(UNITY_DOTS_INSTANCED_METADATA_NAME(type, var))
#define UNITY_ACCESS_DOTS_AND_TRADITIONAL_INSTANCED_PROP(type, arr, var) LoadDOTSInstancedData_##type(UNITY_DOTS_INSTANCED_METADATA_NAME(type, var))

#define UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_DEFAULT(type, var) LoadDOTSInstancedData_##type(var, UNITY_DOTS_INSTANCED_METADATA_NAME(type, var))
#define UNITY_ACCESS_DOTS_AND_TRADITIONAL_INSTANCED_PROP_WITH_DEFAULT(type, arr, var) LoadDOTSInstancedData_##type(var, UNITY_DOTS_INSTANCED_METADATA_NAME(type, var))

#define UNITY_ACCESS_DOTS_INSTANCED_PROP_WITH_CUSTOM_DEFAULT(type, var, default_value) LoadDOTSInstancedData_##type(default_value, UNITY_DOTS_INSTANCED_METADATA_NAME(type, var))
#define UNITY_ACCESS_DOTS_AND_TRADITIONAL_INSTANCED_PROP_WITH_CUSTOM_DEFAULT(type, arr, var, default_value) LoadDOTSInstancedData_##type(default_value, UNITY_DOTS_INSTANCED_METADATA_NAME(type, var))

#ifdef UNITY_DOTS_INSTANCING_UNIFORM_BUFFER
CBUFFER_START(unity_DOTSInstanceData)
    float4 unity_DOTSInstanceDataRaw[4096];
CBUFFER_END
CBUFFER_START(unity_DOTSInstanceDataSecondary)
    float4 unity_DOTSInstanceDataRawSecondary[4096];
CBUFFER_END
#else
ByteAddressBuffer unity_DOTSInstanceData;
#endif

// The data has to be wrapped inside a struct, otherwise the instancing code path
// on some platforms does not trigger.
struct DOTSVisibleData
{
    uint4 VisibleData;
};

// The name of this cbuffer has to start with "UnityInstancing" and a struct so it's
// detected as an "instancing cbuffer" by some platforms that use string matching
// to detect this.
CBUFFER_START(UnityInstancingDOTS_InstanceVisibility)
    DOTSVisibleData unity_DOTSVisibleInstances[UNITY_INSTANCED_ARRAY_SIZE];
CBUFFER_END

// Keep these in sync with SRP Batcher DOTSInstancingFlags
static const uint kDOTSInstancingFlagFlipWinding      = (1 << 0); // Flip triangle winding when rendering, e.g. when the scale is negative
static const uint kDOTSInstancingFlagForceZeroMotion  = (1 << 1); // Object should produce zero motion vectors when rendered in the motion pass
static const uint kDOTSInstancingFlagCameraMotion     = (1 << 2); // Object uses Camera motion (i.e. not per-Object motion)
static const uint kDOTSInstancingFlagHasPrevPosition  = (1 << 3); // Object has a separate previous frame position vertex streams (e.g. for deformed objects)
static const uint kDOTSInstancingFlagMainLightEnabled = (1 << 4); // Object should receive direct lighting from the main light (e.g. light not baked into lightmap)

static const uint kPerInstanceDataBit = 0x80000000;
static const uint kSecondaryUBOBit    = 0x40000000;
#ifdef UNITY_DOTS_INSTANCING_UNIFORM_BUFFER
static const uint kAddressMask        = 0x3fffffff;
#else
static const uint kAddressMask        = 0x7fffffff;
#endif

static DOTSVisibleData unity_SampledDOTSVisibleData;

void SetupDOTSVisibleInstancingData()
{
    unity_SampledDOTSVisibleData = unity_DOTSVisibleInstances[unity_InstanceID];
}

uint GetDOTSInstanceIndex()
{
    return unity_SampledDOTSVisibleData.VisibleData.x;
}

int GetDOTSInstanceCrossfadeSnorm8()
{
    return unity_SampledDOTSVisibleData.VisibleData.y;
}

bool IsDOTSInstancedProperty(uint metadata)
{
    return (metadata & kPerInstanceDataBit) != 0;
}

bool IsDOTSSecondaryUBO(uint metadata)
{
#ifdef UNITY_DOTS_INSTANCING_UNIFORM_BUFFER
    return (metadata & kSecondaryUBOBit) != 0;
#else
    // There is no secondary UBO on SSBO code paths.
    return false;
#endif
}

// Stride is typically expected to be a compile-time literal here, so this should
// be optimized into shifts and other cheap ALU ops by the compiler.
uint ComputeDOTSInstanceOffset(uint instanceIndex, uint stride)
{
    return instanceIndex * stride;
}

uint ComputeDOTSInstanceDataAddress(uint metadata, uint stride, out bool secondary)
{
    uint isOverridden = metadata & kPerInstanceDataBit;
    secondary = IsDOTSSecondaryUBO(metadata);
    // Sign extend per-instance data bit so it can just be ANDed with the offset
    uint offsetMask  = (uint)((int)isOverridden >> 31);
    uint baseAddress = metadata & kAddressMask;
    uint offset      = ComputeDOTSInstanceOffset(GetDOTSInstanceIndex(), stride);
    offset          &= offsetMask;
    return baseAddress + offset;
}

// This version assumes that the high bit of the metadata is set (= per instance data).
// Useful if the call site has already branched over this.
uint ComputeDOTSInstanceDataAddressOverridden(uint metadata, uint stride, out bool secondary)
{
    secondary = IsDOTSSecondaryUBO(metadata);
    uint baseAddress = metadata & kAddressMask;
    uint offset      = ComputeDOTSInstanceOffset(GetDOTSInstanceIndex(), stride);
    return baseAddress + offset;
}

#ifdef UNITY_DOTS_INSTANCING_UNIFORM_BUFFER
uint DOTSInstanceData_Select(uint addressOrOffset, uint4 v)
{
    // x = 0 = 00
    // y = 1 = 01
    // z = 2 = 10
    // w = 3 = 11
    // Lowest 2 bits are zero, all accesses are aligned,
    // and base addresses are aligned by 16.
    // Bits 29 and 28 give the channel index.
    uint mask0 = uint(int(addressOrOffset << 29) >> 31);
    uint mask1 = uint(int(addressOrOffset << 28) >> 31);
    return
        (((v.w & mask0) | (v.z & ~mask0)) & mask1) |
        (((v.y & mask0) | (v.x & ~mask0)) & ~mask1);
}

uint2 DOTSInstanceData_Select2(uint addressOrOffset, uint4 v)
{
    // Lowest 3 bits are zero, all accesses are aligned,
    // and base addresses are aligned by 16.
    // Bit 28 gives high or low channels.
    uint mask0 = uint(int(addressOrOffset << 28) >> 31);
    return (v.zw & mask0) | (v.xy & ~mask0);
}


uint DOTSInstanceData_Load(bool secondary, uint address)
{
    // NOTE: Indexing into a float4 is likely to generate bad code.
    // Look into alternatives here.
    uint float4Index = address >> 4;
    uint4 raw = asuint(secondary
        ? unity_DOTSInstanceDataRawSecondary[float4Index]
        : unity_DOTSInstanceDataRaw[float4Index]);
    return DOTSInstanceData_Select(address, raw);
}
uint2 DOTSInstanceData_Load2(bool secondary, uint address)
{
    uint float4Index = address >> 4;
    uint4 raw = asuint(secondary
        ? unity_DOTSInstanceDataRawSecondary[float4Index]
        : unity_DOTSInstanceDataRaw[float4Index]);
    return DOTSInstanceData_Select2(address, raw);
}
uint3 DOTSInstanceData_Load3(bool secondary, uint address)
{
    // Float3s are packed as float4
    uint float4Index = address >> 4;
    uint4 raw = asuint(secondary
        ? unity_DOTSInstanceDataRawSecondary[float4Index]
        : unity_DOTSInstanceDataRaw[float4Index]);
    return raw.xyz;
}
uint4 DOTSInstanceData_Load4(bool secondary, uint address)
{
    uint float4Index = address >> 4;
    return asuint(
        secondary
        ? unity_DOTSInstanceDataRawSecondary[float4Index]
        : unity_DOTSInstanceDataRaw[float4Index]);
}
#else
uint DOTSInstanceData_Load(bool secondary_unused, uint address)
{
    return unity_DOTSInstanceData.Load(address);
}
uint2 DOTSInstanceData_Load2(bool secondary_unused, uint address)
{
    return unity_DOTSInstanceData.Load2(address);
}
uint3 DOTSInstanceData_Load3(bool secondary_unused, uint address)
{
    return unity_DOTSInstanceData.Load3(address);
}
uint4 DOTSInstanceData_Load4(bool secondary_unused, uint address)
{
    return unity_DOTSInstanceData.Load4(address);
}
#endif

#define DEFINE_DOTS_LOAD_INSTANCE_SCALAR(type, conv, sizeof_type) \
type LoadDOTSInstancedData_##type(uint metadata) \
{ \
    bool secondary; \
    uint address = ComputeDOTSInstanceDataAddress(metadata, sizeof_type, secondary); \
    return conv(DOTSInstanceData_Load(secondary, address)); \
} \
type LoadDOTSInstancedData_##type(type default_value, uint metadata) \
{ \
    bool secondary; \
    uint address = ComputeDOTSInstanceDataAddressOverridden(metadata, sizeof_type, secondary); \
    return IsDOTSInstancedProperty(metadata) ? \
        conv(DOTSInstanceData_Load(secondary, address)) : default_value; \
}

#define DEFINE_DOTS_LOAD_INSTANCE_VECTOR(type, width, conv, sizeof_type) \
type##width LoadDOTSInstancedData_##type##width(uint metadata) \
{ \
    bool secondary; \
    uint address = ComputeDOTSInstanceDataAddress(metadata, sizeof_type * width, secondary); \
    return conv(DOTSInstanceData_Load##width(secondary, address)); \
} \
type##width LoadDOTSInstancedData_##type##width(type##width default_value, uint metadata) \
{ \
    bool secondary; \
    uint address = ComputeDOTSInstanceDataAddressOverridden(metadata, sizeof_type * width, secondary); \
    return IsDOTSInstancedProperty(metadata) ? \
        conv(DOTSInstanceData_Load##width(secondary, address)) : default_value; \
}

DEFINE_DOTS_LOAD_INSTANCE_SCALAR(float, asfloat, 4)
DEFINE_DOTS_LOAD_INSTANCE_SCALAR(int,   int,     4)
DEFINE_DOTS_LOAD_INSTANCE_SCALAR(uint,  uint,    4)
DEFINE_DOTS_LOAD_INSTANCE_SCALAR(half,  half,    2)

DEFINE_DOTS_LOAD_INSTANCE_VECTOR(float, 2, asfloat, 4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(float, 3, asfloat, 4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(float, 4, asfloat, 4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(int,   2, int2,    4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(int,   3, int3,    4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(int,   4, int4,    4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(uint,  2, uint2,   4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(uint,  3, uint3,   4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(uint,  4, uint4,   4)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(half,  2, half2,   2)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(half,  3, half3,   2)
DEFINE_DOTS_LOAD_INSTANCE_VECTOR(half,  4, half4,   2)

// TODO: Other matrix sizes
float4x4 LoadDOTSInstancedData_float4x4(uint metadata)
{
    bool secondary;
    uint address = ComputeDOTSInstanceDataAddress(metadata, 4 * 16, secondary);
    float4 p1 = asfloat(DOTSInstanceData_Load4(secondary, address + 0 * 16));
    float4 p2 = asfloat(DOTSInstanceData_Load4(secondary, address + 1 * 16));
    float4 p3 = asfloat(DOTSInstanceData_Load4(secondary, address + 2 * 16));
    float4 p4 = asfloat(DOTSInstanceData_Load4(secondary, address + 3 * 16));
    return float4x4(
        p1.x, p2.x, p3.x, p4.x,
        p1.y, p2.y, p3.y, p4.y,
        p1.z, p2.z, p3.z, p4.z,
        p1.w, p2.w, p3.w, p4.w);
}

float4x4 LoadDOTSInstancedData_float4x4_from_float3x4(uint metadata)
{
    bool secondary;
    uint address = ComputeDOTSInstanceDataAddress(metadata, 3 * 16, secondary);
    float4 p1 = asfloat(DOTSInstanceData_Load4(secondary, address + 0 * 16));
    float4 p2 = asfloat(DOTSInstanceData_Load4(secondary, address + 1 * 16));
    float4 p3 = asfloat(DOTSInstanceData_Load4(secondary, address + 2 * 16));

    return float4x4(
        p1.x, p1.w, p2.z, p3.y,
        p1.y, p2.x, p2.w, p3.z,
        p1.z, p2.y, p3.x, p3.w,
        0.0,  0.0,  0.0,  1.0
    );
}

float2x4 LoadDOTSInstancedData_float2x4(uint metadata)
{
    bool secondary;
    uint address = ComputeDOTSInstanceDataAddress(metadata, 4 * 8, secondary);
    return float2x4(
        asfloat(DOTSInstanceData_Load4(secondary, address + 0 * 8)),
        asfloat(DOTSInstanceData_Load4(secondary, address + 1 * 8)));
}

float4x4 LoadDOTSInstancedData_float4x4(float4x4 default_value, uint metadata)
{
    return IsDOTSInstancedProperty(metadata) ?
        LoadDOTSInstancedData_float4x4(metadata) : default_value;
}

float4x4 LoadDOTSInstancedData_float4x4_from_float3x4(float4x4 default_value, uint metadata)
{
    return IsDOTSInstancedProperty(metadata) ?
        LoadDOTSInstancedData_float4x4_from_float3x4(metadata) : default_value;
}

float2x4 LoadDOTSInstancedData_float2x4(float4 default_value[2], uint metadata)
{
    return IsDOTSInstancedProperty(metadata) ?
        LoadDOTSInstancedData_float2x4(metadata) : float2x4(default_value[0], default_value[1]);
}

float2x4 LoadDOTSInstancedData_float2x4(float2x4 default_value, uint metadata)
{
    return IsDOTSInstancedProperty(metadata) ?
        LoadDOTSInstancedData_float2x4(metadata) : default_value;
}

float4  LoadDOTSInstancedData_RenderingLayer()
{
    return float4(asfloat(unity_DOTSVisibleInstances[0].VisibleData.z), 0,0,0);
}

float4 LoadDOTSInstancedData_MotionVectorsParams()
{
    uint flags = unity_DOTSVisibleInstances[0].VisibleData.w;
    return float4(0, flags & kDOTSInstancingFlagForceZeroMotion ? 0.0f : 1.0f, -0.001f, flags & kDOTSInstancingFlagCameraMotion ? 0.0f : 1.0f);
}

float4 LoadDOTSInstancedData_WorldTransformParams()
{
    uint flags = unity_DOTSVisibleInstances[0].VisibleData.w;
    return float4(0, 0, 0, flags & kDOTSInstancingFlagFlipWinding ? -1.0f : 1.0f);
}

float4 LoadDOTSInstancedData_LightData()
{
    uint flags = unity_DOTSVisibleInstances[0].VisibleData.w;
    // X channel = light start index (not supported in DOTS instancing)
    // Y channel = light count (not supported in DOTS instancing)
    // Z channel = main light strength
    return float4(0, 0, flags & kDOTSInstancingFlagMainLightEnabled ? 1.0f : 0.0f, 0);
}

float4 LoadDOTSInstancedData_LODFade()
{
    int crossfadeSNorm8 = GetDOTSInstanceCrossfadeSnorm8();
    float crossfade = clamp((float)crossfadeSNorm8, -127, 127);
    crossfade *= 1.0 / 127;
    return crossfade;
}

#undef DEFINE_DOTS_LOAD_INSTANCE_SCALAR
#undef DEFINE_DOTS_LOAD_INSTANCE_VECTOR

#endif // UNITY_DOTS_INSTANCING_ENABLED

#endif // UNITY_DOTS_INSTANCING_INCLUDED
