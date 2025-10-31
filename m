Return-Path: <linux-kernel+bounces-880002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4630C249DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 588633509A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC08343D67;
	Fri, 31 Oct 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5b23FJM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518A341677
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907802; cv=none; b=dPOCwE8v4xGHUQPJzbV6ejJNxIh2gQARw2TCsXNCDyi6ogQg9XSIEBn8O3GgZvTgmMlC+EGuJpe5Pi3PCZiJox6nA0a1dNMNWkhfoai3/ql6W3mgASBVqdprhh5rqw6VG98BAl6G/4yWGrzoQfEERgImq1bgCK9oz5g4XzyTkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907802; c=relaxed/simple;
	bh=0SFro9VCn/x/43W8JdCw6cLRCKyjciSmHIPP9nWwbSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbwZGIJZgDm1u6LSprGPY0mEq2zDRM1J6+xKnPBUTRHw0Oq7wFEGazVaPveV/f5SwLg3nSgTg4u1L0vXgWt0kzejg3qTzDjTKr27itpaFHHqiEzJPHV08RmUX/SRWRuwCyfpcQtaNDXSCrOvP4UN6/+oagIbjocVFy1mPtl3xqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5b23FJM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471191ac79dso23213805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761907797; x=1762512597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzdi8nfSSs1sZofLN+Os1wqi0upcCWxbMTjLpxylR+I=;
        b=E5b23FJM+BQH6tiUaq2VkUwaz087S/n3fSrpSC++mvjQi1p7kilh6kAotmd5eCekkY
         Cfh5etr1mSucYSAZiH0fWiuWgwncP7DYURGQ5DF4W93rgctogBOZpceL5zUVzdUYcVpc
         i/IRmk30eIg9rVDZlt1Fcfv25shbnRnN2A+nQKY1P8Lg81C1T1v+5nmxuFmjXk6ljZU/
         A3/4n4lqEW6fN/bFx6xWMWbipTNIyWbETD61aVOtzNFXHgJR2HjXl4pUmBYPDT6Bf0Zz
         6nkLqJmsPwvJ/YzOFfwEM/vm2TwUgzAdYdg6xtOw8ZKQVQdCy+dOe7bnpqSF7+LFQN9C
         wtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907797; x=1762512597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzdi8nfSSs1sZofLN+Os1wqi0upcCWxbMTjLpxylR+I=;
        b=BSgPpWoGcKa4qN+kCdp2iEqqalIHuSLZLUiEW4vBlYRZYRxtawdta9rrMj/146qtVX
         mjhc6fMMB81Qe9aumfAO6klWUfXRVikVrEsD/zNi05kLNC4z99b68cTN2ozjInuz34Yb
         +rK0u0XO6rJChcn3yF6hVMx0H1DdZpY7399J3Q8l/Hw7D1I/yH+bkiRABzCqYtOXMn2k
         XnpBPbXnX/IrOD7bCY1Uc6cdsViOqepyZFf5AHybFzKSMh9qH7zZve1XBlZyOUqV/di4
         LgY9JLcCUq7QgbjP4kDoY5Bmin+F+9ieCpoXe1e4883qlNyVw42UgBlIyXrR37kvesru
         58pQ==
X-Gm-Message-State: AOJu0YxY3n3+N0dDTyYiO5DxFuG7XMvsP2Cjlmj3JQ4M+rSJhEQGq2mR
	ryxJr1mi44VlPr0bgNRLk/8gglkN9EwE0W1yQVuqNUKQo4T3AQnKhBS/iIesusqq
X-Gm-Gg: ASbGncuzAmu5ZC7APhddkYL99FDbMyHwx6SYCz+749XopyjMU6IR7DllwJ+hRl1sx9/
	ijMaa2ifrrqwObeXG7oHzOLXO/KvRbGq9pZlLWsOo9dAS9Fy45ynnYYTXBBx4oI8G84uumMFMuK
	lPd/Q+5Avs2nSMkP9X6VgPgYIW2gHvlpUTSCyl0bLc7YkNcYKtspR8krHSw1vHQup9On09/bOIf
	VJE3Qalr6vBlpLu6qCagss7vywD1vll5hW96+m0xmXAmA0HN/SVsKviCrC+67N17eLAXFKEbf6p
	4Qmbx4/NmzV6UyIvLDlCwDUaX3rGMYuRh3mbHINLd3iD1k2GwwLdTlE3C4l36wyerM3UZalLkHm
	rI8hxuOsrqh/qxc3vwtbkWVdyRkEKB2U0LB0zP+8EeA4QXAGTDj2V0i4gB6c2l2nFFtt2z/6YFP
	r1WOLB5HR1KnbeW6dCFO03WA==
X-Google-Smtp-Source: AGHT+IExqiXaV3tY1QYgyp3Vb/lFXZy9Ed+LjlywLCtsIPMBbB1MZkrDAGvWrVtUBRa7sksEKHFBPg==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-477308ce7b2mr30226905e9.31.1761907796910;
        Fri, 31 Oct 2025 03:49:56 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf7d07sm19498025e9.9.2025.10.31.03.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:49:56 -0700 (PDT)
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
Subject: [PATCH v4 4/5] drm/nouveau/mmu/tu102: Add support for compressed kinds
Date: Fri, 31 Oct 2025 12:49:23 +0200
Message-ID: <20251031104924.10631-5-mohamedahmedegypt2001@gmail.com>
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


