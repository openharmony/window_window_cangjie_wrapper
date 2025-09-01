# 窗口仓颉接口<a name="ZH-CN_TOPIC_0000001076213364"></a>

-   [简介](#section15701932113019)
-   [目录](#section1791423143211)
-   [使用说明](#section171384529150)
-   [开发者文档](#section171384529152)
-   [参与贡献](#section171384529153)
-   [相关仓](#section171384529156)

## 简介<a name="section15701932113019"></a>

窗口仓颉接口是在Openharmony上基于窗口子系统能力之上封装的仓颉API，提供了窗口管理和显示设备管理的基础能力。当前开放的窗口仓颉接口仅支持standard设备

其主要结构如下图所示：

![仓颉window封装层](./figures/window_window_cangjie_wrapper.png)

如架构图所示：

- 窗口服务：提供窗口实例管理能力，提供上层查询接口
- 显示设备服务：提供显示设备管理服务，提供上层查询接口

## 目录<a name="section1791423143211"></a>
```
foundation/window/window_cangjie_wrapper/
├── figures                            # 存放readme中的架构图
├── ohos                               
|   |── display                        # 仓颉 display 接口代码实现目录
|   |── window                         # 仓颉 window 接口代码实现目录
├── test                               # 测试用例存放目录
```

## 使用说明<a name="section171384529150"></a>

窗口仓颉接口，目前提供窗口管理器，显示设备管理等API。

提供的能力范围包括：
- Window接口：窗口实例，获取应用窗口实例，相关接口参考[Window](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/arkui-cj/cj-apis-window.md)。
- WindowStage接口：窗口管理器，管理各个窗口基本单元。
- Display接口：管理显示设备的能力，获取所有显示设备的信息以及监听显示设备的插拔行为。

与ArkTS相比，暂未提供以下能力：
- Pipwindow：画中画能力。
- Screenshot：屏幕截图能力。

## 开发者文档<a name="section171384529152"></a>

[API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/arkui-cj/cj-apis-window.md)

[开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/summary_cjnative_ohos.md)

## 参与贡献<a name="section171384529153"></a>

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓<a name="section171384529156"></a>

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkui_arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[multimedia_multimedia_cangjie_wrapper](https://gitcode.com/openharmony-sig/multimedia_multimedia_cangjie_wrapper)

[ability_ability_runtime](https://gitee.com/openharmony/ability_ability_runtime)

[window_window_manager](https://gitee.com/openharmony/window_window_manager)
