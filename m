Return-Path: <linux-kernel+bounces-888895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195CC3C38C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AC04255A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385834AAFF;
	Thu,  6 Nov 2025 15:57:04 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682B3451AE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444624; cv=none; b=oxjDBIqTsOuY5KXBpmaW3Dc2CQ2h+/Dqe7qetDU2T1iQMlnUZoBQwkbrEpgokzfGeVXCWxQaxW/eRZqtluHnfrfXq4IOCikFpBuwfaDrtd+26KQtcUD7YFVRDoCiVEecFQ8N0Ju01LZXByT/grv2QSDBVAy088p/nPK2gaikza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444624; c=relaxed/simple;
	bh=XQp4YoJOgWYJBS+lAreScEfDBZBcema28xQn9VyrhM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJGmj11aiBCW5A3UWX1Ftme3kNkWnv+0O6grLmigRs54B5GawNqsgS+oh9MCiiRr+uxV9gonymk4J/Cd+dCoxvWs/JOCUaf2VP9Z386zhiR1lK3huL+3IEmHfS/O+TL88gwvfY2SLPmU9EnGF5RIbnRncbyyoHc/JCVVUghNbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7277324054so176394266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444620; x=1763049420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48WWGgV3/OQmNtRAgDmereIyjTW6e2ku3y8EB8DFBcI=;
        b=tSKIFJksTtHCu+7miFjOPMmZ4v+wZ8H/FUoFNSbcQpmt/LhHqb0bag40NaUrRxZNhC
         S71nN1C6zjjqzTbyuUN1sMIHt9GJxan4V3RqcaHknyifQUsVRixkir3VwUY5YcTpVLuS
         RQUKwI92kWLShSYT9PsOcLiageroMG6lQTX6jhrU10AH+IjCBOpIkreLyHjOoNQ+E7Y+
         oNkYP2XGJXGZIjsp7YHhWr4wvEOhAqWpPZOK9Cm11rFxYbxuedTqSuZG34LG1f3ZgG2v
         MJHq04TK8HmmxM0ttXUeePps4G/WT5njJjO76kjKrcDIMAu6aIlTeJ7/0rgBDPbqobC3
         pvYQ==
X-Gm-Message-State: AOJu0Ywx26BqCkWj2KlwRVQTX5NU5bZNKx4RpOcwYkQ6CvuHc+GRLqMP
	ufkETdsCMcnFlyMkNqigbQx4XEVNbdOcgANF9yzixDN2Yji/PdIYnwL4
X-Gm-Gg: ASbGncuI6plj71QFEL8GZb6L7YCVloNrCvVL1kmbbUcNSrFnCK59FKL2U5Sy7nRtbvX
	mEjH9+kiqCJ8mwLP2ZIZknaVF0XsujqClX5mJ1iN/Opn+ayJP/z2zJT6eQ/NK+MNjCXSn8jAOfB
	YIWIpWkv38IOiZWnTDeFyXagDFC7ZxOFrFKYlRMEzSBz82NwF8Ad+Klc9wN2nyIH+pu1FnpYyHU
	QrzyZi+TlNwMYij31WJmFo+zChqNOZ/vMNG+ikagcLPS1yIMIX0D/OPRAxrAPHnsCznWHy2ApEg
	jTCTzUf4acqOYLP7ol6q7atM/JNkTDTlXQwR3WzyriYy13cxOLtckPCvwQHwlbYYmZth0MadJjz
	Bry8S3SMSvjDgs+AJV7XWaqiI9O9idtlNP+2DaZNlqVsyGVd7k9k4J5euoH6kZjAYnr0=
X-Google-Smtp-Source: AGHT+IH3apJIMqPcnbatW6g6CX/36pIxc07iiFbcaWyCUtgKinScRJsH1y1gOgOBQul167uBZYd8kQ==
X-Received: by 2002:a17:907:94d3:b0:b40:6e13:1a82 with SMTP id a640c23a62f3a-b72652bfb17mr813636066b.26.1762444620305;
        Thu, 06 Nov 2025 07:57:00 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:48::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893cbc72sm240883966b.29.2025.11.06.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Nov 2025 07:56:49 -0800
