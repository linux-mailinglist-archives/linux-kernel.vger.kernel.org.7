Return-Path: <linux-kernel+bounces-752964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D57B17D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DEC4E7EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24805202C30;
	Fri,  1 Aug 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oMtlIV44"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CC1F582B;
	Fri,  1 Aug 2025 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032167; cv=none; b=DD3LVSZxZEYxl+FuKqfOTGF1jxp1YAa0MVFi7Xkz/ALt0NE9Ks343iRnQVUsFjrn6/GI6shddB37S60bpzs1dGGTbgsoDjoukglXcKKmucoc/4CrstCyC6ljrpqdj6b0a0o8dZsnbm2NN6Gn6w4tvMhnVOhGPPvTOOz/TXbdo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032167; c=relaxed/simple;
	bh=bsk+HLPb0WBt7yT8CNh7XZDVmApbScWBRCm6hs+Hni4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPdW+nkh/+kEBlVpHfIDcdz3BygOl/GG/a7Kli6DKMoWHqCkd4IGcf1O/VeJUXQpvnjHZ7aeAGBTEEtlsOqN2qp7LCwcS3s9lzufuoim+OEvwS3YwhUsfLqRwKNG9skjxgf7gGnn0QyJOvH9AdfPf0e/4yxragpHkuLrZusi1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oMtlIV44; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 72a35e166ea611f08871991801538c65-20250801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GqCgHy0W6OOYmpQtbQsAq1/yyPs/JR4S/EvsXoobYrk=;
	b=oMtlIV44eoBQ52aCZBOqcF0pSjTraFt73/SQT7lHuC8lGAYpqy7wM19z+lqjbjUv08z4bQ4y6/XEndU6vn1EL+5DYF4j42CMX53/29Hbl+Tn8KTGCEHiAjHCz1Sn95aFsvRPL2JyI8nEFmTay3NeSnmH0EE7UzKZPYnPDpQxc20=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:4f823445-208d-468b-aa6e-60a4ff9f3b66,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:6ef37950-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 72a35e166ea611f08871991801538c65-20250801
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1767694331; Fri, 01 Aug 2025 15:09:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 1 Aug 2025 15:09:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 1 Aug 2025 15:09:18 +0800
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
Subject: [PATCH 2/3] soc:mediatek  mt8189: Porting driver for spmi/pwrap
Date: Fri, 1 Aug 2025 14:39:36 +0800
Message-ID: <20250801070913.3109-3-niklaus.liu@mediatek.com>
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

Modify spmi/pwrap driver for mt8189

Signed-off-by: niklaus.liu <niklaus.liu@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 27 +++++++++++++++++++++++++++
 drivers/spmi/spmi-mtk-pmif.c         |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 0bcd85826375..e3e8234e29a0 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1087,6 +1087,17 @@ static const int mt8183_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =			0xC28,
 };
 
+static int mt8189_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3e4,
+	[PWRAP_INT_EN] =		0x450,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8a4,
+	[PWRAP_WACS2_RDATA] =		0x8a8,
+};
+
 static const int mt8195_regs[] = {
 	[PWRAP_INIT_DONE2] =		0x0,
 	[PWRAP_STAUPD_CTRL] =		0x4C,
@@ -1324,6 +1335,7 @@ enum pwrap_type {
 	PWRAP_MT8173,
 	PWRAP_MT8183,
 	PWRAP_MT8186,
+	PWRAP_MT8189,
 	PWRAP_MT8195,
 	PWRAP_MT8365,
 	PWRAP_MT8516,
@@ -1854,6 +1866,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 		break;
 	case PWRAP_MT6873:
 	case PWRAP_MT8183:
+	case PWRAP_MT8189:
 	case PWRAP_MT8195:
 		break;
 	}
@@ -2393,6 +2406,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
 	.init_soc_specific = pwrap_mt8183_init_soc_specific,
 };
 
+static struct pmic_wrapper_type pwrap_mt8189 = {
+	.regs = mt8189_regs,
+	.type = PWRAP_MT8189,
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt8195 = {
 	.regs = mt8195_regs,
 	.type = PWRAP_MT8195,
@@ -2456,6 +2482,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
 	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
 	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
+	{ .compatible = "mediatek,mt8189-pwrap", .data = &pwrap_mt8189 },
 	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
 	{ .compatible = "mediatek,mt8365-pwrap", .data = &pwrap_mt8365 },
 	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 160d36f7d238..00420568afef 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -530,6 +530,9 @@ static const struct of_device_id mtk_spmi_match_table[] = {
 	{
 		.compatible = "mediatek,mt6873-spmi",
 		.data = &mt6873_pmif_arb,
+	}, {
+		.compatible = "mediatek,mt8189-spmi",
+		.data = &mt8195_pmif_arb,
 	}, {
 		.compatible = "mediatek,mt8195-spmi",
 		.data = &mt8195_pmif_arb,
-- 
2.46.0


