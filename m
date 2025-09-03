Return-Path: <linux-kernel+bounces-799161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B086B427D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8991717CFE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997A335BB0;
	Wed,  3 Sep 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXQdb4f8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881031578B;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919954; cv=none; b=Y7XIfL1TMXOaec1D0ZPAnz0foz4yYwh1sEZ9oRhKFQRMyioK2jVZRRl6umEwKXQT3vJtTGSQcIqEvQrFNHoaZ+yo7XqBLPpMwv58LIQpF2YQ3rc+yiyVpVWiTv8o/Wkj250gK0DZU3hfFsYNaYMO2XwZRLxsUEX0rwYqDT3Y+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919954; c=relaxed/simple;
	bh=f7pzs19WsSpPk7IiGwL4pkOX5YtpLd+7ruT/bjmFUoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BguRxNZu19bHH9U6/GUQddpQJGjUU2GMTJwi/0Hph4mRoi5JXLyOV8Sa82OTaeXM4X2a3vDmVT3+T0gZX6EWcCOno8QoWyPv+4Ge5qjqCDIdttiLk+cZkbbubrHpeltvm3kCzcu3QgsI3Ogtttg9HoGo62kHMLHQnqjAFiuLMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXQdb4f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAA4AC16AAE;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=f7pzs19WsSpPk7IiGwL4pkOX5YtpLd+7ruT/bjmFUoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nXQdb4f8dPzmftqDcYw0+e4hSLMrxXdatiKT+z/a1AG/rt6LSGP3rEvrr6dg0Hy8S
	 4yt7G049FnK77P/8QPNBduEPwgntEzuSV6F/x3gvNAXwFnwdb8m0dwwXm/B0ZDFIF8
	 3quOYij2GwhFNBx3a6qn8uaSfYv/zk+638aPPp4CaoaLBYnbfmd1UWoc1lnP5h3FBj
	 An8QutbE7BMGbBu6hZy2CxsKcLpLtMCJzBa2B78I6hNmhcbjROducnMIO8kFGgMQfw
	 Z4gL4uxXbjsZCEMs5hqepw3DkKWX9qcqgr76ALhJp/Pxmcv74kwF5qlShTM1ppET+R
	 nH8R2dULw9TRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151BCA1015;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Wed, 03 Sep 2025 19:04:55 +0200
Subject: [PATCH v4 7/7] arm64: dts: rockchip: add mipi csi-2 dphy nodes to
 rk3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v4-7-a4f340a7f0cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=1971;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=EOeNg7P2XmUPLOzLBrcxGPzX6tkgiFkIQtNnjJusr/w=;
 b=Tmen4hPVQ8EHstuJqdsTDkixieFXQyEUDYNYXsTEOdpGe3owz93Y94SPBObYOtj3lz5pZzdyz
 CzI7aEQr8tRA+RdzaY+Qv2gxoD0LCowf7kQjFilyAkgjgwTOh/YamsN
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

The Rockchip RK3588 features two MIPI CSI-2 DPHYs. Add the device
tree nodes for them.

Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 70f03e68ba55..72a0022d1b74 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -621,6 +621,16 @@ php_grf: syscon@fd5b0000 {
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
 	};
 
+	csidphy0_grf: syscon@fd5b4000 {
+		compatible = "rockchip,rk3588-csidphy-grf", "syscon";
+		reg = <0x0 0xfd5b4000 0x0 0x1000>;
+	};
+
+	csidphy1_grf: syscon@fd5b5000 {
+		compatible = "rockchip,rk3588-csidphy-grf", "syscon";
+		reg = <0x0 0xfd5b5000 0x0 0x1000>;
+	};
+
 	pipe_phy0_grf: syscon@fd5bc000 {
 		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
 		reg = <0x0 0xfd5bc000 0x0 0x100>;
@@ -3055,6 +3065,30 @@ mipidcphy1: phy@fedb0000 {
 		status = "disabled";
 	};
 
+	csi_dphy0: phy@fedc0000 {
+		compatible = "rockchip,rk3588-csi-dphy";
+		reg = <0x0 0xfedc0000 0x0 0x8000>;
+		clocks = <&cru PCLK_CSIPHY0>;
+		clock-names = "pclk";
+		#phy-cells = <0>;
+		resets = <&cru SRST_P_CSIPHY0>, <&cru SRST_CSIPHY0>;
+		reset-names = "apb", "phy";
+		rockchip,grf = <&csidphy0_grf>;
+		status = "disabled";
+	};
+
+	csi_dphy1: phy@fedc8000 {
+		compatible = "rockchip,rk3588-csi-dphy";
+		reg = <0x0 0xfedc8000 0x0 0x8000>;
+		clocks = <&cru PCLK_CSIPHY1>;
+		clock-names = "pclk";
+		#phy-cells = <0>;
+		resets = <&cru SRST_P_CSIPHY1>, <&cru SRST_CSIPHY1>;
+		reset-names = "apb", "phy";
+		rockchip,grf = <&csidphy1_grf>;
+		status = "disabled";
+	};
+
 	combphy0_ps: phy@fee00000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee00000 0x0 0x100>;

-- 
2.39.5



