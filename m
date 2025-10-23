Return-Path: <linux-kernel+bounces-866053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D9BFECB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95BB3A96E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F6269811;
	Thu, 23 Oct 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El1/f/6/"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37A1F4262
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181234; cv=none; b=Cl2ME3xUPdfeCO16bL3zdf8H1drSGoKmkx3++ftrrnajo88Xm9aT9o5ga/SMwMEMWUmJy6K/iCc97aNSuDWHXqd7hVTzYQutGLWIYyzAjUngKAn2C/yXwcfIIKm5LspCH1VVCSDc4Amsw++n53wf/aylPuKI3UbI4diGd1Xdq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181234; c=relaxed/simple;
	bh=2VNGM+ga5+4lCYxn8srmIsIAGhhW4pu5Ux2Lzg8IB3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRTNoeBo/wP2fUHuAcRs/MN4GnmEDIgpTfvg2QLcGjqTQYTJ9AqXNwIwBP6M9E5G81NT4BJMT+xPGNVyiJNVQRIAg1B7CN7tmkPB+Kzmcv8QWYA8LZ1CXzMHEy5HBS+fcvtRgMKBWUcW/67T94l6k3qdlk2r5tmivkTih6vIak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El1/f/6/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so236894a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181231; x=1761786031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj6nuzkY1lA64LuLbEa1jW/rmfdvccJ8fRwNCahhULY=;
        b=El1/f/6/OI3b5aTOLrzoZ4iyO1kqu94o5MvF253BFVSKNjd5v5NWlktZcORp5ZsQv2
         XrTgGSE+WXiRbi4fGGlhG+j7W7Mn7EXn9oGg1WVsn/pd9OmycV3AGOrWZbhjT7ewamRd
         Wziek7GAGgQu488ac+3J/c1ruAfUDjPTOT6F8pmKGssir1yx7TG3NxAZpn+TRFajasR8
         HyIqbVbRIQ5Fj2nlL7KcL3K55fOwUykkki78gwMF70tFqPEi2tsr34G08kIKrId9pfcg
         fIIjM80w8I7POvnPxee82O20tUk759gGHOvDJ9zCeFb4viA031FqQUrfvzgr91AFaaOF
         SaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181231; x=1761786031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj6nuzkY1lA64LuLbEa1jW/rmfdvccJ8fRwNCahhULY=;
        b=u6OnMNOFazRE8mm4ylugqUt8gsRuZuS47kHbnwSQjZ1IsTfy2WR1dELvcbjBSDzz0W
         vcyP5aOJcco7/ij6w1qNMGVoQ0uU4qHaUx0Q8q4spT+tjaMrUFLqR9CYsjLonwiCwDle
         aqlMyhxTFrAqZfdUY/5M27NEYhWRmXnY59dl8YjvTHGTA/IzKxqTqTfh6dVnDD2y8L1N
         FMvyFkZsMYQhbVQWNj/VixKsqpbeXiT12hzyFqD7HkhPkdvwRRKFb2U+JNXovhi30RHg
         V4EkR/4YslnGB4lK+3TPk8akSeoyo3bTlqkoYx70JshHZO9d4HIIpRZnnCMHTHk0m761
         a/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVUa9LB4eTQHWC4kO4Y1p4ZmRI5skR840g+64WgfhE9DeicUFbxUO+HHvGya3Zyv/zeUWpu6PCFZg3X3yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOfL1ZR2yUiD5gDavQgK5CiCc9WnrSjRuvUMuSGEsa/uqHIj1
	R3aqS/O284kgV2FqcrclEW1MCiR4p1eLPqFORtmZ0F8apvTojV2SLgAE
X-Gm-Gg: ASbGncuQ042tEoxEuGBDCOHM9bZhuAMQ/pLW51kTuzbbXe4NAj8uJ6mRAILMZBe8gbl
	/+aSEsmBfXlgACsOCTwNRziyZTsLjhrJtuzXDXGAh7PzipiTdVtjT5yDTP7QussBd+dzreVyWk3
	0UHzs5id7PFuVxx/OcguAf1QGeQ53Ss7nEQylGzKTCGzL0qy6QrCi477qPjv6D6OUHtknUcE/VN
	BSU6aIoLCRN69n6rjhjjMRAGj+a9Q+tgwEv36zd7lrLdRoxeea9GQzCv7o3YHd18wF1BuxVkhTX
	8/CM8cBxrt6tdI8N+HQt6s9vyuqNVwCFQzvamZ3lRXt3VFK3i06c5N2FbYc0aVtHUztWrxtPlO/
	5lQtE3hM3Omz9A9S8dueIIL1FRMvtessm/gDG2cjTSsNiqYlkNySK2l+FhVY7xJZAPHGqFBu4h6
	TMn2Gvg/9C
X-Google-Smtp-Source: AGHT+IGKtTFJtpQ24tkehAeG1F60BvFty13fIYOS2AypXorCFytbWHehPyoCNC+kjaMOPOaFRHtOew==
X-Received: by 2002:a17:90b:2d8f:b0:335:2eee:19dc with SMTP id 98e67ed59e1d1-33bcf8f94b6mr28354305a91.28.1761181231262;
        Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8adc8sm552212b3a.39.2025.10.22.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:11 -0700
Subject: [PATCH net-next 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-7-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 99db2e415253..0957d6a41d08 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -521,17 +541,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3


