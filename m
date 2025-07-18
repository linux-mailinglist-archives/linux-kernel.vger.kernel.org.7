Return-Path: <linux-kernel+bounces-736311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C220B09B65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4377BADCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480F1F583D;
	Fri, 18 Jul 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="vYsQY2ri"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09869218585;
	Fri, 18 Jul 2025 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820020; cv=none; b=I2SYTupL2+H6gpWUVx5CdF3T3S7HMbCS/CTjUjXeKjs33qpHzvshYOsqd1MI9fUIwu+aNoHRFgoEDCIE9SlcNbBL+Cy2g53JfN8OL5JLDrWWzTCJVwpOSppc3f2To3esdRlWWVhohSYExMQj/uCcuSq6nj35ZSPjE2mtWj/Culc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820020; c=relaxed/simple;
	bh=rkOcGha0NMpMENS7IkiGhpncLZ4UIcZCejQJKMH8xbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aDW8NxvQKo6gfKM8kOyUFJevBPk2mFJHjspwssa6KAPXKYhepkUXxdwsvgNF1zK7rQGPw9wMxGhyPFMFi3iaMbwDqnoVUHlkA1wJ6H5WZyOAmvwKklGIh4mOY9e2nDQBbhGhMbJ8P8+qK1is+fus1Z956VAHD1gZl69VaB+YDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=vYsQY2ri; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752820008;
	bh=8L/77Mn5XZ7DUkt0B8rv59NyXI2YcZ6+wGLcoXpyR/Q=;
	h=From:To:Subject:Date:Message-Id;
	b=vYsQY2riBWkmGaO7770GZDHqylL5YI7Sm7H92HHx1pjBgW2wcjvfaFWC+y77KLjtx
	 FqpQsiY53GaCcszGWEZwouWSWNUqfZAAlcMq9OBjm2oBehCEjWMKepVlLbrcImApVK
	 wx1bZW4iQRiutcsAZPcnAdIvLNGZOqCqYaDMrz6E=
X-QQ-mid: zesmtpgz7t1752820003ta854dc60
X-QQ-Originating-IP: KmGNRB8zsZXB6SadBHY3Wx3w3DveaOIbchoBOWYeHkY=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 14:26:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18356592917221095869
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
Date: Fri, 18 Jul 2025 14:26:19 +0800
Message-Id: <20250718062619.99-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718062619.99-1-kernel@airkyi.com>
References: <20250718062619.99-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N1nOGOj+zup8sZKgPtkkpvi2oiEaPwBax0+hXlyIoAIAjuLrnB4/d9Uz
	3zcowUe097pOTqDERnE6WHhuj9PZOuW0JyxFUbHfms4gvboyPuECOb1sxn0xeMIU6BoD6ZX
	GeaizEWNvCnXR5WmmJA6BpKaA1/9b/7IBD/If/crVCVV7qrNpFgULWwMIHkvy1ElQ43lbQh
	jyK5W6A0RngtNwGgpKGLDfVRAkug+KwjOk2HozFbBrlefl+9ZvRJ0oLXy5KBxOsqUja3Ln0
	GMMtUKgEts4YyY4uhlyXKfekgu1hRgBgF5Ew45Ux0itZvVHvLAyXD7/uWqUvLAkew6u2q+c
	4MJ3pu4j8GGi1gyZSU32YTHC7CB7Y0aoAx+KsIcELMSUdcdG61ZB8i/XB2VMdJ4AKTeFLPy
	7VlYsHAqK1GLsCoEFFYAvsjeWQvrMU8HVFyrfu3fkn6jifxI8qjsJ/YB7CFgXp8np+5LFQ1
	rCZ+ex0UZllOUuRWy2pA77C5x98qtb4+TJa7hTRxAs03QOm4r0j5YyW9vqjQ2Fg1yiU9Qxr
	djIba0mtCqsSssRBVY/pSX/eL1B+54y/9wJBvYDBYvdF6oSjgg/8sB++BWSvzOcNb/KLAkt
	3E1Yx8kO+WyiH2Nlt5KW+XeUsnY7TdDXGbXOvrjZyDYBrMt4Q5KMKHRFGPK5nQbEnRkB7Wn
	kYWgaQpvhkJXKbTlpcH+idTj29DzilCsMWeaacMV48REkv0jIXWFC1MOcDbyCCOFPefUGdZ
	W3uH/UfeZav0gHHX/zp5MRjGhyOjJh7OhAiay05cVXx5FIyZb56UvF4IyLcz1YWPO7UvX6V
	FeJkLRoTmtSVgdTrpZk3NIa5dLTXvbGkI9swPuc4kd6bs1RRNsSJGDsBShZBQ7nPjVYCb8n
	TO6JKMBR/sr/zsp0NwsLdCPR3Bjzw08A5UB4ddAqiTELq4B7ZjhIcWr6k5vWYevDfFUf+dS
	yY4j5+VGXZILugX5DHfMsI5fkJMO1shYpvQ5+jOvWMlcZ31x0WVrWswUp12bPd+5Qjw1U85
	/e59CYBqm1phbwk/zy
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Changes in v2:
- Add endpoint to link DP PHY and DP controller.
- Fix devicetree coding style.

 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
index 70aee1ab904c..997b822a57ff 100644
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
@@ -341,6 +368,63 @@ regulator-state-mem {
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
+
+					usbc0_orien_sw: endpoint {
+						remote-endpoint = <&tcphy0_orientation_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					dp_mode_sw: endpoint {
+						remote-endpoint = <&tcphy_dp_altmode_switch>;
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
@@ -354,6 +438,16 @@ &io_domains {
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
@@ -400,10 +494,48 @@ &sdmmc {
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
+		tcphy_dp_altmode_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&dp_mode_sw>;
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
+		tcphy0_orientation_switch: endpoint {
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+	};
+};
+
 &tcphy1 {
 	status = "okay";
 };
@@ -461,6 +593,7 @@ &usb_host1_ohci {
 };
 
 &usbdrd_dwc3_0 {
+	usb-role-switch;
 	status = "okay";
 };
 
-- 
2.49.0



