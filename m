Return-Path: <linux-kernel+bounces-863875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94021BF9664
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424DF3A8DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6583296BD5;
	Tue, 21 Oct 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqJJlJwk"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4782F3C12
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090449; cv=none; b=FGEcn3Q5dRAs69zyEBJRaJBJQFuKCP4yR7hNSAZaIQ6ASKZqZVsIDknhRPsR8+p0F+3QJKoiv6otKE23kMDco1RPhtCscXMxml6s7zcAHCelsld9l03Ne9uzZSgexTvkPuHvYhgyslNr80ZCeXo3btl8lPflpxJtrCgGxFCpx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090449; c=relaxed/simple;
	bh=3y8PIRX5hkWQeTfoKXTU1ofOrszBguxn5J0xvkQVls4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMB5Ts0OLNj91j8kpccmzLn2VguZUZ6r21sLDM7DEnsskUWY/d9+4mloPLId/vzf3FRdv5oyXWrdayhILlqES5BYJsODjftIotS/5kn6BIr7OHcFtISwXm0RoEeGTQpBLna7pWPsuWVBCMENxDRzlg2Oiwnq4BupBi0dHcCD8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqJJlJwk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so5461686b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090441; x=1761695241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CK9u+Kt1JkmPpt+Zpi9iArk9lXtsDJKTwzBLD9LkTbQ=;
        b=NqJJlJwkyLQpe0RCVgOzL3F7QTYr5Ad370qUiPMKjo2JSTcuxPFnJOs3htPOcTMUax
         /hucTKt8HC7Pe31fJ8dNAb8ye9C/iq4Y8TF4IEIfoP2viD5b0J3IEXpfDbkjDynJFudO
         O07hdhUulsyc+1YHijgX/qmZY5ABIj2c1iV9eOUJV3f2d3LQ5knInZ5nTPXNzaOBgKnV
         81dTpTMoBePW5pfxOoUxNW4UEbUWIzshPpIsE9fi4tC3CZiNI1fuiV/SiDxn6xMsb3uY
         fIAq53l4W4JbuJsdQOmZCtwr666zb36Gr45HE8CcTKMVy2JJ968nhSRwnON9WCE44s5q
         uNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090441; x=1761695241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK9u+Kt1JkmPpt+Zpi9iArk9lXtsDJKTwzBLD9LkTbQ=;
        b=IggXp8ud+Fzr6a8YXH93c8/CD6lfdAtuioIATlW8FrMY7MTH6c2+ebjGvkgb+FdHKY
         oIowdXWyOXI+VAKqE40ZNAPdRNZP0mf8Wyakl4spNdKdL1Y3e1VeELv98rwqZVNJZvUD
         8MiW0OCgaaNiBZWIdUuGtixQ0eDl8ycedGLAfM7rekd94USv9rl6052bLqkwPsuB27hM
         82jEmoaF1bFC0H4WPehBrwvEV3rOZHNFYMlvWbd+kxh48jdaICUiWl+q1vyABqwhxSJ7
         5+yua+3hiZ/DQB111RqqBLHPT0qBB7Eb3oQcyn2mUB8CQQlTwn9UgAsxojHuBACnsc0A
         wY8w==
X-Forwarded-Encrypted: i=1; AJvYcCW8WCf2QyRCiQfRv9yUxuO9kt9dATd1u+Ed8QEUXLjiRr+D7Wvqc11WfSgzUs3A8Yu/ToeKok2mFSm1deo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXYk6uEampn3O7JMIp8Wl0+RKCYAAEuK/FbGjBk9964hmy/7El
	ide1CCHdlGClDHymk1sMy88bWtYFKGO/t0/nyuRj8Ut+5zyJiEF2BBeI
