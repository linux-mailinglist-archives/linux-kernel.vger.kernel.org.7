Return-Path: <linux-kernel+bounces-770467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B72B27B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3D41896D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4F253358;
	Fri, 15 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CETaJ7Xc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD322330F;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247061; cv=none; b=TcH2aMhzrb/odx6vIIcNHoghFuklDZRBQ4tEZQUctxx0xXjY3icIoTexqgbQGgoEU4rCYj0pAh/BzTGm55xqask3KLhUpLgyWlQwpSeiYFI8oMGDdAQEz5pfV35m38OKBxdswgmX6JYhV55iRsswZb7t+y6EzD6QPR1czE50qGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247061; c=relaxed/simple;
	bh=+LdxacDOKbwv5ZlhXWTL9PeHEmVA5121O21NQzi8U8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+bFS6aOWWUXjjSnYakFD/3AQIInZqARTN9bEKGQRz1JIQZDHCJk10KgHbWE7jaJIIYTYw1ImGgM3Dhezb9Ic5cBQhMT/h3820z3TpTqupiWpBRhiXtv75BhTqyawTgYJnvHXn/EEwqBlIOe0eyOwsvjEHiAyKtmL7uC8XKBVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CETaJ7Xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FFD8C4CEF5;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=+LdxacDOKbwv5ZlhXWTL9PeHEmVA5121O21NQzi8U8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CETaJ7XcfZrZwAHeVDADXVmrjA8oZuhJhdw49Amn9mXn/+HqvQemXaJySdaPJ+y6I
	 3Ng2QayQJHuyrU7qZRhHvw9kc5Q+Ra6kGZ/Ketj3xz0PnvR63uIJIiEjVVMtiQrR9E
	 uQCVXSQPmoQ+Rx8fEejbfz+voOaAuwsAO/uMws4mApgjHJiBt6ntD23KPSi3kVWAi4
	 AvDmBDxpxPm7Lv1nZ4a4UDpJEYhfGhXFDSQwJ7qsDwn1pYkzrMWkxcYTSnfaxvE90a
	 OE3A3seWMJBtsoefnQksp+Ff+TZnCkbnysr4fhLmc0uoGVbT8eQDuJYgffVVcu3Kt0
	 vvgut4MG5SfpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A55BCA0ED1;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:27 +0800
Subject: [PATCH 01/13] dt-bindings: soc: amlogic: Add clk-measure related
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-1-59f04ba67457@amlogic.com>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247056; l=2924;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=WKCqPVvjKvBXZpMp6AHTLsZhyPJ7w7tYipQPXxNUfy8=;
 b=Q41qJt636clPDrUBiobgwPQhIgCCdN9zC7cR3+DvjHw/DkHPHACtzt579HcHsSbegx+EGYnso
 SAP1K0IrAffB30vT6+ZbJysS3mjFwAyqBwtGnT6NcX2J7u/OIiLPKsZ
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add three properties to clk-measure: 'clkmsr-indices', 'clkmsr-names',
and 'clkmsr-reg-v2' for describing measurable channels and register
offsets in DT.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  | 54 +++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
index 39d4637c2d08..1c9d37eef5f0 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
@@ -6,7 +6,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Internal Clock Measurer
 
-description:
+description: |
   The Amlogic SoCs contains an IP to measure the internal clocks.
   The precision is multiple of MHz, useful to debug the clock states.
 
@@ -28,15 +28,67 @@ properties:
   reg:
     maxItems: 1
 
+  clkmsr-indices:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Supported channel IDs for clk-measure.
+    minItems: 1
+    maxItems: 256
+
+  clkmsr-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      The channel ID names supported by clk-measure correspond one-to-one with
+      the IDs specified in 'clkmsr-indices'.
+
+      Therefore, the defined 'clkmsr-indices' and 'clkmsr-names' must have
+      matching counts and maintain strict correspondence.
+    minItems: 1
+    maxItems: 256
+
+  clkmsr-reg-v2:
+    type: boolean
+    description: |
+      Specify whether the register address offset for clk-measure corresponds
+      to version V2.
+
 required:
   - compatible
   - reg
+  - clkmsr-indices
+  - clkmsr-names
 
 unevaluatedProperties: false
 
 examples:
   - |
+    /*
+     * Example 1: clk-measure uses the original version of register address
+     * offsets.
+     */
     clock-measure@8758 {
         compatible = "amlogic,meson-gx-clk-measure";
         reg = <0x8758 0x10>;
+        clkmsr-indices = <0>,
+                         <1>,
+                         <2>;
+        clkmsr-names = "ring_osc_out_ee0",
+                       "ring_osc_out_ee1",
+                       "ring_osc_out_ee2";
+    };
+
+  - |
+    /*
+     * Example 2: clk-measure uses V2 version register address offsets.
+     */
+    clock-measure@48000 {
+        compatible = "amlogic,c3-clk-measure";
+        reg = <0x48000 0x1c>;
+        clkmsr-reg-v2;
+        clkmsr-indices = <0>,
+                         <1>,
+                         <2>;
+        clkmsr-names = "sys_clk",
+                       "axi_clk",
+                       "rtc_clk";
     };

-- 
2.42.0



