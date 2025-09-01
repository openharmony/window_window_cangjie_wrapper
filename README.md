# Cangjie Window Wrapper<a name="EN-US_TOPIC_0000001076213364"></a>

-   [Introduction](#section15701932113019)
-   [Directory Structure](#section1791423143211)
-   [How to Build](#section171384529151)
-   [Developer Document](#section171384529152)
-   [How to contribute](#section171384529153)
-   [Limiatation](#section171384529154)
-   [Interface Scope](#section171384529155)
-   [Repositories Involved](#section1447164910172)

## Introduction<a name="section15701932113019"></a>

The Window Manager subsystem provides basic capabilities of window and display management. It is the basis for UI display. Here is for cangjie window api implementation code.

Framework architecture:

![Cangjie window wrapper](./figures/window_window_cangjie_wrapper_en.png)

## Directory Structure<a name="section1791423143211"></a>

```
foundation/window/window_cangjie_wrapper/
├── figures                            # Architectural diagram
├── ohos                               
|   |── display                        # Cangjie display implement
|   |── window                         # Cangjie window implement
```

## How to Build<a name="section171384529151"></a>

```bash
./build.sh --product-name rk3568 --target-cpu=arm64 --build-target window_cangjie_wrapper
```

## Developer Document<a name="section171384529152"></a>

[API Document](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/arkui-cj/cj-apis-window.md)

[Develop Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/summary_cjnative_ohos_EN.md)

## How to Contribute<a name="section171384529153"></a>

Contributting：[How to Contribute](https://gitcode.com/openharmony/docs/blob/master/en/contribute/how-to-contribute.md)

## Limitation<a name="section171384529154"></a>

Support device type：standard

## Interface Scope<a name="section171384529155"></a>

Already supported：

ohos.window

ohos.display

Not supported：

ohos.Pipwindow

ohos.screenshot

## Repositories Involved

[ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)

[cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[multimedia_cangjie_wrapper](https://gitcode.com/openharmony-sig/multimedia_multimedia_cangjie_wrapper)

[ability_runtime](https://gitee.com/openharmony/ability_ability_runtime)

[window_manager](https://gitee.com/openharmony/window_window_manager)