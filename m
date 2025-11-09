Return-Path: <linux-kernel+bounces-891900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E470EC43C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7441F3B41E1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C062E3AEA;
	Sun,  9 Nov 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhfXtBun"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881F2DFF18
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686387; cv=none; b=XS4csLDA/rvwpr4+y2pi64F5s8HPlEJL9IFFYYHdTUdoh2hv7nlF9wh3mLdyNXxJxjv+H3XIjVwKELIKan1WhRW92HeygRgYgbeVA5EvW1T+1wRSqKckEsbpVSHSdrC+C/lGDDPlvElPxz8tg+AF5itkYgwsmX9NjQL3FedezDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686387; c=relaxed/simple;
	bh=UvRQaBE+xBWDjEoTvma8nwauXFhwx/8Rb4iPAQ5Y+mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSaiNnyH+eaejtj5eSGgYUUlD3yYwvtyjw4hkMZkHXobF9Upr0kC8lHbks3kXALBHAzgc9+n1tzMYnDsTt9wQOEncJKuqDo2yNrDsnZ4U8lJqrbWAmUK63aM59YiSl1Q4Wkx9AqaHLo52HzN/7MdgfmKhJSPEq3k4VlMmFnPEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhfXtBun; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b895458cso1011217f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686384; x=1763291184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+hYRYhUCbZd/x0skNNMpBqkY/5tBkO38vfAM3Du2Qw=;
        b=RhfXtBun2NIt/w9RhohkzRGSorw8FN5Hi9T9CGuwhB0pLKA5wMtwygaHD2YE4iVm4p
         9bnLXueZvBF358A2rGdMbTpyvbuWfFbhZfEGKRtryWF3qnslTvKc0KZHdpa5cai+IcOX
         GsztNZLvGjBV1dp9clbjeBLv6juB/vlBF1pjfJhR3Q18hL8fBvKLBDyk8neU6pXDC3LY
         dUgQ/voCzbRzqe+g+1TU2gSSoYMPBrtwUZmwNglWjC01e/uiVVtFRbZVUl7Gcq9fTcnV
         JVFNqYbhGkGSGhBdZAJmIwzmqqYySU9O8pufu0RqVS85Pt68ysDhIs8c3ptX0TpyrqVh
         dfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686384; x=1763291184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+hYRYhUCbZd/x0skNNMpBqkY/5tBkO38vfAM3Du2Qw=;
        b=MLelty/pH08hiUNbHQKrv+2NN83stVVZeChH3CUVeab6/ggqueSaNGIZjUwIthJAWj
         wB6HSL79OJ9Q9zoIs1hIdmNb4Ig/yIUOOBQ/yYNghAuPI93uHEI0dpwpopzIzyz+CUuq
         rHOzF3jromLUnJjz1TDMwSPD4LCJTLWAbcWMUGdnPPpbeY+5/XJtfnne84X09X/PVdta
         h4ZUGDhF7yag2KjL59mC6dAPCOhqCo5buy+LhM3LhuT19WYgMoXSucxQ1l4/RfC5II6W
         iKUTwxLWTDvYxsZce6/Kdu0Sw0gayE/299N4z5HUumeIdKTUSypE0mg6Acij4NlDnonA
         /UhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXWJv+1lFHic//0wIxJJ0fl1+yHiyeQrIUSgCml1sEMmCXEwCb5FyffiVCvyZ89XV2zLjU14cghtxm5MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJ1KSOIx0g++PCgm99ArTwTtUU3BXAIzkCuSdtS5nmQ1Vvs9M
	XrZ+QZ4PmMlhVhLskY2xmHuLnW3bcTG5qf33UuTlpb6IZuYDPePa59gX
X-Gm-Gg: ASbGnct5OvATCeGrOvqod2G7mfCEduqHW/RFzfdTsL+1QNn8VUS2FHeKjJgk9anPPuy
	kE6utD0F2rGdOi/hHm1lx2Dn0fe+PFkUYadfiNV/pC5ZzwG+bMvVDF0qI1Irysa8MYDP4dCf5xK
	8xDUO4z6lYu2Y0EyWGIkIefYBswJ3AX2h7WmoXEJgJS6fZrnEpTFBT0jz3VRfHmFlhJM+3SImpy
	JsYh9SMFMwt7sVOqQx/ir6dwkGkw5JFp2FyzrseTJIJyH1muTvxWPpktDa9K1fYIQ9W6hW0b36p
	9yj+Ai5ju5vfRfcOSJ47zl2ak+BwDcLKMw0KU+XAof/o4Ux2vht36tVitttBT8jn8DfkM/Ktj3p
	b2uB/LcIYcAx5t6H0Bmd4lm/qXgac3n2TJ1r1WMmdCVqUz8uF51G7TGm5VH1woA/9+PSzQOaG20
	jBhamgLQ60oK6IcbQ=
