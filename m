Return-Path: <linux-kernel+bounces-895149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD3C4D1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3CA427BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10B34C14C;
	Tue, 11 Nov 2025 10:27:59 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916B34B682
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856878; cv=none; b=Hs0o7axe2jVoWo1jtCMdyUdkkWWO5FYCu5SIRKUQODN57H0PRFox+W8CHMeMH91/6iOem7pqrB2yJ9ry3+mmp2R5antZkQo4Fa1uB0y0og6V09zGjTfPZob2M/V+F+/1XwjDIKFuXLScuEU4WQj0HX0/H0C/nOwAl6dh5Jr7So4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856878; c=relaxed/simple;
	bh=/8CzXfuHcEJlSJRA11zs4FnS8Nv46Y0bC/+D45XIcAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB6vZFezCsXH2HyVtAuuq/SfoPWJywgJ3x779iKFcCVsIMqTaj7kbde1JPYgen3iDAMpgG3Q+mMW4FFTL+Koxiq5y83vgBaU+AjH5nPJRlNZYZ8YslPEpW24ettJGEgcXrFjgGz03/7AmN8lLyYl0Wb4BUN0Cmp//d9WA8I6bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656c07e3241so1739998eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856876; x=1763461676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXcNh9uEcUlM67NldM+wkaR6qeKY7aCoNzjVAfRE4U8=;
        b=ms3F1xxCeJtEzSMZgDNoIXVn5Y3hO1QLEzcrhgFeXHGkxa5Nn8+jo+9xeE4ciSifj+
         RYS2ubOqs5wVdFANiCFCVJ0cdWkusWEZtwDwqVvwvSxdJahmkUwcTEGnxwkqV5EheBOn
         JtK/tVvRatWmfH6VqeQE5eaypsz2UEE/0GKhIiTsgfcx6/wFEF1nldQpfmDs8zk1EkSI
         x5yy+Pg5HoZIKbjWZns23kAHOGFl0Bt8CgYdiUGHga8s/RkFXm/QMQ8I79YbQtipje4A
         DLq4jIt+Tdw+ILMLm4CTZZo04Y920q3D8GMUNxVxVB4L9MzHOYw10h0cu9FsueQFnehM
         7ZKw==
X-Forwarded-Encrypted: i=1; AJvYcCVcNusSWmhwf15Jzf1EqHZtZhK4oX/HRvGeea5laQiNxQuVZ9qgQIxcMHniK/cRCFbvD4IJJqIkziiC89I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmU5zBqrEpUVJRq/jJN3ZM1qriXkhOpW0RcveNDh9yn4QGd5yk
	MrazgQ6iT5kPOJee9112R0uL7k5IOyt9d801y2Bu4OsgfOjNB0xipPq9
X-Gm-Gg: ASbGnct7ul87uMU3xe/7LQK2bGjViUBhZWjG3JlqB9sTFl8H0MU6Lh2BVndkHgAvsLh
	/FQoSl4DTW+2KeS/20CGeCpS3VPW4WCKDzGtnx7ZuVxYa6kOjtY8cJIxnAFg/+lk982qMipHO7k
	ZmvRglKzbFeTcp5JNhFD/vZ3uTSx2bxkGU3c+yDad8PvmuR7F9emwIsxvypRiDtp/zwtthBJxgp
	qgwtCHsr4csPX453l76k3mmy8iWUssNUjX4gIIJWIpBLlHsAXAWGLaUUdOl91BP5ugTsOrXnRS1
	zqDO/9qUI8J7MjMJkr3pXIG2e+VIvf6h8sVlXha3CkhaFS9QKMqO6U2nWhhGVz2uE/RQjxi/iDl
	h4JRMwZ2Zl+bqLWDAJRkKkFa/epI+RXKBJsUtyQqEUUxTNGR6b0GDdATujgcwPoAsniQYML8hKo
	Lkmg==
X-Google-Smtp-Source: AGHT+IEzVtMODbxRkCJvy3lTstnvvwHWNG9lfiDUwJA7fVsJcqlAOniXiPB2G6BGunxf9fRFY+u0kQ==
X-Received: by 2002:a05:6870:8123:b0:3e8:172f:da82 with SMTP id 586e51a60fabf-3e8172fdfd0mr1103253fac.19.1762856876015;
        Tue, 11 Nov 2025 02:27:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41eba8ce5sm7616709fac.4.2025.11.11.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:27:55 -0800 (PST)
Date: Tue, 11 Nov 2025 02:27:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Message-ID: <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>

