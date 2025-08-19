Return-Path: <linux-kernel+bounces-775671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB650B2C376
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54BD3A8005
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38933A017;
	Tue, 19 Aug 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNETah00"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4333EAE3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605848; cv=none; b=BJFVHOspUIxR8aeifW9D1grCJ3jjkq6UEHF6GhQFfK3PeSgDUPqTGcTzEhkGw+LhfbsBKX+lpoq0dxrRx7z1n2fXDrww3dKIcFZ3N2TLkPx6ogDAxZ8g1KSnku7ogr7jzETNHZ9hHDFSpFWWJA7CHDoHwziPRnTrrjOCmdVDTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605848; c=relaxed/simple;
	bh=c6SJfBR+/GbWNLnYTC3q9NWv7hrRufqAdO/HZR4VMuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEXlY0BMJMZVWb2zyLwanwgrkmFoQwISlxyx69i/9qYqSQojbMNWfkWmb95xABSyiGtkOsDcns647JThYi+0bpib+gntv4eALwdSoezrOVoyWe4bik6bBDq2D6x4QNDvOwPNblsRnaX/SxyDozNxxIOkEtj78Gx5e+tCOiQ2EjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNETah00; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-244582738b5so41340865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755605847; x=1756210647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWV0vVeINjxfROFedsb1z6gg/iy2s16vpsTiJJvBM0c=;
        b=MNETah00SuYZkWCldteYc2ZB22HGBx4M2zivbXHChIbhKqcB7Kr41FEUa7WjF0gjBi
         pwyo2mymGlTXmjaW2MRet8EckdRDYwS1Yewr7FYebBOl5QMb+rvR9Pgjw0owYuVH3lEr
         gEveWcQQ2XJmKY8MPMjsU9UUjpXn/Pl7+V8eNFRPcOZlYw71OMSg5UleIaECsaSkbx9e
         WgW5JZaJAYc2zoM3yznFWtc1C+G/d0nucot8uwPCTjr2wcM7AqgMX6yzl4gRTQR1F7N9
         3nxaA3hj6DQVDbmdbxqHJeQdoTAcWZ7ThWlTq1puDNDM/OiWLpUDJtTvuI/uQT7+LCLo
         DzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605847; x=1756210647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWV0vVeINjxfROFedsb1z6gg/iy2s16vpsTiJJvBM0c=;
        b=JEVyLuprK2IkG7BrgPcIf94NlGGerOuPzEgLfD65IPb2tuEnEzIoqzyg0JUrtf8wCa
         WPgTDjh5pUp0q8C1oHnXZx2LvAktj6MHDyV63AQ0E8iMqn4ODrwJmcAQ9P4h/Hzb3VmQ
         /zpgaG59lZ8MbMlHdkAlxkN7giT3rSiWZck0mzBT/SzDXYaao1bH8gNKy/JYJwkYHFw2
         0osqZx+waBK9hHsux/FmRwggmJJCh1OER+dcS6+VCWqmdRPILj+CIMXmdtQ3EaOmzRBx
         OsACoLZj5FEYXQ5PVKGK68z0F6LObanU0lzvu0ajXkapWwvmnoKvTr9D/GfPt3jsJsB/
         FknA==
X-Forwarded-Encrypted: i=1; AJvYcCWRjHoTw2QwB5C0RLKdI5bEBtY28eI+wOVM5mCwdhq/awhQMUNxLFxWm6lNdMlVc8putDbkCEAbPgCuD9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCJ8MMHgi/Wh8kZNyie5P1QZ4CCK6PtGmjwg+ObAkwQP9JoVv
	RPkKwwmBCSjD8x71Eod2izDN9keTwPb14Zk2LddpRuEkZKwGJtqaEryP
X-Gm-Gg: ASbGncttjSlVZJ0xm8igbAvKIe68vhV4zSGi3UvFb8DHgTKMrVkKt6nS1M04PXZLDBk
	XHQ3DuBlRRi73s0pq02RmsEE8YXBhLHSa52Iu983+1nRDfv7iDJstMrs4nCUNNA9PIdufNUF9AR
	pDYjr/dkVwACE/ybVzJLIzX1Ix5s3iyP1aJZrf4mb91rtzQAe4y+IDwJiz9cc1nPFJnowr3D9QN
	je1dfDt7frrIQ+5ST6/ckHPkrNARBIlFf3OgLtSEadRPVYR5gCOnPfFgmbiCD+xIEbVx3Zqz5v7
	r8D+K3mVLk5bSdqBSQAKmG8rrVhcikOOXjHI/rwQOy7rh+pEljNXFjlNGUbmZ/OU/j/Qqt/PpT4
	UhX6f9qP9mr5oTfUpmA==
X-Google-Smtp-Source: AGHT+IF4qxL0U9vpZ0HxdELT3VX2+7tfvAlLdXWTxv3BAaxYCg97WMvRMcDAIOayDSjp3fkucWBHtw==
X-Received: by 2002:a17:903:b0d:b0:244:99aa:5484 with SMTP id d9443c01a7336-245e04704dfmr33200635ad.33.1755605846818;
        Tue, 19 Aug 2025 05:17:26 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ef54sm108352705ad.26.2025.08.19.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:17:26 -0700 (PDT)
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: michal.wajdeczko@intel.com,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	krathul3152@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	skhan@linuxfoundation.org
Subject: [PATCH v3] drm: Replace the deprecated DRM_* logging macros in gem helper files
Date: Tue, 19 Aug 2025 17:41:03 +0530
Message-ID: <20250819121517.46998-2-krathul3152@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com>
References: <90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com>
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
Changes in v3:
    - Revert all changes to drm_gem_objects_lookup()
    - Use drm_device as suggested in [1]. 
Changes in v2:
    - Change drm_gem_objects_lookup() to take a drm_device* argument.
    - Make appropriate changes to all calls of drm_gem_objects_lookup().

[1]
https://lore.kernel.org/dri-devel/90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com
---
 drivers/gpu/drm/drm_gem.c            | 10 +++++++---
 drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4a89b6acb6af..fbea8c50f17c 100644
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
 
@@ -787,6 +787,8 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 	u32 *handles;
 	struct drm_gem_object **objs;
 
+	struct drm_device *dev = filp->minor->dev;
+
 	if (!count)
 		return 0;
 
@@ -805,7 +807,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
+		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
 		goto out;
 	}
 
@@ -856,9 +858,11 @@ long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
 	long ret;
 	struct drm_gem_object *obj;
 
+	struct drm_device *dev = filep->minor->dev;
+
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


