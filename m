Return-Path: <linux-kernel+bounces-774219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A6B2B006
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137C41B27D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493027B352;
	Mon, 18 Aug 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QfMhOErS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F88258ED7;
	Mon, 18 Aug 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540835; cv=none; b=oiaiuYGPnJPB65pcHeUm2spT2DsqYiBCgEA8PHPWbKfl+wNGEdrz0HvkJpt3uk/ppMB7+LQhnYvg26SJZxN1apYMvoKFvbaW6I2SkGtCWtXAPixJSnEWyrv5/S4rO583tGTi2uRtPAM8mtWyfI45PxMa6p8u7c5togr+QHol1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540835; c=relaxed/simple;
	bh=vNPbjyOpkG8XcByKMjTJekP9BZmb7pofH0G0rNFewM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KzWSp1dIautyWHAHt108O5aLJGXa5ZmqaxvBq5wFqiqJJvQwajFNnMbnlCUvWA45sbSYi2DH+pxt/tTFPgKU9yTx0L2FyM/pj2uA0Gqnyi1qx4x6AMh5Lt/WLUGIN/7ITi1QiGudLgboZXRbdpjPhXCTp+Of2ankHgG/+QxcRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QfMhOErS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755540830;
	bh=vNPbjyOpkG8XcByKMjTJekP9BZmb7pofH0G0rNFewM4=;
	h=From:Date:Subject:To:Cc:From;
	b=QfMhOErSf6V6FAROpst6qSfWmMfdEU2swDhhQpVeNZiJUCOG/0dLZd02RGwAcmT0I
	 2Ik0VrA67saMdINlkItZAK5pq1bLbMoiEI+fkAnBSFSmTB4vMRjMb5zh/vOPao9KLa
	 S0PfVOD/ecrFmZb7U/MbB3xcA3byycSJJNVVAhjC0kjUNJqKZCIf/VdyI8/lRMIEJK
	 HHNpWZ/EDsrPl3qJap007HC2BE1CReq82Ps2OIU2OKDf1IYiPNgCxRDEjzRyfSz491
	 iIjY+1ysVKYHZ1v+deKgZvldDtwVxTsRXRlMB4YSuidANMpX40bmO0XdK+195b1367
	 mLN+6nmlTvzDg==
