Return-Path: <linux-kernel+bounces-751627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A5B16B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E50E5823DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A724467D;
	Thu, 31 Jul 2025 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHY5nu04"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096923F41A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940210; cv=none; b=JgYpjR5TavUbOgYNnEb1S5qdcuwtbiQw2TqKK2ehGIVF0riiZOairYgY4ZkUCgX+eL5ariR9/8M6x+dYihTHB5oPf5XwW6GJ1PiU68SGdVz/32/uhcASKZj8NsvPPb1PviDewbsMbfJKi8WZV5U9ZLr5r+RRxAjlQQNk+xiiuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940210; c=relaxed/simple;
	bh=7I6sal06IFxjih0fDGj/VH/J/XAMAfdhnR2uzo00UkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ap+86nw04qeVxO5DudDKzwM/AamFSWTe4o6O6njjxT4KEgFQwawEuiI/pSvTUy/b8xZrBRiqGGA9KvKeYT8uxi9GZ+cMRU8tL1EwCskOD6z3zMkJp6Ip+gev5WH9n6ukr6AG8EBLFE9iS2X4KflXH9QMjF6FJzBHdtqlcdvXOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHY5nu04; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7910123a0so543551f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940206; x=1754545006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55O+VIoR/xi+3QJpaWR1sqlb+0LX3xYA869Y7SaOfBE=;
        b=VHY5nu0428y/Yb4jawfpGZw1gjr3VMF8+s/vbj2Xsw3F8RREY2o4oKU39IxjOFKcMT
         KXvuy6BJDy/UflYFdNGdEJ7eIfDyDmokZZTFc/VsgB6bYEjPBzA3RI2ua23dwPToyxEO
         6WFCHllDoRCOh5b6R+iVO+/igu/YugCGQS8SYNaHUlASkR91IJ9yYFWClHz7fYGgq7eM
         M/zmYFGdhgGY6rLebDnEEUZ/TmyDf0ofJL7ox5GG7z9hi66n5At/tHnKyyhoiqyK0QxC
         z0t3RvjiH6jOqQ423Wp79N+5GXcsXpNLOfQCZv0obUv2Q4/oPKGEhRHVAG1DYvcdLHi2
         17Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940206; x=1754545006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55O+VIoR/xi+3QJpaWR1sqlb+0LX3xYA869Y7SaOfBE=;
        b=bwhN6NPcAdblF8QtoTQZlpJhpaSjCc2PJgvCFyCv6Cv4vWTnkbJFW7eK1eG24/sqNI
         Wlw9Jr4Aw3ku4mXaRmSDqEcqguOQ1xri9df83I7tS1zzuvdxKow3YzhYhDOaDvyApFo/
         XqL0U9DTY1wNqBBVIZw3vQSyM8n3XUuDDKKjHJRHKRauvHzBXhF/+qO8hDXMEZjAejnW
         Zir3+Hgd9d5FbiGmkefYefxV0XVqwU/lrCb58AydEakc8OUGBQ9klrvML3kP/zg1g0GK
         T6lkngWPauNAV+zC/ix9S5mvcSJVsL80GUpvnyE6N/VrCsyR95CfTHIR+aQHcOlJjUlh
         MLGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5eRnAPrmcvmSADaCzX+lHh97gcTNdwSB2KLPjy6jMcAR1pLWD5jMZ0lQg3U3qYR0tckdCgHtqGDgqER8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCdvxnSNsmRl04cxNpqfICjz6J9vOMjYapK+fxgb2rQQRfoSo
	GheKSr2t5Kt6X/GJd0Fv90apq66wLEGzKcvs8fo9XeVXKvbOCd3v2YzZ
X-Gm-Gg: ASbGncuW5wXXCWDxBVpLKea2+zSSE8PV+xcKiKzYBqaMUYGFXpOjbzZRZlp3QTF7MZJ
	T8oT3LpxQdvd3+MHwk+LOf48gy7BHYG0EurRO8az0iH0xr2H9PaseFqgy9TpGOPZjYt21CFS1Q7
	PgqfjeyhoqvvlqCy3xaqRnq1BsBFEowzzUpJP2rn0/V5AMbb2S8s68/OK6Jh4xEPRhIA4sigBlk
	k5oHzJkHbTezfLje4xHfV/1YmlgCde0jk7Z0czHeb7Elrsfb8rivgvmD0c6aosSgCKg0D+XxtuJ
	kOjCj6bQjDcfNHiVtpSL5HoPoArpk2X1JDhuxqUrNzRctArO9OE/nftxyYhOpYDo9IF/vBDQPCO
	yP8Dj56YyqHq05FRTEmYgdaA/WX3F7GtJwLyeD389sGqlnBmKobJCHSeAN48w
X-Google-Smtp-Source: AGHT+IGzUXir19zXUYKXSGg93uN8+VK+de8qh6rGcvNpNSIf0qBeuNeoorLazodERZ0vHpkgXIleng==
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:db60 with SMTP id ffacd0b85a97d-3b79affdbc3mr1504704f8f.10.1753940206455;
        Wed, 30 Jul 2025 22:36:46 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:45 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 31 Jul 2025 07:36:35 +0200
