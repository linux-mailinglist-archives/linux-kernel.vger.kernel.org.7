Return-Path: <linux-kernel+bounces-844061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5EFBC0E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 913BA4F4308
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A692D7DF2;
	Tue,  7 Oct 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIvY3Czw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E61E633C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830450; cv=none; b=phYrjKpim941nhRSqBQfAfn6cUqvCZIv+kFoQDcu/xW0hbsr2i8cpmTCaOMD1FcMabE839M1OdXHlbOsOGTK9j6u5vW/SurE2Oo6SVdi8E79bAp/JXHw/14ji9ONtkvMdFTuYG1X2+3tc7qdXA7LNEEp5ZS3Ky0sl+2XE0U1Z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830450; c=relaxed/simple;
	bh=SjicVC6G1miKTiX+KBEYiF7UME/0QKcEwbVeDB1svNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv4DatZnbt4tBezDacU7DvZ5e+m2f4Q6wCh2jd/Q4e9OlfUucioUsUCbw39eiPcPKhZwbQN0uicypdezwW1FgqQcZFPPbY95P8urhpsMid+KGsogNAg6Uqn3o57W99QQojeQKTTmQjIAq2iR1d7wkIPKyCoFvz8XFn6FwObuMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIvY3Czw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbihWzaC35GhBeQwi8LRgNFDsCsoNSTKHzcqQbFMT10=;
	b=FIvY3Czwz2Q6WeFQ2CLe9YEsT9Rb+1peRAQQ403i+gcL54LUeR0sXya2pvbUBDDzYs121C
	sfg65KnCtaQR8QsLd+hCTfR+ZKyNnKuSwZ4pfViiEoQdxAaaN7Rl0my72tSy02YaWR4iTe
	eaahdBcCy5xKdXzaBOvg4VsmEYlhn5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-8XwiYuv5MvCzlLQBXEFhiw-1; Tue, 07 Oct 2025 05:47:26 -0400
X-MC-Unique: 8XwiYuv5MvCzlLQBXEFhiw-1
X-Mimecast-MFC-AGG-ID: 8XwiYuv5MvCzlLQBXEFhiw_1759830446
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e473e577eso31539375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830445; x=1760435245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbihWzaC35GhBeQwi8LRgNFDsCsoNSTKHzcqQbFMT10=;
        b=V0iQGJ75wTHM9+agWTMRPt2JU/pw+f69ID1VVYTyDPTqkbirAR7/ClbZml9qNMvdcI
         dNJck52BV8UVtphw6klzBqIf9xYYqvtLTyNGqFKpmLZBfv6OyRHiPnEUB65OL1RIB5XN
         xkuJoIGTeMcGaxN1i3gaOmmXQAGT3Dz5Ij9H7t1xt5TexqoSOlXqcY0Fu8y7K7X9Z09o
         F6I6dofuc5st5RiUpIO8dUidNJgw9XXwIdT49rpts1EuZx/M+GGnTJwTpHzdc67wNmH5
         fXiXdEAKc9HnDcQTcSWzxLtCLADmhvYBsMD4EmSmHRgftPwUz0VOLoBnDaNzQi9kddoR
         mfNQ==
X-Gm-Message-State: AOJu0YxfsCioNz/VOk+YWtv9qzOvaRyJiS4DdnlU8TcR5Ra/MfFMg7Q2
	9tdYurd205dp3LS9a7lLsjk3Qrt+wPcJpH9vADJcPiVSRw4qJLV6XXOBcJXM2wabb3MlppH5+wt
	58nLXjEhC4fa2rm6Zadl2oDxDJkTIsE2bR0WY5XAbUHgB72WYzpZa3XUeDJDxVic8RU3Nui8vGw
	==
X-Gm-Gg: ASbGncvsiCSpEHZ7kyDatF9EncETUdUN8qCaTdCpWMkAr3PltD6f7GSN4hbyHJl3fzY
	DmxNO44mrvgjtB3xDYp097UJ35sKcHKWAAhrzFng8/ACjI0uvCx32qTV24ohXUNctkDqfZKSuih
	CA+QSAwPtLfDKQHnNk0G0/YVl2RSMddx0/AEDFG50CgvQ9hg0EhVpOK27W3l4mpTYBByDPjXQXK
	j4WAu+uDKfDHHziJvdaPfZzEivcNgx9yQ9ppAKyVbQKNQ0VBZ7OPjQS5cfqAT9Oj/9lXE2W4pNw
	1BjZzSWu5RThmiIYx8M7m2azpJL+awKiHpiftDTdY9BbN+s/indWgh6bIsMUXQpdmgpUPmERbz2
	10eeiNZbpSD2UXVDhPg==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4372:5395 with SMTP id 5b1f17b1804b1-46e711525b0mr101139395e9.25.1759830445196;
        Tue, 07 Oct 2025 02:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0qstkQLD4f3rHHu9sfxKJO5+olk6dYA8Hcq/FgDh0sJaS5xre6yM8TYc5jsNMZS6c+9ocfg==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4372:5395 with SMTP id 5b1f17b1804b1-46e711525b0mr101139195e9.25.1759830444746;
        Tue, 07 Oct 2025 02:47:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3a58sm295658455e9.6.2025.10.07.02.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:47:24 -0700 (PDT)
