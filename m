Return-Path: <linux-kernel+bounces-774377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879D1B2B181
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622251759F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40F2727ED;
	Mon, 18 Aug 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfhxrzyO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EB3451D4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544996; cv=none; b=Vba0c+88b3oQHH3xgvWotZ7Jyw9akl26TDbH4vKmFw12IgzHPQxUnBM93ZwD+Tfr9kcHLkytix7mC5bnmnoLQdVCDHH6S9P5Ui6IV9atcRMuvgqKTvECThwtnV7EISVfHqbARy1ylrIkfrvOilyQ9nigxARy+W5x2xt3YuXP04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544996; c=relaxed/simple;
	bh=bb14qSVeRqjYRYA+R4QtQHwtzABBEc2GiSw2jwXJmBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgfP+e3sXI3fVgo5brQcBzTiCS8Yfl5aNN8b/3IbmIf3dTpZDsMoNtXLDlST4f0/KeQHJtVItn160UDqWEGMnSokjvKKJQyIo49f3Pl/cgtzQCSoaiEH7RUV9IPxZI30W8xzVsHGovVsItNVwDXgcs6Pz2AcsYTFM6qjN6jwTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfhxrzyO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458194d83so32097015ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755544994; x=1756149794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3oJ/UF4e9DQo9mznCUa/U85D9g9MWf2CIUxQg1XPG8=;
        b=NfhxrzyOvTgisoCx9VuNV6cFsOZQo0y0Q1wRLg3ZwKmHp2xF2Zh8JlSL+CVRmPpOq8
         5hh29H4+7+Uw1bcsPTu+SDcfnS+5UPxVnP0q8zfQYaqj32O0nb3mFPVWFLFU6ytrW5z2
         O/kE8pjmc2Dm1Fw1hmaJoC7zzyOJhSbV3RdNKJexMrgmzt5AgmLd0Tq9m2f0f31MPpj2
         ZHySe8xFdSNekKXMAQ6rbD5dPGiBi1HPX1+wTE25UxNgMSQORvwBTap04ofYXB36Hai6
         DpKkLa53B0HDK3H48ti4+Bugg9bprRK1w68JsMN8LzddAmbI4okXphK33tUvDR1/Ne14
         wS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544994; x=1756149794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3oJ/UF4e9DQo9mznCUa/U85D9g9MWf2CIUxQg1XPG8=;
        b=kErgTyg1kzRLvtIwaVUJBjuuarM0lLEYG00N/ucs5F+l+7Fkm9JFrgSjE6SMyX2cHK
         Oq4D8xTGYGqaRbhUxJ9VD0CUXj3FmA8y1ntq2omHYsJ0zZtw3R23075KZHGILiAKmKJX
         LhlCJsOBA5vjPVWG9pK8kUn51eFCa2q7yWWuI+/hY33ozgrTLHRUNOzS9yc3RllcE4uF
         3w7X4e1LpHzWpSFsdO4smi1jZV5X5QcMR5Pe3gvgMcesV8rHaoofU7FmEPOagVfOLnx0
         1NYnFiX9DqKHq22nZKvJPeU6uOUcdk6c+RHvuCHvVpMfL06EfOYRVaEcBJ0TQQmRIaKt
         02Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVIQxkcQvOVINHv5kj7hLmtgdsZXMSMcNCNhMhBUlI3oq0V6PwfPQPxSZA7WzYVyb2nThEzL8HdJ4+9wQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/h74g1hgELMLMgLU4HnW8TuMVPok/rbytcaItnn3kQolBEnK
	e1YYw3DIviBsY7ApNHCIVn5bWVYwgj/GRf8yapk02f+rVYrQ43holS2g
X-Gm-Gg: ASbGncvB+rjWL5LkAC3BiP2Qo8kWbBIFSwM9r+s1rb6PLky8S8HSyLI3d9JPPE3sJRb
	OhIymXvlw5W9UZkWkFPo8qSd7vFaaG3iPD//hEux2oJe4U9O4OAOJyBlDREwqIgA4zkgOKQRmJB
	CSYoZruZ+zC+P3n6zmneIdH0pfU+eU8I/XckGng4LPRHwxAHVhVTSPOnTRtrGZuSmXKb0bR20UZ
	3nR+G560VPjWZb4fM+sD8feHUapeRrM3vXLfSUz/mwvYX70wIa1PPkT0t1zJtnpEAnwgIa1Xb97
	3vXROcimgkRCYXQVyo85sn9X0Eze9qxvMKxVnlgULeJvSYGBo5dnOE2/4+Bs22IVU9M3g/uOdpE
	9mm4/8ApAOPRfYw4Iw4kwIdRUOoij
