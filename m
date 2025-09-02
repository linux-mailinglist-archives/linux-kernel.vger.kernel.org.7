Return-Path: <linux-kernel+bounces-797171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0EB40CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7304E43FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C62934A31D;
	Tue,  2 Sep 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnEnw29V"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9093469FC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836627; cv=none; b=O1/+I4qjInE0BqwkFtat7ko3+dVJhuhMrBOMNpAln0u6Xp3MCRS/MG18V4Wi0ogf51O7NLLy7L54HlFYcsvWnrvMWIQeTQdlilStbbcT8Fc2sxN30KC0L86m7JmVUl4CIkCCw5RNiPtR/W1xGVegeM36gFfpWpt6Fg++g4LEPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836627; c=relaxed/simple;
	bh=HUZUWUJarg7W6rqDCZMjaomtY0RkYmWhDh1YrtdJo2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q9Al1VWjpXxpp4CBbxXYOP4ygm10IlJD+14THPRciUKxKRyq2HAYyYsIdWUkG7yHFrLPeKOHKxHYdYDlTZ1n5TpIcZiqpf7Ysu9RiByA/Z3QzUXhRKwBaRTYMbio1kAjbzFTdvpdvebvgv4dbxHffX1Y6AvwR7es/JpdUlOtGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnEnw29V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722bcb989aso3166599b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836625; x=1757441425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TH0A07StqxqCETJBwzgyuGcbJt6lyB5z/jM8qgdsuU=;
        b=XnEnw29VJuubyMHWCLkTpe3wvj7KC+vv1SDjlMjz0ySXvOcfeL1yKB3jEWxNpSRxJ6
         6o2NlLuCARBv+jt0ps5fWdHTzWrzRxmNsFGk3gMGh8h8TZQgE5wNR5+FcOOrx/e51Pnp
         o1zR1MVV5nF09Uedce2aHtCaLcb5nXBG2mb6biPVCMRMSWIhtAyIDy/ch7TyrBnrQ/qQ
         8K9hMkNPPxIx03Ss3mfD+7eyN3FHvjNxnY7gm15OPY98Hn7YqiiqwbzkKADjk4VWr3DF
         eGE/uzhM896ush9r7UAww0r6fVGaw8dipvyA6xdKg2BLTkNS3ulO9AlsYtths2EZCMGQ
         iiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836625; x=1757441425;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TH0A07StqxqCETJBwzgyuGcbJt6lyB5z/jM8qgdsuU=;
        b=DTImjPztXCgum4XqPMiNq7L99bBzdytOZ/sdqcoNz+k1I3Oq+laVMPfvV1Mt8TnvsG
         Ze3N359KX+byIjo4kdRDfncaDIVn5X9zyEWQuH7G6HUpIXPmuPgqYZ6FCv62ZV/Qby6h
         XYM+UsHPbBvn+d7KfHKgNgYr50iGGD+gUK/qdknlYyXOXadJd7TCNXdKJs4dKG3HVvO9
         LfTX7HhYIVNrGcEVo29xb04T7Z/sSEXVxDf5U4VQ893+WVSVWysnjaDwIuN+Jn+W3hL0
         ZMAWG0/dUKxNSduNDpFAN8CEZOcjJMoQH9ATOmW5XvXslzaoEX33HdmWTytnUG0sfbad
         enrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE74FHYIt/YZmCeQqRmt+k9JUHA58kWSaX4g8FupDhfkihiZ6yEQAwFAyDNabm8Dpl250SaCfGLvPreAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytdpWtNe9gj/nwXHa5ixJ6U5VdXWxyrxprneKaj+v2mUk2+fJn
	uF39B3LfP8YiFVaC/lsnVrSyPa5MpDvbNEIiQOTMbYjG/UfRLmfjpy+YssLCIA==
X-Gm-Gg: ASbGnctcZYgP6PV5LlwttnsZA6UJUdJgEp0jy/fK1djnKuOKYBAjmmp6zh5cwbL5GfY
	8BaLtq2O7h71HE8NZCW2K68UIFwTG2qRKI387mu3N9b3KUXjFzljLNbjFGFhj17dpj3wcPJyG6f
	lB528eblvyPFjC0374aIMFhoTSB5/J+piTcrXfLuiZ2XaOBNETL/PMrKN6a9w6g/ImhVcwapU4C
	0ydkMG5qA/aJb1OeXKpo1M3uesMWkk58Jn8ktF3AsS1RJviv77GOCLcjAH9lNJnbt6Kb4xDmrfn
	fse5oTqCcY442nFuLXgrWI9M1FOCBBjW4r8BVNv6yPJ0caITUtrycbs16sOAkb3WqEOHIG4D/Ik
	cq/qc+CyA73QYK2nO6g==
X-Google-Smtp-Source: AGHT+IGFHCri7WeJln98XxJPVPtUkEe7QIgxGiwCcpWDJ+7ZO0ZQMfaPJ4nVVMR14D8qz0BRhvzB1g==
X-Received: by 2002:a05:6a00:2e04:b0:772:5b16:1081 with SMTP id d2e1a72fcca58-7725b161490mr8303874b3a.28.1756836625470;
        Tue, 02 Sep 2025 11:10:25 -0700 (PDT)
Received: from Terra ([2001:df0:b240:6cbd:e842:2f6a:96d:9188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b362dsm14334484b3a.32.2025.09.02.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:10:25 -0700 (PDT)
Date: Tue, 2 Sep 2025 23:40:20 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: michal.wajdeczko@intel.com, tzimmermann@suse.de
Cc: skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	simona@ffwll.ch, mripard@kernel.org
Subject: [PATCH v5] drm: Replace the deprecated DRM_* logging macros in gem
 helper files
Message-ID: <aLczDHV_yGnnRKbr@Terra>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5cc1e0-ea0a-4d7f-8834-20a371346d79@intel.com>

Replace the DRM_* logging macros used in gem helper files with the
appropriate ones specified in /include/drm/drm_print.h.

Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Changes in v5:
    - Minor style fix.

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
 drivers/gpu/drm/drm_gem.c            | 16 ++++++++--------
 drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4a89b6acb6af..fb12cc2051d8 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -101,10 +101,8 @@ drm_gem_init(struct drm_device *dev)
 
 	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
 					  GFP_KERNEL);
-	if (!vma_offset_manager) {
-		DRM_ERROR("out of memory\n");
+	if (!vma_offset_manager)
 		return -ENOMEM;
-	}
 
 	dev->vma_offset_manager = vma_offset_manager;
 	drm_vma_offset_manager_init(vma_offset_manager,
@@ -783,9 +781,10 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
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
@@ -805,7 +804,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
+		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
 		goto out;
 	}
 
@@ -853,12 +852,13 @@ EXPORT_SYMBOL(drm_gem_object_lookup);
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


