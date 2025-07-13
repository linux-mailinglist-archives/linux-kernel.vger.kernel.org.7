Return-Path: <linux-kernel+bounces-728892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0FB02E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC5417F097
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0917A2F7;
	Sun, 13 Jul 2025 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjpOfufC"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A913A41F
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752376127; cv=none; b=pGi1gLOguLwazMsACHrwwR9U5qXR2BtKuywnf0Wuxb58feW5dpgbF8oty9Zft7IQClVVHPm9zsDnlSmhYNRXDna0MRyGbwKYQyhHBgs9KjZYlx+AsxWSKPZ6oJ6shaHW5g2oGj/pS+F/otKtHAJedhGZYzJRbdVTDuJflDMaXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752376127; c=relaxed/simple;
	bh=nR5Er56pkkyzVUf5PhF9LQ3M5NPa6FHJYE0PP9Dfq5c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVO3gpys0gYVLAAdjmKsrr5pFBvVaj36mEbCexo0gV3gZKFwx7ezl3sA1JaJuWA+X42IK2h07HiRjGDDtlOKbaRVfxF9y1yxrrMjE0s/8LBqq48uYteTtwLPogw2Z/xwkf5KMg9GYLxF+1nfx9/vq/idKrBrab0lvn6sYqhJEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjpOfufC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so3046570a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752376125; x=1752980925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXvmkRtZbf2b+Njy0K8dmXZ8wWln74jkiBHLW9XMXyE=;
        b=JjpOfufC3h26x/rxAQUaDZ1oiACduipY+sgRzxWZwyY3XQFFKVgJ552EQEnJr/chv/
         zfszQ8o8g3dTOO8HX28rkul3/mAaXusTGnoXjkUC0QA/s+eORQ0UEbLLfltZkRWWx7dc
         MznTjTEkDr7c3gCZzibuxC9iUIN6+22Iws4/2gFAa32PFmUHpspGlUDfNiCbhQLIGiBq
         xHWOWCN1OIqsObPfQPaMyR6PuCfd4XOTV68VRi4sPzipDP2GtnZW/Q1aB+qTAsMHMO/A
         aOep4dV3+Thwgw3qW5cKo1Nlo0QUX7pPzwWwb30XLxaDpZyYqhN+Ek/o9yqzsvsOV+IQ
         GCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752376125; x=1752980925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXvmkRtZbf2b+Njy0K8dmXZ8wWln74jkiBHLW9XMXyE=;
        b=cly2n2F0AaXE4UEsB47rRAW6zp6uQbtAGCoZ2306GiGHSlEQ67K+jgUP7MOXR+PVag
         ZOEKys6L4s1+lILDlh+dCoIYt5EDDs1tepQ0pSH8PMRXU/iz9P+YaBCr4PE0FHN0ljLD
         ygw7pkzs9aCDBp0QOzFiucdLNsNqmn71qHh8RI6jze7pIFNfOImFnI014E7WhDzuoMS/
         GNLIoC7uRE8ODOjad/09dd3Xgb2HBHQISIQfSppy2WmQ18IK4Q1oLwPbyzPs8VxWFaNR
         4Kr2jWnqIMJ8y6+uHYrgqLug65X4JeB6TUg5wawPZAm0Jh5xC/v4BFdTUREebIyqm0DX
         eNhw==
X-Forwarded-Encrypted: i=1; AJvYcCWd3TKmllYmyDQi9A6VOXi1C3w9Zx6dk2DQJnFKwXjDgh7q5kYhzDVrLIOR18dXjz4z9uaFeY28hesPrfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSQaz+C1mzA4L8nmJW0CaKhSjFLWDlcmgzR7rXP1EWHd4xIUO
	n2FdlvVA6wcOuwg9RQ8CH4HcWBJ5NjA6JgJSg09jDYeTMlXUz+F+a75F6l8EwA==
X-Gm-Gg: ASbGnctZMk30b70gQoHZK8PpTzBwY3VIJgQCK3HnzD28AysZ2YQHvy0S6XfkkE/p4Zn
	MoQqeNXwHgY6vc0MbT3aZ+1tN9NJMZoqg7jkYmK5KTBp47RAt/bvmDVyeGWK9QKQ114p+zWv2Ou
	CySOQVLn7n5auFIEL53mhhKo4o+89I9CZTk8ZoHlcEt/5Lm0Kp/WAcIxKCkOKAUKZ9Agx4wNh0t
	KNz1d5W28eqk/Bu4POcmQNRWnGFchiWKm8TxNxKmXa6LvdzKG57iNmMQnGZqmxi+CiH7PQ9x21A
	WOAlR6eNQQd7URjZDIF0E0yJfH/CJ5wHro0t73oI0WLlXr4bLfnx2twX3GcUjbjhh/H3p/HGBHw
	DGnWBa5CEOxn2qgjPBk8VphI7p6DeR0wzDYpa8Yt3mS4DxN0hBrntUP0s
X-Google-Smtp-Source: AGHT+IGJn2mfV13kGWqNsFG87NUzlj6w+JlP0SqQyWoNKdedSr6NBSs8KTAdv+NjN201O4ijYH0AjQ==
X-Received: by 2002:a17:90a:c88c:b0:31c:23f2:d2ac with SMTP id 98e67ed59e1d1-31c4f53f737mr10992295a91.19.1752376124847;
        Sat, 12 Jul 2025 20:08:44 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4283a81sm69421585ad.27.2025.07.12.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 20:08:44 -0700 (PDT)
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
Subject: [PATCH v2 1/3] panthor: set owner field for driver fops
Date: Sat, 12 Jul 2025 20:08:29 -0700
Message-ID: <20250713030831.3227607-2-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250713030831.3227607-1-olvaffe@gmail.com>
References: <20250713030831.3227607-1-olvaffe@gmail.com>
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


