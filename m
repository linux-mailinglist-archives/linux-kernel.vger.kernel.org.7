Return-Path: <linux-kernel+bounces-821838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7819EB826C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBC3720682
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A01F5413;
	Thu, 18 Sep 2025 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g312YVYf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC0218580
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156285; cv=none; b=cM+GMj8JnFmk9gCK38lCe6p6WC9a2iWwH9/Xiw2S3lZTWTZIWI0Ff3+woZ5wa4DPrECkQ63nhZx3TcOtScssP1tQL3GcfIvtS9J6hY8iN1Rm5bio/QQsd400lrma+s68nwmHBANs77LzzKiHSv62YYkALqNVdIsckY0raxL2v4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156285; c=relaxed/simple;
	bh=1tGHh9D4SKDvEOmsISHVmpQ1zNxKTXUO5Zxk4dBMT/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtT/At4Yx7GG3fdptFRAdU47ubDTO6rSoYMQePbWHCUX4Ki2fe9TrnGMkUXUw6GEwgAMI0u6b6BMt3diASv4YZ4RNbMzpSYtRRQR9mE5Nl5OnUjfFwI6DWoMdClglS+4fBNE2/o2t2ZAR/3fHy41Ju2Pt5F4EVIk7b+HW1F0D90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g312YVYf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156281;
	bh=1tGHh9D4SKDvEOmsISHVmpQ1zNxKTXUO5Zxk4dBMT/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g312YVYfu09+uwmwFU7QBJm+XK9nAAXqkUpbMbVdfdo6ibFximu3Tqt0z41m/ZuCb
	 e2RoDBpVYGRMaBtM2IOGTQ04gqY2OW5WKaTGZnEuWt7hIAllB7abjdt/Ef5PSJB7tl
	 9iIfZP5fqmKR0Q1bM3L9QO/LGoVTGYb/6BEfI3V1yCAWdLjTrt5JR4W+p2POc1w6ty
	 JaNbP6Qm4ZPBEJ0JRDoaBR25mYXPKqAq6fa7pMT/glRRIV46LoPbXpBbUnuSb8V3tW
	 dMeuiKjJ4The2yyeJay3cb9PUAna6xUU/vkbvl3i+H//am5r8q3z6efJeWhvrrfmJ/
	 yIEuILXanZPwQ==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 12D7F17E0DC2;
	Thu, 18 Sep 2025 02:44:34 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:20 -0400
Subject: [PATCH RFC v2 11/20] drm/colorop: Export drm_colorop_cleanup() so
 drivers can extend it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-11-ac4471b44758@collabora.com>
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

Export drm_colorop_cleanup() so drivers subclassing drm_colorop can
reuse this function in subclass cleanup routines.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/drm_colorop.c | 3 ++-
 include/drm/drm_colorop.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index b0c3216f4dac22f3408cbd537a20f38d03abc0a7..83deb2bc6f50fe030664548365d22de9b45f486b 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -187,7 +187,7 @@ static int drm_crtc_colorop_init(struct drm_device *dev,
  *
  * @colorop: The drm_colorop object to be cleaned
  */
-static void drm_colorop_cleanup(struct drm_colorop *colorop)
+void drm_colorop_cleanup(struct drm_colorop *colorop)
 {
 	struct drm_device *dev = colorop->dev;
 	struct drm_mode_config *config = &dev->mode_config;
@@ -202,6 +202,7 @@ static void drm_colorop_cleanup(struct drm_colorop *colorop)
 
 	kfree(colorop->state);
 }
+EXPORT_SYMBOL(drm_colorop_cleanup);
 
 /**
  * drm_colorop_pipeline_destroy - Helper for color pipeline destruction
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index e7d1e5e95a901b1bd91fd8580e2fcb367c0253ce..f7472ece00cdb09ae204d0c2339eb35c3246874e 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -375,6 +375,7 @@ static inline struct drm_colorop *drm_colorop_find(struct drm_device *dev,
 	return mo ? obj_to_colorop(mo) : NULL;
 }
 
+void drm_colorop_cleanup(struct drm_colorop *colorop);
 void drm_colorop_pipeline_destroy(struct drm_device *dev);
 
 int drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_colorop *colorop,

-- 
2.50.1


