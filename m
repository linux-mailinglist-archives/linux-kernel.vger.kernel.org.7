Return-Path: <linux-kernel+bounces-866054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF7BFECAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3919D4EADBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26CF271446;
	Thu, 23 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG58bxwn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C19882B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181236; cv=none; b=b2Ltxpak6knoszkkw/yXhlDbLkbYwMbAMRfD5b4XZCQZai0w9qRrC6VPiYkX8nkSFqsPoVMTgiYtS3vSE0O3DKKPfuJVPN/4eUgBDJ01so7Iw8U+HYEE6GdMYq3z3506MmpuZjqYe+uLrSZMwka4OO2tDx/CqlFv1ssAtq5lSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181236; c=relaxed/simple;
	bh=ldMhDtJSqTF6HhjHdYlIqeC6EPSyMpf4Tz0FTZQLeGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLJiDJ7W6TtTKVwqJESl+5i5q1G1zOgJE2JnE+GIfGJWH931yX+HKSUsDKU9UbFmSRfVVI/iDjvq1qQlPS2O4de6UHjLaDgUK/McHaEHGWwQ3qALyv5aQ726anZesmn2HJ++mkvYgqJGEAro+hXa4DXyZshbYPkrmzGxCjOsJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG58bxwn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so282038b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181233; x=1761786033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHfkVNY88Sc0q4SntuKgstPkJPF0CfHaltJaUqfEVbY=;
        b=iG58bxwnX7C7JqE/CWdLFV3SbWnqyj8cGBp6FVFwyVkxd1jxRh+kdAVmAILWTEVEU2
         rLQwYY6sYmDHCPDoMXEQHeNepJ84oY2gtXJ8GVGtDR1QF1siAE06njR8pkzxwPLQrAIh
         ree/ZXUkR/U9HtzKtKp2KCfRCKZrfgS+4Axz5S501yITlFWngUKHbdgBGLJif7+gzsUY
         YL7HQ2I9QYUpfNzrqW/hAhCmvycrzD2G/vYc5M6hZwMqkpUjAS1PEdvrCN7hkm3CGIAG
         KTo4GvpZmxPzPmPfQ4Y3iM6eXAYob/PkMhhnJZQJzHzaGw5lskvCDbJ9v7MgwDNvjnDQ
         bsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181233; x=1761786033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHfkVNY88Sc0q4SntuKgstPkJPF0CfHaltJaUqfEVbY=;
        b=Zr2OakT/LiAhd8w4qj5S3L5aH45EcqsSIvLxn5yKrkFbLFXi8nOf4Wa3/cJgudNTL+
         rPpNkKqwleDxLBqIkZ0noonmZr+n+wvj89hoJhVUrbSUTTD2/kigSDJ3YwZYCnG5EzKE
         KPgS2GmJYQ/WQqX08EzvyHa7Bm3katDl5ExRTwtCGhthkePVEOpu543yiMpS2ic3IEr+
         WZhZGsztU5xay0XqDApJpnILaD7stZqQq7O3iOGFaxSvjLc4ENfUIbNCGtsPlrkJ9O86
         ku45JMkxGzhRaQltDnxvsLuftCBMxuFMSA+iXo5qJEALD62bVmUVExivioaBmhsi7xa7
         cpDw==
X-Forwarded-Encrypted: i=1; AJvYcCWcyxg+uUYLfR//uCncr2mxIirGKkB3zyvoGiu3cP9DC7RfD5mZyUb8xWuDwTwztPpxI9cbqtJD043h/5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Gi1P48BUUF3J24c1VblsHANEKS1JeBne5peRc+9aZplI+ohI
	6ZNeqQyarM8lTGdingIP/kaqipJYDv97BL4XEYA4uvyi1KFRhnzgvixC
X-Gm-Gg: ASbGncsvzxvXLfK9i3zeG+D4LywsrspOsvbY5QoRGvE8hfbuhP0Wkqg6aEO5roIraxN
	AOfS7H/zzFb4QSCxxsdEDAO/a48XlGHXJ0MZmSvxv68w6jOPzaf1bgTBA2vEvrhEy2TkT3ql4s2
	X0v027UcocbeUmcXZBILrkZRTWbZGL7xnf7ryIvLIUqLTBd9M5ZztxVceI8FHqg5DPZq4po2rF6
	HGqk4tVISO0w6Jh5OLQY4mmkfvytVktGVcnjQjNCqxucH7Rs0cDFqwlyYtKUcdI2AvKEbU/wLgw
	ifTjZ6SuezS0fm3LRv7t8c50WIEhs8iT0BaIyYqotRnDG97YpAxnYqYO0InMuiql/nqRio/mPl8
	6BFNtoqBgzZr/FAxygiqhvy1aK1x2Y9W26n4pyzdEXN+OJQl/n7pgsRAHnHJFv/AfmRHyrqbX
X-Google-Smtp-Source: AGHT+IEmheK4A1ko5QFpEBWLeWSltnMrHAw98m3F5BI5tqmt9PtwcLSEEh61GZCfGXRvh2RHxgaMVg==
X-Received: by 2002:a05:6a20:1611:b0:334:a820:be1b with SMTP id adf61e73a8af0-334a8565b08mr28701692637.17.1761181232651;
        Wed, 22 Oct 2025 18:00:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c0e4e6sm362698a12.11.2025.10.22.18.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:12 -0700
Subject: [PATCH net-next 08/12] selftests/vsock: identify and execute tests
 that can re-use VM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-8-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
index 0957d6a41d08..a728958c58ee 100755
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
@@ -528,23 +567,21 @@ handle_build
 
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


