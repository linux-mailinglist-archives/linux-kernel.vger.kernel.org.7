Return-Path: <linux-kernel+bounces-800175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2DB43444
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C27B17EEE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC12D3A96;
	Thu,  4 Sep 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="BC90s7RV"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9652C0F95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971211; cv=pass; b=EDfV8i2mft0k/xHIrxA6ysi3j/Co47k7hsDtEkVHFUCbATy4t6ljjeLd723dKSyPQTwQGRiSv8PlIWwdQZ1ww/P3dOZIbKCHAqJoPjM2SWgsNEjMhPEZCJip25biOcZXqFUkWQOM7pKOsHjZ/M9DTnaEc6YefWKdFM4miI4HHJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971211; c=relaxed/simple;
	bh=yThojGq2htGeDtcw2fL4Fpoihpw/WLkZrvOBW1548IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBeP75vGijbO7Y0/aJXIgvkdGC4Xj7KtJ+me7GP/npsnDCLzhFnAMx0DF+Zxo+ussBRtn9FJeTioUj5p4/sjBgHNdXPVbKoaNMY5JMs8Ip/NclqHVoxR+mwIpY+Kg/3edSkgpDFK3aEc4NwjJ84WW1V5jC9MiSxEMSY8n9EkbRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=BC90s7RV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971194; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BZ2ckkvb0Mq/f9c1jiZADoyv5zTkliUo8FpglhP6/2G3APPBMALSFcVOK0dE7N6G9Tz5PwrDmS3B09yezVvrMsK1CiOx6k8xD+ppNRYnNfpOVyhcUUh0IlfesNFQxwfTdL73Uq5LU8oTVc65PmnaGeif+Ix/j1HVTMiq7ebq9vo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971194; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oOmHUEYP4hvZPCCzkI8xwnbPllmMO5rCcbMG2UcPsWU=; 
	b=dKjjHLxpmlV+AQErGuosmw3ywwEIwu9+yxOjyQ/65UoKqsqkF5BSzMTPEIRZ6kbN8gLJYnO0pCfdsEJQDJDrhs5e/YrbjZo359pgNqkmE04/C3z49i18ACODR30wmwGATRM1ii5hJBlE3uhMiN+kksMC/lm4s5IgnZfnOfbqSUI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971193;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oOmHUEYP4hvZPCCzkI8xwnbPllmMO5rCcbMG2UcPsWU=;
	b=BC90s7RVYAKzOJVgDkT0v7rkNzL+dwoTYdVFyGPuRGwIdFzxN9YRIgI4iZEJVQA4
	J5+dXxsf7FTUMyheQWnnTeKtF96jlKcEMqolhJzeaHuLsHcceshPZKxUF3Q0vIBt2DJ
	OcF6yjGVpoRqGkC/0zXSQhdpn3D1Nqb27K5Y3Z3X60mWZPLtD0NqNdKRK50bbO7s6X+
	QWYw8iOFUBoFqyGyfZ7zfdRtirloLHIoGiAOcBP5G8UDko6uY0xGD7MBCgLm3EzYX+L
	knBCD028Z94p5WnILSwTUFF+d7xfBf/yz03oq9My0OdnT2FscBHnMuQ4Phi0oxuD2Xh
	BeeRR4qryA==
Received: by mx.zohomail.com with SMTPS id 1756971190990998.7721644912724;
	Thu, 4 Sep 2025 00:33:10 -0700 (PDT)
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
Subject: [PATCH v2 5/7] drm/etnaviv: prepare for shared_context support for iommuv2
Date: Thu,  4 Sep 2025 15:31:49 +0800
Message-ID: <20250904073151.686227-6-uwu@icenowy.me>
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

As we have some unfortunate GPUs with IOMMUv2 but broken PTA (reloading
a different page table at runtime always fails), shared_context is now
not a v1-only thing.

Move it out of the v1 struct in the union.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

 drivers/gpu/drm/etnaviv/etnaviv_iommu.c |  8 ++++----
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h   | 22 +++++++---------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu.c b/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
index afe5dd6a9925b..6fdce63b9971a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu.c
@@ -39,7 +39,7 @@ static void etnaviv_iommuv1_free(struct etnaviv_iommu_context *context)
 	dma_free_wc(context->global->dev, PT_SIZE, v1_context->pgtable_cpu,
 		    v1_context->pgtable_dma);
 
-	context->global->v1.shared_context = NULL;
+	context->global->shared_context = NULL;
 
 	kfree(v1_context);
 }
@@ -136,8 +136,8 @@ etnaviv_iommuv1_context_alloc(struct etnaviv_iommu_global *global)
 	 * a stop the world operation, so we only support a single shared
 	 * context with this version.
 	 */
-	if (global->v1.shared_context) {
-		context = global->v1.shared_context;
+	if (global->shared_context) {
+		context = global->shared_context;
 		etnaviv_iommu_context_get(context);
 		mutex_unlock(&global->lock);
 		return context;
@@ -163,7 +163,7 @@ etnaviv_iommuv1_context_alloc(struct etnaviv_iommu_global *global)
 	mutex_init(&context->lock);
 	INIT_LIST_HEAD(&context->mappings);
 	drm_mm_init(&context->mm, GPU_MEM_START, PT_ENTRIES * SZ_4K);
-	context->global->v1.shared_context = context;
+	context->global->shared_context = context;
 
 	mutex_unlock(&global->lock);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
index 7f8ac01785474..2ec4acda02bc6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
@@ -49,21 +49,13 @@ struct etnaviv_iommu_global {
 
 	u32 memory_base;
 
-	/*
-	 * This union holds members needed by either MMUv1 or MMUv2, which
-	 * can not exist at the same time.
-	 */
-	union {
-		struct {
-			struct etnaviv_iommu_context *shared_context;
-		} v1;
-		struct {
-			/* P(age) T(able) A(rray) */
-			u64 *pta_cpu;
-			dma_addr_t pta_dma;
-			DECLARE_BITMAP(pta_alloc, ETNAVIV_PTA_ENTRIES);
-		} v2;
-	};
+	struct etnaviv_iommu_context *shared_context;
+	struct {
+		/* P(age) T(able) A(rray) */
+		u64 *pta_cpu;
+		dma_addr_t pta_dma;
+		DECLARE_BITMAP(pta_alloc, ETNAVIV_PTA_ENTRIES);
+	} v2;
 };
 
 struct etnaviv_iommu_context {
-- 
2.51.0


