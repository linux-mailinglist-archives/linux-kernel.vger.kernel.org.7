Return-Path: <linux-kernel+bounces-810296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A824FB5186E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E821899C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6F1F4E34;
	Wed, 10 Sep 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SoRbWa+k"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D8218ACC;
	Wed, 10 Sep 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512496; cv=none; b=UhuWjR+qmYvtFP1HVdQEfsbybhlByC7EG1Q3CM/7lBbFc7EC2R7+WvKNeCZ5/wXJYjE+qRMr6zwcAFpUHzmlODme3lfAv39UN2CHM8vo6yIMII2T0LEfjG7Dza+ZaYOtvPuEHYwfllH5exZ5iP3JdpH00WVaVRdXKCPDTPwkvr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512496; c=relaxed/simple;
	bh=/8UtYirEDYoOIbphyHMIVX0/QMGG1VCWOJPYddPzLD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JgnUFdVn4YgexZEJQXzDq0hmiuNeGziZjxtwLd6S6ibvc7Upnuc4OdfDEGtvVrkgdz1N9t1FN+cdPoc8VMPnFt3T/pydNZWMGECw2FoLzGhIpCQUSwxtxmNYwcJTcv4bfpPPSva9Qbno70mH0KsyGgIhCm8sk399fo+3qH8P+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SoRbWa+k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757512491;
	bh=/8UtYirEDYoOIbphyHMIVX0/QMGG1VCWOJPYddPzLD4=;
	h=From:Date:Subject:To:Cc:From;
	b=SoRbWa+kDhB9TzKR+tCQk5cxSM9+BvVzlO0Q4RcaVwUvc4NjgiwDdSSUt6abI+3Ug
	 2ICt72HDwN3INq23r2f4C6tz8QayhHSz0AxTt6NPQ+CzXjJo3qGJyFzw1m2Z/ryWUI
	 DglsBglH9bdVUC+/jtebE0TukzdZuvxk854VleQUzgUbo+QxwfFNG8GGeep0Bz34/u
	 seIqjIZK1a1quNulXCt2DXL6zqU1zyuRb96VT6FbznTr2YTKF9phyNxL4tqWMZv4Dl
	 ZxVA29YmwTFw/x8dZUzkCbsl+l+u1kSSpAuQJ4QdZoRmrZJXsdw4FpGgp+aiYfBgSM
	 nZ6ekpzsouE0w==
