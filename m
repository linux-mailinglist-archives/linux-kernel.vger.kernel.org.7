Return-Path: <linux-kernel+bounces-891693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F449C43449
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE24E16E3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30127B50F;
	Sat,  8 Nov 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTf6+bxr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A1279334
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631414; cv=none; b=NrIYUhve0i9ozQK5YunBcYV+IrPFCU6i8vcjj5qIq0wctYU58CxkyDD/sxBUdJYpsxiCVTWYcgt49O6GlEG+gjnrIHKQ+XHa/DRWM+i2aoX+Q6Vplbq55V2wQERQv8uo5uCQpnUkx+aViS9ikJgF7XhYW1og1Lq56hWHyngJ6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631414; c=relaxed/simple;
	bh=k2k72cLXvWLqSlJ9i7wjju9Hv2ObXwadGjokiPjmX30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J32nzZIVeuFr0mFj6MthlEVjJvX+0wkplyvG+IGPrfirjTIyB3QCXNo3K8tE+XwUBLVQgms3NFPJxbAtq2hKJj3cjGvWmH6JOXIbbWgkCL85GY0r6tmLrPxWQe4GBe6iFriXUBJ39Gb33HIJj2XZXfNJB1lvTaIsxIKzCeaSmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTf6+bxr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47758595eecso8788055e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762631410; x=1763236210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi8xQlvzBSlmsDVPhecyLavK8NOYFA3LF8oQkJrVx+g=;
        b=PTf6+bxrCQIsaCCteWKwGsByMfHEaOo3ydAVEMp4DrIW+D0V3yc/qEH9Mr/dgNGLnk
         kuz2zaoouwYvLSK6W3BLfDyYpIMGZEJhotXAD+Gq+t5r2gMMjYf4p8yy+uxodmpzKJaj
         5i820jUD8P7Z9vU/oQipCBO4XMkUEPcDBN1teXDc/LerShFGSJmM90GeESF8AZGuc0bV
         9dS+GashuJqAF6eVE8g9fCU/JK2FO78vL3V9W0CNSM5VFS3v63CACjCCa5IitmgxK7rE
         3S7rssoJ8VgkD3c/UsG3ZUO0yIyAM+agXMOAQhfeJq3jrTy+seydDfEXNepRnDXlOZXZ
         IrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631410; x=1763236210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qi8xQlvzBSlmsDVPhecyLavK8NOYFA3LF8oQkJrVx+g=;
        b=rCOTJFBscbAKwq1800T2diQMDBtLIA6Nzcv+Ln1aJpdrgJ54AFS3K7oyromgeaaenB
         SOFsY7T4qkbJo23yL5+bdXghkrUdjcqlIbeHg0v0K4e+G1TXLx6LykfxG0UhcnMza1zg
         BthxlTDK9sUhAVnshmGf7EI2GgjuQFmZ2Qa/O3wMmh4/95Sm2ulVojOM6j8zjEze2gx3
         FUirtel+ldrsirpecOLqLsBGiRqtUy3X2dr7XO8oBm6cOMt4tBQENFvuyy7s1aISK3mY
         EnqiAeq331Vh+MoclAntTXFG1rzH+xem1HT9yqS5jhJ59Cth7dvSrFFZKdNG70zr4VAs
         Z9Aw==
X-Gm-Message-State: AOJu0YxD/bh4USEeWkxiuCBoLt0s39nIEhTK3WrF78KeXB5VjTIQXsHx
	U17rhT1Wq8cDvhAtQf25xETam93aR3CBqaAO91nOVbkRyWCEJybdmYJuqKonQQ==
X-Gm-Gg: ASbGnctqF7t5CZL9mmoqzGAF/IuNaq5YbJ/to43dgtlSFqhmas6CUSl0JQL11xM5V1r
	BFJRD9IaVyhHD6mfvV3+W42WKqZCBj97LTJtO7anwET5nsZ66f4HrpsyinS/SoYBhDRXlYjj6bC
	KmvGH5/EKb7huWCFWU634dlGJbZ0ygAAg+lRA84MV9zf9mqISMUc+2jsuHzqvB5J7zGZ6/E/Uar
	aRh+FAIKUMui1+G7lUdT/e9bkJGn/a/ykqwX1U+Z6NGXlNolGTmlYvpVEvi45A15zGwdc/vIk/z
	aStmElIKtE2tmjnuBgqPuRb4zMsMMSAdVB3Gcd94/j9FqY6il865ME3/NUpkGzHrD7HRkgxTYbE
	68H3YRQjL9aMBuU3ZAi87bcv0p5roGmm05MPpZ97+RiTUUuz+gFmBHAbBntDy3uxZlvO5J90B+1
	Zu96ZuzsgmxIUKJqVFI9GY
X-Google-Smtp-Source: AGHT+IGJ0mquGZTUHobdRtGScO/j12gECXAEL4G/mW7xZCyE1L9MtsLoPR7OPQcLTRH+LMInpSE23A==
X-Received: by 2002:a05:600c:138b:b0:475:ddf7:995e with SMTP id 5b1f17b1804b1-477732341demr30177645e9.12.1762631409686;
        Sat, 08 Nov 2025 11:50:09 -0800 (PST)
