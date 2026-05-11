# Codex Windows Graphics Tutorial

Windows 向けのグラフィックス API サンプル集です。Codex で作成した小さなチュートリアルとして、同じ「DDS テクスチャを四角形ポリゴンに貼る」処理を Direct3D 12 と Vulkan の両方で実装しています。

## Samples

| Sample | API | 内容 |
| --- | --- | --- |
| `Samples/QuadTextureSample` | Direct3D 12 | Agility SDK 対応、HLSL を DXC で Shader Model 6.6 の `.cso` に事前コンパイルし、DirectXTex の `DDSTextureLoader12` で DDS を読み込みます。 |
| `Samples/QuadTextureVulkanSample` | Vulkan | Windows + Vulkan SDK 前提。HLSL を Vulkan SDK 付属 DXC で SPIR-V に事前コンパイルし、最小 DDS ローダで同じ `quad.dds` を読み込みます。 |

## Requirements

- Windows 10 / Windows 11
- Visual Studio 2022
- Windows SDK
- Git submodule 対応の Git
- Vulkan SDK
  - Vulkan サンプル用
  - `VULKAN_SDK` 環境変数が設定されていること
  - `$(VULKAN_SDK)\Bin\dxc.exe` と `spirv-val.exe` を使用します

Direct3D 12 サンプルは NuGet の package restore で以下を取得します。

- `Microsoft.Direct3D.D3D12 1.618.3`
- `Microsoft.Direct3D.DXC 1.8.2505.32`

## Clone

```powershell
git clone --recursive https://github.com/shaderjp/CodexWindowsGraphicsTutorial.git
cd CodexWindowsGraphicsTutorial
```

submodule を後から取得する場合:

```powershell
git submodule update --init --recursive
```

## Build

Visual Studio 2022 で各 `.sln` を開いて Debug x64 または Release x64 をビルドできます。

### Direct3D 12

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" `
  Samples\QuadTextureSample\QuadTextureSample.sln `
  /t:Restore `
  /p:RestorePackagesConfig=true

& "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" `
  Samples\QuadTextureSample\QuadTextureSample.sln `
  /p:Configuration=Debug `
  /p:Platform=x64
```

### Vulkan

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" `
  Samples\QuadTextureVulkanSample\QuadTextureVulkanSample.sln `
  /p:Configuration=Debug `
  /p:Platform=x64
```

## What To Look At

- `QuadTexture*.hlsl`
  - HLSL の頂点シェーダ / ピクセルシェーダ
  - Vulkan 版は `[[vk::binding]]` と `[[vk::location]]` を明示しています
- `Assets/quad.dds`
  - 両サンプルで使う小さな DDS テクスチャ
- `QuadTextureSample.cpp`
  - Direct3D 12 の root signature、descriptor heap、PSO、texture upload
- `QuadTextureVulkanSample/Main.cpp`
  - Vulkan の instance、surface、swapchain、pipeline、descriptor、texture upload

## Notes

- `DirectX-Graphics-Samples-master` はローカル参考用フォルダとして `.gitignore` されています。
- Vulkan 版は学習用の最小実装です。swapchain resize、depth buffer、mipmap、複数テクスチャには対応していません。
- Direct3D 12 版は Agility SDK の DLL をビルド出力先の `D3D12/` にコピーします。

## License

MIT License。詳細は `LICENSE` を参照してください。
