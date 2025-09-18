Return-Path: <linux-kernel+bounces-822582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD4B84334
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0533A7806
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFE53019B7;
	Thu, 18 Sep 2025 10:42:23 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86B2FE56B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192142; cv=none; b=a/RbzSGuW+Or7Pamde/ntJCPa0VzRGpdy1FydqgV2Wil7DZHrmcKcytHVG+Eo7OSUNeTFhscJoMO+OY5iCW5XTo6WGDklwFSswR1M3gl5+jhyykK4KjCjadwySByvbvIHOdJ4Izehfq9+6AipZGmFSgDL7m6LChZ8ZaejGr9ndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192142; c=relaxed/simple;
	bh=njsWipcAw6zDiWuPvoBPcLtz4KDuk27UDraQiXEyOh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eqm/CkualNNGgJ4Qij++xVnv/FK9h2BGTyuunIukkVuiI9rdQQWsJNuIetQiTp5myzjJBhyNNsggvqGv/wnLDb+HOlVZnA6mf8XvnVPVWe2Z33JsKLZGJtqR9Pa2cO1rGw6PzVJ1sDuLnRaP8yOn6XIRDAY26uM7wrTDbVvPdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04770a25f2so126408666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192138; x=1758796938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XoyvrHtWDXQ1aF+5AGUr+W6S/qx0Hv9FBJ5bml0jjU=;
        b=O3cefy+t5o6vKtVp2ROeYUmKzsu3eyUGGVTArN8yvEE2aiDDGvozhVBJQqRqPmAty1
         YPpBAWO5wfcD1jV0XZprWI3VvblOs3gd1X1GAsT/0vdvpensXs0YUfMh92A982ExgDIB
         6nwj3y5fgnOsf1D4JsmJ1LYKQC2FyY2uqiIP9yRi+PrsWDkoLjearvdVgUpijyYOQNHV
         n+JKPxdTwy6cMhALjjqFUbDJ009EWbw6YwNQfKNolbXTvY/Vc3fhx+TpbNVyhrbfJfZz
         4ZDeDvMi64o0hhMDJG1gK+oYxr3JW9RHfKDyE5N6GCH+A5y5Ip7sPdKM45riWn3SE/0Z
         kC4A==
X-Gm-Message-State: AOJu0YyDSJ+VQRNlQ8TsvCHInUWKFooWrXgxTkz5Zy4S0+keCXSklPiJ
	z+wuuhMbMRmFJV2lZAQprMe9DUzV1S59+PTe7I7FDGYd6gMjHqq00LNm
X-Gm-Gg: ASbGncvSNW2Z4OsCAwHGqTjsZGh+leRFnylSy1Vy5mivD7Uo0ZO0peuEwk0gtXYwEcC
	FxW6maY/wymc5K3UIl9tqxsapsg7SV2gxxkejv1XaeFf6uCD6r6V8N0n2XqAo8WaMnkLZx/mHFm
	xM5emXbBqFAm2ylsn3Z1lSl1kdKnKxbKXGQXLRoL11/d0R5hfEXieaWzN3cbuvMN3Ztfogsu7b7
	WcWcBZNQ4NNA7SYBki9pLh2vRxtkR3h4LIekqm+OQjBgexSotdmRsbtjJS3sfb+S7y9fmOcb0z+
	80/Uzl4DDoD4+bUGFpG4wrX4plWDFkw3pGJw2PANcFnWZhU8Q50cDS95gPiWnsqYYZnxTepaWyn
	R5XOVGxksPxB7gMvmqC8sbwShqRxTBn0=
X-Google-Smtp-Source: AGHT+IE92BVFrQCBsR676S80PJ/8gUcq+eiiRVuAaXrNsNJAA15CFSCVcQfNzvpwZlkxIxTyuZ2zOg==
X-Received: by 2002:a17:907:6d11:b0:b04:5cca:9963 with SMTP id a640c23a62f3a-b1bbb0678d1mr596051466b.41.1758192138250;
        Thu, 18 Sep 2025 03:42:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd110259fsm168886166b.90.2025.09.18.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 03:42:07 -0700
Subject: [PATCH net v5 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netconsole_torture-v5-3-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
In-Reply-To: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5260; i=leitao@debian.org;
 h=from:subject:message-id; bh=njsWipcAw6zDiWuPvoBPcLtz4KDuk27UDraQiXEyOh8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEovc49EgP5d4GjkGG1zgN4ovby5/JpB/Gu
 bWxpeoknFuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 bUcVD/oDDzmOZ/WDmw4umwdzF5PpslmCzGqFdnd/3/MODVV6eTR5YoBX/oi6j5rXsr7S3EWNp/d
 f3ANYb2uFJGznNnE9XNH65XPMHc/I4qKgB3n3MVsYIMv9lAZtmy+5vlZGMg3/cI2J/+MdwlK3zW
 FnGCOGZlqy1wad42ip35/RYKTLOD7XjFTMfplQJPskqgegn1NTy6Y9Wm8nBsZfzm3uICHzajxZn
 M9CjU5XmM0pTYug4g2UlfrMsKbhnK+Zj5MGgJGlS9E8nixYoj+qO50re1lS9iu0VBpjBOkxfXKf
 53sePs+4XNcd81g3m37vtkPFCbDVbsUnFlAc8iwKC11Bs5QMiyTB4DHA4IahWP3KSYsAWmJLEJp
 hYdq+ROdFTpJhSPiJp+jxVFdsp9fHayfLE3j/4iHwdzUsWJOrIpRW8pVSuJVE1gNb+DL9fXH0or
 0xrAerAVhVtYYW+skruPndxTCqJuEQoWP/jxmjfkhPmKUFAtCystb/dF1l7nSaR+fp82Lf27JBF
 nd6Lo8k38F3racYpgnnng+ddgJxqC80Vwuair90h+bwvjRzBy6/PrP8CCwv+z1XQwWVQm1Wv4FM
 TpLP/I2sBABwftn36Yks4msnf4aXvciaYs9PJAtefaYYC0dWdb3dkU+iBfY/mfa0sGRrmHTocQ1
 RMlF9QtzlesOqSQ==
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
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 984ece05f7f92..2b253b1ff4f38 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	queues.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_torture.sh b/tools/testing/selftests/drivers/net/netcons_torture.sh
new file mode 100755
index 0000000000000..723aa2488c19a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_torture.sh
@@ -0,0 +1,127 @@
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
+ITERATIONS=${1:-1000}
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
+		echo 0 > "${RND_TARGET_PATH}"/enabled
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


