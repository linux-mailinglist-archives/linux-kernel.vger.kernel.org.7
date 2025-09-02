Return-Path: <linux-kernel+bounces-796853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F2B40852
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580621885471
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8416F311970;
	Tue,  2 Sep 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVw7LP2A"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCA3009EA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825254; cv=none; b=dKhKslay6UapcQIJCJTdSmXkxstunx/xXfKhAEcKk4S3IEUKs18gpyP8ntUjsMa0srh5zYgaj2QJBadhncRNlVDHrYI6xe3ICzuxVO6du24Rg6aX/KisrSnxjDlLunPy1f8wTekLoEat0heq/+MEHYbw+vBRhfIhcW7MPQ7ZSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825254; c=relaxed/simple;
	bh=E1gm4ixWV25iVKcnn7DLy0cpx6LH/SXjVAyuX2kFSPw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rsPPC2URNTBhPlajjBnpFBbpTesKlqa1wL35wHbAlLgxCUBpOkuDauyiiegt3zhlVzYmZv8PFNe0lWCcAxWMazuCk9ieodlAHg4aa6EosQ5eyGlvcMKeSOTLt5LT7OguP3ihHeVCXXCAkAz1eZZ2KMlhvr2XbGAcAEj66F2t0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVw7LP2A; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722bcb989aso3005769b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756825253; x=1757430053; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn6ROBb8evHy9I8BKmFlbvpCLLUKX+yfgDwyfCgLRYg=;
        b=iVw7LP2ANCC+d2Ml7CSFPjyUVRzN+8bAdFPZN9DqCdiTUxmqp5QCTG4yc7satjdNDy
         Yc1p1vDXHLHfzN2pZ3UYUdwIq6V6KP/Pwd/8hcaRUW3AI78tJqOm4u3kNNOvSf+dLE4J
         qNGoHZ07jU1+4DAVLYJvu9iGCZ6buO2mXXL99u7L5UeM3ioiDVSLOYSvqv0xUiCF0dZR
         evMSLdgsQE/wz2hDVhKLt30cM0hxUdcZ9kbYa3RWVBe0KKsHYVNY7sJ3IVtpHhmc6+zv
         PBzBAUGh+VCVWVTXNp2ZyXzXtOj2tlT+s1PcngY0fqywCE9TS3OUE9/GnnpFaiLsg/56
         3DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825253; x=1757430053;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tn6ROBb8evHy9I8BKmFlbvpCLLUKX+yfgDwyfCgLRYg=;
        b=jysJeVMkq2kdNuWHmUuW4fXS7cAihMfS/NVgmW168Hzp6kPljN/o0HywO4QvBQf40i
         7VkzkMrjJBl34v0xLRARL1c9BwgLnsCjI3tsQkV401h3YN611sI45cMg42jc1uD8YlP1
         6Eh3hiqt73d1JGAfXoo7EmgHpDMWLr64hNKBs2W08dODFByaTwBBgvyJYVFbqD/SJhUg
         bxFxyBsR+Nm11oDShNY3gygtjrkn6dqVvZmjo5TBOZYCBpOtluXN1KAC9mi1c48Y2C6b
         nvmrjcxfft3qgRDYI5yq/4PPmwE36zNObIF5os3f+k2CPTfRRq+lDbHumTrwlLiMMCOd
         jNqA==
X-Forwarded-Encrypted: i=1; AJvYcCWzJyVb2JthnQyIQQ+eV5qEuZiF9tO/2RMcL+DznVog+Fkx4vhuMICh/S2bJAENmM950+MvqyIutzEMPiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGmAZDKadqob/HD7NGYu79owPXMv0mSIKc7r+poFFgKJK2zCk
	egzi2L0bWbbLxGOR2EVD6HIxso4tPnOxIpvJskowmbEsKWkPWs+rE0qc
