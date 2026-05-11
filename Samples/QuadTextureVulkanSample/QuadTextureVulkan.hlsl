struct VSInput
{
    [[vk::location(0)]] float3 position : POSITION;
    [[vk::location(1)]] float2 uv : TEXCOORD0;
};

struct PSInput
{
    float4 position : SV_POSITION;
    [[vk::location(0)]] float2 uv : TEXCOORD0;
};

[[vk::binding(0, 0)]] Texture2D<float4> g_texture : register(t0, space0);
[[vk::binding(1, 0)]] SamplerState g_sampler : register(s0, space0);

PSInput VSMain(VSInput input)
{
    PSInput result;
    result.position = float4(input.position, 1.0f);
    result.uv = input.uv;
    return result;
}

float4 PSMain(PSInput input) : SV_TARGET
{
    return g_texture.Sample(g_sampler, input.uv);
}