X-Gm-Gg: ASbGncs0It6Zdemu22O8/Qen04RSimwCOfwYWY1QJef9YZt8PTwk7qHYCpwjHebf4Hq
	v+Vd5shdhxDCkhShrlbWX0cKXQQnt9p3BqX+kZvCw3C/C12LyQpU+ONEPQ6kZUAfwALR7xsm8lr
	nBw53Q/s7qy0b7DV+exn0IaIp+nB3HhbGx3wjraGcksHwvaSZDI6hi779pID74YTO5IrGBpwexf
	/a18GPQRv+n47hgk55ud8A5KIqDIu+0qTo2gLVuNbd0qhNgBCMoUTfWshDjsoNJP6t5x4mS8u0I
	2JoFIL5GbYz3WBjOpiXEhi+1lJa693iEiP2KsPs1qwyttHkXoEpQYNtrBfSjtoWb8+xaBG6oN4x
	MdXZfhM/kcSbQ0w7BOVrhsXVguMj60ghpL2YOCkrPs3uq8NbEyCKtLtzraLcbbPueA7d6m3i5Fa
	8oTfNM08cx
X-Google-Smtp-Source: AGHT+IFJdMZKgJWaplAshFUldw2jLwZXkhw3pWDBy0khuKWid6KnvqbfJG8+4bhgh4tiivM884/1og==
X-Received: by 2002:a17:902:db0b:b0:24c:cc32:788b with SMTP id d9443c01a7336-290c9c8a77dmr227913505ad.3.1761090440554;
        Tue, 21 Oct 2025 16:47:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fdbe35sm120169985ad.46.2025.10.21.16.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:06 -0700
Subject: [PATCH net-next v7 23/26] selftests/vsock: add tests for host <->
 vm connectivity with namespaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-23-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to validate namespace correctness using vsock_test and socat.
The vsock_test tool is used to validate expected success tests, but
socat is used for expected failure tests. socat is used to ensure that
connections are rejected outright instead of failing due to some other
socket behavior (as tested in vsock_test). Additionally, socat is
already required for tunneling TCP traffic from vsock_test.  Using only
one of the vsock_test tests like 'test_stream_client_close_client' would
have yielded a similar result, but doing so wouldn't remove the socat
dependency.

Additionally, check for the dependency socat. socat needs special
handling beyond just checking if it is on the path because it must be
compiled with support for both vsock and unix. The function
check_socat() checks that this support exists.

