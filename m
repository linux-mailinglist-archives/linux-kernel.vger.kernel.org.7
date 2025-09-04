Return-Path: <linux-kernel+bounces-800154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C2B43417
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433C1585AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88829DB6A;
	Thu,  4 Sep 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="B6bf3QTT"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741E29DB64
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971202; cv=pass; b=HAdwIGqD4RGkYZbK+AX4CA6COA64EUKQ1enOfYtSIXoPqQljNKnsbV6v+5gKM08oZ6RVcmALB3jCmHgsYcozKOIaOKf7ztSfZ17SYN5WZiUMpPrvKnYRG4mmZI0b6nJVXRH58wJ7TqyU0gdzJUlneXJK5tfb1usv2ddnOCBuXcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971202; c=relaxed/simple;
	bh=TI9QFctGVgjSYqffzhPC/mWxuk7hfBmjnyRJtMH5l8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AO9fZiqcVpBlUHnRoOpHwWR2d0EPJDrGsXgbSH/YVq3inrDth4GQ/QVonSq3rLou+2auUj1QJEknpU6aWmFImDp21oIEcjxdKfnYwF53cJDxUDQSV7Zb41CVbZQVMUWakL7Ljq1J2t4lRrw5ZFVAbmj8VBmGyIaI7pyPRn8ba+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=B6bf3QTT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1756971184; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=no4G4U4VTPUEeCXAYyz0MmsXiOaO0yNzUNM12+zgecrXH2aqWdG6Xz3b3XUDZy505ydhXLrde107DktyYH/JfAuzemSTUgr8D0OixdvA7+DUW+M45AvcQirQEKfrZnW0C/hgKIbo0ClH/9xfv8f2/Cj+DPsocQgjqrOMpSwPV7g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756971184; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gpts7NthN3eibQeZcZSvSI9koYWBnwv2X6pMUbjR4LA=; 
	b=FlT2y2BMEKv/azvXnUrNsTlOSPxovipKC4PPdOHhbXkbLlAtvkmT935UiMmge/W7ehEuM4MHzcIkfcdrOcQ7LKmIdVfIuXKgAg6neZdOiiIRxF/TSFF4Jjyvg9RfxNDoLE3FEeD5GPGIWyQaq+Fki3V+Nrg13FKtsUSYZh0Ovls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756971184;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Gpts7NthN3eibQeZcZSvSI9koYWBnwv2X6pMUbjR4LA=;
	b=B6bf3QTTVN+bwbuz986odcG8+mnqNaZHoKKyjRNlKt4HqBIHjRhZOy3son02rUUR
	cs40uPIfW/1mD7Ei45RXzzzxJax1zACDC+8d2Kioc45xSfSTna0rdvH60nZFDPWjxe0
	SB0wSbeik3PU4W9vC62al5hX636fKVvHUanLgWA3es9U7EPliep0ByhuDyXlSN5Vimu
	GfjtJCx1xslOhbi4S2WTZYtOsKmQadfHXWRdzIHLHc5Tde3ieZdXiSK4bPB+0YMj9Cu
	FY8cU1NSs8sd40TW6g9nV47Pf6bXnk4X1YDT+OsJxZCyE11CO/d/j514ipnHj/7LbO2
	OP+9/1uezg==
Received: by mx.zohomail.com with SMTPS id 1756971181360796.0305334552593;
	Thu, 4 Sep 2025 00:33:01 -0700 (PDT)
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
Subject: [PATCH v2 4/7] drm/etnaviv: protect whole iommuv2 ctx alloc func under global mutex
Date: Thu,  4 Sep 2025 15:31:48 +0800
Message-ID: <20250904073151.686227-5-uwu@icenowy.me>
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

As we are forced to use a global shared context on some
PTA-equipped-but-broken GPUs, the fine-grained mutex locking in the
current implemtnation of etnaviv_iommuv2_context_alloc() won't be
meaningful any more.

Make the whole function to be protected by the global lock, in order to
prevent reentrance when allocating global shared context.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

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
2.51.0


