Return-Path: <linux-kernel+bounces-891571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB1C42F7A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1153B67CF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B5263F38;
	Sat,  8 Nov 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzlaOoEF"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24B244691
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617721; cv=none; b=BhwYePsv5gc1ltYNwVDdzewVM7sFy0LsFcUAW5dr/OVWwbovJ/Gz2H3eJ9LBklILV8LUVWkocpmiqGR+JK238SowVbjRNGJmCpPwaT3nE+Qc+y2ngvVAfWU6UJ+YN9lA5/lgsrktJp9uhuRZffmeAL8ej39uQrTUnXmwXCwgyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617721; c=relaxed/simple;
	bh=F9FsVtLt7rSsC+SslDdvx9EYIxO2ErB70trA08f7qAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr8Arw5/DZdgDG9mcrcfmO92zT61Dg4bqCejDeLqZn0c6vS1RPD2hGIJaaZ0bBf6ijAqxLMR0lKdMdWG9asTmunrLOrJPXFyIJK+QO4d8GoMEBOZnCz4eztdombV3MQRVbPocIfAaRvX1zwJQiRHsQ3+iPKdHVxZK/ca2LLVXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzlaOoEF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b98983bae80so984773a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=EzlaOoEFGnQtWtAUK6QRETa5cr68VJ9uGYfHind4UB0drUaox0wHjkivoFsFuJenFp
         9AICGVsBtIUsaRZn9cOd9l8Anaa89KxldxiYzWAaeSgnzFTwSJiM7zY5TpLGnxwSSWdn
         m5dwQgysbz2CiywgJ9frT99wavGveNEp/y3ZqqXj9gWrS944EZrDz5FaendwuDI6xtii
         tQHk7NP9wIoBchac261RXLICQjcRAmJfSxO25HIpUxR9ZUT+e6SQSqDXKC83HdMljk21
         6gqIBElBgphRHF1xug/9LOMPNIcvqJ1cVZM9NShpvs9y4zhmP1Ni5H6uX2Ixx4MlhxlG
         0tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=VfZJ/mGDbJBETwiZH4sN35YXigNcQC8zYVEyeb1tdgYAmcF3BxGylf22+OkxEf9hD/
         ZO2gc9sGPIMajOBjh/A47RmTt5LnOXebNT3djCPlIvBE+nX8HxfBiOM/2JuMbFF4zbRy
         v29qXCgtYdriZU+VAOLM2DWk1c9FXYCSJ/UoZ7TqG/ZFiya4hFzf03oNGbk5vUB/ypcY
         bZgjCdXYUkscByYcqosjQK2JmxqcAkykhwDLANJnRRUihRcCiikJJodnqdHUYlKmJf6D
         5zXzX2OFuRz4gkBhBM3AgLYnCoj7mDTrm7GKZFHt07hhsSLQ6UaNv8OG7Otkr8QMCnwk
         Lt/A==
X-Forwarded-Encrypted: i=1; AJvYcCVOpvMla/XSbm8nx4nDk/9hF2wAAPNbuNFTP47aqvG/ixfDDhgbyCm4V9ivIjCUuozqvxskXGX0MGvdfcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJM0CLUmJ7HE8so0ydXhdBxa3H56U+l5Ymy7kxQBvaXEvxiDji
	58oC35u84p4cCVeiq5wTjhCapXSXp4nLVWKzIXxM24sCiP2YnrkGgS9E
X-Gm-Gg: ASbGnct9HkEVQsFpw+fM54pvHWqZMFI7+9iNxk9eMyAutaNXBjXzcJc1f5jAKrX5Dp/
	8PrGanPMt8MTJS742msXa/B6ZsKfv5hV8BLd9Fy7fJEu64U2iHrsGVDdznaZdfrHnLbC/V0p5i8
	BzGMzVR9gm+H02JaPk6hh5zq3jvQagBt0j3+BOm1UFV2NjyJVfqJwOoSqHjTcidHxeiEFsX45NW
	CRK9erwymsS2yp2u+4Jn0aFG43F1dKfSWxP/BYOipLzC7mh56Cdyc+mn7AQgHvJ36s1cJAeJXFp
	xGh7zXoIEbb82MJj2v9QyckbAXmv6hDxj79mDJnLDahH2SyiXfZ0ScmGwKDakj4VGAb5Ezwt8zc
	/re1SEs1Ty1WSW1+VXvg/6usAWSVZQIq3+gNGstk/xzrrLbQP133pQsRfXXxgCa2D+3x/39vPer
	0q1Cofbi4=
X-Google-Smtp-Source: AGHT+IHomY4YyVD8KS6qtG7MNKX+4x/II1DuyBNIdKkYHuI5hzRRInd+7+JdQ5vyk3YIsOnkaHnafw==
X-Received: by 2002:a17:902:ebc1:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-297e5663a67mr35112645ad.27.1762617718558;
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm93090585ad.92.2025.11.08.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:59 -0800
Subject: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 2dd9bbb8c4a9..a1c2969c44b6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -461,7 +463,44 @@ test_vm_loopback() {
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
+		check_result "$?" "${arg}"
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -537,23 +576,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(create_pidfile)"
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
-	check_result "${rc}" "${arg}"
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile="$(create_pidfile)"
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


