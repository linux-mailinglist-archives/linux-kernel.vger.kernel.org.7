Return-Path: <linux-kernel+bounces-821840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBACB826D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCC544E276F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268521C186;
	Thu, 18 Sep 2025 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iaGUtixd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32720371E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156301; cv=none; b=o8T6+LqLb0TSZRgw7FKIe7DS+YkkB6+WzgNfDUdsBIWGiJMhwWPTLoCtepL6r4wZlkhNCxYtAF9TPQE23I7OhkRRRy67AMCr7PUBqNcmMEMh++GGeLWbXYTvQntUcDKjas9pqNKSEPmEyaT/P6MzKR6N8GONESq42lV2LjPw1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156301; c=relaxed/simple;
	bh=TnMBPDFyDMJferh/o7a/nXrGbs+kzTCQpZ2Q6QHHl4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjnFF/9M2SyiTR/ONSMy+XGRbm7lEQg9hM35+o0HpfgP7W+MT4G69uiTfYJgsmhDis0HKMJSkI9+ioPfVq+35zOGaeK2Td8Da4+35piolEi/2GucsnzcOjMicC3BbbBlBAoXzE9+BPW62b5kB7b9sg8Qpr/VaXowM0IgBbAvyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iaGUtixd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156297;
	bh=TnMBPDFyDMJferh/o7a/nXrGbs+kzTCQpZ2Q6QHHl4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iaGUtixdxdf6RYXPYNmG7DqDtJuWTQiUK4LLbTs7bi3xJSWo3MU1720JIKWG1ZnuU
	 nxDsk/s43j6AhPmVoRO14V/zY9vIcxxjlMg229nQM0WRQ2P+YLqkCkVO/Xu7oqxIdT
	 bHmGkQAAzRcUg7hSj7z8r+dkZ5iSAgKy0fTzSjO5Rj1pJJ+nFd01hd0oooXFF33R94
	 I9TN2pZpT4J3Zhy89lMGv8/HYfZYBa/p3ZSbWstNRC+YBDlqo/XoE9OBAgfEkAV34r
	 KThCdhQys2y4yCcxJm0Z8MIcv4c3fnhT/8gimGDrvYYRqOUov+khjNAtzDt7D0YjxS
	 mP5qQ7xmZfTsg==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E1D2717E0EB8;
	Thu, 18 Sep 2025 02:44:49 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:22 -0400
Subject: [PATCH RFC v2 13/20] drm/mediatek: Support post-blend colorops for
 gamma and ctm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-13-ac4471b44758@collabora.com>
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

Allow configuring the gamma and ccorr blocks through the post-blend
color pipeline API instead of the GAMMA_LUT and CTM properties.

In order to achieve this, initialize the color pipeline property and
colorops on the CRTC based on the DDP components available in the CRTC
path. Then introduce a struct mtk_drm_colorop that extends drm_colorop
and tracks the mtk_ddp_comp that implements it in hardware, and include
new ddp_comp helper functions for setting gamma and ctm through the new
API. These helpers will then be called during commit flush for every
updated colorop if the DRM client supports the post-blend color pipeline
API.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c     | 208 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h |   2 +
 2 files changed, 205 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index bc7527542fdc6fb89fc36794cee7d6dc26f7dcce..9ab2c2b77392839a1b03d6cb01670bf252bf68a5 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -82,6 +82,12 @@ struct mtk_crtc_state {
 	unsigned int			pending_vrefresh;
 };
 
+struct mtk_drm_colorop {
+	struct drm_colorop colorop;
+	struct mtk_ddp_comp *comp;
+	uint32_t data_id;
+};
+
 static inline struct mtk_crtc *to_mtk_crtc(struct drm_crtc *c)
 {
 	return container_of(c, struct mtk_crtc, base);
@@ -92,6 +98,11 @@ static inline struct mtk_crtc_state *to_mtk_crtc_state(struct drm_crtc_state *s)
 	return container_of(s, struct mtk_crtc_state, base);
 }
 
+static inline struct mtk_drm_colorop *to_mtk_colorop(struct drm_colorop *colorop)
+{
+	return container_of(colorop, struct mtk_drm_colorop, colorop);
+}
+
 static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
 {
 	struct drm_crtc *crtc = &mtk_crtc->base;
@@ -125,6 +136,19 @@ static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 }
 
+static void mtk_drm_colorop_pipeline_destroy(struct drm_device *dev)
+{
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_colorop *colorop, *next;
+	struct mtk_drm_colorop *mtk_colorop;
+
+	list_for_each_entry_safe(colorop, next, &config->colorop_list, head) {
+		drm_colorop_cleanup(colorop);
+		mtk_colorop = to_mtk_colorop(colorop);
+		kfree(mtk_colorop);
+	}
+}
+
 static void mtk_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
