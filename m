Return-Path: <linux-kernel+bounces-867567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69410C02FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BF814F9B54
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952E35580C;
	Thu, 23 Oct 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7n5lEqD"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A134B19C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244109; cv=none; b=bFZejsZFKGSEOTDqc22oTd10sOc8aAYPcObDin1p7O7H1Gj5qR5BMOoVyECk/s+9JuMoTWeTk07apm8RbSfmAFvq4uI4eu3flYnogvnbSmY4VbHwg8glf5IEb2B7qbpyAJ0arFd6g+MbusJTXcWHIe/blE+zVwso8lDVt6dcoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244109; c=relaxed/simple;
	bh=bXxBLfs7zprOHTZHXU6v9cfS97dNF6O/NmtSmg9Dcg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMOhDacU68EXmnT5I9A4olmHK0PhLNSyOz4lVS1p8+cliDVG+qcwSFpO0ZYechzzQC40F/c+tws/h3jLN9Pp5+c0Z9Tra616Ye1bkVfulqKM3OE9Ix0BF14oUgOrNTRERGkYpt7JDFcIUKJJDPiW8dJm++LB3+rG0XXcAM1ji9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7n5lEqD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33255011eafso1267494a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244098; x=1761848898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCwbZALKzMmSW9iQhg2QB2KqAXC2Lr1Db59OQ7PdTpE=;
        b=U7n5lEqDryM8SnXGwk8JtHrXP3CBhsmyffy0N0WIusMDCTAucg6hWgx5uDediDsY/L
         E3WilLZk8Xo9rDl6uJ3Ysv80XEuDISXoWtcwJFmyZQKwSAroSaEWkGUYw6fnw0+YCYfh
         EFk1x9osyk4LHHF7Ca1qChJ825VKfbccv7+qwUfad+6LAuU2UMJwsXuFGNCUzVRRe847
         Wh1OqZpdF+2/uNr3q0y6R4kKgvJcK2BGFuv6uGUh2vLvMrMDNv6/mQ7RKZyv4D2eI9A8
         h6iTldbIrjjXUgKpETA1jUnyU+oi9PCFx0REBwHBHjR6B9o2GsFlKudVG6kJBdqcaq5B
         iw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244098; x=1761848898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCwbZALKzMmSW9iQhg2QB2KqAXC2Lr1Db59OQ7PdTpE=;
        b=enCHBIMPCuf1FM+KRmfqPFgKGhtfGkiELuEUeMK5gV+m2pQ+0SuzlCygj2hJL0ApJC
         uc0JcyJ3aLOz8yRhtcvO2OaE7eVcvGjVuGxfnQ02el8vXPLnXxfLojc3NZgMhFDQCGxl
         du4CniukBVMxebaGi8vZzVtO2s3Y8BP8i76jxXuJibxTrQMKk6daVCCQ61kZ8piFTcti
         R0yZnimNF5bywRX2vDpCNE+YmXxLdYK5OkRRjIkQKJT8J2A5vUa7CPfrUBcdi2HAIhEL
         86MgzbtsFYBvBrdu/WaXFKgMnjdaHiBC7Ku3blpYBB+RTEOMkqLc7DQyZ0RZuKudL0oM
         ZZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWxEoEWUKjjRfCW4/8QeYoDMkYCrELiMwAlmVQfeIOXpOYfLJFiqQjJaP3q9lGURHwWEBDQV8bcXwxuQpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBnDURdpAzr/Xp6Mr8mmp+rno0/6/6ZSiAbJxUKbykTl4sEda
	nd+fD+YbMGVEjEm3G44KSRgzCH0F6til2I0bcSBp9sVO5vN+gY5DrZ4q
X-Gm-Gg: ASbGnctwW8G8A7u0Wdz9fxKhlkAo16H+TE5npaPKn3+ofDSKarTJWaNBPAmcH9U8Mjn
	3GaJe0BcpJNe9JyPDqlhFUywtnk1URRI7C3Q1SwngCkZA8ACsR9VCkGfmaMgAiWXNPG1BdlFK4Z
	uPLimp0KfylLcU6piYJ0ZwtRziWoLKYRFubt0o8zrFqUNnkXOSrO2crdBkRvzFnBFrTqr3l+cq4
	b/z22RE8Pc4Ic+kY8W6ZNywyi3Rzlwgf9i+iOcitBBxRyAPd9ChdJAwIwETOpAJhqF+J/Yok5/P
	Ab5RbPcpS10Wo8lqwL6M+Rf7EQ4KHNsAxMcdJW2mopSKZ6F60Khs57iIBAxL0de7giEE3b/nNYS
	NCIyetxyH34nwL9mAKkHca2/HItocYpYrC5fMlS4cj04vf/NgcSSD0dyK/+N1t3EzaLZI7xUuRm
	TC+VvWoEk=
X-Google-Smtp-Source: AGHT+IFx7yBJ75xjpC43+vM6BKxxk2sJHe/HPmtClbhgVqFNPtURD2tOiskQk/SLCG92Yy1QMi/lvA==
X-Received: by 2002:a17:90b:3f8d:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-33bcf861b1amr32391331a91.6.1761244097816;
        Thu, 23 Oct 2025 11:28:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2c3bsm6530615a91.20.2025.10.23.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:53 -0700
