Return-Path: <linux-kernel+bounces-860271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E28BEFB6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6D4189C4DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2D2E9757;
	Mon, 20 Oct 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ujfnKOT/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAD2E8E0D;
	Mon, 20 Oct 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946164; cv=none; b=geHFgEdK3XuPcjSPfDR94ClxpfyAhfCGG844O42J6B0I9KrXTm1W6Mzj4cuioM+4DA0aLO8Dhz/qyv6sY+jvpkTB2JtQ1R34nPQ2L0E9YHcTO4HT3sg68j9bJUaADb5h/0XMVjre3ozcTpPM0kaRTLJ8T7+83JDl4KEf1dbSxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946164; c=relaxed/simple;
	bh=u85rAd7a6xb2dnzQ/GOw1lCG4truPoUl2x5/rTNdaY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHeRQqqynfQSSplfQ1g86343tK+ZOHBzw2uvIKwWZBZSp6LZfK6ViUYr96TX0Gr0VFO0HbIavWJecgBKRAOPmZJGaRBC3i+TAQnREZon8yBTUtiCSfHTEklaWSEvmp23bJB1li/hyKq+IMJkrfxs9+CfIrKXZkstfwQ2CvNsw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ujfnKOT/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 59fb88fead8811f0ae1e63ff8927bad3-20251020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=skWTZtYKSk+L0V02K1h9jMQUDLDlNwNtlzucoipLJko=;
	b=ujfnKOT/2FXo9PT8ZM6g6ZfiTmjMPsgDxV0qBuH15pU41kNmPjv7Hl4TfF4MJ0L8AeQjNi9Ldt4lXZP0uRDKkbikhWVawbc8SYMkGEMOqwHoLI4CMVpQInuFcAXPtbsRQ0L4CNUR0w5iD14pWaOBdtqnUjAgWAb9ZERzacxrXmo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:76503915-3989-4549-bf70-f447cef995be,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:d09c3e51-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59fb88fead8811f0ae1e63ff8927bad3-20251020
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1237109764; Mon, 20 Oct 2025 15:42:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 20 Oct 2025 15:42:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 20 Oct 2025 15:42:32 +0800
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
Subject: [PATCH v1 13/13] soc: mediatek: mutex: add mutex support for MT8189
Date: Mon, 20 Oct 2025 15:40:26 +0800
Message-ID: <20251020074211.8942-14-xiandong.wang@mediatek.com>
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

Add mutex support for the main and external displays in MT8189:
- Introduce a new DVO1 output component for the new mutex
  settings of MT8189.
- Add a need_sof_mof flag to configure both SOF and MOD settings
  for the output component.

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index c48983d8a6cd..743c4b93a39e 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -177,6 +177,48 @@
 #define MT8188_MUTEX_MOD_DISP1_DPI1		38
 #define MT8188_MUTEX_MOD_DISP1_DP_INTF1		39
 
