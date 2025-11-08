Return-Path: <linux-kernel+bounces-891692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C4C43446
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FB3B3060
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDCB28689B;
	Sat,  8 Nov 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWZQzF81"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41D280A5B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631406; cv=none; b=tqkzB99BwuNIj1+4VBrYmzpU28xbm68uUX4xCZmRkA/E5O7nE984TnQ6FEE96CVQzmuaWSrOs1TYoRucRW5xAbGsTgfEgKi5PZWjXTLw3d2ZRNk+hS2RNS4vAwvyVFbsEziTVy7sQGiSNxx2gWW2CkFpRK/E2YRnMFYIepYlwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631406; c=relaxed/simple;
	bh=PX9MC8HmNl1liASH03zyFsQnq6qIkxE5oSyXIPHw1cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5wGuiHLb6YHIsvjHOhY42vJvGcyFlqr3bFUppqvFwWZgFpltaEU+vPLCCccFBLmJA+lypVpDHQKSKODUFcybNeXAc3H4rUUkbWlweMin/qK97vMN+sQsc5pRTV/BFPm/7x6fPa29y8f+nqRS9jViEPWXGJXywUF7mvbBxuUA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWZQzF81; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47728f914a4so10683785e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762631402; x=1763236202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzVBO3wygi8AtPeTVGw8SAvM16hukiPubsoP12gEgLs=;
        b=EWZQzF817Jk+PVjaSOObi9uhj/Q5bpxcscppEwkmGAY/zcChvf1Du7EO9TxBcKdUUv
         1N16Sv1btmf9uba4SAcSRL5pzQDN5IbE4eXKEZCHZbA9Cv1+iFvoNGa/4kBVsR8QfOKz
         FJZLdG/eZkKaeM7SCTwDq6qjXsc/ClDbcGlaAv8L2j3ndZJwYSX6K47BOkC+EH9s3Knd
         sj93TBnb6YgJjIBpU0CZjls4gh25xyzsLsTAZqxhqMdJmhXcFH/zRKJoG+hGmhdMUFh/
         b50URJjAiEMHQ5X7XTx4/uPkszhYCqQ71vye2wvS+EmeAIs5dViTc3OUHC1upYTxptsv
         Z6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631402; x=1763236202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzVBO3wygi8AtPeTVGw8SAvM16hukiPubsoP12gEgLs=;
        b=a35L/v78TyBkxM1lUXQe5eFtKmDgb4RfmAZDqiMovF/KXgnGKX9FpLN57OZWbSfcuo
         NHnQwlavFQ9s72AxftUihoeWhcrVYKvGzEHpenQbgwBiiJ6I+vD6ZZfxIE4eidn+WTj9
         3ugjra4gDmMT3vkmg6NlE2NMxAGOuLhnCRWp93V5jdCHbhsazykAJuZtDefi5Yje5J1g
         kDroWP9Nwm/qGSz26l98uOXVtqrrCgy0x3AO104Ud1piyh0RSsrGvGpG1HShV7CmSZxH
         CJc/zuflCZCwvrG/z/3NX1Nm7FDW2uHeOxoVzdXOWkL4nkE28wS+Ejn1WXKrK/p2GZnn
         ig2A==
X-Gm-Message-State: AOJu0YyndjeOsWdjXBUqMkNgaAgPfgeYCGtvrk6lJciAugHkPyKWLLYI
	DG9kEbLzfgVugPGApdl8Q/kVB8jIRE9KPA60SnUVVuS/RSp4X5jcMA8MKW+cXg==
X-Gm-Gg: ASbGncvewT3Mw4qZXOGKUPfBgs40UMbS585r5EM6KzD8N5iwOMkLOhqOMUAizBzOg3l
	pAn5tE3tiIgZYiystRwAVlBrlML4/PmRBkwm+3bH1ZIl6vnjs5rBsACREACj7/g3aZceThFxHiL
	aUhCyDjedFlmuWaa9oh6Lxclf9JnZeGZT6cebH/d9dzKWKlvYl7/kra6C+2KtgYJ3S9IC1LoD6M
	Kb/lXE+VGc6T5ghGV/lCFmliSGkMUNfqssdoMiJVv9jmvnqSL47rBnFYVb08NcaWXqpkkS/jdk1
	irA0unMzvImCz+E3keaNLYTyIxz7ceK4q4I1vF0l7ObJlOpm8sRmvD8Vbvh5deyXWOjLaHLdEw2
	x+cE7vf2wBTCPaKsCSzgteZhbrNIk1l5NdtJNDTQnJuEKy/pFDwbFxQekgR/Ig22IJd9F1+uKQ/
	wZzIS9p/1W8A==
