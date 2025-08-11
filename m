Return-Path: <linux-kernel+bounces-762422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A92FB20654
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44617175EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF62853F8;
	Mon, 11 Aug 2025 10:47:56 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73428469B;
	Mon, 11 Aug 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909276; cv=none; b=C00OoyDj5ax+gha69ubhySDs7mbu5fqyAQj6BFz6X9TwihP/xzeLDkKbvCw8S+/58he3j9mLoTW1qU/kx/2QmEyuk9hCCFHumi+BNI2Z2ZBALTsi42tmW5Ij6A9F/K3O2zaa6Ok5tKB2S06baAaeWtv0H6YzwA0jEra+66HMo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909276; c=relaxed/simple;
	bh=g8gp8BVLVy9aN3DPQe/yekUQtjP8Mmdd0mEhmUHec7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSxAWp1wsjaewM7W5bOkcLLfQ0AY8PfIYwgw63qyrTPk+CEyec/WxnB86zvnzBVvEqpKLNa9NUKHsUtRVPQ7P3LPLc9zgb1FVOeuoB3GOEslYLwyExm20EX2oedDJbQYSq9G7IOLBCEaeIavV7IW9Lwu3Fv8YXUdRfTdr47LZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz6t1754909178tc3424951
X-QQ-Originating-IP: O367LhMDrA5UUcAaIlTsBzkwR/H64uLueoC6jhekzj8=
Received: from buildhost ( [183.17.229.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 18:46:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16938584829946610355
EX-QQ-RecipientCnt: 14
From: Nick Li <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Date: Mon, 11 Aug 2025 18:46:07 +0800
Message-ID: <350C011186D85903+20250811104610.8993-3-nick.li@foursemi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811104610.8993-1-nick.li@foursemi.com>
References: <20250811104610.8993-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NkNCIKum/oUBq5oCzgce3SemTYwYklz3vIgXXwOmaJQX7hvsdLZwEmKx
	uNursblN079ZFqJp17c7oiBFh278QEIcqblbqRP1C6bb9qlb4KTvpvUr2IC2ne2NHIu7ZIR
	0gmAhDWi/h9VR1K9hbNxSjlQl1iilZhq+oVqDz8dfuqKjc/vq4JqpXsWk+iMF1UqPOMF3Z4
	ZcegDV7ny/JZWvz6h9j0imkOyHVjdrU7rWyHqcReyh5umYXa8RXJHPvfIxXhZMY1XbGVqtu
	gB02bjZzEWAYdFGRBbeaTt6Dyf38/cbwVLVn233jaj/sAM9O2/X5mZGWfK3AW6PCpPyI6Rt
	OEehr1Fd2T5Vb1EzL3avAFzDCq93nR4Qx9cVFv8JnEDMcwiNaYcFmcWDAovc/j8kP1h8khS
	0W9T7Kkp87a+NIDoBuAG3h38lMbvO7qk6QmYnzCVauI6vQoc9VRCNopWU9ZrUnGsK08Wf+v
	nSR65WWh0nH31drFysVwo8NY2DOxdiijjurHhZyXfWUfO2W5fD/kWKw6rd47G/RLLJu6sB3
	cCnI9b8rddSfMf7Lvp/oTDn+ucyDmKl4OFkMTeWaB6wDt4yMVndxmwKnk78GTXeRo3g4CkL
	Ns3Mb5kHa9oZ61wT4uyGnuIrPr2XTVGu/DL3Xm7ZRWhlUttmlzIX55vWKKYcnrl/v0usihd
	Zs/OCwbWhAVhQS6uFGPCuxPF0cTBiBHIwb+gkF2odPchW89zkGBJFLK377Hf2XMzD3Sxgl+
	Dax/M3IgBH3s9Ku4kogMmUgegvCNbvpOv6uZE4UiztWFud4KJnZydMW9vEpnDGvCWrRszfm
	ojEINfNr9VsmRMXTd+ouSycIAAiWUcG1okx1xqFb/rLJUbKvCyVs1DANs6lvneKCBTfOKuW
	171ZpKsm4Ail2OQt5Hj4FkvCSg9NoR8NsF33Zh8R/4PYiNHiU3RTBsgjyPrdMgG2ZOfa4xg
	8D5+tRKD/QHDMqfaEWIKz2hct9KU3ybB27L1Q13NB/nJGq5dkSD9ci01T98/sSW//GbMPYT
	yYreC7SPOWD9DErP63DfytBIWXo3ROUkShIQh21wgGuzNtSJ8v9VE8avmNk9NKdqJ+4apuU
	j1MHP1UtFwhSuc0TZKOq+xssCrvDM/m14Tdxgtp51eROIVqCfLHyOk=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Add a DT schema for describing FourSemi FS2104/5S
audio amplifiers which support both I2S and I2C interface.

Signed-off-by: Nick Li <nick.li@foursemi.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/sound/foursemi,fs2105s.yaml      | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml

diff --git a/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml b/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
new file mode 100644
index 000000000..4da735317
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/foursemi,fs2105s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FourSemi FS2104/5S Digital Audio Amplifier
+
+maintainers:
+  - Nick Li <nick.li@foursemi.com>
+
+description:
+  The FS2104 is a 15W Inductor-Less, Stereo, Closed-Loop,
+  Digital Input Class-D Power Amplifier with Enhanced Signal Processing.
+  The FS2105S is a 30W Inductor-Less, Stereo, Closed-Loop,
+  Digital Input Class-D Power Amplifier with Enhanced Signal Processing.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - foursemi,fs2104
+          - const: foursemi,fs2105s
+      - enum:
+          - foursemi,fs2105s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: The clock of I2S BCLK
+
+  clock-names:
+    items:
+      - const: bclk
+
+  interrupts:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  pvdd-supply:
+    description:
+      Regulator for power supply(PVDD in datasheet).
+
+  dvdd-supply:
+    description:
+      Regulator for digital supply(DVDD in datasheet).
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      It's the SDZ pin in datasheet, the pin is active low,
+      it will power down and reset the chip to shut down state.
+
+  firmware-name:
+    maxItems: 1
+    description: |
+      The firmware(*.bin) contains:
+      a. Register initialization settings
+      b. DSP effect parameters
+      c. Multi-scene sound effect configurations(optional)
+      It's gernerated by FourSemi's tuning tool.
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+  - pvdd-supply
+  - dvdd-supply
+  - reset-gpios
+  - firmware-name
+
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@68 {
+            compatible = "foursemi,fs2105s";
+            reg = <0x68>;
+            clocks = <&clocks 18>;
+            clock-names = "bclk";
+            #sound-dai-cells = <0>;
+            pvdd-supply = <&pvdd_supply>;
+            dvdd-supply = <&dvdd_supply>;
+            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+            firmware-name = "fs2105s-btl-2p0-0s.bin";
+            pinctrl-names = "default";
+            pinctrl-0 = <&fs210x_pins_default>;
+        };
+    };
-- 
2.50.1