+#define MT8189_DISP_MUTEX0_MOD0			0x30
+#define MT8189_DISP_MUTEX0_MOD1			0x34
+#define MT8189_DISP_MUTEX0_SOF			0x2C
+#define MT8189_MUTEX_MOD_DISP_OVL0		0
+#define MT8189_MUTEX_MOD_DISP_OVL1		1
+#define MT8189_MUTEX_MOD_DISP_RSZ0		2
+#define MT8189_MUTEX_MOD_DISP_RSZ1		3
+#define MT8189_MUTEX_MOD_DISP_RDMA0		4
+#define MT8189_MUTEX_MOD_DISP_RDMA1		5
+#define MT8189_MUTEX_MOD_DISP_COLOR0		6
+#define MT8189_MUTEX_MOD_DISP_COLOR1		4
+#define MT8189_MUTEX_MOD_DISP_CCORR0		8
+#define MT8189_MUTEX_MOD_DISP_CCORR1		9
+#define MT8189_MUTEX_MOD_DISP_CCORR2		10
+#define MT8189_MUTEX_MOD_DISP_CCORR3		11
+#define MT8189_MUTEX_MOD_DISP_AAL0		12
+#define MT8189_MUTEX_MOD_DISP_AAL1		13
+#define MT8189_MUTEX_MOD_DISP_GAMMA0		14
+#define MT8189_MUTEX_MOD_DISP_GAMMA1		15
+#define MT8189_MUTEX_MOD_DISP_DITHER0		16
+#define MT8189_MUTEX_MOD_DISP_DITHER1		17
+#define MT8189_MUTEX_MOD_DISP_VPP_MERGE0	18
+#define MT8189_MUTEX_MOD_DISP_DSC_WRAP0_CORE0	19
+#define MT8189_MUTEX_MOD_DISP_DSC_WRAP0_CORE1	20
+#define MT8189_MUTEX_MOD_DISP_DVO0		21
+#define MT8189_MUTEX_MOD_DISP_DSI0		22
+#define MT8189_MUTEX_MOD_DISP_DVO1		23
+#define MT8189_MUTEX_MOD_DISP_DPI0		24
+#define MT8189_MUTEX_MOD_DISP_WDMA0		25
+#define MT8189_MUTEX_MOD_DISP_WDMA1		26
+#define MT8189_MUTEX_MOD_DISP_PWM0		27
+#define MT8189_MUTEX_MOD_DISP_PWM1		28
+#define MT8189_MUTEX_MOD_ALL			0xff
+
+#define MT8189_MUTEX_SOF_SINGLE_MODE		0
+#define MT8189_MUTEX_SOF_DSI0			1
+#define MT8189_MUTEX_EOF_DSI0			(MT8189_MUTEX_SOF_DSI0 << 7)
+#define MT8189_MUTEX_SOF_DVO			5
+#define MT8189_MUTEX_EOF_DVO			(MT8189_MUTEX_SOF_DVO << 7)
+#define MT8189_MUTEX_SOF_DPTX			6
+#define MT8189_MUTEX_EOF_DPTX			(MT8189_MUTEX_SOF_DPTX << 7)
+
 #define MT8195_MUTEX_MOD_DISP_OVL0		0
 #define MT8195_MUTEX_MOD_DISP_WDMA0		1
 #define MT8195_MUTEX_MOD_DISP_RDMA0		2
@@ -554,6 +596,34 @@ static const u8 mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_WROT3] = MT8195_MUTEX_MOD_MDP_WROT3,
 };
 
+static const unsigned int mt8189_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_OVL0] = MT8189_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL1] = MT8189_MUTEX_MOD_DISP_OVL1,
+	[DDP_COMPONENT_RSZ0] = MT8189_MUTEX_MOD_DISP_RSZ0,
+	[DDP_COMPONENT_RSZ1] = MT8189_MUTEX_MOD_DISP_RSZ1,
+	[DDP_COMPONENT_RDMA0] = MT8189_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT8189_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_COLOR0] = MT8189_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_COLOR1] = MT8189_MUTEX_MOD_DISP_COLOR1,
+	[DDP_COMPONENT_CCORR0] = MT8189_MUTEX_MOD_DISP_CCORR0,
+	[DDP_COMPONENT_CCORR1] = MT8189_MUTEX_MOD_DISP_CCORR1,
+	[DDP_COMPONENT_AAL0] = MT8189_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_AAL1] = MT8189_MUTEX_MOD_DISP_AAL1,
+	[DDP_COMPONENT_GAMMA] = MT8189_MUTEX_MOD_DISP_GAMMA0,
+	[DDP_COMPONENT_DITHER0] = MT8189_MUTEX_MOD_DISP_DITHER0,
+	[DDP_COMPONENT_DITHER1] = MT8189_MUTEX_MOD_DISP_DITHER1,
+	[DDP_COMPONENT_MERGE0] = MT8189_MUTEX_MOD_DISP_VPP_MERGE0,
+	[DDP_COMPONENT_DSC0] = MT8189_MUTEX_MOD_DISP_DSC_WRAP0_CORE0,
+	[DDP_COMPONENT_DVO0] = MT8189_MUTEX_MOD_DISP_DVO0,
+	[DDP_COMPONENT_DVO1] = MT8189_MUTEX_MOD_DISP_DVO1,
+	[DDP_COMPONENT_DSI0] = MT8189_MUTEX_MOD_DISP_DSI0,
+	[DDP_COMPONENT_WDMA0] = MT8189_MUTEX_MOD_DISP_WDMA0,
+	[DDP_COMPONENT_PWM0] = MT8189_MUTEX_MOD_DISP_PWM0,
+	[DDP_COMPONENT_COMP0_OUT_CB4] = MT8189_MUTEX_MOD_ALL,
+	[DDP_COMPONENT_COMP0_OUT_CB5] = MT8189_MUTEX_MOD_ALL,
+	[MT8189_MUTEX_MOD_DISP_PWM1] = MT8189_MUTEX_MOD_DISP_PWM1,
+};
+
 static const u8 mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
