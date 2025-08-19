Return-Path: <linux-kernel+bounces-776017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A8B2C789
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E9A520356
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0D27E1C5;
	Tue, 19 Aug 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uew5Wgqk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769427B328;
	Tue, 19 Aug 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615029; cv=none; b=AFpZJOB3yQtIgt6DJQUuh9c7pVp17sgULmKbfVqDbw65rsnyspgbu3BN8XMT1cLrhBukjQnexiSSr69MyH1ewiXgrS7o7NUTsgelqHZ85fyQH7W6IJVKHp5ieCtIZsEYXgufT8TBDd35ms1mwWorAc8C1xRNAr+GxV3KXj1EEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615029; c=relaxed/simple;
	bh=Yiwz8AGMAP/ESeshF5msVk8My9HQeNxOKXjxXregOWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UtcTy6ARU2H5CJatjQ1fQpeyWeQK+5GYgGBg9rqvmRxjrpY8Icq6a15iH+L0T33MfzcaV5RiOBCBefkPQWmAeGUMyZfUA9siY48DRP/XALpoPczpamxTYMEqX7C3efMEWSP3iwWBj5Zffd/js4fHPbZga+1sRgmSAKdZE7Pg3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uew5Wgqk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755615020;
	bh=Yiwz8AGMAP/ESeshF5msVk8My9HQeNxOKXjxXregOWI=;
	h=From:Date:Subject:To:Cc:From;
	b=Uew5WgqkH/9s5sSWxVLaf7HvDET5RtGtF94110P+MTIAkk7vEoSsUNp5X96yaMdaT
	 e8Nka3IY9C0PDdvPqOAAyXANfWREhSPi1vyhYj9X9dmVsBA0GaN4HZGG/53ZOyRC13
	 kqup/Woydv/9Oi+Zu3SmgB6R32sEfFCFrpnEnm0soK7Jyy3LYzJfMjTeQBI36POxoZ
	 zwphSo61Azlnb+hb3a72Abj7CFzdisJZc+B8vFXZbYNxWm6EHeUNfP8RCQ6cVfhhvA
	 i/l0NpUzGtSMfvwIpNmIMzO7JW8F7sYZrWl8L599DpydIaBOHxYA3XI3F8Dy/iQYjW
	 Jtnsz6h+hXxqg==
Received: from jupiter.universe (dyndsl-091-248-189-012.ewe-ip-backbone.de [91.248.189.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0751017E110D;
	Tue, 19 Aug 2025 16:50:20 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id B77F1480044; Tue, 19 Aug 2025 16:50:19 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 19 Aug 2025 16:50:13 +0200
Subject: [PATCH v4] arm64: dts: rockchip: add USB-C support for ROCK
 5B/5B+/5T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-rock5bp-for-upstream-v4-1-7a2365ce7176@kernel.org>
X-B4-Tracking: v=1; b=H4sIACSPpGgC/4XNQQrCMBCF4atI1o5kksZWV95DXDTJRIPalEktS
 undbd2IiLj8H8w3g8jEkbLYLgbB1MccUzNFsVwId6qbI0H0UwsllZFaFcDJnY1tISSGW5s7pvo
 KwVfGSmnNRlsxnbZMId5f7P4w9SnmLvHj9aXHef0D9ggS1gpL8gGNxc3uTNzQZZX4KGaxV2/Fy
 OqHomalLKXWzmHt1Jei30qFvxQNCB510M6Tq9buQxnH8QmTAAXCRQEAAA==
X-Change-ID: 20250324-rock5bp-for-upstream-fd85b00b593b
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9307; i=sre@kernel.org;
 h=from:subject:message-id; bh=Yiwz8AGMAP/ESeshF5msVk8My9HQeNxOKXjxXregOWI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGikjyuF3J7QK518kBCdeKNz/W3LNWSqA/ttL
 wJxLjmSvA1+p4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJopI8rAAoJENju1/PI
 O/qaRMQP/1mdQ7NjIKQ2Br/iT5KidWYnSB8xTJJYCyrTkoCpqI8M73kPblwS8N3W4EFUZPTmCdV
 6U2/5LAp/Ln6dqbLfxb76vwCIDIKf4E5XjWc87T5k28vcPv7pj6KLhza/g5ID2NhFIden45EChL
 0VqxGmaV97BSGCZOh+UHwuobElXTRZMHkRjLMKUpe/pgrnDC5hQTgoB14+sqYY+RhmsFgXtd8Vm
 HZvIFl7Cei/4RGHE7NjpW/O4JMNtI897jdOociyYB09SvWIUpn2tTfj8miYUs9l0MLxPhjZMFXM
 u1UnhAL5j1P4EljoNr6Q5hWKTw7Po/l2iApVh0Xo9dzwb1mrqr2o6g9bACHKbCgV/FZWzqPsqlm
 ilR3vYrL+5/QYMtxEU/2OVzt59yPJ1VRR+wmLg7AA0ZfERa961wf4OLpcD0dl9uJF7/a9wOQ/My
 xqhCPiQpogAioBFugokPwtRMORjBB0SuvzKX5EfkUEeV2OJIzBw1lx37bEW/1ITWn2lAdsNUxZP
 zt4CnCNjj7kigkztz8t8gcHu81IM+wyUJqsKYXAS5OpPL+7rgaxPXM0AyR8UHA3vJmbTwYoXNGE
 GmXrw3EIEBuLor9RcNMtLOP5rjPvOuDKZh/p6glbvS4B0MLyJJ4FfCOhqTh0H+uhWvohWkBHT/B
 eXI9/gU9+nNNitQIyj0slHQ==
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

Changes in PATCHv4:
 - Link to v3: https://lore.kernel.org/r/20250818-rock5bp-for-upstream-v3-1-d13f3cdec86c@kernel.org
 - Fix ROCK 5T pinctrl DT warning

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
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    |  14 +++
 4 files changed, 174 insertions(+)

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
index 258c7400301d7f77517197ab433946bbfa39cf63..217954767845a73c7462a71c27c724f1309144eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
@@ -95,6 +95,20 @@ hp_detect: hp-detect {
 			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb {
+		usbc_sbu_dc: usbc-sbu-dc {
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>,
+					<0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
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


