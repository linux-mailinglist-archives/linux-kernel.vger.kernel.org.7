Return-Path: <linux-kernel+bounces-746997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA59B12E12
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E4E3AF4CB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C21F0E58;
	Sun, 27 Jul 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WvoWDHXi"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355201E3DF2;
	Sun, 27 Jul 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753600636; cv=none; b=Q1ILiwhkpxj171rE6feQOLebCYOU/md11l4+qIiOR7uAYTL1blQrH5DN1RO3uBFBGCbC56sgRzzqPw6FCojbk4Hw0dYH+ZmftYQTFsJ590dTfIKnVxHzs8kNbprTHjjrS5VAGvO989nUTMIrzb350tTs8eoogaaNaSk75CjtbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753600636; c=relaxed/simple;
	bh=rHp6wo/jHroUiSpBc+4kmaDogRUUMOg2V3Lozu3DHcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpjJkcvva8vOYZwMEgqQ/AiHNWCQsWfcSSVa0TUN0MlZN0QRYGI1J0v4L/OO40+10bYocqoB971nFc55qh/rSGWR4imSdP/ccv0ld0AbRUy16x2lS8AmMSky3ptivQlVeeUV5rVFgaL1/Pdu0h67YkKyIznRcFvEmnH9MLqAn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WvoWDHXi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b16b7c326ab911f08b7dc59d57013e23-20250727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZZLcYegyaHbf8qxTlw980aj5MvkdsQQ3wp27pJbfu6Y=;
	b=WvoWDHXiw4ZNb9jc0b6dVrQYo3eBxI0VX2X589+B+phu3K6AbXpJzVQrPyf7PzffO1xAtL0Xog9FX7WMlmc9ueVVTZhvyURdUe6hhCuRvtT/XOvMEIJRvR7IkNiH/wsko07oDVqF5g9Gkv4Wwt8tIxphLyvpNN4DgAOCOVqUYJw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:46e12f18-6940-4dad-9326-ac945674ecb7,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:f95dd208-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b16b7c326ab911f08b7dc59d57013e23-20250727
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1909679680; Sun, 27 Jul 2025 15:17:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 27 Jul 2025 15:16:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 27 Jul 2025 15:16:58 +0800
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
Subject: [PATCH v2 4/7] dt-bindings: display: mediatek: disp-tdshp: Add support for MT8196
Date: Sun, 27 Jul 2025 15:15:54 +0800
Message-ID: <20250727071609.26037-5-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250727071609.26037-1-jay.liu@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add disp-tdshp hardware description for MediaTek MT8196 SoC

Signed-off-by: Jay Liu <jay.liu@mediatek.com>
Signed-off-by: 20220315152503 created <jay.liu@mediatek.com>
---
 .../display/mediatek/mediatek,disp-tdshp.yaml | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml
new file mode 100644
index 000000000000..3d95ecfc0d19
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,disp-tdshp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek display 2D sharpness processor
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description: |
+  MediaTek display 2D sharpness processor, namely TDSHP, provides a
+  operation used to adjust sharpness in display system.
+  TDSHP device node must be siblings to the central MMSYS_CONFIG node.
+  For a description of the MMSYS_CONFIG binding, see
+  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+  for details.
+
+properties:
+  compatible:
+      - enum:
+          - mediatek,mt8196-disp-tdshp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        disp-tdshp@321e0000 {
+            compatible = "mediatek,mt8196-disp-tdshp";
+            reg = <0 0x321e0000 0 0x1000>;
+            clocks = <&dispsys_config_clk 107>;
+        };
+    };
-- 
2.46.0


