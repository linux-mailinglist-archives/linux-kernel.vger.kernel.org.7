Return-Path: <linux-kernel+bounces-893505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BDC478F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DE81887D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C927272805;
	Mon, 10 Nov 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="DVcN4RTL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478B258CD7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788788; cv=none; b=XgqboulxILy+Yqj3rVHjJBYv0ASFVcOdGnRQEom0CG4mTtO5JyIeF6ECU8t8QtgHDyeB+zAB808JQnsA5UEV+PktKRQFe1LaxQ6ZGTVXOh3EawenCd9Kc5Y3v0JyU6fBGNth4T8sCPdCSfsj7Ow0LzfRcOgAprawKgzzjg8kjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788788; c=relaxed/simple;
	bh=1t/XeZGSz7klYVmp8UNRLZxTGb1MDqM4Sp4fGb+4iBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPn+VeSDidsMvKGDj9opEaZtSpPfi3sBZTVA9ZHOCvkWeYedAHUoXRNbWqVowbEfNXPln6px8RI+kOR8QNTz0J4Sf4YCLmaOyh+vOM5YWKzbj7wtLsrBxgE37bIc5NdgrzuZeDxutiIxU77aMB1fZ506fbk9NDGhpmlABf6B0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=DVcN4RTL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b64cdbb949cso545040266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1762788785; x=1763393585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lphwm18lHOH8GUN+4yFjFjzr4xIhvT5dzK4hQnRKziE=;
        b=DVcN4RTLbnH5X65cPcoQwd2CW1eFigmtyuQgIUIvNcTSfEDIDd4YhO0G3XBc2raIkd
         Qa5AkBgln82nzwOrXbIfg0dlpu7z/ygx2ATGxqhxQE6aR+n7p8uDPUBxxpo05xyZN/Ls
         zb8DUsv/NXgjdebOKB3zptjA1yTybfBjxM56IJR2UlrfYfSX7O69AyKGaVo4Y8F1Z9/C
         Tk3ie2k7Hxq0+UblUtBnRKK49b8EXO6oIuS3sCLHposfq192NWCY/BqPWgAZuVrOx/nE
         ESXtsY7STx4kmDRVOjwYIps4ouJt90cvp/8ppQlLi7+iEvIkAFi2sndQXwM+M/J/cuEt
         zarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788785; x=1763393585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lphwm18lHOH8GUN+4yFjFjzr4xIhvT5dzK4hQnRKziE=;
        b=N20ST4b49ij4yRUltiq/uNpsC6dyzYy4BiVlBeO3ITKhC9Hfn+yy1Rn+drjy2XOHfd
         AoV2HYgLkF1qA9WoUzOTs0ZGrnEklnas0BI+N5GajD1j0rbseWxp16TbRi9fFbdQT6ox
         2Zxx++4GY0qnBEqcjvR01UbXLNlCkEKcUc1ePC0OHl2SqpZS15VLYh0yO3U6ecpbQzpU
         AfRJTfxRYWwR1Eeg3PsKyYFUdQyCJbehLKK/0Hv8fWo5uHWJZKQdN70pS1F1fbKTJN6h
         5iftZ0j3ThBKIGUtUJ48N7e2wF/DVXElgxKVIF4s+W/bct2t5NqQQIumroQWggAdXfdb
         TpGw==
X-Forwarded-Encrypted: i=1; AJvYcCWkb4YTXzuWe9SSXD6hvj6nkF2B5fd/t7KXczdCpYVtrflGDqTy+ehva1pwV2kMz5elV0Z5rd5MVG70f1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/klJpn3DIP5Y2idfS8zuPK691K9ps6CSAW/LnzWWYHWI8+hAY
	Yqjjaq/nlqB0TvxNVZVSXAC0uh8vaw2W58OvByp5lLT7EMnjhzhN8FNlfEXgvDkNy6o=
X-Gm-Gg: ASbGncvTJiKfUdP9R/xZxUjF2Hwkpti48R8NJmCXX2ZudEWoA+cGXHAsdarD3hyedI9
	kfjKqDSHls9Bt04u2uXTqIt5bjEPsZ+OHoHLGpqEMNOrK5nqW1cNoc2Gtdb2ENx/GGI4bMsrYZH
	8UBcIEG9uVs0MWRGk6vXAVkZebDn7ERQGqXp0oNCbN3u5rasQh//+op87adjiBJ0asz6JByxItM
	BzYcS1U9SioVtKUkj1gdVwoxVBSfpMhT2AuMF3osfGQrc445IBO7GfdprHV9eGT/qVw1bvjluXa
	jDEYrU9CKXTi2Go0+SWIQNSz8MKmcXMOBcd+4fUxAukxIHr4O/IL6B3eeaKLd0/8w/iAU1kHLCb
	Siz3DI7L42DEbTOanfmDWF+mjduj2a1wCIQFPmk/2gyXocf2PF6eGhAlrPRjkeBxnRNK0Zha5xs
	j/DFGNFI159i2wLccODy9LvMdUCqqGPj0srmSatUasct4puBYwm/fTN6UDrh12d3j97D6FyWg=