Received: from jupiter.universe (dyndsl-091-248-188-108.ewe-ip-backbone.de [91.248.188.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BAF0217E088B;
	Wed, 10 Sep 2025 15:54:51 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 79570480044; Wed, 10 Sep 2025 15:54:51 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 10 Sep 2025 15:54:51 +0200
Subject: [PATCH] arm64: dts: rockchip: Fix network on rk3576 evb1 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-rk3576-evb-network-v1-1-68ed4df272a2@collabora.com>
X-B4-Tracking: v=1; b=H4sIACqDwWgC/x3MwQpAQBCA4VfRnE3NrhCvIgfLYFJLs1pK3t3m+
 B3+/4HAKhygzR5QjhJk9wkmz2BcB78wypQMlmxJjSHUrSjrCjk69Hxeu27oqBkd2YrIGEjhoTz
 L/U+7/n0/pbO4qGQAAAA=
X-Change-ID: 20250910-rk3576-evb-network-b09cb0260011
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=/8UtYirEDYoOIbphyHMIVX0/QMGG1VCWOJPYddPzLD4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGjBgyv0Snl1hIYtTGv1yO1KIdE5RcXUVbExR
 iQ4YXBWaLwBmokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJowYMrAAoJENju1/PI
 O/qaBOkQAKMN/8cj7wuP2lEaE7js7l+HmzH07C5ToGZ7aVe6EJ0NXEwozv2ItC2mLGlavxhl773
 rWmymc+sSoVP67KtoOeLb/h7+71wkjDOg/iTDA+zZaHRGxGbM+b2ebSOUwq0NGiWYD33PW4vQS4
 aDrmYPKRef9tCFkz8hxPmQsMGYZzpxvCTOG/9hUewg+Q3Q6bC70mIhpC4FoWRUG62lCqlPEg93n
 5TRnR+6FVY4UViPX84scJdTSCl+e5z51LVKiCtP+jjPb6MQsDZygYygKMtvW3sgt4TPJPGYMQJu
 2H272hUQJtR6aiJlhcJfM+J841hZb8WmNKEW+cX8pz7HLHJ12Ca/4BU0lUx1W+Tcsjy8qmveRY/
 oWzOy8GX4HdkRok4n8IXs5UKIlb9uhjP/wPh4XHmeCZGUSqdXTh2xnRn57l3xR+WMVpTzJ7Ypny
 EE6aT6l0D72vUxopFQR/noL0TSl8rBdLUE7sc8iFKOx1qZMoGZlY3jMICckxH5OdTy2sj3cYlSQ
 7bxMV8L/1tSyfy2eclx2Pa69U0JUCwnblGbIKSqDsE0Lgq7GhWShMmvHZpO2bsbxSmNO5F+0mz8
 aVSdyNEi+XFSTMHUprG+SgrdqUqh/AWB+tjwRY7S62Ads6sf72Pk76CaaVqX5CzcNGjNwXDr3z4
 55B97I8mYJo51ZO4O/2c4Dw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The RK3576 EVB1 has a RTL8211F PHY for each GMAC interface with
a dedicated reset line and the 25MHz clock provided by the SoC.
The current description results in non-working Ethernet as the
clocks are only enabled by the PHY driver, but probing the right
PHY driver currently requires that the PHY ID register can be read
for automatic identification.

This fixes up the network description to get the network functionality
working reliably and cleans up usage of deprecated DT properties while
at it.

Fixes: f135a1a07352 ("arm64: dts: rockchip: Add rk3576 evb1 board")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 38 +++++++++++++++++-------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index 439831715cbb55a67ce9ca8736d70549377e8048..db8fef7a4f1b9570cb517ccc9a857d1c93c9d2db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -275,9 +275,6 @@ &eth0m0_rx_bus2
 		     &eth0m0_rgmii_clk
 		     &eth0m0_rgmii_bus
 		     &ethm0_clk0_25m_out>;
-	snps,reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 20000 100000>;
 	tx_delay = <0x21>;
 	status = "okay";
 };
@@ -293,9 +290,6 @@ &eth1m0_rx_bus2
 		     &eth1m0_rgmii_clk
 		     &eth1m0_rgmii_bus
 		     &ethm0_clk1_25m_out>;
-	snps,reset-gpio = <&gpio3 RK_PA3 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 20000 100000>;
 	tx_delay = <0x20>;
 	status = "okay";
 };
@@ -715,18 +709,32 @@ hym8563: rtc@51 {
 };
 
 &mdio0 {
-	rgmii_phy0: phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+	rgmii_phy0: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
 		reg = <0x1>;
 		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		assigned-clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		assigned-clock-rates = <25000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rgmii_phy0_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
 	};
 };
 
 &mdio1 {
-	rgmii_phy1: phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+	rgmii_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
 		reg = <0x1>;
 		clocks = <&cru REFCLKO25M_GMAC1_OUT>;
+		assigned-clocks = <&cru REFCLKO25M_GMAC1_OUT>;
+		assigned-clock-rates = <25000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rgmii_phy1_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -786,6 +794,16 @@ rtc_int: rtc-int {
 		};
 	};
 
+	network {
+		rgmii_phy0_rst: rgmii-phy0-rst {
+			rockchip,pins = <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		rgmii_phy1_rst: rgmii-phy1-rst {
+			rockchip,pins = <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pcie0 {
 		pcie0_rst: pcie0-rst {
 			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;

---
base-commit: 02761df1f09ec1d3e03ec2c68c6c5c85955dd8f4
change-id: 20250910-rk3576-evb-network-b09cb0260011

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


