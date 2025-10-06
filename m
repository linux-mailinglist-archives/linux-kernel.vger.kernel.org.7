Return-Path: <linux-kernel+bounces-843387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A357BBF147
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E356C4F10B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0A2DF122;
	Mon,  6 Oct 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLF4wGWv"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A32DF121
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778067; cv=none; b=Yuc/gTbalcaDbBmm//9HuzIkajWGhRa6JIITVBsAtreILxL2q8DZyGOryZusjDcA1BXsA6zPkHe+INc4+MeOudWiiOtjm5RlZab7qdMleCYEA7oeldB7sK5Ms1a0Lbi8fuqtbLACzkJNrIVPmwvFA4nsuLMSpu4WywItk32eHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778067; c=relaxed/simple;
	bh=Dlo+pHo/tsptPqgWvl507lZJ6JhUl6TykLFinf/YZJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZYxjmQHdBovIrW5dv/KIQiFhVQ2o+tBlNM5NSjBVPiUFka6Yu9poGvURro0iYUU139xN0nUmfArCHnWxWXJ78bL43joXh2EIkLHNZy1+o7SwXAK3lLV3rskHWn4RX9XvviaOQYSmVcL85WnsLclZ2izSddgnoLU+l0EmSmpNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLF4wGWv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso3498571f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759778064; x=1760382864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTAULiuztj0Agha/BlSN2X8C2BFYZNs5crXxh++Rvjg=;
        b=WLF4wGWv6v3UZZ2/a0S90wQX0ekgcRMyDxBv1B8zaaKVvm60/WhV15HOdH1OwGgZLn
         4DuuyVd/pusqyOLypO9F+0ha50H1fuH58KF5SKiO8EVZVTZnsxsVawN9J+n9ruYEDKuQ
         vWDfDDK6V+QKKI43ah8poSBJoGl5Aw2CDQNs6g9ReRBKVVZJO1Yfy+cWlkLiORjmmfHP
         PzHi2rXOZQ99vxrVxH6px4R+ovM+8/yyvTcX77pIYOtn+ya/HNAo30WlmSSXWyRM2rFd
         rGqS4/YNkHYJB3Ffwcjn2+d+5uvjfkUtU/KiAVGqXNgrpaaW5mexs9VCzc++uGR1Wyed
         43uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778064; x=1760382864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTAULiuztj0Agha/BlSN2X8C2BFYZNs5crXxh++Rvjg=;
        b=X74Me9vasmwVksgRo0TtmzlObIZKKAnqa9u8sRtqrRon3UzcX9dLrjKom43MopIdEQ
         +Mw546O5Sbn9afJhLNI2zzomFuos2lbN/SSqugK+NkyEb3PoFSfKaMPdrXeJ3gMU1jo2
         nrsO2iFAxIi3d+T4PfQhtH76mna1HwCWvCGYNEzWnLomNKn3m2gAIVSdVCbe4SSQvruG
         TN+2HflC9vP38QfgLEI5aBleBKBTMr+F4JGqBbd6s4y5igqDnICoxU0L7fwIV3NepfsT
         jd+v+aobV1auxvRuomQHgUdprmKcYf7rPuVIT4gVS7jlDPQMO3tUyR1QIaewgPmif6qm
         Sh3A==
X-Gm-Message-State: AOJu0YyKT3/PFNPtIDBVhTzY1mLEXlkwhnGmXEdef6ZDVULeCGD3MTV+
	6QMYePkwS/y1HcWSPdhk/MrE/64EM7Hz/LO9FpxgPmn+Sy8YqGxtwChpjycDXA==
X-Gm-Gg: ASbGncvMKvc4B/wT0HglJAarKh/JUEaBQ0xFiAXlHJELjHpF3MzVAs4YmIIoH95QKgn
	aqIwUrgPRKWwJBWffYiQvQhzo9Y1yCUpvzkkPo7oZtbPGdpOZ0/n0fdXC4Y536Ooo2Pnd/thRbP
	6dsbh8Lazto9uaUDGtiMLsphgIe987Lmg9jwOYOfZWaBbxzQaBmLoIh5nXkH5UVqaJ8u1Qaubde
	saZTpnKVA9dFHIwOd8oHquMt79HpfyxJ+wRvm4n1N9i7bSlWG3kY6RXjQVTWsjFMEn0HT+n47ep
	OKRGJz5nKpO5BeORXfQV3+rwh0xeESOwuoiI/F9xcLXrj2pdZ6rrrwY2iaYQdb+8G5TlEzKyY50
	uDzxCNrmawRJKmwC0GsqkuccR/Pwb4jqiexQaUuaqKg8Hla/Z3YP2+GQt2A==
X-Google-Smtp-Source: AGHT+IFxV7him0HZhacECWXwTdjy1PuaFOX6jioW6BihS5lIl+hV4dVQt7up8H4JJKnMcGudT+WEzQ==
X-Received: by 2002:a05:6000:2003:b0:3ec:ea73:a91e with SMTP id ffacd0b85a97d-4256712a61bmr9129477f8f.12.1759778063608;
        Mon, 06 Oct 2025 12:14:23 -0700 (PDT)
Received: from fedora ([154.182.208.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm16646435f8f.14.2025.10.06.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:14:22 -0700 (PDT)
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
Subject: [PATCH 4/5] drm/nouveau/mmu/tu102: Add support for compressed kinds
Date: Mon,  6 Oct 2025 22:13:27 +0300
Message-ID: <20251006191329.277485-5-mohamedahmedegypt2001@gmail.com>
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

Allow compressed PTE kinds to be written into PTEs when GSP-RM is
present, rather than reverting to their non-compressed versions.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
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