Message-ID: <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
Date: Tue, 7 Oct 2025 11:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 1:57 PM, Breno Leitao wrote:
> +# Test #1 : Create an bonding interface and attach netpoll into
> +# the bonding interface. Netconsole/netpoll should work on
> +# the bonding interface.
> +send_netcons_msg_through_bond_iface
> +echo "test #1: netpoll on bonding interface worked. Test passed" >&2
> +
> +# Test #2: Attach netpoll to an enslaved interface
> +# Try to attach netpoll to an enslaved sub-interface (while still being part of
> +# a bonding interface), which shouldn't be allowed
> +enable_netpoll_on_enslaved_iface
> +echo "test #2: netpoll correctly rejected enslaved interface (expected behavior). Test passed." >&2
> +
> +# Test #3: Unplug the sub-interface from bond and enable netconsole
> +# Detach the interface from a bonding interface and attach netpoll again
> +delete_bond_and_reenable_target
> +echo "test #3: Able to attach to an unbound interface. Test passed." >&2
> +
> +# Test #4: Enslave a sub-interface that had netconsole enabled
> +# Try to enslave an interface that has netconsole/netpoll enabled.
> +# Previous test has netconsole enabled in BOND_TX1_SLAVE_IF, try to enslave it
> +enslave_netcons_enabled_iface
> +echo "test #4: Enslaving an interface with netpoll attached. Test passed." >&2
> +
> +# Test #5: Enslave a sub-interface to a bonding interface
> +# Enslave an interface to a bond interface that has netpoll attached
> +# At this stage, BOND_TX_MAIN_IF is created and BOND_TX1_SLAVE_IF is part of
> +# it. Netconsole is currently disabled
> +enslave_iface_to_bond
> +echo "test #5: Enslaving an interface to bond+netpoll. Test passed." >&2

I think this is missing the negative/fail to add test case asked by
Jakub. AFAICS you should be able to trigger such case trying to add a
veth device to the netpoll enabled bond (since the latter carries the
IFF_DISABLE_NETPOLL priv_flag).

