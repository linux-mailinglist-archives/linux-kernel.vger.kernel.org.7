Return-Path: <linux-kernel+bounces-820730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1AEB7EC30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D7A3B0049
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD81393DF2;
	Wed, 17 Sep 2025 12:52:24 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3234572E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113543; cv=none; b=X6MGKBl+0nQr/T880gpjtO6GwLfkLrFBCnpPZKtGySNuKIJB1ZH956DuP1AXAt8ISPMDt2noOw7xeiRvCSkQeC8/RiJgGZ+5f2wBiQw8K7TpARx7ZRv2KV3cEbL45Mprr8Q6uOOMNnu0EVcp6ETBTbcHNKMomwN3oTYrw9j54vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113543; c=relaxed/simple;
	bh=xydTUOOwR+kb4BiGLwqzztmAAKwAAbCtW7zc4Xhr3I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiD+fIDu3Qs5Ym5t2F0JrKfwolk+3QJeJlo88MnvXnDA5DgSciY+wzYHw62AJR6NRz/EKrj2PUD/lVeTlAv9cZbmJ+OsDcz9PQbfF5HOfvRw/+AY6eJJUdMQkuf4Fzrykzf+pRvo3nsixcZdRdIufEfG99co0wX8fy2ojuocudM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0787fa12e2so944899866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113540; x=1758718340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UUKIXVVQhORiL6o2zggCDFLRC+Tn3mg+SUCXQ8RI4c=;
        b=AfjdoQSg05IqncHgmWhETj8clxHuERbi4RGeNjV2I0WUNExm+ei+JJirGX8r8xpS2J
         pr3djV0IVMeBO49GCxV0qSxyL22rCIGyqok2gsnRN1MYt6qOdKTqzDswhpEPnD55O2mY
         psCP2wQvihv0sQsoLzKirH+mCCH8eZhdlhvn3qtFo1nmSTbzYJwtFGVNCqQv3m+dCdc5
         VIMYrod2H+WBhIWO8qRdL5r79j4Bv8L0aJQFx+YvDAUQ9io7A3lG2xAHcCow7KS/xzKz
         exkoP18K3SMWUU9PyQ7/YlbpCLCkNoJTk5unXIeDnliUNVAsGs+N8VnvuTqZUKUoMa8X
         KnOg==
X-Gm-Message-State: AOJu0Yw30jNBO3B5+sfH0PRnVCUi2CeA/E06ADBhc45uhWrNhXX7t6M4
	rZAObW2SjeXAHlhdLU/oYuAsdx1b13EvAkbedUrqa7tz8hMgAgMltLMd
X-Gm-Gg: ASbGncu1sYxjlk2y03NKECenWT0EXM3aR+J9RNnHl4XUF/RBy/vALqcvQ+BtXKi4q3I
	eksSv2nr8RYvdisqT7jUdfeBcq0WbeuSJqYB9hBW88TefzlWm4ZOczlZaCZwtmL6J3Gc+8dLnSP
	rTI0RWBiz3G7oi1RQERafXtHps5HFsxerGSER9jKACWCBiUiZKW4KXhidvMTHF1RNbJbg5MKePL
	5Fwrq1XUdUgsKGazgcfyNuuIpEYMRB2nhFvNZiQ49CEA08KOr/zLzR0c1iWDBtiFGJ65ywMhcGQ
	cQXkv7gTqT8mJTX/ZVuCNQXyDJzIh61nvZnHvO0jayL0dzq5+qOB07DY2Pt2RJqYftQq4ZCeRlR
	0bxYNiumqoq1Z
X-Google-Smtp-Source: AGHT+IEeSwxR761Zx/HgsbV8wEkAW/gpnsYRMwqUPjR/FKzQf5EVL3B+45+LEkfHmiRphhFyY3eD/w==
X-Received: by 2002:a17:907:2dac:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b1bb7e35eadmr224042266b.32.1758113539523;
        Wed, 17 Sep 2025 05:52:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da542sm1392489866b.2.2025.09.17.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 05:51:45 -0700