X-Google-Smtp-Source: AGHT+IH92q5QOXzI4WZ4CJLmbmLqEP8LnnpB979AA8pp1DpotusvDsiCb5AlA0AXesNOD4EDvj76Ww==
X-Received: by 2002:a05:6000:2313:b0:42b:30f9:79b6 with SMTP id ffacd0b85a97d-42b30f97cabmr2472285f8f.58.1762686383589;
        Sun, 09 Nov 2025 03:06:23 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:22 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:56 +0000
Subject: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=6066;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=UvRQaBE+xBWDjEoTvma8nwauXFhwx/8Rb4iPAQ5Y+mI=;
 b=Eb0IHEBBAkQPP9Q1S+7s8n9lVkGxOwxJABGurHAOtNTpg37S2wv8wVq4+JLgHqVDrahkZ9cp0
 wu2PefKD3ZsCc7ly9N818FVmcPMlbA8hZoJcWoLoiF3N0WEZ9aPHkZp
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Targets are created via cmdline parameters to the module to ensure that
we are able to resume targets that were bound by mac and interface name.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++-
 .../selftests/drivers/net/netcons_resume.sh        | 92 ++++++++++++++++++++++
 3 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 68e0bb603a9d..fbd81bec66cd 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_resume.sh \
 	netcons_sysdata.sh \
 	netpoll_basic.py \
 	ping.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e89647..88b4bdfa84cf 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -186,12 +186,13 @@ function do_cleanup() {
 }
 
 function cleanup() {
+	local TARGETPATH=${1:-${NETCONS_PATH}}
 	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
+	echo 0 > "${TARGETPATH}"/enabled
 	# Remove all the keys that got created during the selftest
-	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
+	find "${TARGETPATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
-	rmdir "${NETCONS_PATH}"
+	rmdir "${TARGETPATH}"
 
 	do_cleanup
 }
@@ -350,6 +351,29 @@ function check_netconsole_module() {
 	fi
 }
 
+function wait_target_state() {
+	local TARGET=${1}
+	local STATE=${2}
+	local FILE="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"
+
+	if [ "${STATE}" == "enabled" ]
+	then
+		ENABLED=1
+	else
+		ENABLED=0
+	fi
+
+	if [ ! -f "$FILE" ]; then
+		echo "FAIL: Target does not exist." >&2
+		exit "${ksft_fail}"
+	fi
+
+	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {
+		echo "FAIL: ${TARGET} is not ${STATE}." >&2
+		exit "${ksft_fail}"
+	}
+}
+
 # A wrapper to translate protocol version to udp version
 function wait_for_port() {
 	local NAMESPACE=${1}
diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
new file mode 100755
index 000000000000..404df7abef1b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,92 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test validates that netconsole is able to resume a target that was
+# deactivated when its interface was removed when the interface is brought
+# back up.
+#
+# The test configures a netconsole target and then removes netdevsim module to
+# cause the interface to disappear. Targets are configured via cmdline to ensure
+# targets bound by interface name and mac address can be resumed.
+# The test verifies that the target moved to disabled state before adding
+# netdevsim and the interface back.
+#
+# Finally, the test verifies that the target is re-enabled automatically and
+# the message is received on the destination interface.
+#
+# Author: Andre Carvalho <asantostc@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+rmmod netconsole 2> /dev/null || true
+
+check_netconsole_module
+
+# Run the test twice, with different cmdline parameters
+for BINDMODE in "ifname" "mac"
+do
+	echo "Running with bind mode: ${BINDMODE}" >&2
+	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+	echo "6 5" > /proc/sys/kernel/printk
+
+	# Create one namespace and two interfaces
+	set_network
+	trap do_cleanup EXIT
+
+	# Create the command line for netconsole, with the configuration from
+	# the function above
+	CMDLINE=$(create_cmdline_str "${BINDMODE}")
+
+	# The content of kmsg will be save to the following file
+	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
+
+	# Load the module, with the cmdline set
+	modprobe netconsole "${CMDLINE}"
+	# Expose cmdline target in configfs
+	mkdir ${NETCONS_CONFIGFS}"/cmdline0"
+	trap 'cleanup "${NETCONS_CONFIGFS}"/cmdline0' EXIT
+
+	# Target should be enabled
+	wait_target_state "cmdline0" "enabled"
+
+	# Remove low level module
+	rmmod netdevsim
+	# Target should be disabled
+	wait_target_state "cmdline0" "disabled"
+
+	# Add back low level module
+	modprobe netdevsim
+	# Recreate namespace and two interfaces
+	set_network
+	# Target should be enabled again
+	wait_target_state "cmdline0" "enabled"
+
+	# Listen for netconsole port inside the namespace and destination
+	# interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_msg "${OUTPUT_FILE}"
+
+	# kill socat in case it is still running
+	pkill_socat
+	# Cleanup & unload the module
+	cleanup "${NETCONS_CONFIGFS}/cmdline0"
+	rmmod netconsole
+	trap - EXIT
+
+	echo "${BINDMODE} : Test passed" >&2
+done
+
+exit "${ksft_pass}"

-- 
2.51.2


