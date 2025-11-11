Return-Path: <linux-kernel+bounces-895220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D0C4D43E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A1E3B0FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAD3557F6;
	Tue, 11 Nov 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="H1wmp5u+"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140111E7C23;
	Tue, 11 Nov 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858360; cv=none; b=sbbet1qPreFDmzSda0qm3LreAln82nv184uEqPPY6qwkwAaby/9EGOzAZBM1SqgeZnxGxN3QsySeg2YTX1khh511XmePQd1Tl6ZxGOoaO9bsvEZk1arVlkHxG4svRcifQmrJuGRgR9SPvKynBwQzjLMnMxpaXevmqmnhvCGGKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858360; c=relaxed/simple;
	bh=gU056Y/rFcOj1a11SgXQ0IMaQNIV6nhU5/yij/2i3qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QFS8xBF/HSz49Wux7aho2Bp0TzmOVewsyySgTrC4zQk6bvtCSrRTOameSgerCOb1s+xSoz46kB1r98zXrkpRIXMH3ppvtojACmE0GZBTkZKtbiA5FGVJQnEWvg1NFStZnYBYYIjq6Qy0TEElT7LO7M/kmygPMT45Dvz0SPyQxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=H1wmp5u+; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858353;
	bh=fg2TKuNBAB7TuYxIVNS/NsLi1w/3kkBrg4QejE4Xpiw=;
	h=From:To:Subject:Date:Message-Id;
	b=H1wmp5u+vUxZRDUoAKUtlMByDH46lMU2OwSdcWWntFv64h/BQTQdoGphKzofbpvpb
	 EWGoaaGREiEed4wi7xtzJDf4Ew4jEp6YUAaZK7JNaqGpXubmFSgrAtNIB7ZYi4kmhB
	 H/LLlhYNx+uDD+NBXpjKi9q4n+WyVaV8Q608AO18=
X-QQ-mid: zesmtpsz9t1762858291te7294ff4
X-QQ-Originating-IP: exeCqqoIeGySwZLpWAlGG7yGEO1UuQ9aEdXrUWr2v7o=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:51:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3148432019982431225
From: Chaoyi Chen <kernel@airkyi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Chen <hzpeterchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v9 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
Date: Tue, 11 Nov 2025 18:50:40 +0800
Message-Id: <20251111105040.94-11-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYz8c2bcbB9MeJGSUhMFJX+QKNtglUuTkBwxriXbkhOkJmswov+ZfY3B
	oCLlY8sNRsm2hv76MYg7rpgseOTtUQWIAfQ0EU5trx7GQpsBAcl7Fr1ELjvs4JRGAdCExW8
	O+Ank2QvOlVAlWk4pvkMbk6jEG+Yfwc10e7QRdHDbENYEvbw5Ve3A6IKjmgbH9Fh1npGSq8
	TOWz0VpjA7StX8n1dHLFGrPwAxzxAMmAvzqCTi3aosy/B8ndnKEfXCuBiyPeu5MjN8bWj6U
	48bI6RtdfG48s2McjQOQT45cLQCOc5W40k32YZfRQ4gcGr15QRGNyE7jaZy73fNQtwEQul0
	NefdWk5BcbdkLFKBtU9uzn4mxC5kxHXWKlnfmkpeLNx8+lbS4Y4zDOODtY3KdAKfeHgiT2o
	jvKGAPDmRxKO6Hz6RuI4RrRc9snK9zOPByyIpwjE6PP75HUG05Cmw/68Lvss+J9EYVC4FFu
	j72CzLtle0FzBo6Wq3RmqX77/DFC4MFpTO2cWEOedHam/50cEG2qK57TNDBP8ti694g+6ep
	p8J6i3kjVRL9w5TE3oOtY4sgnayjeGUc9BM5UQKplI3Hd8zRo0F9HwM7OgtvYr5kn9Jb5yk
	EFKAvpcVgRpNOWTD0KcnannDLD0H7+0RX1M7zMIVaPFh4IoOQjV/LQPnyn70GbOzPray8mt
	jx90P9pjgykFTWztUQunZLK2ssbc5fSpw0fGTFO9BNIaJJyi8X+kMwb9trO90Mc/HpMH1cF
	qHHHGXvrLqLwb9JiFY5HR/yM+wG2SssGkOp1UI0ewgdKXcHiL6+Xsa2nLPomXznR2O541Dh
	imzsh2eT+OT/erA2kA+6eMIaIQpRyMUKPhyy6dcF1t6sT0fEPNOXqIjSWoq7Os1ZWv+EpPk
	VKuN8xWFwlvUE2jQ5DHPSQ2gq97FOA/pqkP5DtC+HH5Uotxff+V1TWsPSk6ddL1tqo9z47i
	N6Nl5GP7AdTwmzFEZsq/7hiWFLoie7sNba/fUuLqENIYaqJ8fkSkns9Y1UbBqKIH8RAPAk5
	ex3RKweNxBx4GrpCUUuCrAWnHxaji3wRVGvuW6Jw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Changes in v9:
- Add usb role switch for Type-C.
- Remove USB2 PHY in Type-C connection.

(no changes since v4)

Changes in v3:
- Fix wrong vdo value.
- Fix port node in usb-c-connector.

Changes in v2:
- Add endpoint to link DP PHY and DP controller.
- Fix devicetree coding style.

 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
index 70aee1ab904c..be1e90f7a453 100644
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
+					usbc0_orien_sw: endpoint {
+						remote-endpoint = <&tcphy0_orientation_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usbc0_role_sw: endpoint {
+						remote-endpoint = <&dwc3_0_role_switch>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					dp_altmode_mux: endpoint {
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
+			remote-endpoint = <&dp_altmode_mux>;
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
@@ -461,7 +601,14 @@ &usb_host1_ohci {
 };
 
 &usbdrd_dwc3_0 {
+	usb-role-switch;
 	status = "okay";
+
+	port {
+		dwc3_0_role_switch: endpoint {
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
 };
 
 &usbdrd3_0 {
-- 
2.51.1


