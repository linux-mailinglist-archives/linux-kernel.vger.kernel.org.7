Return-Path: <linux-kernel+bounces-889606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568AC3E08F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2256E3B2798
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA22F6565;
	Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfKs7eKs"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D12EB86C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476599; cv=none; b=bYrXxuawaDVD4sH8kLlxlNuyU2RErge4YWuY2FdHqnSj5XcB9eAwqZCAjZ3ZYimfzVPc7gkOHzV2BVt27M0awU0uaezG/mj7dx/A6TlBQbQl7m7lQXzEuYLPe4anAAXSWDEPszdGk9KGsyxIRwOkP9Wyi7o0S44buYMRz6GTbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476599; c=relaxed/simple;
	bh=4uCVZgM6UeuQx0XSrGdd9WXjIqluMM3jZUftpCJANAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lr6hLRezOUKMoE8Bp5i5n+25nP8xfpdmBx6pSd0NgCZTX2uXPwu36xRtimcxO+Vq46pNPi/qJmfdI9t7KMuPOzP3cT2snFap0uRAK4alwLnJ5xOmvCHlZ0KZs4AxKgSP6KlnieLLrLBg4IYhvT+AjXkfPwqwAw1sBBa2/3vS8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfKs7eKs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b9a6ff216faso172207a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476596; x=1763081396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=jfKs7eKsSRQ+QZYNuOQ3Ewg2uyfpFtWMekNrVmc0lq3cCBiBYHuN8FLOxErNTJQUFK
         Lux8ahAkQVcgK1ZWE6lmgd14rtmEK9WYJIb3UFqjuUV1w+r74RDFtXylyxtR6VgLfKPS
         mTpVXoc41XQwL5RSXmLcSXubHwyylHakv/aHC1hDQ/764NNF1318Jc0nl3YlP9sZuUyE
         tcCdoqd1dJq8ORpBxZnBX82Kxj78WQavRgk6Zbj82tOXfZOMMczMAMLBOyEg04Aq4ooh
         mDFFVwqrzse2OkRqQIyvmR5Vap7rONja74UgKCoVUAfAs4QAvlvsw0mv3IhKjEYXZSgD
         Jacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476596; x=1763081396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=KNKi9pUpIYqqDqJEY87xZz5hAlNTdwgmJwZQNv1pzqcchTswYOLleLucNIa/ZZX4Dt
         Xs85vqcjZQw6uCrSvY5cxX3ikJ+sxSDdeCRD+6mLcO3pmWmAEP9ZTzuTejFtcR8TR6v8
         82CaBnrp0jzR4x/giYTGzFsHPqNcteBfqBoXAWlA442qgmgMmy9SW3c/iLO1Mtg+s+x7
         yCTlQ/vxyIYuU4xT0hBjmcMIlkYJPyaLDAQoO6Tr+Wr28iYZsobGAe/xIvZlUpdgF/YD
         1eHWrOOscoglIoeNpZDe0LpUuG54cDjguPYYEARiwgRkHjXsrfdfmw6t1tR+jbWgNV7M
         xPlw==
X-Forwarded-Encrypted: i=1; AJvYcCVdz3s1w1Vsqgw004LCcOJBCLorOUGzdlKxkMFNLv+yhAGRxIVkF6gcXsxKe1XK655EIZJwjbT6gYs7Rjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlof6I8Y+OhoGO4VUkED2hSB7faV30vV9kblN6iDBvGi+ukam
	rlczrgey/upWHrHMZVCUNcZ7mWhKtRfaPv5SIl58uNDJznXFMNsBiBvY
X-Gm-Gg: ASbGncsgxRS56l7VYxXaIujcJlJK1SJtx4FSd16CyZRkDjkz9XaELHCwcyIrKuCyIsM
	EreiypCxRuW4Tt54xlpQikWok6YkEyZHfPIe2nRpmqe/+I2nU9Uhp2miH674xgb33c2n0//mRxe
	T0izPwpGrJbwSxatUqHAaUnybX9rYeVxx7ecyj7w2REgCVPexV7QNS8QaodhWqK6FElF8zEsx0U
	LcrRX8Se7Oh5ookohYhl4FRIgJ6oubx9ga63WGjRn/04ZSQgQuMxkRBKKESqEHKecur0Fz//LJK
	73vq2hf6R/VR9DkizFbUnpFFUTiQY/wVhm0y+GBM7GOQ6vmG9HsABebp+w6nX0ana9N/27DEXHx
	CWgSKW6AbNMNesoJ73SbMgRkF4wncQygKNuUCpPdPrqrap3hkm4IMj8oqbMuDzyPYQITDqbFnEA
	==
X-Google-Smtp-Source: AGHT+IGDT33BspNwLZAZGr8rW1mWSoTCi6gvaV3hnBfSUxt42Bs8QnGChK2Hk2M/l58MMqK2S4GupA==
X-Received: by 2002:a17:903:1a86:b0:277:3488:787e with SMTP id d9443c01a7336-297c0389ec8mr16267605ad.12.1762476596231;
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm40974195ad.11.2025.11.06.16.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:49 -0800
Subject: [PATCH net-next v3 05/11] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-5-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a461ef1fcc61..ede74add070a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -246,10 +246,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


