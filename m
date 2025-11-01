Return-Path: <linux-kernel+bounces-881254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F96C27D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C6440376C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE72F83C5;
	Sat,  1 Nov 2025 12:00:44 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274D2F6190;
	Sat,  1 Nov 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998444; cv=none; b=PnVC/M6lgEPk2qQRWKogVE73mIIK87Lq3m5WXyEU5UVonqpCxWdZGDK5ngOKWBBJnbyk4j7c7UPzgnKtK4Y6fzgYC0uLFZyFrYJt92yDmphRxAH2i856YTdFDvyc+/UGpHjYho1vXfP5U6rjn1zCdemVwh82POMaZJN0JQvxST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998444; c=relaxed/simple;
	bh=bnoZL44cmgQ5fXoUbsYtLZUMhkvJ/6jmim4+uoVl7zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NO0hSCCblp4tdM7EfPs2IEDPjtV+uYjDDXSZ61r7L2h8hUvu7PvhUt80aDS/8xMxURybSN07qetDzHIDHNvgTV7PNfB3RQvahEprw900x0hv6vIHql8HJQ9CSZpcPp75t2OACcoYlUHajDcNIhG0rLIDOgkPSh+CIXMyTAHUm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2801cc49f;
	Sat, 1 Nov 2025 20:00:37 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Hsun Lai <i@chainsx.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: rockchip: update 100ASK DshanPi A1 support
Date: Sat,  1 Nov 2025 20:00:10 +0800
Message-Id: <20251101120010.41729-6-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251101120010.41729-1-amadeus@jmu.edu.cn>
References: <20251101120010.41729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a3f4a7ae303a2kunmc60b64232d3775
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGRpDVkMeHUJPQk9DTh9PGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Enable button, RTC and USB support for the 100ASK DshanPi A1 board.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
index 815f75e7cd70..f325adf348ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
@@ -66,6 +67,61 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	keys-0 {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-maskrom {
+			label = "MASKROM";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	keys-1 {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-recovery {
+			label = "RECOVERY";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	keys-2 {
+		compatible = "adc-keys";
+		io-channels = <&saradc 4>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-user2 {
+			label = "USER2";
+			linux,code = <BTN_2>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	keys-3 {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio0_a0_d>;
+
+		button-user1 {
+			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "USER1";
+			linux,code = <BTN_1>;
+			wakeup-source;
+		};
+	};
+
 	vcc_in: regulator-vcc-12v0-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_in";
@@ -599,6 +655,15 @@ regulator-state-mem {
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	rtc@68 {
+		compatible = "dallas,ds1338";
+		reg = <0x68>;
+	};
+};
+
 &i2c4 {
 	status = "okay";
 
@@ -618,6 +683,11 @@ es8388: audio-codec@11 {
 	};
 };
 
+&i2c9 {
+	pinctrl-0 = <&i2c9m1_xfer>;
+	status = "okay";
+};
+
 &mdio0 {
 	rgmii_phy0: phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -661,6 +731,12 @@ gmac1_rst: gmac1-rst {
 		};
 	};
 
+	gpio-keys {
+		gpio0_a0_d: gpio0-a0-d {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	headphone {
 		hp_det: hp-det {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -688,6 +764,11 @@ &sai6 {
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&vcca1v8_pldo2_s0>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	full-pwr-cycle-in-suspend;
@@ -733,6 +814,19 @@ &uart0 {
 	status = "okay";
 };
 
+&usbdp_phy {
+	status = "okay";
+};
+
+&usb_drd0_dwc3 {
+	status = "okay";
+};
+
+&usb_drd1_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &vop {
 	status = "okay";
 };
-- 
2.25.1


