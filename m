Return-Path: <linux-kernel+bounces-771789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA88B28B94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431CB2A84EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F50A1DA21;
	Sat, 16 Aug 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="MLtMwvYk"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE522FDEC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330582; cv=pass; b=LhNbWsn25lvwSRruxNm2mSSGGpunTfvCNAPRmU9a7hr/UvuPqMthJON7WC5iRevYDEjzbwMX1+TUgxnIpZXSBViF9WwXkBRSonbrAO+VMj7tjZ842WeryD2HPCF3USrBUR2nfBybSgsvJ4FBU6ZC57cO9FK40/U549AMVtRWgVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330582; c=relaxed/simple;
	bh=ihZ0YvzK6Jc2oHoFU1M3i5d95DQ9EnyyRoUvPF2/drQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl41ovWFrxVSEoZBq0uJ3NR5lBQqpIkQuYbFjuVJGjvXM9hF1Y59S5aHa05ZnbFwqTaK9N3KdK50ZFMynxnpT5JSs2sqNb1wpy6Pe5WVwrpfiFfkPBkZbSUJBM4nCm2kR29R8YN+W9g4caVb84cqiPLCIByTwIo8k7KDKvaHHmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=MLtMwvYk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330562; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YF099E5zO967bfyuMBSXww0TlAsPeeVUp0FDTkm7ijV2KgWJqGA+Ey/9EoYHL7HPPUasiP517CDtSRy1AZfS453P8bRCkWVd7BHExUEjjTOCYqLhDPHLipHnBM79DwHs2wnoCIxiQjRvkyOltQkat0SrSkgduRrfCpnWpobgyuM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330562; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AKJEL0/mUZ/C7FGFS07m14Rz7LamiiUDHM253Sk2BSE=; 
	b=UMMTl3bQajSs/p1bd/6QET/MeUaKE32TkIUzGhXw9EdKv5eIhQQ4LoVRfBxxDGAX6I5RAP9iWJVcBNeoLk0tnLX2Csnm1ZutuKKnJ7mCkz82Tca3KHWjUZwhGTDNG74sMi18pa9sUjCwAzvwaQkb24H8ku2KgcwJ7+HgRjwK9Ww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330561;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AKJEL0/mUZ/C7FGFS07m14Rz7LamiiUDHM253Sk2BSE=;
	b=MLtMwvYkp435pUtnIwCuxI96Wy0IhxZWcrBhkN/6+YY9rYhTYBYyB//fjetjD1G1
	HRAq3MzYR+1CLiT/1CQMP/HPCSi/FDk7ICszj+qMy96dntc+zfr68OAwiBEsTXnAdca
	InjK15saqPyBKk26BawfUumJZVh3nUXLB4snCv11u4Y+xj6xp1H3zJ8I98AMKGeXr7s
	zMZWhPKKX9Dl7upFbBTMYwF4N47z4T6KJTVLb2xtnseSW26/trxHFcc9dTeBKyIbbS7
	8SHj+L4LMaz6JAMVI8xps8zaHmCz1P02Yipxd0HevQYk5mMUBVI5nzFB6hp24Lfv18m
	VwqSVH7yYw==
Received: by mx.zohomail.com with SMTPS id 1755330559475160.36739447746152;
	Sat, 16 Aug 2025 00:49:19 -0700 (PDT)
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
Subject: [PATCH 4/7] drm/etnaviv: protect whole iommuv2 ctx alloc func under global mutex
Date: Sat, 16 Aug 2025 15:47:54 +0800
Message-ID: <20250816074757.2559055-5-uwu@icenowy.me>
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

As we are forced to use a global shared context on some
PTA-equipped-but-broken GPUs, the fine-grained mutex locking in the
current implemtnation of etnaviv_iommuv2_context_alloc() won't be
meaningful any more.

Make the whole function to be protected by the global lock, in order to
prevent reentrance when allocating global shared context.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
index d664ae29ae209..5654a604c70cf 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
@@ -272,20 +272,18 @@ etnaviv_iommuv2_context_alloc(struct etnaviv_iommu_global *global)
 	struct etnaviv_iommuv2_context *v2_context;
 	struct etnaviv_iommu_context *context;
 
+	mutex_lock(&global->lock);
+
 	v2_context = vzalloc(sizeof(*v2_context));
 	if (!v2_context)
-		return NULL;
+		goto out_mutex_unlock;
 
-	mutex_lock(&global->lock);
 	v2_context->id = find_first_zero_bit(global->v2.pta_alloc,
 					     ETNAVIV_PTA_ENTRIES);
-	if (v2_context->id < ETNAVIV_PTA_ENTRIES) {
+	if (v2_context->id < ETNAVIV_PTA_ENTRIES)
 		set_bit(v2_context->id, global->v2.pta_alloc);
-	} else {
-		mutex_unlock(&global->lock);
+	else
 		goto out_free;
-	}
-	mutex_unlock(&global->lock);
 
 	v2_context->mtlb_cpu = dma_alloc_wc(global->dev, SZ_4K,
 					    &v2_context->mtlb_dma, GFP_KERNEL);
@@ -304,11 +302,14 @@ etnaviv_iommuv2_context_alloc(struct etnaviv_iommu_global *global)
 	INIT_LIST_HEAD(&context->mappings);
 	drm_mm_init(&context->mm, SZ_4K, (u64)SZ_1G * 4 - SZ_4K);
 
+	mutex_unlock(&global->lock);
 	return context;
 
 out_free_id:
 	clear_bit(v2_context->id, global->v2.pta_alloc);
 out_free:
 	vfree(v2_context);
+out_mutex_unlock:
+	mutex_unlock(&global->lock);
 	return NULL;
 }
-- 
2.50.1


