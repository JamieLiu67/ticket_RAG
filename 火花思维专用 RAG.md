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