X-Google-Smtp-Source: AGHT+IFad2Sv0meNuq0G/aQ1adIBZ0wHYRB79nvho7DFSsLLH3V30hFfbgFPz04e3QED8jj/QbHJuw==
X-Received: by 2002:a17:903:234d:b0:240:90d:468d with SMTP id d9443c01a7336-2446d6eeeddmr145151015ad.9.1755544994570;
        Mon, 18 Aug 2025 12:23:14 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cae02e7sm88178905ad.39.2025.08.18.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:23:14 -0700 (PDT)
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	krathul3152@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	skhan@linuxfoundation.org
Subject: [PATCH v2] drm: Replace the deprecated DRM_* logging macros in gem helper files
Date: Tue, 19 Aug 2025 00:50:45 +0530
Message-ID: <20250818192247.58322-1-krathul3152@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <f94151b4-893a-4758-a118-153076a20d3c@suse.de>
References: <f94151b4-893a-4758-a118-153076a20d3c@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the DRM_* logging macros used in gem helper files with the appropriate
ones specified in /include/drm/drm_print.h.

Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
---
Changes in v2:
    - Change drm_gem_objects_lookup() to take a drm_device* argument.
    - Make appropriate changes to all calls of drm_gem_objects_lookup().
---
 drivers/accel/rocket/rocket_job.c       |  4 ++--
 drivers/gpu/drm/drm_gem.c               | 12 +++++++-----
 drivers/gpu/drm/drm_gem_dma_helper.c    |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/v3d/v3d_submit.c        |  2 +-
 drivers/gpu/drm/vc4/vc4_gem.c           |  2 +-
 include/drm/drm_gem.h                   |  5 +++--
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 5d4afd692306..db7c50c9ab90 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -560,14 +560,14 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	if (ret)
 		goto out_cleanup_job;
 
-	ret = drm_gem_objects_lookup(file, u64_to_user_ptr(job->in_bo_handles),
+	ret = drm_gem_objects_lookup(dev, file, u64_to_user_ptr(job->in_bo_handles),
 				     job->in_bo_handle_count, &rjob->in_bos);
 	if (ret)
 		goto out_cleanup_job;
 
 	rjob->in_bo_count = job->in_bo_handle_count;
 
-	ret = drm_gem_objects_lookup(file, u64_to_user_ptr(job->out_bo_handles),
+	ret = drm_gem_objects_lookup(dev, file, u64_to_user_ptr(job->out_bo_handles),
 				     job->out_bo_handle_count, &rjob->out_bos);
 	if (ret)
 		goto out_cleanup_job;
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4a89b6acb6af..ee1e5ded6dd6 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -102,7 +102,7 @@ drm_gem_init(struct drm_device *dev)
 	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
 					  GFP_KERNEL);
 	if (!vma_offset_manager) {
-		DRM_ERROR("out of memory\n");
+		drm_err(dev, "out of memory\n");
 		return -ENOMEM;
 	}
 
@@ -764,6 +764,7 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
 
 /**
  * drm_gem_objects_lookup - look up GEM objects from an array of handles
+ * @dev: corresponding drm_device
  * @filp: DRM file private date
  * @bo_handles: user pointer to array of userspace handle
  * @count: size of handle array
@@ -780,8 +781,9 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
  * failure. 0 is returned on success.
  *
  */
-int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
-			   int count, struct drm_gem_object ***objs_out)
+int drm_gem_objects_lookup(struct drm_device *dev, struct drm_file *filp,
+			   void __user *bo_handles, int count,
+			   struct drm_gem_object ***objs_out)
 {
 	int ret;
 	u32 *handles;
@@ -805,7 +807,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
+		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
 		goto out;
 	}
 
@@ -858,7 +860,7 @@ long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
 
 	obj = drm_gem_object_lookup(filep, handle);
 	if (!obj) {
-		DRM_DEBUG("Failed to look up GEM BO %d\n", handle);
+		drm_dbg_core(NULL, "Failed to look up GEM BO %d\n", handle);
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
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 1ea6c509a5d5..3ffd9d5a9056 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -188,7 +188,7 @@ panfrost_lookup_bos(struct drm_device *dev,
 	if (!job->bo_count)
 		return 0;
 
-	ret = drm_gem_objects_lookup(file_priv,
+	ret = drm_gem_objects_lookup(dev, file_priv,
 				     (void __user *)(uintptr_t)args->bo_handles,
 				     job->bo_count, &job->bos);
 	if (ret)
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 5171ffe9012d..a3ac8e6a4a72 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -79,7 +79,7 @@ v3d_lookup_bos(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	return drm_gem_objects_lookup(file_priv,
+	return drm_gem_objects_lookup(dev, file_priv,
 				      (void __user *)(uintptr_t)bo_handles,
 				      job->bo_count, &job->bo);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 255e5817618e..6ce65611231b 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -692,7 +692,7 @@ vc4_cl_lookup_bos(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	ret = drm_gem_objects_lookup(file_priv, u64_to_user_ptr(args->bo_handles),
+	ret = drm_gem_objects_lookup(dev, file_priv, u64_to_user_ptr(args->bo_handles),
 				     exec->bo_count, &exec->bo);
 
 	if (ret)
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index d3a7b43e2c63..03cb03f46524 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -544,8 +544,9 @@ void drm_gem_unlock(struct drm_gem_object *obj);
 int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 
-int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
-			   int count, struct drm_gem_object ***objs_out);
+int drm_gem_objects_lookup(struct drm_device *dev, struct drm_file *filp,
+			   void __user *bo_handles, int count,
+			   struct drm_gem_object ***objs_out);
 struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
 long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout);
-- 
2.50.1


