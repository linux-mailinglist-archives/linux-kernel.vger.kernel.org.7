Return-Path: <linux-kernel+bounces-847570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2ECBCB370
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C87D1351E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E3289E07;
	Thu,  9 Oct 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtDKU8Li"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546628C03D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053189; cv=none; b=pMk2A5pbom1WTBFUyDrZjkKIE7PEFJpJ+29eZqXgytcpxSqHCB7gLaFROw+H/GrKmJfqvMne3FLqdVqvrPnlFqxJZBaXzz204iYci9dxZG+kAHpqb6L7X6nk41L2bMMDg+lg+u7CJRuvgdramosnfKIayRUetiV6YheUb/vYnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053189; c=relaxed/simple;
	bh=8VPAMaQBETO2yjs7C45RwpZmClyUw0V51lsKIvS8Qt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe8dGIdcjC2zEEtfUQlehpyccifuHjxrS7ewE+MwR30/NBtY5L63+6haK5y0eACMhp8ouec4buy0SgBg9j0VyYPho11kHBIU1TQFz91hDp7+PrdtOu5g41yPzNxjCfO3OL9N2+d+jIYSjhXolW7GLABw/GIAvFdNqDXskpL87+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtDKU8Li; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so8129735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053185; x=1760657985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61fl0QmalDC2B70Ur7984Y98C8MPZlXSrMQqbp1jaho=;
        b=QtDKU8LioM7tsO2TeOUXSWCuHtvsU3RDtggco9pg/JzmO7tXZqNfbkWd8NoCReHtA3
         IHJvR+95Jl/FvIwCe7I37HdZ8tPWjFpMgyAt6hPCwf5u002BcLA0mcfQDtkmx9OFT3IY
         O7L/QwlpAV9bvGy9lx5ir0uwax+CcdJIJxEKxVv0tZ9vA33E5jm3FoCVmt4Kx6n4+bDz
         4XoBgf8VtRWy8+wigw9RYuOB1J0Jk56Hw3DBgfGnqRVTI3Dd/59cMX79wEYjqeI4OPBU
         SZB4E4rW734jle5y8fAtTe8fCMw0EKuhiz4LmOaC/dCJHd/GddK0qfaPskoH3SQi8QFy
         hnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053185; x=1760657985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61fl0QmalDC2B70Ur7984Y98C8MPZlXSrMQqbp1jaho=;
        b=B3yCgkqJH9rtjdmoDOI102I+8gATsjfqwzLt7+AN2IZGilUBK3Ek83bkv1ctOBE2jj
         80RzJjNPXSLa8QTs7lbQhbO9ERx/C4jSNC3Q3+RtC61c9nlitzPromYXpKt5nqLz3oAd
         DyB1LOnS+7UavkW479YJqP6Gt2SHKPgSygR4OdXbQ6hxJT2zpe1kSW9/c696hgYbzK+H
         ojULdHi4L+JoGB+arm2s5t5yDHiF8iBJlQiqw5Rb8ITEvuVT7TSPq6hpmbkheVt5LMNW
         JdIdBI3FxnxaRqlZLcP4YdN8BYw/f4nIgYAMLRS3X4fDRlo6rqa0TNbvbwzi/cihM0ss
         5O5Q==
X-Gm-Message-State: AOJu0YxbF5kixclQKBEljQMpctyJguxRPhfSEdSNSLFQ3NVLNHSCPT20
	pSm3zN89wAsTzWxHkjw4AsOHYZGOIac0RB3vC2ROSJoho3/7BQidEqn0uWWzJA==
X-Gm-Gg: ASbGncszsZOxQMddu2Vd81QwXNk8wvHuU0o+/z5LgMQKKF2BIIPehRHiuFz167kRYPO
	5Ql+KbSz1Fwm4j+HOBya2PkmqSPPRj19E5YI6LgkgPtH/CAPFCFo+Dh/xpCZrUWYuE8jT1sPh+t
	cIEhu8Hvk6C0Hz9jNUEyyhxuydzBJZh8z/yetzXM0hBu5wzp7z4J1jnjt3gP7Bex7e3tztygK1B
	g/IqqKg0AwibHXtpWfyNv5o42docbDAd3Jtmpm6LH57WtHI+ujOVttY+cuibuKHjGz8EdMis8+P
	1C0qPNjtQJtG/DjJZFZjuT/w7UH5RNw0gBweQbzGaHPh2W1flI2uo0RLFKh/Q9bxnnEhpZAfNUA
	pPTI5XdF+Yp78s70cVXA+ZhbepFxOeAhBqoJur3dHYhF3n39SDO2G
X-Google-Smtp-Source: AGHT+IGKhAP1SwjKQyd4gXEeUKmnVqILTkgIT5bozEqWpm87eGAj421N2AI9bjTAYBj21oh0zBP4/Q==
X-Received: by 2002:a05:600d:4384:b0:46e:6d12:ee2a with SMTP id 5b1f17b1804b1-46fa29f5e70mr60200355e9.16.1760053185395;
        Thu, 09 Oct 2025 16:39:45 -0700 (PDT)
Received: from fedora ([41.45.27.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm46066075e9.4.2025.10.09.16.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:39:43 -0700 (PDT)
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
Subject: [PATCH 4/5] drm/nouveau/mmu/tu102: Add support for compressed kinds
Date: Fri, 10 Oct 2025 02:38:36 +0300
Message-ID: <20251009233837.10283-5-mohamedahmedegypt2001@gmail.com>
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

Allow compressed PTE kinds to be written into PTEs when GSP-RM is
present, rather than reverting to their non-compressed versions.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
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
2.51.0


