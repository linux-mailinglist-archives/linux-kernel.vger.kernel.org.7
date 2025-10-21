Return-Path: <linux-kernel+bounces-863873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD65BF9661
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BB524FD5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266731DD8D;
	Tue, 21 Oct 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6J/Aftu"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF172F5A14
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090448; cv=none; b=dpNKKsjMo2Ogkt75UbcmwTal4xisz1/1/h9wDsLazRd6QNBfkZWdmGWUD1DzyF135BAaTRCwYArhda4VC7hk69TlaUqQbKeOh2sez19uPngJdNqUp9DnpPs3P6QxqtJ0dstKiAdX5FHzPr8C+coL2c6dDc+jZ1grIkRqy0JaQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090448; c=relaxed/simple;
	bh=aux3K1IYIyz9wrqrgYN0zmRynTiqRa/rFWmvtJNo/MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+WNv4BZNEAS5UtNuzddIAX2UxNYUPoG+ou8C7dbokoaKiPajA2lmCBDqIjvc4l657xt5e7ZvuKXS2dWFDRbT7qJvpQbaFTuHgRQvREgkH53fIBjxvS9xgwiL50MyH/D5CZhfdI5d8vaX3krNypu8aXxhS9E8bwoyIvMmfSj37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6J/Aftu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so4296272a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090442; x=1761695242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkE1wm12EpboPq+xR0aDSe3dF2N2c2mo+B2K7wyT4X8=;
        b=C6J/AftuMusU8Mrlz5RZP9zd3cowo+Dg8ucaMJ5+lmjqC6A7BJ0CG7rav3J/C5SiXD
         tuytImbpcR0mTyq1QkzhVrjtZc/gB3iuGeqOYoi8AcgIxViVgm4zYih7wSD79MmnsHGo
         8ECrUsXacQ0rjTNMTT3oSS5KHtJqDBt85RMUzhshDzWiS0zZT0WffYfiYVp8g9kxISg5
         +yyU/SjNYUjfKPc2GID8TAK7e9P73uKKWRLH/vIKjLSfqI2ykYedX+ymITRkmhOMojBU
         1ET+y4bgjY3oBvMAWEbcfVwl9YdS8adLFnI7+hVOK5y3iAaBFhYWZPmqTMwNxGB54lMX
         VuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090442; x=1761695242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkE1wm12EpboPq+xR0aDSe3dF2N2c2mo+B2K7wyT4X8=;
        b=Zn45H0YDR/7K9e91Twra+K0e2ZgZ33HwuMxwPq9uiFwRkNAT30Xk7dicUGLIy1htBr
         3ybups4peW+RFeqDR4brQL01W3iUgsiDTOFq4qh0pNa5mN2Yc7srVkcG9qbMvdu5PZM9
         8GXT0QXQ9VFGo0/CM1RomyTOp65ZgBg2YLSYcgYpbxyy+RDzGV1os5RMxVfdEC7gbd/C
         hF6kQej17C8tSZGQhfoQwm/Wr8fxqIGItVAuxov4HupcKHjUTNxTkYkYfcn/Nn4c3ygk
         fzVboavGbJBBeDpbWsXXVvBP4jpKIK2gFyRQSekvBMt/mpmvvshZNVC/yG57+u3sxkRE
         4Gtg==
X-Forwarded-Encrypted: i=1; AJvYcCXnmVyDxLOdJge1qx3NSJN6BVRuzk1Mm1EY975dTLuX0yFBKInLYuhzGttqXZeHrYeNObemKV4Qh6zzfbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3y7k7ey7FIahA9axl9VRLpgj+wn0uF3IEqOn5bfX/eeGQw7o3
	aK2uZE96knTfORvLViJc6VhvlbGt++n8sOZJnLXsRZ5ncpAtdA7Un6J9
