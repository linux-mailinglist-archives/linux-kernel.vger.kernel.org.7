Return-Path: <linux-kernel+bounces-878366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF30C206A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3A4622C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EA226CF0;
	Thu, 30 Oct 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="W2Eq0kC5"
Received: from mx-relay17-hz2.antispameurope.com (mx-relay17-hz2.antispameurope.com [83.246.65.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB62192F4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832447; cv=pass; b=VvNzR7FULNjTpuVQUCrXfa8QEUTmNBuDHa7vclCSyQOHN5cYLHL8y3xhvOlqWyiiwoTbeEcTf5ARWMhnK6iI1yJNM60TEO8YQUlt7m/FDL2Ks6McbVE9j7XJGO98JTkskdm/7w/BXRIREXeuYxgWWxg37vyRclPvwdeY6aeYjMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832447; c=relaxed/simple;
	bh=7TJedIY/9UFJw10oGIKYKIy0SHdFPabonZXK+kKB1VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTJsKr06JwIuEbkO5EmCh3ReSTcsTm1xOUp9pjTld66QLf5RLm08ZQ2syEeKqCmr/eLxYYN9ovQNOjp7Pup+uPbVERxM7DbBRtth3flULuqkZPdu1vcMDh4mIiLJ7+AI4zEkmpDP2Vhd/4FRfL/MrhiY2JJanHUxLT2GiH4X4XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=W2Eq0kC5; arc=pass smtp.client-ip=83.246.65.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate17-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=ftODCMJWq6xxBVzz35BWN/b7GEhpvIJPEY0znOy+1pQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832409;
 b=G6mbC0MlfeEqx19lWGiH1PI12K1RDR/t2D7VrnA8lKQYb7XS2Xuk0FDvrfV/md2B8XwDjqvm
 DMrWXPMLQdPhVHfT6vd4bTMIn29geIX/CHDyP0t6wcNryFqqVppOafWk32a5INIvez3hWRIOZi2
 POrgkDe5fxfZZThO/AyzSQbxJ04QKR5fZMg/hhXsKe/1yUAZ3s0tTR7G3fPFxuFIxNaQyT4Vd4R
 RucBQr/9is45YAPU2nyi2g6H4VP5wtCyQoGZQChhPCidhFmJXfMZtDSibZ9YW/WBq9Nz6VuCeFZ
 +OogewZWD5XeYu3xMQFOZL3k3AtnqBSCm5tykE4X8gAqg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832409;
 b=JqVRnc3PC8pXrum7mktEloSDeQ0SghqzeudyOjXrTyijC9HlBCTx8yd408A4NkDb5HPvVm3O
 9y1a1wm9qCMslwpYUBty6ZX2SShMXouZua+xkpKRjy2y1XOfMH9n3AntPFX6FMOGE4VOAsYJeJA
 fC7aOwyV/HuMl0cSEl7hLwl6oRkAE9lTKkQzeNGYadHSgdksveHJR880S7VwRwEEB/nIYWl+uFy
 CXV05ZgSCUOTvuZNFW+lioHNOSWS8XWDg1IUhAGJZL+TIMbNCkMUfwjgXKM4a9dxT0W6jS90wkb
 Y8csyyohYcZXa7C/cbA9CmKBLeyjo6XHB125NWIE7xmFw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay17-hz2.antispameurope.com;
 Thu, 30 Oct 2025 14:53:29 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id D53C65A04FC;
	Thu, 30 Oct 2025 14:53:12 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] arm64: dts: imx95-tqma9596sa: add gpio bus recovery for i2c
Date: Thu, 30 Oct 2025 14:52:55 +0100
Message-ID: <20251030135306.1421154-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay17-hz2.antispameurope.com with 4cy5D94wS6zdbpV
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4ebec40930e540c73b0a44225c3aa667
X-cloud-security:scantime:1.733
DKIM-Signature: a=rsa-sha256;
 bh=ftODCMJWq6xxBVzz35BWN/b7GEhpvIJPEY0znOy+1pQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832409; v=1;
 b=W2Eq0kC5h9DAyam+nyH7ZhuZkO47fE+Y66kl3UgUGjMa+6ZL7F/QW6oaex3mfVebGboYkJww
 yUtpfYSYavP6emw+ig7otqYrcK1UDoaSDikTIJIF8zNJEHiXFWjcS4rXw86EFd4nxT1Dr5jsXae
 dgpGUV8y9miQRMDoiJgNUA6+OP7O3u/weIxZ0VFugVGbvL7krr0yHmQrY6Uw1XN/uQxR5Gu1RSl
 wo0ZdZX7rXWipqZaGgiSFNQDd39HJ7ayZqa6i/X2GWoQlqHzseBjB1gOcOImtQ4vmRuKKzHdMQW
 JCkVmIASi8vFt7dr0yrSegGDJQ02T8fg6sKq7knaSc7uQ==

Add pinctrl group for GPIO based bus recovery.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx95-tqma9596sa.dtsi  | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index cc251505f6280..9c892cd8ff215 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -263,8 +263,11 @@ expander1: gpio@75 {
 /* I2C_CAM0 */
 &lpi2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	dp_bridge: dp-bridge@f {
@@ -299,16 +302,22 @@ dp_dsi_in: endpoint {
 /* I2C_CAM1 */
 &lpi2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_lpi2c4>;
+	pinctrl-1 = <&pinctrl_lpi2c4_gpio>;
+	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
 /* I2C_LCD */
 &lpi2c6 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_lpi2c6>;
+	pinctrl-1 = <&pinctrl_lpi2c6_gpio>;
+	sda-gpios = <&gpio2 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio2 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
@@ -606,16 +615,31 @@ pinctrl_lpi2c3: lpi2c3grp {
 			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL			0x4000191e>;
 	};
 
+	pinctrl_lpi2c3_gpio: lpi2c3-gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28		0x4000191e>,
+			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29		0x4000191e>;
+	};
+
 	pinctrl_lpi2c4: lpi2c4grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO30__LPI2C4_SDA             0x4000191e>,
 			   <IMX95_PAD_GPIO_IO31__LPI2C4_SCL             0x4000191e>;
 	};
 
+	pinctrl_lpi2c4_gpio: lpi2c4-gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30		0x4000191e>,
+			   <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31		0x4000191e>;
+	};
+
 	pinctrl_lpi2c6: lpi2c6grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO02__LPI2C6_SDA             0x4000191e>,
 			   <IMX95_PAD_GPIO_IO03__LPI2C6_SCL             0x4000191e>;
 	};
 
+	pinctrl_lpi2c6_gpio: lpi2c6-gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO02__GPIO2_IO_BIT2		0x4000191e>,
+			   <IMX95_PAD_GPIO_IO03__GPIO2_IO_BIT3		0x4000191e>;
+	};
+
 	pinctrl_lpspi3: lpspi3grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO07__GPIO2_IO_BIT7		0x51e>,
 			   <IMX95_PAD_GPIO_IO08__GPIO2_IO_BIT8		0x51e>,
-- 
2.43.0


