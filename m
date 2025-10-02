Return-Path: <linux-kernel+bounces-840409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B184FBB4528
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF0F325455
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C51E1E1C;
	Thu,  2 Oct 2025 15:26:46 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7351D88D0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418806; cv=none; b=N7yZAzNDh17s7vR47Qvwk6cNfDTKL/ao5Bt/BIwK3Kz7ZJnS2amLtbWuliQgkHO0KfDUNt5WrJRBGaUfj+Qkgn17MoP9FkIqxneSqPPEQbdBDiej6e0S0Jtn1CewxSfBRhMK1zhMXbArgKxdpzl8k1FCqEGf1FHebMHljq+MsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418806; c=relaxed/simple;
	bh=wCTCXuF1yxmEp/u/Sr4POeQXqdQsOxIg5TvZ/SJ3ls0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6MBfQwGlBhYIBKyw/q2OkrBhHH1arJIFdqNdwGRPlayCf+W0gjI1YcsFju3rF5vYp/4LDiIvVAk5Q0TvOeXheb0dTD7aam4FHHE6Ako1AwPbpUdFxByWAVpG7X1BsIW87ED2p/Jy18Qeco9FnUo5wnO9mwXBapZwVzF6OSiwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3ee18913c0so212953566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418802; x=1760023602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXgombtdf1pG/9E0pDd7PwlfJe24y1WoCU+6S182X6w=;
        b=KvhHgJN/C/KGIqYJI/u+nv8JeaEUfucxF4w8RENy1QlIiwLrpR0YvEXYr2bvvkgIAb
         u5ksEAZyGfUP0b9IRwNz/pdtaVFlHVSOyz16EUzdLx8TsviieM674iCJvSkG62BOHbYk
         GifAZKhqcSoDi3IEobHppM54BVTMTtuKNXts9HYdHnFzN5xMeh3qeplt0FFLNmFTgION
         C3FSBO6PO7Xm9kKE2LiF9Xq9NFr8y0u1DFx4FkL7YYiRtxnCB2+PAfLQxGkx7n9ljkDd
         XVTClpMZ7x6Wnm/o83T47jz6j30/guyOOuXYrMvVs4GIk9mExjGCgPOa3u/LkmelY3Hq
         hdwA==
X-Gm-Message-State: AOJu0YxkAaSaNh9SjURuQuA1VZai1DK3gw4f7j4JoEbcP0RIyIS6LdRR
	ql1P+QMhEu3ukQ2QG3Birjnz9zA1kMg/cgyWXXNN+qKs3dpq+R7RDKxS
X-Gm-Gg: ASbGncuGn8bYu81sf3r276Zca7zSr4SrYi5CpMlwETdWLz0aBvpg3FvgIc9IVweFybq
	2gzhkfsn6h+VdaN4GihDPcZIM/kqtIptlV8bXasNMXtwc0iZFyfy82wuH65bSSibFxPTprA3oG6
	sIau6r2yeNcBslSY/r4R7k2wsECwjsvJrW3mWylV+y/eMZ0Ag7zIO2M5HzK379MG9oMD5B01e+8
	xMS5PiF4G2f3XIDbHsNAjRIq0uRb6jTxipeEjRpvGuMAeCYOxScma2/J6DnN0cSmtyXMpFaBFZ/
	LDFPyty474VzAPpOovrYPq2QDmVPoTJmW1fW4PERcsJhD4ctw6aF2Iw8WTX+FFjK6qo0a2dZfCD
	ks7PK8BGfREUqQ1YhX5hvgb83JfpGU1U/eMG+2Gs6uSSGXyc=
X-Google-Smtp-Source: AGHT+IGwJ7GX2udijpZY8tC506RtKUpv5oAxJ0Wta3SK+EKAIFSchsaTuH5oq1K3c4XJNvkVHHckCQ==
X-Received: by 2002:a17:906:6a1e:b0:b46:1db9:cb76 with SMTP id a640c23a62f3a-b46e6031e32mr947212166b.39.1759418802114;
        Thu, 02 Oct 2025 08:26:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606dc84sm222645366b.45.2025.10.02.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:27 -0700
Subject: [PATCH net v6 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-3-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5371; i=leitao@debian.org;
 h=from:subject:message-id; bh=wCTCXuF1yxmEp/u/Sr4POeQXqdQsOxIg5TvZ/SJ3ls0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pmsmmMGNKcgEnavHC2jMEtdvF8yeZdoGp4aZ
 3JHNKKmj6SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bd4lD/9+O4IHa2bZy6+3RktskQcbeHj09CYSlsackDR0zeECGyMpFB9wUmmDQMJW0foPBqCXB5F
 PrsVB83q1YgEsLu4mfivqXDYoBuYHVAImibFrRzwkWuLaAPNJnE/cN7niP885NMl6Ydrjrn5ySM
 FEx3yPsG1f6td68+Qzy9nKvNQmL/ImM6/ndzpvXuknJqYb3XWGa+8QpuZzOxemQYj0XFUoOO7rI
 h+tILR8p55nF+3AAilLeMBJfipr+WqGklE6+WbbvPzP4WlHlJypCZeuJBusi/gEbwwXmv4THtlx
 0/CjRNY3ufwtPFg0k+JfR+agGr7Pnfqlimayzxh92fMKp3DgU034derwx4K0edlAXc2vb+uh5Kq
 AKVQI352huzOxTrMHMaczB9zQkV4czj+BUYLOn8NUyj75HC/UL8FgPLqRGXCQGW0z4AZKp205/M
 ptqPctj1EEYeHoo7njjgUC5liEhdCvZ+FfWXiWdkjPjbq60Eu6PKS6Kho5jaYC7SPo7T9TV2+QX
 TarXwGH5FIfbck8Vca1C9DYEitV1IKf70mBxFXSzwQn1MBnahxE5WJTXWBT4I5axFynAZpapC3U
 SlXCzgalhj+34nNzXjy7wahhcOlSTGioynvN2TMsd7YY710BXiJEahoL6MejHXyq8K6/CmrN1k0
 n5ldAGaPgN8Bq0Q==
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
 tools/testing/selftests/drivers/net/Makefile           |   1 +
 tools/testing/selftests/drivers/net/netcons_torture.sh | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index bd3af9a34e2f2..42b3fb049f868 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
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


