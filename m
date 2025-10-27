Return-Path: <linux-kernel+bounces-871495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F749C0D792
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E5A3BCF62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8782F7471;
	Mon, 27 Oct 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bbPKOvL8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2303B2A0;
	Mon, 27 Oct 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567324; cv=none; b=mpp1X3A9/Gs2koT2vsiZUSKsjl+TAzjSa4Zh+t9QZdKVVNrQDez9bUwEaEJIWSn2odGIWHCX3SOAjlTXLJMVNALXdGiIyyCMdWDxghmqNp2x0EksRFUIf7wW2Dnb3y2ymIw9/3QqFfV9qz1Z1FXYE5GLanaSLli8Chjje9xXBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567324; c=relaxed/simple;
	bh=6EE1sFtVuCA74NZXgrypx0nNMCv8KnZ9CqWQfj1SAoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtBYDdLlpm92kQ/VwaU95y5C/5vGse7hiCawOS3ZopW1YmBW0hMTrsYwNktkJnIJVbWFVzR40F5Plg7Gzp9stgov/KTl3Y72KGGZKTDmBmoEvNzBj2q5QwzABjobQ4pv6Dz/Zy7fu5BOjQnlbqS7rA1z0xO1D7Tjr+9CH3gP0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bbPKOvL8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9615fb52b32e11f0ae1e63ff8927bad3-20251027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4Wra1rfIu4hcjIW/mcKFsb7Xyed7D20AFlt/g6K1gWU=;
	b=bbPKOvL8OqROAX7DRVNYCPxlbzsNYihPbFF+veepbvCFKDe/lf3TKq8yBUfki5kASVDhDjmlVFbJPtSeYD/lYreD6H6JTT4mejQQf/DMmPrndx7EaH+gqo/OeHU+YC/y9AfB1wSTWH5xewnjciqCjZTSvbH5W4IFYglqHe1LZOU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bda9edfe-34f9-4e5d-9be0-c2d66faad181,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:23205a84-4124-4606-b51d-d5c9eec0e7b9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9615fb52b32e11f0ae1e63ff8927bad3-20251027
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 559775049; Mon, 27 Oct 2025 20:15:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 27 Oct 2025 20:15:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 27 Oct 2025 20:15:07 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH v2 2/2] memory: mtk-smi: Add mt8189 support
Date: Mon, 27 Oct 2025 20:14:28 +0800
Message-ID: <20251027121443.16783-3-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
References: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the necessary platform data and ostdl setting to enable support
for mt8189 smi.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/memory/mtk-smi.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 733e22f695ab..80af9c214c83 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -401,6 +401,30 @@ static const u8 mtk_smi_larb_mt8188_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[25] = {0x01},
 };
 
+static const u8 mtk_smi_larb_mt8189_ostd[][SMI_LARB_PORT_NR_MAX] = {
+	[0] = {0x8, 0x20, 0x20, 0x20, 0x20, 0x20, 0x10, 0x0,},
+	[1] = {0x8, 0x20, 0x20, 0x20, 0x20, 0x20, 0x10, 0x0,},
+	[2] = {0x7, 0x7, 0x4, 0x4, 0x0, 0x0, 0x2, 0x2, 0x7, 0x7, 0x0,},
+	[4] = {0x2F, 0x1E, 0x9, 0x1, 0x1, 0x1, 0x1, 0x2, 0x2, 0x5, 0x1, 0x17,},
+	[7] = {0x20, 0x2, 0x1, 0x1, 0x1, 0x4, 0x2, 0x1, 0x1, 0x2, 0x3, 0x2,
+	       0xA, 0xF, 0x4, 0x6, 0x5, 0x1,},
+	[9] = {0x6, 0x3, 0xC, 0x6, 0x1, 0x4, 0x3, 0x1, 0x2, 0x4, 0x5, 0x2,
+	       0x4, 0x2, 0x3, 0xB, 0x1, 0x4, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+	       0x1, 0x1,},
+	[11] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x1, 0x1, 0xB, 0x1, 0x4, 0x6, 0x5, 0x6, 0x1, 0x5, 0x2,
+		0x9, 0x5,},
+	[13] = {0x2, 0x8, 0x8, 0x8, 0x4, 0x4, 0x4, 0x4, 0x4, 0xE, 0x4, 0x1,
+		0x6, 0x6, 0x2,},
+	[14] = {0x1, 0x1, 0x1, 0x20, 0xE, 0x4, 0x8, 0x8, 0x6, 0x4,},
+	[16] = {0x1E, 0xC, 0x2, 0x8, 0xE, 0x2, 0x1E, 0x10, 0x4, 0x2, 0x2, 0x2,
+		0x2, 0x2, 0x4, 0x2, 0x4,},
+	[17] = {0x1E, 0xC, 0x2, 0x8, 0xE, 0x2, 0x1E, 0x10, 0x4, 0x2, 0x2, 0x2,
+		0x2, 0x2, 0x4, 0x2, 0x4,},
+	[19] = {0x2, 0x1, 0x3, 0x1,},
+	[20] = {0x7, 0x7, 0x3, 0x3, 0x1, 0x1,},
+};
+
 static const u8 mtk_smi_larb_mt8192_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[0] = {0x2, 0x2, 0x28, 0xa, 0xc, 0x28,},
 	[1] = {0x2, 0x2, 0x18, 0x18, 0x18, 0xa, 0xc, 0x28,},
@@ -533,6 +557,13 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8188 = {
 	.ostd		            = mtk_smi_larb_mt8188_ostd,
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8189 = {
+	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
+				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
+	.ostd		            = mtk_smi_larb_mt8189_ostd,
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
 	.ostd			    = mtk_smi_larb_mt8192_ostd,
@@ -556,6 +587,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
 	{.compatible = "mediatek,mt8186-smi-larb", .data = &mtk_smi_larb_mt8186},
 	{.compatible = "mediatek,mt8188-smi-larb", .data = &mtk_smi_larb_mt8188},
+	{.compatible = "mediatek,mt8189-smi-larb", .data = &mtk_smi_larb_mt8189},
 	{.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
 	{.compatible = "mediatek,mt8195-smi-larb", .data = &mtk_smi_larb_mt8195},
 	{}
@@ -803,6 +835,16 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
 	.init     = mtk_smi_common_mt8195_init,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8189 = {
+	.type     = MTK_SMI_GEN2,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
+		    F_MMU1_LARB(7),
+};
+
+static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8189 = {
+	.type     = MTK_SMI_GEN2_SUB_COMM,
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
@@ -847,6 +889,8 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
 	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
 	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
+	{.compatible = "mediatek,mt8189-smi-common", .data = &mtk_smi_common_mt8189},
+	{.compatible = "mediatek,mt8189-smi-sub-common", .data = &mtk_smi_sub_common_mt8189},
 	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
-- 
2.46.0


