Return-Path: <linux-kernel+bounces-860272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EFDBEFB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05273BF508
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721F2DEA67;
	Mon, 20 Oct 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F2/+6J/E"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE582E92D0;
	Mon, 20 Oct 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946165; cv=none; b=PkxTcf73VOC2OnlaCfv7j80apTozVAY58FdkEx9afT9e1j1aA0d/aGcR669wtdUO3OG6JOn7TNKoteHVnbCHRvWgAqojjNmXb3deGV+VVGREeuE02VBU2/c1X11HxIFi4CZUhVGQUi/Bvc9m4kPmnB+MzO7YhUiUoHNXv0E2QHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946165; c=relaxed/simple;
	bh=9N3ZfC46dTEpm5px1XwxhR98X7yCv7mzikXM33QShHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngv7FEA9urUmU65m4fU240nxC2SC3+3D9fBYpjzWdg671PJHClyY8osIeSI0NhBaV6iuMYwkTV7xFxmGE5GE2PQs7jXfDCCzOLOt5p8PSoVoSPYqWVTzx1+bbvikUvgByPxNB0YSPcbBhB7NYu/OdWJkjPWS3bGd9G6vJbRv1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=F2/+6J/E; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 59870f06ad8811f0ae1e63ff8927bad3-20251020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=unI0wIIqbAP2uomB4vfvFmF0dxJjVLm6Syq3B3eb2GU=;
	b=F2/+6J/E12E/dghsAZx2NlbVAs9FNivDZOHfIBeJFd1Tv++vbb+F2lcrxS73k5E01CXpY53guDLjeqBe5a2M408PfzpGnGxipYsUVHZhHk80Rmkw/+S7Li68Pd4XxzPGhB78R1gO+9rPB0JSlNnFKtV5gQbZezKdCc+xAlgxAyI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:71597775-edb4-460d-9257-04241aa4cf2f,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:c8416686-2e17-44e4-a09c-1e463bf6bc47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59870f06ad8811f0ae1e63ff8927bad3-20251020
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 968935925; Mon, 20 Oct 2025 15:42:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 20 Oct 2025 15:42:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 20 Oct 2025 15:42:31 +0800
From: Xiandong Wang <xiandong.wang@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v1 12/13] drm/mediatek: Add support for mt8189 mmsys driver probe
Date: Mon, 20 Oct 2025 15:40:25 +0800
Message-ID: <20251020074211.8942-13-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251020074211.8942-1-xiandong.wang@mediatek.com>
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

mmsys probe for mt8189

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c  |  2 ++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 40 ++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.h  |  2 ++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  8 +++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 39 +++++++++++++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index ac6620e10262..b83ecd5404c6 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -498,6 +498,8 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_DRM_ID_MAX]
 	[DDP_COMPONENT_UFOE]		= { MTK_DISP_UFOE,		0, &ddp_ufoe },
 	[DDP_COMPONENT_WDMA0]		= { MTK_DISP_WDMA,		0, NULL },
 	[DDP_COMPONENT_WDMA1]		= { MTK_DISP_WDMA,		1, NULL },
+	[DDP_COMPONENT_COMP0_OUT_CB4]	= { MTK_DISP_VIRTUAL,		-1, NULL },
+	[DDP_COMPONENT_COMP0_OUT_CB5]	= { MTK_DISP_VIRTUAL,		-1, NULL },
 };
 
 static bool mtk_ddp_comp_find(struct device *dev,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 7cd3978beb98..f1fa1f1c3ff0 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -110,6 +110,32 @@ const u32 mt8173_ovl_formats[] = {
 
 const size_t mt8173_ovl_formats_len = ARRAY_SIZE(mt8173_ovl_formats);
 
+const u32 mt8189_ovl_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_ARGB2101010,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_BGRX1010102,
+	DRM_FORMAT_BGRA1010102,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XBGR2101010,
+	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_RGBX1010102,
+	DRM_FORMAT_RGBA1010102,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_YUYV,
+};
+
+const size_t mt8189_ovl_formats_len = ARRAY_SIZE(mt8189_ovl_formats);
+
 const u32 mt8195_ovl_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
@@ -779,6 +805,18 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
 	.num_formats = mt8173_ovl_formats_len,
 };
 
+static const struct mtk_disp_ovl_data mt8189_ovl_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 4,
+	.fmt_rgb565_is_0 = true,
+	.smi_id_en = true,
+	.supports_afbc = true,
+	.formats = mt8189_formats,
+	.num_formats = ARRAY_SIZE(mt8189_formats),
+	.supports_clrfmt_ext = true,
+};
+
 static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
 	.addr = DISP_REG_OVL_ADDR_MT8173,
 	.gmc_bits = 10,
