Return-Path: <linux-kernel+bounces-821843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94061B826E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF2C1C246F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A7145348;
	Thu, 18 Sep 2025 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TbF2ZDWI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF792F32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156323; cv=none; b=LgUBGz077i9EAysJ9kz6YEWSblD/6auJzjQBdCeYNJHQy1tVIDPeMdeEvmkcue1+zP1uadpQqJlEzoo9TntBdKPK/QYVvE4fqkQ7+TUaI/P/zfGddIouikByyQLiDbUokvqcvLoRv/xvziLBILea3z14ur+ueEDtLdyWscORVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156323; c=relaxed/simple;
	bh=hrg4K9aJusXrURZYZb3+I5lkB5k51QV3G7lrQkGG2a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbgxRVBYB1of5baGQOGU4WmHoVDUjRlSWACGz4X2HjOMNX6XjQ4aEm8lnJdlLFYt9pNzLJ6TieezF7ada+IwFOgNPyuuu0NMWe9Zk+K68LcCZ443/9rKq0cazfdaGrVyu4WO0QFWDE5X0GVC6bv3eF+hSu+Wlw9UAtiLVkIMnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TbF2ZDWI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156319;
	bh=hrg4K9aJusXrURZYZb3+I5lkB5k51QV3G7lrQkGG2a8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TbF2ZDWI2haHqxIzCLtHuRR7gts16RvJ75kYVBf5h3nu2W3fkUrAi2ZixSUX61zAP
	 2ypMBEVj7lDCIHm7LGYOMG/vJ0vdQczwLa/PUwYwlbI6p9pvxB2UUE4wRhe+7AvSjF
	 tL2sepBa8WarzRlIkpRXIEX1MPpwM3SndjxozmonFdUMfoDwmp3ZBCg4wYnqbZsxSD
	 6okqdyPy9fLV4t2VVJMJmwj+ciD2EN2WrJmihDR3A6oZ2UGSHyV2RLb9eamejptsrB
	 B1fnEMFgEQJ093PNeTi0BBj6F3+lh9vJWh6oMUh54KkSq0pT3dEBZUB5x6tCN7hv7T
	 LpdnFIRL8VQxw==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A5F717E0EB8;
	Thu, 18 Sep 2025 02:45:12 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:25 -0400
Subject: [PATCH RFC v2 16/20] drm/mediatek: Set post-blend color pipeline
 driver cap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-16-ac4471b44758@collabora.com>
References: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
In-Reply-To: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, wayland-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, leo.liu@amd.com, ville.syrjala@linux.intel.com, 
 pekka.paalanen@collabora.com, contact@emersion.fr, mwen@igalia.com, 
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com, 
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 xaver.hugl@gmail.com, victoria@system76.com, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, 
 mcanal@igalia.com, kernel@collabora.com, daniels@collabora.com, 
 leandro.ribeiro@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2

Now that the driver implements post-blend color pipelines, set the
driver cap so they can be used from userspace.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index d5e6bab364143540e1f59df481b9a9d559c39199..73c0f448d7fcf25e473e2c3c6ddaaf28446570cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -611,7 +611,8 @@ static struct drm_gem_object *mtk_gem_prime_import(struct drm_device *dev,
 }
 
 static const struct drm_driver mtk_drm_driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC |
+			   DRIVER_POST_BLEND_COLOR_PIPELINE,
 
 	.dumb_create = mtk_gem_dumb_create,
 	DRM_FBDEV_DMA_DRIVER_OPS,

-- 
2.50.1


