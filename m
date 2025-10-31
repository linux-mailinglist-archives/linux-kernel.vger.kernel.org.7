Return-Path: <linux-kernel+bounces-879612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA72C23931
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A309F3AA39B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838332BF47;
	Fri, 31 Oct 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i7w9f9Sl"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6D32D441;
	Fri, 31 Oct 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895979; cv=none; b=XetOKF55YBtJwa0ovtw+4d2GO1U2ozb/7kQJ0GfPL2+DIGKIAHozhCr+XM8OGd0I1OILetDSh8S3QqIDnDRNOC3lD6UYuacrAXjEbNAGTxYOjrU50jtRhzNyYKgTcAF1OYClHaFwZV7PZoRQ1rKboGn8afpiXysg+aMXY11WyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895979; c=relaxed/simple;
	bh=9fmn0UcVtkhZnA/aNwyEVNa9X8AFWMw181/S4ktN0/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mR/M3Ikn8I6UQj6IMOs5d2FRIkBlbadO0oeWbsTEVkZVCMsqPHbHc/+jQoMlqJYGYCd+ALf277EMOJ6D3KJ0jf29kS/kubyQ+EewJb303KsC1aZEUhgPORn6cqTZlB5rosQX7uPoLWWUHpsnqE/Xj+WXCFQrLzUG6eDxWiWjKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i7w9f9Sl; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d0572840b62b11f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7TARVhAK6mVSRJNhSW9K1HBwaZf6qoNRSWMj1Zi8YRc=;
	b=i7w9f9SlL9mXOw5HEcI5J8moBiGJKDDwe5N8wa3n8LK2Tfx2QHJJT8nXrzGgrCNQXX2Rm/4woC/kDenbahCGHUmuzXSS4ywGEpBMnvi6HaSj2xsi9a8KQaYft6spCWk3rw3jZcgtxNhNcMSMR2/AqfprRYw/ylEqdlCPTFq68fM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:80473f92-b0ea-4581-86f5-9c74f318ea9b,IP:0,UR
	L:25,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0a17fbdf-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:2,IP:nil,URL:97|99|83|106|11|1,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0572840b62b11f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1431405726; Fri, 31 Oct 2025 15:32:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 15:32:52 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 15:32:52 +0800
From: Cyril Chao <Cyril.Chao@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Cyril Chao <cyril.chao@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Cyril Chao
	<Cyril.Chao@mediatek.com>
Subject: [PATCH v3 09/10] ASoC: dt-bindings: mediatek,mt8189-nau8825: add mt8189-nau8825 document
Date: Fri, 31 Oct 2025 15:32:03 +0800
Message-ID: <20251031073216.8662-10-Cyril.Chao@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251031073216.8662-1-Cyril.Chao@mediatek.com>
References: <20251031073216.8662-1-Cyril.Chao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add document for mt8189 board with nau8825.

Signed-off-by: Cyril Chao <Cyril.Chao@mediatek.com>
---
 .../sound/mediatek,mt8189-nau8825.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml
new file mode 100644
index 000000000000..dd9ee0a3b292
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8189-nau8825.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8189-nau8825.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT8189 ASoC sound card
+
+maintainers:
+  - Darren Ye <darren.ye@mediatek.com>
+  - Cyril Chao <cyril.chao@mediatek.com>
+
+allOf:
+  - $ref: sound-card-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8189-nau8825
+      - mediatek,mt8189-rt5650
+      - mediatek,mt8189-rt5682s
+      - mediatek,mt8189-rt5682i
+      - mediatek,mt8189-es8326
+
+  mediatek,platform:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of MT8189 ASoC platform.
+
+patternProperties:
+  "^dai-link-[0-9]+$":
+    type: object
+    description:
+      Container for dai-link level properties and CODEC sub-nodes.
+
+    properties:
+      link-name:
+        description:
+          This property corresponds to the name of the BE dai-link to which
+          we are going to update parameters in this node.
+        enum:
+          - TDM_DPTX_BE
+          - I2SOUT0_BE
+          - I2SIN0_BE
+          - I2SOUT1_BE
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        additionalProperties: false
+
+        properties:
+          sound-dai:
+            minItems: 1
+            maxItems: 2
+        required:
+          - sound-dai
+
+      dai-format:
+        description: audio format.
+        enum:
+          - i2s
+          - right_j
+          - left_j
+          - dsp_a
+          - dsp_b
+
+      mediatek,clk-provider:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Indicates dai-link clock master.
+        enum:
+          - cpu
+          - codec
+
+    additionalProperties: false
+
+    required:
+      - link-name
+
+required:
+  - compatible
+  - mediatek,platform
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "mediatek,mt8189-nau8825";
+        model = "mt8189_rt9123_8825";
+        mediatek,platform = <&afe>;
+        dai-link-0 {
+            link-name = "I2SOUT1_BE";
+            dai-format = "i2s";
+            mediatek,clk-provider = "cpu";
+            codec {
+                sound-dai = <&nau8825>;
+            };
+        };
+    };
+
+...
-- 
2.45.2


