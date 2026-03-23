# ID: 13

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.x

Request Type: 线上问题

Request Description: 【火花思维】
上课设备: DMG-W00
鸿蒙卓易通下载使用的学生端，设备检测正常，但是进入直播课摄像头就打不开

Reply: 【火花思维】
可以配置下发切换camera1，成功后等待10分钟左右，建议用户杀掉app重进频道
【其他客户】
可以使用私参`setParameters("{\"che.video.android_camera_select\": 0}")`切换camera1来尝试解决

---

# ID: 14

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.x

Request Type: 线上问题

Request Description: 上课设备: Windows
老师这堂课音频录制频率一直抖动

Reply: 麻烦您看一下音频录制频率在什么范围内波动，如果有多次低于40，可以查看水晶球事件列表中的设备状态，低于40的时候是否有设备状态变动，即设备掉线
如果水晶球正常，可以艾特我们人工工程师继续进一步调查

---
# ID: 15

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.x

Request Type: 线上问题

Request Description: 麦克风声音时大时小
或忽大忽小
或断断续续

Reply: 建议先查看水晶球中事件列表-设备状态，确认用户采集设备是否降噪耳机或Krisp这种降噪应用，或者使用虚拟声卡
如果是降噪设备或虚拟声卡建议切换设备观察
如果不是降噪设备建议查看老师设备麦克风音量，如果有持续波动需要关闭自动声音增强，如果上述都正常可以艾特人工工程师做进一步调查

---
# ID: 16

SDK Product: RTC

SDK Platform: 所有平台

SDK Version: 4.x

Request Type: 线上问题

Request Description: 学生课中出现看不见也听不见老师的情况

Reply: 【火花思维】
1、建议您在水晶球里搜索学生uid，查看用户是否已经成功加入频道
2、如果已经加入频道查看老师的回放链接，或课中监课老师查看是否正常，如果正常可判断为学生侧问题
3、如果上述都正常可以艾特人工工程师做进一步调查
【其他客户】
1、建议您在水晶球里搜索学生uid，查看用户是否已经成功加入频道
2、如果已经加入频道，确认是单一学生问题，还是多个学生问题，判断学生侧还是老师侧问题
3、如果上述都正常可以艾特人工工程师做进一步调查

---
# ID: 17

SDK Product: RTC

SDK Platform: 所有平台

SDK Version: 4.x

Request Type: 线上问题

Request Description: 家长反馈听老师声音卡顿，电音
或挺老师声音小，或听不清老师

Reply: 【火花思维】麻烦您看一下老师的远端回放是否正常，如果正常可确认为学生端问题，帮忙提供家长侧录制的实际现象，我们做进一步调查
【其他客户】麻烦您提供具体的频道和uid，并确认一下是只有一个接收端异常还是所有接收端听老师都有问题，我们做进一步调查

---
# ID: 18

SDK Product: RTC

SDK Platform: 所有平台

SDK Version: 所有版本

Request Type: 线上问题

Request Description: 广电或者华数或者鹏博士或者网络，上课的时候看学生一直在掉线

Reply: 【火花思维】
麻烦您先查看水晶球，学生是否有大量的红色丢包，如果确认为网络问题艾特我们人工工程师给学生配置切换网络
【其他客户】
麻烦您先查看水晶球，学生是否有大量的红色丢包，小运营商可能会有网络波动，可以艾特人工工程师做进一步调查

---