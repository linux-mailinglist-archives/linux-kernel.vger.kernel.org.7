Return-Path: <linux-kernel+bounces-821835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A128B826AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFBF7A8135
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BA214A93;
	Thu, 18 Sep 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f11P/Gs1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F411DFD96
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156263; cv=none; b=d/X2bi9wH64m6yF+7JDuPWmYEKtEn5PrR24bvngK6VqVZfcf1WqDfijgqbTBLVzAUM/09THy+F62KO9TD8+3pxVK3hblHfXjigQ+iSedEFxhC94EyXCN7m3Y9LEym7wMy2fIPU5Mdrzt0XnFaVqJO2Ob04Qj0SkyfPQgomU+mLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156263; c=relaxed/simple;
	bh=UXKjEG3M6JwMo9jVyEqgKoA2PaYmNoENBDd0NSDN4DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sz7n7dSy3kYZNGh6DWVybc7wxUxB+jeyjEZAMo66WAfgc0SmD6wefxov1Op7JSV0eImWf7U03ecnZJ3WkobAnIOhZUL9XOyNMrebhg4QmjX74b6JjYP7PIySRIipLbx9a9/h4KRtJ1+Zqp8I9AYHmcn2QOpOU4AHwULJYXhdmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f11P/Gs1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156260;
	bh=UXKjEG3M6JwMo9jVyEqgKoA2PaYmNoENBDd0NSDN4DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f11P/Gs1m48kPY9tm+HyDyc6pNra8vo4O75Y1bnBceQA58dt5Gy0XSRapBgSw39+h
	 iCQbfP1qL3cL/nhIUc63zo10F0L1oszWLzGv02s/TpG3srzFGw+sQnwEm7mPhcgZsQ
	 lDwZCzSl4qy9uDUazRxYpG5zzRnJFodoVJt93zyxZLBhFfr23XBpR3nsqeiQN8nahi
	 tDWtgSqXyK91p33uEG7xcjCaScydnzm6EPnYd8jL323Au5TIpCT6ccIznxXcgN7iDW
	 eCnwmz/NUILk/i0AIOBUAlOZnazwBszsrN/jsYzLLj+fFaME7teyr2lWqUE7CN7BCj
	 85AFEo2658Cgw==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2885717E0DC2;
	Thu, 18 Sep 2025 02:44:12 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:17 -0400
Subject: [PATCH RFC v2 08/20] drm/atomic: Print the color pipeline as part
 of the CRTC state print
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-8-ac4471b44758@collabora.com>
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

Print the value of the color pipeline in the CRTC state as part of the
CRTC state print.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/drm_atomic.c  |  8 +++++---
 drivers/gpu/drm/drm_colorop.c | 26 ++++++++++++++++++++++++++
 include/drm/drm_colorop.h     |  3 +++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3ab32fe7fe1cbf9057c3763d979638dce013d82b..6982c978dc530b838353ace60f748660c3b4524d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -472,6 +472,8 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
 	drm_printf(p, "\tplane_mask=%x\n", state->plane_mask);
 	drm_printf(p, "\tconnector_mask=%x\n", state->connector_mask);
 	drm_printf(p, "\tencoder_mask=%x\n", state->encoder_mask);
+	drm_printf(p, "\tcolor-pipeline=%d\n",
+		   state->color_pipeline ? state->color_pipeline->base.id : 0);
 	drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
 
 	if (crtc->funcs->atomic_print_state)
@@ -617,7 +619,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_state *state,
 	if (colorop_state)
 		return colorop_state;
 
-	ret = drm_modeset_lock(&colorop->plane->mutex, state->acquire_ctx);
+	ret = drm_colorop_modeset_lock(colorop, state->acquire_ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -2004,10 +2006,10 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 
 	list_for_each_entry(colorop, &config->colorop_list, head) {
 		if (take_locks)
-			drm_modeset_lock(&colorop->plane->mutex, NULL);
+			drm_colorop_modeset_lock(colorop, NULL);
 		drm_atomic_colorop_print_state(p, colorop->state);
 		if (take_locks)
-			drm_modeset_unlock(&colorop->plane->mutex);
+			drm_colorop_modeset_unlock(colorop);
 	}
 
 	list_for_each_entry(plane, &config->plane_list, head) {
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index a1b36cd488f0a014425a9192ffe5fcc4d2c1afaa..1384a259605fa4945aa74402901886d7e1fde0d1 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <drm/drm_crtc.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -595,3 +596,28 @@ void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_color
 	colorop->next = next;
 }
 EXPORT_SYMBOL(drm_colorop_set_next_property);
+
+int drm_colorop_modeset_lock(struct drm_colorop *colorop, struct drm_modeset_acquire_ctx *ctx)
+{
+	if (colorop->plane)
+		return drm_modeset_lock(&colorop->plane->mutex, ctx);
+
+	if (colorop->crtc)
+		return drm_modeset_lock(&colorop->crtc->mutex, ctx);
+
+	drm_err(colorop->dev, "Dangling colorop, it must be attached to a plane or a CRTC\n");
+	return -EINVAL;
+}
+EXPORT_SYMBOL(drm_colorop_modeset_lock);
+
+
+void drm_colorop_modeset_unlock(struct drm_colorop *colorop)
+{
+	if (colorop->plane)
+		drm_modeset_unlock(&colorop->plane->mutex);
+	else if (colorop->crtc)
+		drm_modeset_unlock(&colorop->crtc->mutex);
+	else
+		drm_err(colorop->dev, "Dangling colorop, it must be attached to a plane or a CRTC\n");
+}
+EXPORT_SYMBOL(drm_colorop_modeset_unlock);
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 7a4e0d0c4a3d594abecef304b1d5990434cdb231..3e223f3b3597978c5d702ce7622ae30b8aa9dddb 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -29,6 +29,7 @@
 
 #include <drm/drm_mode_object.h>
 #include <drm/drm_mode.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_property.h>
 
 /* DRM colorop flags */
@@ -444,5 +445,7 @@ const char *drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_inte
 const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
+int drm_colorop_modeset_lock(struct drm_colorop *colorop, struct drm_modeset_acquire_ctx *ctx);
+void drm_colorop_modeset_unlock(struct drm_colorop *colorop);
 
 #endif /* __DRM_COLOROP_H__ */

-- 
2.50.1


