Return-Path: <linux-kernel+bounces-880001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B90C249D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27C67350928
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB153342CB3;
	Fri, 31 Oct 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZUMkV/h"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE30340A67
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907798; cv=none; b=qockGPdjdq43ch8upZfefENPQ96AJa8aYkEspnmo/1Tl5Y8kh7dVD/nHXsh/COwKLoDM/UdH+NhPiRPDDzssVNDcrjoPWiZ2g3A9Lihaa1SGSjbqPe3qlTNcmD4DKInxbHVdFdSUxeB/GpAdoEbdFwXrkWmcRnKznYENApYdc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907798; c=relaxed/simple;
	bh=6nn2VeqdLzRcwL7AKTuuXeR8rESQolA47ksnBgHsmQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5pfruyT1rCgX/ss1yZjzWgy6maLmvazE9CmxJuKsmhhza6b3pNrht6SxJY9iOli7Ln0/1cugplU5ylXa2g4PMH/5Mf3RqpfbWbXOHbcLBe5ZVK36WSbJGG/MZpdtGPuqD48Vc5XDG+SWMqKr54Hp/w6mN+oqoN6w9XSiGRwfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZUMkV/h; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so16745505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761907794; x=1762512594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ultisk0LTvrj8uqMnV5HKpTwdWn+r1ljzwjarHhGTc0=;
        b=FZUMkV/h3a/HV8SLPsC8Y0UBdhGmokcfUUjXTAcSXDbx2NjaHvxVM0+QRDTZCI1r5x
         YYlq/mzlA+4qxMToWDcR/14Q+hPAEFhsZpFkUHFC6WLQe72Jily4o9rilAVnhd2QH8NC
         dNAJD9QUFJTdTSJ1CSxmbs35v7cP56jQVQ67d/oMOfWbaxW5Hw1iwo30fbNC8eDU5kCh
         HsJ7MYMHIHOGBm2mSVtSXJCck/1E3aX1di6c0Uhi5vBzVsretoLYOwDMTpBhxUjqV9cZ
         r8GKq3MbRaYDx1Vp/GP/tP4ookHk6/WxpXovcUQeGX/YhoEkeZm5z84QuyGOXOLHe9d3
         Vbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907794; x=1762512594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ultisk0LTvrj8uqMnV5HKpTwdWn+r1ljzwjarHhGTc0=;
        b=gnODwmNDI0YQ7x2SyKLIKTlIg7EZnvPz52sFasdEOtwM+1dP8Fv0wz7cgfL/H7Gm33
         EVk42119+EO0mQYKbZ3j7cAu8OhW87jQWv8nZg2cUTxn6xIo15rl9asGixddknCGxh/t
         RN5t1lSpJEjvJMq4uMeSMEOB2hYhIWTlX2eSSBOBdINpD0rIx6EyjdbqTTLOBDGh2IYz
         UvfPErUOxtTkXqrMlSMuoelGSvZSHzMDE1VTaCT4GHwBB4TVsnaUxDsFRHOE1lKwup52
         MA+U5zre+1Mv8vcw7rxat9JT9UKgbzAMsIFPEDPo72wL+3qZvqEXqqpgs0UJCvjuIpV2
         H63g==
X-Gm-Message-State: AOJu0Yw/KPPiFw9BswbUkpuBldHz0FRUgU3kfphd9UP4neVzDXQSL3Xs
	Ef4G3UXxScAQkV0SFHUahyqW4fd+eW24EIDfJHLA3FL7Z6SdeFcwX6oWmowOmcIS
X-Gm-Gg: ASbGnctC4mC5zlP7yxVkIFsMsWJYyD/rEP32ewXKQOjHB7vJlB9RWdqP1C/wQvXyWVs
	OsuKDto9SjWZSDws8MRA2fW+tF3adGNRRwEmDjH+UqYHhYe+8zzzwo3LYkyOtMhJxN5z901h+6w
	PU3uaTbgNHitBVolqp7Ndh8w7W87yaxFHoZQy9KFtu9skK6WyrprcYgHfDDJ7JSVAM7WnUz/bWd
	d68KNFPyOVl8Jo/1QWWMzhYDykWc7CIkOaNyN2Ua6WTJAAddLIKCZjtg+/N9u91mfCkr51EqnU+
	uCHsaHw/MIJ4Zpk7uQW1mVBkDt7+BLoQ9Y4aclJk9MsPAE5GQfmL1NuSk5rmr/NpdX7eMYepL9S
	PmAiarVDn1VN3Hoa8qEp1/O4/uNkmhX9OtK3YBS10QdqFLs6BONVXV02VqfWmkKZURVzWDqL4oY
	LcBQeddWz+knL2L0nNaYHLTw==
X-Google-Smtp-Source: AGHT+IEHSKHsiRZqynSqJrt3dPUmRM03bePpniQMubUnp99Gzx7fJ+iI2PEvs2CkE9jbxNq/Xbd7UQ==
X-Received: by 2002:a05:600c:4695:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-477308be7b3mr31572655e9.29.1761907794096;
        Fri, 31 Oct 2025 03:49:54 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf7d07sm19498025e9.9.2025.10.31.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:49:53 -0700 (PDT)
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
Subject: [PATCH v4 3/5] drm/nouveau/mmu/gp100: Remove unused/broken support for compression
Date: Fri, 31 Oct 2025 12:49:22 +0200
Message-ID: <20251031104924.10631-4-mohamedahmedegypt2001@gmail.com>
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


