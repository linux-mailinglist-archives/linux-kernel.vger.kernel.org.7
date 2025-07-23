Return-Path: <linux-kernel+bounces-742162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F917B0EE22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA5E1897D89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176D288524;
	Wed, 23 Jul 2025 09:10:38 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6B283FE7;
	Wed, 23 Jul 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261837; cv=none; b=ftQSMDnBfuh4xSt2d4tiM+C5wU7mgpzsf7rw1bZDIlq0MDI11fRLq4FXTSxLsc5zcISGWoRz6ojE0ftWMES5wpVddIk7FR3BbWJKlzBViaZ7ox8hFIjhs5+MlzpbP9WXtsJQFtwKO8ugNTaO60D87BRd626/Ajrn14DLrleHIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261837; c=relaxed/simple;
	bh=u8DjUTY+X3pAn4e5Xzdze6tG6ay2FnfhL5m3eTIlBpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bes+xrJbd8pt8gOBFbCrf//Jxs1a6xSZZqX+iV3JgBSVZjy9x6I27NtNUNmGt2BJo0efD85FPSt4HNU4IsmpeA2razWV1nOdb3kNvdPjHKWP6oTL017F2bnqmiovsXsddxJ59B0Z+oVKqByBb8h11dQD0FMo+sWDOxbg6cSSDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz5t1753261784t671181c4
X-QQ-Originating-IP: jRrvKDkbdkjtDRgmBTHKi4qQYs0nhyQxif1XjsVZUBk=
Received: from localhost.localdomain ( [183.17.231.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 17:09:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17466599980844399083
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
Subject: [PATCH v5 2/5] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Date: Wed, 23 Jul 2025 17:09:31 +0800
Message-Id: <20250723090934.480055-3-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723090934.480055-1-nick.li@foursemi.com>
References: <20250723090934.480055-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MsVdersypWT2si12ViHs14JhS0Z9siKQEgjzgyHHc4Dh8R/47PQArE14
	Z4r4Kx7DvzAf4nxxLBN2Qm4jPzDxiqqqhkHfgC+jTA502chV0JbgCiUkRlEtAKFttODZDJZ
	Gbn3mffIDw4ZzolIxm2I80g3noVO7S2BcdHGnRtmh9gviS5KSejqzpt/YU+W1Yi3lllKK6C
	4tS6kKIYBCCmE1ApSZBt4mh7cKzSl9quj+4r1MY5MT52qheMQkECGQ+Fbh70Kxo6t1HVqzp
	5X5FP7/C4al5+e9uwMekUNdVuYass8SD9vVNfvBKP5f3qZViXqo7JtXa8snpz/nVQROjUQv
	6r7JPoJb5c8CL9EpQKKpMLubo6Rp+cEhdMG7KNvSfB27u4NqMsi2Y1vmxxa0+V+REWKoTp/
	ZGiCrQ951kzguCpiq3ahjwr9kD0fuwDftukKnMq4XZh/IJyw5M9akoaejPcNgeYkf+GD7Hp
	FnDDA/Mdsx/TnTG7+BSNBF/PZDnTDUGULlFTtUbcSMuh5k8EnJwZwQzb4EsDyCYkXhu84Lg
	5YON3GGpMKA9zLxzhEwf5oslO2ZfPg0rXdldYT2zyeKJW2ryJjVWLoGonW9uW3p3l5ytNw0
	LBIPOJueTzMRSwcu9XFebw4tKBEO8G4SpJLpK8boLeP3ddY+ydxyrbOejp8Cm0InaqEB1bI
	hXC1a0chn2szx9xfBTAFUKV4uaxv807Z8qRacUOqn2KRUkaiJj1zIq6MxnEZQJLg8WW/Ckg
	Mv2ymsNyFndQ/Nlh8aSeOxqarYlRW2dTEaOIn7R19+OAX7LBAlknaobcphHQ0XbKCfR51qL
	bdoOyGaU56ftnrlIIoLr3/ay5DSiqR57j5sgJlk4Jlg5/LvyI12K/UvDTn5K1LoaH6WzcTb
	1X9oP1kyKzw7R8wGG17cy7B99UYg3PvtyukVkSg36PK3+gk5WwzhdA7aOLrDdhYyEO1NMpY
	W0CHdksaoXjqlA7va1Ohx2KZTIKP9QSfKWhSOl7/NKOFajHWM25I5Py7LBL8Rl9isesLaRA
	u4FfWI3BafS9d85W1d64AILweJ3URZ2ghoa6w6vJHai+ZsWIeaZlApCRvEBRqbupHPvpen2
	4oexSpJRgccMiPh6ib77fbLf3ovjy1w5Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: Nick Li <nick.li@foursemi.com>

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
2.39.5


