Return-Path: <linux-kernel+bounces-889610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55069C3E0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E280188BCE3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77399301037;
	Fri,  7 Nov 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i51rLpjR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37F2F7ADA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476603; cv=none; b=V1/YsouOC6fKhgfev3gbrBl+8N+GSk2YvopHaas/pPeUkpM39HEpOpP/lEnkSPnL94MQgmpyB0Al0JkerGKWr0rliUuhZIfFAtZ0IAnigr/qbRQaDWwDTVrC1+C3rIMWT2xleQK0/uJrQdFQGfTStFiVpA1DqJiMV80k8k4PYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476603; c=relaxed/simple;
	bh=3X7FcSuFEkDk3JDUhogHRIfC2C0s4TSTiHdkuzapQSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRLufmgKzngkumtdf/1CJ+Je1XqeC+6QTV/4+EBW5VDIhaKjkBl41qJIYcjpFwbfuyoc1ZfmW6WHFBHAplSk8rpCd8MGO6cZI7KHxP956KrHFN09fbhVpzGmHiZLVS2K9wlJZsk+SrdywtDUdsc6TsD8Ldea3Utc7VwPOl1GPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i51rLpjR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953ad5517dso2045485ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476601; x=1763081401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=i51rLpjRl+DgspFfmCBoDYbYLiR68qY1vwHrcSPjsf8dYDREDmmBaHfN9hAUik6foc
         Gt1efzeGb1H9sjKH6Z3NoUff+iaG+/rKoo97q2/dZVphMKL0CIwImBkzDfdK6QbDIuIj
         7xa8dgx9H8zxnUPrYGTw4E3pbFKDbB081c5I1XYF7Y0+NJYk9jCWjN3vSCWnSv2x9YCx
         Bp/h79fRZRjpMrfrGsHytvUQIocM+XeAouur1gJZ2cdr/k1DWAkPtgFm61Vcpfb6/IfJ
         PkgLEPUq/LH2AeFLDb7V0mOYZAHUVTJmI9NM73XRDZdurqlBwHjGXtRDle8T8HkRzIlY
         lo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476601; x=1763081401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=X+l8hWuAI1NbJdc4HI4PmmQCNbl7sAmCxAIqXe7SSVt/j5Xo5n/nsceuEDg92Enced
         OAqgIntYF9GYlYp2laEF14D4M2G/fZwceyT0BFusp1OBHf4cX9D+3iwv1OixrykuMgfg
         Y4H/GnO5lLJvR6hwlQtasryQ54odJcEZxiks8VNldlt66k5/TQuaCBuCMu3JCbyOkJru
         TiwZ4zaKwZ4jxlMrEg0RwE5Or+gWxHrQDGWfI2ya4zVk+4KxQSYHus8nU31eZZUb/eJx
         EboEDe/YIBo4jt7s/b3IoSU9pQElJas0y88JVB3Ik9CG4BbRsdCwYLs/lOufz7qhKDjG
         rkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqKHH0seBXDtF/mr9HrKX01KJYUUEcvTROCiF3xFuRI1+LF9DU0KL/obO7XqIl1g2qls1AUL24we+NuHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyGVa89pJ3QcSWP028OHdpgJ214wfk/qqIP6nZi3S5p9ApiMg
	RtJhU1VHy4yhEeWXwWep9SPENUtLgDOErUEzQzeOdcRTcBFrw3bilA/5boOmYQ==
X-Gm-Gg: ASbGncuWMEyQq3gkk+fZeYA7uwCHotnshXNDF6NhMC3Vzqc6jE1qDaEIvJ4VfBLJq6U
	FSG7ZQ463vpphRfd/CnTnf5D1RQn+pPdVBWSRtGW8CGyT8jOl2rFBDV69OohhukyY+0MjMUOkbu
	E0T39nVz8/inl26xrkHmX1NQ1HQPKzONWzRM7tPRM9MbJpcSM8S5IH0m7/nJhvl6QVpI5LNtfiq
	cy3CnXO79vwT8WTg9VKTPyVcD+V1m+17gxdAIOSePPMnuEO9UmxNCRpbzAwJBB1hgLDG31udhJz
	tQEqABWZ/UCX8X2ew6tc0co0xZFBDlPDZMVV2yssYjt2z76aiNg/cIV+LxmW2aTIjxPg9mY1/wW
	I59flT/EIDtNweciVKEgBFpU0rF0zn/qKx0YyCZ5OwjcypCmIncyTrKhDnAoGngdGHWkFsKpEaw
	==
X-Google-Smtp-Source: AGHT+IGJA+8g6wRjaGXZk+uvhQ1e9D6dzx/VUNrIZDpEGW28OcBzHMx9m6/c+9slJaL7jTXyZDCNaQ==
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id d9443c01a7336-297c040a72bmr17286965ad.25.1762476600328;
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm40775685ad.64.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:53 -0800
Subject: [PATCH net-next v3 09/11] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-9-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 7962bc40d055..a5c33b475a39 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -170,7 +170,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


