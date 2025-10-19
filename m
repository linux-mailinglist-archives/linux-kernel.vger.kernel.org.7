Return-Path: <linux-kernel+bounces-859748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D64BEE7A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EEB189A3E0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE122EB844;
	Sun, 19 Oct 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Qi1QuUhj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605392D0610
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885592; cv=pass; b=V/SVEQ9r5pEBlYv0EJCWArAVMTtnVN3bsw1P/5yj7OUCihJyWOPUVEVj/NT+rN93mqiWVrvTZ/TGmekwoRdrneb3fMy2XtBbmph7u8m88wjTgvLOJVR6/QUQ0o6NWSyIOvoz2LSbthiJhHbK7f9fjBbIaenwlw+zBPcXtpH9o4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885592; c=relaxed/simple;
	bh=NUs16rhj72biF5jC4rphf+2KUyGv9VZwHzvBhthy5Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6Sexyi4OSCuQNv3aOFt0cYY5flgDf0uQNsT397BxbCpQLhcwxs3q2n43A87qlfioOzftIL6PB2CTCdBhzGJjcI/mnAU8NmPYR24LHBMsr+jQPUSKMcaMWqn21uvIg8MlQ24H1FC/MbzDO7CCJqDk24AdN1T15jkXBeBPErsck4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Qi1QuUhj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885570; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CIrSU49p2QyQK+UHDrBTQ8l5R4NnWHnZkW6djmFbSldEDbFp3CQcMs3Ag0GqEYSarh8b5ak5fmMND1z6KknkaArABZGtTOBsfCM9Yto38hUZoUIIviF0fCdEbn8DLdpgtSaGgHnZQvIop2+y4PXOMOdVu4T7NwW/WtAyodmcFNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885570; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qs0r+LNG3M3cRUgi1SzIY+3fOiH0XSE0IxGGsB67r5E=; 
	b=SWE5HNGaqtLsUNpqyly/w2GP9fTLhsixDMRYfBZsF+16TEabvf3PyhPrSPSonajTARKevkFE5f3EVowy6tdrZlxpta8pKHOmdEjyWCi7mA3a2Mx5odIj0OBI7z7Fq209XoSe7DTLIPloofmwvnX4zuyu5bVUw3ARyNgH81RhmX4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885570;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qs0r+LNG3M3cRUgi1SzIY+3fOiH0XSE0IxGGsB67r5E=;
	b=Qi1QuUhjq8piKf3yGO9ItyGm9laeI5HxpvPwOnjI6/CZrS4heMxdSR/ES31OIOHX
	iTvlyimDAKE5QOESei4xd5jBXXGusNWBcW/JvDnA22JaCVn46WRU4gQgq3Lfg8l/WRR
	bGS9ucMecIA832+FA6Y8ogoQB/fNu+eIAysNrZVs=
Received: by mx.zohomail.com with SMTPS id 1760885567981201.8306713155564;
	Sun, 19 Oct 2025 07:52:47 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 02/12] drm/panfrost: Handle inexistent GPU during probe
Date: Sun, 19 Oct 2025 15:52:07 +0100
Message-ID: <20251019145225.3621989-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
References: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just in case we're dealing with a yet not recognised device.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index f94337a6c302..8d049a07d393 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -240,9 +240,10 @@ static const struct panfrost_model gpu_models[] = {
 	/* MediaTek MT8188 Mali-G57 MC3 */
 	GPU_MODEL(g57, 0x9093,
 		GPU_REV(g57, 0, 0)),
+	{0},
 };
 
-static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
+static int panfrost_gpu_init_features(struct panfrost_device *pfdev)
 {
 	u32 gpu_id, num_js, major, minor, status, rev;
 	const char *name = "unknown";
@@ -327,6 +328,12 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
 		break;
 	}
 
+	if (!model->name) {
+		dev_err(pfdev->base.dev, "GPU model not found: mali-%s id rev %#x %#x\n",
+			name, gpu_id, rev);
+		return -ENODEV;
+	}
+
 	bitmap_from_u64(pfdev->features.hw_features, hw_feat);
 	bitmap_from_u64(pfdev->features.hw_issues, hw_issues);
 
@@ -347,6 +354,8 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
 
 	dev_info(pfdev->base.dev, "shader_present=0x%0llx l2_present=0x%0llx",
 		 pfdev->features.shader_present, pfdev->features.l2_present);
+
+	return 0;
 }
 
 void panfrost_cycle_counter_get(struct panfrost_device *pfdev)
@@ -489,7 +498,9 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 	if (err)
 		return err;
 
-	panfrost_gpu_init_features(pfdev);
+	err = panfrost_gpu_init_features(pfdev);
+	if (err)
+		return err;
 
 	err = dma_set_mask_and_coherent(pfdev->base.dev,
 					DMA_BIT_MASK(FIELD_GET(0xff00,
-- 
2.51.0