X-Gm-Gg: ASbGnctR1FQy882sz0wzEZgLveqwkfUT8laNn1XsDTEXx383GKnq8Ohol6l4hhPIopb
	xL2LcjPq+WM1BBTdpOV4cclzt+aW6KZmV4XWoEvGYTy5OmkpyFdeZ/tB+Rb5lXcuY52QGsSYD0d
	CSHAUfEFs+8YKlf/Mx7irILCh66x+5QumFwNVQwnCdi/kdGzab9wUEYipldgn6LQnCPuk7HDw0X
	MpUlMC1u8vZTuqshoAGBRifssTmOnC9AmZRPW2WSwnuDNQx5eH3R4zaOZxpDRZflYxwQ289fi4c
	OkkvcERckq+wGqswgzBL7kn7YXXX0r8ksWHDNBrg4kDGuSwPRK3SPOR6ydCB6CMGjcvYJNLn3V8
	IbyPcItf5029W7Dt3+g==
X-Google-Smtp-Source: AGHT+IHHxrc0XwRU+HRTrGA57CaD51yo2yh2p0+QXYYFuVfMz4hoSOXX4R8xNZoi2aFYtFEvwTwhMQ==
X-Received: by 2002:a05:6a20:7fa0:b0:243:9845:4137 with SMTP id adf61e73a8af0-243d6e5b2edmr17328160637.26.1756825252323;
        Tue, 02 Sep 2025 08:00:52 -0700 (PDT)
Received: from Terra ([2001:df0:b240:6cbd:e842:2f6a:96d:9188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772608b1b5asm5332937b3a.46.2025.09.02.08.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:00:51 -0700 (PDT)
Date: Tue, 2 Sep 2025 20:30:45 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: michal.wajdeczko@intel.com, tzimmermann@suse.de
Cc: skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev, krathul3152@gmail.com,
	linux-kernel@vger.kernel.org, simona@ffwll.ch, mripard@kernel.org
Subject: [PATCH v4 RESEND] drm: Replace the deprecated DRM_* logging macros
 in gem helper files
Message-ID: <aLcGnf_wrY5QuZZC@Terra>
Reply-To: 20250816152604.14667-1-krathul3152@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace the DRM_* logging macros used in gem helper files with the
appropriate ones specified in /include/drm/drm_print.h.

Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
---
Changes in v4:
    - Some codestyle corrections.
    - Remove OOM error logging in drm_gem_init().

Changes in v3:
    - Revert all changes to drm_gem_objects_lookup().
    - Use drm_device from minor.

Changes in v2:
    - Change drm_gem_objects_lookup() to take a drm_device* argument.
    - Make appropriate changes to all calls of drm_gem_objects_lookup().
---
 drivers/gpu/drm/drm_gem.c            | 13 +++++++------
 drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4a89b6acb6af..dc3d6cfa692b 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -102,7 +102,6 @@ drm_gem_init(struct drm_device *dev)
 	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
 					  GFP_KERNEL);
 	if (!vma_offset_manager) {
-		DRM_ERROR("out of memory\n");
 		return -ENOMEM;
 	}
 
@@ -783,9 +782,10 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
 int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 			   int count, struct drm_gem_object ***objs_out)
 {
-	int ret;
-	u32 *handles;
+	struct drm_device *dev = filp->minor->dev;
 	struct drm_gem_object **objs;
+	u32 *handles;
+	int ret;
 
 	if (!count)
 		return 0;
@@ -805,7 +805,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
+		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
 		goto out;
 	}
 
@@ -853,12 +853,13 @@ EXPORT_SYMBOL(drm_gem_object_lookup);
 long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout)
 {
-	long ret;
+	struct drm_device *dev = filep->minor->dev;
 	struct drm_gem_object *obj;
+	long ret;
 
 	obj = drm_gem_object_lookup(filep, handle);
 	if (!obj) {
-		DRM_DEBUG("Failed to look up GEM BO %d\n", handle);
+		drm_dbg_core(dev, "Failed to look up GEM BO %d\n", handle);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 4f0320df858f..a507cf517015 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -582,7 +582,7 @@ drm_gem_dma_prime_import_sg_table_vmap(struct drm_device *dev,
 
 	ret = dma_buf_vmap_unlocked(attach->dmabuf, &map);
 	if (ret) {
-		DRM_ERROR("Failed to vmap PRIME buffer\n");
+		drm_err(dev, "Failed to vmap PRIME buffer\n");
 		return ERR_PTR(ret);
 	}
 
-- 
2.51.0


