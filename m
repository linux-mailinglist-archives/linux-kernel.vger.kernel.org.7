Return-Path: <linux-kernel+bounces-884189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F481C2F8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8199A4EE63C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6973019C1;
	Tue,  4 Nov 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MYHs57c6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C5248868
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240394; cv=none; b=f9csyKJRVcpl/yiTd8iYiak9ih02mvpI8tuMzqUUgjRuNxb29gYE0taICCwtX9w/qiGKq+eEWFEflU/jBdmfL5XQpuSGUVd9NyqfalU5CDR6Z8+X1LbrqjAxd1pCkZiVEkbz/dZEUkE+6oSXZJ/56bare4LHQmrAq3ejDiSwq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240394; c=relaxed/simple;
	bh=1TAbvzEfD/RA+9spWTBUiFFmFjivd3g5DCmnmcqcHIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inr2nJa/V5+udCoudIf8Qdh4cFzw5HCAMLeiwzQue5nyWA9khgilfVaAiEaFD9B1U9x7v01HYYnRXUXMSXUN4eyR3f4TJSd11X1bKYNSYPQzcYSyj25q6DscI/bFL0gbRMDz2pqy2Kaf1Y41EB5OeWby8BxYPl/+YyqpaQ/EdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MYHs57c6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b1c2e246b94d11f08ac0a938fc7cd336-20251104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uilWK9pxP4N3+juvbcZo5GClSyfc42uLaTShdPX4r0I=;
	b=MYHs57c6oi+2sujB3vog1XY68lg7caw4Gd/r9jQW3+DciHsTkRBmudvk+VF/i6o20hFpOcPbIad/GsDll8VIaXXnEU1lpv2PZTeniDJb6O7ounOWw4vHNsbN671LfY3omLXQ38zKFJQT3pmc/GMw+zgT1wPV7YJEyioHU7AHysY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:16fdd5a4-285c-4701-a16c-6bd0603c7210,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:93c61be0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b1c2e246b94d11f08ac0a938fc7cd336-20251104
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 9346668; Tue, 04 Nov 2025 15:12:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 4 Nov 2025 15:12:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 4 Nov 2025 15:12:57 +0800
From: niklaus.liu <Niklaus.Liu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <zhigang.qin@mediatek.com>, <sen.chu@mediatek.com>,
	Niklaus Liu <niklaus.liu@mediatek.com>
Subject: [PATCH V3 1/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189
Date: Tue, 4 Nov 2025 15:12:41 +0800
Message-ID: <20251104071252.12539-2-Niklaus.Liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251104071252.12539-1-Niklaus.Liu@mediatek.com>
References: <20251104071252.12539-1-Niklaus.Liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Niklaus Liu <niklaus.liu@mediatek.com>

Enhance the regulator coupler driver to support GPU power control on the
MediaTek MT8189 platform. This update ensures proper coordination of
multiple regulators required for GPU operation,improving power management
and system stability.

Signed-off-by: Niklaus Liu <niklaus.liu@mediatek.com>
---
 drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
index 0b6a2884145e..e2a1fb459e42 100644
--- a/drivers/soc/mediatek/mtk-regulator-coupler.c
+++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
@@ -42,6 +42,18 @@ static int mediatek_regulator_balance_voltage(struct regulator_coupler *coupler,
 	int max_uV = INT_MAX;
 	int ret;
 
+	/*
+	 * When vsram_gpu is enabled or disabled and the use_count of the
+	 * vsram_gpu regulator is zero, the regulator coupler driver will
+	 * execute regulator_do_balance_voltage, which adjusts the vsram_gpu
+	 * voltage to the minimum value. This may result in vsram_gpu being
+	 * lower than vgpu. Therefore, when enabling or disabling vsram_gpu,
+	 * the 8189 temporarily skips the regulator coupler driver's modification
+	 * of the vsram_gpu voltage.
+	 */
+	if (of_machine_is_compatible("mediatek,mt8189") && rdev == mrc->vsram_rdev)
+		return 0;
+
 	/*
 	 * If the target device is on, setting the SRAM voltage directly
 	 * is not supported as it scales through its coupled supply voltage.
@@ -148,6 +160,7 @@ static int mediatek_regulator_coupler_init(void)
 	if (!of_machine_is_compatible("mediatek,mt8183") &&
 	    !of_machine_is_compatible("mediatek,mt8186") &&
 	    !of_machine_is_compatible("mediatek,mt8188") &&
+	    !of_machine_is_compatible("mediatek,mt8189") &&
 	    !of_machine_is_compatible("mediatek,mt8192"))
 		return 0;
 
-- 
2.46.0


