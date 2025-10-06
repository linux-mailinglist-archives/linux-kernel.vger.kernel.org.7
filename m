Return-Path: <linux-kernel+bounces-843386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A916BBF144
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E473D189A583
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B47C2DECBA;
	Mon,  6 Oct 2025 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krAb0S6F"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E409E2DECA8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778062; cv=none; b=Cs8+LQbZu/4kjdP6WTO4bjl53vBvntNP7U7numr+QIs7OFaaQXGtHOVeL21IKebct5t6qq2IvPsBPLQntPVyzUinvTIBfseOA07MMj4e6u4yYcLN5T5YoyTCvsHZ2FWVr/Kigcb6+AX51el76WNc9IUXjLfWmI/1UiaZuydmQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778062; c=relaxed/simple;
	bh=i8+9CTLIUnAPtN1kxNYRakoqpP1sxfJc+oHYVyECw74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9sMVm6QyOubQgK7czCTqRoyRrqLnrRZVVc6PyeWAL0O9vpMBhyVKi/X9u+XUuKuN/Q8Wyen9tgZe681nzhAb89MdhHAxukxUO8FPCBAoAKOQzAEVLc7Cdqu557j5QblpzeieeAO+gVpI2x90BDUOyNNc4WCBNPBF4E5rLPspfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krAb0S6F; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4220683f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759778059; x=1760382859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAYO5exGw5pBpJwPfJWxaone+f+36yTg5sQQrnulw7c=;
        b=krAb0S6FOVC1k0/eIllulsNYsKTEL74ggSHvtedWg2qDmQwv0Dl4hMk43f647Oz8kI
         zEFtEHoq7PAjoUILW4EUoQbW7r/vBrkj6bfSxQMdFPvm6S44YhYkGdV7OTIeGToxardq
         z7g7vYINL9MbsHiokmUNlWeX3oFsJvOZ+5RnapiGvj+BzJpu7OUyjtL6b1L4aq1QM7lw
         fxVxjxGeKGFy1DZyVUn2w2MNiQaTKnx0QadpauROv2OeIZtgHtwYk6mfZ90l1fRdA1zP
         VPwCdFkUQnUyrA8I6SsZdE3DYL8+7bNJ2kfa/EMzlKm5GUdF2jUJJ1NdQ9nxbH8yKw6h
         68GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778059; x=1760382859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAYO5exGw5pBpJwPfJWxaone+f+36yTg5sQQrnulw7c=;
        b=LfOjILgIIKDMJ+SGpGY/MouN0wdYccOjFEsmERFzYVLIXFLAFKkIbp5C/gFF+aLxtV
         gbfdwaDXTqpGf5WN+LjzvgnUHBkTBAAH+VqHE5BPcOMQgTI2XqKrcStriZSJISldqbyb
         4Zp+vVFprIr46jkEgzCuPwtWPISVzE3H0mneKAJuMoucKS+ltOxDGNxtwdIV3AHGLET3
         7KrPyDcfSYfyeDZTIqg0CW/4Xim4jAzcHHuJg1JEGeBK7FbsDvGJd7S4dOJQdVEXULet
         1UosgK1aa9Zd+uvc9+XuLn6WyrGmGwPZHO3scHlYQ6sNiQuf+XHmp1oLmWfp5s9tJoIt
         OXmg==
X-Gm-Message-State: AOJu0YzwvO6V3qViB8oX+ShOblzr7jJGAmnaAp8PVpmgMjwbQ5/LEVRE
	zMP//q2gwNSkdxgyN+j9+d+ipO7F/0wM9qvEQusbpUnxbDIYvbaY+uCe7mBl9Q==
X-Gm-Gg: ASbGncvcJW8zYD5LwMIYJ2ipKDXxrF8NhYdKytCwcWpWeDaYTH0UZNl0BXWJiR0cw32
	38q/QyDpJeogtiQuOwddchQOINpJoFeqG1F1KXi1U8pw/Lhg9oJlOBD3EAzzT0xwiDGAhZwOPbX
	gbf+jVj1NRt9MnFEINuAq7dJVK32OhvukFGNJeTuBVFKmCz//MsK/R/exkrn6qwdcrrz0nkssAB
	l4d/1ibB5+RIMdzDSMeeyfsOveu/5MFrBEXCB1bdVlSPz48vATqXzEBIDcfg/KUKn+qakXN+Eqf
	fTiqWrvETyNhTTNAHkJeHfoWPjmzjK1xoPZfJhAtqHAd615mvvTpG/l/S/JZaY45N+ykULgoDEJ
	5JRiapy6dL9XW9DVnSu825I9JNqQuot7SSWTuzYEwJQ7fvYcDKUPHwUfcJMfjIr8+BxaP
X-Google-Smtp-Source: AGHT+IFgnvCVizHV0NE+PuzB7sBbTSTfTggo6zyJ+bMeG0+kpzGpMjfhHGaPgBdZXpGwvw+NuYnnuQ==
X-Received: by 2002:a05:6000:1883:b0:3ec:42f9:952b with SMTP id ffacd0b85a97d-425829b61f3mr502699f8f.4.1759778058786;
        Mon, 06 Oct 2025 12:14:18 -0700 (PDT)
Received: from fedora ([154.182.208.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm16646435f8f.14.2025.10.06.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:14:18 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org
Subject: [PATCH 3/5] drm/nouveau/mmu/gp100: Remove unused/broken support for compression
Date: Mon,  6 Oct 2025 22:13:26 +0300
Message-ID: <20251006191329.277485-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
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


