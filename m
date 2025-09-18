Return-Path: <linux-kernel+bounces-822731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DCB848B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AF61C04764
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894C2C2359;
	Thu, 18 Sep 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NAICAlpk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D861DDC1D;
	Thu, 18 Sep 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197885; cv=none; b=YuYLR2lKTvdKNu3DFsyH9XmRlUpFcu05P+19mcBY4N/etxg+mL0kxf89JNmjv7NkOIBP1u9CF/s4+ri5A0xPKnxWArZ7Htsu30eqjLitj1S9JZMOrj5tXSYKT7CXtr6H0wBMUWJMEs8KvOYbqaHAf+7iaaTuPaFDJF9bR5MBXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197885; c=relaxed/simple;
	bh=dW1YgHL1tGMqek49OPKOTFfXt9sMFljGoccmJHT6f9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asFhwqPwaxuUUWsvEgDn9dUhK4AzcCtNni7HjL+olYrPGUn13wMgTiHfJUSdImIAHAB2ArRfC+pmkiTjzY5Nfy8mimFpWTYs5j2KyTnKsIXZ7PGAyW8IfHsLl1+DK5U2ZrpQD8QbYeFIH+5zvrWuoyebn2o8I9y+eQuKv02c2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NAICAlpk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81a96ae6948911f0b33aeb1e7f16c2b6-20250918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QPPb+919LDTjk4rx5cWwPbu26/1B+8lxfpYUp1Eui3Y=;
	b=NAICAlpkV4DdRQAQb63yGrCuFA0wH4OXbG3fhPvvgHCp/ep3fFyD2pA42KqeJhctdcdDWRqNFvURIQl25tCt/gKZQLsIs9+sK1CjXatmKHQHwsoxEPzMXAzpStsqb9LyiWFEjyTNiDkEot8sUBESJYVCMVuzETWbN/E7fwcTjPA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:21507167-4ba1-4148-8a20-76f9a1a52462,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:bc9a1991-68e1-4022-b848-86f5c49a6751,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81a96ae6948911f0b33aeb1e7f16c2b6-20250918
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 694513379; Thu, 18 Sep 2025 20:17:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 18 Sep 2025 20:17:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 18 Sep 2025 20:17:53 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang
	<sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 3/4] arm64: dts: mediatek: add device-tree for Genio 1200 EVK UFS board
Date: Thu, 18 Sep 2025 20:17:49 +0800
Message-ID: <20250918121751.229554-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918121751.229554-1-macpaul.lin@mediatek.com>
References: <20250918121751.229554-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add a basic device-tree (mt8395-genio-1200-evk-ufs.dts) in order to be able
to use UFS storage as the main storage on Genio 1200 EVK board.

This board is the origin Genio 1200 EVK already mounted two main storages,
one is eMMC, and the other is UFS. The system automatically prioritizes
between eMMC and UFS via BROM detection, so user could not use both storage
types simultaneously. As a result, mt8395-evk-ufs must be treated as a
separate board.

It use mt8395-genio-common.dtsi file to use common definitions.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8395-genio-1200-evk-ufs.dts    | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dts

Changes for v2:
 - Move root node at the beginning of the dts file according to review
   suggestion. Thanks.

Changes for v3:
 - No change.

Changes for v4:
 - No change. Add Reviewed-by tag. Thanks!

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a4df4c21399e..86d568d57549 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk-ufs.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dts
new file mode 100644
index 000000000000..e09a3ecd8773
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Ramax Lo <ramax.lo@mediatek.com>
+ *         Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+/dts-v1/;
+
+#include "mt8395-genio-common.dtsi"
+
+/ {
+	model = "MediaTek Genio 1200 EVK-P1V2-UFS";
+	compatible = "mediatek,mt8395-evk-ufs", "mediatek,mt8395",
+		     "mediatek,mt8195";
+};
+
+&ufshci {
+	status = "okay";
+	vcc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vccq2-supply = <&mt6359_vufs_ldo_reg>;
+};
+
+&ufsphy {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "disabled";
+};
-- 
2.45.2


