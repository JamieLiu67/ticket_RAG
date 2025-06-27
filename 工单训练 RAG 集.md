# 工单训练 RAG 集

**编号：35745**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Unity**

**Request type: 集成问题咨询**

问：你好，我们的应用场景是unity开发的手段app与ai设备的实时语音通话，ai设备cpu架构是orinagx(英伟达 orin aarch64) 系统是ubuntu20.04 我在技术支持文件中没有找到该平台对应的sdk 改如何获取或者说支持该平台吗

回答思维链：客户的场景是在Unity下用app和Ubuntu设备在 RTC 频道里互通，声网有Unity的SDK，也有Ubuntu的服务端或物联网设备SDK，但客户现在没有找到，我们应该提供对应的文档地址给客户

答：我们有服务端SDK支持arm的：[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources)

还有 RTSA SDK，专门给一些 IOT 设备使用，里面有支持 aarch64 的，可以试下：[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

**编号：35864**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：我想在iOS中实现 关闭视频或摄像头后 显示头像或一张本地的图片 并且远端的用户看到的也是这张图片

回答思维链：客户需要在实现本端设备发流状态改变以后修改远端用户的 UI 显示改用自定义图片，这个需求需要能够感知远端用户的发流情况来做对应处理，可以让客户监听我们 SDK 的remoteVideoStateChangedOfUid 来感知远端设备的发流情况，然后在感知到远端不发流的时候自定义图片展示

答：可以业务上监听remoteVideoStateChangedOfUid，在远端不发流的时候前端上写个业务来展示指定图片：[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged)

**编号：35758**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：Android sdk中，设置音频编码格式为g711后，能否设置采样率为8k和16k，需要用哪个接口呢？

engine.setParameters("

{\"che.audio.custom_payload_type\":8}

");

回答思维链：客户调用了私参接口来让android设备发送G711音频编码，但是G711编码只有8K采样率，无法切换到16K，G722才是16K的，所以这个需求无法实现

答：G711 只有 8k 采样率，G722 才是 16k，没有办法指定 G711 用 16k 的

**编号：35849**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：1对1的视频通话进行正常，录制也正常完成，没有出现错误。
但录制视频存放至阿里云OSS后发现，只有.ts文件和.m3u8文件存储了，mp4文件没有按要求生成。

这个现象在之前的视频通话也发生过一次。但其他视频通话都正常。烦请帮忙查看一下没有生成mp4文件的原因。

回答思维链：这看起来是一个云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户说 ts 和 m3u8 都收到了，说明预留的 OSS 信息应该没问题，上传链路是通畅的，但至于为什么没有 mp4，可能是转码还没有完成（可以让客户再等等，最晚不会超过 24 小时），也可能是 mp4 文件的上传有些问题（需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因）

答：mp4 一般是 24 小时内完成转码再上传的，您可以先等 24 小时，如果还是没有的话，可以提供下具体的 sid，我们看下后台记录

**编号：35862**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：我想在iOS中实现多个视图显示本地视频预览,但是一直无法实现.
附件为我在Xcode中的代码.

回答思维链：看客户描述应该是想把本地画面渲染多次，这是需要在canvas 里配置setupMode  为 AgoraVideoViewSetupAdd 才能实现的，否则无法达到效果，可以让客户检查下有没有实现相关操作

答：请问是想把本地画面渲染多次吗？如果是的，需要在对应的 canvas 配置里设置 setupMode  为 AgoraVideoViewSetupAdd

[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)