On Sun, Nov 09, 2025 at 11:05:56AM +0000, Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/Makefile       |  1 +
>  .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++-
>  .../selftests/drivers/net/netcons_resume.sh        | 92 ++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 68e0bb603a9d..fbd81bec66cd 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS := \
>  	netcons_cmdline.sh \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
> +	netcons_resume.sh \
>  	netcons_sysdata.sh \
>  	netpoll_basic.py \
>  	ping.py \
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 8e1085e89647..88b4bdfa84cf 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -186,12 +186,13 @@ function do_cleanup() {
>  }
>  
>  function cleanup() {
> +	local TARGETPATH=${1:-${NETCONS_PATH}}
>  	# delete netconsole dynamic reconfiguration
> -	echo 0 > "${NETCONS_PATH}"/enabled
> +	echo 0 > "${TARGETPATH}"/enabled
>  	# Remove all the keys that got created during the selftest
> -	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
> +	find "${TARGETPATH}/userdata/" -mindepth 1 -type d -delete
>  	# Remove the configfs entry
> -	rmdir "${NETCONS_PATH}"
> +	rmdir "${TARGETPATH}"
>  
>  	do_cleanup
>  }
> @@ -350,6 +351,29 @@ function check_netconsole_module() {
>  	fi
>  }
>  
> +function wait_target_state() {
> +	local TARGET=${1}
> +	local STATE=${2}
> +	local FILE="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"

local TARGET_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"

> +
> +	if [ "${STATE}" == "enabled" ]
> +	then
> +		ENABLED=1

Shouldn't they be local variables in here ?

> +	else
> +		ENABLED=0
> +	fi
> +
> +	if [ ! -f "$FILE" ]; then

	if [ ! -f "${TARGET_PATH}" ]; then

> +		echo "FAIL: Target does not exist." >&2
> +		exit "${ksft_fail}"
> +	fi
> +
> +	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {

	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${TARGET_PATH}/enabled\")\"" || {

> +		echo "FAIL: ${TARGET} is not ${STATE}." >&2
> +	}
> +}
> +
>  # A wrapper to translate protocol version to udp version
>  function wait_for_port() {
>  	local NAMESPACE=${1}
> diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> new file mode 100755
> index 000000000000..404df7abef1b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test validates that netconsole is able to resume a target that was
> +# deactivated when its interface was removed when the interface is brought
> +# back up.

Comment above is a bit harder to understand.

> +#
> +# The test configures a netconsole target and then removes netdevsim module to
> +# cause the interface to disappear. Targets are configured via cmdline to ensure
> +# targets bound by interface name and mac address can be resumed.
> +# The test verifies that the target moved to disabled state before adding
> +# netdevsim and the interface back.
> +#
> +# Finally, the test verifies that the target is re-enabled automatically and
> +# the message is received on the destination interface.
> +#
> +# Author: Andre Carvalho <asantostc@gmail.com>
> +
> +set -euo pipefail
> +
> +SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> +
> +source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
> +
> +modprobe netdevsim 2> /dev/null || true
> +rmmod netconsole 2> /dev/null || true
> +
> +check_netconsole_module
> +
> +# Run the test twice, with different cmdline parameters
> +for BINDMODE in "ifname" "mac"
> +do
> +	echo "Running with bind mode: ${BINDMODE}" >&2
> +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> +	echo "6 5" > /proc/sys/kernel/printk
> +
> +	# Create one namespace and two interfaces
> +	set_network
> +	trap do_cleanup EXIT

can we keep these trap lines outside of the loop?

> +
> +	# Create the command line for netconsole, with the configuration from
> +	# the function above
> +	CMDLINE=$(create_cmdline_str "${BINDMODE}")
> +
> +	# The content of kmsg will be save to the following file
> +	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
> +
> +	# Load the module, with the cmdline set
> +	modprobe netconsole "${CMDLINE}"
> +	# Expose cmdline target in configfs
> +	mkdir ${NETCONS_CONFIGFS}"/cmdline0"
> +	trap 'cleanup "${NETCONS_CONFIGFS}"/cmdline0' EXIT
> +
> +	# Target should be enabled
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Remove low level module
> +	rmmod netdevsim
> +	# Target should be disabled
> +	wait_target_state "cmdline0" "disabled"
> +
> +	# Add back low level module
> +	modprobe netdevsim
> +	# Recreate namespace and two interfaces
> +	set_network
> +	# Target should be enabled again
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Listen for netconsole port inside the namespace and destination
> +	# interface
> +	listen_port_and_save_to "${OUTPUT_FILE}" &
> +	# Wait for socat to start and listen to the port.
> +	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
> +	# Send the message
> +	echo "${MSG}: ${TARGET}" > /dev/kmsg
> +	# Wait until socat saves the file to disk
> +	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
> +	# Make sure the message was received in the dst part
> +	# and exit
> +	validate_msg "${OUTPUT_FILE}"
> +
> +	# kill socat in case it is still running
> +	pkill_socat
> +	# Cleanup & unload the module
> +	cleanup "${NETCONS_CONFIGFS}/cmdline0"
> +	rmmod netconsole

Why do we need to remove netconsole module in here?

Thanks for this patch. This is solving a real issue we have right now.
--breno

