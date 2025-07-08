Return-Path: <linux-kernel+bounces-721471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4DAFC9A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3D55646B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B112DA765;
	Tue,  8 Jul 2025 11:31:22 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525D2153FB;
	Tue,  8 Jul 2025 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974282; cv=none; b=sIWmrYqXhmh47kbTW0a+ujBsLebDq5SwvPHoCelXZ4fPQ78WK3csB7yUfzFymeXHsdxpRsHntxxhmq3G2YRuCGs5Q2ih2shlx8WHFx1H4s29VZoHjoaVuTrRprDrQPDL+tlHvQ0+9rj7x7fv6zq9uNrVOukkAwQ0VbeBBY1OEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974282; c=relaxed/simple;
	bh=/57htY+SatQiOjyX12JUtnuS6FPqG9T4RAEtLXpbYm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ine4tvHz2/QWXw9uZmGqAvKL8oRiiTqVYjSTNL3QQYLDQtmfCZUT3XbRIZKCgC3iiDlZrO2M5PKzrcpcaWijV8KUI7zCenQTV3oX6BXZ562+UbHJuUVuEieZH5Rpz+2eH55vDNHXcGXnUsG8arnuW2YSJMI4hEFI/l/hUjoK/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpgz15t1751974220t283667e3
X-QQ-Originating-IP: vx6Ze9M/XKbWL6qPniUPM3Zmm35mZnAn33ix85wjLYA=
Received: from localhost.localdomain ( [113.89.234.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 19:30:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2191539676694511359
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
Subject: [PATCH v2 2/4] ASoC: dt-bindings: Add schema for FS2104/5S audio amplifiers
Date: Tue,  8 Jul 2025 19:28:59 +0800
Message-Id: <20250708112901.25228-3-nick.li@foursemi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250708112901.25228-1-nick.li@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OCiRMS4r28MyjPeEQ2Kq3lySiocqxQ4lGwSNSMWHIikvgfwJRnGrIHma
	b2wtwu/tKyLTHUyHRQPnh0q87s4tSK723GRUnZ5UBt3qSMUBb4yV1IPz5oeAT0uagFxcSPp
	vAUxJ8S+blt2eTumAf2lcDDHeImivx4AJvAIG65iOyjWN/Ubc0JDn//5v7rc+nbYFd6k1ZE
	Xn/LOopjDF5xl59J95zTx30xGzkPV8wEtjSyxFx2UysJZAk6udK2t+ZgMmvpHpSTuj3RTTE
	yXAeeQQK5kNYZuXxFJ34S+jD8eBXAA0WmSOoYVouOTcjGDEv1b6aRjh53jLmW13Q/0Ho1jP
	RvWNOC7NtO9WJfE8PZk/h4tS9JfCsqqpQYJQiF+0rFXWb2ScRETXaMt9G+lJjZJQClMoNpF
	NK50042tbF2wJ/wQmxWQs6z0AgN7fvsl7iqjNuG7cb8YN58CSQKT7XJzE4Wn1N5+EFvhZ30
	vxC7NDYgg17mCHRH1ESs4qG+VSdzaIEEDsHVYCeA32mKUIB0AmrWS7PCMWt7jfaHDFx4QDF
	nV5W4gbCusVY/Bp66Bcd0ztl33xxyY0TxryxrgOTt11yv9WkH1hg4SDTT8GfUzzXGMGnXEf
	FplH35lfXLpVmve1HfE7YwXfMCSYx+3gKYw0s3aNX3OWrxMsAal2ejac2f5XGY8ysRYYqSd
	OXmm0FSS4J8ixoUw9MXd+X36DGItVt4O2Q7ZkBNI5h9DIfIlMXWnZGIFDX9FE24+l7JoWsl
	rVLbiEjZ5iB4DitA5rbuOkrrbnWmZk4ue5pDhvw72Wzbc1wjp6nQiBM+GuyKhvymEgiSyY+
	BH6VLVj1wqNMcDZl07r+F1Yf0PHQuxlXlO+zolm8dqoNK+Z53nxaB6ilt3BUxDl9OYDd+Vv
	rB0wbk8n5M9LVRDAapwZ9F1Ravd7uvjz/eER9KO2/AL2QoyAskEch4fJNK/qOEN4QcRnNpg
	4Cpdb2gqsMuUvbK+gAulpJ8k1oLRrF4tEft4Nk0ehqMFnqpTJojOupvUTK4qPMnZaxIMxKx
	G+Un0zwSDyLzcXzp8FaWswg3f5yfsbTwHVs8Uo/X8QYxTnP16miI+OXjlkv9n4FmOLx8m6K
	g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add a DT schema for describing FourSemi FS2104/5S
audio amplifiers which support both I2S and I2C interface.

Signed-off-by: Nick Li <nick.li@foursemi.com>
---
 .../bindings/sound/foursemi,fs2105s.yaml      | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml

diff --git a/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml b/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
new file mode 100644
index 000000000..5211f9fe1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
@@ -0,0 +1,100 @@
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
+    description:
+      I2C address of the device. Refer to datasheet for possible values
+
+  clocks:
+    description: The clock of I2S BCLK
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
+  - reset-gpios
+  - firmware-name
+  - '#sound-dai-cells'
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
+            pvdd-supply = <&pvdd_supply>;
+            dvdd-supply = <&dvdd_supply>;
+            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+            firmware-name = "fs2105s-btl-2p0-0s.bin";
+            pinctrl-names = "default";
+            pinctrl-0 = <&fs210x_pins_default>;
+            clocks = <&clocks 18>;
+            clock-names = "bclk";
+            #sound-dai-cells = <0>;
+        };
+    };
-- 
2.17.1


