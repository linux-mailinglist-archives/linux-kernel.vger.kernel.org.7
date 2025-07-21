Return-Path: <linux-kernel+bounces-739075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00008B0C176
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6DC7A9E58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570B291C0F;
	Mon, 21 Jul 2025 10:40:09 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE7290DB5;
	Mon, 21 Jul 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094409; cv=none; b=FE3g/QcrzusS3L4DmiX84YgmCvuvnG0Sm98w2MIVO/G43gUaPWaeJHiDYj49CHN4bpgp+aE+m5KyF8jkF/3BjTkptHZ2/S/ZIvLRcecy11hCkFQHLlxWrVLRx/xs8acg4wuytGy9miSeS7L49JBn4tAge/h+ekXtcoK+KJvkDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094409; c=relaxed/simple;
	bh=SVMUPAflKbju+T0fh97IW9wXCWK+eHHEA49dfLK2+Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyAodVVZCtMIP5PnBKTNUFfGoDJayRZujOSXTmcTw90qeDKOq4lmtPcUEBXePvgoEKIvjfEQjLR974kjXk/1mfK9r63njCcc7zZRnnHc2kJO0D0poXIJX45FZ29/fjiR0J5VwtMCzDFeylueKLFAAu+86iZMN7tpPm0wMyPlSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpgz7t1753094354t9a9ed827
X-QQ-Originating-IP: LZNI764mN6AxCPBLD+WN8+F0FR9mszdTAD3KSXNpZxY=
Received: from localhost.localdomain ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 18:39:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1671705023845774465
EX-QQ-RecipientCnt: 14
From: Nick <nick.li@foursemi.com>
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
Subject: [PATCH v4 2/4] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Date: Mon, 21 Jul 2025 18:38:03 +0800
Message-Id: <20250721103805.531758-3-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721103805.531758-1-nick.li@foursemi.com>
References: <20250721103805.531758-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MIYVF5Pddf3wP4II19XBepOSpWLogGcRWRiZtpfBrJLsgDGpZpic0n66
	Ikb1Wc/s+74X3+nJ/kv/1lkj7EGK5Vlcc83X55toMFgkrnDQpwlitpnPCVPFlwGO9EMVTpf
	mrN3NWtbx+brX+7wLffVWxb+ELCaCWcbjSqV/bCcdlBcfjWxgxxHxg/gEOE4E68xXNUYsl7
	rK/Kj3EqFcQyUQyUrNjMdMtkbDHjuK3iy+0I4G7zYAf/Yw+rnjR2Z7ziwhhYm6j69ToZUHI
	K/SMKLq4bQL712fUxkqnUCDhfL1mTXM86lXltgO0R8eYwA3g7KKeNyBoWOM+lTuk91fwF0Q
	mHukWpaKTCOXnSP60DQR3+5vlQcJ6bmYdJ5VyD7aPLd+qdrmHxkgmnIJ1ir2ZfvEOVrjB9C
	arYmuqSXEWmzBN2im3SQmPzHjDNQxt/AM8LmGBrFPcvNNgNq22n4cekWMS91/o/uoT17Kn/
	LLPbYz2z6x8DXl0JSSyeMwiCkTEfNsxVeCRSm+JsaAzgD71kiM5Z5ZSq0Qzlrt/UTrISybi
	Y/kqvcWt1X9cjNwFNYkT+UOGWgiyIffqXHpdAXECV3FDe2ISnIAhqD1P8/lIHf8X63YAESQ
	1j+abN2sImsMd2krp+8XR8Gn0AZyRgwUbovSCIsnYonW1x4TS9JcFMWR1p7n9YZvaIKMa0W
	n0YRHHlcjMIQgqXJ1LKdCR9iFSBZgY9oNmMpAQMWzdCp79Urc193JI+t1xN8GIzAeg7BcyV
	5cw1MQJmf4PXbC5vky8zxn3bbP+OapMyq8ejXkE3aesyWAwJ1RUIzOUWhFP9Gf8b4L3jajz
	8FX9umD4CSkDOi+di8M/GlOQZ8wqsKi316icX1bWApIqc4sVMJ1nOi7UgiDbzNP22FEi/ww
	935xssMUGTDgsS6VVyDM/aRYucUnUYDzkq45xC9Q9dP2ubfsX1Evyaq/hkoiZNYjxwmKOcH
	Y/O1WJDUG5dvGFXxkZL1FgfTHUgYf6zck4kbF6TZc5ZN3zVyHxhFP6K1gIwuOPm3SIk/42K
	5pwxCcbiTNf70RYFLF9ib8NI0e2eEnZw8byMauer5K59mHib/MOg2Lh6xgZWJztQwEu93GO
	qE1ttDFPrRM
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: Nick Li <nick.li@foursemi.com>

Add a DT schema for describing FourSemi FS2104/5S
audio amplifiers which support both I2S and I2C interface.

Signed-off-by: Nick Li <nick.li@foursemi.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/sound/foursemi,fs2105s.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml

diff --git a/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml b/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
new file mode 100644
index 000000000..7391c404a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
@@ -0,0 +1,99 @@
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
2.39.5