@@ -718,6 +788,14 @@ static const u16 mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 		MT8188_MUTEX_SOF_DP_INTF1 | MT8188_MUTEX_EOF_DP_INTF1,
 };
 
+static const unsigned int mt8189_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+	[MUTEX_SOF_SINGLE_MODE] = MT8189_MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_SOF_DSI0] =
+		MT8189_MUTEX_SOF_DSI0 | MT8189_MUTEX_EOF_DSI0,
+	[MUTEX_SOF_DP_INTF0] =
+		MT8189_MUTEX_SOF_DPTX | MT8189_MUTEX_EOF_DPTX,
+};
+
 static const u16 mt8195_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MT8195_MUTEX_SOF_DSI0 | MT8195_MUTEX_EOF_DSI0,
@@ -812,6 +890,14 @@ static const struct mtk_mutex_data mt8188_vpp_mutex_driver_data = {
 	.mutex_table_mod = mt8188_mdp_mutex_table_mod,
 };
 
+static const struct mtk_mutex_data mt8189_mutex_driver_data = {
+	.mutex_mod = mt8189_mutex_mod,
+	.mutex_sof = mt8189_mutex_sof,
+	.mutex_mod_reg = MT8189_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8189_DISP_MUTEX0_SOF,
+	.need_sof_mod = true,
+};
+
 static const struct mtk_mutex_data mt8192_mutex_driver_data = {
 	.mutex_mod = mt8192_mutex_mod,
 	.mutex_sof = mt8183_mutex_sof,
@@ -903,6 +989,7 @@ static int mtk_mutex_get_output_comp_sof(enum mtk_ddp_comp_id id)
 	case DDP_COMPONENT_DPI1:
 		return MUTEX_SOF_DPI1;
 	case DDP_COMPONENT_DP_INTF0:
+	case DDP_COMPONENT_DVO1:
 		return MUTEX_SOF_DP_INTF0;
 	case DDP_COMPONENT_DP_INTF1:
 		return MUTEX_SOF_DP_INTF1;
@@ -1182,6 +1269,7 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt8186-mdp3-mutex", .data = &mt8186_mdp_mutex_driver_data },
 	{ .compatible = "mediatek,mt8188-disp-mutex", .data = &mt8188_mutex_driver_data },
 	{ .compatible = "mediatek,mt8188-vpp-mutex",  .data = &mt8188_vpp_mutex_driver_data },
+	{ .compatible = "mediatek,mt8189-disp-mutex", .data = &mt8189_mutex_driver_data },
 	{ .compatible = "mediatek,mt8192-disp-mutex", .data = &mt8192_mutex_driver_data },
 	{ .compatible = "mediatek,mt8195-disp-mutex", .data = &mt8195_mutex_driver_data },
 	{ .compatible = "mediatek,mt8195-vpp-mutex",  .data = &mt8195_vpp_mutex_driver_data },
-- 
2.46.0


