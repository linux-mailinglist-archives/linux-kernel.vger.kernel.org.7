Return-Path: <linux-kernel+bounces-795334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C137B3F044
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D1E487878
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866E27586E;
	Mon,  1 Sep 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPdsJbkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64D1DEFDD;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760513; cv=none; b=KDh5sTy6eCLSZsNpb5I2WgoEMF1SdBOIgtxgWJthfzycUhVQ/2cGHo0t+9NNGjVxaVywhPAhrAt/sC39bCf/iVymrhdNyOIKmjRtsJESXc9VE1g0XxG8uzaVyONYA6uMh2AatyolFJ2ecVKgfMkLUgRdu0Fc7GauIChgoQPLpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760513; c=relaxed/simple;
	bh=vBYv6MXUwCuhAbpabDwzBwOgMyTdiJM8q4aGv6VxvME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8yByQGxN42mTXfm/dWxYvCwxCTpyHt5bIeaLzMy9SEykspmL/J2S5FMvWe4euM0JzeKkCfUNVz1SHWeHwZ42I4CxWelMTWkBzvSNfBOLn8D6ZH/HKNHF+OSft3GQLuagolsb7+C6jY7Q0fZ7azoUZyrsCIHPehAwmQ/G5Cyi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPdsJbkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3C6AC4CEF8;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760512;
	bh=vBYv6MXUwCuhAbpabDwzBwOgMyTdiJM8q4aGv6VxvME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aPdsJbkRjCQLOpTsKDW49YistbX/BPcUZoZ34Ki7srfAsN/FKLgFZ29duWyTr1F0H
	 D5cwHWqPgq+u7gCmVOqyJc+jb55xtC3/H1B4Gc1sZhVH21FbotV9N03WCcFpt1yeKk
	 ZgzKisZR+qSsl+wk7tkVcejOSOnC0NKUNoobCmJOTMO8Mnz8aiPqV3OhK4v3oMPxHc
	 ynN4UVHMoMsaVKP6KdSZvqPXlRly6uwDVTL6oxJJ3r+5O7TUtnanI5K+TR7kscX2Y7
	 Bp3axnfp8niaXYhVKdj3b/KiqxKJWarke0e7Q7lD+2ZkobtdGi6ac3XeshlNu6iYJQ
	 zYUQa5DV6Xpqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D47CA100A;
	Mon,  1 Sep 2025 21:01:52 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Mon, 01 Sep 2025 22:47:43 +0200
Subject: [PATCH v3 2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make
 power-domains non-required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v3-2-a5ccd5f1f438@collabora.com>
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
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
 Michael Riesch <michael.riesch@collabora.com>, stable@kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756759662; l=1532;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=GUfdT8g95f8R9qP58as/tdyx1X3jOtQiZxdNeML59g4=;
 b=DuKH0e/OtkdKKwqW8M1VcwKl51XChDQIf7z5nZn4GekS4KRFKM7SBl7RIlzRLjARVw+cyOq7K
 X77ZmFyW07WAXDc8vQbjEz4rupfXT9JoXWqtm7LZ3beawyE8IACb5Do
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

There are variants of the Rockchip Innosilicon CSI DPHY (e.g., the RK3568
variant) that are powered on by default as they are part of the ALIVE power
domain.
Remove 'power-domains' from the required properties in order to avoid false
negatives.

Fixes: 22c8e0a69b7f ("dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy")
Cc: stable@kernel.org
Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 .../devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
index 5ac994b3c0aa..9ad72518e6da 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
@@ -51,13 +51,26 @@ properties:
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
+    then:
+      required:
+        - power-domains
+
 required:
   - compatible
   - reg
   - clocks
   - clock-names
   - '#phy-cells'
-  - power-domains
   - resets
   - reset-names
   - rockchip,grf

-- 
2.39.5



