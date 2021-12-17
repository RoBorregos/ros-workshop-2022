#!/usr/bin/env python3
import rospy
from std_msgs.msg import String
from py_tutorials.msg import ChatterAdvanced

def talker():
    pub = rospy.Publisher('chatter', String, queue_size=10)
    pubAdvanced = rospy.Publisher('chatterAdvanced', ChatterAdvanced, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        pub.publish("hello world %s" % rospy.get_time())
        pubAdvanced.publish(ChatterAdvanced(dataFloat = 1.1, dataString="hello world %s"))
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
