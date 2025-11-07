Return-Path: <linux-kernel+bounces-890979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D40C41827
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B4189C5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10FA309EF4;
	Fri,  7 Nov 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="NyIEhXoc"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63C302CB2;
	Fri,  7 Nov 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546025; cv=none; b=ALZE2r5v2hbNeHuHYytlCOEh+G32FnT8n9OKFcmnYuSf1ras0GqCqy6WtBXageTvfmcNVzI0MPIzo1XRSI2Ydo6Y4ZslxLPCDCX41UHG3J49vbHa9QzCBTtPcLiSi9jIV+uXYT0D9nBgiw1MNfRNvEZYphHj54Z41dfdpodNibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546025; c=relaxed/simple;
	bh=AlyAos5lAGXVNjR2bMAh2pv4DcOio8Uo9RCDmeLoeq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XodBWxm01aaaTZvn6s/8yJ0BJd9tWp7/GDuXu1jNaZqGQZs7rlz2OQyglt2N/XuGKB2Hm87lfAB/IS6cLOc3zGoxI8PY51ulwP5VDJxlb11CCIg5yZ2jby9zsYDPmQjPiQX0+vV1f9qx34zDTirdSL0hQR2zMc49N/xC5k1aDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=NyIEhXoc; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VxdgB3HocQdpr4EL2JWSmprEcBe6YuGBAKZnIFLa3JY=; b=NyIEhXocz2ovspKIq5RVBW3KBy
	dQF0uDeOqfv0wn+sqbLmAeSi26535o5Rszo8hcFezSaEgLhW4cWxAEzkTYqBRxsj1XJlLjN/5p9qA
	tYaIk4SVIRaq4rFQp0C2rrAnyFjdIxv1ycd6TK/MaFpGGTn2v3PTlz3g8+oTp/LAJFExwbHC7q73N
	oZHkOZkar9GIF11QV2mrqynY5gfs2sRpp6cqofRVk3bizkL9HEs2P9ZcsJm7oy+6jHm1vPNz1hMiN
	SMBv/cZ8H5TjHPv/T9frhKz8dGfb/Si7u1apR8MQZGepfPSmU0hXOdb7GVicp6WRhiyatF13L5LSW
	7NRC/OkQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Fri, 07 Nov 2025 21:06:45 +0100
Subject: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
In-Reply-To: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4044; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=AlyAos5lAGXVNjR2bMAh2pv4DcOio8Uo9RCDmeLoeq4=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJl8gbHrbIRk1O43bDtQ47jHWiiK1fz4visv1aY1NOptW
 DCpwupIRykLgxgXg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABMp4WP4Z/nml3nZbu3Nnz6+
 erb2Ya7ZrO6HGdercrxnv0qOUV3jJczwv3rWQVnzJsWW0KKkf80huyols/a5Vj+TShIy+3TLr5m
 DBwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Document the FP9931/JD9930. As the FP9931 is a clear subset of the JD9930,
define it as a fallback compatible. GPIO names are same as in the datasheet
except for the EN pad which is described as "enable".

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/regulator/fiti,fp9931.yaml | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fiti,fp9931.yaml b/Documentation/devicetree/bindings/regulator/fiti,fp9931.yaml
new file mode 100644
index 000000000000..ce44040a3c02
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/fiti,fp9931.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/fiti,fp9931.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FitiPower FP9931/JD9930 Power Management Integrated Circuit
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description:
+  FP9931 is a Power Management IC to provide Power for EPDs with one 3.3V
+  switch, 2 symmetric LDOs behind 2 DC/DC converters, and one unsymmetric
+  regulator for a compensation voltage.
+  JD9930 has in addition some kind of night mode.
+
+properties:
+  compatible:
+    oneOf:
+      - const: fiti,fp9931
+
+      - items:
+          - const: fiti,jd9930
+          - const: fiti,fp9931
+
+  reg:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  enable-gpios:
+    maxItems: 1
+
+  pg-gpios:
+    maxItems: 1
+
+  ts-en-gpios:
+    maxItems: 1
+
+  xon-gpios:
+    maxItems: 1
+
+  vin-supply:
+    description:
+      Supply for the whole chip. Some vendor kernels and devicetrees
+      declare this as a non-existing GPIO named "pwrall".
+
+  fiti,tdly:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Power up soft start delay settings tDLY1-4 bitfields in the
+      POWERON_DELAY register
+
+    minItems: 4
+    maxItems: 4
+
+  VCOM:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      The regulator for the compenstation voltage.
+    properties:
+      regulator-name:
+        const: VCOM
+
+  VPOSNEG:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      The pair of symmetric LDOs
+    properties:
+      regulator-name:
+        const: VPOSNEG
+
+  V3P3:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      The pair of symmetric LDOs
+    properties:
+      regulator-name:
+        const: V3P3
+
+required:
+  - compatible
+  - reg
+  - '#thermal-sensor-cells'
+  - pg-gpios
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fp9931: pmic@18 {
+          compatible = "fiti,fp9931";
+          reg = <0x18>;
+          pinctrl-names = "default";
+          pinctrl-0 = <&pinctrl_fp9931_gpio>;
+          #thermal-sensor-cells = <0>;
+          vin-supply = <&epd_pmic_supply>;
+          pg-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+          ts-en-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+          enable-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+          fiti,tdly = <2 2 3 3>;
+
+          vcom_reg: VCOM {
+            regulator-name = "VCOM";
+            regulator-min-microvolt = <2352840>;
+            regulator-max-microvolt = <2352840>;
+          };
+
+          vposneg_reg: VPOSNEG {
+            regulator-name = "VPOSNEG";
+            regulator-min-microvolt = <15060000>;
+            regulator-max-microvolt = <15060000>;
+          };
+
+          v3p3_reg: V3P3 {
+            regulator-name = "V3P3";
+          };
+        };
+    };

-- 
2.47.3


