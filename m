Return-Path: <linux-kernel+bounces-830534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D25B99ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E6A3A74DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A182FDC2C;
	Wed, 24 Sep 2025 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbaU+AjR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417521CA84
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718139; cv=none; b=m5x/biL2giG8v3WVac+HyEY2ZGvT3DIMfS42WEUOSL+7nYT7gt57GGV+ZcFrV5EiaVjqplBYcvyYRz+Nsfx/S9IOald70zewUoegKcIZjTUeoA1iVpiQAkm1lvJ+xECVQA1yAwsYchxY6tbQOO3r4s1CktWP9iUt6wL9OcJF3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718139; c=relaxed/simple;
	bh=/oGFj5yDl52VwtbI9NgtZJZkkt/CMZMsg9opZuMOGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVmW6i3XYnMjXVkKko8Hrf5oNv2pCroYxGc+E7GQyKFCFlgSx/P312YyzZVEXNIsmCrVXS5h9FbWuD1CEvPch/HWf5H8WgmFUg+XL9gBhgMaEt6h38DAwCB/qVCOHPKITeTD8w4NZkp1XZ9LDKV7W8n57PACMjXdz42Lo5vhbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbaU+AjR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso4047115e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758718136; x=1759322936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7JhEQyLJ4tStQZeMjbdNTURPvFyv2MDrZVanIpjsKA=;
        b=fbaU+AjRaCJpOoCh6YFfhsUzE3KROTu3gljtkJrsQVSDVKK1YJlIjL0j5X6hWNXUjC
         IJOjOR4mytR8MyahhRk96704uhL8PixEm7E8au61cvix/eMQUP0zR9XNhK8UJCXPh7iP
         FR35DXfXWZGRS/1UpSs+jNcDO9rSPsRDRfWHBLweEyX2IGFU3EOvaVgRECg6GgHKCfFx
         fXqZLag3abK+FInr3fALn4DN3n/hiOLnCmKne3ycWM/WB5UU+qNOwt67EHwOnsGA3tFq
         HMFn39V08hp+yRQse3OCQKNpi4iUvZXkkQ+I3pJ2Xg3KZp2Xq/+5uAs/oZ9J4z6OnOJl
         r2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718136; x=1759322936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7JhEQyLJ4tStQZeMjbdNTURPvFyv2MDrZVanIpjsKA=;
        b=walmRtJ4pr8rX6wPAXGPZYO8IvaqCHo4l2LoLzRnA/B5pLW/evE9yrIpD4KXncNO/M
         5B4yk6U3hykwe50wxDTVdBJvnB814KYqWPYas/ptSsSp4EHIAPT9SLmjKmR1U9zJ1xiN
         /AaP4TzXRQAXOc292JRXQhpEifFeghCKOBmQ6tcy7nrRYwDY9t/2O92SBxTC/p4tvmb/
         vJ4DU4EYaaXHRlPFhpNvLbFFEqC6r+QcSQzfdhD6WsyioJpPJRDz22If64b2tChwholC
         vnaLKk9sN7udokbCGrg06Ug/65EyNVnnSXLKd/gLl0BIZ5o4IhOKUftzmAm2BKYlkEdj
         9AUA==
X-Forwarded-Encrypted: i=1; AJvYcCULVVIIQIHzK9f35IAZyHONDnT+SfnwUSQlrEsv3RqR7FLQ1283G2TiqpGzp6VOTzBigls2BIaY6sF0LpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQCWUjkOfYlEb4YhsPEES12dG0XdmppSMuxWk7Z60J4l0im1b
	pgx64fAd17UaHj+N6KUX9kFD3JMvQEFqxV1l1jvEXU0Q6jXEVmRnM1Ov
X-Gm-Gg: ASbGncvkZeBb+f0CtQVi7YICi9CoH4ddq1HxsjxyfxQmRx+h1u5JML3gatk4OOMqsMS
	GXWMUCRioXOK26kjHbMPK8O8HLhAC8CvYfxjwzed0J3DLqkWmn3rr9ODyNQI713/g02ffCzduyT
	XsBUGYOhzWh6M+TBPHDwUsLtkdWwMvSsrBD275IYnLTpQDei2DGVe7sZmtGFAJf5i/Q2Dl/qfID
	fE44uOCzpyzWA+HW/Os55x1VTUCRRa6XEScI42u5SG5JYstyWK6hkTKaNr9Z5S8WPMEH9VGwK8K
	yqZjJp/QgNHSJW6LBzCZvnh1bG23PDP+MmZckmeov6Ojia0EeN/2VS7wk4PYPB6bean/QHlZvDK
	IGqRyFqr+hca2DaRs8cVHlIsz6MJUKGWcTGe+g3DCPhfS4kTiSyrytDOCwfl+7EbfF3kgBf5phM
	kCAMjnJbYuOtXB+bYi
X-Google-Smtp-Source: AGHT+IGsCjQ5kbJbHGIPwqnOsa+Tesxxo/+eEFeOI/jBB9wKGApdlCpF0dLkSsx1lqdtZ8hj+A5qAQ==
X-Received: by 2002:a05:6512:3b88:b0:55f:595f:9a31 with SMTP id 2adb3069b0e04-580745c448dmr2342043e87.51.1758718136145;
        Wed, 24 Sep 2025 05:48:56 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9668090sm5052943e87.109.2025.09.24.05.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:48:55 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnkiov <alsp705@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] gpu: i915: fix error return in mmap_offset_attach()
Date: Wed, 24 Sep 2025 15:48:50 +0300
Message-ID: <20250924124852.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return value of function drm_vma_node_allow_once(), 
called at i915_gem_mman.c:672, is not checked.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 75f5b0e871ef..eb76f8f2bd95 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -758,8 +758,11 @@ mmap_offset_attach(struct drm_i915_gem_object *obj,
 	mmo = insert_mmo(obj, mmo);
 	GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
 out:
-	if (file)
-		drm_vma_node_allow_once(&mmo->vma_node, file);
+	if (file) {
+		err = drm_vma_node_allow_once(&mmo->vma_node, file);
+		if (err)
+			goto err;
+	}
 	return mmo;
 
 err:
-- 
2.43.0

