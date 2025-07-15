Return-Path: <linux-kernel+bounces-731730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466FB058B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CE84E2AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3E2DCF76;
	Tue, 15 Jul 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="oTsGq3X4"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFB2D9EE4;
	Tue, 15 Jul 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578729; cv=none; b=eMLT7+W74wWr4T4JFzxeobdnRqKMH1osfWziRPBHHTu7nBGa4i1ZHMljFQEetfNQ7/Wv9QcWD2rFD4BWt16Z3q0ugdvULkU6teVWIH7V3gQl5doD689SYR5DwbjlcuPVrzx8kP5pdt6TY6rqvlLnsSHnyYMplO8/0wPMk4qdqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578729; c=relaxed/simple;
	bh=9rlfFkpaGE/xNvJ6Q/+q4wWQK5zz/tQKZ0BYTyxV1GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ccI+Eho7vaqYC3dySAJlAsiGjteRu3lLmoi2PX0Cmv+/OuwHoNXu/giU86+aWJ11OK3W5gWWCcguKjCpRpSMv3yFpq7MBhjZHeZKSLkcKr/snIIBN09n8H8l2suOBL12p4D43H31TqAi7exber5ZU4E0pXGbc5hpVYsA92aop0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=oTsGq3X4; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752578722;
	bh=7XLP8/2EgWjHsxetg5+9fnw9v4HpdEFPJtMEGTR/Kxc=;
	h=From:To:Subject:Date:Message-Id;
	b=oTsGq3X4Qmo9xKb9GmhQEbVxlFmjShxns2jMM9L4z6lnDXiBJ52Q2J1XvIbXQcduB
	 SGQHhRQqnSEFblu6756iv2BZgaZOgjqZpkg6/r1Qz46KGoN5UIoWiHJriqzKZd4lfx
	 HZ+Os9rTY2V6FpZEvTVi5Wo66m7X+1qssG/j3Uwg=
X-QQ-mid: zesmtpsz3t1752578721ta9aaee12
X-QQ-Originating-IP: ziPpytnZRUvE2L1gAOs1LkViZuJVWgTk5QV/nyGdLmA=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 19:25:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3805871955137023780
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
	Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
Date: Tue, 15 Jul 2025 19:24:56 +0800
Message-Id: <20250715112456.101-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250715112456.101-1-kernel@airkyi.com>
References: <20250715112456.101-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MdoRYM9mYrydyPm0BSyRKlE7e3YoDpl5S8t6pg10+rU4hQ7g/4vTYN06
	AeUB1eQkWLSZIKg/4e6LIxlxtiBq3TySoJqedUr1QcDdYsH7ZnIO9I1GYHQTvIo262ZRr/8
	/PV4gdmIqz6SxkU8a2r0AkYKUvksrB0EBmLLsDO1726JZ5lCzKNySAHrKm6a0uUW9zfm3xY
	Bz4D/pHsHZ6YcrAVAuVw23CCJPz5tHc8hP3phthmWnP3IQPfrYSinB6zZz8tSHnv+uX6UzB
	jozotE60rn1Td7L5rAG9RmGfbKRd8mEvCc6Lnav7uKSYF+CbdDrd8vBJOuacd/5vdA8idJg
	APOgsjV+YvvAYvSbDqrM4CkUmqCbZoiIUWXLup8np5ncxCUeO1Tua6yrXbY9OaW+JyaA7tV
	XkcaQBh2FGZC2dGNQ8gK7+yzyzeGxdGy4NKhf3leJJXijtfO2UgEoVRmy0Sp+WVlxRnG5xY
	Ju0dpeE2JAb7A1QCVJrtsIjC4vJph2K2Jb9E/j+kXQSOKB/zJme01+uLFga6aFtzMIs1Eku
	uM7q0yMOihcpLoXuPT+gIMSpBU7Bf75L3a2mCb21LxJmNQZ+nffFlaHaatPoKoJ3O00ZDjo
	XPyrj/UB3MC4RPl5o47PPSrurchbSIe/b14im0c3/u0u82qz/38CtF7FjgTZcndKFAEqEcj
	/aRWir67gjU08G7IrqdfjCDYpU5RYt8IwCi/aodSAocNp+7fAPW48OttNiWy4ImNRHbZ5Gm
	r6KuOQxfyRRMCfIAO9Ab6pJO5N0YUfYWlWoDpwwSnWeTY+DSSbtu2DVx+82hjFr2cJBhgF4
	ATxcXmndmFSicy+hkQKqGiInOO5a8Umg0o6zAQdaOVfiqRLnq41S+/li8ZNomBGlAFUNzCT
	CywA8PJoJsZP5Sky7qd/UFiJj8vs9G6r4lYD7sEV8Ga/2bPCJCk0seZPr9x+Xi8e/Dq74w+
	5YB/pdL5bwtHXloIlUjOzvceS1bjTTTiTSqPAFfxB9YjnAf/tuhiidNms
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 EVB IND board has a Type-C interface DisplayPort.
It use fusb302 chip as Type-C controller.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../boot/dts/rockchip/rk3399-evb-ind.dts      | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
index 70aee1ab904c..9ceda32456a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb-ind.dts
@@ -4,6 +4,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/usb/pd.h>
 #include "rk3399.dtsi"
 
 / {
@@ -19,6 +20,16 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	vbus_typec: vbus-typec-regulator {
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
@@ -29,6 +40,16 @@ vcc5v0_sys: regulator-vcc5v0-sys {
 		regulator-max-microvolt = <5000000>;
 		regulator-min-microvolt = <5000000>;
 	};
+
+	sound: sound {
+		compatible = "rockchip,rk3399-gru-sound";
+		rockchip,cpu = <&i2s0 &spdif>;
+	};
+};
+
+&cdn_dp {
+	status = "okay";
+	phys = <&tcphy0_dp>;
 };
 
 &cpu_b0 {
@@ -341,6 +362,66 @@ regulator-state-mem {
 	};
 };
 
+&i2c4 {
+	i2c-scl-rising-time-ns = <475>;
+	i2c-scl-falling-time-ns = <26>;
+	status = "okay";
+
+	usbc0: fusb302@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus_typec>;
+		status = "okay";
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
+			displayport = <&cdn_dp>;
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
@@ -354,6 +435,16 @@ &io_domains {
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
@@ -400,8 +491,35 @@ &sdmmc {
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
+	mode-switch;
+	orientation-switch;
 	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		tcphy0_orientation_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+
+		tcphy_dp_altmode_switch: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&dp_mode_sw>;
+		};
+	};
+
 };
 
 &tcphy1 {
@@ -461,6 +579,7 @@ &usb_host1_ohci {
 };
 
 &usbdrd_dwc3_0 {
+	usb-role-switch;
 	status = "okay";
 };
 
-- 
2.49.0