X-Google-Smtp-Source: AGHT+IG70p62xu1Iuwa33zY/SzOofNGuNdD0jOrfLb2TRpLg/LojF9DWIwzRCiYu+VP8gJxW9BMb4A==
X-Received: by 2002:a17:907:9807:b0:b6d:2b14:4aa4 with SMTP id a640c23a62f3a-b72e05ac909mr786170366b.63.1762788785220;
        Mon, 10 Nov 2025 07:33:05 -0800 (PST)
Received: from [192.168.1.42] (2a01cb0405e83a000cb38cfe29807c1e.ipv6.abo.wanadoo.fr. [2a01:cb04:5e8:3a00:cb3:8cfe:2980:7c1e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm1115978466b.31.2025.11.10.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:33:04 -0800 (PST)
From: Mary Guillemard <mary@mary.zone>
Date: Mon, 10 Nov 2025 16:32:59 +0100
Subject: [PATCH v6 4/5] drm/nouveau/mmu/tu102: Add support for compressed
 kinds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nouveau-compv6-v6-4-83b05475f57c@mary.zone>
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

Allow compressed PTE kinds to be written into PTEs when GSP-RM is
present, rather than reverting to their non-compressed versions.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mary Guillemard <mary@mary.zone>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c | 46 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
index ecff1096a1bb..ed15a4475181 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
@@ -109,12 +109,34 @@ gp100_vmm_pgt_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
 	nvkm_done(pt->memory);
 }
 
+static inline u64
+gp100_vmm_comptag_nr(u64 size)
+{
+	return size >> 16; /* One comptag per 64KiB VRAM. */
+}
+
+static inline u64
+gp100_vmm_pte_comptagline_base(u64 addr)
+{
+	/* RM allocates enough comptags for all of VRAM, so use a 1:1 mapping. */
+	return (1 + gp100_vmm_comptag_nr(addr)) << 36; /* NV_MMU_VER2_PTE_COMPTAGLINE */
+}
+
+static inline u64
+gp100_vmm_pte_comptagline_incr(u32 page_size)
+{
+	return gp100_vmm_comptag_nr(page_size) << 36; /* NV_MMU_VER2_PTE_COMPTAGLINE */
+}
+
 static inline void
 gp100_vmm_pgt_pte(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
 		  u32 ptei, u32 ptes, struct nvkm_vmm_map *map, u64 addr)
 {
 	u64 data = (addr >> 4) | map->type;
 
+	if (map->ctag)
+		data |= gp100_vmm_pte_comptagline_base(addr);
+
 	while (ptes--) {
 		VMM_WO064(pt, vmm, ptei++ * 8, data);
 		data += map->next;
@@ -195,6 +217,9 @@ gp100_vmm_pd0_pte(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
 {
 	u64 data = (addr >> 4) | map->type;
 
+	if (map->ctag)
+		data |= gp100_vmm_pte_comptagline_base(addr);
+
 	while (ptes--) {
 		VMM_WO128(pt, vmm, ptei++ * 0x10, data, 0ULL);
 		data += map->next;
@@ -440,9 +465,26 @@ gp100_vmm_valid(struct nvkm_vmm *vmm, void *argv, u32 argc,
 		return -EINVAL;
 	}
 
+	/* Handle compression. */
 	if (kindm[kind] != kind) {
-		/* Revert to non-compressed kind. */
-		kind = kindm[kind];
+		struct nvkm_device *device = vmm->mmu->subdev.device;
+
+		/* Compression is only supported when using GSP-RM, as
+		 * PMU firmware is required in order to initialise the
+		 * compbit backing store.
+		 */
+		if (nvkm_gsp_rm(device->gsp)) {
+			/* Turing GPUs require PTE_COMPTAGLINE to be filled,
+			 * in addition to specifying a compressed kind.
+			 */
+			if (device->card_type < GA100) {
+				map->ctag  = gp100_vmm_pte_comptagline_incr(1 << map->page->shift);
+				map->next |= map->ctag;
+			}
+		} else {
+			/* Revert to non-compressed kind. */
+			kind = kindm[kind];
+		}
 	}
 
 	map->type |= BIT(0);

-- 
2.51.1


