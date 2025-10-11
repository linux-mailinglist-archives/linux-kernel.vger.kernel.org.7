Return-Path: <linux-kernel+bounces-849180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8BEBCF5D2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060F13AEAD2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B033A1B5;
	Sat, 11 Oct 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIVrydn9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563D14C5B0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190344; cv=none; b=DlkXg5HwQO7C7Rg2YDbV1jHENuBhhUQ+zQcd+qoKFjDEivHKPujtdJWGRzPqNZg1ZisZUQGzH6lUE4hmwUghVJBSwTQ1hiUZrLq1NotM7SaytYLWJq3V/4CexN5s05SxR5QE8XEygtFxJAIJIz4n7TJv0WE07rR/E6RI54ExySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190344; c=relaxed/simple;
	bh=iFYvEtWlC7xxF1kiaqDFQ3ELFe/iyBZgt0MDdURh88Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oeFWOq/NdmytPWvoShR9jXz/WKVj9fnz5l4fD6ZlhVtyc25UL9p8GoypoGYO1E636TzTOTSmWvk/226znJouksjg+tO/iyON2y3RsfW0hmm7VEprhHPMHWbokw70FDBCtTqdAHIqSa9+fMUMk/XYhs/Z4KrVB3M5GV2Thxez49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIVrydn9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b41870fef44so536171566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760190341; x=1760795141; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSN6YJly2uz/i5kBQYAcGqHNw257xKcldfsRLDm9KbU=;
        b=gIVrydn9Vp8rdlikttMQZ/VHAVdeC374TJBpNu47lZtIwZ/8U1YHoROeRId83IM0XV
         LTeiLNBPF5hT9qJJzKfZbZboG3BBNxqC4XmDHk/ck3I1/oMVf80jbYdnukdG2ZOq3ymq
         8l/QUY1CeTnHhBVySOvStNmCjx6JZo39Pxv+hQmeBHHnWb/npw88EfGVkpZ9ZLSBOwM5
         E4wBaARJ18jFMBo0L/Rd217SaAGWyCv6B/UrTJkllWLwltJKveGyd31uc22beSFrcL8g
         R4iVFLTdUtVH5a4gCworf/7nMvvxfsRyUWhWNeCskLZHzolRktg4Tkw97zi54as7WdeD
         p1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760190341; x=1760795141;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSN6YJly2uz/i5kBQYAcGqHNw257xKcldfsRLDm9KbU=;
        b=qCArx87bf938RMC9Tei0VHKlvOJucB6IR6Z0O5jUHOZc8+yUnFc1/o+FXikXSLkoK/
         SDbnIKAeHslnccjGFp5PGDIV2c5aSWrTYDqhO8+Og9XnWuoewvGE38trZqTyFVrmalUJ
         eI9Y/9acOoytfnQ7tAb3lCoiGLPYgKdeCePgB5O38+SnxcnShP8EsIwz0QZcHIpSgcBC
         p0lQocsbVg0H15tbj5MZPCmgmnDRLI/s+MtqjYrBAdSDpI2TX6a2qWocVO2wWTEpWB53
         wrTN2He+1MHu4mEXIVSJ2CWkYlMFVfH+1ytm3T3PK3Az1NXDOAVZ9Hly+eKz2eM9eRyv
         50sA==
X-Forwarded-Encrypted: i=1; AJvYcCUcFBUtdY08xhW/oE92QEvisL5dR9wVSS/owe8q5cH8VHsHCUKuHY5obrFqXAwbVMNBoXnum5gHJj4P98g=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHK5bfIT2N6mTHQcbJOwtMZVPSFqtoi395+BGrltYmdvSmMsw
	Qa+A9ldcR3jXKsGt3fyeVxCsVHyN8wMqrhDykgU1slSIgUU+NVYR8Og=
