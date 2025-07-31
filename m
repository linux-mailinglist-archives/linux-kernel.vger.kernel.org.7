Return-Path: <linux-kernel+bounces-752355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB3CB17491
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE7189C54A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7755239E8B;
	Thu, 31 Jul 2025 16:02:57 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3ED2236FC;
	Thu, 31 Jul 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977777; cv=none; b=O8eng7ABv6KwsN7xNXNnjTfTUdz+e6zP7YwhKfLzrPdiS2522NBhlRVSTqT1n48ZthL5atI6kEOp+a2rY5smyyJnOix6blF6AwxyVGWuhV2sHulWzxveQPYdkcfPQJiQnaSEOsdCayJMk/Jq/eJyJ/E29l2+k263gDd8vjbwMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977777; c=relaxed/simple;
	bh=ptVqnTy6pJHp4ERvk/kSrG/DnxxRwuC1y9ff9/zGedk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBEgbjHVYgO8vawzYwJE8GZd+pyA3QvVSOyXdku0TZRFc08kN+FkpsI/w3to5LDDLtn7s0bKPRXmsMg4h3FqfHtV8bfu4r+kWiUvLHBJGu+RjooM+zHFPRQLHZ0wy0PccihsZuMayOrCVkplm6O8beRcNEen8/9IVV+NzXKvQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 5BD181C2711;
	Thu, 31 Jul 2025 17:52:52 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id 69EC41C270E;
	Thu, 31 Jul 2025 17:52:51 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:15 +0200
Subject: [PATCH v3 02/16] dt-bindings: display: sprd: use more descriptive
 clock names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-2-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Introduce new clock names that actually describe what the clock input is
used for instead of referring to a specific clock source.

The new clock input names are based on information from clock drivers
such as drivers/clk/sprd/ums512-clk.c. The 128M clock appears to be
CLK_DISPC0_DPI, the clock used for the DPI output from the DPU, while
the 384M clock is CLK_DISPC0, the actual DPU core clock. The DSI
controller's 96M clock is most likely CLK_DSI_APB, the APB clock used
for accessing its control registers.

Since it seems possible to configure different frequencies for these
clocks, the old bindings do not even accurately describe the hardware.
Deprecate the old clock names.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 .../bindings/display/sprd/sprd,sharkl3-dpu.yaml         | 17 +++++++++++------
 .../bindings/display/sprd/sprd,sharkl3-dsi-host.yaml    | 11 ++++++++---
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
index cfa162178fe11df149f2f8dcb03383dafc44868e..7f34652080b22e7b7072a709fd390a72375110ef 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -33,9 +33,14 @@ properties:
     maxItems: 2
 
   clock-names:
-    items:
-      - const: clk_src_128m
-      - const: clk_src_384m
+    oneOf:
+      - deprecated: true
+        items:
+          - const: clk_src_128m
+          - const: clk_src_384m
+      - items:
+          - const: core
+          - const: dpi
 
   power-domains:
     maxItems: 1
@@ -69,10 +74,10 @@ examples:
         compatible = "sprd,sharkl3-dpu";
         reg = <0x63000000 0x1000>;
         interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-        clock-names = "clk_src_128m", "clk_src_384m";
 
-        clocks = <&pll CLK_TWPLL_128M>,
-          <&pll CLK_TWPLL_384M>;
+        clocks = <&pll CLK_TWPLL_384M>,
+                 <&pll CLK_TWPLL_128M>;
+        clock-names = "core", "dpi";
 
         dpu_port: port {
             dpu_out: endpoint {
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index 9177ae6aa7a33f7f797b48cfe06cf8a5391b34a9..71abbc2de8dbb1b674f151a87490c865b187fdd0 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -25,8 +25,12 @@ properties:
     maxItems: 1
 
   clock-names:
-    items:
-      - const: clk_src_96m
+    oneOf:
+      - deprecated: true
+        items:
+          - const: clk_src_96m
+      - items:
+          - const: pclk
 
   power-domains:
     maxItems: 1
@@ -75,8 +79,9 @@ examples:
         reg = <0x63100000 0x1000>;
         interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
           <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-        clock-names = "clk_src_96m";
         clocks = <&pll CLK_TWPLL_96M>;
+        clock-names = "pclk";
+
         ports {
             #address-cells = <1>;
             #size-cells = <0>;

-- 
2.50.0

