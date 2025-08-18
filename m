Return-Path: <linux-kernel+bounces-774585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F3B2B482
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7507B621151
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9627C842;
	Mon, 18 Aug 2025 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8oa5Jd7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6C26FA6F;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558873; cv=none; b=lbWSNZVOmKl/0rBPMUVR+UvJfeWps2b2QMkHPuQqz/Nn+GbF23QZ/NMC2B+4pWTU7DIi9C657s5tjbthheHuZN0cacgmBSTVZbxiZwILiB0M8avBHUV0YDyxweX1BjOgaUmwQmmzmr9WeGbSimcCUWx/Sg6TYxiEow8/YRdMoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558873; c=relaxed/simple;
	bh=C8JbbdDqM8lge0snDOXhphGmPRbweJnkcQYl4O2Lpuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LeoJkdWzl0VA8E3JbIKFRt3nNYJ482+eAp1BYm04gvKFHbx+XQ+BBcZIOWK6HdAFII5SF5HpxpFMbF007Nnwv5z1O6gnZVjJ8O4YE8dvYlodfFNWYC3ujA+6J+2F7P6ehXkwsc/1ufCznCH1c278iFYjCy+r3A1ig9p+dE/+y3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8oa5Jd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79E4FC19421;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558873;
	bh=C8JbbdDqM8lge0snDOXhphGmPRbweJnkcQYl4O2Lpuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M8oa5Jd73CLwo3dCzUa7TgbVZrBH+pXaskBKXW5ypYFF9nD9xQu8MsIXmIiLBLBq/
	 jPJh6p/yOiVu/Exxt8famo5syinIp1GfwLXgYa9SrIubDy5kkR0D7qULRKMinz2LLV
	 MWxdJWjwPs697lCFUwLke8uYvZyXotSf/zP/sZ/CLqWrGiW8Qd1Z1IK845Jcr1jVNg
	 nbFoJ/hP/1AFPUoaf+KLcFkwHxmfkquIQo3lpya79QxY7UTH8Lthyom7lj8rLPMAqi
	 bS8ONHQ1U3MPPCtcVsllK7ct42SRFrAQWcCWRIGlIUq0PvT/ZQfF/ttsFD/2GIWwIF
	 M9buD6BtQp6nA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB6CA0EF1;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Tue, 19 Aug 2025 01:00:37 +0200
Subject: [PATCH v2 3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add
 rk3588 variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v2-3-7a94f079b712@collabora.com>
References: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Michael Riesch <michael.riesch@collabora.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755558041; l=2827;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=PMDzlrQeY+NRmFqopM/ChR6/5pYbe3wSrubFJu+0sMU=;
 b=AEtLzU240l3giMFwyKl21EH9Gejgiu6qeYmvs3lvFhzWFKQ1tm7t0mCqCxz29QeDKQCU7vmKM
 w70rtAqj0rKAfrDEtilu6hzdb8YHSeHoMX79gE1BCU3lqkrWLYpYDVC
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

The Rockchip RK3588 variant of the CSI-2 DPHY features two reset lines.
Add the variant and allow for the additional reset.

Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 60 ++++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
index 42da616ae2e3..10197cc9dc47 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
@@ -21,6 +21,7 @@ properties:
       - rockchip,rk3326-csi-dphy
       - rockchip,rk3368-csi-dphy
       - rockchip,rk3568-csi-dphy
+      - rockchip,rk3588-csi-dphy
 
   reg:
     maxItems: 1
@@ -39,18 +40,50 @@ properties:
     maxItems: 1
 
   resets:
-    items:
-      - description: exclusive PHY reset line
+    minItems: 1
+    maxItems: 2
 
   reset-names:
-    items:
-      - const: apb
+    minItems: 1
+    maxItems: 2
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Some additional phy settings are access through GRF regs.
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-csi-dphy
+              - rockchip,rk1808-csi-dphy
+              - rockchip,rk3326-csi-dphy
+              - rockchip,rk3368-csi-dphy
+              - rockchip,rk3568-csi-dphy
+    then:
+      properties:
+        resets:
+          items:
+            - description: exclusive PHY reset line
+
+        reset-names:
+          items:
+            - const: apb
+    else:
+      properties:
+        resets:
+          items:
+            - description: APB reset line
+            - description: PHY reset line
+
+        reset-names:
+          items:
+            - const: apb
+            - const: phy
+
 required:
   - compatible
   - reg
@@ -77,3 +110,22 @@ examples:
         reset-names = "apb";
         rockchip,grf = <&grf>;
     };
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        phy@fedc0000 {
+            compatible = "rockchip,rk3588-csi-dphy";
+            reg = <0x0 0xfedc0000 0x0 0x8000>;
+            clocks = <&cru PCLK_CSIPHY0>;
+            clock-names = "pclk";
+            #phy-cells = <0>;
+            resets = <&cru SRST_P_CSIPHY0>, <&cru SRST_CSIPHY0>;
+            reset-names = "apb", "phy";
+            rockchip,grf = <&csidphy0_grf>;
+        };
+    };

-- 
2.39.5