@@ -146,6 +170,8 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
 		mtk_ddp_comp_unregister_vblank_cb(comp);
 	}
 
+	mtk_drm_colorop_pipeline_destroy(crtc->dev);
+
 	drm_crtc_cleanup(crtc);
 }
 
@@ -854,20 +880,103 @@ static void mtk_crtc_atomic_begin(struct drm_crtc *crtc,
 	}
 }
 
+static bool colorop_data_update_flush_status(struct drm_colorop_state *colorop_state)
+{
+	struct drm_colorop *colorop = colorop_state->colorop;
+	struct mtk_drm_colorop *mtk_colorop = to_mtk_colorop(colorop);
+	struct drm_property_blob *data_blob = colorop_state->data;
+	uint32_t data_id = colorop_state->bypass ? 0 : data_blob->base.id;
+	bool needs_flush = mtk_colorop->data_id != data_id;
+
+	mtk_colorop->data_id = data_id;
+
+	return needs_flush;
+}
+
+static void mtk_crtc_ddp_comp_apply_colorop(struct drm_colorop_state *colorop_state)
+{
+	struct drm_colorop *colorop = colorop_state->colorop;
+	struct mtk_drm_colorop *mtk_colorop = to_mtk_colorop(colorop);
+	struct drm_property_blob *data_blob = colorop_state->data;
+	struct mtk_ddp_comp *ddp_comp = mtk_colorop->comp;
+	struct drm_color_ctm_3x4 *ctm = NULL;
+	struct drm_color_lut32 *lut = NULL;
+
+	switch (colorop->type) {
+	case DRM_COLOROP_1D_LUT:
+		if (!colorop_data_update_flush_status(colorop_state))
+			return;
+
+		if (!colorop_state->bypass)
+			lut = (struct drm_color_lut32 *)data_blob->data;
+
+		ddp_comp->funcs->gamma_set_color_pipeline(ddp_comp->dev, lut);
+		break;
+	case DRM_COLOROP_CTM_3X4:
+		if (!colorop_data_update_flush_status(colorop_state))
+			return;
+
+		if (!colorop_state->bypass)
+			ctm = (struct drm_color_ctm_3x4 *)data_blob->data;
+
+		ddp_comp->funcs->ctm_set_color_pipeline(ddp_comp->dev, ctm);
+		break;
+	default:
+		/* If this happens the driver is broken */
+		drm_WARN(colorop->dev, 1,
+			 "Trying to atomic flush COLOROP of type unsupported by driver: %d\n",
+			 colorop->type);
+		break;
+	}
+}
+
 static void mtk_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_atomic_state *state)
 {
 	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct drm_colorop_state *new_colorop_state;
+	struct drm_colorop *colorop;
 	int i;
 
-	if (crtc->state->color_mgmt_changed)
-		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
-			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
-			mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
-		}
+	if (state->post_blend_color_pipeline) {
+		for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
+			mtk_crtc_ddp_comp_apply_colorop(new_colorop_state);
+	} else {
+		if (crtc->state->color_mgmt_changed)
+			for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+				mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
+				mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
+			}
+	}
 	mtk_crtc_update_config(mtk_crtc, !!mtk_crtc->event);
 }
 
