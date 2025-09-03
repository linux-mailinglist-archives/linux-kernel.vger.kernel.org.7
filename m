Return-Path: <linux-kernel+bounces-799157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3CB427D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95EE3BC006
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960FA320CCC;
	Wed,  3 Sep 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyxGWYjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50282C027E;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919953; cv=none; b=NTXldhcdzi//0OEdZ9aUpTpW0n+VymoxNPRh61E5r65KakFvU7jlPcOqrt7gmbZGyLoNUcs9n+I+c8sqhgXuN/Sz/KHKvN0abFEFSbwL++HG4zSQun3O/aaq/mTgfkeD1xMGrXMmu4cckAOuvxCviNAQrn5BAs3bCwxipyP75EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919953; c=relaxed/simple;
	bh=c20cmmfTeQA0nLdLkh/oo9A3fLD/zAk2dIMmFlk8lfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbP9PwyjgT+hFd99zfGETfveB1Jwx8zAOQ3RMch6EjSYWhQJIj4hReXlc2mJ8hjE/yp4LvZttwPn9smGjvufbcHagTEu0vOMlY8MLL/MZjigZ2FX+7t8g7CYk97xJpnNMAed7iLQPHXxOrJfXYOAojPV+uNUhYEPoNcQWR8oohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyxGWYjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75660C4CEF8;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=c20cmmfTeQA0nLdLkh/oo9A3fLD/zAk2dIMmFlk8lfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DyxGWYjYLjywV5SG02zaRV33wR4VCX2liVrKIm1iv6WgyBRqVFt2TBzucM9x2PiSE
	 0LvP6ZGGeHN/5+0wCxyViurYgZY6zNo/rgzOdxcL0aNqVFuJiakfK5zcgty8ih4VnM
	 tfwnYCZ5aZxW44NiJxL4q2RLAjrFRlsH7mnV+sXILqWnEGVjeJo+cYANbXVDXCC7Tn
	 dHe3Hwe2nne1n4zmyKKI5tLOyz374rcYMaB6Uc/OmY2SGWLp+3CAGFZfwJEbv0FeAX
	 K4qPYjJ82Okc7VrMRtk37YTljDzW20+aK3A77TXku6AvDwphlPuMub7a0HVSGHfZUI
	 I3kqjlTdpzjDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457FCA1015;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Wed, 03 Sep 2025 19:04:51 +0200
Subject: [PATCH v4 3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add
 rk3588 variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v4-3-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=2731;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=7bigeg1F5lPwfgStFZZ4wKFyLRk3XbHpIpD0M72GMm0=;
 b=LokOxU4EfIW0fGm4vKWQMR5FmC0PeGxu6+KsKQv2ROgNpcw1hbk8D+oy49nGl5PnLAz3/co7E
 Og8j+IhAP9wDMHvR1s0BysO7/GM+jaqAna8v3Mq7yibY4/J3iMRybe2
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

The Rockchip RK3588 variant of the CSI-2 DPHY features two reset lines.
Add the variant and allow for the additional reset.

While at it, fix the description of the first reset in order to avoid
confusion.

Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
index b304bc5a08c4..03950b3cad08 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
@@ -21,6 +21,7 @@ properties:
       - rockchip,rk3326-csi-dphy
       - rockchip,rk3368-csi-dphy
       - rockchip,rk3568-csi-dphy
+      - rockchip,rk3588-csi-dphy
 
   reg:
     maxItems: 1
@@ -40,11 +41,15 @@ properties:
 
   resets:
     items:
-      - description: exclusive PHY reset line
+      - description: APB reset line
+      - description: PHY reset line
+    minItems: 1
 
   reset-names:
     items:
       - const: apb
+      - const: phy
+    minItems: 1
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -74,6 +79,30 @@ allOf:
     then:
       required:
         - power-domains
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
+          maxItems: 1
+
+        reset-names:
+          maxItems: 1
+    else:
+      properties:
+        resets:
+          minItems: 2
+
+        reset-names:
+          minItems: 2
 
 additionalProperties: false
 
@@ -91,3 +120,22 @@ examples:
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