Subject: [PATCH net v9 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-netconsole_torture-v9-3-f73cd147c13c@debian.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
In-Reply-To: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5328; i=leitao@debian.org;
 h=from:subject:message-id; bh=XQp4YoJOgWYJBS+lAreScEfDBZBcema28xQn9VyrhM8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVGB/NwudI8cHgqREyLhK8XZ3cdL0jDJ95xc
 4ciCMMXZm+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRgAKCRA1o5Of/Hh3
 bdyvD/9PthZz/GwWqwFiLth/42RDN0UDJlqGe8AcOfYirbjEp/Wnq159l4/eiQ7CZd9mpTKyCYt
 xTThAtAFr8HvyP1ZoPgfntE4YQlk8dUS4nFLz4EIjUEYfuURZLollXsrQPXcompCAtg11ZIuIQz
 3TnhrikNOOOAj/poqKZu5w142E/YoXO98dAeeNC8If5X9RFcM2U/qJ68dH5egiuGFwcpR1M8MYa
 TD+78/SfwGVw/mt+2vq2nhggB2yFRBTjad/ZF40rsmBqXpOPlAt48Eim8yySVXIZN9Dgf+ZJPnM
 MUZkxFEM9Y8iwgxDJT3ZMculT0HTRI2MGw/+7FF5ef4W/obv2LeOBuRfqmTYiBdZHKtrzuN7xGx
 sMU9d44cGLZCnAzaaW9EUesH/51ldlhw1BT/fpWEWoKnaCMbmNEU4K+ILlRuSzNlPGEc9Tschim
 ukyu32VSeT4nRT2GCxiAxTXT+ns1jLwlTsLDno4oAd35Mjz9riLBRNUyxIV/aXfU6+rT4+fy/9m
 aHyyags8eApDM/npQcYeVbxFrpDu0hzEp4U0GXcw9F7xt7Q48GLQvkF2L+mEpuNgMoVFvOzNhln
 d0MGKDinFM1q8KuuhAgqNi7zgsJt8+OCWWgDz9elHe6Tq+ValbkvQcxxlpYysHkZ9WCS+XhKo4K
 YJ+0azs4dOSP6Yw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Create a netconsole test that puts a lot of pressure on the netconsole
list manipulation. Do it by creating dynamic targets and deleting
targets while messages are being sent. Also put interface down while the
messages are being sent, as creating parallel targets.

The code launches three background jobs on distinct schedules:

 * Toggle netcons target every 30 iterations
 * create and delete random_target every 50 iterations
 * toggle iface every 70 iterations

This creates multiple concurrency sources that interact with netconsole
states. This is good practice to simulate stress, and exercise netpoll
and netconsole locks.

This test already found an issue as reported in [1]

Link: https://lore.kernel.org/all/20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Andre Carvalho <asantostc@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/netcons_torture.sh       | 130 +++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 6e41635bd55a4..71ee69e524d77 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_torture.sh b/tools/testing/selftests/drivers/net/netcons_torture.sh
new file mode 100755
index 0000000000000..2ce9ee3719d1a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_torture.sh
@@ -0,0 +1,130 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Repeatedly send kernel messages, toggles netconsole targets on and off,
+# creates and deletes targets in parallel, and toggles the source interface to
+# simulate stress conditions.
+#
+# This test aims to verify the robustness of netconsole under dynamic
+# configurations and concurrent operations.
+#
+# The major goal is to run this test with LOCKDEP, Kmemleak and KASAN to make
+# sure no issues is reported.
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+# Number of times the main loop run
+ITERATIONS=${1:-150}
+
+# Only test extended format
+FORMAT="extended"
+# And ipv6 only
+IP_VERSION="ipv6"
+
+# Create, enable and delete some targets.
+create_and_delete_random_target() {
+	COUNT=2
+	RND_PREFIX=$(mktemp -u netcons_rnd_XXXX_)
+
+	if [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}${COUNT}"  ] || \
+	   [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}0" ]; then
+		echo "Function didn't finish yet, skipping it." >&2
+		return
+	fi
+
+	# enable COUNT targets
+	for i in $(seq ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+
+		# Basic population so the target can come up
+		_create_dynamic_target "${FORMAT}" "${RND_TARGET_PATH}"
+	done
+
+	echo "netconsole selftest: ${COUNT} additional targets were created" > /dev/kmsg
+	# disable them all
+	for i in $(seq ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+		if [[ $(cat "${RND_TARGET_PATH}/enabled") -eq 1 ]]
+		then
+			echo 0 > "${RND_TARGET_PATH}"/enabled
+		fi
+		rmdir "${RND_TARGET_PATH}"
+	done
+}
+
+# Disable and enable the target mid-air, while messages
+# are being transmitted.
+toggle_netcons_target() {
+	for i in $(seq 2)
+	do
+		if [ ! -d "${NETCONS_PATH}" ]
+		then
+			break
+		fi
+		echo 0 > "${NETCONS_PATH}"/enabled 2> /dev/null || true
+		# Try to enable a bit harder, given it might fail to enable
+		# Write to `enabled` might fail depending on the lock, which is
+		# highly contentious here
+		for _ in $(seq 5)
+		do
+			echo 1 > "${NETCONS_PATH}"/enabled 2> /dev/null || true
+		done
+	done
+}
+
+toggle_iface(){
+	ip link set "${SRCIF}" down
+	ip link set "${SRCIF}" up
+}
+
+# Start here
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network "${IP_VERSION}"
+# Create a dynamic target for netconsole
+create_dynamic_target "${FORMAT}"
+
+for i in $(seq "$ITERATIONS")
+do
+	for _ in $(seq 10)
+	do
+		echo "${MSG}: ${TARGET} ${i}" > /dev/kmsg
+	done
+	wait
+
+	if (( i % 30 == 0 )); then
+		toggle_netcons_target &
+	fi
+
+	if (( i % 50 == 0 )); then
+		# create some targets, enable them, send msg and disable
+		# all in a parallel thread
+		create_and_delete_random_target &
+	fi
+
+	if (( i % 70 == 0 )); then
+		toggle_iface &
+	fi
+done
+wait
+
+exit "${EXIT_STATUS}"

-- 
2.47.3