+static int mtk_crtc_atomic_check(struct drm_crtc *crtc,
+				 struct drm_atomic_state *state)
+{
+	struct drm_colorop_state *new_colorop_state;
+	struct drm_colorop *colorop;
+	int i;
+
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		switch (colorop->type) {
+		case DRM_COLOROP_1D_LUT:
+		case DRM_COLOROP_CTM_3X4:
+			if (!new_colorop_state->bypass && !new_colorop_state->data) {
+				drm_dbg_atomic(crtc->dev,
+					       "Missing required DATA property for COLOROP:%d\n",
+					       colorop->base.id);
+				return -EINVAL;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
@@ -885,6 +994,7 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
 	.mode_valid	= mtk_crtc_mode_valid,
 	.atomic_begin	= mtk_crtc_atomic_begin,
 	.atomic_flush	= mtk_crtc_atomic_flush,
+	.atomic_check   = mtk_crtc_atomic_check,
 	.atomic_enable	= mtk_crtc_atomic_enable,
 	.atomic_disable	= mtk_crtc_atomic_disable,
 };
@@ -987,6 +1097,92 @@ struct device *mtk_crtc_dma_dev_get(struct drm_crtc *crtc)
 	return mtk_crtc->dma_dev;
 }
 
+#define MAX_COLOR_PIPELINE_OPS 2
+#define MAX_COLOR_PIPELINES 1
+
+static int mtk_colorop_init(struct mtk_crtc *mtk_crtc,
+			    struct mtk_drm_colorop *mtk_colorop,
+			    struct mtk_ddp_comp *ddp_comp)
+{
+	struct drm_colorop *colorop = &mtk_colorop->colorop;
+	int ret = 0;
+
+	if (ddp_comp->funcs->gamma_set_color_pipeline) {
+		unsigned int lut_sz = mtk_ddp_gamma_get_lut_size(ddp_comp);
+
+		ret = drm_crtc_colorop_curve_1d_lut_init(mtk_crtc->base.dev, colorop,
+							 &mtk_crtc->base,
+							 lut_sz,
+							 DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
+							 DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	} else if (ddp_comp->funcs->ctm_set_color_pipeline) {
+		ret = drm_crtc_colorop_ctm_3x4_init(mtk_crtc->base.dev,
+						    colorop,
+						    &mtk_crtc->base,
+						    DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	}
+
+	mtk_colorop->comp = ddp_comp;
+
+	return ret;
+}
+
+static int mtk_crtc_init_post_blend_color_pipeline(struct mtk_crtc *mtk_crtc,
+						   unsigned int gamma_lut_size)
+{
+	struct drm_prop_enum_list pipelines[MAX_COLOR_PIPELINES];
+	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
+	struct mtk_drm_colorop *mtk_colorop;
+	unsigned int num_pipelines = 0;
+	unsigned int op_idx = 0;
+	int ret;
+
+	memset(ops, 0, sizeof(ops));
+
+	for (unsigned int i = 0;
+	     i < mtk_crtc->ddp_comp_nr && op_idx < MAX_COLOR_PIPELINE_OPS;
+	     i++) {
+		struct mtk_ddp_comp *ddp_comp = mtk_crtc->ddp_comp[i];
+
+		if (!(ddp_comp->funcs->gamma_set_color_pipeline ||
+		      ddp_comp->funcs->ctm_set_color_pipeline))
+			continue;
+
+		mtk_colorop = kzalloc(sizeof(struct mtk_drm_colorop), GFP_KERNEL);
+		if (!mtk_colorop) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		ops[op_idx] = &mtk_colorop->colorop;
+
+		ret = mtk_colorop_init(mtk_crtc, mtk_colorop, ddp_comp);
+		if (ret)
+			goto cleanup;
+
+		if (op_idx > 0)
+			drm_colorop_set_next_property(ops[op_idx-1], ops[op_idx]);
+
+		op_idx++;
+	}
+
+	if (op_idx > 0) {
+		pipelines[0].type = ops[0]->base.id;
+		pipelines[0].name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
+		num_pipelines = 1;
+	}
+
+	/* Create COLOR_PIPELINE property and attach */
+	drm_crtc_create_color_pipeline_property(&mtk_crtc->base, pipelines, num_pipelines);
+
+	return 0;
+
+cleanup:
+	mtk_drm_colorop_pipeline_destroy(mtk_crtc->base.dev);
+
+	return ret;
+}
+
 int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		    unsigned int path_len, int priv_data_index,
 		    const struct mtk_drm_route *conn_routes,
@@ -1103,6 +1299,8 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 	if (ret < 0)
 		return ret;
 
+	mtk_crtc_init_post_blend_color_pipeline(mtk_crtc, gamma_lut_size);
+
 	if (gamma_lut_size)
 		drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, has_ctm, gamma_lut_size);
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 7289b3dcf22f22f344016beee0c7c144cf7b93c8..554c3cc8ad7b266b8b8eee74ceb8f7383fe2f8df 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -75,10 +75,12 @@ struct mtk_ddp_comp_funcs {
 	unsigned int (*gamma_get_lut_size)(struct device *dev);
 	void (*gamma_set)(struct device *dev,
 			  struct drm_crtc_state *state);
+	void (*gamma_set_color_pipeline)(struct device *dev, struct drm_color_lut32 *lut);
 	void (*bgclr_in_on)(struct device *dev);
 	void (*bgclr_in_off)(struct device *dev);
 	void (*ctm_set)(struct device *dev,
 			struct drm_crtc_state *state);
+	void (*ctm_set_color_pipeline)(struct device *dev, struct drm_color_ctm_3x4 *ctm);
 	struct device * (*dma_dev_get)(struct device *dev);
 	u32 (*get_blend_modes)(struct device *dev);
 	const u32 *(*get_formats)(struct device *dev);

-- 
2.50.1