X-Gm-Gg: ASbGnctkPqxqvak/u7Uey4vGcnM4jqKLKdFEw7RbyxSOEwa1OzQlU0HBbBuo6qCS0y0
	mhY89Gw/W/ceoRf6lRCIiRDsW5JhbbS1m1DdguC0IyZevOnv95ADU6saNYIT/1dSh6pEIReBmRj
	ar3Qa8GdC3+a//LfO3j+ADL8EbWdx/ZdQ5lj5Nk36avK8znZMqL31WgsQngl0Fwh6pTQPd40dmI
	PC6nHon54iKccdUauipim9JGDelZcdQTpNornPMvihFUbkjR/ds4HDVO/BGnCSNq70ebj1en9oN
	esJ+1z6Ezm57DSXuZE5zDiWxxnknncgZoEkxJc2lOjtUYOhBT/pP5hWScZiPhVwWHiBZa0Wf+MU
	o+qFUgIk1euIIqXwzC7tcHziB76Aa/VqzMa5aW7a84Yntmh3nwoNadgUVhgiM3ccREz4+X9Ld
X-Google-Smtp-Source: AGHT+IGJHLCu0MjtQBg0SHgooNwgM1vSlSfWRfiRu2HNlz5nsiqtV1uW/yPe7aUNptDiEFDTA5YlTQ==
X-Received: by 2002:a17:902:ea05:b0:267:f7bc:673c with SMTP id d9443c01a7336-290cb27af4cmr269152055ad.44.1761090441540;
        Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm11933323a12.26.2025.10.21.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:07 -0700
Subject: [PATCH net-next v7 24/26] selftests/vsock: add tests for namespace
 deletion and mode changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-24-0661b7b6f081@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 123 ++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 0a5751c52fa8..f8fa8b16d6e3 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -62,6 +62,12 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_mode_change_connection_continue_vm_ok
+	ns_mode_change_connection_continue_host_ok
+	ns_mode_change_connection_continue_both_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -129,6 +135,24 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_mode_change_connection_continue_vm_ok
+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_host_ok
+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_both_ok
+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
+
+	# ns_delete_vm_ok
+	"Check that deleting the VM's namespace does not break the socket connection"
+
+	# ns_delete_host_ok
+	"Check that deleting the host's namespace does not break the socket connection"
+
+	# ns_delete_both_ok
+	"Check that deleting the VM and host's namespaces does not break the socket connection"
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -1141,6 +1165,105 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pidfile
+	local outfile
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+
+	# wait_for_listener() does not work for vsock because vsock does not
+	# export socket state to /proc/net/. Instead, we have no choice but to
+	# sleep for some hardcoded time.
+	sleep ${WAIT_PERIOD}
+
+	# We use a pipe here so that we can echo into the pipe instead of
+	# using socat and a unix socket file.
+	local pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout ${WAIT_PERIOD} \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ $2 == "delete" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ip netns del "${ns0}"
+		elif [[ "$1" == "host" ]]; then
+			ip netns del "${ns1}"
+		elif [[ "$1" == "both" ]]; then
+			ip netns del "${ns0}"
+			ip netns del "${ns1}"
+		fi
+	elif [[ $2 == "change_mode" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ns_set_mode "${ns0}" "local"
+		elif [[ "$1" == "host" ]]; then
+			ns_set_mode "${ns1}" "local"
+		elif [[ "$1" == "both" ]]; then
+			ns_set_mode "${ns0}" "local"
+			ns_set_mode "${ns1}" "local"
+		fi
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout ${WAIT_PERIOD} \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
+
+	if grep -q "TEST" "${outfile}"; then
+		rc="${KSFT_PASS}"
+	else
+		rc="${KSFT_FAIL}"
+	fi
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}"
+
+	return "${rc}"
+}
+
+test_ns_mode_change_connection_continue_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_host_ok() {
+	check_ns_changes_dont_break_connection "host" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_both_ok() {
+	check_ns_changes_dont_break_connection "both" "change_mode"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "delete"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_changes_dont_break_connection "host" "delete"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_changes_dont_break_connection "both" "delete"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


