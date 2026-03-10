# che.video.android_camera_select
模块：采集
平台：Android
类型：Number
写法：`setParameters("{\"che.video.android_camera_select\": 0}")`
默认值：auto
值说明:
- `0`: camera1 API采集
- `1`: camera2 API采集

私参说明：默认情况下，SDK优先选用camera2，但有时存在兼容性问题，比如黑屏，花屏，卡顿等需要指定camera1规避；
使用camera1的条件：
- camera2黑名单的设备，比如一加
- camera2功能不支持或等级仅支持HARDWARE_LEVEL_LEGACY
- 私参指定

# engine.video.enable_hw_encoder
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"engine.video.enable_hw_encoder\": true}")`
默认值：auto
值说明:
- `true`: 硬编
- `false`: 软编

私参说明：counter146可以看硬编还是软编，需要注意的是当编码输出帧率为0时，该counter值无意义。大多数情况下SDK优先走硬编，但有时有兼容性问题时，尤其是下行无法收流或者解码或者解码花屏时，可以尝试下上行设置软编。
常见的使用软编的情况：
- Android 编码分辨率width<256&&height<256

# rtc.video.enable_face_beauty
模块：前处理-美颜
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.enable_face_beauty\": true}")`
默认值：true
值说明:
- `true`: 美颜走yuv链路
- `false`: 美颜走texture链路

私参说明：建议需要跑ai模型（高级美颜），走texture链路，基础美颜走yuv或双buffer链路；值为true时基础美颜的磨皮只作用于人脸上，关掉的话会影响一点效果。

# engine.video.enable_hw_decoder
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"engine.video.enable_hw_decoder\": true}")`
默认值：auto
值说明:
- `true`: 硬解
- `false`: 软解

私参说明：counter316可以看硬解还是软解，需要注意的是当解码输出帧率为0时，该counter值无意义。大多数情况下SDK优先走硬解，但有时有兼容性问题时，可以尝试下设置软解。
各平台软硬解的行为：
- Windows：4.3版本及更早版本全走软解；4.4版本开始，前2路视频走硬解，第3路起走软解
- Android：4.3版本及更早版本全走软解，4.4版本开始走硬解
- iOS：硬解

# engine.video.hw_decoder_fallback_config
模块：解码
平台：Native
类型：enabled-Boolean，其余的为int
写法：`setParameters("{\"engine.video.hw_decoder_fallback_config\":{\"enabled\":false}}")`
默认值：true
值说明：
enabled：
- `true`: 开启分辨率低于阈值，解码延时高于阈值等情况下的硬解fallback软解
- `false`: 关闭硬解fallback软解，不影响可用性的fallback

width_thres：非安卓平台分辨率阈值，默认值256
height_thres：非安卓平台分辨率阈值，默认值256
resolution_thres：安卓平台分辨率阈值默认值`240*320=76800`
decode_time_delay_thres_broadcaster：主播角色解码延时阈值，默认2000
decode_time_delay_thres_audience：观众角色解码延时阈值，默认2000

私参说明：
- 440开始，SDK根据分辨率大小判断选择硬解还是软解，小分辨率用软解，大分辨率用硬解，安卓平台阈值为76800，其他平台阈值为65536。
- 安卓端大分辨率场景常会遇到由于硬解延时高自动切换到软解，但软解性能不足的问题。建议大分辨率场景用私参关闭fallback或者显示指定硬解，同时设置硬解输出格式为texture，关闭超分。

# rtc.video.decoder_out_byte_frame
模块：解码
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.decoder_out_byte_frame\": true}")`
默认值：1080P及以下为true,1080P以上为false
值说明:
- `true`: 硬件解码输出格式为yuv
- `false`: 硬件解码输出格式为texture

私参说明：由于默认SDK默认打开超画，硬件解码默认输出为YUV，当需要优化性能时，尤其是大分辨率场景，建议设置解码输出格式为texture，同时关闭超分

# rtc.video.enable_sr
模块：后处理
平台：Native
类型：enabled-Boolean，mode-Number
写法：`setParameters("{\"rtc.video.enable_sr\":{\"enabled\":true,\"mode\":2}}")`
默认值：432版本及之后默认true
值说明：
enabled：
- `true`: 开超分
- `false`: 关超分

mode:
- 2：对多个远端开超分
- 1：对远端最大窗口开超分


私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分

# rtc.video.sr_type
模块：后处理
平台：Native
类型：Number
写法：`setParameters("{\"rtc.video.sr_type\": 20}")`
默认值：20
值说明:
- `20`: 超级画质
- `3`: 2倍超分
- `7`: 1.33倍超分

私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分














