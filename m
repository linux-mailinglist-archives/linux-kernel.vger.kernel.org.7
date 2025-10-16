Return-Path: <linux-kernel+bounces-855447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12042BE141D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A914919C6E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4A20F067;
	Thu, 16 Oct 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ePMMocVh"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60D223DE7;
	Thu, 16 Oct 2025 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581735; cv=none; b=J1zrPa9fkZilSg2zTNoM6VtEnuC9zYp9WlotamzHHmGEqcCz4uKCOL/4ip24rBKqk6DAVkUwX+zG9bT++cWgKH5h1C6ULiBhrQ6gKW1tSV+ZBRpl8qcCgfOZXWvLemoaFLh2nOYGSXDklhifhVVGLNbi2FpK+hOGTzC4wMv4Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581735; c=relaxed/simple;
	bh=Ksu1m13XDgyOSNrC/yix/S/ref0aCyYvyb9gG5K8i98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EejwR4vXUqU/8hDyAbm7SX9BQn1XRLpuy5XLvRdGegi76f3zwswwQm0XRuJO7N3JZNTwXID8HfDiM502dwoIrv50Uq6vwNwAPEskwMAD1714vOXlW37EOkaoMVDHGzg1DU1meo8jZhi6vFnkkkfeSZ+9mUwggR4Vvtq+B7UREZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ePMMocVh; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581708;
	bh=1RfAR5qe3fDpGYWfe4IMPee9wlWopj1wjBrVtJQSHJQ=;
	h=From:To:Subject:Date:Message-Id;
	b=ePMMocVhYpf+bx3EtPyKWKKIVsXxiiUO8q88h8aMWMd16ANKKXzCy0KDnWXQfU+EZ
	 UPnXNEZ2Pe5GGjqVpd3dANfKLy2NEMKIeWCGx107PFH9q3WJqaP6qXnAUVjVrO1DCr
	 wjuy7gCEyAhpkpnwEeAeLhzqF8V/CE7YwvB0uZdc=
X-QQ-mid: zesmtpgz1t1760581707te7834fa0
X-QQ-Originating-IP: fu4+9mqDE3XZAMSCh/z+SENLWrlcpaz7T3n6vsQJy5o=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:28:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18195829153663395563
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 8/8] arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
Date: Thu, 16 Oct 2025 10:27:41 +0800
Message-Id: <20251016022741.91-9-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016022741.91-1-kernel@airkyi.com>
References: <20251016022741.91-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NyTsQ4JOu2J27F0cQTRa45Ef9+r4ktGvtzz8BSBcGwlKmK4bUQ9BqOKr
	7lnp5y6VNi9cvAsawFfhIjGqtlpWOw4TKTT/T53Xe8aGFka1FxZpFl6XiKzEarnSUCLaQPD
	Wwe25p4lploE0MGXVBg6ilyEJwse/GLHWNA3lYjXg37lPbP9WjkzvKua/TO08t5c8yb1Elu
	WzIWnEk/ii2oR0uzll54wldD/1iDQ5rQyOwLoULrS1AKcEeKpCTmePCcSfw38amlPDRxMVX
	7N9KxDFQzG1P545BiN1p40hZNFuKaSslQycZVPXm7UfxNRTtnTFczVQmxRuG2JpbAVCOMCg
	uBZpS1n93kQ/5S90YxD/oAE4C0uUW+/Y0mt5fWsG+KyGdh1JrUrt+TyYwbbVSnfuAJC6LpO
	KzG0U0Y2gaa7Zqsqlaoe4QBUvkQLs65kyHVGmHr/kYHphMSjfkFyWKGmk1/OKChOeP4j25D
	Gjcfn/3FI/QvC82lQfvp9x62k1yRxo+JW5ob8CbratMkkUtHgWIC1Y7ImHi8EzYk91LKi+q
	v+TqUBXYICoPERWdG7DpVhqs6cbktXkgnqEbh1iDLLx3mif/jG8lSz8RGgZrW//goj0RooQ
	hxjakLofksce+yOUZilYPOBB92zTu0UeLr09eWpb7Lfi7X3IKyQH0gt5ukcxaH8T332l3Tr
	Pz2cl9e46C0xAf8wZqXAB0NIXsSbbHxtllkNtRUBVPopuKkhGs6zh7H1HjHGi33kkmjpNc8
	NuI5Yzqe1AeylddJV7e79SKZN9aInTl1ucpbkTbsW6edQsb5guKWLWbtXGn5QYqnNIFX7jE
	9heikYT0QHnWf0svJ7CyW3oNqFtkVeMTIy92OAxTw17dKJ3zVJ3TNbrbzmHrgBZdjT5smOa
	50vivkbEGVoo6af53yl4XQLT1cO2ANhxM8mMciCRbkYCiYwCofzlY0bRxiWRwJqMZKqbJZP
	ivV7C79a85fWPFftKkijCTtpD++imtzRLO55hXZMBM25dU5xIVC6RQI4/UewQfIQtx1NgnD
	ldAPF7G1t93eAxttixuR5JSMhTVo/if0wFnptew8hiBPPGrr58
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 EVB IND board has a Type-C interface DisplayPort.
It use fusb302 chip as Type-C controller.

