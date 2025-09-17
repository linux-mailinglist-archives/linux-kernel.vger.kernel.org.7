Return-Path: <linux-kernel+bounces-820186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E56ACB7E00B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA8C1C01CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5830504F;
	Wed, 17 Sep 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n33H4OIA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0CA29AB13;
	Wed, 17 Sep 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095650; cv=none; b=F9n4pQwMu6HqT1iMCeeqO9N+ZrHhzoTaPjPs0mI3y8zN+Zfb9lVVGubcwyNBM87cW787NLQP8kUwqLq+MPV3mG3VljC8OvPrbhiRNwqVZphL3NGoTmueTcyWingUmOXi3lP6Pf3KN7/oZ/g5OEuB4Qk4WoVUZqjAPblTPZtqTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095650; c=relaxed/simple;
	bh=uR/VCzBgggJ1b5EXwPk6rLimKDxU94OwJl6RwzVEuUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrbfX5ybScozvE0QuZcRMxIMyM6B/FEz8rBmk8XlLqDvCQRW4u9+pwdk/6rt9HawVSv8xuWGHghtb13Ma3H3qzJGzI+EvaqzQY96rKSVfKfa50ErF2h6M2aMP+qInr/YGX1nddXdvz3+/NK3H+7EdwC5Yshv4mKO9wuXwVjDnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n33H4OIA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 79e47880939b11f0b33aeb1e7f16c2b6-20250917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uznzB13p4amR3AHMGxiS0rK/8bL739hCWyhx0iAq2QA=;
	b=n33H4OIAdIJeGke968BUbIcrlttTdjyvJS0YRjgsSBUWKNC1HT8j/FeuImn22wis9L1Rz8YGZZH0ZB8tzZ5DeEN0ncOYJQge9EPG69BQWYY5i4xkvZr82EtGb8cKNKcb5HgmdHTuSCYtdumTsn5YPuSvpLXLrNnD491h2Jgf1rA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:aa1451a8-100d-4503-9cd1-29c7139199be,IP:0,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:1ca6b93,CLOUDID:6e9f69a9-24df-464e-9c88-e53ab7cf7153,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836,TC:-5,Content:0|15|50,
	EDM:-3,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79e47880939b11f0b33aeb1e7f16c2b6-20250917
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 833157554; Wed, 17 Sep 2025 15:54:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 17 Sep 2025 15:54:00 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 17 Sep 2025 15:53:59 +0800
From: hailong.fan <hailong.fan@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sound-open-firmware@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Hailong Fan
	<hailong.fan@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp document
Date: Wed, 17 Sep 2025 15:53:05 +0800
Message-ID: <20250917075336.5985-2-hailong.fan@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250917075336.5985-1-hailong.fan@mediatek.com>
References: <20250917075336.5985-1-hailong.fan@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Hailong Fan <hailong.fan@mediatek.com>

Add device tree binding documentation for the MediaTek
MT8196 DSP. The DSP is used by the Sound Open Firmware
driver node and includes registers, clocks, memory regions,
and a mailbox for DSP communication.

Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
---
 .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
new file mode 100644
index 000000000000..af0f9d71200f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/mediatek,mt8196-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek mt8196 DSP core
+
+maintainers:
+  - Hailong Fan <hailong.fan@mediatek.com>
+
+description: |
+  The MediaTek mt8196 SoC contains a DSP core used for advanced pre-
+  and post-audio processing. This DSP is typically used by the Sound
+  Open Firmware (SOF) driver and requires registers, clocks, memory
+  regions, and a mailbox for communication.
+
+properties:
+  compatible:
+    const: mediatek,mt8196-dsp
+
+  reg:
+    items:
+      - description: DSP configuration registers
+      - description: DSP SRAM
+      - description: DSP secure registers
+      - description: DSP bus registers
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: sram
+      - const: sec
+      - const: bus
+
+  clocks:
+    items:
+      - description: mux for audio dsp clock
+      - description: audio dsp 26M clock source
+      - description: audio dsp PLL clock source
+
+  clock-names:
+    items:
+      - const: audiodsp
+      - const: sys_clk
+      - const: adsppll
+
+  power-domains:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: mailbox for receiving audio DSP requests.
+      - description: mailbox for transmitting requests to audio DSP.
+
+  mbox-names:
+    items:
+      - const: rx
+      - const: tx
+
+  memory-region:
+    items:
+      - description: dma buffer between host and DSP.
+      - description: DSP system memory.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - power-domains
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8196-clk.h>
+    #include <dt-bindings/power/mt8196-power.h>
+    adsp@1a000000 {
+        compatible = "mediatek,mt8196-dsp";
+        reg = <0x1a000000 0x5000>,
+              <0x1a210000 0x80000>,
+              <0x1a345000 0x300>,
+              <0x1a00f000 0x1000>;
+        reg-names = "cfg", "sram", "sec", "bus";
+        clocks = <&cksys_clk CLK_CK_ADSP_SEL>,
+                 <&cksys_clk CLK_CK_TCK_26M_MX9>,
+                 <&cksys_clk CLK_CK_ADSPPLL>;
+        clock-names = "audiodsp",
+                      "sys_clk",
+                      "adsppll";
+        power-domains = <&scpsys MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT>;
+        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+        mbox-names = "rx", "tx";
+    };
-- 
2.45.2


