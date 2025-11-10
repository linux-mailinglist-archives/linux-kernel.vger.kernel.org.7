Return-Path: <linux-kernel+bounces-894276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF4EC49A62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DB7D4EF647
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE82FF172;
	Mon, 10 Nov 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbKCWtu2"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A402FFFAA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814709; cv=none; b=Fx+lKd51MRbicjoO+ryLqOX8C3nUJ1GLuJWY8l6qcG1Udgm14CGSehAKyBQpMsGHd3U1jyNaUIlKrjNx4b89D3JXu5YmLqkB+j95UEZoo23Jo+SPQnfasn4HAKj3Ly1kpFSofXdI3ehf7gycf8D3U0B4RyLNJdGQrzOHjLS0O94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814709; c=relaxed/simple;
	bh=eZK1Xu5JN6AdAWHjt3I1wr/kVoRDt4g+7NE3jr7YXSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWb6IC5hzsM0nEiTH1NIntaei0EEgPrlBYKTT1uuV7MKF5D+HuiCbT1ntuf0QacLD5Cu8dpWp3yJ/4QSYUcvLKskWBBcg88oRM+Z2P2ZXea5FHsCSPGNqMcdcF0q4YBFBQS+ZnpkDtxm+R1MxeNNTWyWFb3a4PuwdRSTrhblc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbKCWtu2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592ff1d80feso3851183e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762814706; x=1763419506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIwuzdhiAZkzZPVTm8j4iWbSbDi2mAi24VI6Sy2PShw=;
        b=DbKCWtu21uHIt/jiovQ31aHLu0SOwV31koM9fBw+ftLb7g4wjpLae+np8HVleXkuHs
         kTPEWgs0nbGtNRq1Tm1L7vsaB9P4qsSo42hXjWqlGz3SK+/sqKVSkvGbDwx71bUQuJsq
         cWeF6gozpWL6vrDzCT3/GjmST5MXQDzA66U7rrjq712lJamyAojNvfayOSQi/0+PEs3N
         ie2InvcVsJMidDu8DVsg2Zr6AUoymcJ1i1FwzhDJmStakR6gUeMiC+g9IIsrcCSjvHiM
         gIqcnVHD7AMMjb8RcXg5ZHehHntVrLdnZtKKR5FjAHryxAN9dkD9JW9LR078mChUeCje
         M7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814706; x=1763419506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIwuzdhiAZkzZPVTm8j4iWbSbDi2mAi24VI6Sy2PShw=;
        b=b5lGJVsqDv53qUdIDLJ1ZQloW2Nw3+BHTCSLkUlXaU3phG8XXIDgneZxQ0FdOWRNNG
         V453MZQZQdG+d0eSpJCYR/8F1oGj5hJVAj8feG4YzpO8MHx0J5se9JVSC1g7wsQYd22d
         fmNr4i1bBBpDADUH91ciEjTm7RCHDg7/YsLPpvDbN1UZ2rBNjl6Q/v2bbv4RexmnRVjN
         X5YzjiSFluOuhk6bZqLJgbWj41BuH29mXkjiiZXo0a5kaXzSDWE9Jo5MsKPikyWtV65l
         AHz/E6xiAbluH6zUO0T+Jz0ps84LMmUE4UygF/D5KyCcRoNqFqkKpcVLu8doFIOvJvoB
         5s9g==
X-Forwarded-Encrypted: i=1; AJvYcCUjib/l94ylNVXOnxOyrW/S54UiCvBOd3e5cR/+wMC9uaqsywiajqntPqb3hCzfVlh0uRNrMV2132vLtwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjC1yRI1NK92rSAu6gjwv3y/mJEHPJ1De1JtMipHO2UkmY0QbP
	Qi0jWKDr3xX8y6QbnrHumUJS/IS9gUxOMbAfdqs9Mkus7I3MKV64KPhv
