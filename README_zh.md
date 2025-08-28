# 仓颉窗口封装层<a name="ZH-CN_TOPIC_0000001076213364"></a>

-   [简介](#section15701932113019)
-   [目录](#section1791423143211)
-   [编译构建](#section171384529151)
-   [开发者文档](#section171384529152)
-   [如何参与](#section171384529153)
-   [约束](#section171384529154)
-   [接口范围](#section171384529155)
-   [相关仓](#section171384529156)

## 简介<a name="section15701932113019"></a>

**仓颉窗口子系统封装层** 提供窗口管理和Display管理的基础能力，此代码仓提供了仓颉相关接口库

其主要结构如下图所示：

![仓颉window封装层](./figures/window_window_cangjie_wrapper.png)


## 目录<a name="section1791423143211"></a>
```
foundation/window/window_cangjie_wrapper/
├── figures                            # 存放readme中的架构图
├── ohos                               
|   |── display                        # 仓颉 display 接口代码实现目录
|   |── window                         # 仓颉 window 接口代码实现目录
```

## 编译构建<a name="section171384529151"></a>

```bash
./build.sh --product-name rk3568 --target-cpu=arm64 --build-target window_cangjie_wrapper
```

## 开发者文档<a name="section171384529152"></a>

[API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/arkui-cj/cj-apis-window.md)

[开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/summary_cjnative_ohos.md)

## 如何参与<a name="section171384529153"></a>

参与贡献：[如何贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)

## 约束<a name="section171384529154"></a>

支持设备类型：standard

## 接口范围<a name="section171384529155"></a>

已支持：

ohos.window

ohos.display

未支持：

ohos.Pipwindow

ohos.screenshot

## 相关仓<a name="section171384529156"></a>

[ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)

[cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[multimedia_cangjie_wrapper](https://gitcode.com/openharmony-sig/multimedia_multimedia_cangjie_wrapper)

[ability_runtime](https://gitee.com/openharmony/ability_ability_runtime)

[window_manager](https://gitee.com/openharmony/window_window_manager)
