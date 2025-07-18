Return-Path: <linux-kernel+bounces-736845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D7B0A3EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EF1A809A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D842D9EC9;
	Fri, 18 Jul 2025 12:13:37 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B952D97A6;
	Fri, 18 Jul 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840817; cv=none; b=JciF3mc5ClMbX1IvyH55+YARXA/6PsWW8FHpHCufs7LzxfFv7r1py7qxRk6wVSCWNRX44mJkPm15alQAkPknkoF9o9KgGSjolin7cdAETqNRWKRTcu7NohxKk7PG8tHMkdqSUHpHtkTqvYaIHUYirm7t8vof5+EPcFhqLtZriNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840817; c=relaxed/simple;
	bh=6P7takzY4Q8f6ReFyjrw1HfpKgMBdtdrtHw8aaqhOnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJn2xHpetmiN1uDVyqbs9uO3wahWSOhPoFaJ4aqxCxAPVR0YeaLUgIitBVSRpttMwPd6pFgm7/BNn2+achqhujaQz3VUXeumQoxQCN9bvBAr9A0kNpRX5+lriabz5E2iZUSMZ/Xdg/kUIVDzdRxwShw1n0u1lU6idaxCAhSQiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpsz21t1752840751t6cb0562e
X-QQ-Originating-IP: 9dRlpqgRyURRDy4xBiYoj8Gt3pAHaU0fiVdyqOcxXOA=
Received: from localhost.localdomain ( [113.89.232.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 20:12:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2754424817838708234
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
Subject: [PATCH v3 2/4] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Date: Fri, 18 Jul 2025 20:12:19 +0800
Message-Id: <20250718121221.76957-3-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718121221.76957-1-nick.li@foursemi.com>
References: <20250718121221.76957-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N+fE1vV13phxrCGOlXvji/aOxGzgCzxl0lydCNFyUo9FQbASuubjjUKI
	w1frHfj8rlTU7meq9z7H2ReaxHoux/4NpGtcIUHN264emmHrNvR0XHuQ/OmlZsEm4XhqX5q
	t9g6iVEDKF9STjdzJ3Wyv0aeDo/4siWXK3B//in/3kbeb4uGxLmR4++qSKYpkKerelm/e/c
	XjmKUcFSSyZfywPvia/V7ojwi0uTMZdKqAQGf2pLnN4CULiU9vgJV+mX7Yd7LrK7pAoZLgp
	g67XoBoxmQ+xG4a/Sp/FQ8slF6TpPzfK4DaagU7AHmST0LI6UaIURvyRGWc/IUSauyNRF2U
	jLHB4qyb+FnjWI8Ae127sJ4amHOCt0PX706R5xK1nI1SFuAZoL6ds505OVwT/GojH3k6Pg3
	P1DLF0j7GF6d5KpS09Ltz+sX/zso4EEhuuO8z+dsOJJ1F53AQoLiU5f+GpPt5xJYG3vHIoO
	6+LEIVMpZNWWF3H9jaAFnW5UV0OoaRuxmKIWZ11IoPs9AOPJlqj0AL2pgDULr1ctZw8keiN
	wMGhLzI6l5pORCiTlbk+3gNzGYGiJsjTrLAUtWlMDEz0v+T2GtT1ZwMfVHXEr0IHYznfwfZ
	Xe9jma/wGVPWATeKhOePgTzE1GJTPDYFO7JkNnxc6kvzNp2maZHCeMjwT//b+trjhNhcCCj
	dI11QP/C9El5zfoI/Q60MqyF1HDhkekOWBXHIPB1hYqEHBMmbHCy/0ly9hzOhCsW2iVRPak
	SS/h2UIzjGdHsUEMJAywttgv5mc0Q9Fs5IBPHv6zW+NY17MHnJYj99r8f0LoFozoNznab6p
	tzCIec/rE7z+J2zc6/UAIX8yJ9V4tFa0XtAATQtLU5kyoIIO56ahd/XhAMmXuETZJ02VsMY
	8jgji7GQ5/Ht7Wj72veMOIUbjq2CxB6FDspQ4XWTRpAEBcSoRjikGVHN0OmAhnzAX3EBwks
	TCQnh0QQxLxNoukzM5wjfO/MK+qk7cMTzDPilH3LyY8PWXP+Nko0kadBIooW1vfCsAURXBI
	4EcX3gQoDXoMlmIdlVcNA8hgRuOj6l2lQSR9YNDrw6IGkm6T84BGhqw93IJ9y/7HTmuEev6
	aGB1ZDwES8zVHvkS3BMpXUo9X0YGbJK9M38vTiUXBMfhaTFtLsDjaIEhG3d0WnWxg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: Nick Li <nick.li@foursemi.com>

Add a DT schema for describing FourSemi FS2104/5S
audio amplifiers which support both I2S and I2C interface.

Signed-off-by: Nick Li <nick.li@foursemi.com>
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