Subject: [PATCH net v4 4/4] selftest: netcons: add test for netconsole over
 bonded interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-netconsole_torture-v4-4-0a5b3b8f81ce@debian.org>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
In-Reply-To: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=12638; i=leitao@debian.org;
 h=from:subject:message-id; bh=xydTUOOwR+kb4BiGLwqzztmAAKwAAbCtW7zc4Xhr3I0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77aVAd8MsswrPsiASqaObU0Z6xMqt4s1eiC
 2wy9K2MesyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bRxaD/9veBRmzdAY/Vi4yjScqEw35Mzthp8KBWv1nA5pa56SK/ADczLTA1EPv7tIpfvRQxU3uyt
 mWJpMJSXe/gMhu/AEh7WJlD1fIWQR91m56mrBFKe2hUbWvhzHJar1lkOa1WWH7lp7n+fTQURuZ7
 0jEiGUPCbgy8shGI9GAUxzcp4afMnccW99PXG9z0LuTo0cVHR6foo7oc9C4e+f/li0Q3wE0e+77
 zU8/IE3MqjG1/LY75YElMIcXTI3o9ezpmPibXLthoYBWCdgfYMk80vDGgnnBgjEYqwZNHGcMQeC
 Fu/dPgn5thHOUOytwc3kYilaCE9W+x0gJAcS3Aig+2YAHxX7eGjLXxnfJP2aQfLUPyZcm7Orywn
 dSqhnTPkYpDUHR74deJ2QoKU22RyPiI/45/Xrw/RmI0CftQqSlirzfkv7by+Po6qIZUxfkXUMfe
 g86CO+qIjgKUSVTD4sYOhVpWw9cOAH5DALes8CLtLj5dLocuduUO+MRRE1uuNY2GBDnM+eWHHo6
 Ru5zzgiMcYKzZ1FyApUi2z5X+wGJlifDwaaNb7uQ2o6nlzriGycKa8jzn4Ab22NafRmBuojlOFm
 7kg9m3AB6lGXrqBfDgxzuKHwu/uVxVV/NM1PZuGlFho5duYRVDqSOqFjB/P4Urus7DdMxoAC21c
 5lzPE+TlPFBhaaA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds a selftest that verifies netconsole functionality
over bonded network interfaces using netdevsim. It sets up two bonded
interfaces acting as transmit (TX) and receive (RX) ends, placed in
separate network namespaces. The test sends kernel log messages and
verifies that they are properly received on the bonded RX interfaces
with both IPv4 and IPv6, and using basic and extended netconsole
formats.

This patchset aims to test a long-standing netpoll are where netpoll has
multiple users. (in this case netconsole and bonding). A similar
selftest has been discussed in [1] and [2].

This depends on CONFIG_BONDING, which is already set in
tools/testing/selftests/net/config.

Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 167 +++++++++++++++++++--
 .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++++
 3 files changed, 232 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 2b253b1ff4f38..b49730b393bdc 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
+	netcons_over_bonding.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
 	netcons_torture.sh \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 9b5ef8074440c..b9436f29ddf29 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -28,17 +28,24 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
 # NAMESPACE will be populated by setup_ns with a random value
 NAMESPACE=""
 
-# IDs for netdevsim
+# IDs for netdevsim. We either use NSIM_DEV_{1,2}_ID for standard test
+# or NSIM_BOND_{T,R}X_{1,2} for the bonding tests. Not both at the
+# same time.
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_BOND_TX_1=$((768 + RANDOM % 256))
+NSIM_BOND_TX_2=$((1024 + RANDOM % 256))
+NSIM_BOND_RX_1=$((1280 + RANDOM % 256))
+NSIM_BOND_RX_2=$((1536 + RANDOM % 256))
 NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
+NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
+NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
 
 # Used to create and delete namespaces
 source "${LIBDIR}"/../../../../net/lib.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
-
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
 	udevadm settle 2> /dev/null || true
@@ -54,7 +61,6 @@ create_ifaces() {
 }
 
 link_ifaces() {
-	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
 	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
 	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
 
@@ -96,18 +102,60 @@ function select_ipv4_or_ipv6()
 	fi
 }
 
+# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
+# and the other two will be bond to the RX interface (on the other namespace)
+function create_ifaces_bond() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle 2> /dev/null || true
+
+	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
+	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
+	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
+	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
+
+	# TX
+	BOND_TX1_IF=$(find "$BOND_TX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX1"/net -exec basename {} \; | grep -v net)
+	BOND_TX2_IF=$(find "$BOND_TX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX2"/net -exec basename {} \; | grep -v net)
+
+	# RX
+	BOND_RX1_IF=$(find "$BOND_RX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX1"/net -exec basename {} \; | grep -v net)
+	BOND_RX2_IF=$(find "$BOND_RX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX2"/net -exec basename {} \; | grep -v net)
+}
+
 function set_network() {
 	local IP_VERSION=${1:-"ipv4"}
+	local MODE=${2:-"standard"}
 
 	# setup_ns function is coming from lib.sh
 	setup_ns NAMESPACE
 
-	# Create both interfaces, and assign the destination to a different
-	# namespace
-	create_ifaces
+	if [[  "${MODE}" == "bonding" ]]
+	then
+		# Create two interfaces for RX and two for TX
+		create_ifaces_bond
+		# Link netlink ifaces
+		link_ifaces_bond
+		# Bind the TX ifaces into BONDTX_IF and the receive ifaces
+		# into BONDRX_IF
+		setup_bonding_ifaces
+	else
+		# Create both interfaces, and assign the destination to
+		# a different namespace
+		create_ifaces
 
-	# Link both interfaces back to back
-	link_ifaces
+		# Link both interfaces back to back
+		link_ifaces
+	fi
+	# Here after SRCIF and DSTIF are configured to either
+	# regular interfaces or bonding interfaces, and will be treated
+	# the same.
 
 	select_ipv4_or_ipv6 "${IP_VERSION}"
 	configure_ip
@@ -180,8 +228,6 @@ function disable_release_append() {
 }
 
 function do_cleanup() {
-	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
-
 	# Delete netdevsim devices
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
@@ -193,14 +239,18 @@ function do_cleanup() {
 	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
 }
 
-function cleanup() {
+function cleanup_netcons() {
 	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
+	# do not fail if the target is already disabled
+	echo 0 > "${NETCONS_PATH}"/enabled || true
 	# Remove all the keys that got created during the selftest
 	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
 	rmdir "${NETCONS_PATH}"
+}
 
+function cleanup() {
+	cleanup_netcons
 	do_cleanup
 }
 
@@ -377,3 +427,96 @@ function wait_for_port() {
 	# more frequently on IPv6
 	sleep 1
 }
+
+# netdevsim link BOND_TX to BOND_RX interfaces
+function link_ifaces_bond() {
+	local BOND_TX1_IFIDX
+	local BOND_TX2_IFIDX
+	local BOND_RX1_IFIDX
+	local BOND_RX2_IFIDX
+
+	BOND_TX1_IFIDX=$(cat /sys/class/net/"$BOND_TX1_IF"/ifindex)
+	BOND_TX2_IFIDX=$(cat /sys/class/net/"$BOND_TX2_IF"/ifindex)
+	BOND_RX1_IFIDX=$(cat /sys/class/net/"$BOND_RX1_IF"/ifindex)
+	BOND_RX2_IFIDX=$(cat /sys/class/net/"$BOND_RX2_IF"/ifindex)
+
+	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
+	exec {INITNS_FD}</proc/self/ns/net
+
+	# Bind the dst interfaces to namespace
+	ip link set "${BOND_RX1_IF}" netns "${NAMESPACE}"
+	ip link set "${BOND_RX2_IF}" netns "${NAMESPACE}"
+
+	# Linking TX ifaces to the RX ones (on the other namespace}
+	echo "${INITNS_FD}:$BOND_TX1_IFIDX $NAMESPACE_FD:$BOND_RX1_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+	echo "${INITNS_FD}:$BOND_TX2_IFIDX $NAMESPACE_FD:$BOND_RX2_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+}
+
+# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
+# the bonding interfaces
+function setup_bonding_ifaces() {
+	local RAND=$(( RANDOM % 100 ))
+	BONDTX_IF="bond_tx_$RAND"
+	BONDRX_IF="bond_rx_$RAND"
+
+	if ! ip link add "${BONDTX_IF}" type bond mode balance-rr
+	then
+		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
+		# only clean nsim ifaces and namespace. Nothing else has been
+		# initialized
+		cleanup_bond_nsim
+		trap - EXIT
+		exit "${ksft_skip}"
+	fi
+	ip link set "${BOND_TX1_IF}" master "${BONDTX_IF}"
+	ip link set "${BOND_TX2_IF}" master "${BONDTX_IF}"
+	ip link set "${BONDTX_IF}" up
+
+	# now create the RX bonding iface
+	ip netns exec "${NAMESPACE}" \
+		ip link add "${BONDRX_IF}" type bond mode balance-rr
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" master "${BONDRX_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" master "${BONDRX_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BONDRX_IF}" up
+
+	# from here after, SRCIF is bond interface
+	SRCIF="${BONDTX_IF}"
+	DSTIF="${BONDRX_IF}"
+}
+
+# Clean up netdevsim ifaces created for bonding test
+function cleanup_bond_nsim() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
+	cleanup_all_ns
+}
+
+# Full cleanup
+function cleanup_bond() {
+	cleanup_netcons
+
+	# Delete TX ifaces
+	ip link set "${BONDTX_IF}" down || true
+	ip link set "${BOND_TX1_IF}" down || true
+	ip link set "${BOND_TX2_IF}" down || true
+	ip link delete "${BONDTX_IF}" type bond  || true
+
+	# Delete RX ifaces
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BONDRX_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link delete "${BONDRX_IF}" type bond  || true
+
+	cleanup_bond_nsim
+}
diff --git a/tools/testing/selftests/drivers/net/netcons_over_bonding.sh b/tools/testing/selftests/drivers/net/netcons_over_bonding.sh
new file mode 100755
index 0000000000000..10f2183a16edb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_over_bonding.sh
@@ -0,0 +1,76 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+# This test verifies netconsole functionality over a bonded network setup.
+#
+# Four interfaces are created using netdevsim; two of them are bonded to serve
+# as the netconsole's transmit interface. The remaining two interfaces are
+# similarly bonded and assigned to a separate network namespace, which acts as
+# the receive interface, where socat monitors for incoming messages.
+#
+# A netconsole message is then sent to ensure it is properly received across
+# this configuration.
+#
+# The test's objective is to exercise netpoll usage when managed simultaneously
+# by multiple subsystems (netconsole and bonding).
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+modprobe bonding 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup_bond EXIT
+
+# Run the test twice, with different format modes
+for FORMAT in "basic" "extended"
+do
+	for IP_VERSION in "ipv6" "ipv4"
+	do
+		# Run the test twice, with different format modes
+		echo "Running netcons over bonding ifaces: ${FORMAT} (${IP_VERSION})"
+
+		# Create one namespace and two interfaces
+		set_network "${IP_VERSION}" "bonding"
+		# Create a dynamic target for netconsole
+		create_dynamic_target "${FORMAT}"
+		# Only set userdata for extended format
+		if [ "$FORMAT" == "extended" ]
+		then
+			# Set userdata "key" with the "value" value
+			set_user_data
+		fi
+		# Listed for netconsole port inside the namespace and
+		# destination interface
+		listen_port_and_save_to "${OUTPUT_FILE}" "${IP_VERSION}" &
+		# Wait for socat to start and listen to the port.
+		wait_for_port "${NAMESPACE}" "${PORT}" "${IP_VERSION}"
+		# Send the message
+		echo "${MSG}: ${TARGET}" > /dev/kmsg
+		# Wait until socat saves the file to disk
+		busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+		# Make sure the message was received in the dst part
+		# and exit
+		validate_result "${OUTPUT_FILE}" "${FORMAT}"
+		# kill socat in case it is still running
+		pkill_socat
+		cleanup_bond
+		echo "bonding: ${FORMAT} : ${IP_VERSION} : Test passed" >&2
+	done
+done
+
+trap - EXIT
+exit "${EXIT_STATUS}"

-- 
2.47.3