> +
> +cleanup_bond
> +trap - EXIT
> +exit "${EXIT_STATUS}"
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 9b5ef8074440c..30e4f357b47e9 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -28,17 +28,24 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
>  # NAMESPACE will be populated by setup_ns with a random value
>  NAMESPACE=""
>  
> -# IDs for netdevsim
> +# IDs for netdevsim. We either use NSIM_DEV_{1,2}_ID for standard test
> +# or NSIM_BOND_{T,R}X_{1,2} for the bonding tests. Not both at the
> +# same time.
>  NSIM_DEV_1_ID=$((256 + RANDOM % 256))
>  NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> +NSIM_BOND_TX_1=$((768 + RANDOM % 256))
> +NSIM_BOND_TX_2=$((1024 + RANDOM % 256))
> +NSIM_BOND_RX_1=$((1280 + RANDOM % 256))
> +NSIM_BOND_RX_2=$((1536 + RANDOM % 256))
>  NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
> +NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
> +NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
>  
>  # Used to create and delete namespaces
>  source "${LIBDIR}"/../../../../net/lib.sh
>  
>  # Create netdevsim interfaces
>  create_ifaces() {
> -
>  	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
>  	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
>  	udevadm settle 2> /dev/null || true
> @@ -54,7 +61,6 @@ create_ifaces() {
>  }
>  
>  link_ifaces() {
> -	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
>  	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
>  	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
>  
> @@ -96,6 +102,33 @@ function select_ipv4_or_ipv6()
>  	fi
>  }
>  
> +# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
> +# and the other two will be bond to the RX interface (on the other namespace)
> +function create_ifaces_bond() {
> +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
> +	udevadm settle 2> /dev/null || true
> +
> +	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
> +	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
> +	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
> +	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"

Note that with the create_netdevsim() helper from
tools/testing/selftests/net/lib.sh you could create the netdevsim device
directly in the target namespace and avoid some duplicate code.

It would be probably safer to create both rx and tx devices in child
namespaces.

> +
> +	# TX
> +	BOND_TX1_SLAVE_IF=$(find "$BOND_TX1"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_TX1"/net -exec basename {} \; | grep -v net)
> +	BOND_TX2_SLAVE_IF=$(find "$BOND_TX2"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_TX2"/net -exec basename {} \; | grep -v net)
> +
> +	# RX
> +	BOND_RX1_SLAVE_IF=$(find "$BOND_RX1"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_RX1"/net -exec basename {} \; | grep -v net)
> +	BOND_RX2_SLAVE_IF=$(find "$BOND_RX2"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_RX2"/net -exec basename {} \; | grep -v net)
> +}
> +
>  function set_network() {
>  	local IP_VERSION=${1:-"ipv4"}
>  
> @@ -180,8 +213,6 @@ function disable_release_append() {
>  }
>  
>  function do_cleanup() {
> -	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
> -
>  	# Delete netdevsim devices
>  	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
>  	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
> @@ -193,14 +224,26 @@ function do_cleanup() {
>  	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
>  }
>  
> -function cleanup() {
> +function cleanup_netcons() {
>  	# delete netconsole dynamic reconfiguration
> -	echo 0 > "${NETCONS_PATH}"/enabled
> +	# do not fail if the target is already disabled
> +	if [[ ! -d "${NETCONS_PATH}" ]]
> +	then
> +		# in some cases this is called before netcons path is created
> +		return
> +	fi
> +	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
> +	then
> +		echo 0 > "${NETCONS_PATH}"/enabled || true
> +	fi
>  	# Remove all the keys that got created during the selftest
>  	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
>  	# Remove the configfs entry
>  	rmdir "${NETCONS_PATH}"
> +}
>  
> +function cleanup() {
> +	cleanup_netcons
>  	do_cleanup
>  }
>  
> @@ -377,3 +420,104 @@ function wait_for_port() {
>  	# more frequently on IPv6
>  	sleep 1
>  }
> +
> +# netdevsim link BOND_TX to BOND_RX interfaces
> +function link_ifaces_bond() {
> +	local BOND_TX1_SLAVE_IFIDX
> +	local BOND_TX2_SLAVE_IFIDX
> +	local BOND_RX1_SLAVE_IFIDX
> +	local BOND_RX2_SLAVE_IFIDX
> +
> +	BOND_TX1_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_TX1_SLAVE_IF"/ifindex)
> +	BOND_TX2_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_TX2_SLAVE_IF"/ifindex)
> +	BOND_RX1_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_RX1_SLAVE_IF"/ifindex)
> +	BOND_RX2_SLAVE_IFIDX=$(cat /sys/class/net/"$BOND_RX2_SLAVE_IF"/ifindex)
> +
> +	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
> +	exec {INITNS_FD}</proc/self/ns/net
> +
> +	# Bind the dst interfaces to namespace
> +	ip link set "${BOND_RX1_SLAVE_IF}" netns "${NAMESPACE}"
> +	ip link set "${BOND_RX2_SLAVE_IF}" netns "${NAMESPACE}"
> +
> +	# Linking TX ifaces to the RX ones (on the other namespace)
> +	echo "${INITNS_FD}:$BOND_TX1_SLAVE_IFIDX $NAMESPACE_FD:$BOND_RX1_SLAVE_IFIDX"  \
> +		> "$NSIM_DEV_SYS_LINK"
> +	echo "${INITNS_FD}:$BOND_TX2_SLAVE_IFIDX $NAMESPACE_FD:$BOND_RX2_SLAVE_IFIDX"  \
> +		> "$NSIM_DEV_SYS_LINK"
> +}
> +
> +# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
> +# the bonding interfaces
> +function setup_bonding_ifaces() {
> +	local RAND=$(( RANDOM % 100 ))
> +	BOND_TX_MAIN_IF="bond_tx_$RAND"
> +	BOND_RX_MAIN_IF="bond_rx_$RAND"
> +
> +	if ! ip link add "${BOND_TX_MAIN_IF}" type bond mode balance-rr
> +	then
> +		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
> +		# only clean nsim ifaces and namespace. Nothing else has been
> +		# initialized
> +		cleanup_bond_nsim
> +		trap - EXIT
> +		exit "${ksft_skip}"
> +	fi
> +	ip link set "${BOND_TX1_SLAVE_IF}" down
> +	ip link set "${BOND_TX2_SLAVE_IF}" down
> +
> +	ip link set "${BOND_TX1_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
> +	ip link set "${BOND_TX2_SLAVE_IF}" master "${BOND_TX_MAIN_IF}"
> +	ip link set "${BOND_TX_MAIN_IF}" up
> +
> +	# now create the RX bonding iface
> +	ip netns exec "${NAMESPACE}" \
> +		ip link add "${BOND_RX_MAIN_IF}" type bond mode balance-rr

Minor nit:

	ip -n "${NAMESPACE}" link ...

will yield the same result with a little less wording.


> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_SLAVE_IF}" down
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_SLAVE_IF}" down
> +
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_SLAVE_IF}" master "${BOND_RX_MAIN_IF}"
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_SLAVE_IF}" master "${BOND_RX_MAIN_IF}"
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX_MAIN_IF}" up
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_SLAVE_IF}" up
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_SLAVE_IF}" up
> +}
> +
> +# Clean up netdevsim ifaces created for bonding test
> +function cleanup_bond_nsim() {
> +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> +	cleanup_all_ns

If all devices are created in child netns, you will not need explicit
per device cleanup.

/P


