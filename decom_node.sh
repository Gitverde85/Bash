TSMID=query
TSMPW=querymentoring123
SERVER=axpmgtsm01
WORK_DIR=/home/ie01015/decom
SERVELIST=$WORK_DIR/server.txt
TEMP_DIR=$WORK_DIR/temp
TEMP_RENAME=$WORK_DIR/rename
CAT_RENAME=$WORK_DIR/after_rename
CAT_CONT=$WORK_DIR/contact
CONT_BACKUP=$WORK_DIR/backup_contact
#The script takes the first parameter passed. This can range from $1 to $10.
NODE=$1
CHANGE=$2

#TODO: validate that the node is not blank.
#The purpose of this script is to automate the node decommissioning process on the TSM server.

if [[ "$NODE" == "" ]]
then
        echo "You must inform the node that you want to decomm"
        exit 1
fi

if [[ "$CHANGE" == "" ]]
then
        echo "You must inform the change number"
        exit 1
fi

DSMADMC (){
  dsmadmc -id=$TSMID -password=$TSMPW  -servername=$tsm -dataonly=yes -tab  "$1"
}

# Update node contact

for tsm in `cat $SERVELIST`
do
  echo --------- $tsm -----------
  DSMADMC "query node $NODE f=d" >> /dev/null
  if [[ "$?" -eq "0" ]]
  then
        DSMADMC  "select contact from nodes where node_name = upper('$NODE')" > $TEMP_DIR
        cat $TEMP_DIR | grep LV97R1 > $CAT_CONT
        CONTACT=$(cat $CAT_CONT) #Coloca conteudo de um arquivo dentro de uma Variavel

        echo "****Original contact saved in Backup_contact****"
        echo $CONTACT >> $CONT_BACKUP

        echo DSMADMC "upd node $NODE contact='$CONTACT;$CHANGE'"
        if [[ "$?" -eq "0" ]]
        then
              echo "Node $NODE updated."
        else
              echo "Update incomplete for $NODE"
        fi
        echo " "
        echo "Removing Replnode"

        echo DSMADMC "REMOVE REPLNODE $NODE"
        if [[ "$?" -eq "0" ]]
        then
              echo "replication for $NODE has been removed."
        else
              echo "remove replnode for $NODE incomplete"
              exit 1
        fi

        echo
        echo "Rename Node"

        RENAME=$(date +%Y%m%d)
        NEW_NAME=DECOM_${RENAME}_${NODE}

        echo DSMADMC "RENAME NODE $NODE $NEW_NAME"
        RC=$?
        echo
        echo ${NEW_NAME}
        if [[ "$RC" -eq "0" ]]
        then
              echo "$NODE has been renamed."
        else
              echo "rename node for $NODE incomplete"
        fi

        echo
        echo "Decom Node"

        echo DSMADMC "DECOM NODE ${NEW_NAME} "
        if [[ "$?" -eq "0" ]]
        then
              echo "Decom node for ${NEW_NAME} has been started, check q node $NEW_NAME f=d to verif decom state."
        else
              echo "Decommission for ${NEW_NAME} incomplete"
        fi

        echo $tsm $? Pode fazer decom
  else
        echo $tsm $? Nao faz decom
  fi
done
