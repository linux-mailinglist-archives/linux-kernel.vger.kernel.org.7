Return-Path: <linux-kernel+bounces-819605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F0B5A39B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AD93A4285
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4129ACD8;
	Tue, 16 Sep 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8umpCHb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425EC2798E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056914; cv=none; b=fo5yGb/sEXlPDHNSd0O/F+syqfzvWmverwSI7WFOkMUjUUQaUuw2njTWP5TAdporxT6YtQ5DHOMmCe6Wya/CbfW152w3Jk4N0vAG5VBJIfQhxVuOQdA4Pv5+iFiQCyRxNlBkSZ+CMkLhfb0ulySKgxZ5sNVtOYelpyRBc9th+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056914; c=relaxed/simple;
	bh=SuiPmK+Crh42Wn2BmX/TuMGhY6YmRUh+uPBkvuNcLk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKGUwjGSEc9NGkTtcxbNeD1GcxwKmONvDIXgMbUS4VB4MRIhqIL6eKgmKBQslwRvexki9vNoE550TeIuLEYWnvod1XMVEdkFZfmEC8uSpNKkIA4TsfSsbV7t2c65AYyJdFl1RGZyK1lEftfWAs0FOn1q1y3QQJvTed3jH2QfBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8umpCHb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77619f3f41aso3489523b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056912; x=1758661712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXlqsfnKLagrxPr3VzrTdqYzxgGnKLHikbQ3zw87L3c=;
        b=C8umpCHbwZZ2llAQ1djBycVECywlKd5mAd1G02oPuDt4hYOusHAsdriA084wbIHFkK
         91eP+zDaGyanHdZ8W4h5uE+vy6ZXSlMWOpA2kAvyFJ847YgYUiWiw3OMXJEGDm2l51JG
         b4/m9x1c4ynmk7ZPWEhk2bQsxHDMbbHa3bcDSbT5CIsDyZEGc72J5gstBWlUdDAJhaRS
         m2AQn9Hmd8ke2vy4m7xmnmpP5cm6rtIxXKXIkiqu1ncowVja+a02bVEEMah7e7gNG6yr
         6UYGdygIodxgcA7KwCVN0PXQX1SUn3On+JAJObjvwukIvyvWK5YYPMfml/iAYwcZROIF
         rRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056912; x=1758661712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXlqsfnKLagrxPr3VzrTdqYzxgGnKLHikbQ3zw87L3c=;
        b=pkDZclCMLOQgfknfVk4T6XZ6ohHIc2CUZ2ooj+pP9ctqg5a8+L+R+Ah9eUgce7uZbL
         xBMdZEGqzrYOpG61+IEz4Kv4ZPK16OuqE5hokd9yXXrbCWuUMVqth2XHmXzS4dGWjD3r
         GOoU4gM1ZDhrCuJC/r84+OIq7w4Ez7m0EywDfYA2Z//VGcVrh2+Z/d0dWpxTgAaYg+Hx
         rsx8LRwOjMZU+sSSfIsdvFl5yNyLd4uRNjI/w1fDMO18KkVIh9j8DysRr4ljW8jzr/Ko
         mqK1KAPYjdqeFqCrSovB7vbpww3LA8I3YKZpC4UWXiZTSLDHQB0ujWoI4QMSQGlNn6xB
         eC5g==
X-Forwarded-Encrypted: i=1; AJvYcCXLamdwKlesTNe9bAxsvO8MO2VYZUlauVX8dxDWwESX8Gz/EbYeoDViptdgkebeTSaSdkoeqA1zxze2SgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Zc+RxOD9ZJudysR944SNm4zSbovAAhe48cvsjiQ8c7wuz3AJ
	4J4wZ/oAZ4wZq55WBj+k3AFQ32DrVa745hGseNIJW30Yfkxtq97I+pWV
X-Gm-Gg: ASbGncvtqWJpw/LvkoQE7UAjM99cKwRIyOYQ48sU3ofmYIWy3shlB8T9Zh0g9R8sJr/
	H3KKJM4aSFfTtFxnl69J8QCjnb9vhmTNedEwJx+0esrYZap5AWehBkn+LluRag7So8dBE123719
	CNZOvyuXCpyTCwhlhKpI8W+oiDLd+0uuwBJmWJ75t3VYkp/tKWL9t2Iu0H+hg3qW++Cn1rht31j
	LYM7HqC8GBOG/yj5Znpm09dYN0ikw9w4SSxkTYDpdPlJk4NHpJDPAYj4D0h7U9B47b2LTtzyl8B
	P3XwwLnBp156hj9B72V6VjM8S/sCe6KYXiZJmk3bX8W1Tja+8/rbO3zqKKLmr0G/YwPrNb0Pk76
	VXd5EDRp0Oek/wk6Y2c3jHwnDf75hRkEda2Jgin6y2X91RQzwpVYGJSo0eQ7BkvrA4d+KUWxOLX
	BfQx+44ht4uA==
X-Google-Smtp-Source: AGHT+IGpEOt2m53Rpg1wAIXOJxhtQSEdxYW2LFFzym9M525oZbCACFLRLKzow9N2bwg0rZ2ZXol3rg==
X-Received: by 2002:a17:903:19e8:b0:267:776b:a315 with SMTP id d9443c01a7336-267776ba382mr100151885ad.32.1758056912450;
        Tue, 16 Sep 2025 14:08:32 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-26711e5d42csm62779625ad.78.2025.09.16.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:31 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] drm/panthor: rename and document wait_ready
Date: Tue, 16 Sep 2025 14:08:14 -0700
Message-ID: <20250916210823.4033529-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916210823.4033529-1-olvaffe@gmail.com>
References: <20250916210823.4033529-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename wait_ready to mmu_hw_wait_ready.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 6dec4354e3789..d3af4f79012b4 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -503,7 +503,17 @@ static void free_pt(void *cookie, void *data, size_t size)
 	kmem_cache_free(pt_cache, data);
 }
 
-static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
+/**
+ * mmu_hw_wait_ready() - Wait until the AS is inactive
+ * @ptdev: Device.
+ * @as_nr: AS to wait.
+ *
+ * An AS can accept one command at a time. This function waits until the AS is
+ * inactive and is ready to accept the next command.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int mmu_hw_wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
 	int ret;
 	u32 val;
@@ -528,7 +538,7 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
 	int status;
 
 	/* write AS_COMMAND when MMU is ready to accept another command */
-	status = wait_ready(ptdev, as_nr);
+	status = mmu_hw_wait_ready(ptdev, as_nr);
 	if (!status)
 		gpu_write(ptdev, AS_COMMAND(as_nr), cmd);
 
@@ -601,7 +611,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 
 	lock_region(ptdev, as_nr, iova, size);
 
-	ret = wait_ready(ptdev, as_nr);
+	ret = mmu_hw_wait_ready(ptdev, as_nr);
 	if (ret)
 		return ret;
 
@@ -617,7 +627,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
 
 	/* Wait for the unlock command to complete */
-	return wait_ready(ptdev, as_nr);
+	return mmu_hw_wait_ready(ptdev, as_nr);
 }
 
 static int mmu_hw_do_operation(struct panthor_vm *vm,
-- 
2.51.0.384.g4c02a37b29-goog