Add more padding to test name printf strings because the tests added in
this patch would otherwise overflow.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 463 +++++++++++++++++++++++++++++++-
 1 file changed, 461 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 69ec6ec82b0c..0a5751c52fa8 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,7 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#		* socat
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
@@ -48,6 +49,19 @@ readonly TEST_NAMES=(
 	ns_local_same_cid_ok
 	ns_global_local_same_cid_ok
 	ns_local_global_same_cid_ok
+	ns_diff_global_host_connect_to_global_vm_ok
+	ns_diff_global_host_connect_to_local_vm_fails
+	ns_diff_global_vm_connect_to_global_host_ok
+	ns_diff_global_vm_connect_to_local_host_fails
+	ns_diff_local_host_connect_to_local_vm_fails
+	ns_diff_local_vm_connect_to_local_host_fails
+	ns_diff_global_to_local_loopback_local_fails
+	ns_diff_local_to_global_loopback_fails
+	ns_diff_local_to_local_loopback_fails
+	ns_diff_global_to_global_loopback_ok
+	ns_same_local_loopback_ok
+	ns_same_local_host_connect_to_local_vm_ok
+	ns_same_local_vm_connect_to_local_host_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -76,6 +90,45 @@ readonly TEST_DESCS=(
 
 	# ns_local_global_same_cid_ok
 	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
+
+	# ns_diff_global_host_connect_to_global_vm_ok
+	"Run vsock_test client in global ns with server in VM in another global ns."
+
+	# ns_diff_global_host_connect_to_local_vm_fails
+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
+
+	# ns_diff_global_vm_connect_to_global_host_ok
+	"Run vsock_test client in VM in a global ns with server in another global ns."
+
+	# ns_diff_global_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
+
+	# ns_diff_local_host_connect_to_local_vm_fails
+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
+
+	# ns_diff_local_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
+
+	# ns_diff_global_to_local_loopback_local_fails
+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
+
+	# ns_diff_local_to_global_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
+
+	# ns_diff_local_to_local_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
+
+	# ns_diff_global_to_global_loopback_ok
+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
+
+	# ns_same_local_loopback_ok
+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
+
+	# ns_same_local_host_connect_to_local_vm_ok
+	"Run vsock_test client in a local ns with server in VM in same ns."
+
+	# ns_same_local_vm_connect_to_local_host_ok
+	"Run vsock_test client in VM in a local ns with server in same ns."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -102,7 +155,7 @@ usage() {
 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
 		name=${TEST_NAMES[${i}]}
 		desc=${TEST_DESCS[${i}]}
-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
 	done
 	echo
 
@@ -220,7 +273,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh socat; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -271,6 +324,20 @@ check_vng() {
 	fi
 }
 
+check_socat() {
+	local support_string
+
+	support_string="$(socat -V)"
+
+	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
+		die "err: socat is missing vsock support"
+	fi
+
+	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
+		die "err: socat is missing unix support"
+	fi
+}
+
 handle_build() {
 	if [[ ! "${BUILD}" -eq 1 ]]; then
 		return
@@ -308,6 +375,14 @@ terminate_pidfiles() {
 	done
 }
 
+terminate_pids() {
+	local pid
+
+	for pid in "$@"; do
+		kill -SIGTERM "${pid}" &>/dev/null || :
+	done
+}
+
 vm_start() {
 	local pidfile=$1
 	local ns=$2
@@ -562,6 +637,389 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_diff_global_host_connect_to_global_vm_ok() {
+	local pids pid pidfile
+	local ns0 ns1 port
+	declare -a pids
+	local unixfile
+	ns0="global0"
+	ns1="global1"
+	port=1234
+	local rc
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}"
+
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
+	pids+=($!)
+
+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns1}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	for pid in "${pids[@]}"; do
+		if [[ "$(jobs -p)" = *"${pid}"* ]]; then
+			kill -SIGTERM "${pid}" &>/dev/null
+		fi
+	done
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_diff_global_host_connect_to_local_vm_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_ns_diff_global_vm_connect_to_global_host_ok() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local unixfile
+	local pidfile
+	local pids
+
+	init_namespaces
+
+	declare -a pids
+
+	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+
+	ip netns exec "${ns0}" \
+		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+
+	ip netns exec "${ns1}" \
+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
+	pids+=($!)
+
+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pids[@]}"
+		rm -f "${unixfile}"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${unixfile}"
+
+	if [[ ! $rc -eq 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+
+}
+
+test_ns_diff_global_vm_connect_to_local_host_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:${port} STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pid}"
+		rm -f "${outfile}"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_host_connect_to_local_vm_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		return $KSFT_FAIL
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return $KSFT_PASS
+	fi
+
+	return $KSFT_FAIL
+}
+
+test_ns_diff_local_vm_connect_to_local_host_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+__test_loopback_two_netns() {
+	local ns0=$1
+	local ns1=$2
+	local port=12345
+	local result
+	local pid
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+
+	log_host "Launching socat in ns ${ns0}"
+	echo TEST | ip netns exec "${ns0}" socat STDIN VSOCK-CONNECT:1:"${port}" 2>/dev/null
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == TEST ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
+test_ns_diff_global_to_local_loopback_local_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_to_global_loopback_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_to_local_loopback_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_global_to_global_loopback_ok() {
+	init_namespaces
+
+	if __test_loopback_two_netns "global0" "global1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_same_local_loopback_ok() {
+	init_namespaces
+
+	if __test_loopback_two_netns "local0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_same_local_host_connect_to_local_vm_ok() {
+	local ns="local0"
+	local port=1234
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_same_local_vm_connect_to_local_host_ok() {
+	local ns="local0"
+	local port=1234
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ $rc -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 namespaces_can_boot_same_cid() {
 	local ns0=$1
 	local ns1=$2
@@ -820,6 +1278,7 @@ fi
 check_args "${ARGS[@]}"
 check_deps
 check_vng
+check_socat
 handle_build
 
 echo "1..${#ARGS[@]}"

-- 
2.47.3


