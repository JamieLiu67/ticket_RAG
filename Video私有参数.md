# rtc.video.enable_face_beauty
模块：美颜
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.enable_face_beauty\": true}")`
默认值：true
值说明:
- `true`: 美颜走yuv链路
- `false`: 美颜走texture链路
私参说明：建议需要跑ai模型（高级美颜），走texture链路，基础美颜走yuv或双buffer链路；值为true时基础美颜的磨皮只作用于人脸上，关掉的话会影响一点效果。

# rtc.video.decoder_out_byte_frame
模块：解码
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.decoder_out_byte_frame\": true}")`
默认值：1080P及以下为true,1080P以上为false
值说明:
- `true`: 硬件解码输出格式为yuv
- `false`: 硬件解码输出格式为texture
私参说明：由于默认SDK默认打开超画，硬件解码默认输出为YUV，当需要优化性能时，建议设置解码输出格式为texture，同时关闭超分

# rtc.video.enable_sr
模块：后处理
平台：native
类型：enabled-Boolean，mode-Number
写法：`setParameters("{\"rtc.video.enable_sr\":{\"enabled\":true,\"mode\":2}}")`
默认值：432版本及之后默认true
值说明：
- `true`: 开超分
- `false`: 关超分
mode 2-对多个远端开超分，mode 1-对远端最大窗口开超分
私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分

# rtc.video.sr_type
模块：后处理
平台：native
类型：Number
写法：`setParameters("{\"rtc.video.sr_type\": 20}")`
默认值：20
值说明:
- `20`: 超级画质
- `3`: 2倍超分
- `7`: 1.33倍超分
私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分