X-Google-Smtp-Source: AGHT+IFKRtnzr6h/yDOoNnlfXZI3TwwKRMvaZxn/CG3D9oz1Xwc15sQ3+kUt+r2cqQSOgU1wH0tHyw==
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-47773297851mr27813065e9.38.1762631402423;
        Sat, 08 Nov 2025 11:50:02 -0800 (PST)
Received: from fedora ([156.208.73.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm233461435e9.1.2025.11.08.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:50:01 -0800 (PST)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	James Jones <jajones@nvidia.com>
Subject: [PATCH v5 2/5] drm/nouveau/uvmm: Allow larger pages
Date: Sat,  8 Nov 2025 21:49:16 +0200
Message-ID: <20251108194919.68754-3-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
References: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mary Guillemard <mary@mary.zone>

Now that everything in UVMM knows about the variable page shift, we can
select larger values.

The proposed approach relies on nouveau_bo::page unless if it would cause
alignment issues (in which case we fall back to searching for an
appropriate shift)

Signed-off-by: Mary Guillemard <mary@mary.zone>
Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 60 +++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2cd0835b05e8..acc1556d1ef4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -454,6 +454,62 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
 	drm_gpuva_insert(va->vm, va);
 }
 
+static bool
+op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_shift)
+{
+	u64 non_page_bits = (1ULL << page_shift) - 1;
+
+	return (op->va.addr & non_page_bits) == 0 &&
+	       (op->va.range & non_page_bits) == 0 &&
+	       (op->gem.offset & non_page_bits) == 0;
+}
+
+static u8
+select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *op)
+{
+	struct nouveau_bo *nvbo = nouveau_gem_object(op->gem.obj);
+
+	/* nouveau_bo_fixup_align() guarantees that the page size will be aligned
+	 * for most cases, but it can't handle cases where userspace allocates with
+	 * a size and then binds with a smaller granularity. So in order to avoid
+	 * breaking old userspace, we need to ensure that the VA is actually
+	 * aligned before using it, and if it isn't, then we downgrade to the first
+	 * granularity that will fit, which is optimal from a correctness and
+	 * performance perspective.
+	 */
+	if (op_map_aligned_to_page_shift(op, nvbo->page))
+		return nvbo->page;
+
+	struct nouveau_mem *mem = nouveau_mem(nvbo->bo.resource);
+	struct nvif_vmm *vmm = &uvmm->vmm.vmm;
+	int i;
+
+	/* If the given granularity doesn't fit, let's find one that will fit. */
+	for (i = 0; i < vmm->page_nr; i++) {
+		/* Ignore anything that is bigger or identical to the BO preference. */
+		if (vmm->page[i].shift >= nvbo->page)
+			continue;
+
+		/* Skip incompatible domains. */
+		if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
+			continue;
+		if ((mem->mem.type & NVIF_MEM_HOST) &&
+		    (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIFT))
+			continue;
+
+		/* If it fits, return the proposed shift. */
+		if (op_map_aligned_to_page_shift(op, vmm->page[i].shift))
+			return vmm->page[i].shift;
+	}
+
+	/* If we get here then nothing can reconcile the requirements. This should never
+	 * happen.
+	 */
+	dev_warn_once(op->gem.obj->dev, "Could not find an appropriate page size.\n");
+
+	return PAGE_SHIFT;
+}
+
 static void
 nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			       struct nouveau_uvma_prealloc *new,
@@ -506,7 +562,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			if (vmm_get_range)
 				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
 						     vmm_get_range,
-						     PAGE_SHIFT);
+						     select_page_shift(uvmm, &op->map));
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -599,7 +655,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
-	uvma->page_shift = PAGE_SHIFT;
+	uvma->page_shift = select_page_shift(uvmm, op);
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
-- 
2.51.1