X-Gm-Gg: ASbGncscWph0rvIN/JTpAd5mBDqTAMs2blknFQrPsipcUZc7IY4QwvRGYb/OcTzWJGA
	JYhUNCyvzCBHpSh2omFp0uTmWCUQEY08zsX6Utn9zt2ltGxjWmwocLyy6DPf7hOhIwycF5qvzQQ
	RcHXk29a9wkPD9pw5H8TNGqXARPWYecSCNgK6fjG9ZmgOfmHKyUqQBC1Q47EBzhjgo+Hu45XYMY
	Bw+ZfFhvxZ6XiXGiLb6B9FqzuF094NVGebYtYwL6YkzaiQsFYqAPj9CcJmVYJaFRkLtVcgAhHad
	iB7vGzGj9QYCghpmOPuZhx5rKaPhT3ENHMBg18HJkwO1NRR66e1ZnrPxbEPYLXo4/GfYqpUHUf0
	i/WHAHWQTJCxhPU5huxlq4boSM6KR/mNy3GsTX4+fq4Pct/k2C1oAP5/W29guKaGmRMoacN1yEh
	NtSROMcBQnw+MddLJz4AQrhq6DYCgfk6wuY10XErvlouDClQbLWlB+oQ==
X-Google-Smtp-Source: AGHT+IF5fhocAogDz+cJ9tyaU4gnUqnaQYeK5zO9z8Q9VyoS5y1N9k5LFRn6B+l2nBw3ChAsww2BBg==
X-Received: by 2002:a05:6512:689:b0:594:35b7:aa7 with SMTP id 2adb3069b0e04-5945f205966mr2497734e87.48.1762814705883;
        Mon, 10 Nov 2025 14:45:05 -0800 (PST)
Received: from Shofiq.home (88-148-150-44.bb.dnainternet.fi. [88.148.150.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59451bd3b92sm3928726e87.19.2025.11.10.14.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:45:05 -0800 (PST)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: nm@ti.com
Cc: ssantosh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2] soc: ti: knav_qmss_queue: free resources in remove callback (v2)
Date: Tue, 11 Nov 2025 00:44:47 +0200
Message-ID: <20251110224459.49724-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110212751.Jdztdakpcerpqpr28@gmail.com>
References: <20251110212751.Jdztdakpcerpqpr28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Nishanth,

Thanks for reviewing!

This is version 2 (v2) of the patch, not the same as before.
I have fixed the formatting and indentation issues you pointed out.
The patch now passes checkpatch.pl without any warnings or errors.

Changes in v2:
- Fixed indentation and alignment issues reported by checkpatch
- Wrapped commit message lines to within 75 characters

Thanks again for your feedback!

Regards,
Md Shofiqul Islam

Implement the TODO in knav_queue_remove() by stopping PDSPs and
freeing queue regions and queue ranges before disabling runtime PM,
mirroring the allocations performed in the probe path.

This ensures resources are released on driver unbind and avoids
leaking queue/region state.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 1e5f3e9faa99..7d9f3570ecf3 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
+/**
  * Keystone Queue Manager subsystem driver
  *
  * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
- * Authors:	Sandeep Nair <sandeep_n@ti.com>
- *		Cyril Chemparathy <cyril@ti.com>
- *		Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Authors: Sandeep Nair <sandeep_n@ti.com>
+ *          Cyril Chemparathy <cyril@ti.com>
+ *          Santosh Shilimkar <santosh.shilimkar@ti.com>
  */
 
 #include <linux/debugfs.h>
@@ -1884,14 +1884,13 @@ static int knav_queue_probe(struct platform_device *pdev)
 
 static void knav_queue_remove(struct platform_device *pdev)
 {
-    struct knav_device *kdev = platform_get_drvdata(pdev);
-
-    knav_queue_stop_pdsps(kdev);
-    knav_queue_free_regions(kdev);
-    knav_free_queue_ranges(kdev);
+	struct knav_device *kdev = platform_get_drvdata(pdev);
 
-    pm_runtime_put_sync(&pdev->dev);
-    pm_runtime_disable(&pdev->dev);
+	knav_queue_stop_pdsps(kdev);
+	knav_queue_free_regions(kdev);
+	knav_free_queue_ranges(kdev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static struct platform_driver keystone_qmss_driver = {
-- 
2.51.1


