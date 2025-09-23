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

- Window：当前窗口实例，窗口管理器管理的基本单元。
- WindowStage：窗口管理器。管理各个基本窗口单元。
- Display：屏幕属性提供管理显示设备的一些基础能力，包括获取默认显示设备的信息，获取所有显示设备的信息以及监听显示设备的插拔行为。
- 仓颉窗口FFI接口定义：负责定义C语言互操作仓颉接口，用于实现仓颉窗口能力

架构图中依赖部件引入说明：

- 窗口管理部件：仓颉接口封装依赖窗口管理部件提供的窗口服务和显示设备服务
- 元能力部件：依赖元能力部件提供的BaseContext查询能力
- arkui_cangjie_wrapper：依赖ArkUI仓颉部件提供的基础类型
- ability_cangjie_wrapper：依赖Ability仓颉部件提供获取AbilityContext接口
- cangjie_ark_interop：依赖仓颉互操作部件提供的APILevel能力进行API管理
- multimedia_cangjie_wrapper：依赖多媒体仓颉部件提供的image接口
- hiviewdfx_cangjie_wrapper：依赖DFX仓颉部件提供的Hilog接口

## 目录<a name="section1791423143211"></a>
```
foundation/window/window_cangjie_wrapper/
├── figures                           # 存放readme中的架构图
├── ohos                              # 仓颉接口实现源码目录
│   ├── display                       # 显示设备管理相关接口实现
│   └── window                        # 窗口管理相关接口实现
└── test                              # 测试用例存放目录
```

## 使用说明<a name="section171384529150"></a>

窗口仓颉接口，目前提供窗口管理器，显示设备管理等API。

提供的能力范围包括：
- Window接口：窗口实例，提供获取应用窗口实例的接口，相关接口参考[Window](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/arkui-cj/cj-apis-window.md)。
- WindowStage接口：窗口管理器，提供管理各个窗口基本单元的接口。
- Display接口：管理显示设备的能力，提供获取所有显示设备的信息以及监听显示设备的插拔行为的接口。

与ArkTS相比，暂未提供以下能力：
- Pipwindow：画中画能力。
- Screenshot：屏幕截图能力。

## 开发者文档<a name="section171384529152"></a>

[API文档](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/arkui-cj/cj-apis-window.md)

[开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/summary_cjnative_ohos.md)

## 参与贡献<a name="section171384529153"></a>

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓<a name="section171384529156"></a>

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkui_arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[multimedia_multimedia_cangjie_wrapper](https://gitcode.com/openharmony-sig/multimedia_multimedia_cangjie_wrapper)

[ability_ability_runtime](https://gitcode.com/openharmony/ability_ability_runtime)

[window_window_manager](https://gitcode.com/openharmony/window_window_manager)
