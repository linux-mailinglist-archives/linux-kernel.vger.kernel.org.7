Return-Path: <linux-kernel+bounces-893502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15810C4798C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE113AD66E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF9262D0C;
	Mon, 10 Nov 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="IThJIqmR"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C471184
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788786; cv=none; b=SjUmH7bXsyoCECAMqFueG8tSaxOEdOUtEyw1HIO4US58G6A8vOrgjD+WcdkUDvEGYHrwGgRGKXk3V3iHdi75m3YryZ5BOQwQy4VDacHLcOwfnc0/xhkaLnmYLJ/ZnnCw8Vngohdax++RXxh07GAiHO2VIgj1qndR8gd6U5pL24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788786; c=relaxed/simple;
	bh=T6q1ZsIoH/X7ckcjucX48+upMCdXpdZQUc+m9qvG0T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJJglPL0fED7Qe4m4iagRJhYosXPJeIVG3nqYUrEE9WByF7b6MU1P4uVjj9y88d7yFSLFXYXKzzm3Gigk/yjuvCTrQRz+zzSc9fPvFS1zicM+L17O9bGYBJtCFUFH9jl8gkvdu0aYncK3iiGZ2mzXAW2dgQKSacW4iY4yPp9ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=IThJIqmR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1293693a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1762788783; x=1763393583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8anBBbHESquXQhbkwtAuSkGAXh7jPk8kuEQGrPhUcY=;
        b=IThJIqmROwGZnDApKDnWO6//NcJO/PpW+u1y7HvgDEi3Z7P7+qoKKsTZHZ0buQ0mLZ
         Unfi/e3wEMh52aZsGz9Un9hXGDDIJNx/LBT9JArs2w5BhLiog3PrlIUAhQjgqNSnCQNs
         cqogHLSwLlpLoxvWQCFQhuXFVuvpqvjFSn2OG6TbJ68jdpcenc3PM08ntSrypCimF+p7
         Yvojh0jG0lld/680LIx64vvrBGG+PwNad28uiGJEI/VE61ImT6qUQpDZGwB1+6iGr0P5
         /OIqx/GAiEUw/9bBmRasAogO5L2F2zI1p2Xc7i3hmnDsKSZ3HcjrUV/z5XbCwZ26nHHj
         3/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788783; x=1763393583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R8anBBbHESquXQhbkwtAuSkGAXh7jPk8kuEQGrPhUcY=;
        b=OAo7UJYNYkwVrcZq9YZj/zOqt5YrdiwRyOybNY/0gMSMuwW9E4cLst1HQNhig3c8FD
         ptJ1J1PA2XadKQjhu4pl4Woi2Ws7uAr4Un9yO+ZvbzcDJrgt1aGgNjfmucPhp46QVQj7
         /Si9Bb3pz1TRizbe9ZkMpjsrbCONjZab6CNkUt5rBnhrWYUhm5InO6MrtVRfxz51+Ag8
         Z+4pdNb03pPPrRKbceDJrvUh720Kx/EIyHLd24NXwzxrPcVxFELMwg10JnbMrgmkppno
         KXNXxwRvmfHhPVHsSM9J9XVFMu1Dzdt7fvcsvK81S0SX/57PYaKz5bsPW2Z5IbpsrySW
         8fwA==
X-Forwarded-Encrypted: i=1; AJvYcCU9MYp/Fdmo/MlUE1FjK+5FeMk7CnzB/oeq+OtWU2MEPrPZ05ilTqCRPUmQtsGCF4ZLPjdY8TDzsKDqM7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvvr7K7//EuulYnZsf144Giv5yp7vuSYgfX7g9dHLiVVuqClm+
	kMG/JQDgJHnTLHxn8i/iwoke5WthsOt7UKiNZOjvkS/0oCjAb3VFzvf9HCiPrr17El4=
X-Gm-Gg: ASbGncviJLD7WLZi6exIecKry4Z7czSetfxxiB5FnykL+Y1TCU7Qryiy0Isck7UUqha
	mD26llfHB4B9m8hYWktmOgSbVbNb5rEonGYQjuj5eVTQbb7/aP2ZE0USKWYttFnHDFcWdB7RwbH
	9kklpWLfA9RqsYzEsl7cf/EtaipSATcts3u7lPpAbA/nIYns7bDI6IPiF9ZJLHzbj2GgwOcJgqk
	McoKkLCOYbm+r8DecdKJKG8CTz+gd+ZxzIM1o/hvGNbkazkDWFi5Y1/jvb8MIhTWnKkOTj920bk
	mlT4NumTO0HJ3QKXR+E7Mf7KkcWqcHLPZC9ehUQz3MpJM/O0pxb/h+ML/rQ6mlKfCD3kmbJWkC/
	zjE2Sj9d965xlLMjjZNSkVHvIabcxSv6M61xjAkF+Yy6VVJTRwQmuWydryaO/ynEvEh68QirYr9
	80eEqbirfXtvIVN3hh9YHD84VbQnlERTHm3qE0XzfGdbdc9Sca4AKEsmDSwkPyo1q4PJJoBrk=
X-Google-Smtp-Source: AGHT+IGLnUb5JAPQPO72VTewXJyhQbqwXbtomELs4bxH7l4C0hn/3i6G7eKjJQqBAuCg+Rqn79a5JA==
X-Received: by 2002:a17:907:c1f:b0:b6d:565f:7862 with SMTP id a640c23a62f3a-b72e02d3b95mr919506966b.14.1762788783332;
        Mon, 10 Nov 2025 07:33:03 -0800 (PST)
Received: from [192.168.1.42] (2a01cb0405e83a000cb38cfe29807c1e.ipv6.abo.wanadoo.fr. [2a01:cb04:5e8:3a00:cb3:8cfe:2980:7c1e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm1115978466b.31.2025.11.10.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:33:02 -0800 (PST)
From: Mary Guillemard <mary@mary.zone>
Date: Mon, 10 Nov 2025 16:32:57 +0100
Subject: [PATCH v6 2/5] drm/nouveau/uvmm: Allow larger pages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nouveau-compv6-v6-2-83b05475f57c@mary.zone>
References: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
In-Reply-To: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mary Guillemard <mary@mary.zone>
X-Mailer: b4 0.14.3

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
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 60 ++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2cd0835b05e8..f10809115c56 100644
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
+	drm_WARN_ONCE(op->gem.obj->dev, 1, "Could not find an appropriate page size.\n");
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


