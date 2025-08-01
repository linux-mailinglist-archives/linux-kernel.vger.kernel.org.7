Return-Path: <linux-kernel+bounces-752965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179CB17D21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FB7189E5DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AC220B801;
	Fri,  1 Aug 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yx03isgu"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CD1FF610;
	Fri,  1 Aug 2025 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032169; cv=none; b=id209tmsT67DSFBWXp6k/fHFznz2y5Fqtwr0BIorg/i6oPAPhnxtjzZd79J50qXJAWAbyS/UBijx3HCDkGQeG/AUZCqHal0oXQ28yHyrDpREgLYqs/V3/EXiz3WqFrP1S7E/eYCQ3v/3KmCKk98tRohdsNO/sOBO8hxLDA+qtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032169; c=relaxed/simple;
	bh=fl6uSeYxRMWH3jKSu6Bok18lfxJuGijlT0DWX2EIMOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J22dSGtaTxpGGbD3PC4Ftl/T3oYp6R7DAtZlc3+BfP0Kz8Y8eMSH+Y3bOxzAmJW8uGOo0hItGWdt7K3Iu3iNRLMRlrE9y/xO1YsVD/qA6NtPgHXC+aqVBZ4dHWAiEPuiwpABHOgToxzD8jtL1gY1ZgnrssqUkC86Ph1rPw6laDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Yx03isgu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 73a3e4486ea611f0b33aeb1e7f16c2b6-20250801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cn2RoAisMKaAgdwYwaUWd9l5blW+koqxiGIwZNbsspk=;
	b=Yx03isguInoReYLzSgAx5TSR+1qmFNfoc9yY42tkd9X1L63CTAHZ0hEI3TUTNVd/k294V3LKOtlLkRtqvdsRjQDxvGtkmyGsUpdPMaPVx6f6l2adVDuEtS87j2UObsvSV1GxGyIrXRrbCdhIYqbGItSqx9F/NeTR4tpL1gJR1IA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:06aee1f3-832a-4c41-a0ee-1e4c0e87825d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:9eb4ff7,CLOUDID:2c750209-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73a3e4486ea611f0b33aeb1e7f16c2b6-20250801
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1640975403; Fri, 01 Aug 2025 15:09:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 1 Aug 2025 15:09:21 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 1 Aug 2025 15:09:20 +0800
From: niklaus.liu <niklaus.liu@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flora Fu
	<flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, niklaus.liu
	<niklaus.liu@mediatek.com>
Subject: [PATCH 3/3] regulator: Modify mt6315 regulator mode mask
Date: Fri, 1 Aug 2025 14:39:37 +0800
Message-ID: <20250801070913.3109-4-niklaus.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250801070913.3109-1-niklaus.liu@mediatek.com>
References: <20250801070913.3109-1-niklaus.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Modify mt6315 regulator mode mask, compatible with all 6315 models

Signed-off-by: niklaus.liu <niklaus.liu@mediatek.com>
---
 drivers/regulator/mt6315-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index 2608a6652d77..092ff748fe21 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -218,8 +218,10 @@ static int mt6315_regulator_probe(struct spmi_device *pdev)
 	struct regmap *regmap;
 	struct mt6315_chip *chip;
 	struct mt_regulator_init_data *init_data;
+	struct device_node *node = pdev->dev.of_node;
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
+	unsigned int val = 0;
 	int i;
 
 	regmap = devm_regmap_init_spmi_ext(pdev, &mt6315_regmap_config);
@@ -247,6 +249,10 @@ static int mt6315_regulator_probe(struct spmi_device *pdev)
 		init_data->modeset_mask[MT6315_VBUCK1] = BIT(MT6315_VBUCK1);
 		break;
 	}
+
+	if (!of_property_read_u32(node, "buck1-modeset-mask", &val))
+		init_data->modeset_mask[MT6315_VBUCK1] = val;
+
 	for (i = MT6315_VBUCK2; i < MT6315_VBUCK_MAX; i++)
 		init_data->modeset_mask[i] = BIT(i);
 
-- 
2.46.0


