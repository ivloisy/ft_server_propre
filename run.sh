# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ivanloisy <ivanloisy@student.42.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/25 17:14:58 by ivanloisy         #+#    #+#              #
#    Updated: 2021/04/27 12:00:57 by ivanloisy        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

docker stop cnt
docker container rm cnt
docker build -t img .
docker run --name cnt -d -p 8080:80 -p 443:443 img