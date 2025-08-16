Return-Path: <linux-kernel+bounces-772135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32116B28F22
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457EBB62145
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002B2F60B7;
	Sat, 16 Aug 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAwvVAdX"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A552E3717
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357985; cv=none; b=XiWmLKyDdEbT6/O6tdXHHlWDXXi1EdrhmPBaEE6XHSKCFZSsTwKLTmw42P4kwERcWWSyv6rR26Su3emT/kYLJ+lGLCWpYJ3itZbTd6TozOeuNbCLlmGpK6EVu21pPd6Tzcr5oh4QFlU9Uw9bR4yCc5HpoAIZ5v99LCoAUW+HtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357985; c=relaxed/simple;
	bh=BfAvAFLlIpC3b2DyuXLmbkTf7L8vxGNdTxCkyuHNgwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=minW9ZgZef/9ARbwgvMkHfdNoHWjQmsBHQ+qLG1yhkCGr7JWBZIy0oCNF3tux1hQTKwL2EqF85ewArxv7lJinr+36KPKblRC2t5p1a0hIxC1ThXmWjIUKKCuPbEevQMJK3iOG7ECFV+nod13Ff2X3ui0CrqW1LVmkKyrPZG2zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAwvVAdX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2e614b84so2770694b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755357983; x=1755962783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mnxj9j4ujZHlmAKFH0J5lQUtJG4DrJODQ1fx+MjoZI=;
        b=mAwvVAdX5OKBNH8esU3kkwjJDKph/nQ+VZ2+bVQJrw7WMCEDx7Q6TP+nyTAjFnHBPF
         vDtK6HKt4bhdILktw0wO144aNdeqdHrzGkZS6yHdG86byhCAUs9iNt5HOmKcPU17vKVW
         6MebPbXQeCxxyOak1lssJB2oWozaZNVOzwsVVCA0u7oOwwyH0gVXtqHhlM8nybiCje1J
         DJaxhZyL+JvYO8MFobI10cu0SSaGXwdClHx2vsQ1tCWzElLYcz3jcNFPC3iPGeOzuRsR
         aR4ObjQO+KnlIXlVESyx/AN5/1el2RGNe88PsTSObf9+RuhYGZlS1pykAKdduLCKDerr
         HT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357983; x=1755962783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mnxj9j4ujZHlmAKFH0J5lQUtJG4DrJODQ1fx+MjoZI=;
        b=aF3CnWQS7FLaK3/la7SfIKlwm1F10UzHZ3qRmj9/WMxmboQ9JlCEVnBCGaKL9MCIMU
         RnaAPUb2k4BqybehMwLqeaHMFhhkT5cQj0IW9v77L8n7Hjmsvh4sl90eB5HZKjkQ41Zu
         ii0kKOmHCu1weM++ithD9FfC5IG4JRjcEkDRXyR7xC+EBfxd5HfftbUvlf6hViveSSkc
         yCiUfsESFKObKG1WEOjnFmYNeS3113c6BKpJWpGzhi4S9D3E72kXH4d5ULSJho3mBzG0
         6efeHFn9vtAg4RjF0cLydkOcCe67+qSI0k7Z97IyFj6g6lLDzwL+COhfA9bFTy+0p3sX
         ReUg==
X-Forwarded-Encrypted: i=1; AJvYcCVbY0hksp5JU9CmW+YdFIbpG/9+zaLovgKl41ynAQocXBOhZ7A0nsQCWefzLLpNFvyLhsXDJQi9GOZbpxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXX/OuSC1TpJQ32mUCv1ofPgtNETpn1MQ0yGOOuMz1sm9j3wQE
	JPjv4ype++sxcWwIEFRY2PzZPkeSUVSck16IVPOtYfhxSvLnNZcWMA59
X-Gm-Gg: ASbGncubVWxBr0LUj7d1fksQsYHYAnzwEa9o7flRwA/e7N56Hkz+gBSS4B0uQhKGN3L
	8EtStzQU4rjVrEenFzfP1b9l37lDJ8i6Esd9X9d3ti5+psEAdimJovSAjKkUdCvkpwOwt0aRnYV
	OAibw6FVM4pX+I5KdDkNUvTrXwbBjklX5g4ClHfCeZfGWvcBkeY6gGievW3AekF0BZ3/gXfVrL+
	6dhYoVsPYrTsIoKUvx/ahHNkhdRfqk+JeHUdRswiblr+JpccLQ4fpYxRBX9EIw9dbA/KEqLy07I
	FI7MI7TK/NcBu1woWF65X+Dzph/jzoAb91KhSi2q96jVqwWKutzrjG3yZm9B+Nm2ri3l9X1W6yw
	le0oS4Rey1Tr09Zhqm/s=
X-Google-Smtp-Source: AGHT+IFw/4392JeGo+4oIC6CNMmWWYGFfVUHQ0o5Vvd3MPIQwmDgr00+svvnyoZjozRFHuSkH1e3Gw==
X-Received: by 2002:a17:902:f64d:b0:243:17f:b767 with SMTP id d9443c01a7336-2446d75ce15mr85010495ad.25.1755357983551;
        Sat, 16 Aug 2025 08:26:23 -0700 (PDT)
Received: from Terra ([2001:df0:b240:417c:391a:2d23:2970:dee9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb09ff8sm37861245ad.50.2025.08.16.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:26:23 -0700 (PDT)
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	skhan@linuxfoundation.org
Cc: Athul Raj Kollareth <krathul3152@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm: Replace the deprecated logging functions in drm_gem* files
Date: Sat, 16 Aug 2025 20:56:02 +0530
Message-ID: <20250816152604.14667-1-krathul3152@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated logging functions used in drm_gem* helper files
with their appropriate ones specified in drm_print.h.

Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
---
 drivers/gpu/drm/drm_gem.c            | 4 ++--
 drivers/gpu/drm/drm_gem_dma_helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4a89b6acb6af..91f528d8900f 100644
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
 
@@ -805,7 +805,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 
 	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
 		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
+		drm_dbg_core(NULL, "Failed to copy in GEM handles\n");
 		goto out;
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


