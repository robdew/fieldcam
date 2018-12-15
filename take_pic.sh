###############TAKEPIC.SH
#!/bin/bash
# sudo fswebcam --log ~/camlog.txt -d /dev/video0 -r 1600x1200 pics/`date '+%Y.%m.%d-%H.%M.%S'`.jpg
# sudo fswebcam --log ~/camlog.txt -d /dev/video0 pics/`date '+%Y.%m.%d-%H.%M.%S'`.jpg
#sudo raspistill -w 1024 -h 768 -o pics/`date '+%Y.%m.%d-%H.%M.%S'`.jpg
#sudo raspistill -o pics/`date '+%Y.%m.%d-%H.%M.%S'`.jpg
# sudo raspistill -w 1024 -h 768 -o latest.jpg

# In lawrence kansas the longest day is 5/21
# Sunrise: 5:56
# Sunset: 20:50
# We will take a picture if the time is between 5 am and 9:30 pm

#cleanup 
mkdir ~/pics
rm ~/pics/latest.jpg; rm ~/pics/snap1.bmp



TIME=`date +%H`
if [ $TIME -ge 5 ] && [ $TIME -le 22 ]; then 
	#take a pic, write out exif data to pic
	# sudo raspistill -w 1024 -h 768 -x -n -e bmp -o ~/pics/snap1.bmp
	 sudo raspistill  -w 1600 -h 1200 -x -n -e bmp -o ~/pics/snap1.bmp
        # convert the pic to a jpg and annotate the corner with a datestamp
	convert ~/pics/snap1.bmp -pointsize 40 -gravity NorthEast -annotate 0 "`date`" ~/pics/latest.jpg
	# copy the file to the server
	sudo chown pi ~/pics/* 
	# rsync  --progress -azh -e "ssh -p 21098 -i /home/dewey/.ssh/dewey-picam_rsa" ~/pics/latest.jpg robdhuus@robdewhirst.com:~/public_html/cam/latest.jpg
	# make a copy of the file on server without xferring it again
	# ssh -p 21098 -i /home/dewey/.ssh/dewey-picam_rsa robdhuus@robdewhirst.com "cp ~/public_html/cam/latest.jpg ~/public_html/cam/old/`date '+%Y.%m.%d-%H.%M.%S'`.jpg"
        #send a copy to JMM webserver
        ncftpput -u $username -p $password jayhawkmodelmasters.com images/webcam /home/pi/pics/latest.jpg

fi
#######################################

