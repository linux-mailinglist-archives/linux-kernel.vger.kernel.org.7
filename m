Return-Path: <linux-kernel+bounces-891694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97929C4344C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D259188DD50
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D128643C;
	Sat,  8 Nov 2025 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O54T8x01"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F462836BE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631417; cv=none; b=lx8aJtNpvuYtBgdKm/BaQUetkRkQh+s+6JHX2c8JSjpyUIK6tWMPzxb4qf04j69Zt3otFMDlMc4clamZ4w0Ob7ugPT5xJ+USSiUZ0M2X3ySaIXrIRwfFO3Xu0LphXZVOtOzQjn3FA+NNLI4iqxypX2tDleUy0MrZ5iv6S5MPJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631417; c=relaxed/simple;
	bh=pNgwOBgBk2wMiFrukjS9HtqBAxX5pCWg75gT1vVjMXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uob4fI6lcYleP+OdCf5oJg22+U9H5V9MlreOwEia7G1koKbC92a1w4OQVdkQyWn30I5VT+z5DGEoFnyAEKwXN0bu3w8jKf6EVKFpkf+zlHvSTqXx19u6hXfDkkkgf9FTCe7OJ+PSxgfICbvoO2hUwH2dPtE3zWzLc8MJw4jbLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O54T8x01; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471191ac79dso19215875e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762631414; x=1763236214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtdKmJcqO9zaIwqI/14ufG9W4yGZnpTrnplEsPvtN6c=;
        b=O54T8x01mNAI0TmPw4n/PNVMdbrv3/kQq6TPnpTzd9UdRqX+yeUgjJeZQ6looC4Bsz
         fAueCBxWkPfm0vK9wy4d98Ed8Jxu63R0tBwXmmlFrSZ+15sJwnRWDFYUVR5+oqFf5b5S
         R9T/DtQqYwSq3RwhqBMl6jLV9qHe0nvQ3/ilcIwgPFVT5YaB9ptvyhkZ/WYWpU/4xr4b
         Y/1E0FGBmtx5ui95Dp/S1iTbstuVzg7n3S6zOW3I4jReTO9akrA4GIH1+UDIjDrBu0qn
         jDvRBLqmbWVm7UtDraQ5f24+bL+0B+2uVXOtvGaqor0ovfWBn+9xvawokBONAhPIWlbP
         0aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631414; x=1763236214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtdKmJcqO9zaIwqI/14ufG9W4yGZnpTrnplEsPvtN6c=;
        b=eemRVWRYs+6NqoP5ZPSuEcMjSVKTMcXMuwG0zBKR07GX5PolbqajcZlej1kVoPIgyv
         5g3Hb/I04dwBZx77Ur4PpLnzXOYRPIuZ46FEHJPt9j84HhljMWqyLqyIZx5sBX8ekhur
         qWNm5goOQJAjuqBq9FhMI6yb6JkKCeKGuXuMiYEexsHatFMxAGb29qWDuZ+6kmG3SprH
         jWPmGvX5yQxnqpbTYtq9lzmhcO5bX9QHoDiUfsZ2FS/PSgofCBwPuJKXCQodpM4oM5VY
         jHUDDCb9G0oJ8m8cemk0Swza4fx98WDWZQqPjFtvB9fu1zHf6yKq0aB4+VXWRGPBRwJ9
         N9Sw==
X-Gm-Message-State: AOJu0Yyamf1XblIrUJUgT0T/lk52Enc5s9VVlU3KHYJhrgHm1/uAkGU8
	LzJL+ZiPeWWp13V/jaIK1McvXey3hC4dR7YWnl6Pa/xjp8oiEcvR60upOWTVOg==
X-Gm-Gg: ASbGncvohZNWMWpXuUdfNORyauTDwCv5pyoIuh2G7CaOe9601VR5m2J+jb5TaRFJKe1
	O0CewlVENwuTVBmrTTcinid1XAbJfWgA1FbyIoLDROMifvThaLdUqKjFOjea/PfxhR1YFP/AP44
	upWie8TagbchscbMJ+DvalDUbNJY4ORgHdIrenXc/uXjcCNXbiXhPb0rYDwoGzdIsw2Z/zRTQpX
	830TXB7SWX8tNWassowsbbjm94KpZ3MCJuTB37OkvJ/MJSE4SpCglvYJznG0GfHMhbLPtvN0IT4
	beZsxrSa0j+OHVGVDfeq1m7UrxRHHUpONfxskO48DMSP03HyyjFPZP8H8Kac0YRjHfpBVl+Xbff
	tUZC2Pdi21faVZgb8y8G2pIY9f2qSMwV7hGfx2LiXLkE8mLGn+L2PIq0OJJ0+6eiF73KgzP7Z5v
	WzSkkdzi3ThNKHwh7VlWlS
X-Google-Smtp-Source: AGHT+IHLDsB59QWASihliDj9gIsX+r8OWcAsgYDGHKKuet7SX9VhC3x8d+fQ/Gzbhl5mk70HXHn1uw==
X-Received: by 2002:a05:600c:608d:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-47773cc8453mr18802295e9.26.1762631413614;
        Sat, 08 Nov 2025 11:50:13 -0800 (PST)
Received: from fedora ([156.208.73.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm233461435e9.1.2025.11.08.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:50:13 -0800 (PST)
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
Subject: [PATCH v5 4/5] drm/nouveau/mmu/tu102: Add support for compressed kinds
Date: Sat,  8 Nov 2025 21:49:18 +0200
Message-ID: <20251108194919.68754-5-mohamedahmedegypt2001@gmail.com>
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

Allow compressed PTE kinds to be written into PTEs when GSP-RM is
present, rather than reverting to their non-compressed versions.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
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


