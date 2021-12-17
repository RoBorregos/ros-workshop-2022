#include "ros/ros.h"
#include "py_tutorials/AddTwoInts.h"
#include <cstdlib>

bool is_number(const std::string& s)
{
    std::string::const_iterator it = s.begin();
    while (it != s.end() && std::isdigit(*it)) ++it;
    return !s.empty() && it == s.end();
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "add_two_ints_client");

  ros::NodeHandle n;
  ros::ServiceClient client = n.serviceClient<py_tutorials::AddTwoInts>("add_two_ints");
  py_tutorials::AddTwoInts srv;
  if (argc >= 3 && is_number(argv[1]) && is_number(argv[2])) {
    srv.request.a = atoll(argv[1]);
    srv.request.b = atoll(argv[2]);
  } else {
    int tmp = 0;
    n.param<int>("/SrvClientCpp/x_value", tmp, 1);
    srv.request.a = tmp;
    n.param<int>("/SrvClientCpp/y_value", tmp, 1);
    srv.request.b = tmp;
  }

  if (client.call(srv))
  {
    ROS_INFO("Sum: %ld", (long int)srv.response.sum);
  }
  else
  {
    ROS_ERROR("Failed to call service add_two_ints");
    return 1;
  }

  return 0;
}