X-Gm-Gg: ASbGncs5zw7FWnsKBVvCmUBrrs40NVD+MlPojYsxzSvkZxBv0qzjyban3rRDsN6LcLS
	VSdL34S/pDybaClVYn5y/eCYSF5fIDszrmyGJe57+LrAx3MlZFNGMAF8rdRjltCJsgi+u50B87w
	S0calJOTCKxCCGvF9fMsF7hEqQSvGVuPL36AWDBBzMhfxsKXKsxhlNHD7OANC2yn3e3o4QCE1kl
	ulL0XZUi2ALIb9QpVcoRF2on8yB+w75T2f/RVsVQdCPsNbya9tOC7vEb3VMlPTPHV61kl+5tIB+
	wJmVystRfci5g4nvnuRCGnJEmlhbVsgf5AZSqMnp+j9rE5sKE6d1tn4l+ddbNcDRWYBu+rwYaH8
	a94ZQeBBJewyG6r9ygywjagdCfT8FFzaA4BX3VjPePe+LRN9Dlm8Qhnu8STBwuUu7NNPMgaYGHr
	luONDohy5F4sp8r5Yjb+HsrGM6Drx3P4nLQavqrbY=
X-Google-Smtp-Source: AGHT+IFxwNevxZuakuH1AwVGVUxgynpTEfjH50O/959om/vjv//gOoU0pSJRYKc+s8OpRyguD6wedQ==
X-Received: by 2002:a17:907:3e05:b0:b33:671:8a58 with SMTP id a640c23a62f3a-b50ac0cb5dcmr1592525966b.37.1760190340665;
        Sat, 11 Oct 2025 06:45:40 -0700 (PDT)
Received: from [192.168.1.17] (host-87-19-169-144.retail.telecomitalia.it. [87.19.169.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61ccb09sm470963166b.19.2025.10.11.06.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 06:45:40 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sat, 11 Oct 2025 15:45:10 +0200
Subject: [PATCH v3] drm/msm: make sure last_fence is always updated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-close_fence_wait_fix-v3-1-5134787755ff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGVf6mgC/43NQQrCMBCF4auUrI1kEivUlfcQKWkyaQfapiQlK
 qV3Ny0uXLhw+T+YbxYWMRBGdikWFjBRJD/mUIeCmU6PLXKyuZkUsgQhKm56H7F2OBqsH5rm2tG
 TC4FgZCkBEVk+nQLmeWdv99wdxdmH1/4lwbZ+QBC/wQQcuLMKVXWyRlt7bQdN/dH4gW1gkv8gM
 iPaNkpJ2zh3Lr+RdV3fF0yhQ/0AAAA=
X-Change-ID: 20251009-close_fence_wait_fix-00e1c2521eee
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760190339; l=2066;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=iFYvEtWlC7xxF1kiaqDFQ3ELFe/iyBZgt0MDdURh88Y=;
 b=0JggH6t/TIHGmWfFVBv+owfEoMyqVT7mhRAb3nxyr2ha5tqUUZN4EesSAzkWYqalqgfHTvUq8
 DGbonyZztQrCEgdQZF7aL8H5sjt6yJwRvyVXi4tzO0dhOQpo283VE+a
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Update last_fence in the vm-bind path instead of kernel managed path.

last_fence is used to wait for work to finish in vm_bind contexts but not
used for kernel managed contexts.

This fixes a bug where last_fence is not waited on context close leading
to faults as resources are freed while in use.

Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Changes in v3:
- Fixed Signed-off-by tag
- Link to v2: https://lore.kernel.org/r/20251010-close_fence_wait_fix-v2-1-adb332dbff65@gmail.com

Changes in v2:
- Only update last_fence on vm_bind path
- Link to v1: https://lore.kernel.org/r/20251010-close_fence_wait_fix-v1-1-fd3e394dcadd@gmail.com
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3ab3b27134f93b01236fec5833a18a6e2ad2cf5e..75d9f357437006ff261db148901e176eae670d41 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -414,6 +414,11 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
 					 submit->user_fence,
 					 DMA_RESV_USAGE_BOOKKEEP,
 					 DMA_RESV_USAGE_BOOKKEEP);
+
+		last_fence = vm->last_fence;
+		vm->last_fence = dma_fence_unwrap_merge(submit->user_fence, last_fence);
+		dma_fence_put(last_fence);
+
 		return;
 	}
 
@@ -427,10 +432,6 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
 			dma_resv_add_fence(obj->resv, submit->user_fence,
 					   DMA_RESV_USAGE_READ);
 	}
-
-	last_fence = vm->last_fence;
-	vm->last_fence = dma_fence_unwrap_merge(submit->user_fence, last_fence);
-	dma_fence_put(last_fence);
 }
 
 static int submit_bo(struct msm_gem_submit *submit, uint32_t idx,

---
base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
change-id: 20251009-close_fence_wait_fix-00e1c2521eee

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


