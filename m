Return-Path: <linux-kernel+bounces-771792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF205B28B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906E42A8590
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0440230D35;
	Sat, 16 Aug 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="hPzr9B4Y"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D37223DCB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330621; cv=pass; b=s4hzaOxdaiR18IJE9KR1jeySWh+WReLrH68x4+x5a+o3NsS4m6A1Uoft9I9mYMSGKwTpGht6U3glSxuDuEsbQnFJH4xzFXRjk2Ddq5j5bPPvbsDQTz3woAaETbMPyn6nGMBywydRTwLFID+NMs1zVj3n7zqV88WylRfCqJKK+30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330621; c=relaxed/simple;
	bh=E0FjB6kMfQY5O+yJBZwSthSOmMxaZjsAugPmNRW5CwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoHbqTell3ZQyS1e3OReKPtGWDMjcBfcz0To/okk+ga80xI2asW0t2z4vi232IB5fDJgP5faJM7WSpp5hFj6KJp9bVvGSRP+bU0WizPitN6XYH6jS+mZhAwTrHWDpUz48zDQoN5zAAD2nmYrnYh1Jq5ugpl+ewxv5I8oEX4jg0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=hPzr9B4Y; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wk3n11qAalAXzPVmgZZZEaJ/zqMH94YdP8W8QseZQilV6/fFOzeOtrnBU1TXIvODhpSNzdlGWIDJ2+yw8ymZzysVuRQZrsozLJKUaQYITfoMVeCLl0s72kHk5mri7VtzVqYEDJZlftbhE5hojvDdXmbRdlvChgRpybVpG3Tvxjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330602; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dl80jSPpC5O2vp6knEfeEZ6aNBmqt3cz1+4K1LZ3LiI=; 
	b=me6QuRwSn9njgRjEz6S5/2cYS5Y092ZrOcumAsy52X6gIcD8JZRPVwxs3sfBsCVIpNwf9NEFfoZSqrxcnL9ii/k+y+uwzAAsySjpgqVPnHfzEsEXQ7NeAFt8VCBtlG1+HLv8IBp80yjAwKlxunj7CaPW4Z3/bafXVJQ2Hg4UiW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330602;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Dl80jSPpC5O2vp6knEfeEZ6aNBmqt3cz1+4K1LZ3LiI=;
	b=hPzr9B4YznreZqMCWBxJhlGuLr6dC74K5IcxVNIzU4nYbGEWF5KX2wfOyZc8e3D5
	jJjl9MYmwzB9mVo8Anoq/4kaoy1EeojMnCvxKjOg4gD4s06PQRP5WFJo1P9abFcXmpF
	Rv3apgURWVbMaCFXp+Oe5nERN8N/roueIkSvSGRUsnKox7sX9OVieVFX6LCaFe7LNNs
	YTlRpGK2pqrb7KwKB6MyHyNAJgF9O6zWVoVRzrWdUXW9lueVYcuffMw7AapQibVMJ0q
	/wgA/we+W/iAHt1pLdokwdSy+0YjxmcExLkgwFoumAyTTt6f+4kgJrn+60zDlHV7fvV
	PE0+R4f2Zw==
Received: by mx.zohomail.com with SMTPS id 175533059910433.10218510901905;
	Sat, 16 Aug 2025 00:49:59 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 6/7] drm/etnaviv: add shared context support for iommuv2
Date: Sat, 16 Aug 2025 15:47:56 +0800
Message-ID: <20250816074757.2559055-7-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816074757.2559055-1-uwu@icenowy.me>
References: <20250816074757.2559055-1-uwu@icenowy.me>
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
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 8 ++++++++
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c      | 1 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h      | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
index 5654a604c70cf..960ba3d659dc5 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
@@ -273,6 +273,12 @@ etnaviv_iommuv2_context_alloc(struct etnaviv_iommu_global *global)
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
@@ -301,6 +307,8 @@ etnaviv_iommuv2_context_alloc(struct etnaviv_iommu_global *global)
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
2.50.1


