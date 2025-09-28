Return-Path: <linux-kernel+bounces-835227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BEEBA6887
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CA53C0207
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E765A284686;
	Sun, 28 Sep 2025 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk2qMTB+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772A2165EA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759038565; cv=none; b=MqMENiJIoBJdP48+Za4g18Hwf444PZklCUPguhdsx5UniHekvxr5Nur2YZXxL203RZAZhFBLXVEbnUTa8UQjSycFD9qqg+SXVNPg1MH/iz1iTh9+bNnCPYmjMrHol7z5YRXv+0S6vAzC84z+9hD5ngGlmxXYYTMdCiYxCI1NKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759038565; c=relaxed/simple;
	bh=a/N2HR70ceRBjv9O7z2CSrR/MI4SKQkSKPBJBKKCRiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MB9QoGD1xlv0xUTsB6VbWB6Q2rO7OEU7KRb8HRnaS2mO2MT1RRoMZIPHNNW6bJWFF9AXlGPsDM7xCGjQJCzBMbEjw44JDNs8/Hf7jMzi8aQ1ZMUWBrQhtidYENAtsKE2uzUw9X6BvL6KR0StUwknBmdIRiprQX+4joLZAb29yAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk2qMTB+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781997d195aso512956b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759038563; x=1759643363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXOGNZuoaGhzLXmLiFIZJZsbC3gonJn28kPPxMXiXWg=;
        b=bk2qMTB+Sub3whMkbv/tswaxY6VeqjAuFuRoL1Le9C2W8/Z/qpBSh+jQWzAAnHMn/k
         qBLacxy1NYl4cm9YUhEts59ayovdnIUlMb94JxUwDtUCrl9GPrNxywauHUTMcR5Vj75j
         nR+mqjWWm+KLQd1keC2CZrbTTEi1BwTIodo8WBmEeseysTrfvTmwCOYAwA0knP9AIKXe
         qtWHUvh9/1JC/IRd4ThPOo+QuAAmAHfBQZPe1PZY1zK6U/oCiOYRM3U+6yTg4bCIe6/4
         wBa7p+0FFpkp+MQbITrjgtDBsrODfX/fRme+apJyV23OJ82BRPubKB+9cI/XjPz1GiTD
         RNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759038563; x=1759643363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXOGNZuoaGhzLXmLiFIZJZsbC3gonJn28kPPxMXiXWg=;
        b=vpKS3uaTd7q/TMsFKPodb4sGKqSCpfO8xSJAFgpGpmpUmns9sL4ky7Nnb4O+V8/rUY
         z/2G51apppPZhPsApt3o4SbptYUUiNdhAQOxkBFvWBgpNTvsbxjHjQ/vGqVsMhh47z/p
         LE0hbFuvkrfIai7wF/JpQpIPcrKBPNyIiuRS8hm3cg3hi4jwFbIq8VcT5mCLxaLMv9w3
         BsGHpXCIcMOthb5dO4SdTzcSj01QEFHA4cREPP/3Kgndq/v0hgvIRXqT7jolDwM3Xr3r
         uWa0sUrgT99U8I71nxE2iT49mvNNFrMqVMyKg0WqZfHjNFRtSCX+KP67oyS3lakw7Rw8
         IuXA==
X-Forwarded-Encrypted: i=1; AJvYcCVWzoBrgMih410Q3vuOyDpEIUFoxocinvBvVJDA/QGrUVX4y933RK/wxH2QOe8fp1u7U1A4D9+N2iKYOPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9wZnAjDbuWiMki/ad6A1TZvonsuJTeELYFu1eEeokbboB9cm
	XU4WKqqyX5stqKa+L2S++3rVhGl8G7rISvnmU8uSiJGBj2ExkJxRgWVX
X-Gm-Gg: ASbGncuI4HM6tA0WA0FMUBmP95GHGEk4aGEcfE2tQedKMOiNKIICWYG2b0zsEHf0ZEH
	5JrCWCMvOlrZEx1NdDv/AYkbQvYH9QLL+KHqGwV7Bte0w05lQyc/D59N6ipoBeoRCxh5c7mc9NJ
	VwvkJQcxXp5h1bJt80fjZP9gXkKS4QY8+8zISwSOZ3NEmhOAq0Nt3pOggbmw1V2qvtQoaaV4aWN
	C7tFBVQvuGEa84k0cbjaSBsrjb0eI71m2k7Yih1Voy+HkVJAg6o9/xAvkvMIlzbxmlqqW1kDkBx
	no0fu8539PweP9LCkS6pjMJZjHC2IVZfmsOLN/beBwVuQ9KuljZ1ClyqDmmYUsB9RdZv2d1l455
	+x/lpHIXL/uhf3jnDRtmqi3ETwfE3zkjHFtlH79MoGC1iMXcL6+5PIZkX50uz+q2bX73oRbUGcv
	Ldag1URQeCvFKbMyZhxLVse5hzAeK/q+QfcGWxx339uEA=
X-Google-Smtp-Source: AGHT+IFtQXL2iF1TYStc0x11Pxv5A9nIPIcXq/lUvS/9/Y8J3YJJroPgqc5YItbGABj9VEdV2EtRfQ==
X-Received: by 2002:a17:903:19e7:b0:25c:4b44:1f30 with SMTP id d9443c01a7336-27ed4ab097dmr147299675ad.45.1759038563086;
        Sat, 27 Sep 2025 22:49:23 -0700 (PDT)
Received: from opensource206.. ([106.222.233.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6700ccdsm94559015ad.37.2025.09.27.22.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 22:49:22 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] drm/vmwgfx: Replace schedule() with schedule_hrtimeout() in fallback wait
Date: Sun, 28 Sep 2025 11:19:13 +0530
Message-ID: <20250928054913.7871-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded polling with schedule() in vmw_fallback_wait()
by schedule_hrtimeout(). The old code wakes up at jiffy granularity and
leads to unnecessary CPU wakeups during fence waits.

schedule_hrtimeout() provides high-resolution sleep with finer control,
reducing CPU utilization without affecting fence correctness. For the
non-interruptible case, use schedule_timeout_uninterruptible().

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
index 05773eb394d3..64045b0efafc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
@@ -202,16 +202,12 @@ int vmw_fallback_wait(struct vmw_private *dev_priv,
 		if (lazy)
 			schedule_timeout(1);
 		else if ((++count & 0x0F) == 0) {
-			/**
-			 * FIXME: Use schedule_hr_timeout here for
-			 * newer kernels and lower CPU utilization.
-			 */
-
-			__set_current_state(TASK_RUNNING);
-			schedule();
-			__set_current_state((interruptible) ?
-					    TASK_INTERRUPTIBLE :
-					    TASK_UNINTERRUPTIBLE);
+			ktime_t delta = ktime_set(0, NSEC_PER_MSEC);
+
+			if (interruptible)
+				schedule_hrtimeout(&delta, HRTIMER_MODE_REL);
+			else
+				schedule_timeout_uninterruptible(delta);
 		}
 		if (interruptible && signal_pending(current)) {
 			ret = -ERESTARTSYS;
-- 
2.43.0


