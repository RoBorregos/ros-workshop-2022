#!/usr/bin/env python3

from __future__ import print_function

import sys
import rospy
from py_tutorials.srv import AddTwoInts

def add_two_ints_client(x, y):
    rospy.wait_for_service('add_two_ints')
    try:
        add_two_ints = rospy.ServiceProxy('add_two_ints', AddTwoInts)
        resp1 = add_two_ints(x, y)
        return resp1.sum
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)

def validInt(s):
    try: 
        int(s)
        return True
    except ValueError:
        return False

if __name__ == "__main__":
    rospy.init_node('SRV_CLIENT', anonymous=True)

    if len(sys.argv) >= 3 and validInt(sys.argv[1]) and validInt(sys.argv[2]):
        x = int(sys.argv[1])
        y = int(sys.argv[2])
    else:
        x = rospy.get_param('~x_value', 1)
        y = rospy.get_param('~y_value', 1)
    print("Requesting %s + %s"%(x, y))
    print("%s + %s = %s"%(x, y, add_two_ints_client(x, y)))
