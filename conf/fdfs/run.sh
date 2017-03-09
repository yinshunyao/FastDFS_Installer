

#fdfsdfs auto start sh start #####################################################
sudo killall fdfs_trackerd
sudo killall fdfs_storaged
sudo killall nginx

FDFS_LOG="fdfs.log"
START_CMD=/usr/bin/restart.sh
if [ ! -f $START_CMD ]
then
	echo "restart.sh not found" >> $FDFS_LOG
	START_CMD=""
fi


TRACKERD_CONF=/etc/fdfs/tracker.conf
# if config file exist
if [ -f $TRACKERD_CONF ]
then
	echo "starting the trackerd of fdfs"
	TRACKERD=/usr/bin/fdfs_trackerd
	TRACKERD_CMD="$START_CMD $TRACKERD $TRACKERD_CONF "
	$TRACKERD_CMD &
	RETVAL=$?
	echo "Trackerd result: $RETVAL" >> $FDFS_LOG
else echo "$TRACKERD_CONF not found" >> $FDFS_LOG
fi


STORAGED_CONF=/etc/fdfs/storage.conf
if [ -f $STORAGED_CONF ]
then
	STORAGED=/usr/bin/fdfs_storaged
	echo "starting the storaged of fdfs"
	STORAGED_CMD="$START_CMD $STORAGED $STORAGED_CONF "
	$STORAGED_CMD &
	RETVAL=$?
	echo "Storaged result: $RETVAL" >> $FDFS_LOG
else echo "$STORAGED_CONF not found" >> $FDFS_LOG
fi

NGINX_CONF=/etc/fdfs/nginx/nginx.conf
if [ -f $NGINX_CONF ]
then
	NGINX=/usr/local/nginx/sbin/nginx
	echo "starting the nginx of fdfs"
	STORAGED_CMD="$START_CMD $NGINX -c $NGINX_CONF "
	$STORAGED_CMD &
	RETVAL=$?
	echo "Nginx result: $RETVAL" >> $FDFS_LOG
else echo "$NGINX_CONF not found" >> $FDFS_LOG
fi
#fdfsdfs auto start sh end #####################################################



