Return-Path: <linux-kernel+bounces-879248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37DC22A24
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C3D1A64310
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBA33BBC9;
	Thu, 30 Oct 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkaMNaZQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0733BBC2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865479; cv=none; b=n5RV1tYc15YcR5o2Is68Zk82nk76UN5okJHnzyNGc8wmt4bnvbRnWoISAKrN7PBvrtnRjiV0LJ8xwAy9+JSKlc8HRyK5oNPn/5sEaVX/ffkn7sNpPb2nJEEF9LAXxQjjjhLo9u+DOlH9wbccFrhH7C1obyuTL3oiF/bo2d2XwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865479; c=relaxed/simple;
	bh=0SFro9VCn/x/43W8JdCw6cLRCKyjciSmHIPP9nWwbSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIS0wNZaEKAv13As9i3HlnxGG9LHlivjTwPBH8WF+G7thuoqT7KJ7sGcbbn3gDsUI5X1AEVXnSkihMpy7JYSeZWA/ufEgikx1M/HMZZmujRJeEIzJ/QUx/hik2uvxv+fRXfc7CkBDk3Ab+CXPxG3YklnEPBCM9iy0Jw678uD5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkaMNaZQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47721743fd0so8741635e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761865476; x=1762470276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzdi8nfSSs1sZofLN+Os1wqi0upcCWxbMTjLpxylR+I=;
        b=hkaMNaZQg5B9bwJUZCeuV2hMEU0Uw7hPNQwsVtYGhGc28Ad5fLw4ww7QtKZNjaXvWE
         W3A5ACplXzLIwMjZhM2liUIoz5fNqvbqUnJiog+jM28l/etnT4bTf6RBpjh1Dw7qtk9C
         BglbntWD7Rd4hrrRemdjTz4EnOj4lpuqyEIGiy+ZBpvm6qN4gafuKNvf6crQkNdvT49R
         KAZLdBMHG0jD67UY0pzlJGaRsVr1k9AyG7iUcRTCYtq6qvPSkoYgc3lpi2fCqXy8hHTn
         J6tLXedgLBk/NgdZZT6B0P6imS0gZrJvoXE+xhQGHuUpEjZLq7EOpeyG6hEvxZiKgUUv
         8QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865476; x=1762470276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzdi8nfSSs1sZofLN+Os1wqi0upcCWxbMTjLpxylR+I=;
        b=Kh3Z51aSCHWABKHw4PSsfTPjfW1pDDWtr1I6ylY8QbthCK7xzYHwoTLYVL9NzBYE4Q
         bTfoXMoyDqIHKRPyqVcYmM8QVzAre552ZBFaBnWBrUrdjSFKbVrcINROPMpBHJgHT/dh
         KV2hRGKYQkzpZhUVahKPNlrCeRHhtFuasqKVp82CkrsPvlClMLNOgqY1WPaK/7w4wEHa
         CWTlKAnv8qgaBTHxBmZ9VfAWHL/39ZDcYjvoMByeih+nzsWrEatgS8HjUCJy4MTpdGKm
         KCqlbgMY+SW7bnrzE0a2ol2CDoeN8KrXZ/7jyXBf41LGyjx1YAIkNyUMAHoAY28boMF9
         9+NA==
X-Gm-Message-State: AOJu0YzLfEeVo7Xp5zABli5LOewcPjXJz32CFmyEXjoiN5vDV/ACbWFn
	EupkY05qLNCn2MUowsR2at6WIm15dMLKk9vF0kQt5n0zdwdOiBkGFGBf5sCmJ3S/
X-Gm-Gg: ASbGncu1WEdNlw+1uagNi0Njl+ibkwhyI08hIiW8imsv8ktmMV0gnzqAj+IgBghInAq
	YGwPtX0jE1BvynWuzYlkyrSSqjbhuRGiyubvH3Ut9sIXiWJuLzy7KOQ5WdcIW7BeNaU/3qv4aeF
	3r9lIIkOrdvlsX0d+ZVfb/gqSLte5MQDhFbNh4ps7Z4G7yXugWl2Q8Hq21HbGz/hzZMaURq4lPA
	zt4W864NqSC4Lhd9Ce50j6ue4GEhGBsx2ceBk0zMRGsirdjQHUs2iAWoBOm7Qd6aKlsR7ZAfQEb
	1naaK7CIQSPqjikBFKizqD/VC4PES8sND4+4uVfb3en1UoRORV46VBvdIFFrVAFr3i0ldzwrZLt
	9j3rooKoIe9nIlTUZg1sjEktbE4Y9hA6FaNlaDt72HHM6iHT9nhjCOfj+3COQprDrCSwuW1yWDk
	BVz8XXhbssyr0=
X-Google-Smtp-Source: AGHT+IF1so7IsZ9CcfqAXskg5gm7+8a7SRpdoFYm2WfU1UNPEHE0EN5YGGHblVJH7Zxh/5bqtSuH+Q==
X-Received: by 2002:a05:600c:8706:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-477308b0a8bmr14151015e9.28.1761865475936;
        Thu, 30 Oct 2025 16:04:35 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8235sm2227025e9.14.2025.10.30.16.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:04:35 -0700 (PDT)
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
Subject: [PATCH v3 4/5] drm/nouveau/mmu/tu102: Add support for compressed kinds
Date: Fri, 31 Oct 2025 01:03:56 +0200
Message-ID: <20251030230357.45070-5-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
References: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Skeggs <bskeggs@nvidia.com>

Allow compressed PTE kinds to be written into PTEs when GSP-RM is
present, rather than reverting to their non-compressed versions.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 46 ++++++++++++++++++-
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


