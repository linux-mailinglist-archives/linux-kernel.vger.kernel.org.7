Return-Path: <linux-kernel+bounces-885542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1608EC33458
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0A5428700
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EB348869;
	Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boJMujHm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96678338F38
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295958; cv=none; b=u0fx4ZytZHFOWsDHnYUAP9uxhE8++2zJ62bl4zCltqGXJuaBgo4uoas9USxTvvRSdb/dN7dKG61Z3baf4bJBe5QqdDHCiFSsX07zAlqg4Fhn6gZaLCWF3fHm9znAHc6yUxTIK0RU6+h+8GAEp+3nB3jj/N0wEWZkr1tX8cUfroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295958; c=relaxed/simple;
	bh=ZD+kE7Km9hitPWcu6/+QvjzHaUtwlQLzQuuF071Kneo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIpeNp/bc8sAUiK8UflFZMpHe8AzFbHDBddbrN386n4tpjXdE0OkytCTdCb8Z7XvJl25lIEoJWrLhRNrDNUKDj7TQSYPpTOZM9f8VMH+jLAnKciutHZ+iHiTQ2JHpSzdukaLBgCSMDk6PQ6O+i8vR3Ij0f5j1YP72WPV1/ks76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boJMujHm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-294fb21b160so42881395ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295956; x=1762900756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=boJMujHmu6Bt3LKiTEKgcbvVBfY7HcPy5K9KmLyUNkJUwTk265Cmn7PMMtaPVPgvPT
         LvofcFT5lMfzwyGMvdGbYom+GUft2Z5DycWraiGGqDmDXqcsmeG00ItEEmsi0YygeyUX
         wO9z3lMt/h+5S9P4xdTX7fRrmGLeJq3KSS2UdwC2Q2nVx3PcWMrHE9ujSEF0SeLSrX9H
         CeOx97xEPD5sgQOcqL3l0LT8SdNkf2nXZQihKdQRyTHAV7J8oRF/PIm2pXsGMBGtQgbX
         pIQiE1cuoIOxaIdqLsePaij/BsvjVbNTYLUZKaybC2v2zEiMoFTTUJ1qcyXVq8C+REU8
         jW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295956; x=1762900756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=DEZYh4idbE5HXExi+Qn662SDC5/nUc198EXuUco3QWLyqJ6oJjPON2v2ixOZTKKx5w
         gC8DnK+rybcDm/m0Q8NIWlt0nzHFBahxUPZ+AFveaMeOoRDT6sSjkVZlLEM5TZesJC6r
         IxlEOEQBv+PL+pBuXx+XExRVphXgsVIaO6MTHQOZ+DfxbvgkkWlSlr8g7WmK9Z+iQh+l
         4CwecDD3vtm/hZad6vE66pc2TTfAs87YSjvc6v8VxqIUrdCRNDaXVZNgJkNCJfFzjJVM
         YbS4sZg5RNAkL41mMGYIF4XCEXgjCYKUq7FHcOjiO2yLh2NHCoWdCUTJTXw+3Ylfu5Bd
         ikcw==
X-Forwarded-Encrypted: i=1; AJvYcCW7sdBkAVyj+BZL9pvG3HKYSb2ycliPVrAR10l3b4228JgErOl3xN3/gfyT5k5kWi3FU66EC7YOmTPwiyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPGrtKVrBOhJlfp/g3fUPnOXdzykeUV231/0fBGcf0OIAJrfz
	XGoZTbOFO4rkmmuxkMkzSQkQlw4pNA1j6+zsmXnE5wBnEFzY2yi5Q3rZ
X-Gm-Gg: ASbGncsJKDNLEP7i3r/BX337ro9MRIIlO47WkHFqGGKNm4xKFZ2KAh/07D5Hy+t8s3n
	/sNNO6hhABLElUCTAq2MP+lFEYYRL0RxZSVsAeI9lkthxJBVbhkmUAgPNfc6cZ204X7tb5DUfhM
	230dcyFkKTq7qsLImD2jZcGzIOKbfkfrrlIeGqCe3Pj2dCO1x3V1uLFR2xq9ueVYmW57wflu5XW
	n7lWFz0Mn7LbbXM/0MVkasmK46xPwO6Vxxr0Aglp+IMjDCfCcq5BKtHCFo2d34THW6uSf51zqOj
	eKJB7MvRvAKM+s3doHk4HHERn2x9FcRkNYsgEi0RMYacil0t6ahvxz2r5keVqs6HZsT7Soxceaa
	b8yi/ABCiGwhVWjbbftRh2QkAplWyZTVtMZrz/AYIqgjZo3py3W5Aq9mSWxNnGPUOngJneBo+yQ
	==
X-Google-Smtp-Source: AGHT+IGE2AJdLQ3ih5rbl3nytu4JYVPoufSf2/AeWyCovMJpVIx4Pfkn2JQACMKcx394CGEglGnVnw==
X-Received: by 2002:a17:903:2447:b0:295:b490:94bb with SMTP id d9443c01a7336-2962ae75808mr13019465ad.50.1762295955674;
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998893sm39091575ad.40.2025.11.04.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:57 -0800
Subject: [PATCH net-next v2 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 940e1260de28..4ce93cef32e9 100755
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
@@ -510,17 +530,7 @@ cnt_total=0
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


