Return-Path: <linux-kernel+bounces-736324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC66B09B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFCB1AA6AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272C20010C;
	Fri, 18 Jul 2025 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz1BGX1e"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683C1EDA03
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820707; cv=none; b=PYbD1ypyotHXTph83YZInHtB6mKfHy1qYIwx8YYsbKx7+FDbONL58fZLKrOLLGEiSILGbL1jA4KC9iarG3MoY1DI1B/ZoE2zTw07vdNariuY5LRP6XxHtkzshH/3senl1n3MhWBLudr7gfGShB2krpmCE7B7XMsbei1538eRs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820707; c=relaxed/simple;
	bh=nR5Er56pkkyzVUf5PhF9LQ3M5NPa6FHJYE0PP9Dfq5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zpz2ggCEPoa3DIBHutie5pOFzmXAZHoAeBVZ8CVYVylIBmYzNzCltpnEBx98Y+KzA7jeYXk/edw8bT1D9oO7CCcE8kWiWr5jHZjJSy3TDqeww8UCeeVN1GyMMmBIcFTgklEtiZcMpWMqNPEuLCSShOIOOYmmlHT2Z/koE/+eGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz1BGX1e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167b30so16695955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752820705; x=1753425505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXvmkRtZbf2b+Njy0K8dmXZ8wWln74jkiBHLW9XMXyE=;
        b=iz1BGX1e/BLo7C0CPSuLo3HV1CB8CBOvC6VXkbU4OqqalCMHZIzkmkIuYgvb0Ei6KO
         uA/qLaG6hA/z+mYR6FUXJoCvwNYsQllE3/+3OhHLJuoGB3eAY8VOa4ghCKQKd7uIKIOs
         D7eB5NjAjSfxiQRWn3vj+odZlsROyK5ZcBhcdscG68mVyp+SnHfp1q1ESseyHG9PX0Pk
         +w0U1ps5cZeN99FFKWxKY8NIqW6pK09o1o4TWk2dIm7NXhFxwJ0J964Tgt/oeEGe31jc
         IBhGWvXulhJDrCVwXGz7Slz0PuOunE62Q7ZWStL+/IQCEGy+SfgzNcfgDKjc3isLnbCx
         9EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820705; x=1753425505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXvmkRtZbf2b+Njy0K8dmXZ8wWln74jkiBHLW9XMXyE=;
        b=qPQW1t3ETWwpKFa9+zEbTGdfWrJwQaWdXEr+tKe7rafHjhG4DXlc9DrbVr94z0lVDM
         TpWD6yDA8QmJTgq7wWw+H93WJf6pFi7846aKs846AgNYbqdVKCi9/rguJp7aYxhmnpy4
         4TABlXJK+UgzhRWHrm8j3oirfNVpSQyjrvY5aQsAOZatkV3WQ53V4VVPLK7KrjU1q1+V
         lfOAFPN/fRWBVaU14PP3fUrMjDgk0EnuuaFkbJV2bfMn9TNm73B/fRLiMabzfb7K0ynS
         XtZU0vKXPOuBZtStCTpBSC5OJhUMYNVwKEqjZOQbrLDPBzGDX1fqUOOc1LJU7GFt/I7N
         EOOg==
X-Forwarded-Encrypted: i=1; AJvYcCUWTUTsuGhXdUbyFNgEAyvLkp97IBJB+ve596+DEOSK1gx69b0hSOXPaEAvC1eF4t90dhC5YVvtYpeLtSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOh3Ww1Fj3J1ZVkxKJoJ0ng2OhnncbgFHwXR/fQHOjAC48fHr
	MdiX5Cdcee8pRisZIPRW8dRzdz1xJi3LvLDE+4ZjoStStYUv4LYNvmfo
X-Gm-Gg: ASbGncuSCIDFPVgq4Y9Str/ITR2Wc/vDhTrXYleGjeU7VKBWDdMdG2wVOMg9LcJ7PKp
	MxZR6eRi1wKDKLoNBiI7xXggEdZAtt8+brCS6/cNNy8jhx9FoQYR5mPmsUqTy5TAWmA3axmMax2
	EhNPtrJpqx9cF2MXyBiRVCm/aX7Roa8ldfJ8bRL8wzhC6BT66ThgkXLh8lIpWxqJDrKL5zorqC6
	NC2WV+dXaOpdlES4EciQG2hM2zI7vcQAvj7wtAMGKcIeOS5MDloH09f+p+H28R9Z2M+YFUWU9O6
	XWPWslaqSuIwzX3mpvvvSxnekeJ3Rn1F/05nekvYUZjV2OJORNxWSHLunhqi1/VXxhmdMkpfMyv
	IoMbB2X1ekSDO0uUU9/3ojB1pDDOoryr7YqJ7+7vwNsjQyfML3aMyolVnANX4OAEDtNc=
X-Google-Smtp-Source: AGHT+IEQjg2rhR17Fe62KMqonv9XJcQ8PgfAvORPla3hXiivMClvZtuzEB+4ymJa8aFwwnm69RTumA==
X-Received: by 2002:a17:903:22d2:b0:234:f580:a11 with SMTP id d9443c01a7336-23e256c951amr114024735ad.19.1752820705235;
        Thu, 17 Jul 2025 23:38:25 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31cc3e4599dsm589125a91.9.2025.07.17.23.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:38:24 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] panthor: set owner field for driver fops
Date: Thu, 17 Jul 2025 23:38:14 -0700
Message-ID: <20250718063816.1452123-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250718063816.1452123-1-olvaffe@gmail.com>
References: <20250718063816.1452123-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It allows us to get rid of manual try_module_get / module_put.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 1116f2d2826ee..775a66c394544 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1400,14 +1400,9 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
 	struct panthor_file *pfile;
 	int ret;
 
-	if (!try_module_get(THIS_MODULE))
-		return -EINVAL;
-
 	pfile = kzalloc(sizeof(*pfile), GFP_KERNEL);
-	if (!pfile) {
-		ret = -ENOMEM;
-		goto err_put_mod;
-	}
+	if (!pfile)
+		return -ENOMEM;
 
 	pfile->ptdev = ptdev;
 	pfile->user_mmio.offset = DRM_PANTHOR_USER_MMIO_OFFSET;
@@ -1439,9 +1434,6 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
 
 err_free_file:
 	kfree(pfile);
-
-err_put_mod:
-	module_put(THIS_MODULE);
 	return ret;
 }
 
@@ -1454,7 +1446,6 @@ panthor_postclose(struct drm_device *ddev, struct drm_file *file)
 	panthor_vm_pool_destroy(pfile);
 
 	kfree(pfile);
-	module_put(THIS_MODULE);
 }
 
 static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
@@ -1555,6 +1546,7 @@ static void panthor_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 }
 
 static const struct file_operations panthor_drm_driver_fops = {
+	.owner = THIS_MODULE,
 	.open = drm_open,
 	.release = drm_release,
 	.unlocked_ioctl = drm_ioctl,
-- 
2.50.0.727.gbf7dc18ff4-goog


