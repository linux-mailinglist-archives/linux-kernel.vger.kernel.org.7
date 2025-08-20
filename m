Return-Path: <linux-kernel+bounces-778055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F319B2E0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4221BA3361
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235225742C;
	Wed, 20 Aug 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9XT9FFn"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1633EAFA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702567; cv=none; b=G21w5eziX0SSCxBrsiZQd7XObs/EV7rauGAJzGxf6DqPUaMWVTIM3ahzqt2lbyZ1T9+Ym8mdR239wVi+EMNW4c2Eaab68nxMb2K7ZQY+0fNTqY4ONphPCZj57VV/4MOHce7r5xHm21DX/oOsBhQQcps8Vmr2D8mzbjID4UXAkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702567; c=relaxed/simple;
	bh=OSjYCM+QZePSiWEWA+QZ0XnfyYn14Pe1yajip1omtRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLU6/QKGYIBGVV8Ukt1uCWNYo8i366RiCtigqtqHyvySHvyI4QxlrK9t6rhIFl8go3GxQLYVzXnvbgb4EykYyO3bj8aC+QLGTqq9FkfKtdgkrGe4as4ZARTYz0ibRhn8UOUhCgH7amclJsAc2SVS1wY65Wv3OWN+sKM370E8lzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9XT9FFn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445818eb6eso49693405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755702565; x=1756307365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSgIm4/H7Yu+PP0A4Akgz8hg8ykeT23+87+VAQDW1aE=;
        b=D9XT9FFnpPryNJQkZDWDfGzkYOtOOGG8aM2XrAEuooCUbBdUJFsJaX9/D/TRMa69ho
         BBpH8YMl+TC5HqitObEhZiduJBCUAtwEfPTb4X/GI6jzirpO2/pvJOKXrSfaEk03y7AS
         2dsBefHLyDgFy3/LoxPWPbqvy9vCsQhVDJzkOy+hNvn0KlQVoHJVyMr4DlymROTYLM2K
         jqPI2gFP5kMUmm1YEs9E/Kvdh8V4WubbEE5ttq9V4JFwiOJOoLoXGOz5xrvjkzOmjaGw
         SuVb9aM8zO7U/2ET7hRHSbvUca7IwRerurdfwvAJFuo4EYhIWlv3A0NWAESbnA3QCnqo
         dR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702565; x=1756307365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSgIm4/H7Yu+PP0A4Akgz8hg8ykeT23+87+VAQDW1aE=;
        b=hDGK1w1fciOXYFsGsE0AtH+3bVmt6y6CnJWUu6W+FBxYAWcjohvPl7xhtZHu+mCETB
         kwznB6dolNg9g689g8VZ4Ey82wHEsUyfFA4JbCAoQcR1v8do7rdIoOc/gf+Aq7xyog/s
         qSw9Oiamk+pvbtp1f0pAU2NMi++df53AYQ8TkIIhimRImTP2vxA/6BAtov7/RkC2pk+M
         OYJymPov55jfkK6h+7r/4OX/TDjnzii6noq4+TpzMCkhwdwEaEKbLUUXcHkSKGxcTF9c
         pvIuemQ8s5BtjeNrsE02IML6ne70yqQreIYzbc09nYUWpgPGugiiPuTPNDyFm/KXTdou
         CD/g==
X-Forwarded-Encrypted: i=1; AJvYcCUd7q+xgJYrPico9xajS3WemELoNSumCQ9dir+l3uxcaOP+FkwTZb+2Bga76k6ZDT1Itx2EVbnqohcYLRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydU2H5tLprv23S0fPHpVOSYHE2XYUUwggnK3xtm+4Nj4uWVMTW
	NNb6H8a1hkeK0H6l8/vDwr4fOGJLF3wmEmAHCyB66760C3v2pxWUtgac
X-Gm-Gg: ASbGncu0aiq3dR94werQDfJggLzQqpd3zrMMlS/11lApMnQOsbhWSdVdoBJVKECcb/n
	vSN++G4+iU3SGj4C0dBLPDqZREiLoL12f7MPphR8d1D29lOHQ1jxriZ2PfPq2JVFwDVi77sPApf
	W3QXQCSvbjI9xeF6YCe9JrX7f97C3TESByREOYNN/rMGBWvlouZOiHiNvIy2SgcCiuIB/jAMdzq
	av4IA9DpZ/dvjRIOAOcDbcgnCzyK/9O0kw3h9WpNHWvX7UFdvK4598mIT3+oR1yI3D/xAenpjQU
	REO/PI9oy7BeuIa07JfN9++hIgqGorqDct+JCBsJrl7HT6bmpI5w/9LtORKRXM3S9XUzicEqrO5
	RjwBLan7i+2SDvNdPsQ==
X-Google-Smtp-Source: AGHT+IFeesZgKogpEkYmKt7j1jigdbSSubJrkxWpbElJ8Gev87fyWh8qORnnDmjou3DFP1PVwDj13g==
X-Received: by 2002:a17:902:ce83:b0:243:3da:17bb with SMTP id d9443c01a7336-245ef228930mr46362245ad.32.1755702564482;
        Wed, 20 Aug 2025 08:09:24 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7494sm29526165ad.99.2025.08.20.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:09:24 -0700 (PDT)
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: michal.wajdeczko@intel.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	krathul3152@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	skhan@linuxfoundation.org,
	tzimmermann@suse.de
Subject: [PATCH v4] drm: Replace the deprecated DRM_* logging macros in gem helper files
Date: Wed, 20 Aug 2025 20:34:25 +0530
Message-ID: <20250820150829.4312-2-krathul3152@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a5d58430-1ae7-4b7e-8275-dad09a5c8cae@intel.com>
References: <a5d58430-1ae7-4b7e-8275-dad09a5c8cae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the DRM_* logging macros used in gem helper files with the
appropriate ones specified in /include/drm/drm_print.h.

Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
---
Changes in v4:
    - Some codestyle corrections.
    - Remove OOM error logging in drm_gem_init().

Changes in v3:
    - Revert all changes to drm_gem_objects_lookup()
    - Use drm_device as suggested in the discussion [1]. 

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
2.50.1


