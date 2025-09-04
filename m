Return-Path: <linux-kernel+bounces-800176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A10B43447
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3F1586A59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB902D7818;
	Thu,  4 Sep 2025 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="M1iJPmrW"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDFD2D4B5E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971217; cv=pass; b=NVdpADuaF4KGkgKR3v1c04YeBH25GPmM+tj9kW6ltlE48V5E2VXTIb6kIrx+mrGNqABLbw/MlZTV/+zsHI7yM65P1uJ1nfyYHmbPhyLMWdZ0ZG9plhVC0YlZVEiD+v7z/s6FVgHfDMRUYhfziP1GxwBYJMxmje76NkwnAaOmuKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971217; c=relaxed/simple;
	bh=/tB7IRqQ1gYa/UY5/3J4tYcY59vzw6ZarodTXxQvPy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkayJx+25th+17q+KF2KxmdKyFm5otJy9TFPkhgeWkfTsV7VIsENZucGJH0K92FpUwdKddQm9VL0/GQa9mvcltWwHKxeM4Rfcv3kE0i8yW+FcIcFmOS+DrivxljahUOsA4Hw+NZEAbngNKLoUBe1jwIHQWtGW1kybw/Tm+MheOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=M1iJPmrW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971200; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KsWB9vhTV3Jx171RNAqnEnVTrYtaqvxCmLFaquu3v0X1FkKoAUUQG86t0rhApFALyjv7qMdLR184Jtwf/acDWB8WWsDYBsMFXrpMWMsbBvUJaGvIYcKvAQPCzCR1zkPm/KsYFoVFlaegCZRspiNiecpam9fj6CenrUX3lQvsDgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971200; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=raIDLtPMitmP5YW+m8SzHU0bUpzsLvufF/gSH5JQmPA=; 
	b=LraDAXYQAwxraei/RrcC2fq5zk+0J1oRtWm6hMfpkocyBwZMNq/02Ip6Rv5xzz78Grql53Ep+TNwkH2YRqww+C1t++oYObntYfwfQnyzAvCyyfK/MzHvsoC5qxQeHkbtQcLKvTB/Psxc3N6gJ9OdeiVVGbgfI5nJ69CzNbgY0N4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971200;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=raIDLtPMitmP5YW+m8SzHU0bUpzsLvufF/gSH5JQmPA=;
	b=M1iJPmrWwzzCgfwxSUSCRGhWVbVd3G/v9QOiXdIPkMlZ3sCRmV5IqHJuXDWrStv+
	3fOZ/7jWFoQJrzmFhHZA82kOI5t/APum9uY9JrLXX1Mmbs73+P7Np6r2fd8crHNSw7a
	l8+k4yVbJN08VpQ/Vm3hdHB4LI3MUnNIcqu59KQK70Oh7V/oeftcwr3g5kiOX12Odnp
	VchQzrux62ZTf+TReOkec7w95IYLhxaDquUCC0jziFZJdRykFTwvPLGzTwJa6zd1VUv
	oGcIgbWwKASKCD/tQfSCFi+c/D8aOnbVeU9qC+HBtbAOcp87FpgMSAoJ6k5Dj1nn47S
	3pwQDDy0OA==
Received: by mx.zohomail.com with SMTPS id 1756971198441434.76992287939606;
	Thu, 4 Sep 2025 00:33:18 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 6/7] drm/etnaviv: add shared context support for iommuv2
Date: Thu,  4 Sep 2025 15:31:50 +0800
Message-ID: <20250904073151.686227-7-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904073151.686227-1-uwu@icenowy.me>
References: <20250904073151.686227-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Unfortunately the GC620 GPU seems to have broken PTA capibility, and
switching page table ID in command stream after it's running won't work.
As directly switching mtlb isn't working either, there will be no
reliable way to switch page table in the command stream, and a shared
context, like iommuv1, is needed.

Add support for this shared context situation. Shared context is set
when the broken PTA is known, and the context allocation code will be
made short circuit when a shared context is set.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v2:
- Add the shared_context cleanup code in etnaviv_iommuv2_free() to fix
  issues when the GPU is closed and opened again.

 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 11 +++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c      |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h      |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
index 5654a604c70cf..16b89e72602a3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
@@ -63,6 +63,9 @@ static void etnaviv_iommuv2_free(struct etnaviv_iommu_context *context)
 
 	clear_bit(v2_context->id, context->global->v2.pta_alloc);
 
+	if (context->global->shared_context == context)
+		context->global->shared_context = NULL;
+
 	vfree(v2_context);
 }
 static int
@@ -273,6 +276,12 @@ etnaviv_iommuv2_context_alloc(struct etnaviv_iommu_global *global)
 	struct etnaviv_iommu_context *context;
 
 	mutex_lock(&global->lock);
+	if (global->shared_context) {
+		context = global->shared_context;
+		etnaviv_iommu_context_get(context);
+		mutex_unlock(&global->lock);
+		return context;
+	}
 
 	v2_context = vzalloc(sizeof(*v2_context));
 	if (!v2_context)
@@ -301,6 +310,8 @@ etnaviv_iommuv2_context_alloc(struct etnaviv_iommu_global *global)
 	mutex_init(&context->lock);
 	INIT_LIST_HEAD(&context->mappings);
 	drm_mm_init(&context->mm, SZ_4K, (u64)SZ_1G * 4 - SZ_4K);
+	if (global->v2.broken_pta)
+		global->shared_context = context;
 
 	mutex_unlock(&global->lock);
 	return context;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index df5192083b201..a0f9c950504e0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -504,6 +504,7 @@ int etnaviv_iommu_global_init(struct etnaviv_gpu *gpu)
 	memset32(global->bad_page_cpu, 0xdead55aa, SZ_4K / sizeof(u32));
 
 	if (version == ETNAVIV_IOMMU_V2) {
+		global->v2.broken_pta = gpu->identity.model == chipModel_GC620;
 		global->v2.pta_cpu = dma_alloc_wc(dev, ETNAVIV_PTA_SIZE,
 					       &global->v2.pta_dma, GFP_KERNEL);
 		if (!global->v2.pta_cpu)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
index 2ec4acda02bc6..5627d2a0d0237 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
@@ -55,6 +55,8 @@ struct etnaviv_iommu_global {
 		u64 *pta_cpu;
 		dma_addr_t pta_dma;
 		DECLARE_BITMAP(pta_alloc, ETNAVIV_PTA_ENTRIES);
+		/* Whether runtime switching page table ID will fail */
+		bool broken_pta;
 	} v2;
 };
 
-- 
2.51.0


