Return-Path: <linux-kernel+bounces-865496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D755BFD5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 998405022EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13434D4CB;
	Wed, 22 Oct 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HjoYVDdP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E52C11C0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150093; cv=pass; b=hs+Zlz+dR463AWBIkiJWcnZWNkmgELwuwlhbdDGy4j6dpHHESUgxWx351Mw/2aEGn4VPlbXpWsNyGrITGm1CXEhwkThuT54MlLEq0O5HZSE5T1vU6RaxNfVta3X/RYLwcaAJjSTBBsLiCqZWNfg3LoqBsASHDt1fX8OKF2Fh+QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150093; c=relaxed/simple;
	bh=Xg/qPn711w8c2isVa6nPEL/1BZ8WZ+eksmBR7k5SC9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3vcLaEWz4QLquq7Jsok8Jalx04IPW5ukw/64tjDT0UpRcYGoGCN6h+ukJprk5lMMZv8CSKw6HD5M/5GMKq3iLFQCw+CjQIuz8W/24RjRTGydxq6kMOII0eY0kqRMgKjyot82OfgeiNDpwtqr8tncMZnCzJuGddPfyNRiBJKmYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=HjoYVDdP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761150069; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lGCaflefZf9vW0sZUzl5R9DP8UEulwgyXUiaW+glHfUz31zKUpTCTtzJhn7nKRV0XYHMe7hwwkqRlSa6DNzkt2GWlia9O4YhjkvqdkVVK26uawqepgwLMmFOxxCjLnYK2zAf72kvwsYU66EU6Zi/alQaHMmDkjkIijxYYPMrAGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761150069; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FdcrSneWicl1pfGMcZk6PTeqOTBE1QoowN6eLnXOcgU=; 
	b=H/uwlob0aAvM70DEBoKO/53Mu77vNhN7nV3svwqA6OZXj1Q6xieeknEwj66tK4ofB4Xf9p4A4IdPW5bZbAQvfXfcsKcAEkxBaitzg6enV8Di4F5cfOMwui4ZPwCgKiQyceNyTS3xXWS7PC/vy2LSLVcG9efvqFg04Lf/pbR8Bfs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761150068;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FdcrSneWicl1pfGMcZk6PTeqOTBE1QoowN6eLnXOcgU=;
	b=HjoYVDdPhe2UO4MEseYlCzsf5PLSkSqmQ3FBRRpzmXJYnVSgD+EsF1o8xOmD2lBO
	QQW8K+SkhZYDmAJBDqyWPe+4t7rnakJ4ZJOOGeB85q9hxtMI7pc4+4efkg7d7kQPxYi
	5PV1jfVkEizK87x9AmLdRXkEczkClnEiczdwOHWE=
Received: by mx.zohomail.com with SMTPS id 1761150066573669.259808258432;
	Wed, 22 Oct 2025 09:21:06 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1] drm/rockchip: Set VOP for the DRM DMA device
Date: Wed, 22 Oct 2025 19:19:48 +0300
Message-ID: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Use VOP for DMA operations performed by DRM core. Rockchip DRM driver
is backed by a virtual device that isn't IOMMU-capable, while VOP is the
actual display controller device backed by IOMMU. Fixes "swiotlb buffer
is full" warning messages originated from GEM prime code paths.

Note, that backporting is non-trivial as this depends on 143ec8d3f9396
("drm/prime: Support dedicated DMA device for dma-buf imports"), which
landed in v6.16 and 421be3ee36a4 ("drm/rockchip: Refactor IOMMU
initialisation"), which landed in v5.19.

Reported-by: Daniel Stone <daniels@collabora.com>
Fixes: 2048e3286f34 ("drm: rockchip: Add basic drm driver")
Cc: stable@vger.kernel.org # v6.16+
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index eb77bde9f628..e693160e9b7f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -96,6 +96,9 @@ void rockchip_drm_dma_init_device(struct drm_device *drm_dev,
 		private->iommu_dev = ERR_PTR(-ENODEV);
 	else if (!private->iommu_dev)
 		private->iommu_dev = dev;
+
+	if (!IS_ERR(private->iommu_dev))
+		drm_dev_set_dma_dev(drm_dev, private->iommu_dev);
 }
 
 static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
-- 
2.51.0


