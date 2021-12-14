# ----------------------------------------------------------------------
#  Development Docker
# ----------------------------------------------------------------------

#: Builds a Docker image from the current Dockerfile file
ros.build:
	@docker build -t ros:workshop -f Dockerfile .

#: Create Docker container
ros.create: 
	@./run_scripts/run.bash

ros.nvidia.create: 
	@./run_scripts/runNvidiaGpu.bash

ros.intel.create: 
	@./run_scripts/runIntelGpu.bash

#: Start the container in background
ros.up:
	@xhost +
	@docker start ros-workshop

#: Stop the container
ros.down:
	@docker stop ros-workshop

#: Restarts the container
ros.restart:
	@docker restart ros-workshop

#: Shows the logs of the ros-workshop service container
ros.logs:
	@docker logs --tail 50 ros-workshop

#: Fires up a bash session inside the ros-workshop service container
ros.shell:
	@docker exec -it ros-workshop bash

#: Remove ros-workshop container. 
ros.remove: ros.down
	@docker container rm ros-workshop

# ----------------------------------------------------------------------
#  General Docker
# ----------------------------------------------------------------------

#: Show a list of containers.
list:
	@docker container ls -a

#: Show a list of containers running.
listUp:
	@docker ps
