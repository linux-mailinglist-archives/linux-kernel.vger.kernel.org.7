Return-Path: <linux-kernel+bounces-863868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E36EABF9646
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE563503705
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130930F555;
	Tue, 21 Oct 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H92IHcDq"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8462EC0A9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090440; cv=none; b=Rj1ucUwCLINfqLYl+m9wJUS80atTtNqhchbjGHR6iEOFBCtMZk2KrqGtG5mlngy87FNT7YYJUQbMoFfjsKgNYnhhDOk3EqwSAzZm2qcOBubbabXvRJISk3XrkD0vMTNkeoSpGldC/Gu3ip3QoDSPpr6BjTXAM5ZbQBS5DXHScoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090440; c=relaxed/simple;
	bh=X9WzUQups8TkdsWmkHEfnPyp3k1TVWabO4OwH0YlSZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmB84i7EmUKHsrcilte9tXZc4PJUOyUsM+7+nwlS1CHrvCE4wXV81gDy9Dgt+8tg949+OSoO0fpUECVUHiQpzeNzMW74u0vj6J3nmmDtFGXWQ+zwcxTp1kTKuI0nn8edqzashcFroKb0PPnmY1IEydqNRdvCAG4t9LQLTJJ1WDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H92IHcDq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso3990744a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090434; x=1761695234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExL6guYlGMpC9HoFsJPCjZr8NPSDth7dE4rzR6CctFc=;
        b=H92IHcDqAOBl+0N4MTZ+rK0vKqOC/cVUE2BVySlhzWIYtSKBRbnZLDQZztI0Nw2Ycp
         i7Md4C8ArGNcoGruR8l5xxve9Ak7vuSKxxVuOHriYtweHZgLp5spVyDheuCxj/e0UbLS
         FLLg96sJIAne/k0FFHiP3y+ExhV1V0Fr2P2cvoWH0fEkkcnNsTReFskJYCmgcUGuMuOx
         LZzAW1Xxwkzg2o4jhAxpUOaWK59ghe/JDPr/SiCmRF6esklRVVs0jXc6Bdj3XJN6yXti
         2lmNVsc8eTF2zHXqG9BPIYBnaZtVcKyWKVZdT8bUvVSLCh+Bi35gsnEnHuLLbi+AeK8k
         0QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090434; x=1761695234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExL6guYlGMpC9HoFsJPCjZr8NPSDth7dE4rzR6CctFc=;
        b=Tmmayk1FcLVsNhOqzr3jSD6eQGHDKdAVnjcm0KdW/z3xpY8twQKNytzD0/+iya7eaB
         WZaK/KzTkmDvYa+FQMlw4oBmNRxs1jo4LemNFFcdMWgYE79JnlV4b8PLLePNcN0FDlB7
         O8N+jz+4nTv8WTTfrPTQXa6Kct74DjrJCUUFEfLHW0N7Vs1AspPLnZh9mXMAWwHMZg90
         uo6H0YZ026bmRgV/y/iretf2K6Q0MeXnBb/cp0OvModnGxccZDKaGj7uTY/6XPsPdmFD
         HtrZ/bDIeGQxsBupn+b2Y4P9xk6Lir8F1HRI/YaXrk3k8YGYvbwUTBn5n6Zoo7QoONtB
         SYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4uuE3qaYcM6aplO1QY2YlmAXtD9OALGdTMwQNadSzQREdx8pKy33eAfT+xbxLm4xOQPSK5/wOYaKAl/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Dk3g5q3pspwGjD9kD4rUtm1dUKDuRDuePVQ1mBf4CUVhRAXH
	Q1StIQzOrTbTJjSzpCb6nDbQAX1sxIDidMiupZa6iq657+C9+ImlULXS
X-Gm-Gg: ASbGncsM9L9CSIHWsDfN+/eWXR0JWwFX0VGSwB1JoegWRJl5YUIVg/NbNcHmsLmd833
	sryhr+hmCJgJcWljoHCTMUerxww3DHR7WZxQUtzeSTYQM5zGIXChpf0piz5vkYHvLTdPCRyx++d
	+Um44IcGd1dcm3Td44aYIieG+2AQKsXuGM4eoGUr8bIP5RNCDhd245ssczPFwMoRKdlHTSCglo4
	p31NkXd3YKFdclteh1ImjElEsRjkmcjm8ZivNTJUCuchTOLYc7ZXcxMuHGzPjIxqNrFGe093CNb
	aXu6V2eQV2Vd2r25hwa6CtxLpiTzNfv4OXvXkh0zMFTJXYry+jmpHwGcdOP0DURpfrGskzPTXAj
	BR3DMYbtAyvTeTuJWsaVNyqYdtFCJwNlqFcu79t3dC+oMOPyqa1//ijWlmbLQcCjHWPINl9OH
X-Google-Smtp-Source: AGHT+IGFjlVJaAVI5l1l9XcDArSqr800gCJXUHbkf8qJCt41RTFarYvpfL88FKlbpibTKt7cQQNqLw==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr231390815ad.3.1761090434188;
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcc1sm120666255ad.82.2025.10.21.16.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:13 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:59 -0700
Subject: [PATCH net-next v7 16/26] selftests/vsock: add namespace
 initialization function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-16-0661b7b6f081@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4ee77e6570e8..914d7c873ad9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -100,6 +101,45 @@ check_result() {
 	cnt_total=$(( cnt_total + 1 ))
 }
 
+add_namespaces() {
+	# add namespaces local0, local1, global0, and global1
+	for mode in "${NS_MODES[@]}"; do
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ns_set_mode "${mode}0" "${mode}"
+		ns_set_mode "${mode}1" "${mode}"
+
+		log_host "set ns ${mode}0 to mode ${mode}"
+		log_host "set ns ${mode}1 to mode ${mode}"
+
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" | ip netns exec "${ns}" \
+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?

-- 
2.47.3


