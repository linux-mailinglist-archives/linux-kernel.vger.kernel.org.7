Return-Path: <linux-kernel+bounces-880000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A6C249DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C7774F2D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFC634214F;
	Fri, 31 Oct 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeVleNMO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C934164A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907795; cv=none; b=aN/gJs7hQoJL6p5Ttxs8g8+sLHLbacMkEGs21iUsLMKhFo3ciH53M+rNBy4bppt3IheFifZiirWHTApWvyCNsmqSabB8b7czb36dpBEcMMECqrxW3O6PlLzGVFeh4AJLHRp7gr3Lo7xff4uZ41y1vzM6jwz7pgSOg/DlfUhez/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907795; c=relaxed/simple;
	bh=tyec8/1apPbyr9npNAl6QwVVhZO/TjN27vXKVA5iE/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ7ZfUhrLZJvbEwsFKB7WextNf1x4LlL4ww9Nn6DenIsRn1jtaU0UXsTARAVWqtwPitsz0/8/5cddenmbk6282U38FvscvEWJEwinXYQqCwVaj3vj6jbEDX/M8Ko4nm+fWx+qo1yBivCmDrPiRtEFIHz3poamzJ6sVEs5zqav3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeVleNMO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so16745025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761907791; x=1762512591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytESlltqRxcX4R1jrclfkLL9qc0CSP/KNMvJhvbH8BE=;
        b=YeVleNMOnH62BkBSuErt6YTRDK5pJus7SQ2docRGi9MObNY1PFCgzy/LquWZwuKSeo
         UtlvSiPjiu1ZrUpoS+W2Y6MZ/GJnFKXmrW+kRJAbYzus+cQw7drpywLwbbusi+b8rbnr
         +HCckilKaMWRO29XPxwrMuDqlog2J0fAMAee5vR6uYQMAYPhRXNOdYAyNLBkrObo126K
         txODyfIFbFGXLud3pj68xLcWSNWAgYuUZiJ0rkUGEyuYbCCEZvvUBTT5KUExByFuL+xD
         +AEowxBj8nAxaJkWVReZ+liryJUnaSqADf+62LHv0EvjLXDp6MO9hliiZQuSJup0FaVi
         KSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907791; x=1762512591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytESlltqRxcX4R1jrclfkLL9qc0CSP/KNMvJhvbH8BE=;
        b=otPF4e/IbtOB0IvL+I2h/fCbnSENMwqyqz1thJn7BhkoE+eADCcnoG5xhqHt/nUec6
         dADTQ+Te8bEMfSnexfzvNWAXfSWY544AH5OJRCo4PBZYR1/EfvAs/14HEMXzrImhvxIT
         6O9qSWN6bITuQQpXUoh1tozt7nOkWCI0Jk1UqLQniBPV2RDdQDB3s6BkKsGs4/L1jg/q
         rP8U5UxLhP1b0pyDlUazhgXSE8bPuSS/l80sz5vcc9puMX9m1tQKvuhKC9Zo9iNq+FAI
         UMr7Zv21Ab4TXgRQmUz7QahIE46B3mZ4sUgVpVWx6vSSC/xIvGxHjNy0oK9XRROHemNf
         f+vg==
X-Gm-Message-State: AOJu0YzDmNT2zgn9g0E73QM5tZNwoGjyokCWkQXqve6Rl0eOQ07dqsOV
	LPj0faaLZY6FOtfw+5BYlGBCiTi4HGE5JPsnbJq1l3AyfP+Y1myS5Rv/1EJpRKPq
X-Gm-Gg: ASbGncvPxXyav7Avu/ROqRJV4nd8nYXHbaMcWXmWwi6WfrIs5Vdg1Q16rJJG6BChfj6
	Cdzp6LXxlzFD0IvHN82TmcboPdh5v3hNjXPi0itUY3jWvm+qhrUc9FeNF2jM1P7L2PK8PRlGOa4
	pS+Rqew0OwohveKQ9WWbTdI9xiwWaRsUcZ3Fh/6zsA1TSgHNH9yhrnWAaK1poi4CrgjcG4MUzAb
	7thXBXAN/UOJxStaQTSq6ZoT4/kOzsfysnmQhSi7HXobYvRp3+E6q8hzu9gDOBMKzyar/RXOGW1
	rE5R+fBN1XeKntUPczYS3X7EcnCAZ/A1VzqD9r0RqBmIDtFQnxsk13r27kouro8u4riuthI2ECh
	nW5H2oqNU7yQTRkKbxGYN7V9G3JKRoa/5gVpawtvgdmPY5t3dCKhcvssrYq4Q92zNYNK9s7kQ/H
	WgYhgg4nZUuZs=
X-Google-Smtp-Source: AGHT+IEOFyWQviAB5WzOHqdnu6OhTfkzRX9usv/bSGoYjbNq2l0qgpNuGqp+EDuIzC2/qXoWeByspw==
X-Received: by 2002:a05:600c:1e19:b0:46e:711c:efeb with SMTP id 5b1f17b1804b1-477308aa8acmr27643765e9.25.1761907790763;
        Fri, 31 Oct 2025 03:49:50 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf7d07sm19498025e9.9.2025.10.31.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:49:50 -0700 (PDT)
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
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v4 2/5] drm/nouveau/uvmm: Allow larger pages
Date: Fri, 31 Oct 2025 12:49:21 +0200
Message-ID: <20251031104924.10631-3-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
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
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 60 +++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2cd0835b05e8..ab8933b88337 100644
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
+	WARN_ON(1);
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


