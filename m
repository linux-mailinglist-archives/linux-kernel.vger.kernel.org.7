Return-Path: <linux-kernel+bounces-687561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92478ADA68C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 04:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F6518904D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFF298998;
	Mon, 16 Jun 2025 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rN0Ac8S7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA02957AC;
	Mon, 16 Jun 2025 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042611; cv=none; b=tO8ProWrvuQjiE+x1uTccyS9i9bAIwwTSrXXY76vPA2/Ax6lxBG5GeF5DjRj/wcpBTCPBatMWTYEGRXFhwnu/H/0y5qWXVeDCtU5ZthZFG73NEGx6b62CI7Lb7lgZqOklu32htKr/HZgdJDF/nAjWs+z8bImGD1H+ZtZwMEHUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042611; c=relaxed/simple;
	bh=6/o0pxkv8IFmI3ICmV4hZTZrrOZQOAAOo4+IaWSRRmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnRVLFApe+TWX3uTjrwqDZiS1w3FOy1f26PIs/6Grk3joiee73WY6+KJhW60ncgsW9C6IrdfUIYDRzphw7upp0uxQtf2Dhdw6+e7rAe10BPF2g5sqOEKwiee7jCG74xjIlX0Bsnl8oatFyRfNmgwr5Dcf78N/amVy597CTdqC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rN0Ac8S7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 881578824a5d11f0b910cdf5d4d8066a-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EZ7HgUs7/vySNSb2uPcrZkXj0ZWbSiFjRGFESlydo6E=;
	b=rN0Ac8S7+Xi4XeFZYg36Vx0Oa2TZpKAkUreZVXT9tWhviGKG5I9CDdSL+Cyh7PRtjfCXzZnjlMDGhOR6BLEkKW54LwErK173pFiTiNe5/r9OJmP2FJNVvv0RkHdHdyLW0LYLHes1TNz4WXoqXtGmtIFzgitPdwfqoU2Q1tfAuD0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:55170dae-810c-424f-9491-cac23c6be6da,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:2a820277-7521-4364-b0ef-cd7d9c0ecbde,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 881578824a5d11f0b910cdf5d4d8066a-20250616
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 240428070; Mon, 16 Jun 2025 10:56:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:39 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>, Ning li
	<ning.li@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [RFC PATCH 4/8] iommu/arm-smmu-v3: Add implementation for MT8196 APU SMMU
Date: Mon, 16 Jun 2025 10:56:10 +0800
Message-ID: <20250616025628.25454-5-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a special implementation for mediatek APU SMMU. APU SMMU need to
wait APU SMMU's power which depends on APU driver. Therefore, add the
label mediatek,smmu-parent to point to the power device that the
smmu depends on. If the device has not finished probing, return
-EPROBE_DEFER.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-mediatek.c    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
index c00ee687d839..48290366e596 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
@@ -15,10 +15,12 @@
 #include "arm-smmu-v3.h"
 
 #define MTK_SMMU_COMP_STR_LEN		64
+#define SMMU_REQUIRE_PARENT		BIT(5)
 #define MTK_SMMU_HAS_FLAG(pdata, _x)    (!!(((pdata)->flags) & (_x)))
 
 enum mtk_smmu_type {
 	MTK_SMMU_MM,
+	MTK_SMMU_APU,
 	MTK_SMMU_TYPE_NUM,
 };
 
@@ -36,12 +38,18 @@ static const struct mtk_smmu_v3_plat mt8196_data_mm = {
 	.smmu_type		= MTK_SMMU_MM,
 };
 
+static const struct mtk_smmu_v3_plat mt8196_data_apu = {
+	.smmu_type		= MTK_SMMU_APU,
+	.flags			= SMMU_REQUIRE_PARENT,
+};
+
 struct mtk_smmu_v3_of_device_data {
 	char			compatible[MTK_SMMU_COMP_STR_LEN];
 	const void		*data;
 };
 
 static const struct mtk_smmu_v3_of_device_data mtk_smmu_v3_of_ids[] = {
+	{ .compatible = "mediatek,mt8196-apu-smmu", .data = &mt8196_data_apu},
 	{ .compatible = "mediatek,mt8196-mm-smmu", .data = &mt8196_data_mm},
 };
 
@@ -79,5 +87,29 @@ struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (MTK_SMMU_HAS_FLAG(mtk_smmu_v3->plat_data, SMMU_REQUIRE_PARENT)) {
+		parent_node = of_parse_phandle(dev->of_node, "mediatek,smmu-parent", 0);
+		if (!parent_node) {
+			dev_err(dev, "Lack its parent node.\n");
+			return ERR_PTR(-EINVAL);
+		}
+		if (!of_device_is_available(parent_node)) {
+			of_node_put(parent_node);
+			return ERR_PTR(-EINVAL);
+		}
+
+		parent_pdev = of_find_device_by_node(parent_node);
+		of_node_put(parent_node);
+		if (!parent_pdev) {
+			dev_err(dev, "Lack its parent devices.\n");
+			return ERR_PTR(-ENODEV);
+		}
+
+		if (!platform_get_drvdata(parent_pdev)) {
+			dev_err(dev, "Delay since its parent driver is not ready.\n");
+			return ERR_PTR(-EPROBE_DEFER);
+		}
+	}
+
 	return &mtk_smmu_v3->smmu;
 }
-- 
2.46.0


