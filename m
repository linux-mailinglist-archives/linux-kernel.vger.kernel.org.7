Return-Path: <linux-kernel+bounces-885544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932DC3346B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8857B428635
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D173491E0;
	Tue,  4 Nov 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx/F4HeD"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B43148D8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295959; cv=none; b=IOXJowtKU5prHZcttNhIE1a6rUGDAJ7jTL2tNAoT4uJJH6i8TGduNHSSHkCCPvm3d3zlG5yeuf+vgk2mMkwgg3cZ0N5TDWNc8DIThvIN/ob4LpliHHKQ70JyZW/lGRXQGxG1v25jehZhyETAlqYdCS9SSW7rh3nAxGjOrx95z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295959; c=relaxed/simple;
	bh=6JthngltpkcWftejwxT4QQ+XaYtKnwnkggaq1rsEx0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRPAV70M23Cdl9KChS5MGpTJZva0rQXS8TCW1dX5ee+0AxJpVrIXW05J4P3LLr1IL1aZpgDTLt1t9QGZVs5uIgiOgsnfB2MympNeTfZWpspCpONW2i7VbNFOekN0P4/lIIl3hqKfrsRnV9OvpMz5GhxTL7gIdIyoh4UO0Cmhlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx/F4HeD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6249927a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295957; x=1762900757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDsH9kNNXBt4JKt5mitfCe2Rq8PZuvGot+36QHyMJvw=;
        b=Tx/F4HeDm+BFKSyBmuLkmH5BodI95/gSDjsipVOfv/1NFukSwECQX8AkHkfoW84fUv
         M8mflcwUkBtSASZAh/IsaJnrZlhTJbDgsEF+NHTcLtKPKH0R3ow7J6p5ucBl2EEOQCbQ
         xs4lmoD1VuuG3yvLAsm2ef9ELx2oc5RPWHEe80LmGPsM8rXcslXx8WBMvXbaG7gJ0ZGf
         PSpjxCY9Tkitb7ShVKCgiimy4bzjxUiJr+oomoAdaCNhOa8ocNnsLcXgSJeyflhxca36
         x0rTLFYaiw6augijMlOWnaph9Clpdirpu3dexf/xi9laVdfpLeBG7UnzOR69znv5ocLt
         wK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295957; x=1762900757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDsH9kNNXBt4JKt5mitfCe2Rq8PZuvGot+36QHyMJvw=;
        b=j7V2VUNxYWT6GNqN/Am197hZv2Nr+tXroB5swuSnTsGUgstq8jeAx3rsIjw3v/XvEh
         exJoVLr3U8oLBdzddCGL6o43JeWTBVx9oeaVHR46PmSPGjm7uYhiex1Q/MkjdhjX3V7v
         AM6DMvfN4bD63znRJIrtbHVvvCrrVOiRorXYd8KwMvdf9ISIObAL2qzAi0dZIDDpYg8g
         veg9Z2UQ0x5O0BBIDY0HwZHN9W2O5QqzPiQAZ95LK3EBveO1wSEoJ6p7MhLQlBxMZFQn
         Gst8xnnkIsWV81zWFbyaQnpk2NCs8ZJ+6DEGghmoG7f4mMzasi/B4MtylMs4PCGjbtVY
         oMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfobgQkUYDArDyjRhkqNGOAV6SlJgNDXrtDOGUnfj3wbOFJ7BneDZgK7LKp+4GP6q3NTS5BR8AMCdp8T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThTAJa935K07crREUEosj2p9rSgZ7wxl7ejA3hA/SjElqstzA
	ILZeq3oAzETqqNKdlopEg0pFz8iRDUdDgpp3VY4lGzALbTouTlbRum9f
X-Gm-Gg: ASbGncuBpq4TDYsr/sTXlrJbx0hYOkGsr9IY8j4kAox4OIsbU2FwbwNUbFPFviqjnmT
	Pr3Dbbiz9NZdkQQ8oueZOpdoY+A8Hy8lioZJ479NuJjSbjYxuD8RSUUrEuTiTPIKsnPj/+54YV5
	cmqWcXq+HLR4OpDQjiICHd1DamxmtfDGbnnKcdHv8ylzHzO5VUEjTvXThKnvgweLlJAoRA7qMVf
	JaqmZIjxkPteRXihlPX07IKueFs7rMNenme4oh/fxUCFWsdgyYuRJ3953qqMnVXTOhmsuJsaHIj
	B+GhDhAf4zElA1q38zQ9WMXdp/Yor3vzUQ/b+8Ug2N84i8Xh4011XLHXuXTn2smzy+FjH7jAfvl
	E2Jtnq5TA1cDl3JbOtLdkQVX/LhlFS4DURUC4IdIDWZgsbWnCe9cbM4fFVudlZuG58e6j/1rOdw
	==
X-Google-Smtp-Source: AGHT+IGmcX9KQhrwLWD8vDeS4NjjuNE+rklNtcRnYnJAg/yp6Cd7qau2TSc8kt5ZpkI4HpwFXvMX9w==
X-Received: by 2002:a17:90b:3e4e:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-341a6db60ebmr937766a91.23.1762295956648;
        Tue, 04 Nov 2025 14:39:16 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68e4149sm638270a91.16.2025.11.04.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:16 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:58 -0800
Subject: [PATCH net-next v2 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-8-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4ce93cef32e9..678c19e089a2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -45,6 +45,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -443,7 +445,44 @@ test_vm_loopback() {
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
@@ -517,23 +556,21 @@ handle_build
 
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


