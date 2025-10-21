Return-Path: <linux-kernel+bounces-863867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45BCBF9643
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CE246212D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677230F928;
	Tue, 21 Oct 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7Wl0tIy"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6482EBB9B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090439; cv=none; b=ev4GpKPRvzwSWR11zeL/zmMOKDZl8IPxcIOSs3flXfdqY9RjnY1LzNx+SR8E7mz4X6eXihXv2j1j/fHlENUpdISpfrdv12Gq7ypiaLEMuVRaneKio10j3nEtsJo5toFpOFjcN27QQHaWRh/Uiuvbz5Z6Og9iLK4QNZDRChvSY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090439; c=relaxed/simple;
	bh=BO9LQWlKtI1shvhDlqPu16W9qVY6XwRMkI/EUMrjZE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGvAhjiSRjx7Swk9HVb57zPpFYfQ4dyuxk/I6wPlkJjUvgZ2fII7o2nJnqIhNfxRyOrWMwsKIhQQ9Gte6k1Ixb3NRzOnWeTotXov7ZhVnNXR/0csrxmHhVpDuYnYVBQkX2Reo9a8iDigGw43E8Sv7XMpB7uhus/uV5ZtVvO8veQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7Wl0tIy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290dc630a07so33209345ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090433; x=1761695233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUo2ea9cpuDIObzkB+5zIj/xuLOHXIXFOy7ynypiC8o=;
        b=P7Wl0tIy0xZg5AkLjFTiA3CCE8IS61M2SuZhBvxwtKbZHQbOnRVMfUyHuwICv33eee
         akIrPGh0t4mp0Xes6zl0bKGgR2cpgBhDY6fL7hNd+Voua35NTWu1+S/V2bzljT+FT29E
         FeOliG/2dYsgTJY1yCZ9hO/mdTpJ6X7i1tYTYMIVCMcluI6XFIKPzwXaVUdbztem50qj
         JHxTcLMi/ljpqwovfLP//bjxGHzjx9/V+RlLSeZzOQAWxdYfrs6oDFrqfW5O7LNQDrxP
         Hxwdad5fu+M7FIwd5H6SefRAJpL3AYRY0A+iUeHbOCoV6tUcPA7fhWjD8F4CQQIcX//K
         bVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090433; x=1761695233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUo2ea9cpuDIObzkB+5zIj/xuLOHXIXFOy7ynypiC8o=;
        b=rNiPu9ppgq1TX1yQ+hmvs6pbtqIjvzmmHTxeyuzeACV1zCeo1sbDA2YVhtBFoE5CcD
         /K66Kmjx/dV5YH6sznuTOR37/8OdrPtP8UdXmAQMlZrJzEYpw0tMY1gkGwa/7rbRjj3r
         Fs3S70bP585X7ELcK8ENz1PWM0zxAcUsYM5uaFrTr6mvdXjP3wvDl7NArW00adrvT/0P
         /RDYO/GLGnzzl4DZv0g8cB7v3LJI5CIcIDNkCkh+vWy5uY9HRA29V2Mcl3yZIwEpqrdG
         3s1+kKaiYBVGZh6viG9h7LJAueY3REPPys00Ee71P2i4qs4TJuarxPYmx3QFz2NLxmlo
         4U8w==
X-Forwarded-Encrypted: i=1; AJvYcCXSKf0d28bKEag5fBtsQcCMvmgWf92Hysy4kscRChGW5G4Dl16wxcP5rm2jQ7r3i2QpLhP8F3AkILHvzkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlQB+ybt4hePxFegg/3MkdDv2zf8Wk7YwQmU+UDBeoXN5IMCg
	FGM1j6rknXMSEtBrDL0QbIjp1tFgPc536yRs6oNcPqELFb+EO0HkqN3H
X-Gm-Gg: ASbGncu8OIWXNI0tocn2uohS7gWcRB/x3VESh0kLXQomL2oGBDWtscKUqNH3t7py9wK
	vZLB1e5UUfFatkUlwPwdeZS7Q1H59QF4AKz9mpRPrTtQZ0LsQ+GiS/kqG7EFwo//iBIYfGznH7L
	NIYHZF1sbC0SVMKhSchSMGiBUZ0+QC/nXPcHBAaCogrANXbRCQjNZuC/2/fbkOv7eAlGi+vAB9p
	xpooYMm9phlBDYihYlQ4zaek415zMhCZAjBg1kseaDpkLJhQSvzzbSLDgL2sjCV+28PI+YArFFT
	oWgAuJoMZdgMnkgdVonorl0gIJnQ4LcU8oDNWCSxLhGWXSWbv35O1EgFqMQgRhq433+8e27wTvJ
	phL9E20GlEvDN53pwRnBHflqVxDbBzBh8JVCxOFsV0mvedM7FpHY16qhfvrmtb3/oTxcHlqr6fA
	==
X-Google-Smtp-Source: AGHT+IG4mF21y9b4ILzi1VUa6/N8UQb6jbaApizlergIx98zJ8IQeCKiZxAt0HtWfKk/EMQPlOy3Uw==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id d9443c01a7336-290cba4edaemr218306105ad.31.1761090433298;
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a813d4766sm9627762a12.5.2025.10.21.16.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:58 -0700
Subject: [PATCH net-next v7 15/26] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-15-0661b7b6f081@meta.com>
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

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5368ec7b1895..4ee77e6570e8 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -454,7 +456,44 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
-run_test() {
+shared_vm_test() {
+	local tname
+
+	tname="${1}"
+
+	for testname in "${USE_SHARED_VM[@]}"; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+shared_vm_tests_requested() {
+	for arg in "$@"; do
+		if shared_vm_test "${arg}"; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+run_shared_vm_tests() {
+	local arg
+
+	for arg in "$@"; do
+		if ! shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		run_shared_vm_test "${arg}"
+		check_result $?
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -530,23 +569,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
-vm_start "${pidfile}"
-vm_wait_for_ssh
-log_host "VM booted up"
-
 cnt_pass=0
 cnt_fail=0
 cnt_skip=0
 cnt_total=0
-for arg in "${ARGS[@]}"; do
-	run_test "${arg}"
-	rc=$?
-	check_result ${rc}
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile}"
+	vm_wait_for_ssh
+	log_host "VM booted up"
+
+	run_shared_vm_tests "${ARGS[@]}"
+	terminate_pidfiles "${pidfile}"
+fi
 
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"

-- 
2.47.3


