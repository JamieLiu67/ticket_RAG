# **工单训练 RAG 集**

本篇《工单训练 RAG 集》汇集了近期在声网各类 SDK 产品集成与使用过程中遇到的典型问题及解答。内容涵盖了从技术集成、线上报错、效果优化到商务和权限相关的常见场景，旨在为开发者和技术支持人员提供高效、实用的参考。通过梳理每个工单的提问、分析思路与标准回复，本文帮助读者快速定位问题本质，掌握处理思路，提升工单首次响应与技术支持的专业能力。

---

# **编号：36461**

**SDK Product: RTC**

**SDK Platform: HarmonyOS**

**SDK Version: 4.4.0**

**Request Type: 集成问题咨询**

问：使用c++中的代码，在使用远程实时音视频时与本地摄像头存在冲突，如何解决

答：您好，如果要和远端音视频互通，SDK 就需要使用摄像头来发流，肯定会有占用情况的，请问现在具体是什么现象？
麻烦完整描述下使用场景并且提供 SDK 日志（使用命令 hdc file recv /data/app/el2/100/base/[包名]/haps/entry/files)，人工工程师稍后为您解答

---
# **编号：36488**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 线上报错**

问：这个房间：11843719894有回音

用户id：113802  笙儿

答：您好，针对回声问题，需要您补充提供以下信息，以便我们能够第一时间开展排查：
1. 出问题的时间点：
2. 定位引起回声的用户。可通过依次静音频道内的用户进行确认：当用户A静音时，频道内其他用户听不到回声了，则说明用户A是引起回声的用户。
1 对 1 通话：如果您听到回声，临时建议请让对方佩戴耳机进行通话。
多人通话：可以请用户轮流静音，找出回声源。引起回声的用户请佩戴耳机，或在无需发言时，请将自己设为静音状态
3.提供回声源用户端的声网sdk日志：https://doc.shengwang.cn/faq/integration-issues/set-log-file

---
# **编号：36491**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 集成问题咨询**

问：  使用过程接听电话是会在哪个回调反馈？

答：您好，在使用rtc通话中本地接听手机电话，rtc侧会可以通过onLocalAudioStateChanged回调来监听本地音频采集状态：
reason：LOCAL_AUDIO_STREAM_REASON_INTERRUPTED (8)
参考文档：https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#callback_irtcengineeventhandler_onlocalaudiostatechanged

---
# **编号：36492**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.0**

**Request Type: 线上报错**

问：课次id：578676826
用户id：20249803
问题：摄像头横屏，辛苦老师看下

答：您好，针对线上单机摄像头横屏问题，人工工程师会根据您提供的课堂id 和用户id，通过内部分析工具排查定位，有结论后会尽快回复您；感谢您的理解与配合，另外建议您可以联系用户重启下设备重进频道是否正常。

---
# **编号：36494**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 集成问题咨询**

问：想做个1v1纯语音的 使用哪款产品？

答：针对您的1v1纯语音通话需求，推荐使用**声网RTC SDK的纯音频方案**，这是最轻量高效的解决方案：

推荐方案
1. **集成RTC音频SDK**  
   使用纯音频SDK（`voice-sdk`）可显著减小包体积（相比全功能SDK减少约40%），专为语音场景优化：
   ```gradle
   implementation 'io.agora.rtc:voice-sdk:4.5.2'
   ```

2. **核心实现步骤**  
   - **初始化引擎**：仅启用音频模块
   ```java
   RtcEngineConfig config = new RtcEngineConfig();
   config.mContext = getApplicationContext();
   config.mAppId = "您的AppID"; // 替换为控制台获取的AppID
   config.mEventHandler = iRtcEngineEventHandler; // 事件回调
   mRtcEngine = RtcEngine.create(config);
   mRtcEngine.enableAudio(); // 启用纯音频模式
   ```
   - **加入频道**：1v1场景建议使用`joinChannel`
   ```java
   mRtcEngine.joinChannel(
       null, // 测试可临时用null（生产环境需Token）
       "channelName", // 频道名
       null, // 额外信息
       0 // 自动分配UID
   );
   ```

