Return-Path: <linux-kernel+bounces-724846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D28AFF796
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CCF3B2125
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787B28469D;
	Thu, 10 Jul 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkrnOAxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F600748F;
	Thu, 10 Jul 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118572; cv=none; b=B0Z4TDZkDJEAVbqwSCpm7U8PhX/BpAfqrsJXxMhruoPsyDcTgfwwoqPURDePchDub0DL9HSwU+NSt4X9JHPjq4R6Xksf7zp6bpRZxZMc4S2dMdBbqkl7h5RnPgDM/KXqW2fx/Ru0V2ShLGkIc5DuZwVizk5OkVgHFmxR5V+1CME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118572; c=relaxed/simple;
	bh=//XINryxTmCrNyFb/Ct61hIPybf0yNjBvdelFx7bQ14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBJP+5Nnl6/d9Zs9kjrZO+4VvSVCkByxEp9WWw4msQHRO/YgGDUH5QF7eE30A2PWGXl3w2FNCZVyUyLf1nZmB7coio06FFHvpQHY5FXV/gzGq/fIIalI/2TX4+AQf5JQXFy3h2gQyZBh7VxkGg/O2H/K5B1HCwKEF+JXNohwNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkrnOAxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB9B4C4CEF5;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752118571;
	bh=//XINryxTmCrNyFb/Ct61hIPybf0yNjBvdelFx7bQ14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kkrnOAxXTMSlLFNg6v0c+xTV5qRyIWAEA9MGwPRXxA7ryjseHdNkQ00odvaGGcJoV
	 /oXAYn1FXDUTaLMa3rgqUokmYfVuWCYaoiu4k6jKMIcKLRRJRZge6Z/8Chi1ImrPqI
	 Lw7XcWMHpDZ7W2BpPjXfqMLv/KbcoM488eMPzDF2syhj7A7kp4JK+1bIte+j8b8h8D
	 rsswUExVHhJlAnhQelcqbzoWtq6WvuAjOXaPmydybBLJC8byFze0UKwtw0vlZ+MXd/
	 PpKUXOCYzLqMIM9XGo2n24fgxqHo0YXT491zH6/8z2Nlzk8s3/i3hB5hmYZclSpnPs
	 d/o1aFdC5jxdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D2C83030;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Thu, 10 Jul 2025 11:35:37 +0800
Subject: [PATCH v5 1/6] dt-bindings: clock: meson: Add audio power domain
 for s4 soc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-audio_drvier-v5-1-d4155f1e7464@amlogic.com>
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
In-Reply-To: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752118569; l=3341;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=yhsDXY7MMuP9ySNiIHj39Bbbf6ifv82AD9aG95a7FPY=;
 b=HRzZrpgSyMnpl/g7RHqIYGPk+EWvIzv1UFfvZEX3wevTxrCDzEyWmeD2hjyeoTXBQkF3x/u9Z
 HDXGEqCWaujBJZeKMnPNwhyn0alcJBgFA9a3avMZjC+jNYSXuybdFDI
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

The audio power domain has been detected on S4 device.
It must be enabled prior to audio operations.

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.yaml     | 55 +++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
index fd7982dd4ceab82389167079c2258a9acff51a76..c3f0bb9b2ff050394828ba339a7be0c9c48e9a76 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
@@ -21,6 +21,8 @@ properties:
       - amlogic,axg-audio-clkc
       - amlogic,g12a-audio-clkc
       - amlogic,sm1-audio-clkc
+      - amlogic,s4-audio-clkc
+      - amlogic,clock-pads-clkc
 
   '#clock-cells':
     const: 1
@@ -100,13 +102,15 @@ properties:
   resets:
     description: internal reset line
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - '#clock-cells'
   - reg
   - clocks
   - clock-names
-  - resets
 
 allOf:
   - if:
@@ -116,12 +120,37 @@ allOf:
             enum:
               - amlogic,g12a-audio-clkc
               - amlogic,sm1-audio-clkc
+              - amlogic,s4-audio-clkc
     then:
       required:
         - '#reset-cells'
     else:
       properties:
         '#reset-cells': false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,s4-audio-clkc
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,clock-pads-clkc
+    then:
+      properties:
+        resets: false
+    else:
+      required:
+        - resets
 
 additionalProperties: false
 
@@ -129,6 +158,7 @@ examples:
   - |
     #include <dt-bindings/clock/axg-clkc.h>
     #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+    #include <dt-bindings/power/meson-s4-power.h>
     apb {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -198,4 +228,27 @@ examples:
                           "slv_lrclk9";
             resets = <&reset RESET_AUDIO>;
         };
+      clk_pad: clock-controller@330e80 {
+        compatible = "amlogic,clock-pads-clkc";
+        reg = <0x0 0x330e80 0x0 0x10>;
+        #clock-cells = <1>;
+        clocks = <&clkc_periphs CLKID_AUDIO>,
+                 <&clkc_pll CLKID_MPLL0>,
+                 <&clkc_pll CLKID_MPLL1>,
+                 <&clkc_pll CLKID_MPLL2>,
+                 <&clkc_pll CLKID_MPLL3>,
+                 <&clkc_pll CLKID_HIFI_PLL>,
+                 <&clkc_pll CLKID_FCLK_DIV3>,
+                 <&clkc_pll CLKID_FCLK_DIV4>,
+                 <&clkc_pll CLKID_FCLK_DIV5>;
+        clock-names = "pclk",
+                      "mst_in0",
+                      "mst_in1",
+                      "mst_in2",
+                      "mst_in3",
+                      "mst_in4",
+                      "mst_in5",
+                      "mst_in6",
+                      "mst_in7";
+      };
     };

-- 
2.43.0



