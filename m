Return-Path: <linux-kernel+bounces-782578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F277B32253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E191D62903
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F712C031B;
	Fri, 22 Aug 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FwwFLtVt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC252C0275
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887812; cv=none; b=TgX0e9S9qPJYZ3wuICvmeT2ot20/3tkUh+/shoQreDMPSfbgBHz6v5sQrEUy0SpyB6IUDJjzK06SWC3fjimv0EZ68IEKvceTxMTKcpW3LpJ4cRR3joMeo3rGZblnrqCqm4qBZELwRKInQw7h4y/iIzfY9mDpd0C27Q0+s3S3gGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887812; c=relaxed/simple;
	bh=emo1Y+He1rL7+g/lnBKo9KHUxgoj16EF+fdtTkETCdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/HXo/nLMWFMrrCrdLV/FZjpsiYD0nUtleSe/sZtZH9Il5T78fjosdajjkFTRiiNkjvxxfTTIUrCaoUQtAtcq44lrPRlmM2+8+xS47bQvbe0jFxLcWkmmKO+ljF1NpVSjvp2/bA/hQQ75VZ6PfwLZ9iNHMPeyT4/WD4xJ7OQg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FwwFLtVt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755887809;
	bh=emo1Y+He1rL7+g/lnBKo9KHUxgoj16EF+fdtTkETCdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FwwFLtVtG4Bv7Sw2mnor1fBatS0kOibcyamFMwJSoKlggaHCcZxAsUURHcDEsv2CQ
	 ghmtO83Z4zQNVI96GrqPFgHO5v6bRsIrx4w3+44deJ2LoagxGmoKJ1nChvoCmQP28Q
	 rqpl1eJnGVep0DoBXXuS/lcYPRAWTd+55uWemfEd+xlAoxwHN5a3qbhuRyt+GzBZUS
	 Z68TujGclw69uzR4Cc3cya1YXAOgqoB57yCiUfxAaTPSEYcLXrAKQKXZRs8KDBYxDF
	 9tEQ4B/ng2NGDNbUIydt5NeSwl/0Qid/tn2sl//x7KN0wR8QctScU+VThlnBBNVVLQ
	 jdQ/+AwVtPjvw==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2737517E159C;
	Fri, 22 Aug 2025 20:36:43 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 22 Aug 2025 14:36:12 -0400
Subject: [PATCH RFC 2/5] drm/colorop: Export drm_colorop_cleanup() so
 drivers can extend it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250822-mtk-post-blend-color-pipeline-v1-2-a9446d4aca82@collabora.com>
References: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
In-Reply-To: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2

Export drm_colorop_cleanup() so drivers subclassing drm_colorop can
reuse this function in subclass cleanup routines.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/drm_colorop.c | 3 ++-
 include/drm/drm_colorop.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index d53de1438d23def74a77730cacd3651131e82cbe..8a27861a367ab321d45835099f438ee5e2abd709 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -186,7 +186,7 @@ static int drm_plane_colorop_init(struct drm_device *dev,
  *
  * @colorop: The drm_colorop object to be cleaned
  */
-static void drm_colorop_cleanup(struct drm_colorop *colorop)
+void drm_colorop_cleanup(struct drm_colorop *colorop)
 {
 	struct drm_device *dev = colorop->dev;
 	struct drm_mode_config *config = &dev->mode_config;
@@ -201,6 +201,7 @@ static void drm_colorop_cleanup(struct drm_colorop *colorop)
 
 	kfree(colorop->state);
 }
+EXPORT_SYMBOL(drm_colorop_cleanup);
 
 /**
  * drm_colorop_pipeline_destroy - Helper for color pipeline destruction
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 710a6199ebc5498a3f664de39ea07dbc95944eb7..158c2b8f775b99fd0a0efa03f2c019f14a9bc8b3 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -374,6 +374,7 @@ static inline struct drm_colorop *drm_colorop_find(struct drm_device *dev,
 	return mo ? obj_to_colorop(mo) : NULL;
 }
 
+void drm_colorop_cleanup(struct drm_colorop *colorop);
 void drm_colorop_pipeline_destroy(struct drm_device *dev);
 
 int drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_colorop *colorop,

-- 
2.47.2


