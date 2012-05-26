#!/bin/bash
# Usage: check_version <jmx port> <jmx object>

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

check_version_with_retry(){
        DIR=`dirname $0`
		exit_code=2
        for i in {1..20}
        do
                java -jar $DIR/check_jmx.jar -U service:jmx:rmi:///jndi/rmi://localhost:$1/jmxrmi -O $2 -A Version -c "$version"
                if [ $? == 0 ] ; then
                        exit_code=0
						break;
                fi
                sleep 2
        done
        echo "CRITICAL: Expected version not found."
		echo "Restarting Mule..."
		/etc/init.d/mule restart
        exit $exit_code
}

echo "Expecting version: $version"
check_version_with_retry $1 $2