fusb302 chip ---> USB/DP PHY0 <----> CDN-DP controller

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

(no changes since v4)

Changes in v3:
- Fix wrong vdo value.
- Fix port node in usb-c-connector.

Changes in v2:
- Add endpoint to link DP PHY and DP controller.
- Fix devicetree coding style.

 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
index 70aee1ab904c..aeeee6bd2973 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
@@ -4,6 +4,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/usb/pd.h>
 #include "rk3399.dtsi"
 
 / {
@@ -19,6 +20,21 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	sound: sound {
+		compatible = "rockchip,rk3399-gru-sound";
+		rockchip,cpu = <&i2s0 &spdif>;
+	};
+
+	vbus_typec: regulator-vbus-typec {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_typec0_en>;
+		regulator-name = "vbus_typec";
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -31,6 +47,11 @@ vcc5v0_sys: regulator-vcc5v0-sys {
 	};
 };
 
+&cdn_dp {
+	phys = <&tcphy0_dp>;
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_b>;
 };
@@ -55,6 +76,12 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_l>;
 };
 
+&dp_out {
+	dp_controller_output: endpoint {
+		remote-endpoint = <&dp_phy_in>;
+	};
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -341,6 +368,71 @@ regulator-state-mem {
 	};
 };
 
+&i2c4 {
+	i2c-scl-rising-time-ns = <475>;
+	i2c-scl-falling-time-ns = <26>;
+	status = "okay";
+
+	usbc0: typec-portc@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus_typec>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			op-sink-microwatt = <1000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 1500, PDO_FIXED_USB_COMM)>;
+
+			altmodes {
+				displayport {
+					svid = /bits/ 16 <0xff01>;
+					vdo = <0x00001c46>;
+				};
+			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usbc_hs: endpoint {
+						remote-endpoint = <&u2phy0_typec_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usbc_ss: endpoint {
+						remote-endpoint = <&tcphy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usbc_dp: endpoint {
+						remote-endpoint = <&tcphy0_typec_dp>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &i2s2 {
 	status = "okay";
 };
@@ -354,6 +446,16 @@ &io_domains {
 };
 
 &pinctrl {
+	usb-typec {
+		usbc0_int: usbc0-int {
+			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vcc5v0_typec0_en: vcc5v0-typec0-en {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -400,10 +502,48 @@ &sdmmc {
 	status = "okay";
 };
 
+&sound {
+	rockchip,codec = <&cdn_dp>;
+	status = "okay";
+};
+
+&spdif {
+	status = "okay";
+};
+
 &tcphy0 {
 	status = "okay";
 };
 
+&tcphy0_dp {
+	mode-switch;
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		tcphy0_typec_dp: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc_dp>;
+		};
+
+		dp_phy_in: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&dp_controller_output>;
+		};
+	};
+};
+
+&tcphy0_usb3 {
+	orientation-switch;
+
+	port {
+		tcphy0_typec_ss: endpoint {
+			remote-endpoint = <&usbc_ss>;
+		};
+	};
+};
+
 &tcphy1 {
 	status = "okay";
 };
@@ -418,6 +558,12 @@ &tsadc {
 
 &u2phy0 {
 	status = "okay";
+
+	port {
+		u2phy0_typec_hs: endpoint {
+			remote-endpoint = <&usbc_hs>;
+		};
+	};
 };
 
 &u2phy0_host {
-- 
2.49.0