Received: from fedora ([156.208.73.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm233461435e9.1.2025.11.08.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:50:09 -0800 (PST)
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
	Ben Skeggs <bskeggs@nvidia.com>,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	James Jones <jajones@nvidia.com>
Subject: [PATCH v5 3/5] drm/nouveau/mmu/gp100: Remove unused/broken support for compression
Date: Sat,  8 Nov 2025 21:49:17 +0200
Message-ID: <20251108194919.68754-4-mohamedahmedegypt2001@gmail.com>
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

From: Ben Skeggs <bskeggs@nvidia.com>

From GP100 onwards it's not possible to initialise comptag RAM without
PMU firmware, which nouveau has no support for.

As such, this code is essentially a no-op and will always revert to the
equivalent non-compressed kind due to comptag allocation failure.  It's
also broken for the needs of VM_BIND/Vulkan.

Remove the code entirely to make way for supporting compression on GPUs
that support GSM-RM.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 39 ++-----------------
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c    |  4 +-
 2 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
index 851fd847a2a9..ecff1096a1bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
@@ -21,9 +21,7 @@
  */
 #include "vmm.h"
 
-#include <core/client.h>
 #include <subdev/fb.h>
-#include <subdev/ltc.h>
 #include <subdev/timer.h>
 #include <engine/gr.h>
 
@@ -117,8 +115,6 @@ gp100_vmm_pgt_pte(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
 {
 	u64 data = (addr >> 4) | map->type;
 
-	map->type += ptes * map->ctag;
-
 	while (ptes--) {
 		VMM_WO064(pt, vmm, ptei++ * 8, data);
 		data += map->next;
@@ -142,7 +138,6 @@ gp100_vmm_pgt_dma(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
 		while (ptes--) {
 			const u64 data = (*map->dma++ >> 4) | map->type;
 			VMM_WO064(pt, vmm, ptei++ * 8, data);
-			map->type += map->ctag;
 		}
 		nvkm_done(pt->memory);
 		return;
@@ -200,8 +195,6 @@ gp100_vmm_pd0_pte(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
 {
 	u64 data = (addr >> 4) | map->type;
 
-	map->type += ptes * map->ctag;
-
 	while (ptes--) {
 		VMM_WO128(pt, vmm, ptei++ * 0x10, data, 0ULL);
 		data += map->next;
@@ -411,8 +404,6 @@ gp100_vmm_valid(struct nvkm_vmm *vmm, void *argv, u32 argc,
 		struct gp100_vmm_map_vn vn;
 		struct gp100_vmm_map_v0 v0;
 	} *args = argv;
-	struct nvkm_device *device = vmm->mmu->subdev.device;
-	struct nvkm_memory *memory = map->memory;
 	u8  kind, kind_inv, priv, ro, vol;
 	int kindn, aper, ret = -ENOSYS;
 	const u8 *kindm;
@@ -450,30 +441,8 @@ gp100_vmm_valid(struct nvkm_vmm *vmm, void *argv, u32 argc,
 	}
 
 	if (kindm[kind] != kind) {
-		u64 tags = nvkm_memory_size(memory) >> 16;
-		if (aper != 0 || !(page->type & NVKM_VMM_PAGE_COMP)) {
-			VMM_DEBUG(vmm, "comp %d %02x", aper, page->type);
-			return -EINVAL;
-		}
-
-		if (!map->no_comp) {
-			ret = nvkm_memory_tags_get(memory, device, tags,
-						   nvkm_ltc_tags_clear,
-						   &map->tags);
-			if (ret) {
-				VMM_DEBUG(vmm, "comp %d", ret);
-				return ret;
-			}
-		}
-
-		if (!map->no_comp && map->tags->mn) {
-			tags = map->tags->mn->offset + (map->offset >> 16);
-			map->ctag |= ((1ULL << page->shift) >> 16) << 36;
-			map->type |= tags << 36;
-			map->next |= map->ctag;
-		} else {
-			kind = kindm[kind];
-		}
+		/* Revert to non-compressed kind. */
+		kind = kindm[kind];
 	}
 
 	map->type |= BIT(0);
@@ -592,8 +561,8 @@ gp100_vmm = {
 		{ 47, &gp100_vmm_desc_16[4], NVKM_VMM_PAGE_Sxxx },
 		{ 38, &gp100_vmm_desc_16[3], NVKM_VMM_PAGE_Sxxx },
 		{ 29, &gp100_vmm_desc_16[2], NVKM_VMM_PAGE_Sxxx },
-		{ 21, &gp100_vmm_desc_16[1], NVKM_VMM_PAGE_SVxC },
-		{ 16, &gp100_vmm_desc_16[0], NVKM_VMM_PAGE_SVxC },
+		{ 21, &gp100_vmm_desc_16[1], NVKM_VMM_PAGE_SVxx },
+		{ 16, &gp100_vmm_desc_16[0], NVKM_VMM_PAGE_SVxx },
 		{ 12, &gp100_vmm_desc_12[0], NVKM_VMM_PAGE_SVHx },
 		{}
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c
index e081239afe58..5791d134962b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c
@@ -34,8 +34,8 @@ gp10b_vmm = {
 		{ 47, &gp100_vmm_desc_16[4], NVKM_VMM_PAGE_Sxxx },
 		{ 38, &gp100_vmm_desc_16[3], NVKM_VMM_PAGE_Sxxx },
 		{ 29, &gp100_vmm_desc_16[2], NVKM_VMM_PAGE_Sxxx },
-		{ 21, &gp100_vmm_desc_16[1], NVKM_VMM_PAGE_SxHC },
-		{ 16, &gp100_vmm_desc_16[0], NVKM_VMM_PAGE_SxHC },
+		{ 21, &gp100_vmm_desc_16[1], NVKM_VMM_PAGE_SxHx },
+		{ 16, &gp100_vmm_desc_16[0], NVKM_VMM_PAGE_SxHx },
 		{ 12, &gp100_vmm_desc_12[0], NVKM_VMM_PAGE_SxHx },
 		{}
 	}
-- 
2.51.1


