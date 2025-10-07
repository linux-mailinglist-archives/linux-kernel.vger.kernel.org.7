Return-Path: <linux-kernel+bounces-844407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF075BC1D78
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4B219A1F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C670808;
	Tue,  7 Oct 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dnIkN0JH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DD19CC0A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849387; cv=pass; b=icCASX349bm0lSSbXRejJXchuReZX/pNjM8fL/tTLt+t51TTjyMWcGlLM0jW/d/pcW3GqUJ+sIQSlSyyrsWhKY662dzJQYjlyM5Si75GJeQYgMECA7i4zLrtUZb1afesbePYZZIaCGyx2Llv4H1yAelj1Dm2AnWlQUuSovjzIME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849387; c=relaxed/simple;
	bh=C4ZQ1ujTGuSFrp4PyJtNoj33e3P+89KmVR4ug6D6PqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZI8nGPnIs6PxZ6wuFSKeghhPXoBESXEssD2qoEcBaxxl3OTHqqlS8XoiQ7vEOuCOOe8yxT3UCaZttQdyv0DiFFYb+FtcsGXUiOStMDFjK++aD0O0EEvI5HnA58FxQQ4cG1gmnxtiWc1Meq4AlA8MyheExFJpfWgFWyDes/WL88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=dnIkN0JH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759849366; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VL47jvL04JkvdEdSLW1sjb/gKPHpzVBdMrNj5GIjhxG4NjCEPWASnWgPpo5MUfCmRC8Xs0Ca5HlLKbksnD7hhRmML9ixKtLdDO35M6fcbSg4K4NT67h0CByZjLQzokdlfMeaYyN8XCTwoD6V4V+9YlNzS/lu46ksF9yxwr6D7ks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759849366; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9mJpXwNQtuHdXoL5cocq46WnhPmhzO+1eFwpDevoV2Y=; 
	b=JKLRA+n2GK5UDuEU9A+rvvsCRIha5vwZUlKtg9YVAx0DKad4ON582ABhLrFRRii+ooC2CxyoU6+PCwNpMLL17Nb8dR1AXnKmrnodioKMgL4d0jLGWssurVQCTbnDT+F02oPipKnX/pP74nS+pzTt7Z4VhMXaXMClsEDEyUG2y5Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759849366;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9mJpXwNQtuHdXoL5cocq46WnhPmhzO+1eFwpDevoV2Y=;
	b=dnIkN0JHYuN+f7vZNFCsaxvTePfBYZipMdcy63Pb8g8sDnQ2qLMVzFoYaeDsCe5d
	Wh6607MDdlMqD7o+1EPze1bAp2mUJEB3Tued+WbgAehjwWhssz/OdzOgCQGuVg+yjpg
	bATeE633IeuLAnjDk6EcnOQ10p3/lz/6dNgRtGTw=
Received: by mx.zohomail.com with SMTPS id 175984936524452.52368327041563;
	Tue, 7 Oct 2025 08:02:45 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 02/12] drm/panfrost: Handle inexistent GPU during probe
Date: Tue,  7 Oct 2025 16:01:44 +0100
Message-ID: <20251007150216.254250-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007150216.254250-1-adrian.larumbe@collabora.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
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


