Return-Path: <linux-kernel+bounces-746991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9BB12E02
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03027ADDAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B221D63F5;
	Sun, 27 Jul 2025 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FsnjK95i"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D157263B;
	Sun, 27 Jul 2025 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753600623; cv=none; b=jWFYEdkJdgO7ugPkY4ieq/dDy12ONS0Fz57C0MJM9RGrmrRtOydKEdtry7KDzUyYg8ktc96ExXaQqEL3r0yTLhCX79d6xuPmwXOfFvtFVH5MBKkrtUhNgSftNxniKmzaAm/h7wwc+VZQJDV5ub2v1H/VuM0RTyYrJPTAM1YgnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753600623; c=relaxed/simple;
	bh=9mcHe9efp6oxiTgtCayaHIzRzBIztK6ONXL/M+lABGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJSwTG3Nuqy26LIPLcf60D1rvKu+7ocRMtA5fnl3b7qh/N/d4dPoDKVVVspY6GtXHvlY8s9CTkkIEbq+iBrEwtY7OR9VThwKlRrIXmJi1duKLdFURQSlmaNX1NjHntM4v94uehpcmjLisPLBwIdgUYc87fVlJy0kjWFY/4aR29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FsnjK95i; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ad1f4f466ab911f0b33aeb1e7f16c2b6-20250727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lSwDYgn9YwlDMceCjf92zV1EUei+uQACpaZATfJJeQ8=;
	b=FsnjK95iw5RI450xksWl7/ss7SVVkUCx91IOHCDuvXhLvhK5/8XRnHyvNgtjXDle2EgNZxd2aoRw3FOgd7/bHQQMkfwYUAwA+DQFPvY117mOEfUnrG8JmroowZuK1ipKKE1iEfrhjHYI1jUKu2K9RP9JCFxVLBYExbEYrpBEhAQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:c4113d61-8095-4f74-9f9a-38a48bb61627,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:0385360f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ad1f4f466ab911f0b33aeb1e7f16c2b6-20250727
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 677714350; Sun, 27 Jul 2025 15:16:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 27 Jul 2025 15:16:52 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 27 Jul 2025 15:16:51 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, Jay Liu <jay.liu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Hsin-Yi Wang" <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>, Yongqiang
 Niu <yongqiang.niu@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/7] drm/mediatek: Add CCORR component support for MT8196
Date: Sun, 27 Jul 2025 15:15:51 +0800
Message-ID: <20250727071609.26037-2-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250727071609.26037-1-jay.liu@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add CCORR component support for MT8196.

CCORR is a hardware module that optimizes the visual effects of
images by adjusting the color matrix, enabling features such as
night light.

The 8196 SoC has two CCORR hardware units, which must be chained
together in a fixed order in the display path to display the image
correctly. the `mtk_ccorr_ctm_set` API only utilizes one of these units.
To prevent the unused CCORR unit from inadvertently taking effect,
we need to block it in the mtk_crtc.c.

Signed-off-by: Jay Liu <jay.liu@mediatek.com>
Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c       | 5 ++++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c   | 3 ++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h   | 7 ++++---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 6 ++++--
 drivers/gpu/drm/mediatek/mtk_disp_drv.h   | 2 +-
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index bc7527542fdc..6b9cb52e9207 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -859,11 +859,14 @@ static void mtk_crtc_atomic_flush(struct drm_crtc *crtc,
 {
 	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	int i;
+	bool ctm_set = false;
 
 	if (crtc->state->color_mgmt_changed)
 		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
-			mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
+			/* only set ctm once for the pipeline with two CCORR components */
+			if (!ctm_set)
+				ctm_set = mtk_ddp_ctm_set(mtk_crtc->ddp_comp[i], crtc->state);
 		}
 	mtk_crtc_update_config(mtk_crtc, !!mtk_crtc->event);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index ac6620e10262..850e3b18da61 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -458,7 +458,8 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_DRM_ID_MAX]
 	[DDP_COMPONENT_AAL0]		= { MTK_DISP_AAL,		0, &ddp_aal },
 	[DDP_COMPONENT_AAL1]		= { MTK_DISP_AAL,		1, &ddp_aal },
 	[DDP_COMPONENT_BLS]		= { MTK_DISP_BLS,		0, NULL },
-	[DDP_COMPONENT_CCORR]		= { MTK_DISP_CCORR,		0, &ddp_ccorr },
+	[DDP_COMPONENT_CCORR0]		= { MTK_DISP_CCORR,		0, &ddp_ccorr },
+	[DDP_COMPONENT_CCORR1]		= { MTK_DISP_CCORR,		1, &ddp_ccorr },
 	[DDP_COMPONENT_COLOR0]		= { MTK_DISP_COLOR,		0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]		= { MTK_DISP_COLOR,		1, &ddp_color },
 	[DDP_COMPONENT_DITHER0]		= { MTK_DISP_DITHER,		0, &ddp_dither },
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 7289b3dcf22f..98a701ac4cde 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -77,7 +77,7 @@ struct mtk_ddp_comp_funcs {
 			  struct drm_crtc_state *state);
 	void (*bgclr_in_on)(struct device *dev);
 	void (*bgclr_in_off)(struct device *dev);
-	void (*ctm_set)(struct device *dev,
+	bool (*ctm_set)(struct device *dev,
 			struct drm_crtc_state *state);
 	struct device * (*dma_dev_get)(struct device *dev);
 	u32 (*get_blend_modes)(struct device *dev);
@@ -254,11 +254,12 @@ static inline void mtk_ddp_comp_bgclr_in_off(struct mtk_ddp_comp *comp)
 		comp->funcs->bgclr_in_off(comp->dev);
 }
 
-static inline void mtk_ddp_ctm_set(struct mtk_ddp_comp *comp,
+static inline bool mtk_ddp_ctm_set(struct mtk_ddp_comp *comp,
 				   struct drm_crtc_state *state)
 {
 	if (comp->funcs && comp->funcs->ctm_set)
-		comp->funcs->ctm_set(comp->dev, state);
+		return comp->funcs->ctm_set(comp->dev, state);
+	return false;
 }
 
 static inline struct device *mtk_ddp_comp_dma_dev_get(struct mtk_ddp_comp *comp)
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 10d60d2c2a56..85ba109d6383 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -101,7 +101,7 @@ static u16 mtk_ctm_s31_32_to_s1_n(u64 in, u32 n)
 	return r;
 }
 
-void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
+bool mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 {
 	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(dev);
 	struct drm_property_blob *blob = state->ctm;
@@ -113,7 +113,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	u32 matrix_bits = ccorr->data->matrix_bits;
 
 	if (!blob)
-		return;
+		return false;
 
 	ctm = (struct drm_color_ctm *)blob->data;
 	input = ctm->matrix;
@@ -131,6 +131,8 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 		      &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_3);
 	mtk_ddp_write(cmdq_pkt, coeffs[8] << 16,
 		      &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_4);
+
+	return true;
 }
 
 static int mtk_disp_ccorr_bind(struct device *dev, struct device *master,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 679d413bf10b..4203c28c38ce 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -22,7 +22,7 @@ void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state);
 void mtk_aal_start(struct device *dev);
 void mtk_aal_stop(struct device *dev);
 
-void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state);
+bool mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state);
 int mtk_ccorr_clk_enable(struct device *dev);
 void mtk_ccorr_clk_disable(struct device *dev);
 void mtk_ccorr_config(struct device *dev, unsigned int w,
-- 
2.46.0


