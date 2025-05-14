Return-Path: <linux-kernel+bounces-648130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48994AB7229
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546207B1915
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4D28003F;
	Wed, 14 May 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5nQb6o6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B000221DA8;
	Wed, 14 May 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242193; cv=none; b=aoJbnBnukVg4+zF/rw9abjNIVGnYxvXdauHpcWqA2cT2NEnPWfTNMSW1AG6ldl3sd/NBd6mbhQurK4OI7hLblJOryI2qLzz2Gpy4zeEu3kXtA2Ra+48564x/fVB4TPFOA9//3ThD9KzzSQOsZM2fCkAgQbqvt911MztJToc2GqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242193; c=relaxed/simple;
	bh=388Q4Y2vXw/88ABph+aL+8fVavpaQXXIqL0c5ylbmAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah+cipTcu2atdOHOMbR4l0fc7OjOBR0IoeUysqK0f71oyh6uP730r2E1+xW1zV6lqCmNp0RcTi0wPFpOgZKPydvMBvJR+Nr99GpNcxZ/VkeeRy7+/OuOc5NB4UZnecBdYgQ/3mrsDV51O3yR12nJsBaWeIfdb/GPGS2vk2v+J5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5nQb6o6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso114064b3a.2;
        Wed, 14 May 2025 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747242192; x=1747846992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pxupw0mnheBn4UC0J0PHtfsiWVwGvSizaV6fVHNumo=;
        b=e5nQb6o6yIfk3wFXm1Ma1xynhpmF9hrIE5GeVDpVss/g+PG5q335FXr/0Yd6+cMtGa
         mCC8W68MhstcbSHLVB7DBW2sLOXWJOI7615UQtonxXONAGjpokL0rz3HCOLIVPXac0T3
         jxZMKyTE2yfrsTslzuRldfnhrCmblitXvRHyfF+nRlkzM/J39iFxp3OmJUOQaU9eDNZI
         DcKBGhBC82vrI3lm7cB7MuTyyGNo6sxTl/L5Of9qkHtoVxg5LBSKIjhrTRkFgjkZ1iR8
         h1ccIk9tz3GUDeeQUCPNScqQIHAH1FErtPeshcagiZBon6dcMebpezCTgJl37XLm00Kx
         c+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747242192; x=1747846992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pxupw0mnheBn4UC0J0PHtfsiWVwGvSizaV6fVHNumo=;
        b=VFYD3j9mCzTx47jH5+3NgUZK8Rc0AY05tlnRdAonFnU/21Z53A2B+1E3u4iyRl/E2O
         NMZgfY0Uulfpj3kQk3movLVrbhkuOWqtyg0CzWMr47XT6hkyI0mXsxDdMslKXoUYC6G7
         EzAaVd2lxJABtJPaXM0ue6dVNNa2yRuEA3f1mUK820yVzk9RKkc0nFSjeR4YYeSX+p8e
         iTTRcdEH8LXG7RIaw+GM4Ojqpp1zbKmdFLuWXN6vOdTkWxI9HMpvDWzAxnpWMvA4cB4H
         w9k5w6mwNqr5/6Siy+sbeVK8fuFIIhw4URf87+MASSe1kniFaQX0SVbvM5fSUEcLAdzX
         zpSw==
X-Forwarded-Encrypted: i=1; AJvYcCV2CzaTWwDR0SPcQPdu+x/3DHKDNZjbVXsxpl+oBl5pqpwvqg+oAdU63sfF8p+/lPzWECIBISA9TjVw2F7K@vger.kernel.org, AJvYcCVYoDjcHmf8d/ZW4mlCB05IXaXvnJYtP/7pOEXhysIdAmgT/+Gexl7HrCO5mlwmALG3qaFTi+d15nqBbWCY@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQH2UAwZuZVpgs3/OqSGvLZc3/PVJtz8OfFh4WoiIo/FU2rW2
	Bhc9fV2FzfOnf5zLv11jt0Yt7tHLGSCstfgW3DyDDAIrKKIK7vQ8
X-Gm-Gg: ASbGncv4eVswOAGq7QUWb3is2kD4r3uTNFPRB9CMwSaFc/V2q95qcPCEWSnTIhB7lrH
	C/mocbuO2240+Nm/XR10mb0tC3J8ErNtsMzWx9JdaShzON4i/JpLuYkqGGYiQAvd9IKdtg/F/CC
	bNOLRKHJJQUG10AoAXV4PNmBz1QTzoZwJQVggWxx4enjtmBQHGU3JB+ouu1fyF8gHKAz1UBPUrQ
	2OxKHGuXRTYdRFVxBXNaWUfVQ1XlM2QLh59EaDuD4WLs5OHlAHrvfq28DzdYW1w/ZVdWfSBoyHH
	PEwXVzSlbDC2Qs1MzRHVLxWEaoKreMPqxVTSpYGQ2NNMoWNHR0Z9tm20WQS1trgNVtC3eMDulOg
	3kHUd+5zXfTpacl8APR2ggBS4tOYuqIdmJ6F2
X-Google-Smtp-Source: AGHT+IEenEE0TDJYGjpoad0MaXzpg4coPrwhIFddIk4z7RGaH0tq5EifEZh9tMcraEV0o9p+MEDF5g==
X-Received: by 2002:a05:6a00:91d6:b0:742:95a3:b000 with SMTP id d2e1a72fcca58-74295a3b144mr559866b3a.17.1747242191636;
        Wed, 14 May 2025 10:03:11 -0700 (PDT)
Received: from localhost ([2a00:79e0:3e00:2601:3afc:446b:f0df:eadc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a10608sm10022046b3a.101.2025.05.14.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:03:10 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/40] drm/gpuvm: Don't require obj lock in destructor path
Date: Wed, 14 May 2025 09:59:00 -0700
Message-ID: <20250514170118.40555-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514170118.40555-1-robdclark@gmail.com>
References: <20250514170118.40555-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

See commit a414fe3a2129 ("drm/msm/gem: Drop obj lock in
msm_gem_free_object()") for justification.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_gpuvm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index f9eb56f24bef..1e89a98caad4 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1511,7 +1511,9 @@ drm_gpuvm_bo_destroy(struct kref *kref)
 	drm_gpuvm_bo_list_del(vm_bo, extobj, lock);
 	drm_gpuvm_bo_list_del(vm_bo, evict, lock);
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	if (kref_read(&obj->refcount) > 0)
+		drm_gem_gpuva_assert_lock_held(obj);
+
 	list_del(&vm_bo->list.entry.gem);
 
 	if (ops && ops->vm_bo_free)
@@ -1871,7 +1873,8 @@ drm_gpuva_unlink(struct drm_gpuva *va)
 	if (unlikely(!obj))
 		return;
 
-	drm_gem_gpuva_assert_lock_held(obj);
+	if (kref_read(&obj->refcount) > 0)
+		drm_gem_gpuva_assert_lock_held(obj);
 	list_del_init(&va->gem.entry);
 
 	va->vm_bo = NULL;
-- 
2.49.0


