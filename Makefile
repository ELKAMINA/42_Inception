SRC = ./srcs/docker-compose.yml
NAME = Inception

all: $(NAME)

$(NAME):
	mkdir -p /home/ael-khat/data/for_mariadb
	mkdir -p /home/ael-khat/data/for_wordpress
	docker-compose -f ${SRC} up --build -d

clean:
	docker-compose -f ${SRC} stop

fclean: clean
	docker-compose -f ${SRC} down


prune: fclean
	docker system prune -af
	rm -rf /home/ael-khat/data/for_mariadb
	rm -rf /home/ael-khat/data/for_wordpress
	docker rm -f $(docker ps -a -q)
	docker volume rm -f $(docker volume ls -q)

re: fclean all

setup:
	sudo chmod 777 /var/run/docker.sock
	echo "127.0.0.1 ael-khat.42.fr" | sudo tee -a /etc/hosts

.PHONY: all clean flcean re setup
