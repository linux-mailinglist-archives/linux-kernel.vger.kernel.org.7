Return-Path: <linux-kernel+bounces-859215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F737BED088
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55F274E5FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCFE2EB874;
	Sat, 18 Oct 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U56HXIsW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E22C2345;
	Sat, 18 Oct 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760794000; cv=none; b=i/PbXAAxoP1m9ulpuyMlbKquSOwYAXgshCNl/BeZZNSL0wLr1+ospXd950jBlIYNKjOxhG6B9oRjxoHn80kRVncTbRKEp/19Uu3z8Pk4qYpmSGVka7n8MuLwfXg/WHWHiCdv2cEtf0t9Ojqm50WOEmKfEf0Zhp/RtagnzpCpE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760794000; c=relaxed/simple;
	bh=3cEf3d+X8V/4a8a5FuB0/Q0mvJ98pCGXF+hPk1MFOlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMCQ8UvDmDe+Cir/Hl6SyHLTOOE9UGj0wyC0ZpcRydcCcHaoLZzWjZXYGcq6UYfJK3PiMw6BYdR8bV3CEpiY6sBP62RtvrOdXKqjQvHGppD7JmONff3/SUCYt4MIiLjqbZz23gAEhN+u1NbTck58JQs/AsGne8j21UvRaf+hExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U56HXIsW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 10a10444ac2611f0b33aeb1e7f16c2b6-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8H5vzOhfwOFb0ThMppbAGaVCE3dpwzVxkrOGXVN0X4A=;
	b=U56HXIsWeXMkVxw2FVs+eRWndkC2JgtACT8oTIonBfGI6qyPXeahJjUtjRHU35h8KAc7mPb4MxuxoYRHo8YZquNm8q+H2ZJ3GRWE66L8naztuR/rK1ShtdzniEl66XRRDcZ/R/WfPdy+HqoqMVir2BuJvidpkjz0lzunWSdewr8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:902b4ab5-6474-4fb3-9977-b0c3ba185b49,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:358f3251-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 10a10444ac2611f0b33aeb1e7f16c2b6-20251018
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1493803656; Sat, 18 Oct 2025 21:26:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 21:26:29 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 21:26:28 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH v4 4/5] iommu/mediatek: mt8189: Add INFRA IOMMUs support
Date: Sat, 18 Oct 2025 21:26:13 +0800
Message-ID: <20251018132625.14428-5-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
References: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for mt8189 INFRA IOMMUs.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index aa4972aed91e..e71acaa292cc 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -339,6 +339,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int ban
 #define MTK_IOMMU_4GB_MODE_REMAP_BASE	 0x140000000UL
 
 static LIST_HEAD(apulist);	/* List the apu iommu HWs */
+static LIST_HEAD(infralist);	/* List the iommu_infra HW */
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
@@ -1758,6 +1759,18 @@ static const struct mtk_iommu_plat_data mt8189_data_apu = {
 	.iova_region_larb_msk = mt8189_apu_region_msk,
 };
 
+static const struct mtk_iommu_plat_data mt8189_data_infra = {
+	.m4u_plat	= M4U_MT8189,
+	.flags		= WR_THROT_EN | DCM_DISABLE | MTK_IOMMU_TYPE_INFRA |
+			  CFG_IFA_MASTER_IN_ATF | SHARE_PGTABLE | PGTABLE_PA_35_EN,
+	.hw_list	= &infralist,
+	.banks_num	= 1,
+	.banks_enable	= {true},
+	.inv_sel_reg	= REG_MMU_INV_SEL_GEN2,
+	.iova_region	= single_domain,
+	.iova_region_nr	= ARRAY_SIZE(single_domain),
+};
+
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1860,6 +1873,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-iommu-vdo",   .data = &mt8188_data_vdo},
 	{ .compatible = "mediatek,mt8188-iommu-vpp",   .data = &mt8188_data_vpp},
 	{ .compatible = "mediatek,mt8189-iommu-apu",   .data = &mt8189_data_apu},
+	{ .compatible = "mediatek,mt8189-iommu-infra", .data = &mt8189_data_infra},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
-- 
2.46.0


