Return-Path: <linux-kernel+bounces-893504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26364C4793E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23A44F016B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254D26FDBD;
	Mon, 10 Nov 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="hQ+61P9V"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAF23D7DB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788788; cv=none; b=lU1EnIxn7rS/YVj9jV12joJITUahqw2BaaQMIiQowdOZwBGTgculAp8Pu3V5pgsMu5GHuPWNd+gg96lTIvLKa5twtFA+PNROjLKPRJrxvUtu4n2Ovg1a97rmH/6+4zWd6D5P9rofRtlB9nA+FclqNPq30ohM1Nn/LBladxr5G/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788788; c=relaxed/simple;
	bh=oj+/7ZKp13/wE7+I0q9U+i1FJpHSZG5ujs5ZMwbspGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AqX2C/hSLEe3hs+CsjS3mD9taLVOSAUflk/VHsVGXCwOM1GoktAFDfiiIpn2IZWBqiN6ZtnbnBC9dVsO/87+lViKXdoHy5bduZxTF4bUll/PNF6o2TQ5lxEv2ZZ6KqQ7Qt3SSV06VUceY4umVcfem6ev4R2oznTzrsR59K/gH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=hQ+61P9V; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so3692956a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1762788784; x=1763393584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV8HTrWRbKTwEKdId5EYrcLWXepKsv72Ez8s7uKyCdc=;
        b=hQ+61P9V1sUhh+Y1NsOsnCj4yA48KCsVSvLB0ZHxHQlUNAbpkuCYdJJ784OSucNq4O
         kLb5n7igM7aaipr7yDyrijPOXivgPkBptiI1ueWbK4YqrCdC1WLfaE/WC5VW6+ynA1im
         HMbcepdsO2w+Id9Bm7DDAB7AkVE8E0sJhL/ueJ7rjkAmtvRn6+cs2u7/RmtDUDK8LjxR
         sO9TXGg0YSGQXCAgsU9h03dQYt2bxJLMu1gvxYp79gw5VGxlDENKdIv20UqtG5Ngfv2y
         njgZHGPt9jdlWOB8tSFn//IvD1DUnU4pljD3ipSldWZcv2CjV+Q4PFCdpVcwSzlihkoM
         FC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788784; x=1763393584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dV8HTrWRbKTwEKdId5EYrcLWXepKsv72Ez8s7uKyCdc=;
        b=aGtcTJgrH1j6txhd5ig1jKlkeIlxtYDB9wTEyP6FFTJXwBtv7FGaQ6xBqbwk3EnJSR
         i8lXxpNoqArrf5srhtvf1DGz7HgT4PyZNSmGCDqf4q/flmapZneq/7YqbRT+ccQv4bVM
         /rpNSOg7ypDniPh0GSsGZoPa3VThVetS4w4CxyerP/L4PV+LcfcPbChMlY9+Yhm+jhOz
         zcqCfaIbAyJcKQtFsFH0m/mpJ5vtJSY4DRSXmQvTDavOEHQ/lvPln8tC3UF9K8Sim0sY
         ZMjIFZVRO3YEWIa6l+E6HGFTkhD3mnXvMatvOElbfEcdszPQ7RVb6UurX88ngP7swkm7
         KXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtGCHPc5FyWYVO9Fsy0rZa8iE41+nF0DgvpTvwpmy6Q23lCMO+UOaMhqPdlGrvKWmxao6kQMvru5CWaws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPDpp+/dGV4xk2Q2x/8LOIL5h4Iaxi6h1rjeUGkNcApwRu63+
	PXylYqqmALmaE5MfU226o0NVzg+lfP8eLvyZmJVsEb+hj5568SwdUBK/8VWdyaD2Iyg=
X-Gm-Gg: ASbGncuoRnSGUH+hTckH/8km6TENL7D12pYz/JtVg7c1IaRx6pQtCh3FcU68+bHRouN
	eX09wGPN0B392gpqlYaaAjSovHzkLGd+GrgsiNSi+1rXaq5CNY2/TsZIOeourOniL/KE0fiyWxZ
	pqkQHNFLu7q1mSlLCCPEbl2YaQUo3sKuO/WTdmEhUe0D81h6z5cd6lR/0zz67fC5lbKLJYY0hXJ
	ej6i9UgS+19IPu0dMu+U2ENMYjNioP+5LstDJjYdGxBb0K7n6kyKQHO6M9eVv7BXyyhTrXKqH2t
	3X4o6jaNkyN+xqyHyLMv7dRgivJf/HVACAFvHAxXw5ufVANvuq1vvVweAiW7fLPMbkzLxtXG+b5
	/tNpj222e4KrPpF1FmRsOduGhcpaxthP33YZ/H+9TW94hfPolJ2h2kEVGvmcWzDZGr7IHjg5Qnf
	PdrhRTK0D5LKZ/QqeLwauYdzzpxiCNWjyuCQe8TaLTZtDyt7s8+wGnKEgCVVC8
X-Google-Smtp-Source: AGHT+IH1eO/pAsWGf3irlTOolQfuNePb26vDKwUgGAjxaSNbydnFYBUagX4wozVeTRQgUFJmawwuYQ==
X-Received: by 2002:a17:907:9619:b0:b72:5d08:486c with SMTP id a640c23a62f3a-b72e0476fa5mr966079566b.27.1762788784221;
        Mon, 10 Nov 2025 07:33:04 -0800 (PST)
Received: from [192.168.1.42] (2a01cb0405e83a000cb38cfe29807c1e.ipv6.abo.wanadoo.fr. [2a01:cb04:5e8:3a00:cb3:8cfe:2980:7c1e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm1115978466b.31.2025.11.10.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:33:03 -0800 (PST)
From: Mary Guillemard <mary@mary.zone>
Date: Mon, 10 Nov 2025 16:32:58 +0100
Subject: [PATCH v6 3/5] drm/nouveau/mmu/gp100: Remove unused/broken support
 for compression
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nouveau-compv6-v6-3-83b05475f57c@mary.zone>
References: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
In-Reply-To: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mary Guillemard <mary@mary.zone>, 
 Ben Skeggs <bskeggs@nvidia.com>
X-Mailer: b4 0.14.3

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
Signed-off-by: Mary Guillemard <mary@mary.zone>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c | 39 +++-------------------
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c |  4 +--
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