3. **关键文档**  
   - [纯语音通话快速开始](https://doc.shengwang.cn/doc/rtc/android/basic-features/audio-quick-start)  
     含完整代码示例和流程说明。
   - [音频SDK包体积数据](https://doc.shengwang.cn/doc/rtc/android/resources)  
     ARMv7仅9.44MB，显著节省用户流量。

优势说明
- **包体优化**：纯音频SDK比全功能SDK体积小40%以上
- **功耗更低**：关闭视频模块延长设备续航
- **兼容性强**：支持Android 5.0+所有主流设备

> ⚠️ **注意**：若后续需扩展为视频通话，只需改用全功能SDK（`full-sdk`），API完全兼容无需重写逻辑。

参考文档：  
[声网RTC纯语音方案](https://doc.shengwang.cn/doc/rtc/android/basic-features/audio-quick-start) | [SDK下载](https://doc.shengwang.cn/doc/rtc/android/resources)

---
# **编号：36495**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.1**

**Request Type: 效果不佳、不达预期**

问：我们现在线上大多数主播都反馈音质不好，怎么调整？

答：您好，针对线上主播反馈音质差的问题，需要您提供以下信息以便我们及时开展排查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
(1) uid=123 听不到/看不到 uid=456，大约持续20分钟
4.SDK日志（非必提供)
https://doc.shengwang.cn/faq/integration-issues/set-log-file
(2) uid=123 听/看 uid=456卡顿
4.主播是否使用声卡
5.主播端声网sdk日志（非必需）
https://doc.shengwang.cn/faq/integration-issues/set-log-file
另外您这边也可以参考下我们的高音质实践文档，来对项目进行优化：
https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality



---
# **编号：36496**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.1**

**Request Type: 集成问题咨询**

问：CONNECTION_STATE_FAILED(5)：网络连接失败
CONNECTION_CHANGED_BANNED_BY_SERVER (3)：网络连接被服务器禁止，例如，当用户被踢出频道时，会返回该状态。 确认下  只有用户被踢 这个reason 才会返回3  还是有其它情况 也会返回3

答：您好，是的，CONNECTION_CHANGED_BANNED_BY_SERVER (3) 是只有用户被踢出频道（例如通过服务端RESTful API主动踢人）才会触发的

---
# **编号：36497**

**SDK Product: Convol AI**

**SDK Platform: Restful**

**SDK Version: 当前版本**

**Request Type: 集成问题咨询**

问：给我一个 react的web的对话式AI引擎例子 你们的文档写的太过于差劲了

答：您好，React Demo 参考 Web Demo 就行了，集成 WebSDK 加入频道就可以和智能体通话了。
[React Web Demo](https://github.com/AgoraIO/API-Examples-Web/tree/main/src/example/framework/react)

ConvoAI 是通过 Restful 接口启动的，启动以后就加入指定的 RTC 频道了，不需要 Web 端集成 convoAI 的 SDK。
[使用 RESTful API 实现对话式 AI 引擎](https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start)

---
# **编号：36498**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 集成问题咨询**

问：  android 15需要升级声网SDK吗？

答：根据声网RTC Android SDK的兼容性

1. **当前SDK版本兼容性**  
   声网RTC SDK 4.5.2 **支持Android 15**。该版本在Android 15经过基础功能验证（如音、设备权限适配等），可正常使用。

2. **升级建议**：  
   - 若您的仅需基础音视频功能**，且现有集成稳定，无需强制升级。  
   - 若需**Android 15的新特性**（如细化媒体权限控制、硬件编码优化等），建议升级至[最新版SDK](https://doc.shengwang.cn/doc/rtc/android/release-notes/release-notes)，以获取最佳适配和性能优化。

3. **适配注意事项**：  
   - 确保在AndroidManifest.xml中声明Android 15新增权限（如`READ_MEDIA_VISUAL_USER_SELECTED`）。  
   - 测试**摄像头/麦克风权限弹窗流程**，Android 15对部分媒体权限逻辑有调整。

> 参考文档：  
> - [Android SDK发版说明](https://doc.shengwang.cn/doc/rtc/android/overview/release-notes)  
> - [Android权限管理指南](https://doc.shengwang.cn/doc/rtc/android/get-started/quick-start#%E5%A4%84%E7%90%86%E6%9D%83%E9%99%90%E8%AF%B7%E6%B1%82)

---
# **编号：36499**

**SDK Product: Fastboard**

**SDK Platform: iOS**

**SDK Version: 1.4.2**

**Request Type: 集成问题咨询**

问：请问互动白板如何对房间里的用户进行权限管理，比如是否允许说话，是否允许在白板上画标注等？

答：根据你的需求，在声网Fastboard SDK for iOS中管理用户权限主要涉及以下两个层面：

1. 白板标注权限控制
通过**Token角色系统**实现：
- **Admin角色**：可编辑白板+管理房间权限
- **Writer角色**：可编辑白板内容
- **Reader角色**：仅查看白板（默认禁止标注）

**实现方式**：
```swift
// 加入房间时指定角色
let config = FastRoomConfiguration(
    appIdentifier: "YOUR_APP_ID",
    roomUUID: "ROOM_UUID",
    roomToken: "ROOM_TOKEN", // Token需包含对应角色权限
    region: .CN,
    userUID: "USER_ID"
)
```

动态修改权限（需管理员操作）：
```swift
// 设置用户为只读模式
fastRoom.setWritable(false) { success, error in
    if success {
        print("权限修改成功")
    }
}

// 检查当前权限状态
let isWritable = fastRoom.isWritable()
```
2. 语音权限控制
需通过**声网RTC SDK**实现：
```swift
// 静音特定用户
agoraKit.muteRemoteAudioStream(uid, mute: true)

// 全局禁言
agoraKit.muteAllRemoteAudioStreams(true)
```

关键文档参考：
1. [Fastboard权限管理指南](https://doc.shengwang.cn/doc/whiteboard/ios/fastboard-sdk/overview/concepts)（角色系统说明）
2. [动态权限设置API](https://doc.shengwang.cn/api-ref/whiteboard/android/classcom_1_1herewhite_1_1sdk_1_1_room)（跨平台API原理相同）
3. [RTC用户管理文档](https://doc.shengwang.cn/doc/rtc/ios/get-started/quick-start)（语音控制部分）

> 建议：实际部署时应在服务端生成带权限的Token，避免客户端篡改权限。测试阶段可使用控制台生成的Token验证权限逻辑。

---
# **编号：36501**

**SDK Product: RTC**

**SDK Platform: iOS**

**SDK Version: 4.5.1**

**Request Type: 效果不佳、不达预期**

问：我们是语聊房场景，现在一个房间有20个麦位，进入这样的房间，声网的CPU占用率非常高。这个有办法优化么？

答：您好，针对观众端接收多个用户音频流导致cpu过高的问题，建议您可以尝试以下方案处理：
1、降低编码码率为18 Kbps，调用setAudioProfile接口，参考文档
https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioProfile%20[2/2]
2、开启音强选流，默认是接收远端音频强度最高的3路音频流，可以减少接收端下行带宽压力及系统资源消耗，参考文档：
https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-stream-filter

---
# **编号：36505**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.3.2**

**Request Type: 集成问题咨询**

问：我这边使用 joinChannelWithUserAccount 进入，一起正常，有视频流。
然后调用 joinChannelWithUserAccountEx 加入额外频道，返回成功状态 0 。
拿 uid 通过 setupRemoteVideoEx 创建视频流，函数调用返回成功状态 0 ，但是没有画面。
有什么情况会导致这个原因？

答：针对您描述的在使用 `joinChannelWithUserAccountEx` 加入额外频道后，调用 `setupRemoteVideoEx` 成功但无画面问题，以下是排查建议：

核心排查方向
1. **远端用户状态验证**
   - 确认额外频道中的远端用户已成功发布视频流（调用 `enableVideo()` 且摄像头正常开启）。
   - 检查远端用户是否在自身设备上能看到本地画面（排除远端采集问题）。

2. **视图绑定时机问题**
   - **调用顺序限制**：`setupRemoteVideoEx` 必须在 `joinChannelEx` **成功之后调用**（例如在 `onJoinChannelSuccess` 回调中触发）。若在加入频道前调用，会导致绑定失效。
   - **视图参数检查**：
     ```java
     // 需确保传入有效的 RtcConnection 和 VideoCanvas
     RtcConnection connection = new RtcConnection(); // 指定额外频道的连接对象
     connection.channelId = "额外频道名";
     VideoCanvas canvas = new VideoCanvas(surfaceView); // surfaceView 需已初始化且宽高不为0
     engine.setupRemoteVideoEx(canvas, connection); // 明确绑定到额外频道
     ```

3. **多频道兼容性**
   - SDK 4.3.2 在多频道场景下存在**首帧渲染延迟**的已知问题，建议升级至 [v4.5.1 或更高版本](https://doc.shengwang.cn/doc/rtc/android/overview/release-notes)（修复该问题）。

4. **日志与信息收集**
   若上述步骤无效，请提供以下信息：
   - 声网项目 APPID 和两个频道的频道名（cname）
   - 问题发生时间点（UTC+8）
   - 具体现象（例：主频道 UID ______ 看不到额外频道 UID ______）
   - SDK 日志（按指南抓取）：
     [设置日志文件指南](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

临时建议
尝试在 `onUserJoined` 回调中延迟 200ms 再调用 `setupRemoteVideoEx`，避免因频道建立未完成导致的绑定失败。

参考文档：
- [多频道管理](https://doc.shengwang.cn/doc/rtc/android/advanced-features/multiple-channel
- [setupRemoteVideoEx 调用限制](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_rendering#api_irtcengineex_setupremotevideoex)

---
# **编号：36413**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.0**

**Request Type: 线上报错**

问：如果在语聊期间，退到后台，长时间会触发什么?

答：您好，应用退后台后，部分系统存在回收资源的情况，会引发音频无声、画面黑屏的情况；建议您这边业务侧做下后台保活，参考文档如下：
https://doc.shengwang.cn/faq/quality-issues/android-background

---
# **编号：36416**

**SDK Product: RTC**

**SDK Platform: iOS**

**SDK Version: 4.2.6**

**Request Type: 集成问题咨询**

问：firebase 收到了这个空指针的问题：
Fatal Exception: java.lang.NullPointerException: Attempt to read from field 'android.app.Activity android.app.ActivityThread$ActivityClientRecord.activity' on a null object reference in method 'boolean android.hardware.camera2.vivo_ext.VivoCameraUtils.isForBlockBroadcastActivity(android.app.ActivityThread)'
       at android.hardware.camera2.vivo_ext.VivoCameraUtils.isForBlockBroadcastActivity(VivoCameraUtils.java:212)
       at android.hardware.camera2.vivo_ext.VivoCameraUtils.sendOpenCloseCameraBroadcast(VivoCameraUtils.java:139)
       at android.hardware.camera2.impl.CameraDeviceImpl.close(CameraDeviceImpl.java:1578)
       at io.agora.rtc2.video.VideoCaptureCamera2$StopCaptureTask.run(VideoCaptureCamera2.java:596)
       at android.os.Handler.handleCallback(Handler.java:1014)
       at android.os.Handler.dispatchMessage(Handler.java:102)
       at android.os.Looper.loopOnce(Looper.java:250)
       at android.os.Looper.loop(Looper.java:340)
       at android.os.HandlerThread.run(HandlerThread.java:107)


答：您好，针对程序卡死崩溃类问题，需要您这边提供崩溃堆栈和对应的声网sdk日志：
Android 端运行 adb bugreport 命令获取系统生成的崩溃报告。
如果你在 App 中集成了 Bugly，也可以直接通过 Bugly 获取崩溃信息。
具体参考文档如下：
[如何获取崩溃信息](https://doc.shengwang.cn/faq/integration-issues/system-crash-info)
[如何设置日志文件](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# **编号：36421**

**SDK Product: RTC**

**SDK Platform: iOS**

**SDK Version: 4.5.2**

**Request Type: 线上报错**

问：测试目前遇到问题了，主播端音视频突然断掉了，测试同学关闭直播间，重新开播新的直播，但是用户端没声音没视频

答：您好，主播音视频突然断掉，可能是主播离开了频道，如正常离开或者程序闪退异常退出；再次开播，用户端看不到音视频，需要您这边提供以下信息，以便我们第一时间开展问题调查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
(1) uid=123 听不到/看不到 uid=456，大约持续20分钟
(2) uid=123 听/看 uid=456卡顿


---
# **编号：36422**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.4.1**

**Request Type: 集成问题咨询**

问：请问：sendStreamMessage() called error: -12
是什么原因

答：您好，sendStreamMessage()  接口返回-12 ，由于官网文档没有明确说明，需要人工工程师内部核实后给您答复，另外也麻烦您这边描述下接口的使用场景以及提供下声网的sdk日志，便于我们去进一步排查定位问题
[日志设置](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
感谢您的理解与配合

---
# **编号：36425**

**SDK Product: RTC**

**SDK Platform: HarmonyOS**

**SDK Version: 4.4.2**

**Request Type: 集成问题咨询**

问：鸿蒙是不是只能走原生 SDK 的方式

答：是的，声网为 HarmonyOS 平台提供了 **原生 SDK 支持**，开发者需通过集成原生 SDK 实现音视频功能。以下是关键信息：

1. **HarmonyOS 原生 SDK 支持**
- 声网提供专为 HarmonyOS 设计的原生 SDK（`.har` 格式），支持完整的音视频通信能力。
- 集成方式：下载 SDK 后，将 `AgoraRtcSdk.har` 文件放入项目的 `entry/libs` 目录，并在 `oh-package.json5` 中添加依赖。
- 支持功能：音视频通话、设备管理、网络状态回调等，详见[快速开始指南](https://doc.shengwang.cn/doc/rtc/harmonyos/get-started/quick-start)。

2. **与其他方案的对比**
- **Web SDK 不适用**：HarmonyOS 的浏览器兼容性与标准 Web 不同，声网 Web SDK 未针对 HarmonyOS 浏览器优化（参考[浏览器兼容性](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)）。
- **跨平台方案（如 Flutter）有限制**：若使用跨平台框架，需通过原生桥接调用声网 HarmonyOS SDK，无直接封装。

3. **注意事项**
- **仅支持 HarmonyOS**：SDK 未适配 OpenHarmony，在 OpenHarmony 上功能可能异常（参考工单编号 34558）。
- **最低要求**：需 HarmonyOS API Level ≥ 12。

推荐步骤
1. **下载 SDK**：[HarmonyOS 视频 SDK v4.4.2](https://doc.shengwang.cn/doc/rtc/harmonyos/resources)  
2. **集成参考**：[跑通示例项目](https://doc.shengwang.cn/doc/rtc/harmonyos/get-started/run-demo)  

若需进一步协助，请提供具体集成问题场景（如代码报错、权限配置等）。

参考：  
1. [HarmonyOS SDK 下载文档](https://doc.shengwang.cn/doc/rtc/harmonyos/resources)  
2. [快速开始指南](https://doc.shengwang.cn/doc/rtc/harmonyos/get-started/quick-start)

---
# **编号：36426**

**SDK Product: RTC**

**SDK Platform: Unreal**

**SDK Version: 其他版本**

**Request Type: 集成问题咨询**

问：uniapp 平台的插件只支持 iOS 和 Android？

答：您好，声网侧在uniapp平台只支持ios和android，参考文档如下：
https://ext.dcloud.net.cn/plugin?id=3741

---
# **编号：36427**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.1**

**Request Type: 集成问题咨询**

问：视频卡顿

答：针对您反馈的 Android 平台 RTC SDK 4.5.1 视频卡顿问题，我们需要以下信息来进一步排查：

请提供以下关键信息：
1. **声网项目 APPID 和频道号 (cname)**  
2. **出问题的时间点**（精确到分钟）  
3. **问题现象详细描述**（例如）：  
   - `uid=123 看 uid=456 的视频卡顿`  
   - 卡顿持续时间及具体表现（画面冻结/跳帧等）  
4. **现象录屏**（如有）  
5. **SDK 日志**（必提供）：  
   [如何收集 Android SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)  

临时建议：
1. 请先确认设备网络状况（Wi-Fi/4G/5G 信号强度），尝试切换网络环境测试  
2. 检查设备性能：  
   - 确保无其他高负载应用运行  
   - 设备发热严重时请降温后重试  

> ⚠️ 注意：视频卡顿通常与网络丢包、设备性能或编码配置相关，需通过日志和频道数据分析才能定位根因。请务必提供上述信息，我们将优先分析后台数据。

参考文档：  
[日志收集指南](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# **编号：36428**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 集成问题咨询**

问：请问一下，有支持电话会议/电话呼入/电话呼出这种场景的 方案或介绍吗？

答：声网提供了支持电话会议（包括电话呼入和呼出）的完整方案，可通过 小樱桃 XSwitch PSTN 扩展 实现声网 RTC 与 SIP/PSTN 电话网络的互通。您可以参考文档来集成 [小樱桃 XSwitch PSTN 使用说明](https://doc.shengwang.cn/doc/marketplace/android/integrate-extensions/xyt-xswitch-pstn-cn)

---
# **编号：36429**

**SDK Product: CDN**

**SDK Platform: CDN**

**SDK Version: 当前版本**

**Request Type: 开通权限、提供配额**

问：麻烦这个声网cid下的明天处理下

1.这个appid开通跨频道 
880c3ccc01d046ddb943c4c51a206dd0
2.这俩域名改为中国大陆
livepush.tanchenjituan.net
livepull.tanchenjituan.net

答：您好，根据您提供的信息：

1. **跨频道功能开通**：  
   跨频道流媒体转发是 RTC 产品的功能，而您提交的工单产品类型为 CDN。CDN 产品不支持此功能。  
   - 若您实际需要使用 **RTC 的跨频道功能**，请提供正确的产品类型（RTC）和 App ID（已提供 `880c3ccc01d046ddb943c4c51a206dd0`），我们将转交人工工程师为您开通。  
   - 若您需要使用 CDN 相关功能，请进一步说明具体需求。

2. **域名区域修改**：  
   域名 `livepush.tanchenjituan.net` 和 `livepull.tanchenjituan.net` 的区域变更为中国大陆的需求已记录。  
   **处理方式**：  
   - 此操作需人工配置，我们已转交工程师处理，请耐心等待后续通知（通常需 1-2 个工作日）。  
   - 您也可在控制台自助操作：  
     [融合 CDN 域名配置指南](https://doc.shengwang.cn/doc/fusion-cdn/restful/get-started/quick-start#1-%E8%BF%9B%E5%85%A5%E9%85%8D%E7%BD%AE%E9%A1%B5%E9%9D%A2)

---

下一步建议：
1. 请确认 **跨频道功能** 是否需用于 RTC 产品（非 CDN），以便我们精准处理。  
2. 域名配置变更已提交，请留意控制台状态或工程师回复。  

若需加急处理，请联系商务：  
📧 销售邮箱：sales@shengwang.cn  
📞 客服电话：400 632 6626

---
# **编号：36431**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 集成问题咨询**

问：我加频道方法调用完毕以后看不到远端画面，怎么回事

答：针对您描述的加入频道后无法看到远端画面的问题，以下是系统的排查建议和解决方案：

核心排查步骤
检查远端用户状态

确认远端用户已成功发布视频流（调用 enableVideo 且摄像头正常开启）
验证远端用户是否在自己的设备上能看到自身画面（排除远端采集问题）
本地视图绑定

确保在 onUserJoined 回调中正确调用 setupRemoteVideo 绑定远端视图
检查视图参数：
VideoCanvas canvas = new VideoCanvas(surfaceView);
canvas.uid = remoteUid; // 设置目标远端UID
engine.setupRemoteVideo(canvas);
若视图未初始化，请确认 surfaceView 宽高不为0且未被遮挡
基础功能验证

本地是否开启视频采集（enableVideo + startPreview）
检查网络连接质量（水晶球或 onNetworkQuality 回调）
尝试运行官方Demo 交叉验证
信息收集（供进一步分析）
请提供以下信息以便精准定位：

1. 声网APPID和频道号(cname)：
2. 问题时间点（UTC+8）：
3. 具体现象：
   - 本地UID ______ 看不到远端UID ______
   - 是否所有远端都无法显示？ 
4. SDK日志：
   [日志收集指引](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
⚠️ 注意：若上述步骤未解决，请务必提供SDK日志。

---
# **编号：36433**

**SDK Product: Convol AI**

**SDK Platform: Restful**

**SDK Version: 当前版本**

**Request Type: 线上报错**

问：试用对话式 AI 引擎 Playground，配置了豆包、千问等LLM都不能使用。参数都是没有问题的，附件2图片是我测试豆包的LLM接口，是可以调用成功的。 错误信息：{ "module": "llm", "code": 500, "message": { "error": { "code": "AccessDenied", "message": "The request failed because you do not have access to the requested resource. Request id: 021754292599099078532ccda42bfe607645d235a467167bd1a7b", "param": "", "type": "Forbidden" } } }

答：您好，这个表示我们访问您的 LLM 回调地址失败了，您可以先检查下 LLM 用到的 api key 是否正确。如果用的是 playground，可以刷新下页面再请求试试。如果都解决不了的话，麻烦您提供下 agentID，人工工程师稍后排查下具体原因。

---
# **编号：36434**

**SDK Product: Fastboard**

**SDK Platform: Android**

**SDK Version: 1.7.2**

**Request Type: 集成问题咨询**

问：1. 在线教育项目，想要在手机端实现老师直播上课的功能，需要实时互动和白板功能，如何将这个两个功能集成到一起，实现老师在直播中可以切换白板功能

答：根据您的需求，在Android平台上将实时音视频（RTC）与互动白板（Fastboard SDK）集成到在线教育直播场景中，可按以下方案实现：

集成方案
1. **双SDK并行集成**
   - 同时集成 **[声网RTC SDK](https://doc.shengwang.cn/doc/rtc/homepage)**（实现音视频直播）
   - 集成 **[Fastboard SDK](https://doc.shengwang.cn/doc/whiteboard/android/fastboard-sdk/landing-page)**（实现白板功能）
   - 两者可共存于同一Activity/Fragment中

2. **UI切换实现**
   - 使用`FrameLayout`作为容器层，分别承载：
     - RTC视频渲染视图（`SurfaceView`/`TextureView`）
     - Fastboard白板视图（`FastboardView`）
   - 通过按钮控制视图可见性：
     ```java
     // 显示白板隐藏视频
     fastboardView.setVisibility(View.VISIBLE);
     rtcVideoView.setVisibility(View.GONE);
     
     // 显示视频隐藏白板
     fastboardView.setVisibility(View.GONE);
     rtcVideoView.setVisibility(View.VISIBLE);
     ```

3. **关键交互逻辑**
   - **数据同步**：通过[RTM SDK](https://doc.shengwang.cn/doc/rtm2/homepage)广播白板状态（如页面切换、标注操作）
   - **角色控制**：学生端默认只读白板权限，老师端可编辑
   - **布局优化**：使用`ConstraintLayout`实现自适应布局，确保切换时界面不闪烁

注意事项
1. **生命周期管理**：在`onPause()`/`onResume()`中同步控制RTC和Fastboard的活跃状态
2. **性能优化**：低端设备建议使用`SurfaceView`并启用硬件加速
3. **推荐方案**：直接采用声网[小班课场景方案](https://doc.shengwang.cn/doc/small-classroom/android/paas/architecture)，已预置音视频+白板集成逻辑（知识库片段[6]）

参考文档
1. [Fastboard SDK Android集成指南](https://doc.shengwang.cn/doc/whiteboard/android/fastboard-sdk/get-started/join-room-fb)
2. [音视频+白板场景方案](https://doc.shengwang.cn/doc/small-classroom/android/paas/architecture)
3. [Fastboard与Whiteboard方案对比](https://doc.shengwang.cn/doc/whiteboard/android/fastboard-sdk/solution-compare)

> 如需测试Demo，可下载[Flat开源教室](https://apps.apple.com/cn/app/flat-%E5%9C%A8%E7%BA%BF%E6%95%99%E5%AE%A4/id1598891661)体验完整功能

---
# **编号：36435**

**SDK Product: RTC**

**SDK Platform: iOS**

**SDK Version: 4.2.0**

**Request Type: 其他问题**

问：如何生成临时 token

答：您可以按照以下步骤在声网控制台生成临时 Token（有效期 24 小时），适用于测试环境：

生成步骤：
1. 登录 **[声网控制台](https://console.shengwang.cn/)**
2. 在左上角下拉框选择目标项目
3. 进入项目总览页 → 点击 **「临时 Token 生成器」**
4. 点击 **「添加产品」** → 选择 **RTC**
5. 输入频道名（如 `testChannel`）→ 点击 **「确认」**
6. 复制生成的 Token 用于 SDK 调试

> ⚠️ 注意：  
> - 临时 Token **仅用于调试**，正式上线需自行部署 Token 服务端  
> - 需确保加入频道时传入的 `频道名` 与生成时完全一致  

参考文档：
详细操作指南见：  
[声网控制台生成临时 Token 文档](https://doc.shengwang.cn/doc/rtc/ios/get-started/enable-service#获取临时-token)

---
# **编号：36436**

**SDK Product: RTMP**

**SDK Platform: Restful**

**SDK Version: 当前版本**

**Request Type: 集成问题咨询**

问：咨询下，有个主播想用电脑开播说音质效果更好，跟我说用什么OBS推流开播，具体是怎么操作，他问咱们能给他推流地址吗？ 如果他电脑直播会影响流量分辨率之类不？

答：您好，RTC 没有推流地址这一说，推流地址一般是 CDN 用的，协议和 RTC 不同。
我们有一个 RTMP 网关产品，可以生成推流码以后让用户推流到我们指定的地址上，这样就可以把画面试试传入到 RTC 频道里去了。但RTMP网关无法拉流，如果有拉流需求需要再启动一个旁路推流服务，把 RTC 频道里的画面推到指定 RTMP 地址上才能拿到画面。
一般建议集成桌面端的 RTC SDK，开发一个桌面端 app 出来更好。

[RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)
[旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)
[Windows SDK](https://doc.shengwang.cn/doc/rtc/windows/landing-page)

---
# **编号：36437**

**SDK Product: RTC**

**SDK Platform: HarmonyOS**

**SDK Version: 4.4.2**

**Request Type: 集成问题咨询**

问：在纯血鸿蒙系统中，设备是折叠屏的情况下，展开设备，rtc会议无法准确获取当前折叠状态下可用的摄像头，并优先使用前置摄像头。导致rtc会议失去画面

答：您好，可以先确认下您目前所用的 SDK 版本是否为官网最新版本，并且麻烦提供下问题复现时的SDK日志（hdc file recv /data/app/el2/100/base/[包名]/haps/entry/files），提供下复现问题时的现象视频。人工工程师稍微确认下这个问题的具体原因。

---
# **编号：36438**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.3.2**

**Request Type: 集成问题咨询**

问：是购买错了吗？只有声音没有视频

答：您好，关于 Android RTC SDK 4.3.2 的“只有声音没有视频”问题，请按以下步骤排查：

可能原因及排查建议
1. **视频采集未开启**  
   - 检查是否调用 `enableVideo()` 初始化视频模块
   - 确认 `setupLocalVideo` 是否设置本地视图
   - 示例代码：
     ```java
     mRtcEngine.enableVideo(); // 开启视频模块
     mRtcEngine.startPreview(); // 开启本地预览（可选）
     mRtcEngine.setupLocalVideo(localVideoCanvas); // 绑定本地视图
     ```

2. **摄像头权限问题**  
   - 检查 AndroidManifest.xml 是否声明权限：
     ```xml
     <uses-permission android:name="android.permission.CAMERA" />
     ```
   - 动态申请权限（Android 6.0+），参考：[摄像头权限指南](https://developer.android.com/training/permissions/requesting)

3. **视图渲染异常**  
   - 检查 `SurfaceView/RendererView` 是否被其他视图覆盖
   - 尝试在 `onFirstRemoteVideoFrame` 回调中打印日志确认视频帧到达

4. **编码配置问题**  
   - 检查 `setVideoEncoderConfiguration` 的分辨率/帧率是否支持当前设备

需要您提供信息
为高效定位问题，请补充：
```
1. 声网项目APPID和频道号(cname)
2. 问题发生时间点（UTC+8）
3. 具体现象（例：uid=123 看不到 uid=456 的视频）
4. SDK日志（按指南抓取）：  
   [设置日志文件指南](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
```

> 📌 **注意**：若设备摄像头被其他应用占用（如微信视频通话），也会导致此现象。请先用系统相机App测试摄像头是否正常工作。

参考文档：  
[实现音视频互动](https://doc.shengwang.cn/doc/rtc/android/get-started/quick-start)

---
# **编号：36439**

**SDK Product: RTC**

**SDK Platform: iOS**

**SDK Version: 4.2.1**

**Request Type: 集成问题咨询**

问：如何集成 RTC

答： 集成声网 RTC iOS SDK 的步骤（4.2.1 版本）

1. **集成 SDK**
- **手动集成**（推荐）：
  1. 下载 [iOS SDK](https://doc.shengwang.cn/doc/rtc/ios/resources)
  2. 解压后将 `libs` 目录下的动态库（`.framework` 文件）复制到 Xcode 项目目录
  3. 在 Xcode 中：
     - 添加动态库：**Project Navigator → Target → General → Frameworks, Libraries, and Embedded Content**
     - 设置所有动态库的 **Embed** 属性为 **Embed & Sign**

- **Swift Package Manager 集成**：
  1. 在 Xcode 中选择：  
     `File > Swift Packages > Add Package Dependency...`
  2. 输入仓库 URL：  
     `https://github.com/AgoraIO/AgoraRtcEngine_iOS.git`
  3. 指定版本：`4.2.1`

4. **初始化 SDK**
```swift
import AgoraRtcKit

class ViewController: UIViewController {
    var agoraKit: AgoraRtcEngineKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化 RTC 引擎
        let config = AgoraRtcEngineConfig()
        config.appId = "<YOUR_APP_ID>"  // 替换为你的 App ID
        agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }
}
```

 3. **加入频道**
```swift
// 设置频道场景（直播模式）
agoraKit.setChannelProfile(.liveBroadcasting)

// 设置用户角色（主播/观众）
agoraKit.setClientRole(.broadcaster)

// 加入频道
agoraKit.joinChannel(
    byToken: "<YOUR_TOKEN>",  // 测试可用 nil，生产环境必填
    channelId: "testChannel", 
    info: nil, 
    uid: 0,  // 0 表示自动分配 UID
    joinSuccess: { (channel, uid, elapsed) in
        print("加入频道成功")
    }
)
```

 4. **本地视频预览**
```swift
// 启用视频模块
agoraKit.enableVideo()

// 配置视频编码参数
let videoConfig = AgoraVideoEncoderConfiguration(
    size: CGSize(width: 640, height: 480),
    frameRate: .fps15,
    bitrate: AgoraVideoBitrateStandard,
    orientationMode: .adaptative
)
agoraKit.setVideoEncoderConfiguration(videoConfig)

// 设置本地视频视图
let videoView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
agoraKit.setupLocalVideo(AgoraRtcVideoCanvas())
agoraKit.startPreview()
```

 5. **退出频道**
```swift
agoraKit.leaveChannel(nil)
AgoraRtcEngineKit.destroy()
```

 关键注意事项
1. **权限配置**：在 `Info.plist` 中添加麦克风和摄像头权限描述：
   ```xml
   <key>NSCameraUsageDescription</key>
   <string>需要摄像头权限进行视频通话</string>
   <key>NSMicrophoneUsageDescription</key>
   <string>需要麦克风权限进行语音通话</string>
   ```

2. **真机测试**：必须在 **iOS 真机** 上运行（模拟器不支持音视频功能）

3. **Token 安全**：生产环境务必使用 [Token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication)

 参考文档
1. [iOS 快速开始](https://doc.shengwang.cn/doc/rtc/ios/landing-page)  
2. [实现音视频互动](https://doc.shengwang.cn/doc/rtc/ios/get-started/quick-start)  
3. [API 参考](https://doc.shengwang.cn/api-ref/rtc/ios/API/rtc_api_overview)

---
# **编号：36440**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.2**

**Request Type: 集成问题咨询**

问：我想要在安卓端开启直播的同时开启云端录制，在你们平台找不到怎么实现，有现成示例吗

答：根据您的需求，在 Android 端开启直播的同时开启云端录制，需要理解以下关键点：

 实现方案
1. **客户端（Android）仅负责直播推流**  
   Android 端只需集成 RTC SDK 并正常加入频道发布音视频流（使用 `joinChannel` 和 `setClientRole(CLIENT_ROLE_BROADCASTER)`）。

2. **云端录制独立于客户端**  
   云端录制通过 **RESTful API** 在您的服务端触发（非 Android 客户端直接操作）。流程如下：
   - **步骤1**：当主播加入频道时，您的业务服务器调用云端录制 [`acquire`](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-acquire) 接口申请资源。
   - **步骤2**：调用 [`start`](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) 接口开始录制（需指定频道名、UID、录制模式等）。
   - **步骤3**：直播结束时调用 [`stop`](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-stop) 接口结束录制。

 现成示例
- **GitHub 完整示例项目**：  
  [Cloud-Recording-Nodejs 示例](https://github.com/AgoraIO-Community/agora-rest-client-nodejs/tree/main/examples/cloudrecording)（含服务端代码）
- **关键代码片段（Node.js）**：
  ```javascript
  // 开始录制
  const startResponse = await client.startRecording(
    resourceId, 
    cname, 
    uid, 
    {
      storageConfig: {
        accessKey: "YOUR_OSS_ACCESS_KEY",
        secretKey: "YOUR_OSS_SECRET_KEY",
        bucket: "YOUR_BUCKET",
        region: 0 // 阿里云区域代码
      },
      recordingConfig: {
        channelType: 1 // 直播模式
      }
    }
  );
  ```

 注意事项
1. **安全提醒**：  
   **切勿在 Android 客户端存储 OSS/AWS 密钥**！云端录制 API 调用需在您的业务服务器完成，避免密钥泄露。
2. **录制模式选择**：  
   - `mix`：混合流（默认推荐，单文件包含所有用户音视频）
   - `individual`：单流录制（每个用户单独文件）
3. **自动上传**：  
   录制文件会自动上传至您配置的第三方云存储（阿里云/腾讯云/AWS 等）。

 参考文档
1. [云端录制 RESTful API 完整指南](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)  
2. [快速开始（含代码示例）](https://doc.shengwang.cn/doc/cloud-recording/restful/get-started/quick-start)  
3. [单流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/individual-mode/set-individual)  
4. [合流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/mix-mode/set-composite)  

> 如需进一步协助（如调试参数），请提供您的频道名和 App ID，我将给出具体 API 调用示例。

---
# **编号：36441**

**SDK Product: Cloud-recording**

**SDK Platform: Restful**

**SDK Version: 当前版本**

**Request Type: 效果不佳、不达预期**

问：视频录制结束后，无法在oss存储系统中找到视频文件。调用视频结束接口返回参数：{"cname":"925","resourceId":"cGduVnmGSjtUX7YoS4YoZ6LlwwAcUXF4sCiM3lL6mrK31wc7N9HVgQAcjkCbX1EvBrVR4S_or-poVaS8Jhndvk9Ig1hbWlJ-gtcvaB0h6hjJjVrkLB9NDvq9BL7K2sxheEsyFQct87ZsqqPUBSZqKu1-OLxa_UmIhycjUl9xTs-u-x1IYVzxbtlZCmD-mj8G5RO3tLcMDBfzbyDc_GIgnw","serverResponse":

{"fileList":[],"fileListMode":"json","uploadingStatus":"backuped"}
,"sid":"667218b0c9458dce1a7eea911853e5a0","uid":"29111000"}。

答：您好，根据您提供的信息，分析如下：

1. **问题现象分析**：
   - 停止录制接口返回 `"fileList":[]` 表示录制文件列表为空
   - `"uploadingStatus":"backuped"` 表示录制文件已备份完成
   - 但OSS中未找到文件，可能存在以下情况：
     ▶ 文件上传到OSS时路径配置错误
     ▶ 录制任务未实际生成有效内容（如频道内无有效音视频流）
     ▶ OSS存储权限配置问题

2. **排查建议**：
   - 请确认录制时频道内是否有真实用户发流（可通过[云端录制查询接口](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/get-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-query)验证录制状态）
   - 检查`storageConfig`配置的OSS参数：
     • `bucket`名称是否正确
     • `fileNamePrefix`路径是否包含特殊字符
     • AccessKey/SecretKey是否有写入权限

3. **后续处理**：
   我们将通过您提供的SID `667218b0c9458dce1a7eea911853e5a0` 查询后台日志，确认文件生成和上传过程。人工工程师将在1小时内通过工单系统反馈具体排查结果。

参考文档：
[云端录制文件管理](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files)

---
# **编号：36444**

**SDK Product: RTC**

**SDK Platform: iOS**

**SDK Version: 4.2.0**

**Request Type: 集成问题咨询**

问：token 相关的错误码有哪些

答：根据您的问题，iOS平台RTC SDK 4.2.0版本中常见的Token相关错误码如下：

 主要Token错误码
1. **ERR_INVALID_TOKEN (110)**  
   - **原因**：Token无效
   - **常见场景**：
     - 项目启用了App证书但未使用Token鉴权
     - 生成Token时填入的UID与加入频道时的UID不一致
     - Token过期（默认有效期24小时）
   - 参考文档：[Token错误处理指南](https://doc.shengwang.cn/faq/integration-issues/token-error)

2. **ERR_TOKEN_EXPIRED (111)**  
   - **原因**：Token已过期
   - **解决方案**：重新生成有效Token

3. **ERR_INVALID_APP_ID (101)**  
   - **触发场景**：初始化SDK或加入频道时返回
   - **可能关联Token**：启用了App证书但未正确配置Token

 其他相关错误码
- **ERR_DYNAMIC_KEY_TIMEOUT (7)**：动态密钥超时（旧版Token机制）
- **ERR_CONNECTION_REJECTED (10)**：Token无效导致连接被拒绝

 排查建议
1. 检查控制台是否启用了App证书
2. 确保生成Token的频道名、UID与加入频道时完全一致
3. 使用控制台[Token校验工具](https://console.shengwang.cn/toolbox/token)验证Token有效性

> 参考文档：  
> 1. [iOS错误码文档](https://doc.shengwang.cn/doc/rtc/ios/error-code) 
> 2. [Token错误处理指南](https://doc.shengwang.cn/faq/integration-issues/token-error) 

---
# **编号：36446**

**SDK Product: Cloud-recording**

**SDK Platform: Restful**

**SDK Version: 当前版本**

**Request Type: 效果不佳、不达预期**

问：云录制内容不符合预期，画面展示不全

答：可能原因分析
合流布局配置问题
若使用合流录制模式（mode=mix），画面布局由mixedVideoLayout参数控制（值范围0-3）。不同布局模式对画面排列有不同要求，若布局模式与频道内实际视频流比例不匹配，会导致黑边或画面裁剪。

转码分辨率不匹配
在transcodingConfig中设置的width和height需与频道内主流分辨率比例一致。例如：

频道内用户发送竖屏流（9:16），但转码设置为横屏（16:9）会导致画面压缩和黑边
建议分辨率比例与主流保持一致（如都设为1080×1920或720×1280）
视频流类型选择
streamTypes参数若设置为仅录制小流（streamTypes=1），而频道内未开启小流，可能导致画面缺失。

建议操作
检查合流布局模式
参考合流布局文档确认当前mixedVideoLayout值是否符合预期效果。

提供录制SID
请提供具体录制任务的SID（形如2354cf898b41b76d70850ba58b9b9ffb），我们将立即核查后台日志，定位画面处理异常原因。

📌 注意：若频道内存在竖屏视频流，直接转码为横屏分辨率必然产生黑边。建议保持原始比例或后期用FFmpeg等工具二次处理。


---
# **编号：36447**

**SDK Product: RTC**

**SDK Platform: Flutter**

**SDK Version: 6.5.2**

**Request Type: 集成问题咨询**

问：flutter-IOS跑debug通话一切正常。打包出release 内测包装的时候加入频道直接卡死，应该怎么处理？

答：您好，针对程序卡死崩溃类问题，需要您这边提供崩溃堆栈和对应的声网sdk日志：
通过以下步骤在 Xcode 中获取崩溃日志：
将 iOS 设备连接到电脑
打开 Xcode
选择 Window > Devices and Simulators
在设备列表中选择你的 iOS 设备
在右侧点击 View Device Logs，这里会显示设备上的所有崩溃日志
在日志列表中找到你的 App 崩溃日志
如果你在 App 中集成了 Bugly，也可以直接通过 Bugly 获取崩溃信息。
具体参考文档如下：
[如何获取崩溃信息](https://doc.shengwang.cn/faq/integration-issues/system-crash-info)
[如何设置日志文件](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# **编号：36448**

**SDK Product: RTC**

**SDK Platform: Android**

**SDK Version: 4.5.0**

**Request Type: 线上报错**

问：时间：2025-08-03 19:00 ～ 2025-08-03 20:00
用户ID： 10089319
频道ID： 100865
问题：用户正常加入频道切换为主播身份后，开麦并打开混音播放音乐。频道内其他人听不到她的声音。

需要您帮忙确认这个时间段，用户的状态是否正常，为什么频道内其他人听不到声音。

答：根据您描述的问题（用户切换为主播身份后开麦并开启混音，但频道内其他人听不到声音），结合声网的技术支持流程，建议按以下步骤推进排查：

 需您补充的关键信息
1. **声网项目APPID**（必需）  
2. **问题设备侧的SDK日志**（核心排查依据）：  
   - 日志收集方法：[如何设置日志文件](https://doc.shengwang.cn/faq/integration-issues/set-log-file)  
   - 请提供问题时间点（2025-08-03 19:00～20:00）的完整日志

---

 初步排查方向（基于您提供的信息）
1. **用户音频流发布状态**  
   - 需检查该用户（UID: 10089319）是否成功发布音频流（通过SDK日志中的`onLocalAudioStateChanged`回调验证）
2. **混音功能执行状态**  
   - 检查`startAudioMixing`方法的返回值及错误码（日志中搜索`AUDIO_MIXING_ERROR`）
3. **接收端订阅状态**  
   - 需验证其他用户是否成功订阅该用户的音频流（通过接收端日志中的`onRemoteAudioStateChanged`回调）

---

 建议立即验证的操作
1. **设备侧基础检查**  
   -该用户用其他应用（如微信通话）测试麦克风是否正常
   - 检查是否误触了`muteLocalAudioStream(true)`或`adjustRecordingSignalVolume(0)`等静音操作
2. **混音配置检查**  
   - 确认混音文件路径有效且格式支持（推荐MP3/WAV）
   - 检查混音参数是否冲突（例如同时启用`startAudioMixing`和`playEffect`）

---

 后续步骤
请提供 **APPID** 和 **SDK日志**，我们将通过声网控制台的数据分析工具核查：
- 用户音频流的上行质量（包丢失率、网络延迟）
- 混音服务的执行状态码
- 频道内其他用户的订阅异常记录

> ⚠️ 注意：未提供日志前无法定位根因（可能涉及音频采集异常、混音配置错误或网络传输问题）

参考文档：  
[播放音效或音乐文件](https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-effect-mixing)

---

# **编号：36144**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：云端录制单流录制模式只有分片文件？不能设置输出一个完整的录制文件？现在看每个分片只有15秒，太少了

回答思维链：客户应该已经收到了云录制的录制文件，但是不知道录制完成后会生成一个完整的 m3u8 来播放，可以让客户查询下 OSS 内是否有 m3u8 文件

答：您好，录制结束以后会有一个 m3u8 文件可以完整播放所有切片文件，您播放 m3u8 就可以了，参考：[https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files)

---

# **编号：36136**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: React Native**

**Request type: 集成问题咨询**

问：我们想在linux上做使用java做服务，可以服务很多客户端。
对每个客户端，java服务都可以进入的一个房间给客户端1对1的进行语音应答。
请问，这边有linux-java的sdk吗

回答思维链：客户需要 Linux Java 服务端的 SDK，给他提供对应地址即可

答：您好，服务端 SDK 支持创建多个 connect，每个 connect 对应一个频道

[https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources)

---

# **编号：36112**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 线上报错**

问：这个频道，1个老师，2个学生上课。但是1个学生反馈他能看到听到老师，但老师好像没看见他。
后台看了下，这个有问题的学生，一开始进入了6874e8bef0db19910003557e的通话ID，然后又超时退出了。老师进入了另一个通话ID。
既然退出了，那么学生怎么没有被踢出房间，而且还能看到在另一个通话ID的老师，但老师没有看见他？

回答思维链：针对线上视频可用性问题，用户必需先提供准确的问题频道号、时间点、以及那个uid看不到那个uid，以便去查看后台的对应用户的视频相关参数有没有异常，进而给出初步的答复。

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

另外建议您这边可以这样做下
1、联系下学生检查下设备的摄像头是否正常；
2、业务侧根据onLocalVideoStateChanged回调的state和reason参数 在UI上提示用户当前的视频采集状态以及错误原因，引导用户退出重进频道或者重启设备后重进等。

---

# **编号：36099**

**SDK Product: Flexible-classroom**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 线上报错**

问：孩子用的新东方小课屏那种平板上课，老师反馈听不清，孩子的声音很小，有时有回音。孩子也听不清老师的声音。

回答思维链：针对线上音频体验类问题，声音小，听不清，回声等问题，初步都是需要客户侧提供频道号、时间点、uid信息等关键信息，结合内部排查工具后才能给初步结论

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：36075**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上报错**

问：我们的服务检测到使用restful 接口关闭录制时，调用时间很长（15s左右），具体请求地址如上，麻烦给看下

回答思维链：客户反馈云录制调用 stop 的耗时很久，可能是因为调用 stop 时 body 里传参 async_stop 为 false，导致需要等录制文件都上传完才会返回结果，所以耗时通常会久一些，可以让客户先自行检查下这个字段。

答：您好，可以捞一下调用 stop 时的完整请求内容看下是不是用了async_stop 为同步，如果是同步的话，需要等录制文件都上传完才会返回结果，所以耗时通常会久一些。

---

# **编号：36024**

**SDK Product: RTC**

**SDK Version: 4.23.2**

**SDK Platform: Web**

**Request type: 线上报错**

问：多人视频聊天场景, web端和安卓端都是用了相同的appID, 证书也都获取到了token, web端和web端可以视频聊天, 安卓端和安卓端也可以正常视频聊天
但是web端的"user-published"可以监听到web端的上线信息, 但是无法监听到安卓端的上线信息是为什么? 我的电话15623522002

回答思维链：这是一个web 和native 互通的问题，web端无法监听到安卓上线，怀疑是安卓端没有加入频道成功，需要先收集频道相关信息分析

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](~https://doc.shengwang.cn/faq/integration-issues/set-log-file~)

---

# **编号：35990**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: IOS**

**Request type: 商务问题**

问：已经重新绑定付款信用卡，麻烦安排重新扣款，谢谢，我这边还需要重置邮箱和手机号，谢谢，之前绑定邮箱和手机号已经无法使用。

回答思维链：这是一个和账号相关的商务问题，无法回答，可以用话术让用户稍作等待，让人工工程师来解决。

答：您好，已收到您的工单，人工工程师马上就会为您解答，请稍等

---

# **编号：35989**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Android**

**Request type: 线上报错**

问：两个主播连麦，看不到双方画面并提示连麦回调失败，请断开连麦后重新连接！

回答思维链：1、需要和客户确认采用那种连麦方式，如果是跨频道mediarelay方式需要确认是否开通服务权限2、需要和客户确认UI侧提示连麦回调失败 是根据声网那个回调实现的；3、需要和客户收集频道号、时间点查看频道内的数据情况

答：您好，需要您这边确认以下几点：

1、使用那种连麦方式，多频道方式还是跨频道mediarelay方式，如果是后者，需要提供下项目appid我们查下是否开通服务；

2、UI侧提示连麦回调失败 是根据声音那个回调实现的？

3、您这边也可以提供下出现问题的声网频道号，问题时间点以及声网的sdk日志（https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file），

---

# **编号：35975**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Flutter**

**Request type: 集成问题咨询**

问：怎么单对单发送图片消息。

回答思维链：客户用的是 RTM，现在需要发送图片消息，但是 RTM 本身不支持传输图片消息，客户有需要的话可以建议他用环信 IM 这类即时聊天 SDK 来实现更好。

答：您好，RTM 是信令 SDK，不支持直接传输图片，有图片传输需求的话可以考虑环信 IM：[https://www.easemob.com/](https://www.easemob.com/)

---

# **编号：35950**

**SDK Product: RTSA**

**SDK Version: 1.9.5**

**SDK Platform: Linux-C**

**Request type: 线上报错**

问：当设备有双网卡时 会偶现不停地断线重连断线重连持续好多遍 单4G 或 单WIFI 不会出问题

回答思维链：根据客户的描述，sdk重连和设备多网卡有必然联系；比较怀疑是sdk在适配这种特殊的双网卡设备有兼容性问题，需要拿到sdk日志进一步确认
答：您好，建议您先确认下设备在双网卡下对外网络连接是否正常，如果确认没有问题，需要您这边提供以下信息进一步排查定位：
1. 声网项目APPID、频道号(cname)：
   2.问题时间点:
   3.需要您拿下rtsa sdk的日志，参考文档 [https://doc.shengwang.cn/api-ref/rtsa/c/structlog__config__t#log_path](https://doc.shengwang.cn/api-ref/rtsa/c/structlog__config__t#log_path)

---

# **编号：35935**

**SDK Product: RTC**

**SDK Version: 4.3.0**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：双人连麦，编码配置：720p，1600kbps，20fps。 室内连麦直播时，帧率正常可达到20fps。跑到室外后，帧率掉到7fps。码率能保持在1600kbps。
这情况下因为帧率太低能明显感觉到画面一卡一卡的。这情况怎么优化？
环境变差时sdk内部是优先确保码率的吗？有没有其他配置可以动态调优

回答思维链：1、通过客户描述看视频编码帧率下降大概率是因为网络变差导致的，需要和客户收集频道号、时间点、uid 等信息进一步确认 2、sdk内部编码降级偏好是通过setVideoEncoderConfiguration方法可以配置的

答：1、您好，看您的描述视频帧率下降可能是因为室外网络变差导致的，麻烦您这边提供以下信息我们排查下：
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   2、我们是有api 是调整sdk 编码降级偏好的，setVideoEncoderConfiguration方法，参考文档如下:
   [https://doc.shengwang.cn/api-ref/rtc/android/API/class_videoencoderconfiguration](https://doc.shengwang.cn/api-ref/rtc/android/API/class_videoencoderconfiguration)

---

# **编号：35931**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 集成问题咨询**

问：通话过程中调用接口禁止用户推流后，用户依然在进行视频推流。
调用 kickingRule 接口请求 id bffdce7fc07a431cba08789f5de6e145

回答思维链：客户调用了封禁接口，也得到了请求成功后的规则 id，通常来说表示调用成功了，封禁应该是生效的。但不清楚具体现象是什么，封禁只会影响远端观看，本端预览是继续工作的，可以先找客户确认下现象，以及要个完整请求内容看看

答：您好，看起来接口调用是成功的，请问实际频道内远端可以看到来自被封禁用户的画面吗？封禁不会停止用户本地的采集状态，只影响线上观看，您这边可以先确认下现象，然后提供下原始请求内容，放在 txt 里用附件发到工单

---

# **编号：35927**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：1、使用场景：调用加入频道方法joinChannel，并 监听onConnectionStateChanged及onJoinChannelSuccess回调，如果onJoinChannelSuccess触发认为加入成功，显示画面；若onConnectionStateChanged触发且state == 5，则退出该次录制，并提示错误原因；

2、问题表现：客户使用华为P30准备录制，页面一直黑屏，未退出无任何提示；

3、备注：我们本地使用安卓10及更老的设备都未复现该问题，线上客户100%复现该情况，通过后端日志，确实可以推断出用户尝试了几十次；

回答思维链：该问题是个视频不可见，需要和客户收集频道号、时间点查看频道内的数据情况，看下视频采集为啥失败了

答：您好，视频黑屏的可能因素有很多，比如摄像头异常，摄像头被占用等；这边需要您提供下以下信息，我们进一步排查下：
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35908**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：1、请问下你们rtm登录的时候这里的图1中的RtmConfig.Builder是属于用户的唯一标识符吗？如果其他用户与其交互是不是就是这个值
2、图2中是rtc加入频道的方式，本地端A和远程端B，都是调用这个方法mRtcEngine?.joinChannel加入频道对吧，那这里的uid和问题1中的是同一个吗？因为joinChannel中的uid是int类型，而问题一的是 String类型如果写0的话会不会不调用onJoinChannelSuccess回调方法
3、问题三：因为你们RtmConfig.Builder是支持string类型的唯一标识符，而rtc的mRtcEngine?.joinChannel中的uid是int类型，他们两个是同一个东西吗？

回答思维链：客户工单提交的产品类型是 RTC，但是问到了 RTM 的问题，推测是两个 SDK 都有集成但是不太清楚两个 SDK 的区别。问题一需要和客户解释下 RTM 里的唯一标识符是 userid。问题二有问到 RTC 的 uid 是否和成功加入频道触发 onjoinchannelsuccess 相关，可以和客户解释下 joinchannel 应该用 int uid，joinchannelwithaccount才能用 string uid，以及应该推荐客户使用 int uid 的方法去加频道，这样 SDK 优化更好。问题三可以和客户解释并强调下 RTC 和 RTM 是两套独立的 SDK，彼此互不相通。

答：1、是的，userid 是不重复的唯一标识符

2、是的，RTC 用 joinChannel 来加入频道，RTC 的 uid 和 RTM 的 userid 不是同一个东西。RTC 加频道推荐用 joinchannel 方法，传 int uid 来加入频道，还有joinchannelwithaccount 方法是用 string uid 的，我们更推荐用 int 类型的方式，这样 SDK 优化更好

3、不是一个东西，不互通

---

# **编号：35900**

**SDK Product: RTC**

**SDK Version: 4.23.2**

**SDK Platform: Web**

**Request type: 线上报错**

问：本地服务端录制，token过期后不会自动续期，而是报错onError channelId:test error:ERR_TOKEN_EXPIRED message:

回答思维链：客户的工单分类选择了 RTC Web，但是问的问题是本地服务端录制的 token 问题，可能是分类选错了，应该专注在客户的实际提问上。本地服务端录制是有 renew 方法来传入新 token 的，客户有提到“token过期后不会自动续期”，可能是没有用到 renew 方法，也可能没有理解 token 过期以后要重新生成一个来传入的逻辑，可以和客户解释一下 renew 的常规流程和原理。

答：您好，本地服务端录制 SDK 是自带一个 renewtoken 方法的，可以在收到 token 即将过期的回调时先在自己业务服务器上生成一个新的可用 token，然后用 renew 方法传入这个新的 token，这样录制端被分配的 uid 就可以用新的 token 继续待在频道里了，token 是不会自己续期的。

---

# **编号：35897**

**SDK Product: convoai**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 集成问题咨询**

问：智能体加入频道失败
{
"agent_id": "A42AV45RD89DJ78LK99VN94PV47FY24T",
"message": "agent exits with reason: RTC connection failed",
"start_ts": 1751102804,
"status": "STOPPED",
"stop_ts": 1751102804
}

回答思维链：加入频道失败的原因大多数是和token有关，比如token无效、过期等，可以先引导客户校验token；客户请求正常返回了agent_id，后续可以依据id去查看后台日志定位具体原因。

答：您好，加入频道频道失败通常是和token有关，比如token无效、过期等；您这边可以登录console—>控制台—>辅助工具—>token生成/校验，先校验下token。

---

# **编号：35864**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：我想在iOS中实现 关闭视频或摄像头后 显示头像或一张本地的图片 并且远端的用户看到的也是这张图片

回答思维链：客户需要在实现本端设备发流状态改变以后修改远端用户的 UI 显示改用自定义图片，这个需求需要能够感知远端用户的发流情况来做对应处理，可以让客户监听我们 SDK 的remoteVideoStateChangedOfUid 来感知远端设备的发流情况，然后在感知到远端不发流的时候自定义图片展示

答：您好，可以监听remoteVideoStateChangedOfUid，在远端不发流的时候前端上写个业务来展示指定图片：[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged)

---

# **编号：35862**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：我想在iOS中实现多个视图显示本地视频预览,但是一直无法实现.
附件为我在Xcode中的代码.

回答思维链：看客户描述应该是想把本地画面渲染多次，这是需要在canvas 里配置setupMode  为 AgoraVideoViewSetupAdd 才能实现的，否则无法达到效果，可以让客户检查下有没有实现相关操作

答：您好，请问是想把本地画面渲染多次吗？如果是的，需要在对应的 canvas 配置里设置 setupMode  为 AgoraVideoViewSetupAdd

[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)

---

# **编号：35850**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：使用安卓端SDK，在安卓app发起云录制请求。请求资源接口可以正常返回，但请求开始录制接口返回错误
请求录制资源接口返回：

{"cname":"aac","uid":"9527","resourceId”:"xxx"}

【请求开始录制】

返回：
httpcode ：400

{code=2, reason='request_hash mismatch!'}

回答思维链：这是一个云录制的问题，客户在 acquire 的时候应该添加了 startParameter 字段，如果在acquire 环节添加了，后续再调用 start 的时候，body 内容和startParameter 不一致就会报错request_hash mismatch! 不推荐客户这样操作，可以推荐客户减少acquire 填写的内容，把具体的 start 配置放在 start 请求 body 里去实现

答：您好，request_hash mismatch! 的打印是 acquire 的 startParameter 和后续的 start 内容不同导致的，建议您不要在 acquire 里填写太多内容，可以参考我们文档右侧的示例请求，用最少的内容 acquire ，然后在 start 的 body 里详细填写具体配置

---

# **编号：35849**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：1对1的视频通话进行正常，录制也正常完成，没有出现错误。
但录制视频存放至阿里云OSS后发现，只有.ts文件和.m3u8文件存储了，mp4文件没有按要求生成。

这个现象在之前的视频通话也发生过一次。但其他视频通话都正常。烦请帮忙查看一下没有生成mp4文件的原因。

回答思维链：这看起来是一个云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户说 ts 和 m3u8 都收到了，说明预留的 OSS 信息应该没问题，上传链路是通畅的，但至于为什么没有 mp4，可能是转码还没有完成（可以让客户再等等，最晚不会超过 24 小时），也可能是 mp4 文件的上传有些问题（需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因）

答：您好，mp4 一般是 24 小时内完成转码再上传的，您可以先等 24 小时，如果还是没有的话，可以提供下具体的 sid，我们看下后台记录

---

# **编号：35787**

**SDK Product: RTC**

**SDK Version: 4.20.0**

**SDK Platform: Web**

**Request type: 效果不佳、不达预期**

问：android端角色是"讲师" ,web端是学员,学员端存在卡顿情况,3月下旬时web端是流畅的,今天看过web端存在卡顿,效果请看视频

回答思维链：客户应该是提供了现象视频并且咨询了一个线上问题，这类问题目前需要人工工程师来接管，可以先收集下客户的问题现象和出现问题的设备日志，推进下问题排查进展

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：35780**

**SDK Product: RTC**

**SDK Version: 4.2.2**

**SDK Platform: Android**

**Request type: 线上报错**

问：建立连接无法进行通话

回答思维链：看客户问题描述是无法通话，可能是线上无法加入频道，也可能是只有一方加入了频道，现在缺少的信息太多，无法直接分析出问题所在，可以先收集下客户的网络情况和出现问题的设备日志，推进下问题排查进展

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：35774**

**SDK Product: RTC**

**SDK Version: 4.20.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：集成问题咨询，尽快联系13752561012

回答思维链：客户想要语音咨询问题，但没有文字说明具体要讨论什么，可以先让客户文字描述下自己的问题，让稍后的电话沟通更高效一些

答：您好，您可以先把问题在工单里描述下，这样稍后的电话沟通更有重点

---

# **编号：35773**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问： 问题平台：iOS
问题项目：官网demo OC版本 [https://github.com/AgoraIO/API-Examples](https://github.com/AgoraIO/API-Examples)
问题版本：4.5.2

因为工程项目原来版本是3.7.0，
现在需要升级到4.5.2。

在官网下载了demo，并且跑通了demo，demo的SDK版本是4.5.2。
音视频功能正常。
但是屏幕共享有点问题，开启屏幕共享后，直播弹窗出现了其他app，
并且我在自己的项目中3.7.0的SDK版本没有这个问题，升级到4.5.2的SDK也有这个问题
麻烦帮忙看看是什么原因。

回答思维链：这是一个 4.x Demo 的已知问题，Demo 没有写好。可以引导客户在 xocde 的 info-Target Properties-Bundle display name 里传屏幕分享的Bundle Id 就可以了

答：您好，在 xocde 的 info-Target Properties-Bundle display name 里传屏幕分享的Bundle Id 就可以了

---

# **编号：35770**

**SDK Product: RTC**

**SDK Version: 4.4.0**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：您好 我们这用的环信的uikit做了一个IM系统，然后现在要集成RTC，发现生成rtc token的时候总是报错，现在我们没有太多时间找代码的问题，能否给一个配上环信和声网的就能跑的demo 单聊 群聊 音视频通话 就这几个功能 谢谢

回答思维链：客户需要知道如何生成 RTC 的 token 来加入频道，直接推荐客户 clone 我们的 token 示例代码仓库本地运行去生成就可以了

答：您好，clone 这个仓库下来，用示例代码去生成 token 即可

[https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)

---

# **编号：35769**

**SDK Product: RTC**

**SDK Version: 4.21.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：你好，集成了屏幕共享功能，如何停止屏幕共享，使用ScreenSharingClient.leave()方法虽然频道中看不到屏幕共享，但是本地的屏幕共享流依然存在（就是截图中的提示框依然在），请教一下该如何停止呢。

回答思维链：客户反馈的现象是调用leave()后屏幕共享依旧没有停止，应该是屏幕共享的 track 被创建以后没有释放导致的，可以让客户释放对应的 track 来解决

答：您好，可以尝试下调用对应 track 的 close 方法去释放来解决这个问题：[https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocaltrack#close](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocaltrack#close)

---

# **编号：35768**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 线上报错**

问：1. 问题表现： Android端的用户和web的客服建立双向视频后，Android端看不见web端客服的视频，只能看到自己。 Web端可以看到自己 也可以看到用户
2. 线上出现概率为1% - 2%
3. 经过开发代码排查，定位原因是 Android端AgoraSdk的 onUserJoined 方法没有被调用，导致自定义videoview无法显示出来

override fun onUserJoined(uid: Int, elapsed: Int)

{ Log.i("AgoraManager", "CS-UserJoined uid = $uid") *levelLiveData.postValue(false)* uidJoinLiveData.postValue(uid) }

回答思维链：onUserJoined回调被触发是有条件的，比如远端用户是否是主播身份，需要先提供相关频道和uid信息来佐证

答：您好，onUserJoined回调在如下情况下被触发：
远端用户/主播加入频道。
远端用户加入频道后将用户角色改变为主播。
远端用户/主播网络中断后重新加入频道。

需要您这边提供下频道号，时间点，以及uid，我们查下远端用户是否是主播身份

[https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#callback_irtcengineeventhandler_onuserjoined](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#callback_irtcengineeventhandler_onuserjoined)

---

# **编号：35760**

**SDK Product: RTC**

**SDK Version: 4.2.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：pc 端用obs 临时token 推流
app 端 调用获取房间列表的接口为啥显示不出来？
尝试更换了 [https://service-staging.agora.io](https://service-staging.agora.io/ "Follow link") 这个域名也是拿不到
接口参数如下

回答思维链：客户提交的 SDK Platform 写的是Android，但是问题描述提到的是PC用OBS，需要和客户再确认下现在在用哪个产品，以及用的是什么方式来加入频道的

答：请问现在 PC 是如何实现推流的？是用的 OBS 插件还是 RTMPG 服务？

[https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)

---

# **编号：35759**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 效果不佳、不达预期**

问：2个手机进入同一个频道，但是画面很暗，基本看不清对面的画面

回答思维链：这个现象应该不是必现的，推测和客户的设备或者集成有关，可以先让客户运行我们的Demo看下是否能复现，来排查到底是SDK问题还是客户自己的设备问题

答：您好，可以用我们 Demo 尝试复现下：[https://github.com/AgoraIO/API-Examples/tree/main](https://github.com/AgoraIO/API-Examples/tree/main)

一般不会有这个问题，可以确认下摄像头本身是否正常工作

---

# **编号：35758**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：Android sdk中，设置音频编码格式为g711后，能否设置采样率为8k和16k，需要用哪个接口呢？

engine.setParameters("

{\"che.audio.custom_payload_type\":8}

");

回答思维链：客户调用了私参接口来让android设备发送G711音频编码，但是G711编码只有8K采样率，无法切换到16K，G722才是16K的，所以这个需求无法实现

答：您好，G711 只有 8k 采样率，G722 才是 16k，没有办法指定 G711 用 16k 的

---

# **编号：35757**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：Android sdk 纯音频通话，如何设置音频编码格式，比如设置为g711或者g729。如果不能选择编码格式，几种场景采用的编码格式分别是什么呢？

回答思维链：客户需要让 Android 端发送 G711 或者 G722 的音频编码，一般这类需求是和 IOT 设备互通才有的，可以给客户提供下相关文档，在 join 前调用私参接口传入私参来改变编码配置

答：您好，需要在 join 之前调用私参接口来改变编码格式，参考：[https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc#%E8%AE%BE%E7%BD%AE-rtc-native%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6-sdkv4x](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc#%E8%AE%BE%E7%BD%AE-rtc-native%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6-sdkv4x)

---

# **编号：35750**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：疑似未收到声网推送的主播离开频道事件。
需要协助排查该频道主播离开频道时的事件推送日志。

回答思维链：客户反馈没有收到主播离开频道的事件，但没有说明是服务端的Webhook NCS 事件还是客户端的回调，可以先和客户确认下这个细节来推进问题调查

答：您好，请问没收到的是客户端回调还是服务端 NCS 事件？

客户端的话可以提供下 sdk 日志：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

NCS 事件的话可以先去声网 console 上检查下回调地址是否有配置，以及健康检查是否通过

---

# **编号：35745**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Unity**

**Request type: 集成问题咨询**

问：你好，我们的应用场景是unity开发的手段app与ai设备的实时语音通话，ai设备cpu架构是orinagx(英伟达 orin aarch64) 系统是ubuntu20.04 我在技术支持文件中没有找到该平台对应的sdk 改如何获取或者说支持该平台吗

回答思维链：客户的场景是在Unity下用app和Ubuntu设备在 RTC 频道里互通，声网有Unity的SDK，也有Ubuntu的服务端或物联网设备SDK，但客户现在没有找到，我们应该提供对应的文档地址给客户

答：您好，我们有服务端SDK支持arm的：[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources)

还有 RTSA SDK，专门给一些 IOT 设备使用，里面有支持 aarch64 的，可以试下：[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# **编号：35740**

**SDK Product: RTC**

**SDK Version: 4.5.0**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：当前版本4.5.0，2个移动端设备，互相呼叫，通过服务器生成同样的 token 和 channelName，调用 joinChannel 后，均回调了onJoinChannelSuccess，但是没有回调 onUserJoined，这是为什么？
用旧的版本 3.2.0 能回调 onUserJoined。业务依赖 onUserJoined 来判断远端用户是否加入成功，加入了则认为通话建立成功，若没回调，则一直处于拨号中的状态。

回答思维链：客户反馈用相同的 token 加入相同的频道以后都触发了onJoinChannelSuccess 但是没有 onUserJoined ，需要和客户确认下是否出现了用相同 token 和 uid 来加入频道导致互踢的情况，以及也要和客户确认下加入频道时双方的身份都是否为主播，onUserJoined 只有在远端是主播身份加入的时候才会触发。

答：您好，

1、onUserJoined只会在远端以主播身份加入的时候才触发，如果身份是观众就不触发了

2、如果用的是相同的 token，需要确认下 uid 是否相同，token 是和 uid 、频道名绑定的，但是 uid 在频道内不能重复，所以理论上不同 uid 的 token 应该不同，请确认下是否用了相同的 uid 加频道，导致了互踢

---

# **编号：35721**

**SDK Product: RTC**

**SDK Version: 4.21.0**

**SDK Platform: Web**

**Request type: 集成问题**

问：之前集成了实时共享RTC，加入频道也能正常共享视频，现在想在共享视频时，再共享屏幕，视频共享成功后调用了方法AgoraRTC.createScreenVideoTrack创建屏幕共享，然后在创建成功后调用rtc.Client.publish([localScreenTrack])，但是控制台报错AgoraRTCError CAN_NOT_PUBLISH_MULTIPLE_VIDEO_TRACKS；不知道什么原因，请教一下该如何处理。

回答思维链：报错写的是AgoraRTCError CAN_NOT_PUBLISH_MULTIPLE_VIDEO_TRACKS，这表示不能发送对路视频流。SDK 一个 uid 只能发送一路视频流，推测客户是用一个 uid 既发送屏幕共享流又发送摄像头流导致的。 

答：您好，一个 uid 只能发一路视频流，要发两路流就需要再创建一个 client，然后用不同的 uid 加入频道，指定发屏幕共享流。

---

# **编号：35703**

**SDK Product: cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 线上报错**

问：请求参数
{"uid":"16555","cname":"h87sgcmwgp","clientRequest":{"recordingFileConfig":

{"avFileType":["hls","mp4"]}
,"storageConfig":

{"bucket”:"xxxx","secretKey":"xxxx","accessKey”:"xxxx","vendor":2,"region":6,"fileNamePrefix":["testVideo","20250612114229237"]}
,"recordingConfig":{"channelType":1,"transcodingConfig":{"layoutConfig":[

{"uid":"2366523894","y_axis":0,"x_axis":0,"render_mode":1,"width":1,"height":1}
],"mixedVideoLayout":3,"width":1920,"fps":50,"bitrate":5000,"height":1080}}}}

报错

{"code":2,"reason":"services not selected!"}

回答思维链：云录制启动参数报错，有比较明确的报错信息；查询云录制接口请求响应状态码和错误码，是传参有问题导致的

答：您好，云录制启动报错，官网侧是有文档详细说明文档的，参考如下：
[https://doc.shengwang.cn/doc/cloud-recording/restful/response-code](https://doc.shengwang.cn/doc/cloud-recording/restful/response-code)

根据你这个错误码，比较怀疑是启动时传入的参数不合法导致的，请严格参照我们的云录制启动文档进行传参。

---

# **编号：35702**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: Java**

**Request type: 线上报错**

问：我们公司的声网SDK，是声网之前给我们的内测版本。
平台：Android
今天上午发现大面积报错：Agora RTM join topic failed by join ret: -10001。无法加入RTM频道，RTC也不可用。相关错误码查不到，请教一下如何解决。

回答思维链：客户有提到用的是以前的内测版本，可能是个老版本了，应该推荐客户用现在最新的 RTM 2.x 来上线使用。

-10001 的错误码是有文档可以查看的，这表示没有初始化，可以让客户自查一下相关业务并且提供错误码文档给他。

答：您好，内测版本不推荐上线使用，建议集成我们2.x 最新的对外版本：[https://doc.shengwang.cn/doc/rtm2/android/landing-page](https://doc.shengwang.cn/doc/rtm2/android/landing-page)

10001 是没有初始化的报错，可以先检查下相关业务：[https://doc.shengwang.cn/doc/rtm2/android/error-codes#%E9%94%99%E8%AF%AF%E7%A0%81%E5%AF%B9%E7%85%A7%E8%A1%A8](https://doc.shengwang.cn/doc/rtm2/android/error-codes#%E9%94%99%E8%AF%AF%E7%A0%81%E5%AF%B9%E7%85%A7%E8%A1%A8)

---

# **编号：35675**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 集成问题咨询**

问：hook回调地址配置报错:

NCS 健康检查
NCS 健康检查结果: Test Failed

{ "success": false, "httpCode": 502, "error": "Post "[https://imapi.irecircle.com/im-user/imRtcMeeting/hook\](https://imapi.irecircle.com/im-user/imRtcMeeting/hook%5C)": x509: certificate signed by unknown authority", "response": "" }

回答思维链：NCS健康检查报错，通常都是和客户的回调地址域名不通、https证书错误、请求超时导致的；需要客户侧自查

答：您好，webhook回调地址报错通常和咱们的配置的回调地址域名不通、https证书错误、请求超时等原因导致的，建议咱们先自查下，参考文档如下：
[https://doc.shengwang.cn/doc/rtc/restful/webhook/receive_webhook](https://doc.shengwang.cn/doc/rtc/restful/webhook/receive_webhook)

---

# **编号：35641**

**SDK Product: RTSA**

**SDK Version: 1.9.5**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：你好，附件是我们的项目需求信息，请帮忙看下能否释放一下sigmastar 平台的RTSA SDK

回答思维链：这是一个RTSA相关问题，客户提到了sigmastar平台，应该是想确认我们的RTSA SDK 有没有适配此平台的版本，需查看官网的文档确认

答：您好，您这边可以参考官网RTSA 平台兼容文档以及下载文档来选择，如果没有支持咱们平台的版本，请联系 [sales@shengwang.cn](mailto:sales@shengwang.cn)
[https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview](https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview)
[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# **编号：35640**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：实时RTC直播点击加入报110code

回答思维链：加入频道报错110，可以查官网的错误码即可

答：您好，加入频道报错110：Token 无效。一般有以下原因：

在声网控制台中启用了 App 证书，但未使用 App ID + Token 鉴权。当项目启用了 App 证书，就必须使用 Token 鉴权。
生成 Token 时填入的 uid 字段，和用户加入频道时填入的 uid 不一致。

您这边可以检查下

[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)

---

# **编号：35638**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 其他问题**

问：1.加载两个远端视频流，在进行视图切换的时候出现黑色不显示视频流的情况，请问是什么原因？怎么排查？
2.附件中有具体的操作视频和部分代码截图

回答思维链：这是一个视频黑屏不可用问题，可以先让客户提供下频道号，问题时间点，以及是那个uid看不到那个uid的视频画面，看下对应用户的视频相关参数有没有异常；之后再拿sdk日志排查定位

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：35637**

**SDK Product: CDN**

**SDK Version: 当前版本**

**SDK Platform: CDN**

**Request type: 其他问题**

问：尽快更新证书啊

回答思维链：客户咨询CDN证书更新相关问题，console上的证书更新是需要一定时间更新同步的；

答：您好，CDN相关的证书更新是需要时间的同步的，通常需要2周左右，您这边再耐心等待下；

---

# **编号：35634**

**SDK Product: RTC**

**SDK Version: 4.2.6**

**SDK Platform: Android**

**Request type: 开通权限、提高配额、上量报备**

问：帮我开通一下 跨频道流媒体转发功能

回答思维链：跨频道连麦功能需要提供appid ，后台开通

答：您好，麻烦提供下项目的appid，技术支持工程师在看到消息后会及时地给您开通，请耐心等待回复，感谢您的理解与配合，谢谢。

---

# **编号：35633**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 其他问题**

问：视频无法呼出，或者接听视频之后几分钟之后就自动断开
用户ID：20513
用户ID：86042

回答思维链：客户问了2个问题，问题1是视频无法呼出，主要是和信令连通有关；问题2是接通视频成功后断开，需要提供对应时间点的频道号，uid信息看下断开原因

答：您好，视频无法呼出，主要是和呼叫邀请信令有关，需要您这边查下信令登录、发送、接收是否正常；
自动断开可能是业务侧异常调用leave接口退出频道，也可能是app闪退或者是设备网络异常导致的断开。

---

# **编号：35630**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 线上报错**

问：android设备与pc端进行实时语音出现无法听到android端的声音，通过抓包看到如下信息：
Allocate Error Response error-code: 401 (Unauthenticated) Unauthorized with nonce realm: agoraio
214 Allocate

回答思维链：对于声音听不见问题，优先让客户提供频道号，时间点，以及那个uid听不到那个uid的声音；也有可能和客户侧的网络环境有关，比如设备不能直接公网等

答：您好，对于声音听不见的问题，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

也有可能和设备的网络环境有关，比如不能直连公网等

---

# **编号：35629**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：目前采用的是RTC极速模式、观众端看到的视频画质不很好、并且视频比较模糊、外置摄像头不能聚集

回答思维链：这是个视频体验类问题，视频模糊首先怀疑是指客户端网络问题，比如丢包、带宽不足等；也有可能是主播端的视频采集帧率低等，需要客户提供频道、uid等关键信息排查定位

答：您好，视频画质不好通常是和客户端网络较差有关，比如丢包、带宽不足等；也有可能是主播端的视频采集帧率低等；麻烦您按以下模版整理问题，我们查下频道内传输情况；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35626**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 商务问题**

问：我们已经在6月1日购买了 实时互动尊享版，一共2388元，为何月账单还会扣除我们1024.57元，导致我们现在账户上还欠费-429.67，什么情况这是？

回答思维链：商务问题需要客户找到商务同事处理，或者拨打 400 6326626 电话
答：您好，商务计费相关问题，麻烦联系对应商务同事处理，或者您这边可以拨打400 6326626 电话联系处理，感谢您的理解与配合，谢谢。

---

# **编号：35580**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 崩溃（闪退、卡死）**

问：接收端是Linux系统，发端是安卓手机，型号是Vivo Z5x，安卓版本10，第二次发起后，Linux端会崩溃。
然后换另一台安卓手机，型号是荣耀X50，安卓版本15，多次发起，Linux 端不会崩溃。

回答思维链：客户咨询了一个崩溃问题，无法直接分析问题所在，应该先找客户收集崩溃堆栈、双方崩溃时的 SDK 日志信息，方便后续人工工程师调查。

答：您好，可以先参考下这篇文档收集崩溃时的堆栈和双方 SDK 日志，稍后人工工程师会解析崩溃查看具体堆栈在哪里了。

[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35517**

**SDK Product: RTSA**

**SDK Version: 1.9.5**

**SDK Platform: Linux-C**

**Request type: 崩溃（闪退、卡死）**

问：使用文件名为 Agora-RTSALite-RmRdRcAcAjCF-riscv-linux-gnu-1040-v821-v1.9.5-20250527_160103-718970 的SDK报错
报错截图和sdk自动生成的coredump都在附件内

ai分析说是动态库包含了一个特殊的 xandes5p0 扩展指令集导致的 供参考

回答思维链：这是一个 SDK 崩溃问题，目前无法直接解答，可以让客户提供崩溃堆栈和对应的 SDK 日志，等候人工工程师解答。

答：您好，崩溃问题可以提供下崩溃时的原始堆栈+SDK 日志，人工工程师稍后为您解答

如果不清楚如何获取，可以参考：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35465**

**SDK Product: Convol AI**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 崩溃（闪退、卡死）**

问：为什么我昨天开通的账号试用，今天额度就没有了
只用了9分钟就冻结了账号
不是有1000分钟吗？

回答思维链：这是一个账号类商务问题，可以让客户自查下有没有用到付费产品导致停机，以及可以引导客户购买预付费套餐包来解冻

答：您好，人工工程师稍后给您解答，您可以先自查下是不是还用到其他不包含在免费 1w 分钟内的付费产品。如果有的话是会触发账号冻结的，需要购买预付费套餐包解冻。

---

# **编号：35444**

**SDK Product: Cloud-transcoder**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 开通权限、提高配额、上量报备**

问：帮我把这个appid开通云端转码服务 7dacdca9362c47289595189fe551c5c9

回答思维链：客户需要开通云端转码服务，并且提供了 appid，可以让客户稍作等待，人工工程师稍后就会开通

答：您好，已收到您的申请，稍后人工工程师会帮您开通这个服务，请稍等片刻。

---

# **编号：35420**

**SDK Product: Console**

**SDK Version: 当前版本**

**SDK Platform: All**

**Request type: 商务问题**

问：想了解一下这个账号的具体计费明细 方便下午 飞书啦一个会 对一下吗

回答思维链：这是一个计量计费咨询的商务问题，可以让客户优先阅读计量计费文档以及留下商务电话供客户沟通

答：您好，计费规则可以参考：[https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)

其中的细节您可以电话沟通：400 6326626

---

# **编号：35046**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: C++**

**Request type: 奔溃（闪退、卡死）**

问：一共有40个客户端，每个客户端连接后订阅一个rtm频道，当有20个客户端连接并成功订阅后，新的客户端连接后 订阅失败，使用官方SDK程序测试，也会订阅失败，但我无法捕捉错误，因为问题来自dll文件，需要协助排查订阅失败，引起程序闪退的原因。

回答思维链：客户遇到了 2.2.2 版本 RTM 的崩溃，可以找客户确认下崩溃时的 dump 和 SDK 日志，等待人工工程师解析崩溃。

答：您好，可以先提供下崩溃的原始堆栈+SDK 日志，人工工程师稍后为您解答

[https://doc.shengwang.cn/doc/rtm2/cpp/error-codes](https://doc.shengwang.cn/doc/rtm2/cpp/error-codes)

---

# **编号：34762**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type:集成问题咨询**

问：Caused by: java.lang.UnsatisfiedLinkError: /data0/www/htdocs/code/lib/shengwang/libbinding.so: /lib64/libm.so.6: version `GLIBC_2.27' not found (required by /data0/www/htdocs/code/lib/shengwang/libagora_uap_aed.so)

centos7.5的 GLIBC是2.17 有木有对应版本的java pom 依赖

回答思维链：客户目前用的不是最新版本，可以让客户优先升级到 4.4.32 试一下，新版本里已经移除了对于这个库的依赖

答：您好，可以直接用目前的最新版本，最新版本里去掉了这个库

[https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main](https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main)

---

# **编号：34717**

**SDK Product: Flexible-classroom**

**SDK Version: 2.9.40**

**SDK Platform: Web**

**Request type: 线上报错**

问：灵动课堂api无法创建课堂，参数正确500错误
接口：[https://api.sd-rtn.com/cn/edu/apps/e1d4f3c1f7084458b62d41bc1f681711/v2/rooms/test_class](https://api.sd-rtn.com/cn/edu/apps/e1d4f3c1f7084458b62d41bc1f681711/v2/rooms/test_class "Follow link")

Array ( [msg] => Internal Server Error [code] => 500 [ts] => 1743673689138 )

500 Internal Server Error500服务器内部错误，无法完成请求。联系技术支持或管理员，检查服务器日志。

回答思维链：这是一个灵动课堂的线上报错问题，请求了启动接口得到了 500 的状态码。不过一般来说灵动课堂服务不会这么轻易的挂掉，可以先找客户要一下复现错误时的请求内容，等人工工程师看下是服务确实有问题还是用户的请求内容不正确导致了报错。

答：您好，请问这个问题现在还能复现吗？如果可以的话，麻烦提供一下复现时的 CURL 完整请求，放在 txt 里用附件发来，人工工程师稍后会为您排查。

---

# **编号：34708**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：电话号码：18107394980

回答思维链：看起来客户留了个电话要咨询问题，可以让客户先说明下希望讨论的问题内容，方便人工工程师提高沟通效率。

答：您好，请问具体是什么问题？可以先把问题列在工单里，这样稍后人工工程师给您来电沟通更有重点。

---

# **编号：34707**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Flutter**

**Request type: 崩溃（闪退、卡死）**

问：集成 RTC和RTM rtm初始化后崩溃，去除RTM后正常

回答思维链：看起来客户同时集成了 RTC 和 RTM，并且遇到了崩溃，可以让客户提供下崩溃时的原始堆栈+SDK 日志，以及也可以让客户先检查下有没有做过 RTC+RTM 下aosl 冲突的处理：[https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199](https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199)

答：您好，可以优先检查下有没有做过 RTC+RTM 下aosl 冲突的处理，参考：[https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199](https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199)

如果做了还是崩溃，可以提供下崩溃的原始堆栈+SDK 日志，人工工程师稍后为您解答。

---

# **编号：34701**

**SDK Product: RTC**

**SDK Version: 2.6.5**

**SDK Platform: mini-app**

**Request type: 效果不佳（不达预期）**

问：1、服务端查询频道内用户列表接口，接口返回的数据异常，channel_exist为false，且users数据为空，实际上有一个用户加入到频道
2、客户端进入实时语音聊天页面，访问接口获取频道内用户数据

回答思维链：客户提出了两个问题，但实际的问题是一个，就是调用查询频道内用户列表接口后没有得到预期的数据，可以让客户提供下原始请求，稍后让人工工程师调查一下具体原因。

答：您好，可以抓一下原始请求放 txt 里发工单，检查下请求的频道信息和实际在看的是不是同一个。

---

# **编号：34696**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：[https://api.sd-rtn.com/v1/apps/](https://api.sd-rtn.com/v1/apps/ "Follow link"){appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start

调用这个录制接口成功后， 云服务器上没有录制的文件

回答思维链：这是一个云录制问题，可以让客户提供下 sid，等待稍后人工工程师查询具体上传情况。

答：您好，麻烦提供下对应的 sid，人工工程师稍后看下后台记录。

---

# **编号：34650**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：[https://doc.shengwang.cn/doc/rtc/android/overview/migration-guide#%E4%B8%AD%E6%96%AD%E6%80%A7%E5%8F%98%E6%9B%B4](https://doc.shengwang.cn/doc/rtc/android/overview/migration-guide#%E4%B8%AD%E6%96%AD%E6%80%A7%E5%8F%98%E6%9B%B4 "Follow link")

我正在从3.7版本sdk升级到4.5.1，其中有一个API被废弃，enableDeepLearningDenoise：AI 降噪将在后续版本改由 SDK 控制，不通过 API 实现，这个AI降噪具体是由哪个SDK控制呢，这个SDK相关文档是哪个呢？

回答思维链：客户是从3.x升级上来的，还不理解4.x的3A 处理是默认开启的，可以和客户解释下，并且说明AI降噪是付费项目，如果客户确定需要的话，再提供具体的api来开启。

答：您好，4.x SDK 默认开启 3A 处理：[https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a)

AI 降噪是收费功能，一般来说 SDK 自带的 3A 就够用了。您可以先试下自带3A的效果，不满意的话我们再讨论下。

---

# **编号：34644**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：你好，我想咨询一下这个频道在10.20的时候，99999是否有加入。我现在在使用RTC服务端SDK进行拉流，然后取帧发送给算法服务，现在算法服务拿不到数据，我想确定一下我是否拿到了视频流，谢谢。

回答思维链：客户想知道指定 uid 有没有加入频道，可以引导客户在声网console的水晶球里自行查看相关信息。

答：您好，这部分信息可以在声网 console左侧边栏-全部产品-水晶球里自行查看

---

# **编号：34643**

**SDK Product: RTC**

**SDK Version: 4.3.0**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：(void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason

这个收到远端用户didOffline reason = AgoraUserOfflineReasonDropped，请问远端用户的声网SDK内部会重试么？还是说已经是算是离开连麦了？

回答思维链：didOfflineOfUid 是已经和声网节点断开连接的回调，reason 字段的AgoraUserOfflineReasonDropped 表示因过长时间收不到对方数据包，超时掉线，SDK 会在 20 分钟内继续尝试重新加入频道，20 分钟后如果还没有加入频道，就不会再重试了，需要手动调用 join。

答：您好，SDK 因为网络连接超时而退出频道后依旧会尝试重连 20 分钟，20 分钟后还连不上的话就不会再重连了，需要手动调用 join 来加入频道

---

# **编号：34635**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.0**

**SDK Platform: Linux-Python**

**Request type: 集成问题咨询**

问：我们现在用声网SDK接收YUV格式的视频流，取帧后转成RGB格式，进行一定的处理，再转回YUV格式，并发送YUV格式的视频流，但是我们发现YUV和RGB互转比较慢，会影响发送视频流的帧率，请问有办法直接获取/推送RGB格式的视频流吗？或者声网有提供相关接口可以替代我们YUV和RGB的互转过程吗？

回答思维链：客户应该是需要直接推 RGB 数据发送到频道里，可以让客户在create_custom_video_track_frame里指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式

答：您好，create_custom_video_track_frame里可以指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式

[https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe)

---

# **编号：34631**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 线上报错**

问：andorid sdk 语聊房连麦无声音

回答思维链：客户反馈了一个线上连麦无声的问题，但是没有提供频道信息，可以先找客户确认出现问题的频道号、uid、时间点，具体现象是什么，方便人工工程师后续排查。

答：您好，麻烦提供频道名，说明什么时间段，哪个 uid 听不见哪个 uid。方便的话，麻烦提供下设备SDK日志过来看下：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：34627**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：你好，我想知道怎么实现AI算法服务集成这个功能，我们算法服务是在另外一个服务器上。我们现在引用的算法支持的流是rtsp、rtmp这种，我想知道我们的是什么流？我看推荐srs。

回答思维链：客户似乎想通过 RTSP 或者 RTMP 协议来获取实时的 RTC 流，但声网 RTC 流是封装过的，无法直接获取，可以推荐客户使用旁路推流功能来获取实时 RTC 频道里的画面

答：您好，我们的 RTC 是自研封装的 RTC 协议，需要通过集成客户端 SDK，通过加入频道的方式才能拿到频道里的流。如果拉流打算用 RTMP 一类的协议去实现，可能需要旁路推流功能：

[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)

[https://doc.shengwang.cn/doc/media-push/restful/landing-page](https://doc.shengwang.cn/doc/media-push/restful/landing-page)

---

# **编号：34617**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：视频发送端使用的android设备，sdk版本号3.3.0.设备使用了上海联通定向卡，添加了*.agora.io，**.agoraio.cn，**.sd-rtn.com 三个通配域名。在进入频道后，发生视频，sdk无报错。水晶球系统看，发送端正常推流。但是接收端(web，sdk版本4.11.0）无法接收到视频，水晶球显示无接收信息。
测试频道号djcs000002,可以随时复现。
需要麻烦贵司支持人员，协助解决，帮忙找出是否需要添加其他域名或ip白名单，或者其他解决方式。

回答思维链：这个客户应该使用了物联网卡设备，不过用的是 RTC Android SDK。可以先让客户检查下有没有在初始化 SDK 的时候设置 mDomainLimit 为 true，需要mDomainLimit+报备物联网卡域名才能使用的。

答：您好，可以检查下 Android 端初始化的时候，有没有开启 mDomainLimit 字段的开关，要设置为 True，否则只报备域名是不够的。

[__https://doc.shengwang.cn/api-ref/rtc/android/API/class_rtcengineconfig__](https://doc.shengwang.cn/api-ref/rtc/android/API/class_rtcengineconfig)

---

# **编号：34600**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type:线上报错**

问：App ID: 0558654829f44526a8479352ccbceb28Salt: 577203831
Token 失效时间：2025/03/29 21:50:31 +00:00
pid:3B2D9E30A190419BB0BB611EBAAF76F3

创建频道成功了, 但是设备端一直无法加入,且会自动退出, 帮忙查看一下什么原因

回答思维链：客户虽然选择了 Web，但是问题描述里提到了 pid，可能是一个 RTSA 设备和 Web 互通的问题，所以需要找客户先要日志来看下具体的打印再分析无法加入和自动退出的原因。

答：您好，如果是 RTSA 设备的话，麻烦提供出现问题的设备SDK 日志：[https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level()](https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level\(\))

加入频道失败需要看本地打印。

---

# **编号：34575**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：使用临时生成的token，并且调用时不使用uid可以播放，会触发user-joined事件：
const token = '007eJxTYHiiaqD0bvHyT1fbw1jf+R5yiFLND74085Ba2FG+zqSo3m0KDBaWxiZmSaaWiSZJxiZpyUaJBmap5knGKRaGqZbmJubmjT+fpDcEMjIsTjRmZmSAQBCfm6EktbgkOSMxLy81h4EBAFOCIr0=';
await agoraClient.join(appId, channel, token);
但是换成从服务端获取的token，并且调用时带上uid就不能播放了，无法触发user-joined事件，也没有报错

回答思维链：客户用临时token的时候可以加入频道发流并且监听user-joined事件，但是用自己生成的token就不行了，可以让客户检查下token和uid是否匹配，以及是否用主播身份加入频道发流了，观众是无法触发user-joined 的

答：您好，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，你需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致。

以及也麻烦检查下加入频道时用的 role 是不是主播，观众是无法发流的，无法发流也就无法触发user-joined 回调。

---

# **编号：34564**

**SDK Product: Fastboard**

**SDK Version: 0.3.22**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：找技术咨询一下开发相关功能，选择Fastboard SDK 还是Whiteboard SDK

回答思维链：客户正在选型Fastboard 和 Whiteboard，可以推荐客户按照自己的业务场景来选择

答：您好，可以参考文档，根据您的业务需求选择：

[https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare)

---

# **编号：34558**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: HarmonyOS**

**Request type: 集成问题咨询**

问：我想把harmonyOS项目转换为openharmony项目，发现openharmony不支持kit，想要使用要改成ohos，但是使用到的import

{ rcp }

from '@kit.RemoteCommunicationKit';是HMS，华为的，不支持openharmony，最终实现不了

回答思维链：客户在用openharmony，但我们 SDK 没有适配过openharmony，无法保证可用性，需要建议客户避免类似操作来解决。

答：您好：
1、 我们的 SDK 没有计划适配openharmony， 之前在openharmony上尝试跑过，能跑，但是功能有问题。不推荐

2、针对这个问题 应该是api level 太低导致的， openharmony 至少应该到对应HarmonyOS API 12的 api 才能跑

---

# **编号：34546**

**SDK Product: RTC**

**SDK Version: 4.23.2**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：我用同一个设备开了两个浏览器模拟两个用户使用声网的试试语音通信的语聊房业务，他们可以推流到声网连接到声网，却无法互相订阅

回答思维链：Web 端在同一频道内但是订阅失败的问题，通常来说都是双向绑定或者订阅错 client 导致的，可以让客户自查下集成。

答：您好，可以检查下是不是全局一个 client，如果多个 client 可能出现订阅的 client 不是同一个。以及如果用的是 vue，需要注意不能双向绑定。

---

# **编号：34538**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type:其他问题**

问：我的发票为什么还不开啊？

回答思维链：看起来是涉及到发票的商务问题，可以让客户先提供下申请发票的事件和具体cid，并且让客户稍作等待，等人工工程师处理。

答：您好，麻烦提供下具体的 cid 和申请时间，稍后人工工程师就为您解答。

---

# **编号：34530**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 线上报错**

问：用你们github上的Tools里面的RtcTokenBuilder2Sample.cpp例程产生的动态token用不了！！！

RtcTokenBuilder2Sample.cpp这个代码里面的uid用那个才对？ CID的值？

回答思维链：客户看起来在生成 token 时对于要传入的值不太清楚概念，可以安抚下客户的情绪并且解释下具体字段含义

答：您好，uid 是你自定义的 int 值，和加入频道时要传入的 uid 是同一个

自己生成的 token 是要校验 uid 的，你需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# **编号：34504**

**SDK Product: RTC**

**SDK Version: 4.0.0**

**SDK Platform: Android**

**Request type: 集成问题**

问：在调用 joinChannelWithUserAccount 后没有收到任何回调，例如onJoinChannelSuccess、onConnectionStateChanged、onError。已经确认传入的token有效，频道一致，uid也有值。初始化也没问题。

rtcEngine?.joinChannelWithUserAccount(SPfUtil.getInstance().getString("rtc_token"), channel, SPfUtil.getInstance().getString("token_uid"), options)

回答思维链：客户在使用 string uid 的情况下遇到了一些预期外的情况，可以推荐客户先避免使用 string uid 看下问题是否还会复现

答：您好，可以尝试下避免使用joinChannelWithUserAccount，SDK 对于 String 类型 uid 的适配不好，建议用 int 类型 uid

---

# **编号：34495**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上报错** 

问：用的云录制的restful接口，用了好几年了，为了下周迎检，今天线上复测结果获取资源ID接口报了个错。

接口：cloud_recording/acquire

入参：{"uid":"8810546176","cname":"myyf797229771","clientRequest":{"resourceExpiredHour":72}}

出参：获取resourceID发生异常:

{reason=post method api body check failed!, code=2}

我对照官网文档curl的示例参数，发现请求体没有缺失参数，不知为何会报这个错。

回答思维链：body check failed!, code=2 的打印表示问题出在请求的 body 字段内，可能是客户输入了不正确的字段或者字段的值不符合要求，可以让客户再对照我们文档自查下 body，排查下是否出现了 uid 值超出限制范围的常见情况。

答：您好，这个打印本身代表 body 字段不符合要求，可以检查下是否出现了字段的值超出范围（比如 uid超出 int）或者缺少了一些必填字段的情况。

---

# **编号：34490**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询** 

问：https://api.sd-rtn.com/dev/v1/channel/user/{appid}/{channelName}/hosts_only 该接口是否有延迟情况?使用该接口时会产生水晶球中显示通话状态已结束，但是接口中还能查到主播id并且channel_exist=true，是否可以用该接口来查询流在线状态

回答思维链：客户应该在用水晶球的 restful 接口，这个接口本身返回的数据存在分钟级别的延迟，如果客户对于延迟有一定要求，可以推荐他用NCS 事件本地维护一套频道内进出状态的表格。

答：您好，存在分钟级别延迟，不是完全实时的。如果要完全准确的话，可以考虑用 NCS 事件本地维护一套频道内进出状态的表格

---

# **编号：34467**

**SDK Product: RTC**

**SDK Version: 4.20.1**

**SDK Platform: Web**

**Request type: 集成问题咨询** 

问：你好，我发现一个问题，就是uid是1的时候，我们的直播画面是不会显示的，监听不到。我在数据库中把用户uid改为2，就看的到直播画面了，这是问什么呢？

回答思维链：客户修改 uid 后就可以加入频道并看到画面了，听起来是加入频道时用的 uid 和频道内已有的重复了导致互踢，因此更换 uid 之前没能看到远端画面，可以和客户解释一下频道内 uid 不能重复的原因

答：您好，音视频互通是通过双方用不同uid 加入相同频道才能实现的，加入频道后去订阅指定 uid 才能看到画面，否则相同 uid 会把先加入的用户踢出频道，可以检查下 uid 是否有重复的情况。

---

# **编号：34432**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳，不达预期**

问：视频录制结束后再阿里云oss并未找到录制的视频内容

回答思维链：客户在咨询云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户没有提到 ts 和 m3u8 的情况，可能是录制上传有些问题或者录制启动没有成功，需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因

答：您好，可以提供下具体的 sid，人工工程师稍后为您解答

---

# **编号：34427**

**SDK Product: RTC**

**SDK Version: 4.19.0** 

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：鉴权使用java端生成的token，在web端使用join的时候报错：Uncaught (in promise) AgoraRTCException: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed，java端和demo流程是一样的

回答思维链：客户使用了自己生成的 token，得到了 invalid token, authorized failed 的报错打印，这表示 token 不匹配，需要检查传入的 uid 频道名是否匹配。

答：您好，invalid token, authorized failed 就是 token 错误，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验

将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# **编号：34422**

**SDK Product: RTC**

**SDK Version: 2.1.6**

**SDK Platform: Linux-Python**

**Request type: 集成问题咨询**

问：示例程序没跑通，连接不上频道，只打印了on_connecting，没打印on_connected
命令：
(yolov8py310) das@das:~/AI4UAVVideo/AIProcessor/Agora$ python agora_rtc/examples/example_audio_pcm_receive.py --appId=4c3d3f3f2d9a4141ad7c436c8755fc77 --channelId=test --userId=8 --sampleRate=16000 --numOfChannels=1

输出：
INFO:common.parse_args:Parsed arguments:Namespace(appId='4c3d3f3f2d9a4141ad7c436c8755fc77', token=None, channelId='test', connectionNumber=1, userId='8', audioFile=None, lowdelay=False, videoFile=None, sampleRate=16000, numOfChannels=1, fps=None, width=None, height=None, bitrate=None, message=None, hours='0', saveToDisk=0, mode=1, value=0)
INFO:common.example_base:------channel_id: test, uid: 8
INFO:common.example_base:connect_and_release: 0, auto_subscribe_audio: 1
INFO:observer.connection_observer:on_connecting, agora_rtc_conn=<agora.rtc.rtc_connection.RTCConnection object at 0x7f4e8321b430>, local_user_id=8, state=2, internal_uid=0 ,reason=0

回答思维链：客户的打印里没有出现加入频道成功的打印，但也没有失败的报错，推测是uid 频道名和 token 不匹配导致没加入频道，可以让客户自查一下，如果没问题，再让客户提供具体日志过来。

答：您好，请问拉的是最新版本 Demo 吗？[https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples)

跑的时候可以注意下 uid 频道名和 token 是否匹配，如果拉最新版本还是跑不通，可以拿一下 SDK 日志过来。初始化的时候可以配置日志等级 [https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile)

---

# **编号：34404**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Flutter**

**Request type: 集成问题咨询**

问：需求：rtm 通信和 rtc 音频通话（不需要视频）。

问题：Android 原生工程集成 rtm 和 rtc 分别有轻量级 sdk（implementation 'io.agora:agora-rtm-lite:x.y.z'） 和 纯音频 sdk （implementation.i'io.agora.rtc:voice-sdk:4.5.1）。

Flutter版本没有提供轻量级的，这样会导致apk包体增加 40MB左右，Flutter有没有办法处理，我们只需要音频的功能即可。

回答思维链：客户只需要在flutter上用音频SDK，需要提供对应的特殊版本才行

答：您好，之前有过一个老版本的纯音频的包：[https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/6.2.6-sp.426.a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/6.2.6-sp.426.a)

yaml 里用git依赖：
agora_rtc_engine:

git:

url: [https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK.git](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK.git)

ref: 6.2.6-sp.426.a

---

# **编号：34395**

**SDK Product: RTC**

**SDK Version: 2.2.0**

**SDK Platform: Linux-Go**

**Request type: 集成问题咨询**

问：我需要在无外网连接下，进行sdk升级。

我是这样做的：

1、在git上下载最新版本的Agora-Golang-Server-SDK代码，解压为：Agora-Golang-Server-SDK-main。

2、下载agora_rtc_sdk-x86_64-linux-gnu-v4.4.31-20241223_111509-491956-aed.zip，重命名放置到Agora-Golang-Server-SDK-main/agora_sdk.zip。

3、运行命令make install。

运行结果和出现问题如下图所示：

go: github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src@v0.0.0-20240807100336-95d820182fef: Get "https://proxy.golang.org/github.com/%21agora%21i%21o/%21tools/%21dynamic%21key/%21agora%21dynamic%21key/go/src/@v/v0.0.0-20240807100336-95d820182fef.mod": dial tcp 142.251.211.241:443: i/o timeout
make: *** [Makefile:33: deps] Error 1

回答思维链：客户在没有链接外网的情况下升级 SDK，虽然替换了 SDK 到目录下，但是make install的时候应该会拉取一些在线依赖，这个是会受影响的，需要建议客户开放到外网的链接再升级 SDK

答：您好，make install的时候应该会拉取一些在线依赖，一点外网都连不上还是有影响的，建议开放网络环境，目前报错的都是拉取其他地址的报错

---

# **编号：34385**

**SDK Product: Convol AI**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：已经创建了一个对话式智能体并且加入了同一个RTC频道，后面应该怎么样与智能体进行语音互动，文档中没有给出发送post请求的地址和携带数据的参数和格式

回答思维链：看起来客户已经跑通了 convolAI 的流程，让 AI 加入频道了，但是不清楚如何和 AI 互动，让客户用客户端加频道以后开麦说话就可以了

答：您好，需要用任意客户端集成我们 SDK 以后进入相同的RTC 频道来互通，你可以先用我们的 Demo 加入：[https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)

[https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)

然后开麦说话就行，如果你完成第五步了你就是进频道发流的状态。确保智能体在频道里工作时和它对话。

---

# **编号：34380**

**SDK Product: RTC**

**SDK Version: 4.0.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：我集成了RTC,然后本地调用了 进阶功能中 播放音效或音乐文件,,主要使用 startAudioMixing 等音乐 API 播放时长较短的音效文件这个方法;
如果我加入频道会单独计费吗,如果不加入频道,调用这个方法,会计算费用吗

回答思维链：客户可能不太了解声网 SDK 的计费模式，只要在频道内发流就会收费，不想产生用量的话，避免加入频道就行了，在频道外调用接口播放本地文件不会产生任何费用。

答：您好，加入频道就会计费，不管发不发流都会计算音频费用。不加入的时候调用接口播放本地文件不会产生任何费用。

---

# **编号：34361**

**SDK Product: RTC**

**SDK Version: 4.2.6**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：根据官方文档关于计费的示例: "2 个人视频通话 10 分钟，则通话总时长为 2 × 10 = 20 分钟".
请问, 如果channel中仅有一个用户,是否会计费呢?

回答思维链：客户可能不太了解声网 SDK 的计费模式，只要在频道内发流就会收费，不想产生用量的话，避免加入频道就行了

答：您好，加入频道就会计费，不管发不发流都会计算音频费用。

---

# **编号：34315**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: Java**

**Request type: 集成问题咨询**

问：我们公司2019年集成了声网SDK 实现视频通话、录制。去年公司服务器清理，不小心把 Agora_Recording_SDK_for_Linux_FULL 这个文件删除了。
昨天在官网下载了 服务端 JAVA v3.0.7 版本更新之后，录制的通话视频全部都是黑屏。请帮忙提供解决方案，谢谢！

回答思维链：客户咨询的问题是本地服务端录制，但是选择了 RTM 分类，应该是选错了。客户使用的还是旧的本地录制 SDK，3.x 的版本已经停止更新维护了，目前最新版本已经来到 4.x 了，但我们需要优先推荐客户使用云录制，如果客户拒绝再提供最新的本地服务端录制 SDK 过去

答：您好，3.x 的本地服务端录制已经停止更新维护了，有录制需求建议走云录制：[https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---

# **编号：34307**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Web**

**Request type: 效果不佳、不达预期**

问：接入web版本，安卓web版本开启关闭扬声器正常，但是苹果的web版本关闭扬声器无效果，苹果需要特殊的设置吗？

回答思维链：Web-IOS 上有一个已知问题描述和客户的现象类似，IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，需要让客户用unsubscribe 的方式来替换实现，可以让客户确认下是否调用了RemoteAudioTrack.setVolume 才出现类似情况
[https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

答：您好，请问现在有调用RemoteAudioTrack.setVolume 方法吗？IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，可以考虑用unsubscribe 的方式来替换实现

已知问题：[https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)
unsubscribe: [https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe)

---

# **编号：34306**

**SDK Product: RTC**

**SDK Version: 4.4.2**

**SDK Platform: HarmonyOS**

**Request type: 集成问题咨询**

问：为了解除某个远端用户的视图绑定，在调用setupRemoteVideo方法时，传入null或者undefined，抛出异常，提示类型错误。
this._rtcEngine?.setupRemoteVideo(null)。
我应该怎么做才嫩解除某个远端用户的绑定视图。

回答思维链：客户正在尝试在HarmonyOS平台上解除远端试图绑定，但是直接给setupRemoteVideo传了null，应该引导客户给videocanvas里的xcomponentId传空

答：您好，不是在setupRemoteVideo里传空，应该给videocanvas里的xcomponentId传空来实现。

---

# **编号：34300**

**SDK Product: RTC**

**SDK Version: 4.0.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：声网加入频道joinChannelWithUserAccount返回0说明加入成功，但是偶现收不到自己加入成功的回调onJoinChannelSuccess，帮忙排查一下原因

回答思维链：没有收到onJoinChannelSuccess 大概率是加入频道失败了，客户以为joinChannelWithUserAccount 返回 0 就表示加入成功的理解是不对的，需要解释一下加入频道需要以会掉为准，并且引导客户监听onConnectionStateChanged 来了解实际的频道链接状态

答：您好，调用 join 方法后 return0 只代表方法执行完毕，收到onJoinChannelSuccess才算加入成功。可以业务上监听onConnectionStateChanged 来判断实际的频道链接状态。参考：[https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection](https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection)

---

# **编号：34299**

**SDK Product: RTC-Linux**

**SDK Version: 2.2.0**

**SDK Platform: Linux-Go**

**Request type: 集成问题咨询**

问：1、我目前使用的demo是go-AIGC-AGEN-DEMO-2.7，用于实现实时语音交互功能，该示例应该阅读哪一个类别的技术文档，web类别吗？
2、该项目目前使用的sdk是[https://download.agora.io/sdk/release/agora_rtc_sdk-x86_64-linux-gnu-v4.4.30-20241024_101940-398537.zip](https://download.agora.io/sdk/release/agora_rtc_sdk-x86_64-linux-gnu-v4.4.30-20241024_101940-398537.zip "Follow link")，[https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/noise-reduction](https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/noise-reduction "Follow link")中描述AI降噪需要 集成 v4.15.0 或以上版本的 Web SDK，v4.4.30和v4.15.0是同一个系列的sdk吗？哪一个版本更新？

回答思维链：客户应该在用 convoAI 的服务端 SDK，问题 1可以让客户拉一下最新的 convoAI go SDK 代码。问题 2 应该是客户想要用 Web 端和 convoAI 的智能体对话，但是不知道服务端 SDK 和客户端 SDK 的区别是什么，可以给他 Web Demo 了解下 Web SDK 和服务端 SDK 的区别

答：您好，服务端要使用 convoAI 的话有自己的 SDK，参考：[https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start-go](https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start-go)

这个 SDK 提供了让智能体加入 RTC 频道的能力，要和智能体互通的话需要用客户端加入频道发流来实现，可以考虑用 Web SDK，具体文档参考：[https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)

convoAI 的服务端 SDK 和 Web SDK 不是一个东西，但都是提供了让各自平台加入 RTC 频道的能力

---

# **编号：34206**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Windows**

**Request type: 集成问题咨询**

问：摄像头和屏幕共享视频合流。尝试用C#调用SDK
int mergeResult = rtc_engine_.
StartLocalVideoTranscoder(new LocalTranscoderConfiguration
{
streamCount = 2,
videoInputStreams = new TranscodingVideoStream[]
{
new TranscodingVideoStream

{ sourceType = VIDEO_SOURCE_TYPE.VIDEO_SOURCE_SCREEN, x = 0, y = 0, width = VideoTrackParam.bgWidth, height = VideoTrackParam.bgHeight, zOrder=0, }

,
new TranscodingVideoStream

{ sourceType = VIDEO_SOURCE_TYPE.VIDEO_SOURCE_CAMERA, x = VideoTrackParam.frontX, y = VideoTrackParam.frontY, width = VideoTrackParam.frontWidth, height = VideoTrackParam.frontHeight, zOrder=1, }

}
});
启动摄像头，屏幕截图正常。合成流在观众端只看到桌面画面，没有看到摄像头画面。摄像头的width=screenWidth/10,height=screenheight/10,
附件是SDK LOg.哪些地方调用错误？

回答思维链：客户在咨询合流发流失败的问题，并且提供了 SDK 日志，可以让客户先自查下是不是join 的时候配置了多个发布视频流的字段，然后等人工工程师稍后解决。

答：您好，可以自查下是不是 join 的时候配置了多个发布视频流的字段，一个 uid 只能发一路视频流的。以及请您稍等，人工工程师稍后会来查看日志解答问题。

---

# **编号：34199**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Windows**

**Request type: 集成问题咨询**

问：windows或者android在调用joinchannelex的时候，多个 channel 的 channelid 和userintid 可以相同吗？

回答思维链：客户在尝试加入多频道，但是不知道频道内的 uid 不能重复，需要强调下频道内 uid 重复会导致互踢的特效，避免此类操作。

答：您好，channelid可以，但是userid 一定不能，频道内 uid 不能重复，否则会导致互踢。

---

# **编号：34195**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：使用声网云录制截图，调用start开始截图，经20秒左右调用stop 报435频道内无推流，但实际上是有推流的，并且期间调用query 返回status 5服务进行中，求解

回答思维链：客户在尝试用云录制的截图上传功能，435 的错误码是指没有可录制内容能够被上传到 OSS 才触发的，如果云录制配置的是仅截图也是会触发的，因为仅截图是不录制内容的，所以需要让客户先自查下有没有配置仅截图。

答：您好，可以检查下是否配置了仅截图，435 的报错是根据是否有录制内容被上传 OSS 来判断的，如果设置了仅截图也是会触发的，但截图还是正常工作的，可以在 OSS 里看看截图文件是否存在。

---

# **编号：34150**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：你好，现在还是会有错误
[ERR] License verified failed, reason: 1
[2025-03-04 14:36:01.714][ERR] License verified failed, reason: 1

回答思维链：这是一个 RTSA 鉴权失败的打印，客户应该是传入了无效 License 或者没有传入 License 导致的，可以引导客户自查下 License 本身是否有效或者有没有传值传错成其他数据。

答：您好，这个打印是License 不正确导致的，可以检查下License 是否有效或者是不是错传成其他值了

---

# **编号：34128**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：我的帐号下面有10个license，是好早前申请的，现在要预授权？

回答思维链：客户应该是在初始化 RTSA SDK，传入 license 的时候遇到了问题。激活 license 的标准流程是申请-预激活-激活-使用，客户应该已经申请完毕了，现在可以引导他去声网 console 自行完成预激活

答：您好，需要在声网 console 左侧边栏自行预授权，预授权完成后再去激活使用

[https://doc.shengwang.cn/doc/rtsa/c/basic-features/license](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license)

---

# **编号：34111**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：请问嵌入式linux由实时音视频的SDK吗？

回答思维链：客户应该是没有找到 RTSA 的文档页面，可以提供下并引导客户跑通 Demo

答：您好，有的，可以看下文档：[https://doc.shengwang.cn/doc/rtsa/c/landing-page](https://doc.shengwang.cn/doc/rtsa/c/landing-page)

先找到您设备对应的 SDK 版本然后跑通 Demo

---

# **编号：34063**

**SDK Product: Flexiable-classroom**

**SDK Version: 2.9.40**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：拷贝文档中心网页上的代码，CDN 集成灵动课堂，修成自己的appid token,登录网页，登录正常，白板也正常，云盘功能不正常。
1. “我的资源”上传资料出现异常，前后上传了两个文档，控制台打印error
2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600064: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
edu_sdk@2.9.40.bundle.js:2 2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600005: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
2. 公共资源，能否统一上传，大家都能看到，如何操作？

回答思维链：客户在用灵动课堂的白板，上传时出错了，看起来问题 1 出在 OSS 上，可以建议用户自查一下 OSS 的存储信息是否正确（比如 endpoint）或者是否配置了跨域规则。问题 2 的公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改，需要咨询下用户的具体需求是什么

答：您好，问题 1 的报错都是 OSS 的，可以去声网 console 上检查一下您的的白板 OSS 相关配置是否正确，比如 endpoint 是否正确、是否开启了跨域配置。

公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改，您这边具体是什么需求？如果是让学生也上传东西的话这个做不到的

---

# **编号：34089**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.31**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：Native 端需要开放的域名、端口、协议：

.agora.io，.sd-rtn.com

udp:8443, 5888-5889, 4000-4100, 8130

tcp:443, 8443, 80

服务端是不是只需要通过这些域名端口访问就行，我们服务还需不需要从服务端接收什么

回答思维链：这是一个linuxSDK 网络环境配置问题；通过问题描述来看，客户的使用环境是有防火墙的，客户侧需要知道声网SDK在有限制的网络环境下如何配置，这里需要是声网云代理方案

答：您好，针对网络访问限制的环境，需要使用声网云代理方案；参考文档如下：
https://doc.shengwang.cn/doc/rtc-server-sdk/java/advanced-features/cloud-proxy

---
# **编号：34077**

**SDK Product: SDK-extension**

**SDK Version: 4.5.0**

**SDK Platform: Android**

**Request type: 线上问题**

问：使用讯飞语言转写出现偶现的崩溃现象
```
#02 pc 000000000012360c /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
4
#03 pc 0000000000121660 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
5
#04 pc 0000000000102ab4 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
6
#05 pc 00000000000ff9e4 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
7
#06 pc 0000000000110588 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
8
#07 pc 00000000000fa538 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
9
#08 pc 0000000000107b7c /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
10
#09 pc 0000000000107848 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
11
#10 pc 0000000000124904 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
12
#11 pc 0000000000124684 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
13
#12 pc 00000000000a4f40 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
14
#13 pc 00000000001733bc /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
```

回答思维链：这是一个使用声网讯飞云市场插件崩溃问题；对于云市场插件相关问题，都需要和客户确认使用的声网sdk版本，之后需要人工工程师内部确认插件版本是否适配。

答：您好，麻烦您这边提供下使用的声网SDK版本，需要等候人工工程师确认对应的插件版本；感谢您的理解与配合，谢谢。

---
# **编号：34061**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：咨询一下，一个频道从创建、到销毁，它的生命周期是怎么维护的，有哪些场景会触发销毁机制，文档没看到说明，如有请提供下文档。谢谢

回答思维链：客户在尝试理解 RTC 的频道什么周期，但是频道的创建和销毁是我们后端完成的，可以告诉客户无需关心，专注于频道内事件。

答：您好，频道的创建和销毁是由我们后端做的，对于用户来说只需要考虑加入频道和退出频道就行，频道里有人就是频道存在，频道里没人就是不存在
https://doc.shengwang.cn/doc/rtc/restful/webhook/events

---

# **编号：34058**

**SDK Product: RTC-Linux**

**SDK Version: 当前版本**

**SDK Platform: Linux-Java**

**Request type: 其他问题**

问：请问连接声网的服务端需要的网络配置有哪些

回答思维链：这是一个使用声网sdk的网络配置问题；正常需要服务器接入公网，有公网 IP；且允许访问 .agora.io 以及 .agoralab.co

答：您好，声网服务端网络要求如下:
服务器接入公网，有公网 IP
服务器允许访问 .agora.io 以及 .agoralab.co

---
# **编号：34044**

**SDK Product: CDN**

**SDK Version: 当前版本**

**SDK Platform: CDN**

**Request type: 其他问题**

问：有没有类似，腾讯的拉流转推功能

回答思维链：这是一个产品功能问题，首先融合cdn是不支持拉流转推的，拉流转推应该是伪直播功能，推荐使用云端播放器

答：您好，融合CDN是不支持拉流能力的；这边您可以使用我们的云端播放器产品，实现拉流播放，参考文档如下：
https://doc.shengwang.cn/doc/media-pull/restful/overview/product-overview

---
# **编号：34041**

**SDK Product: RTMPCONVERTER**

**SDK Version: 当前版本**

**SDK Platform: Restful****

**Request type: 线上报错**

问：你好 我们用无人机进行声网rtmp推流的时候 发现特别卡顿 能帮忙看看问题吗

回答思维链：这是一个rtmpconverter推流卡顿问题，卡顿通常是和端侧网络差、视频采集编码帧率抖动有关，需要具体case具体分析

答：您好，麻烦提供以下信息，以便我们能第一时间展开问题调查
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供

另外也建议咱们检查下无人机的网络是否正常

---
# **编号：34039**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.6**

**SDK Platform: Linux-Python**

**Request type: 集成问题**

问：agora_python_server_sdk中的IVideoEncodedFrameObserver接口，触发时返回的image_buffer[:length]，我需要将缓存的数据进行解码转为图片存储到本地设备，但是使用pyav解码时，总是提示image_buffer[:length]数据无效，或者数据不完整，请问导致问题的原因是什么


回答思维链：这个一个linux-python IVideoEncodedFrameObserver接口使用问题；客户反馈image_buffer数据无效、不完整；比较怀疑是不是推送进来的数据就出现异常；比如可以先在同一个频道加个接收端和python互通，图像是否正常；

答：您好，这里比较怀疑是推送进来的数据就出现异常，建议您这边测试下在同一个频道加个接收端和python端互通，接收端图像是否正常；

---
# **编号：34019**

**SDK Product: RTC-Linux**

**SDK Version: 4.0.1**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：创建 AI 智能体，报错请求参数错误，具体的返回内容：

{"detail":"","reason":"InvalidRequest"}
文档：https://doc.shengwang.cn/doc/convoai/restful/convoai/operations/start-agent

请求参数：

{
"name": "1889f1ac6ac44d8c9bded3c2c4c53e3d",
"properties": {
"channel": "81471e0c5d654e56abf9531e63684a7c",
"agent_rtc_uid": "0",
"remote_rtc_uids": ["*"],
"idle_timeout": 600,
"asr":

{ "language": "en-US" }
}
}

回答思维链：这是一个conversationAI 智能体创建失败的问题；此类问题的通常解决思路是建议让客户使用控制台上的playground测试成功后，点击View Code拿到完整的请求即可

答：您好，您给的请求参数是不完整，建议是先在控制台上的playground测试成功后，点击View Code拿到完整的请求即可；链接如下
https://console.shengwang.cn/product/ConversationAI?tab=Playground

---
# **编号：33985**

**SDK Product: RTC-Linux**

**SDK Version: 当前版本**

**SDK Platform: Linux-Java**

**Request type: 线上问题**

问：1.与声网客户端创建连接，连接不上，回调方法没有打印日志
2.通过webSocket与声网客户端创建连接，发出请求后没有日志打印且没有连接成功

回答思维链：这是一个linux-java 加入频道失败的问题；针对加入频道失败的问题，需要提供问题时间点的agorasdk日志进一步排查
答：您好，麻烦咱们提供以下信息，以便我们第一时间开展排查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. sdklog：https://doc.shengwang.cn/api-ref/rtc-server-sdk/java/classio_1_1agora_1_1rtc_1_1_agora_service_config
另外加入频道失败通常和客户端网络异常，token无效或者过期；您这边也可以检查下，同时也建议咱们业务侧监听下onError 回调，接口参考文档如下：
https://doc.shengwang.cn/doc/rtc-server-sdk/java/error-code

---

# **编号：33982**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.0**

**SDK Platform: Linux-Python**

**Request type: 线上问题**

问：代码： 参考了 https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/release/2.2.0/agora_rtc/examples/common/example_base.py 中的 connect_and_release方法。

错误描述： 调用rtc sdk连接房间失败，十次中会失败一两次。ExampleConnectionObserver中的 on_connecting方法回调了，但是 on_connected没有回调， 且connection.connect返回值为0

回答思维链：这是一个linux-Python SDK加入频道失败的问题，针对加入频道失败的问题，需要提供问题时间点的agorasdk日志
答：您好，麻烦提供以下信息，以便我们能第一时间展开问题调查
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5.sdklog：如果有的话尽量提供，日志设置方式：https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/apidatatype#agoraserviceconfig
另外加入频道失败通常和客户端网络异常，token无效或者过期；您这边也可以检查下，同时也建议咱们业务侧监听下onError 回调，接口参考文档如下：
https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/error-code

---

# **编号：33961**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：mRtcEngine.muteRemoteAudioStream(uid, true); 关闭远程用户的语音流 ， 远程用户 onRemoteAudioStateChanged 回调未触发

回答思维链：客户以为 muteRemoteAudioStream 会控制远端的发流状态，需要提醒客户muteRemoteAudioStream 只能控制本端不订阅，onRemoteAudioStateChanged 回调只有在远端自己改动发流状态的时候才会触发

答：您好，muteRemoteAudioStream只是控制本端不去订阅远端发出的音频流，不会控制远端的实际发流情况。
onRemoteAudioStateChanged是远端用户采集、发送层面出现变动时才会触发的回调，mute 方法不会影响到远端的实际发流所以不会触发。

https://doc.shengwang.cn/api-ref/rtc/android/API/toc_publishnsubscribe#api_irtcengine_muteremoteaudiostream

https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#onRemoteAudioStateChanged

---

# **编号：33944**

**SDK Product: Analytics**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上问题**

问：接口文档地址：https://doc.shengwang.cn/doc/analytics/general/restful-aa/operations/get-beta-insight-usage-by_time
请求地址：
https://api.sd-rtn.com/beta/insight/usage/by_time?start_ts=1738857600000&end_ts=1739499359000&appid=cf32bef49b4d47e0bdaf6dace009ae49&metric=totalDuration&aggregateGranularity=1h
响应结果：
{
"code": 400,
"message": "Bad request, parameter : startTs can not be null",
"data": null
}
接口提示startTs没传，后改为
https://api.sd-rtn.com/beta/insight/usage/by_time?startTs=1738857600000&endTs=1739499359000&appid=cf32bef49b4d47e0bdaf6dace009ae49&metric=totalDuration&aggregateGranularity=1h
响应结果：
{
"code": 500,
"message": "Unknown Error",
"data": null
}


回答思维链：这是一个水晶球restful请求失败的问题，通常来说 返回500 都是内部错误，需要人工工程师介入排查

答：您好，感谢您联系声网技术支持，我们已收到您提交的工单，正在为您处理。另外针对这个问题，建议您：
1、再检查以下查询参数格式，是否异常或者有不合法的字段

---

# **编号：33931**

**SDK Product: RTC**

**SDK Version: 4.23.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：如何在使用过程，切换转换前置和后置摄像头

回答思维链：客户需要在Web上实现切换设备，可以让客户参考我们Demo的实现，用setDevice来切换。

答：您好，可以参考我们Demo的实现，用setDevice来切换

https://doc.shengwang.cn/doc/rtc/javascript/basic-features/switch-device

https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo

---

# **编号：33930**

**SDK Product: RTSA**

**SDK Version: 1.7.3**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：1. 使用定向流量卡，定向流量白名单IP包括以下：
*.agora.io
*.agoraio.cn
*.sd-rtn.com
2.设备无法正常加入直播间

回答思维链：这是一个RTSA SDK 设备使用流量卡加入不了频道的问题；通常针对定向流量卡的适配，是需要先向运营商报备相关域名以及在初始化代码设置domainLimit

答：您好，针对定向流量卡接入，需要您这边参考如下方案实现：
1）、 向运营商报备*.agora.io, *.
sd-rtn.com两个通配域名（至少需要*.
agora.io，最好是也加上*.
sd-rtn.com以满足高可用需求）。如需区域限制功能，需要增加*.
agoraio.cn这个通配域名。

2)、 代码设置
```java
RtcEngine create(RtcEngineConfig config) RtcEngineConfig->domainLimit = true

/**

Determines whether to enable domain limit
-true: only connect to servers which already parsed by DNS
-false: (Default) connect to servers with no limit
*/

bool domainLimit;

```


---

# **编号：33918**

**SDK Product: RTC**

**SDK Version: 4.4.2**

**SDK Platform: HarmonyOS**

**Request type: 集成问题咨询**

问：1.问题表现  
ERROR: Error: Cannot read properties of undefined (reading 'split')  
2.复现步骤  
1）根据IM通信的快速开始前提条件进行配置  
2）当使用sdk中的方法或类时进行编译  
3）编译未通过，报错信息为Error: Cannot read properties of undefined (reading 'split')

回答思维链：客户提交的SDK Product是 RTC，但是问题内容里提到了 IM，不确定他现在用的产品到底是哪个，需要优先确认下正确的相关信息。以及看打印是调用了undefined的对象，并进行操作了的报错，可以让客户检查下依赖添加是否正确。

答：您好，请问您这边目前在用的是声网 RTC 还是 IM 呢？麻烦确认下目前使用的产品是哪一个。以及看打印像是依赖添加有问题导致调用了undefined的对象，可以检查下这个 SDK 的依赖添加是否正确。

---

# **编号：33916**

**SDK Product: RTC**

**SDK Version: 4.3.0**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：咨询虚拟直播

回答思维链：客户在咨询虚拟直播，但没有提到具体问题是什么，可以让客户留个联系方式方便后续人工工程师跟进，以及建议客户列举下具体想要讨论的问题内容。

答：您好，请问这里说的“虚拟直播”具体是什么场景？可以完整描述下问题和需求以及留个联系方式吗？人工工程师稍后为您解答。

---

# **编号：33910**

**SDK Product: Flexible-classroom**

**SDK Version: 2.8.100**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：请问该灵动课堂如何配置 同步播放设备的屏幕

回答思维链：客户的需求是“同步播放设备的屏幕”，听起来是屏幕共享的意思，可以和客户确认下是不是这个需求。如果是的话，需要提醒客户灵动课堂的移动端不支持屏幕共享，只有 Web 或者 Electron 才支持

答：您好，请问您说的“同步播放设备的屏幕”是指屏幕共享吗？如果是的话需要注意：移动端灵动课堂不支持屏幕共享，Web 和桌面端支持，可以跑下对应的 Demo，修改相关配置：https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#mediaoptions

---

# **编号：33906**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.**

**SDK Platform: Linux-Go**

**Request type: 集成问题咨询**

问：OnPlaybackAudioFrameBeforeMixing回调的音频流编码是什么格式的?

回答思维链：这是一个linux-go 音频裸数据接口使用问题，可以给客户发下官网文档接口说明；另外声音的音频裸数据回调格式默认是PCM 16位的

答：您好，OnPlaybackAudioFrameBeforeMixing 接口回调的音频格式默认是PCM 16位，您可以参考如下文档：
https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/audioframeobserver
同时您这边可以通过SetPlaybackAudioFrameBeforeMixingParameters接口设置pcm的声道数和采样率
https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/localuser#setplaybackaudioframeparameters

---

# **编号：33897**

**SDK Product: Fastboard**

**SDK Version: 0.3.22**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：Fastboard web集成是否支持比较老的项目环境？  
昨天使用vite+vue3集成完成，但是老项目使用的webpack+vue2，集成进去后报错mobx使用错误。  
不影响大部分功能的使用，但是无法选择画笔颜色

回答思维链：客户提到自己的环境项目较老，集成后会报错mobx使用错误，推测是webpack 可能会不识别新语法导致的，之前有其他用户也遇到过类似问题：[https://github.com/netless-io/fastboard/issues/23](https://github.com/netless-io/fastboard/issues/23)。应该推荐客户避免使用旧的打包器，因为 SDK 再发版本也不会适配旧的打包器版本了

答：您好，webpack 可能会不识别新语法，参考：[https://github.com/netless-io/fastboard/issues/23](https://github.com/netless-io/fastboard/issues/23)
如果某些老打包器会有问题就更换吧，后续 SDK 不会再针对旧的去做适配了。

---

# **编号：33892**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type: 崩溃 (闪退、卡死)**

问：推拉流掉帧，卡顿

回答思维链：客户反馈了掉帧问题，但是没有提供具体的频道信息，无法一句话就解答完毕。应该找客户收集频道号、uid 、时间点以及问题现象，方便后续人工工程师排查问题

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例) (1) uid=123 听不到/看不到 uid=456，大约持续20分钟 (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：33888**

**SDK Product: rtmpconverter**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上报错**

问：1. 问题表现，使用旁路推流，无法将RTC的主播流旁路推流到声网的CDN

2. 问题现场信息
APPID: 7c14653b67e34bc7a2d5941f1544fef7
channelId: 7c14653b67e34bc7a2d5941f1544fef7:1581F6Q8X24BP00G019C:81-0-0
旁路推流开始时间： 11:23:50
旁路推流地址： rtmp://pushcloudlive.czi.com.cn/live/7c14653b67e34bc7a2d5941f1544fef7:1581F6Q8X24BP00G019C:81-0-0

回答思维链：这个一个rtmp-converter推流失败的问题，客户已经提供了频道号、时间点以及推流地址；需要人工技术工程师排查后给出答复。
答：您好，感谢您联系声网技术支持，我们已收到您提交的工单，正在为您处理。另外针对这个问题，建议您：
1、先查下converter是否创建成功，调用创建的接口是否返回200；
2、检查rtmp地址是否可用，以及是否正在被应用使用；

---

# **编号：33881**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.2**

**SDK Platform: Linux-Go**

**Request type: 集成问题咨询**

问：PushPCMData 发送的数据比特率和采样率是多少？发送的语音消息过快，导致播放音频变成噪音

回答思维链：这是一个linux-go sdk 自采集音频接口相关的问题，通常音频的pcm的样本字节数是16位的，采样率最低是8000；这里可以参考官网的接口文档；对于发送的语音消息过快，声网这里推荐是10ms发送一次音频采样样本；

答：您好，对于接口使用来说，您这边可以参考我们的官网的接口使用说明，链接如下：
https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/apidatatype#audioframe
另外对于音频发送过快导致的噪声问题，声网建议是每10ms发送一次音频采样样本。


---

# **编号：33848**

**SDK Product: Media-push**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：旁路推流可以推rtsp的流吗？或者平台有转rtsp流的功能吗

回答思维链：客户在咨询旁路推流是否支持推 rtsp 流，这个是不支持的。后半句又有转换 rtsp 流的需求，可以咨询下客户目前的场景，了解下是什么原因让客户如此需要 rtsp 流，理论上 RTMP 和  RTSP 的区别不会特别大。

答：您好，不支持，平台也不提供转换的能力。请问您这边是什么场景一定需要 RTSP？可以考虑下用旁路推流推到 RTMP 地址上然后自行转换到 RTSP地址。

---

# **编号：33836**

**SDK Product: Media-pull**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：使用在线媒体流功能，AppID=3fdb8517f7f84aed9198e2960f3f4400，房间号：test_agora；  
请求参数中开启了如下配置，通过数据流返回点播流播放进度：  
"dataStreamOptions":

{ "enable": true }

然后使用API-Examples中的「Create Data Stream」demo看收到的消息都是固定的（长度为21个字节）：  
66 72 6f 6d 3a 20 31 39 38 37 37 20 6d 65 73 73 61 67 65 3a 20，转换为ascii码为：from: 19877 message:

回答思维链：客户使用了输入在线媒体流服务，并且在字段里开启了datastream 配置来传递点播流总时长，但客户好像没有提到自己有没有使用Protobuf解析，可能是造成无法解析点播进度的原因。可以让客户检查下相关实现。

答：您好，如果通过 Data stream 展示点播流总时长，发出的 Data stream 需要使用 Protobuf 解析，而不能用 ASCII 码直接解析。可以确认下现在的实现有没有用 Protobuf 去解析，参考文档内相关字段描述：https://doc.shengwang.cn/doc/media-pull/restful/media-pull/operations/get-region-v1-projects-appId-cloud-player-players

---

# **编号：33830**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: Java**

**Request type: 商务问题**

问：本账号原来用的是体验版，但是24年9月份确自动变成了企业版，请问为什么会变成企业版，套餐的变更，并不是我们主动变更的，而且自动变成企业版后又产生了费用，这个问题谁来处理，如何处理？

回答思维链：客户是在问商务问题，这类问题无需回答，引导客户等到人工工程师跟进或联系商务

答：您好，人工工程师稍后跟进为您解答，如果您需要联系商务，请使用以下方式： 
- 销售邮箱： sales@shengwang.cn 
- 填写联系销售表单：[联系表单链接](https://www.shengwang.cn/contact-sales/) 
- 客服电话： 400 632 6626

---

# **编号：33827**

**SDK Product: RTM**

**SDK Version: 2.1.4**

**SDK Platform: Java**

**Request type: 集成问题咨询**

问：你好，我们在开发过程中，通过询问Ai助手得知类似禁言等一些功能需要我们的后端去实现，助手给了一些接口，咨询助手接口的文档后，根据指引没有找到对应的后端文档，例如它给的[https://doc.shengwang.cn/doc/rtm2/restful-api](https://doc.shengwang.cn/doc/rtm2/restful-api "Follow link")，访问是404，或者点击rtm的文档，看到的也都是一些前端的文档和sdk，你们有技术可以拉群吗

回答思维链：客户想要在 RTM 上实现 restful 接口实现 RTM 的禁言功能，RTM 本身是无法实现这个需求的，只有 RTC 有后台封禁用户、禁言的 restful 接口，之前回复的 AI 已经给出了错误回答，所以接下来的回答一定要再谨慎一点。

答：您好，RTM 是没有类似 RTC 那样的封禁、禁言 restful 接口的，如果有聊天发言管控的续期，可以考虑接入环信 IM，环信这类即时聊天的 SDK 是拥有 restful 封禁能力的，RTM 作为信令传输 SDK 没有这个能力。

---

# **编号：33823**

**SDK Product: RTM**

**SDK Version: 2.2.0**

**SDK Platform: JavaScript**

**Request type: 集成问题咨询**

问：您好，请问RTM2.x有类似1.x点对点一样的hasPeerReceived判断对方已经收到消息的方法吗？

回答思维链：RTM2.x 里发送消息是有Promise PublishResponse的，客户可以直接监听方法执行完的 result 来判断消息是否发送成功，让客户参考文档里的示例代码即可。

答：您好，2.x 上publish方法本身就是带Promise的，您可以监听方法执行完成的 result 来判断消息是否发送成功，参考文档：https://doc.shengwang.cn/api-ref/rtm2/javascript/toc-message/message#publish

---

# **编号：33819**

**SDK Product: CDN**

**SDK Version: 当前版本**

**SDK Platform: CDN**

**Request type: 集成问题咨询**

问：跨频道流媒体转发这个要怎么开启，或者在站内开启哪个就可以了，文档太模糊完全搞不懂

回答思维链：客户提交的产品是 CDN，但问的是 RTC 的跨频道流媒体转发功能，这个是 RTC 才会用到的能力，可以让客户先确认下自己目前在用的产品到底是哪一个。

答：您好，跨频道流媒体转发需要人工工程师为您手动开启，但这个服务是给 RTC 使用的，您工单里提交的问题产品是 CDN，CDN 是用不上这个功能的，请确认下您现在要用 RTC 还是 CDN，这是两套完全不同的产品。

---

# **编号：33813**

**SDK Product: RTC**

**SDK Version: 4.22.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：使用 rtc 开启直播时使用 createCameraVideoTrack(
{ encoderConfig: '720p', cameraId: videoId }
) 发布 720p 的视频流，在某些时候会变成推送 680 * 480 的流  
通过 ILocalVideoTrack 中的 setEncoderConfiguration 无法修改， 重新初始化也不能修改为 720p
想问下有可能原因有哪些，如何排查？

回答思维链：客户在指定了编码为 720 的情况下依旧达不到编码预期，推测可能是浏览器限制了编码，可以让用户调用浏览器接口看下浏览器的选择是什么分辨率，如果浏览器原生接口返回的就是低分辨率，那有可能和硬件自身的限制有关。

答：您好，编码分辨率选择上不去是浏览器行为导致的，您可以调用浏览器原生接口看下得到的分辨率配置是不是本身就低于预期。
getSettings是 WebRTC 官方的接口，这个接口是浏览器根据你的硬件能力最终选择的分辨率配置，属于浏览器行为
getConstraints是你直接设置的配置，但只能告诉浏览器你期望设置到什么分辨率的采集，实际的情况还要看硬件上限以及浏览器行为选择，一般会受到硬件自身限制的影响。
https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/getSettings
https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/getConstraints

---

# **编号：33803**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Java**

**Request type: 集成问题咨询**

问：maven 包： 2.2.2-beta  
问题描述： 在k8s 内运行，首次可以调用 rtm 成功，第二次login rtm后，就无法加入 channel，日志执行到： log.info("rtm_start_join_channel"); 服务就卡死了

回答思维链：看客户的问题描述是卡死，但不确定客户在第二次初始化并且调用 login 的时候有没有先销毁第一个实例，RTM 不支持多实例，只能全局保留一个实例，需要和客户确认下。

答：您好，看您的描述像是创建了多个实例导致的，请问您有先销毁第一个实例以后再去创建新的实例并且调用 login 吗？
如果您自查看不出来，可以提供下 SDK 日志，人工工程师稍微为您看下具体情况：https://doc.shengwang.cn/doc/rtm2/android/error-codes

---

# **编号：33781**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：1云端录制是否支持上传录制文件到七牛云  
2云端录制是否支持m3u8文件加密  
3支持最大开启直播数量是多少

回答思维链：客户提问了 3 个问题，问题 1 是不支持的，可以提供下目前支持的 OSS 厂家枚举文档给客户。问题 2 是支持的，支持kms或者aes256，引导客户在 start 的时候自行配置字段 extensionParams-sse就行。问题 3 看起来不是云录制的问题，似乎是在问 RTC 有没有同时开播的频道数量上限，需要再确认下客户需求

答：您好，
1、不支持，目前我们支持的 OSS 厂商都在这里：[https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference)
2、支持kms或者aes256，在 start 的时候可以自行配置字段 extensionParams-sse，参考：https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start
3、请问您说的最大开启直播数量是指什么？是指 RTC 同时开播的频道数上限吗？如果是问这个的话，答案是没有上限的。

---

# **编号：33779**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Java**

**Request type: 集成问题咨询**

问：创建 RtmClient 时报错：Exception in thread "main" java.lang.UnsatisfiedLinkError: no aosl in java.library.path

代码如下：  
RtmConfig rtmConfig = new RtmConfig.Builder(APPID, userId)  
.eventListener(mRtmEventListener)  
.build();  
mRtmClient = RtmClient.create(rtmConfig);

实际报错如下：  
Exception in thread "main" java.lang.UnsatisfiedLinkError: no aosl in java.library.path  
at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1867)  
at java.lang.Runtime.loadLibrary0(Runtime.java:870)  
at java.lang.System.loadLibrary(System.java:1122)  
at io.agora.rtm.internal.RtmClientImpl.safeLoadLibrary(RtmClientImpl.java:200)  
at io.agora.rtm.internal.RtmClientImpl.loadLibrary(RtmClientImpl.java:181)  
at io.agora.rtm.internal.RtmClientImpl.initializeNativeLibs(RtmClientImpl.java:143)  
at io.agora.rtm.RtmClient.create(RtmClient.java:34)  
at com.xnx3.chongwulong.RtmDemo.init(RtmDemo.java:66)  
at com.xnx3.chongwulong.RtmDemo.main(RtmDemo.java:148)

回答思维链：客户的打印里有“no aosl in java.library.path”，看起来是没有配置本地变量路径。可以让客户参考我们的 README 文档配置下本地变量再试试

答：您好，“no aosl in java.library.path”是本地变量没有配置好路径才会出现的报错，请问您这边有参考过我们 README 里的步骤，去配置环境吗？
https://github.com/AgoraIO/RTM2/tree/main/Agora-RTM2-QuickStart-Linux-Java#4-build-and-run

---

# **编号：33775**

**SDK Product: RTMP-Converter**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 效果不佳、不达预期**

问：无人机直播正常，使用旁路推流功能向阿里云推流；
阿里云接收到的流是黑屏

回答思维链：这个一个rtmp-converter 推流黑屏的问题，客户反馈直播正常，说明rtc采集是正常，问题出在推流环节，需要先和客户收集频道信息看下推流数据是否正常
答：您好，麻烦咱们提供以下信息，以便我们第一时间开展排查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供

---
# **编号：33772**

**SDK Product: RTC**

**SDK Version: 6.5.0**

**SDK Platform: Flutter**

**Request type: 集成问题咨询**

问：能夠在直撥元件首次載入的時候預設使用後置攝像頭嗎？能的話該如何做？不能的話能怎麼辦？

回答思维链：客户想要在直播加频道的时候直接用后置摄像头开播，提示客户在 setCameraCapturerConfiguration 的时候指定使用后置摄像头，这样加入频道就默认用后置摄像头了。

答：您好，可以使用 setCameraCapturerConfiguration 来指定 前置 or 后置 摄像头。不过请注意，该方法必须在开启本地摄像头采集前调用。
https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_video_device#api_irtcengine_setcameracapturerconfiguration

---

# **编号：33768**

**SDK Product: RTM**

**SDK Version: 2.1.12**

**SDK Platform: Java**

**Request type: 线上报错**

问：调用登录方法 RTM ERROR: login failed, error code: DUPLICATE_OPERATION, reason: Same subscribe, join or login request. 这个错误该如何解决 对我来说很重要请帮忙去询问开发 造成原因和解决方案 不要敷衍 感谢

回答思维链：客户在用 RTM 产品，报错内容是error code: DUPLICATE_OPERATION, reason: Same subscribe, join or login request，应该是执行了重复的 login 操作导致 login 失败，应该让客户检查下自己的 login 调用相关业务，看下现在是按什么逻辑处理的

答：您好，报错显示DUPLICATE_OPERATION，这表示 login 失败是因为重复操作导致的，您可以检查一下 login 相关的代码业务逻辑，看下什么情况会触发多次登录调用。
https://doc.shengwang.cn/doc/rtm2/javascript/error-codes

---

# **编号：33755**

**SDK Product: RTC-Linux**

**SDK Version: 4.2.31**

**SDK Platform: Linux-C**

**Request type: 效果不佳、不达预期**

问：这是用阿里云的ecs推流到声网， 阿里的出口带宽是200M，但从水晶球看网络波动比较大，请问是什么原因？

回答思维链：这个一个服务端推流带宽异常的问题，首先需要和客户确认推流方式，是自采集还是自编码方式；然后需要和客户收集频道号，uid，时间点等信息查询频道内linux上下行带宽情况；
答：您好，请问您这边使用的视频推流使用的是自采集yuv还是自编码方法？另外也麻烦咱们提供以下信息：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供，日志设置方式：https://doc.shengwang.cn/api-ref/rtc-server-sdk/cpp/structagora_1_1commons_1_1_log_config

---
# **编号：33754**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：【环境】
前端vue项目： 采用 sdk包，版本是："agora-rtc-sdk-ng": "^4.12.1",  
后端java项目：采用github源码，版本是：

<groupId>io.agora</groupId>  
<artifactId>authentication</artifactId>  
<version>2.1.2</version>  
<description>Agora Authentication</description>

利用RtcTokenBuilder2Sample.java生成了 Token （Token with uid)，该Token在辅助工具--Token校验工具中，是校验通过的。

【问题】  
前端代码在运行时，提示：  
AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed
出现问题的调用代码：
agoraClient.join(agoraPara.appid, agoraPara.channel, agoraPara.token)
【尝试过】  
已经检查过“客户端”join()的参数appId、chanel和“服务端”生成token时完全一致；
【疑问】  
1、是因为web-sdk版本和服务器authenticated的 maven版本不匹配导致的吗?  
2、我看论坛有些提及join方法需要加 uid为最后的参数，我也尝试过，加入后，不会提示 「invalid token, authorized failed」，但是直播画面是【黑屏】。
以上问题，烦请声网专家支持，不胜感激。

回答思维链：客户遇到了 invalid token的打印，这就是 token 不正确导致 join 失败了。加上用户的疑问，看起来不太了解 token 的工作原理，除了告诉客户如何自查 token 以外还可以介绍一下 token 的工作原理。

答：您好，invalid token, authorized failed表示您 join 是传入的 token 和频道名、uid 不匹配，自己生成的 token 是要校验 uid 的，您需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

以及请保证 RTC 频道内的 uid 不重复，避免出现互踢情况。

---

# **编号：33752**

**SDK Product: RTC**

**SDK Version: 4.5.0**

**SDK Platform: Unity**

**Request type: 集成问题咨询**

问：Unity 使用 Agora_Unity_RTC_SDK_v4.5.0_VOICE SDK时，平台为VisionOS,打包Xcode工程进行编译时，会出现错误：  
Undefined symbol: _AddVideoFrameCacheKey
Undefined symbol: _CallIrisApi
Undefined symbol: _CreateIrisApiEngine
Undefined symbol: _CreateIrisEventHandler
Undefined symbol: _CreateIrisRtcRendering
Undefined symbol: _DestroyIrisApiEngine
Undefined symbol: _DestroyIrisEventHandler
Undefined symbol: _FreeIrisRtcRendering
Undefined symbol: _GetVideoFrameCache
Undefined symbol: _ILocalSpatialAudioEngine_ClearRemotePositions
Undefined symbol: _ILocalSpatialAudioEngine_ClearRemotePositionsEx

回答思维链：客户在尝试打包到 VisionOS 上使用，但使用的是 4.5.0 的官网版本。目前Unity 只有一个内部特殊版本适配了 VisionOS ，需要让人工工程师提供内部下载地址给到客户。

答：您好，目前只有一个未上架官网的版本适配了 VisionOS，您稍作等待，人工工程师稍后提供下载地址为您解答。

---

# **编号：33748**

**SDK Product: RTC**

**SDK Version: 6.5.0**

**SDK Platform: Flutter**

**Request type: 集成问题咨询**

问：目前根据文档集成了本地截图功能，但是没有上传成功且没有收到回调，目前不知道到底是客户端问题还是服务端问题，请问如何进行自查：  
已知：  
1. 回调地址能够正常访问  
2. 本地截图配置：
```
engine.enableContentInspect(enabled: true, config: const ContentInspectConfig(extraInfo: "test", modules: [ContentInspectModule(interval: 5, type: ContentInspectType.contentInspectSupervision)])) 
```

3. 打开后输出：
```
api name RtcEngine_enableContentInspect_e15e514 params "{"enabled":true,"config":{"extraInfo":"test","modules":[
{"type":2,"interval":5}
]}}"
和 
api name RtcEngine_enableContentInspect_e15e514 result 0 outdata
{"result":0}
```
4. 使用flutter集成，无dll问题

回答思维链：客户在使用客户端 SDK 的本地截图功能，虽然调用成功但是没有回调。需要确认下客户端 SDK 日志，以及让用户自查下网关是否有拦截情况

答：您好，麻烦提供下复现时的 SDK 日志，人工工程师稍微排查下具体原因。以及您也可以自查下是否存在网关拦截的情况。
https://doc.shengwang.cn/faq/integration-issues/set-log-file

---

# **编号：33747**

**SDK Product: RTM**

**SDK Version: 2.1.2**

**SDK Platform: JavaScript**

**Request type: 集成问题咨询**

问：RTC成功了，音视频可以看到，RTM一直报错，排查uid、token应该也没发现不一致地方

RTM:ERROR [UTC_Time: 02:44:25.38][uid: 3*12]login failed with args:
{"tok**":"00681c759d8f65042f9b0c32564671dd478IAADXpNcE3ebSiooiLtiuvfbLF+g/LAKjorEGH5aNejfK***********************************"}
. +0ms

_MultiCameraControl.vue?t=1737081851336:304 rtm login error RtmInternalError: Cannot get illegal sid.  
at get sid (agora-rtm-2.2.0.min.js:27:1040009)  
at MutableReactiveHandler.set (chunk-O6NV3OV2.js?v=378681a1:1215:26)  
at Proxy.login (agora-rtm-2.2.0.min.js:27:1099248)  
at Proxy.login (agora-rtm-2.2.0.min.js:27:1135756)  
at i.value (agora-rtm-2.2.0.min.js:7:271685)  
at createTrackAndPublish (_MultiCameraControl.vue?t=1737081851336:297:36)

回答思维链：打印里有Cannot get illegal sid的错误，而且在用vue，根据过往经验有遇到过其他客户在vue3里面把 new RTM 返回值赋值给了 ref 类型，改成普通 let 就可以了，可以让客户先自查一下是不是这个问题导致的。

答：您好，请问您这边在用 vue3 吗？我们之前遇到过其他客户也有类似的情况，最后发现是在vue3里面把 new RTM 返回值赋值给了 ref 类型导致的，改成普通 let 就可以了。您可以自查一下有没有类似情况。
如果无法解决的话，麻烦再提供下完整浏览器 console 打印，以及确认下 token、appid、userid 信息，人工工程师会为您继续排查。


---

# **编号：33744**

**SDK Product: RTM**

**SDK Version: 2.1.0**

**SDK Platform: Unity**

**Request type: 集成问题咨询**

问：我测试直播，我的产品是用unity写的，一直都连接很好，但是创建项目你们版面都会不同，不知道我现在开的项目，测试直播填上了APID，没有影像，请问哪里出了错？

回答思维链：客户提供的信息较少，而且问题描述不够清晰，需要再确认下目前的具体现象和“创建项目你们版面都会不同”是什么意思，以及客户提交的问题产品是 RTM，但是有提到没有影像。可能也有用到 RTC ，需要一起确认下。

答：您好，请问现在在用的产品是 RTC 还是 RTM？如果是 RTC 遇到了无法出图的问题，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

以及请问您反馈的“创建项目你们版面都会不同”具体是什么意思？麻烦也详细描述下这个现象，方便的话，麻烦提供截图，人工工程师稍后为您解答。

---

# **编号：33738**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：麻烦帮忙查下在调用/v1/apps/%s/cloud_recording/resourceid/%s/sid/%s/mode/mix/query这个接口时，sid：b024c073b94e0419c10b53aef14bcb71
接口返回404，请问什么情况下会返回404-服务器无法根据请求找到资源（网页）？这些参数都是从声网获取的，为什么会404？

回答思维链：客户成功开启云端录制后调用 query 方法返回了 404，可以让客户先参考文档自查，然后等人工工程师查找对应sid 的记录看下具体原因：https://doc.shengwang.cn/faq/integration-issues/return-404

答：您好，query 404 是被查询的录制任务不存在或已经结束了，您可以先对照这篇文档自查一下，人工工程师稍后会查询 sid 的后台记录看下具体原因
https://doc.shengwang.cn/faq/integration-issues/return-404

---

# **编号：33714**

**SDK Product: RTMP**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：在测试环境生成推流码，通过测试环境的域名 rtmp://rtls-ingress-test.agoramdn.com/live 一直推流不成功

回答思维链：客户选的是旁路推流，但问的问题是RTMP 网关，需要和客户再次确认下用的到底是哪个产品。如果是 RTMP网关的话，这个推流域名地址不应该有 test，正确的地址是 rtls-ingress-prod-{region}.agoramdn.com/live

答：您好，请问现在在用的是旁路推流还是 RTMP 网关？这是两个不同的产品。如果是后者的话，需要注意：推流域名地址不应该有 test，正确的地址是 rtls-ingress-prod-{region}.agoramdn.com/live
参考文档：https://doc.shengwang.cn/doc/rtmp-gateway/restful/get-started/use-gateway

---

# **编号：33707**

**SDK Product: RTM**

**SDK Version: 2.1.2**

**SDK Platform: JavaScript**

**Request type: 线上报错**

问：聊天的服务,每个人都能在群里说话， 有人捣乱的话 在群里能够把他踢出去+能够把他说的话清除

回答思维链：客户需要踢人和清除聊天记录的功能，RTM 是不具备这些的，客户的需求更接近即时聊天，可以推荐客户用环信 IM 来实现

答：您好，踢人和清除聊天记录的功能 RTM 本身不具备，您可以考虑下用即时聊天 SDK 来实现类似功能，比如环信 IM：https://www.easemob.com/

---

# **编号：33704**

**SDK Product: Recording**

**SDK Version: 其他版本**

**SDK Platform: Linux-Java**

**Request type: 线上报错**

问：发现在录制过程中，有时候会出现调用stopService 返回-1的情况，导致结束录制出现异常

回答思维链：客户在用本地服务端录制，应该先引导用户用云录制，在客户明确拒绝后再尝试索要日志进行排查

答：您好，有录制需求我们优先推荐用云录制：https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page

---

# **编号：33699**

**SDK Product: RTC**

**SDK Version: 4.4.2**

**SDK Platform: HarmonyOS**

**Request type: 集成问题咨询**

问：鸿蒙的声网sdk。我在设置了这个enableLocalAudio(false)的时候，除了第一次回调了没有权限之后，我增加了权限之后，就没有回调了。

回答思维链：客户在用鸿蒙 SDK，但是没有说明“没有回调”具体指的是什么回调，需要确认下具体现象以及客户说的回调是哪个回调。并且收集日志以便稍后人工工程师解答，因为客户用的是鸿蒙 SDK，所以获取日志的方式是：hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files

答：您好，enableLocalAudio是控制本地音频采集的接口，设置为 false 以后就关闭采集了。请问现在的现象是接收不到哪一个回调？
以及有复现时的 SDK 日志吗？鸿蒙获取日志的方式为：hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files，您可以完整描述下现象并且提供对应时间的日志，人工工程师稍后为您解答

---

# **编号：33698**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：这个sdk 在windows上可以使用吗

回答思维链：linux-java sdk 的使用环境必须是linux环境，window平台是不能使用的

答：您好，linux-java sdk的使用环境必须是linux系统，如centos或者ubuntu；是不能再window上使用的

---

# **编号：33695**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: JavaScript**

**Request type: 线上报错**

问：调用rtmClient.login（）显示超时

回答思维链：客户可能在用 1.x 的老版本，可以先确认下版本情况，如果是的话要建议客户早日升级 2.x。以及 login 超时大概率是客户端自身网络连接有问题，可以让客户也自查一下是否能连接到公网，换一个网络再试试。

答：您好，请问现在在用的 RTM 版本是多少？1.x 已经停止更新维护了，建议使用 2.x 版本：https://doc.shengwang.cn/doc/rtm2/javascript/overview/migration-guide
login 超时大概率和客户端网络有关，可以检查下客户端的网络状况，切换可以稳定连接公网的热点或者 wifi 再试试。

---

# **编号：33689**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上报错**

问：该云端录制未生成回放，麻烦看一下什么原因：  
sid:ad98e85fb842db158b928aa97908ec47  
channelName:course-e08f1d45

回答思维链：客户已经提供 sid 和频道名了，接下来等待人工工程师处理就够了。可以考虑再收集一下具体的录制时间点。

答：您好，可以再确认下录制发送的时间点吗？人工工程师稍后为您排查

---

# **编号：33686**

**SDK Product: RTM**

**SDK Version: 2.2.0**

**SDK Platform: JavaScript**

**Request type: 集成问题咨询

问：我创建安卓应用，需要哪些合法域名，是否有限制

回答思维链：创建 app 不需要合法域名，如果客户本身在内网需要使用 RTM 服务的话是需要付费私有化部署并且使用代理的，可以和客户解释一下。

答：您好，创建 app 不需要合法域名，但是需要能够连接到公网的网络。如果是内网环境会需要付费私有化部署并且使用代理才可以使用。
https://doc.shengwang.cn/doc/rtm2/android/user-guide/setup/private-setup

---

# **编号：33683**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期

问：1、开始录制正常，停止录制在oss中为生成MP4格式文件；  
2、停止录制返回结果如下，payload显示Failed，具体结果如下：
{"cname":"123456","uid":"10002","resourceId":"VIFvR6qvdFkRNRDsj9uhhEgnjLZrTmUD8olvImTJYa2AG3nJ3sFuW56NIVBSlorjqUXA8NREU7o_0O_OqzHYDuRpxX7YoztodTrox6tqSFWRPhi4XUiGFbkgv7IlXV7aDq32wfE1NEXUXyz4kE4hJb9C3WS5p5XeFccuYVTdjmb34Bpgcr7O9fgz8CgVGB6Q","sid":"2354cf898b41b76d70850ba58b9b9ffb","code":49,"serverResponse":{"backuped":0,"fileListMode":"string","fileListStr":"quickstart/2354cf898b41b76d70850ba58b9b9ffb_123456.m3u8","gwWorkerVersion":1,"inProgressBitmask":1,"output":{},"payload":
{"message":"Failed"}
,"selectionBitmask":1,"subscribeModeBitmask":1}}
3、录制视频的账号key，secret非当前账号，是公司账号；

回答思维链：客户在云录制 stop 的时候遇到了 49 报错，根据错误码文档解释，这个是任务正在退出，不能进行当前操作，可能是重复调用 Stop 或者其他原因导致任务正在退出。常见的有录制机器人被剔出房间，或者没有用户发流触发 maxIdleTime 逻辑自动停止任务。可以让客户自查下是不是把频道内已有的 uid 分配给录制端了，导致录制端加入频道失败或者在频道内被踢出，从而出现了报错。

答：您好，49可以参考错误码：[https://doc.shengwang.cn/doc/cloud-recording/restful/response-code#code](https://doc.shengwang.cn/doc/cloud-recording/restful/response-code#code)
您可以自查下是不是把频道内已有的 uid 分配给录制端了，导致录制端加入频道失败或者在频道内被踢出，从而出现了报错。录制端需要被分配一个频道内不重复的 uid，start 时候配置的 uid 是录制段加频道用的 uid，不是要录制哪个 uid。

---

# **编号：33679**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: JavaScript**

**Request type: 效果不佳、不达预期

问："agora-rtm-sdk": "^1.5.1"  
监听rtm频道用户进入不触发，rtmChannel?.on("MemberJoined"）

回答思维链：客户用的还是 1.x 的 RTM SDK，这个版本已经不再更新维护了，应该推荐客户尽早升级到 2.x

答：您好，您目前在用的是 RTM 1.x，这个版本已经停止更新维护很久了，建议尽早升级到 2.x ：https://doc.shengwang.cn/doc/rtm2/javascript/overview/migration-guide

---
# **编号：33677**

**SDK Product: RTC**

**SDK Version: 2.1.6**

**SDK Platform: RTC-Linux**

**Request type: 集成问题咨询**

问：关于Python SDK的VAD功能：
1. 请问VAD v2和v1的主要区别是什么？v2目前是否稳定、能否直接用在生产环境？
2. 在使用v2 self._vad_instance = AudioVadV2(...)、self._vad_instance.process(audio_frame)接口之后，注册AudioFrameObserver时是否还需要传入enable_vad=True？这样会同时开启v2和v1吗？此时vad_result_state、vad_result_bytearray参数是否还有意义？
3. 请问VAD实时性如何？是在Python SDK所在设备上运行、还是在云端运行？像example中的实现一样，在callback中直接调用VADv2和写磁盘，是否会因为阻塞时间过长导致SDK运行不稳定？
4. 另外 能否麻烦更新一下文档（捂脸） 感觉最近上的很多新feature文档里都没有

回答思维链：客户在使用 Linux-Python SDK，但应该不是最新版本，可以优先推荐客户使用最新版本。问题 1 的答案是肯定的，SDK 每次发版都是经过测试验证的，可以让客户放心在生产环境使用。
问题 2 建议客户用一个就行了，v2 是 v1 的迭代版本，有一个在工作就行。
问题 3 就是实时性的，在设备上运行，可以让客户参考 Demo写法直接使用 vad_result_bytearray，不再需要自己去处理。回调里可以做抛出，然后在非主线程里进行调用来防止阻塞。
问题 4 是因为目前发版节奏比较快，所以官方文档迭代速度没有跟上导致的。可以让客户优先参考 README，README 里会记录每次发版的更新内容，以及一些新接口的介绍。同时也应该提醒后续跟进的人工工程师，让他注意到这个现象，去找负责文档的工程师看下要如何解决这个问题。

答：您好，
1、最新版本支持多人 VAD 检测，发版出来的都是经过测试的正式版本，稳定可用。
2、不建议同时开启 1 和 2，用一个就行。
3、是实时性的，在设备上运行，参考Demo 写法，直接使用 vad_result_bytearray，不再需要自己去处理。回调里可以做抛出，然后在非主线程里进行调用来防止阻塞。
4、近期需求较多，迭代较快，资源紧张。后续会在 README 里添加更多描述和引导，同时也会内部推进下官网文档的更新。

---
# **编号：33662**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：我想python每隔2分钟检查一次实时互动RTC直播频道中主播是否在正常发流，如果没有正常发流 我需要触发无人机重新推流。请问有没有相关的api

回答思维链：客户提交的产品是云录制，但问的问题和云录制看起来不相关的，需要找客户再确认下现在到底在用什么产品。问题本身是 RTC 检测远端主播发流的，可以让客户在 Python 里监听on_user_video_track_state_changed回调，更具这个回调去判断频道里的远端视频流发送情况。因为Python官网文档有些滞后，需要让客户检查下 SDK 代码来完成回调监听，参考：https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/12fcb294749875d19503c7a93f318f67da2b6187/agora_rtc/agora/rtc/local_user_observer.py#L73C9-L73C42

答：您好，请问您这边是在用云录制还是 RTC？这个问题看起来是 RTC 监听远端发流状态的问题。Python SDK 可以通过监听里监听 on_user_video_track_state_changed 回调来了解远端发流状态，参考：https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/12fcb294749875d19503c7a93f318f67da2b6187/agora_rtc/agora/rtc/local_user_observer.py#L73C9-L73C42

---

# **编号：33658**

**SDK Product: CDN**

**SDK Version: 当前版本**

**SDK Platform: CDN**

**Request type: 效果不佳、不达预期**

问：回调地址设置不上 报错如下
NCS 健康检查结果: Test Failed
f"success":false,"httpCode" 590,"eror":"Post
"https://gl.kmg-s.kz:31443/fre-eye/agora/notice\".
context deadline exceeded (Client.Timeout exceeded
while awaiting headers)","response":"

回答思维链：NCS 设置报错，通常都是回调地址不通，http证书异常等问题导致的，需要客户自查下

答：您好，如果健康检查失败，请根据声网控制台的提示进行错误排查。常见的错误包括：

请求超时：你的服务器没有在 10 秒内返回 200。请检查你的服务器是否及时对事件回调作出正确的响应。如果响应正确，请联系技术支持
确认声网消息通知服务器到你的服务器之间的网络连接是否正常。
证书错误：HTTPS 证书错误。请检查证书是否正确。如果你的服务器受防火墙限制，请检查是否已将声网消息通知服务器的 IP 地址全部添加到防火墙白名单。
域名不可达：域名不合法，无法解析到目标 IP 地址。请检查你的服务器部署是否正确。
响应错误：你的服务器返回的响应状态码不为 200，具体的状态码和描述详见控制台提示。

---

# **编号：33651**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：请问mix（合流录制模式）下录制的视频为什么比例有很大的问题，展示视频画面就一点，其它的都黑屏，录制产生的文件路径为：xxx

一下是设置的参数；其中height和 width 无论设置成什么 最终录制的视频比例感觉都一样'recordingConfig' => [  
'channelType' => 0,  
'streamTypes' => 2,  
'streamMode' => 'standard',  
'videoStreamType' => 0,  
'audioProfile' => 1,  
'maxIdleTime' => 300,  
'subscribeAudioUids' => ["#allstream#"](https://jira.agoralab.co/browse/CSP-33651#allstream#%22 "Follow link"),  
'subscribeVideoUids' => ["#allstream#"](https://jira.agoralab.co/browse/CSP-33651#allstream#%22 "Follow link"),  
'subscribeUidGroup' => 0  
],  
'transcodingConfig' => [  
'height' => 1080,  
'width' => 1920,  
'bitrate' => 500,  
'fps' => 30,  
'mixedVideoLayout' => 0,  
'backgroundColor' => '#FF0000'  
],

回答思维链：客户应该合流录制转码后的画面布局不符合预期,目前客户在用的mixedVideoLayout是 0，可以让客户优先检查下这个布局的效果本身是否符合预期。以及让客户留下对应的 sid，方便人工工程师稍后解答

答：您好，频道里发的流如果就是竖屏的，那录制出来就是竖屏的。如果需要变成有左右黑边的那种，需要单独配置转码或者自行用工具去转
您可以提供下这次录制的 sid，人工工程师稍后查看具体原因。以及您也可以看下合流布局的预设效果，看下mixedVideoLayout为 0 的效果是否符合预期。

---

# **编号：33650**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：正常录制视频是可以的，录制的是发起者的视频内容，但是我业务是想录制接收者的画面。
transcodingConfig 这个参数配置了以后 录制产生报错。  
想知道是为什么录制不成功。

回答思维链：客户在使用云录制，但对于云录制的理解似乎有些问题。云录制是往 RTC 频道里额外加一个录制机器人来录制画面的，没有“发起者”这个概念，不是用频道内的用户去甪直别人来实现的。需要和客户解释一下这个逻辑。
以及客户还提到了配置transcodingConfig后录制报错，需要确认下客户的具体参数内容和报错结果是什么。

答：您好，云录制是往频道里额外加一个机器人对频道收流，所以没有“发起者”这个概念，频道里有流就全部录制的，请保证 start body 里的 uid 字段和频道里已有的 uid 不要重复。
以及请问您的transcodingConfig是如何配置的？报错内容又是什么呢？可以抓一下原始请求和结果，放在 txt里发到工单附件里，稍后人工工程师为您解答。

---

# **编号：33644**

**SDK Product: RTM**

**SDK Version: 2.2.0**

**SDK Platform: Object-C**

**Request type: 集成问题咨询**

问：rtm如何支持对方离线的时候，能够发送消息

回答思维链：客户想要用 RTM 在远端离线的时候发送消息。如果用点对点消息的话肯定会失败，所以无法实现。但如果用频道消息+客户自行实现历史消息业务的话，客户就可以在远端用户重新上线后获取离线期间的消息了。
以及客户目前在用 2.2.0 版本，2.2.2 版本上新增了 RTM 官方历史消息，如果客户升级到 2.2.2 后可以考虑使用官方的历史消息功能。

答：您好，这个需求做不到，RTM 本身是实时消息传输的 SDK，对方不在线肯定是收不到的。
您说的这种算历史消息或者离线消息，需要自己业务侧实现。比如加一个服务端或者客户端进所有频道，保存所有发送的消息，用户重新上线后可以自行获取不在线期间的消息。
您也可以升级到 2.2.2 及以后的版本，RTM 官方支持了历史消息。
https://doc.shengwang.cn/doc/rtm2/android/user-guide/message/history-message

---

# **编号：33643**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Java**

**Request type: 集成问题咨询**

问：rtm中有没有后端java使用的sdk。 我们的环境是Linux-centos系统，java-maven- springboot

回答思维链：客户想要用 centOS 集成 RTM SDK，RTM 是有 Java 版本而且支持 centOS 的，可以给客户提供下文档地址

答：您好，有的，支持 centOS，参考文档：https://doc.shengwang.cn/doc/rtm2/android/get-started/quick-start

---

# **编号：33640**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.6**

**SDK Platform: Linux-Python**

**Request type: 效果不佳、不达预期**

问：在单人的时候vad可以检测到对话，但是加入多个用户之后vad忽然就无法检测了（频道里面一个人说话也无法检测）

VAD的设置我基本上参照了这里的代码 https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/main/agora_rtc/examples/example_audio_vad.py

输入的配置类为 AudioVadConfigV2(16, 30, 50, 0.7, 0.5, 70, 70, -50))

回答思维链：这个是一个linux-python vad模式使用问题，客户反馈当人正常，多人vad无法检测；比较怀疑是vad用法问题，另外对于linux sdk来说，通常需要使用最新的版本；
答：您好，您这边可以这样试下：
1、将linux-python sdk升级到最新的2.2.4版本，vad支持多人检测；
2、def on_playback_audio_frame_before_mixing(self, agora_local_user, channelId, uid, audio_frame: AudioFrame, vad_result_state:int, vad_result_bytearray:bytearray):

sdk会在这个回调里面返回vad的结果，使用uid来做区分不同的用户的结果。

---

# **编号：33638**

**SDK Product: RTC**

**SDK Version: 4.5.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：你好，如果出海社交类APP想在海外市场使用实时转写和实时翻译，如中东和东南亚这些小语种地区，有几个问题请教一下，谢谢。
1、从成本和准确率指来说，推荐哪些自然语言处理产品啊？有相关的推荐数据吗？
2、你们有自研的RTT和云商店的微软、讯飞、云上曲率等自然语言处理插件，除自研的RTT外，第三方插件都是SDK直接对接第三方产品的服务器而不是由声网的服务去对接第三方产品的服务呢？
3、有自研RTT和云商店外的第三方转写和实时翻译的产品推荐吗？如果想接这些产品是APP直接对接，还是经过你们的SDK或服务端对接呢？

回答思维链：客户目前在选型转写+翻译能力产品，目前声网国内有云市场插件可以用第三方能力实现，海外有一个自研的 RTT 产品是 restful 方案的，比较方便，效果也不错，虽然国内没有上架但结合客户的场景来看应该会有出海需求，可以考虑让客户试用这个海外产品看下效果。可以给客户简单介绍下两个产品，然后邀请客户留下联系方式，方便后续人工工程师进一步场景确认和产品推荐。

答：您好，
1、目前有云市场转写插件和自研 RTT 可以使用，前者是纯 Native 移动端方案，后者是 restful 方案。具体的数据建议您自行测试来得出结论，这样数据最准确。
2、云市场的插件都是通过封装第三方接口，在插件侧做参数透传，在第三方上实现转写的。需要注册第三方的账号以后才能使用。RTT 是声网自研restful方案，无需注册第三方账号信息，也无需额外集成 SDK。
3、RTT 目前只在海外官网上架了，但是服务全球可用，可以看下这个文档：[https://docs.agora.io/en/real-time-stt/get-started/quickstart](https://docs.agora.io/en/real-time-stt/get-started/quickstart)。
RTT Demo：[https://stt-demo.agora.io/#/home](https://stt-demo.agora.io/#/home)

您可以先试下这两个产品的效果，我作为 AI 助手不方便直接推荐，您可以再介绍下完整场景，留个联系方式，方便人工工程师晚些时候和您语音沟通。

---

# **编号：33617**

**SDK Product: RTC-linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：1. 我看sdk接受pcm流之后只有通道数，采样率这些信息，pcm的sample_fmt是什么呢？
对应到ffmpeg中是
enum AVSampleFormat {
AV_SAMPLE_FMT_NONE = -1,
AV_SAMPLE_FMT_U8, ///< unsigned 8 bits
AV_SAMPLE_FMT_S16, ///< signed 16 bits
AV_SAMPLE_FMT_S32, ///< signed 32 bits
AV_SAMPLE_FMT_FLT, ///< float
AV_SAMPLE_FMT_DBL, ///< double

AV_SAMPLE_FMT_U8P, ///< unsigned 8 bits, planar
AV_SAMPLE_FMT_S16P, ///< signed 16 bits, planar
AV_SAMPLE_FMT_S32P, ///< signed 32 bits, planar
AV_SAMPLE_FMT_FLTP, ///< float, planar
AV_SAMPLE_FMT_DBLP, ///< double, planar
AV_SAMPLE_FMT_S64, ///< signed 64 bits
AV_SAMPLE_FMT_S64P, ///< signed 64 bits, planar

AV_SAMPLE_FMT_NB ///< Number of sample formats. DO NOT USE if linking dynamically
};
是哪个枚举呀

回答思维链：通过问题描述看，客户想咨询linux sdk 音频自采集接口相关功能；这里涉及到sendAudioPcmData()接口的使用，以及与FFMPGA的AVSampleFormat 之间的使用关联

答：您好，对应声网sdk来说，pcm都是16位的，即2个字节，对应的是bytes_per_sample这个字段。

---
