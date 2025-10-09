Return-Path: <linux-kernel+bounces-847507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DDBCB0C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 282B34ED450
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D3283FCE;
	Thu,  9 Oct 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps0RmTM1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42107283FEA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048060; cv=none; b=p8S8rHo95FHGEy9FLgcL3O+WPmCTgA4DAY2gIystjN9hU93fxjYZfnr2RiboiZ/5+X7ATbOnULty1hgURJnS2Pu2l9ApnHNoaH1lF6e2l75hkhS6UIHagUo9Yy74ZLlngTWdRoZvA2pBrLhKu2LY1SNQ9TSbtMtNN9YdHqJLm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048060; c=relaxed/simple;
	bh=HDcLQ9jItgD9jx1XKHtGXKjYDLot5RODNSnCPekFFbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tb0oDscXj/ndPX6D4iz1hjruPhZE2lAuQOKePEv3vN69VaW1t3pQblba8AJBHr8qSbe2A56OVAmJlOAfNdW1z85DQ97rIHq1cHXLl8FPO7vyHWPf/DKnFuBWrXY7tSTZfTLVxs5MMugfz28jbfnR67O0nnl4xfxLOjf8zNVevJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps0RmTM1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4539dddd99so295057566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760048057; x=1760652857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+C1qgBpiLGQ9qb0EvZ/pqN9napeSCut88weJBHDFgWE=;
        b=Ps0RmTM14wbaEyLkVBn4QSwJ+qqFIzxsG996ygp6nTo7jgVz5yVdWKYLdRJMHQPe5i
         OgueF6eYI6tXZ3zkYdDs6I6c4yxwx/tFIGFROgT7KAxgUVC6leQM6iPHaDZNV0NqK68h
         EjshM1M4OUwffiA3CJb0jaqTjB12YnLbZK1L7kBgbI9iSnZ05XKHCKvCMVvYz5pV3LSP
         65vo8MWQjgmv1UItTcVc65mFyT74KkxazayZA26sRz2sR/K9NA7a0GYXuxTEEAq8GBfq
         HBXBuleNloRkWvbH+QHVD1i18ctcDXxwjmWq2FR8A4tHdYcBUU4P5rX+0Jbc6WCNmHXh
         BLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760048057; x=1760652857;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+C1qgBpiLGQ9qb0EvZ/pqN9napeSCut88weJBHDFgWE=;
        b=M7eyIfMUw8HZ7kfEfIAGWyUFRtjC24yq/MmMvNeMkc5OrFBP0RSn5u3ESOQbSJdcqQ
         DHuOQTB+CWqPZ0Zd/3rpblDHHaLbngk/015OB96CxCIEW2NM8x8m7rM3yun6Jg86n3gm
         Q7pViz9jeRW9dtbWhy/NRqrgrZUJNTcspI9AENq05y1fBFQhvW7DjJs8dHb/9UQ6JS4Y
         5VI/agEms0sT3ZHuMpTB9h3VBXmo7lamo1S6oT9VZGLIC7w/DhghZAutYe9HAuEwpUwA
         B5P/iCFa4tX2C4NiP8aI/p7t/dc9bE72kwW6qzmjXtY4+Gs3q2C+j8e1hVv1+TttBnfs
         AwGA==
X-Forwarded-Encrypted: i=1; AJvYcCUqODHNh7nTbF66u0yY4jnI+If86EzfDt58DCrv+ctKe4Tp65MWKZXu/mBOrwX/j7rBTDikPMaiHsOkQhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztvbE+FztPfpOw6VHgA1Lt/FTrTg67D4H8A5LOyfKyI5ugPLcM
	gJJ5Ogh+jo3niJnOlWHeisWowN8i43O5ZYvuscJyRIkZjYBgNesl86w=
X-Gm-Gg: ASbGncvLK1tT+k3AY4XnJAWmuiwRGhlHNhuRdNeL2kltEFDDr3JO3CJ39I7tjAKXEuT
	NgyrQDsQExBrUemx6WnEPx+rAD3th+S/zPRiqudU6EXZLighX7G4u/ANN5i5PJWAHycCm5tRxBN
	cEuhgHpTFGC0S7ymdfoX376Q3Q3tisJrgXE08pOe2HScw1yUHh0Lf3TYCapj0FMsoUbzVELEZvo
	yd5iqItKONsodmlY8UPIsM1T9Gd+tgkGMjwJnsrbQCZVCfJ41wHUfyLRpm9KpQl72mD5oFSMWn9
	RxTP6jbWc5UBXbhNyl5OQT1BKGi3mw8AZxnz7NwoahjrZEIFkCwCuIOVg3Lr1ojp68reOzxR6PB
	m6R56hRCh4jtkiV0nhxHasOakebniZCgwhBZE9/zPvswbqF6AYnL3G6yBSSC6Dxw+B51jIvH6IO
	SPK0+q+2NZl5JpjmuOhxRsRFAzRiCzjhbsxm6+zIOgHw==
X-Google-Smtp-Source: AGHT+IGJY2MnbndzBWS/Rpwtary79mPSlYcRrWBWKoF2nGdG3wTBAiynYZRbgnU4c2AkM1DSx73G6Q==
X-Received: by 2002:a17:907:60cb:b0:b3f:f6d:1da7 with SMTP id a640c23a62f3a-b50ac4c4085mr1073754066b.54.1760048057118;
        Thu, 09 Oct 2025 15:14:17 -0700 (PDT)
Received: from [192.168.1.17] (host-79-26-169-51.retail.telecomitalia.it. [79.26.169.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67c9b68sm69162366b.32.2025.10.09.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:14:16 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Fri, 10 Oct 2025 00:13:35 +0200
Subject: [PATCH] drm/msm: make sure last_fence is always updated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-close_fence_wait_fix-v1-1-fd3e394dcadd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI4z6GgC/x2MUQqAIBAFrxL7nbAKftRVIiTsWQuhoVFBdPekz
 xmYeaggCwr1zUMZpxRJsYJuG/LrFBcomSuTYWM1c6f8lgpcQPRw1ySHC3IrZmhvrNEAqKZ7RtX
 /dhjf9wOaWwlrZgAAAA==
X-Change-ID: 20251009-close_fence_wait_fix-00e1c2521eee
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760048055; l=1780;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=HDcLQ9jItgD9jx1XKHtGXKjYDLot5RODNSnCPekFFbU=;
 b=0XGlKf43ydVDbBU8ka57El68pwGM62R4dn0ImMJ8BTHLNe67KsNIpUaqhZjUzg1QMDFt7U5sG
 PjwlujPkoBdCnP5j5xX/9+hAc74gRAAO00sSJEmhoWgMgetUSoKT4Pd
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Make sure last_fence is updated in both the kernel managed vm path as
well as the vm-bind path.

This fixes a bug where last_fence is not waited on context close leading
to faults as resources are freed while in use.

Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
---
Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3ab3b27134f93b01236fec5833a18a6e2ad2cf5e..ae91a5614bf377985ff7875fc36baf174780a250 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -409,6 +409,10 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
 	struct msm_gem_vm *vm = to_msm_vm(submit->vm);
 	struct dma_fence *last_fence;
 
+	last_fence = vm->last_fence;
+	vm->last_fence = dma_fence_unwrap_merge(submit->user_fence, last_fence);
+	dma_fence_put(last_fence);
+
 	if (msm_context_is_vmbind(submit->queue->ctx)) {
 		drm_gpuvm_resv_add_fence(submit->vm, &submit->exec,
 					 submit->user_fence,
@@ -427,10 +431,6 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
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