Received: from jupiter.universe (dyndsl-091-248-210-167.ewe-ip-backbone.de [91.248.210.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C6BAC17E04C0;
	Mon, 18 Aug 2025 20:13:50 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8B3F4480044; Mon, 18 Aug 2025 20:13:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 18 Aug 2025 20:13:44 +0200
Subject: [PATCH v3] arm64: dts: rockchip: add USB-C support for ROCK
 5B/5B+/5T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-rock5bp-for-upstream-v3-1-d13f3cdec86c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFdto2gC/4XNTQ6CMBCG4auQrq3pjxVw5T2MC1qm0KAtmWKjI
 dzdwsa4MC7fL5lnZhIBHURyKmaCkFx0weeQu4KYvvEdUNfmJoIJxaQ4UAxmUHqkNiB9jHFCaO7
 UtpXSjGlVS03y6Yhg3XNjL9fcvYtTwNf2JfF1/QMmThk9Cl5Ca7nSvD4PgB5u+4AdWcUkPopi1
 Q9FrEpZMimN4Y0RX8qyLG8fFqTz/wAAAA==
X-Change-ID: 20250324-rock5bp-for-upstream-fd85b00b593b
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9128; i=sre@kernel.org;
 h=from:subject:message-id; bh=vNPbjyOpkG8XcByKMjTJekP9BZmb7pofH0G0rNFewM4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGijbV4+WI1l+7bVC6KJ4HiKS6TevtgAJywd+
 npkPm/xL6PMZYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoo21eAAoJENju1/PI
 O/qa9q4QAJGTsa96GuiyzMyN31E/2sQDP1x+bwYt+E9lsFLANjPUptk3tNZI822UPoL6aacWZ4f
 eFOnmryrKoBhz4JiwSqPQoW7yTwOJSJHsHKL9dsIDrmO0FXJx4eFifZxoCQIGif/IeBWBEieMlG
 7Vcur65mypXHoNtNqTUfXnmUZ6WgWoKDn+KK2zG0moHzWUXaDcFBpZpfZpbXeLWpTJ+Z7Oi3ola
 Yg58sSCv69UwdVJ9w9pZt50iDlq8As3i/vXqBsBewotPGCLHvqanKB9P4s6zijOK72GR1wd/F0D
 vqfptGnIHG9Qh9c0RLbGDL0OMagVIc3DI/r6SyULcC0/CWZmEk+OtbMQnnfuM9fEWVetSoOYZ2L
 BiJZ2IJ/L3WLVRbXA7wUaXrzcU0FLEcAqF4BU1jVO9Fl+hkzukf7KoEi7cQEdNWGqeK4Ynajw9x
 VdO6jwSTAAdgtP5NikpwDJ6T6DWWwU+zMTq3p1eZgLiU6ah12SfBE6EAN8RS46CEUIhMaMrjlzZ
 2F/g1QA7aAtnbWuy7segbZZtAxnv6qGuMCa+DrHGxRBs3ysQqv5z2D1hAIzzoBf4HaOCqcyStnP
 EBAIG/itWjjVCjoaFlwL8RwRu2wZo67xjPDmZ8SLONduovtQsnT+kxNu46lVRiKEnTWg4ek9Fo3
 EIcjjiMDiL1rXNYsDSYkpmg==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add hardware description for the USB-C port in the Radxa ROCK 5 Model B
family. This describes the OHCI, EHCI and XHCI USB parts. The DisplayPort
AltMode is only partially described, as bindings for the necessary
DisplayPort controller are still being reviewed.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
This series adds USB-C support for the ROCK 5B, ROCK 5B+ and ROCK 5T.

Now that [0] has been merged, this should finally work reasonably
stable. Note, that there is a regression in 6.17-rc1, which breaks
stable operation again. I've send a revert of that in [1]. I think
it's time to enable the USB-C interface, so that we can claim further
breaks as proper regressions :)

[0] https://lore.kernel.org/all/20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org/
[1] https://lore.kernel.org/linux-usb/20250818-fusb302-unthreaded-irq-v1-1-3a9a11a9f56f@kernel.org/

Changes in PATCHv3:
 - Link to v2: https://lore.kernel.org/r/20250508-rock5bp-for-upstream-v2-0-677033cc1ac2@kernel.org
 - Rebased to latest for-next branch from Heiko
   - Dropped merged patches for initial ROCK 5B+ support
 - Renamed series, since it just adds USB-C support now
 - Fix pinctrl for Rock 5B SBU DC pins
 - Also handle ROCK 5T

Changes in PATCHv2:
 - Link to v1: https://lore.kernel.org/r/20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org
 - Replaced DT binding patch with the version from NAOKI
 - Dropped unused pinctrl for vcc5v0_host_en from the shared DT
 - Moved USB-C SBU DC pins to board specific files, since they differ
   between Rock 5B and Rock 5B+
 - Added pinmux for SBU DC pins
 - Rebased to latest version of Heiko's for-next branch
 - Disable USB-C on Rock 5B for now
---
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   | 136 +++++++++++++++++++++
 .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |  12 ++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  12 ++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    |  12 ++
 4 files changed, 172 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
index 612808d2b4c5d4c0de998798a0ce3002f64b32e0..f138e8df511a45a3f3de83024f5ed0fb58f38be2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
+#include <dt-bindings/usb/pd.h>
 #include "rk3588.dtsi"
 
 / {
@@ -55,6 +56,18 @@ rfkill-bt {
 		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 	};
 
+	vbus5v0_typec: vbus5v0-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus5v0_typec_en>;
+		regulator-name = "vbus5v0_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -291,6 +304,76 @@ regulator-state-mem {
 	};
 };
 
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m1_xfer>;
+	status = "okay";
+
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus5v0_typec>;
+		/*
+		 * When the board is starting to send power-delivery messages
+		 * too late (5 seconds according to the specification), the
+		 * power-supply reacts with a hard-reset. That removes the
+		 * power from VBUS for some time, which resets te whole board.
+		 */
+		status = "fail";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			/* fusb302 supports PD Rev 2.0 Ver 1.2 */
+			pd-revision = /bits/ 8 <0x2 0x0 0x1 0x2>;
+			power-role = "sink";
+			try-power-role = "sink";
+			op-sink-microwatt = <1000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
+				<PDO_VAR(5000, 20000, 5000)>;
+
+			altmodes {
+				displayport {
+					svid = /bits/ 16 <0xff01>;
+					vdo = <0xffffffff>;
+				};
+			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					usbc0_hs: endpoint {
+						remote-endpoint = <&usb_host0_xhci_to_usbc0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					usbc0_ss: endpoint {
+						remote-endpoint = <&usbdp_phy0_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					usbc0_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy0_sbu>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &i2c6 {
 	status = "okay";
 
@@ -445,6 +528,16 @@ pcie3_vcc3v3_en: pcie3-vcc3v3-en {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb {
+		usbc0_int: usbc0-int {
+			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vbus5v0_typec_en: vbus5v0-typec-en {
+			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm1 {
@@ -860,6 +953,14 @@ &uart2 {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy1 {
 	status = "okay";
 };
@@ -887,6 +988,27 @@ &u2phy3_host {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	mode-switch;
+	orientation-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_ss: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_ss>;
+		};
+
+		usbdp_phy0_sbu: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usbc0_sbu>;
+		};
+	};
+};
+
 &usbdp_phy1 {
 	status = "okay";
 };
@@ -899,6 +1021,20 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_host0_xhci_to_usbc0: endpoint {
+			remote-endpoint = <&usbc0_hs>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
index 74c7b6502e4dda4b774f43c704ebaee350703c0d..5e984a44120e4086fce9e7b72b3db1feaa820275 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
@@ -99,12 +99,24 @@ pcie3x2_rst: pcie3x2-rst {
 	};
 
 	usb {
+		usbc_sbu_dc: usbc-sbu-dc {
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>,
+					<0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 };
 
+&usbdp_phy0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usbc_sbu_dc>;
+	sbu1-dc-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+};
+
 &vcc5v0_host {
 	enable-active-high;
 	gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 9407a7c9910ada1f6c803d2e15785a9cbd9bd655..8ef01010d985bab42db33f88e5e50a3e96053288 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -38,12 +38,24 @@ &uart6 {
 
 &pinctrl {
 	usb {
+		usbc_sbu_dc: usbc-sbu-dc {
+			rockchip,pins = <4 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>,
+					<4 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 };
 
+&usbdp_phy0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usbc_sbu_dc>;
+	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
+};
+
 &vcc5v0_host {
 	enable-active-high;
 	gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
index 258c7400301d7f77517197ab433946bbfa39cf63..b91ef6389bb0e413b56b9618e8707957410d1285 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
@@ -95,6 +95,18 @@ hp_detect: hp-detect {
 			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usbc_sbu_dc: usbc-sbu-dc {
+		rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>,
+				<0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+	};
+};
+
+&usbdp_phy0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usbc_sbu_dc>;
+	sbu1-dc-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
 };
 
 &vcc3v3_pcie2x1l0 {

---
base-commit: 7f0817eee7ba40b48e956955d6fd8ba14750168c
change-id: 20250324-rock5bp-for-upstream-fd85b00b593b

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


