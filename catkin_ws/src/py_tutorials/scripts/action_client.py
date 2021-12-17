#! /usr/bin/env python3
import rospy

# Brings in the SimpleActionClient
import actionlib

# Brings in the messages used by the fibonacci action, including the
# goal message and the result message.
from py_tutorials.msg import FibonacciAction, FibonacciGoal, FibonacciResult

def fibonacci_client_async():
    # Creates the SimpleActionClient, passing the type of the action
    # (FibonacciAction) to the constructor.
    client = actionlib.SimpleActionClient('fibonacci', FibonacciAction)

    # Waits until the action server has started up and started
    # listening for goals.
    client.wait_for_server()

    class ClientScope:
        feedback = None
        result = None
        result_received = False
    
    def action_feedback(feedback_msg):
        print("Feedback:", ', '.join([str(n) for n in feedback_msg.sequence]))
        ClientScope.feedback = feedback_msg
        
    def action_callback(state, result):
        ClientScope.result = result
        ClientScope.result_received = True

    # Sends the goal to the action server.
    client.send_goal(FibonacciGoal(order=20),
                feedback_cb=action_feedback,
                done_cb=action_callback)

    while not ClientScope.result_received:
        pass
    
    return ClientScope.result  # A FibonacciResult

def fibonacci_client_sync():
    # Creates the SimpleActionClient, passing the type of the action
    # (FibonacciAction) to the constructor.
    client = actionlib.SimpleActionClient('fibonacci', actionlib_tutorials.msg.FibonacciAction)

    # Waits until the action server has started up and started
    # listening for goals.
    client.wait_for_server()

    # Creates a goal to send to the action server.
    goal = actionlib_tutorials.msg.FibonacciGoal(order=20)

    # Sends the goal to the action server.
    client.send_goal(goal)

    # Waits for the server to finish performing the action.
    client.wait_for_result()

    # Prints out the result of executing the action
    return client.get_result()  # A FibonacciResult

if __name__ == '__main__':
    try:
        # Initializes a rospy node so that the SimpleActionClient can
        # publish and subscribe over ROS.
        rospy.init_node('fibonacci_client_py')
        result = fibonacci_client_async()
        print("Result:", ', '.join([str(n) for n in result.sequence]))
    except rospy.ROSInterruptException:
        print("program interrupted before completion", file=sys.stderr)