@@ -823,6 +861,8 @@ static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
 	  .data = &mt8183_ovl_driver_data},
 	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
 	  .data = &mt8183_ovl_2l_driver_data},
+	{ .compatible = "mediatek,mt8189-disp-ovl",
+	  .data = &mt8189_ovl_driver_data},
 	{ .compatible = "mediatek,mt8192-disp-ovl",
 	  .data = &mt8192_ovl_driver_data},
 	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.h b/drivers/gpu/drm/mediatek/mtk_disp_ovl.h
index 431567538eb5..675254e786d4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.h
@@ -16,6 +16,8 @@
 
 extern const u32 mt8173_ovl_formats[];
 extern const size_t mt8173_ovl_formats_len;
+extern const u32 mt8189_ovl_formats[];
+extern const size_t mt8189_ovl_formats_len;
 extern const u32 mt8195_ovl_formats[];
 extern const size_t mt8195_ovl_formats_len;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index c9d41d75e7f2..593d9d144218 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -394,6 +394,12 @@ static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
 
+static const struct mtk_disp_rdma_data mt8189_rdma_driver_data = {
+	.fifo_size = 1920,
+	.formats = mt8173_formats,
+	.num_formats = ARRAY_SIZE(mt8173_formats),
+};
+
 static const struct mtk_disp_rdma_data mt8195_rdma_driver_data = {
 	.fifo_size = 1920,
 	.formats = mt8173_formats,
@@ -407,6 +413,8 @@ static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
 	  .data = &mt8173_rdma_driver_data},
 	{ .compatible = "mediatek,mt8183-disp-rdma",
 	  .data = &mt8183_rdma_driver_data},
+	{ .compatible = "mediatek,mt8189-disp-rdma",
+	  .data = &mt8189_rdma_driver_data},
 	{ .compatible = "mediatek,mt8195-disp-rdma",
 	  .data = &mt8195_rdma_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 4c19cffafd0f..9e6d949e5d17 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -187,11 +187,27 @@ static const unsigned int mt8188_mtk_ddp_main[] = {
 	DDP_COMPONENT_DITHER0,
 };
 
+static const unsigned int mt8189_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COMP0_OUT_CB4,
+};
+
+static const unsigned int mt8189_mtk_ddp_ext[] = {
+	DDP_COMPONENT_OVL1,
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_COMP0_OUT_CB5,
+};
+
 static const struct mtk_drm_route mt8188_mtk_ddp_main_routes[] = {
 	{0, DDP_COMPONENT_DP_INTF0},
 	{0, DDP_COMPONENT_DSI0},
 };
 
+static const struct mtk_drm_route mt8189_mtk_ddp_ext_routes[] = {
+	{1, DDP_COMPONENT_DSI0},
+};
+
 static const struct mtk_drm_route mt8196_mtk_ddp_routes[] = {
 	{2, DDP_COMPONENT_DSI0},
 };
@@ -347,6 +363,19 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
 	.min_height = 1,
 };
 
+static const struct mtk_mmsys_driver_data mt8189_mmsys_driver_data = {
+	.main_path = mt8189_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8189_mtk_ddp_main),
+	.mmsys_dev_num = 1,
+	.ext_path = mt8189_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt8189_mtk_ddp_ext),
+	.conn_routes = mt8189_mtk_ddp_ext_routes,
+	.num_conn_routes = ARRAY_SIZE(mt8189_mtk_ddp_ext_routes),
+	.max_width = 8191,
+	.min_width = 1,
+	.min_height = 1,
+};
+
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
 	.main_path = mt8192_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt8192_mtk_ddp_main),
@@ -454,6 +483,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 	  .data = &mt8188_vdosys0_driver_data},
 	{ .compatible = "mediatek,mt8188-vdosys1",
 	  .data = &mt8195_vdosys1_driver_data},
+	{ .compatible = "mediatek,mt8189-mmsys",
+	  .data = &mt8189_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8192-mmsys",
 	  .data = &mt8192_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8195-mmsys",
@@ -883,6 +914,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8188-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt8189-disp-mutex",
+	  .data = (void *)MTK_DISP_MUTEX},
 	{ .compatible = "mediatek,mt8192-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8195-disp-mutex",
@@ -899,6 +932,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8183-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8189-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL},
 	{ .compatible = "mediatek,mt8192-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8195-disp-ovl",
@@ -923,6 +958,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8183-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8189-disp-rdma",
+	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8195-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",
@@ -957,6 +994,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8188-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8189-dsi",
+	  .data = (void *)MTK_DSI },
 	{ }
 };
 
-- 
2.46.0