Subject: [PATCH RFC 2/6] drm/amdgpu: don't wake up the GPU when opening the
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-dont-wake-next-v1-2-e51bdc347fa3@gmail.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

Don't wake the GPU when opening the device. Delay amdgpu_fpriv (and
with it VM) initialization until the first IOCTL that wakes the GPU
anyway, unless it is already active.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     | 11 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 66 ++++++++++++++++++++---------
 5 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a1737556a77eb..e33c90c44697e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -508,6 +508,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+	struct mutex		init_lock;
+	bool			initialized;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
@@ -1617,6 +1619,8 @@ extern const int amdgpu_max_kms_ioctl;
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags);
 void amdgpu_driver_unload_kms(struct drm_device *dev);
 int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
+int amdgpu_driver_init_fpriv(struct drm_device *dev, struct drm_file *file_priv,
+			     struct amdgpu_fpriv *fpriv);
 void amdgpu_driver_postclose_kms(struct drm_device *dev,
 				 struct drm_file *file_priv);
 void amdgpu_driver_release_kms(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e6e2e2acf5b5..2b6cb3b1ca276 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1784,6 +1784,9 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 		struct amdgpu_vm *vm = &fpriv->vm;
 		struct amdgpu_task_info *ti;
 
+		if (!fpriv->initialized)
+			continue;
+
 		ti = amdgpu_vm_get_task_info_vm(vm);
 		if (ti) {
 			seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->task.pid, ti->process_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 34b9d63a86227..732f398922da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2967,6 +2967,7 @@ long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = filp->private_data;
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct drm_device *dev;
 	long ret;
 	bool wake = true;
@@ -2984,10 +2985,17 @@ long amdgpu_drm_ioctl(struct file *filp,
 		ret = pm_runtime_get_sync(dev->dev);
 		if (ret < 0)
 			goto out;
+
+		if (unlikely(!fpriv->initialized)) {
+			ret = amdgpu_driver_init_fpriv(dev, file_priv, fpriv);
+			if (ret < 0)
+				goto out_suspend;
+		}
 	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 
+out_suspend:
 	if (wake)
 		pm_runtime_mark_last_busy(dev->dev);
 out:
@@ -3017,6 +3025,9 @@ static int amdgpu_flush(struct file *f, fl_owner_t id)
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
 
+	if (!fpriv->initialized)
+		return 0;
+
 	timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
 	timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 91d638098889d..e13024bcd8bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -73,6 +73,9 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	};
 	unsigned int hw_ip, i;
 
+	if (!fpriv->initialized)
+		return;
+
 	amdgpu_vm_get_memory(vm, stats);
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8a76960803c65..60f36e03def2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1382,7 +1382,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv;
-	int r, pasid;
+	int r;
 
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
@@ -1395,16 +1395,45 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	file_priv->driver_priv = NULL;
 
-	r = pm_runtime_get_sync(dev->dev);
+	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
+	if (unlikely(!fpriv))
+		return -ENOMEM;
+
+	mutex_init(&fpriv->init_lock);
+
+	r = pm_runtime_get_if_active(dev->dev);
 	if (r < 0)
-		goto pm_put;
+		goto error_free;
 
-	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
-	if (unlikely(!fpriv)) {
-		r = -ENOMEM;
-		goto out_suspend;
+	if (r == 1) {
+		r = amdgpu_driver_init_fpriv(dev, file_priv, fpriv);
+
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+
+		if (r < 0)
+			goto error_free;
 	}
 
+	file_priv->driver_priv = fpriv;
+	return 0;
+
+error_free:
+	kfree(fpriv);
+
+	return r;
+}
+
+int amdgpu_driver_init_fpriv(struct drm_device *dev, struct drm_file *file_priv,
+			     struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r, pasid;
+
+	mutex_lock(&fpriv->init_lock);
+	if (fpriv->initialized)
+		goto out_unlock;
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1457,8 +1486,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
-	file_priv->driver_priv = fpriv;
-	goto out_suspend;
+	fpriv->initialized = true;
+	goto out_unlock;
 
 error_vm:
 	amdgpu_vm_fini(adev, &fpriv->vm);
@@ -1469,13 +1498,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
 	}
 
-	kfree(fpriv);
-
-out_suspend:
-	pm_runtime_mark_last_busy(dev->dev);
-pm_put:
-	pm_runtime_put_autosuspend(dev->dev);
-
+out_unlock:
+	mutex_unlock(&fpriv->init_lock);
 	return r;
 }
 
@@ -1500,6 +1524,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	if (!fpriv->initialized)
+		goto out_free;
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
@@ -1537,11 +1564,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	idr_destroy(&fpriv->bo_list_handles);
 	mutex_destroy(&fpriv->bo_list_lock);
 
-	kfree(fpriv);
-	file_priv->driver_priv = NULL;
-
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
+
+out_free:
+	kfree(fpriv);
+	file_priv->driver_priv = NULL;
 }
 
 

-- 
2.50.1