Subject: [PATCH net-next v8 14/14] selftests/vsock: add tests for module
 loading order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-14-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to check that module loading order does not break
vsock_loopback. Because vsock_loopback has some per-namespace data
structure initialization that affects vsock namespace modes, lets make
sure that namespace modes are respected and loopback sockets are
functional even when the namespaces and modes are set prior to loading
the vsock_loopback module.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 138 ++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 014cecd93858..9aa3200b160f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -68,6 +68,8 @@ readonly TEST_NAMES=(
 	ns_delete_vm_ok
 	ns_delete_host_ok
 	ns_delete_both_ok
+	ns_loopback_global_global_late_module_load_ok
+	ns_loopback_local_local_late_module_load_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -153,6 +155,12 @@ readonly TEST_DESCS=(
 
 	# ns_delete_both_ok
 	"Check that deleting the VM and host's namespaces does not break the socket connection"
+
+	# ns_loopback_global_global_late_module_load_ok
+	"Test that loopback still works in global namespaces initialized prior to loading the vsock_loopback kmod"
+
+	# ns_loopback_local_local_late_module_load_fails
+	"Test that loopback connections still fail between local namespaces initialized prior to loading the vsock_loopback kmod"
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -914,6 +922,30 @@ test_ns_diff_local_vm_connect_to_local_host_fails() {
 	return "${KSFT_FAIL}"
 }
 
+unload_module() {
+	local module=$1
+	local retries=5
+	readonly retries
+	local delay=1
+	local i
+
+	# Sometimes previously executed tests may result in a delayed release
+	# of the reference to the vsock_loopback module and result in the
+	# module being unremovable. For that reason, we use retries to allow
+	# some time for those references to be dropped.
+	for ((i = 0; i < ${retries}; i++)); do
+		modprobe -r "${module}" 2>/dev/null || :
+
+		if [[ "$(lsmod | grep -c ${module})" -eq 0 ]]; then
+			return 0
+		fi
+
+		sleep ${delay}
+	done
+
+	return 1
+}
+
 __test_loopback_two_netns() {
 	local ns0=$1
 	local ns1=$2
@@ -1266,6 +1298,112 @@ test_ns_delete_both_ok() {
 	check_ns_changes_dont_break_connection "both" "delete"
 }
 
+test_ns_loopback_global_global_late_module_load_ok() {
+	declare -a pids
+	local unixfile
+	local ns0 ns1
+	local pids
+	local port
+
+	if ! unload_module vsock_loopback; then
+		log_host "Unable to unload vsock_loopback, skipping..."
+		return "${KSFT_SKIP}"
+	fi
+
+	ns0=loopback_ns0
+	ns1=loopback_ns1
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	ip netns add "${ns0}"
+	ip netns add "${ns1}"
+	ns_set_mode "${ns0}" global
+	ns_set_mode "${ns1}" global
+	ip netns exec "${ns0}" ip link set dev lo up
+	ip netns exec "${ns1}" ip link set dev lo up
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	port=321
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${port}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+
+	host_wait_for_listener "${ns1}" "${port}"
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${port}" &
+	pids+=($!)
+
+	if ! host_vsock_test "${ns0}" "server" 1 "${port}"; then
+		ip netns del "${ns0}" &>/dev/null || :
+		ip netns del "${ns1}" &>/dev/null || :
+		terminate_pids "${pids[@]}"
+		return "${KSFT_FAIL}"
+	fi
+
+	if ! host_vsock_test "${ns1}" "127.0.0.1" 1 "${port}"; then
+		ip netns del "${ns0}" &>/dev/null || :
+		ip netns del "${ns1}" &>/dev/null || :
+		terminate_pids "${pids[@]}"
+		return "${KSFT_FAIL}"
+	fi
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	terminate_pids "${pids[@]}"
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_loopback_local_local_late_module_load_fails() {
+	declare -a pids
+	local ns0 ns1
+	local outfile
+	local pids
+	local rc
+
+	if ! unload_module vsock_loopback; then
+		log_host "Unable to unload vsock_loopback, skipping..."
+		return "${KSFT_SKIP}"
+	fi
+
+	ns0=loopback_ns0
+	ns1=loopback_ns1
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	ip netns add "${ns0}"
+	ip netns add "${ns1}"
+	ns_set_mode "${ns0}" local
+	ns_set_mode "${ns1}" local
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	outfile=$(mktemp /tmp/XXXX.vmtest.out)
+	ip netns exec "${ns0}" socat VSOCK-LISTEN:${port} STDOUT \
+		> "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	echo TEST | \
+		ip netns exec "${ns1}" socat STDIN VSOCK-CONNECT:1:${port} \
+			2>/dev/null
+
+	if grep -q "TEST" "${outfile}" 2>/dev/null; then
+		rc="${KSFT_FAIL}"
+	else
+		rc="${KSFT_PASS}"
+	fi
+
+	ip netns del "${ns0}" &>/dev/null || :
+	ip netns del "${ns1}" &>/dev/null || :
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


