Return-Path: <linux-kernel+bounces-847569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C1BCB36A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B9B19E7846
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91241A01C6;
	Thu,  9 Oct 2025 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvdFwwNF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B828A1CC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053184; cv=none; b=cgSv96zUmGr/m0Gr62wQN9J0irnG363bfZW6fVelzmztm9kULCf68Nn4d+yOznUVFaAGEon73SVrJWvLio7t1tFd0zGCPnE+yafYi02zgXQl5InssVXrM5+WneiDpjoWZib5f3beNqp5jtrA/O1H+nXk0XfAmPvJlIkoQOYaFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053184; c=relaxed/simple;
	bh=kjGFSLCMqozWPEfBaKD+iuh/CVvQu9T6udB30XWCDoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zqw929IFl8TBkwYobTBm+b38ldyz0yBH2rOYjIQ4rT8B9Lot5wKfreBiiod0iIgExEDk1kkCPd5MZyU13b+E41DKNbbif+X2dO2ctvCZ33yMpzuGHoKRTTr3KIIQGqp2Pa/gTfcrQ/Snj4QK6BuQmk4Z0VCt41DzgG7U5nEYgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvdFwwNF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1344620f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053180; x=1760657980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn7r3BL145SwP61apKkjC+d51IoKdlTNuTUmtFzl4kM=;
        b=gvdFwwNF6LdWgvBgEVpyhR0q6XhAZu3vu9/wvxLRZY9/OLAgef2o56hHA7tGn1y6y8
         R6Va9dnFrjUO21VF9H1xzDcDL+u9K24w27SelAPZFVrR64jzQ3J7Yi2cjTHs3B3VPXqZ
         Z+hkFucW4CkvXyy58UejdHD/5lZnI3r/BHgAD1ARI3QrxHxxabN3Sjla3sIb1dzcXYHK
         z1KA8PxZCjLUUQ1dEu6rDpwtqIGPsHw5bR0JrjVr3gnLuE4EUWBSz8/4M0v5vmjp51Bj
         LmfFbziiMhsjr4+j1wwvM/kJa5wywLc6xTdlhOaVaSkki6k/ekQOb635QJFrauFTfHA2
         jbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053180; x=1760657980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn7r3BL145SwP61apKkjC+d51IoKdlTNuTUmtFzl4kM=;
        b=sSbcBEx/Tlc2qsb5aYHDg/fxJXAivpENHnTdYTKg0Tpgk7bS/r8w2HAGF24wV1+QTb
         ZuqfC2z0uLVVBliz9aIHGwmv0fuwmO99fVXkgP6bNdgpDjWr/681viEAdtVqBwxQH2kj
         ON3qtnpE8ctOdc7azt9/x2rFWC5uhPQ4f4PFjWttkwdyu5jrgT72CuLp1foSszjmSc4k
         OcbhEIYW9NdYsjqJuGl4VpSNQDHkqDrRXzGsMEk2QWT2sm8JUm1ovhuIHbNWEC7mI78L
         RIVu60EbaCIxGtE++cFOKWpf21iyExOQrXAp0V+gscGnG6WSnUjXztZJEIVmeo+w3L0v
         ScJg==
X-Gm-Message-State: AOJu0YwuXc6+FZwPEhSbgX7FGzHKCXF28OX/XdtIehF1i+cpxEO9mim1
	lVBOLqfhxz5MMg3L873SA2/41SCJtIKXQF3/pQYmVUkbROd+0qek0KxYUduYfQ==
X-Gm-Gg: ASbGncs2O1fcEdHfRNTgKOfu41+IItySRrmP9Y87+QqOC0aNDL5CfgDbAHdcldn/0hr
	KGqNwSco6J7hHNKbnKFN5XTzp2SVchm2lP4RJNvi37PV+mEsnfADuRjOMTpKf/br8Skc6NnsPer
	p5eoqkIlYkApswDX5/C6UymgJEDkbXv9V+ipZ7XsqHyTugfdT/dORIszy6XzpAUNt9KEG3J8AcO
	S54UyxtXxoSV2sRZmRstYhVr0/649hqlIjL7tlelDq/hNq146YlOnye1EBGf/xgxGpmDxH4NXTM
	5vSfu6uNIGqqeg/CLEKewdUre//sMBQ6xFfaNWB1WdvOw8C/lXo/efwpvw3rqWV8fZ8f57DkVQU
	8Jk1rfkvWhDA5R3X6AZsmAdJKSzsbtnrD1YliEQW4EOAdS0Kkqbxy
X-Google-Smtp-Source: AGHT+IGdqls7SyfS9rlGiYJhNhOTiuHdsvgydZoDC64SjECyggTia4JZD0sXtoOH5akOKGGE784WqQ==
X-Received: by 2002:a05:6000:26c9:b0:425:7679:ea72 with SMTP id ffacd0b85a97d-4266e8e0959mr6384259f8f.47.1760053179986;
        Thu, 09 Oct 2025 16:39:39 -0700 (PDT)
Received: from fedora ([41.45.27.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm46066075e9.4.2025.10.09.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:39:38 -0700 (PDT)
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
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 3/5] drm/nouveau/mmu/gp100: Remove unused/broken support for compression
Date: Fri, 10 Oct 2025 02:38:35 +0300
Message-ID: <20251009233837.10283-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
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
2.51.0


