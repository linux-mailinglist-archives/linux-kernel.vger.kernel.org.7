Return-Path: <linux-kernel+bounces-888045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FDCC39ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BC4F31BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47393093AE;
	Thu,  6 Nov 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="DitawZXX"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC02FB616;
	Thu,  6 Nov 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419281; cv=none; b=USOek0qfD6MrNBCNyqZ/o7ukM3jmT09wk5KunJkZMmpKGkvvuduAnoeGysqcPJMouVIKQJGMAVuzBDViyOwexwnnoPVW7H9Uim5T/X7HT8McW4OCANJMQmA+cpO3Z38cX9WjyOu8I6GBdc2UBhNSKX4lrQTbtWhTcJttvf4vFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419281; c=relaxed/simple;
	bh=Lmb+20oT4tOY9BWFd3TwhRaWrkFxMoiMbPJb1QuUx2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gF1xn2571LYAAluSgWXj4qkuKdQ574ba5Dm7xpWT1zgX4jQEkBM/dqFivDa7XUzbayvvcjep8iP59gNHpp0fPt/2ZhZ2iHp78c459LinyF8TXXQu6Eep9Lxctyboi4FgjK1KfN02l1HyTNbl+HrpIInsFTYLtQdN45gl+5EpFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=DitawZXX; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1762419277;
	bh=FFBdt9C4gI7HHhth+9l6zVhImR8cz8//vGI97WJnQ4w=;
	h=From:To:Cc:Subject:Date:From;
	b=DitawZXXMH7KHrl2vz58RM8KK2y+K7Sf6x49hBCtUYd40lQcfTgUV/NGOAbLgM5hw
	 xUGP++tc9XEZch5fJMJ+Dc1EE0krAP+Teu2y4rA+CvIwkdPSfygsqS84Cm9t+npdwG
	 rgxLln3Ndgpyph70SzGlVZlRQvzJkcIrFuMaKjQE=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id CF800A03F0;
	Thu,  6 Nov 2025 09:54:37 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 1/2] ARM: dts: imx6dl-yapp43: Enable pwm-beeper on boards with speaker
Date: Thu,  6 Nov 2025 09:54:28 +0100
Message-ID: <20251106085429.2067699-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lynx, Pegasus and Pegasus+ boards have a speaker connected to the PWM3.
Enable a pwm-beeper on these boards so the system can produce simple
sounds.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
changes in v2: none

 .../boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts    |  8 ++++++++
 .../dts/nxp/imx/imx6dl-yapp43-common.dtsi     | 19 +++++++++++++++++++
 .../boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts  |  8 ++++++++
 .../dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts |  8 ++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts
index 5c2cd517589b..0a6b668428a3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-lynx.dts
@@ -21,6 +21,10 @@ &backlight {
 	status = "okay";
 };
 
+&beeper {
+	status = "okay";
+};
+
 &lcd_display {
 	status = "okay";
 };
@@ -37,6 +41,10 @@ &pwm1 {
 	status = "okay";
 };
 
+&pwm3 {
+	status = "okay";
+};
+
 &reg_usb_h1_vbus {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
index 2f42c56c21f6..6f9bd163ffbe 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
@@ -26,6 +26,12 @@ backlight: backlight {
 		status = "disabled";
 	};
 
+	beeper: beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm3 0 500000 0>;
+		status = "disabled";
+	};
+
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -466,6 +472,13 @@ MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
 		>;
 	};
 
+	pinctrl_sound: soundgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT0__GPIO1_IO16	0x1b0b0
+			MX6QDL_PAD_SD1_DAT1__PWM3_OUT	0x8
+		>;
+	};
+
 	pinctrl_touch: touchgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_19__GPIO4_IO05	0x1b098
@@ -551,6 +564,12 @@ &pwm1 {
 	status = "disabled";
 };
 
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sound>;
+	status = "disabled";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts b/arch/arm/boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts
index ec6651ba4ba2..7332f2718982 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-yapp4-pegasus.dts
@@ -17,6 +17,10 @@ memory@10000000 {
 	};
 };
 
+&beeper {
+	status = "okay";
+};
+
 &gpio_oled {
 	status = "okay";
 };
@@ -37,6 +41,10 @@ &oled_1309 {
 	status = "okay";
 };
 
+&pwm3 {
+	status = "okay";
+};
+
 &reg_pu {
 	regulator-always-on;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts
index 4a961a33bf2d..770a85e0561c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-yapp4-pegasus-plus.dts
@@ -17,6 +17,10 @@ memory@10000000 {
 	};
 };
 
+&beeper {
+	status = "okay";
+};
+
 &gpio_oled {
 	status = "okay";
 };
@@ -37,6 +41,10 @@ &oled_1309 {
 	status = "okay";
 };
 
+&pwm3 {
+	status = "okay";
+};
+
 &reg_pu {
 	regulator-always-on;
 };
-- 
2.43.0


