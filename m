Return-Path: <linux-kernel+bounces-749145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2528B14AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958BF546AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF882874FB;
	Tue, 29 Jul 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="d3kE2Exq"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD928724F;
	Tue, 29 Jul 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779701; cv=none; b=X6vhyL5dQiPt9ko23iKDAvayd8t2MgEPw4npC4DWvxcHrGYbr2AW7Ok9/a7Dy+ycaKgbF26Sc4QGUGgOd2UJYBDy2di3P8dUAbBBpE7NDWEqXznmqPN2gvcHA7Zo1ImZ9aMhFarIRSLL83mdNU9Zo7oejLbBr88Bzbdxpj8+0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779701; c=relaxed/simple;
	bh=pcrpufKXiwpLeztAqfrGiC6oceMtOOt8LO5zA+Q97Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DADrhFaOOxcWQh0IRDn6TGNkm+heB9/0W3ELr/UCaCUgZHZE7c4+AFNwM5tPnegI4XcPEEW06MLNj5vikj8eA/5hUarm7lSxbJPs4xyoIXLhSjShkHDvNnBz9d6yhR+XjhUDVOmae2JsrFgupRIDgy5HCXfFZFhTH56GfSFYuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=d3kE2Exq; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753779665;
	bh=dtZ8M9ETu2w0tZGRmT7fZPAaZFUL2JXhMvCbISuY7ec=;
	h=From:To:Subject:Date:Message-Id;
	b=d3kE2ExqE0y71lJxb6+MrK441CjkBOb4lsga4nAYSF2DqzYuo11T1K8igF1UVW0k0
	 8Iwni/SxQNSWm6AOaJc+lgfY2OMpCxvw7CENaKRsl4Y7MZBWljRKc55L0tUElIUGuf
	 26h5IcKzoU5LvhigWEWStvOi31aG6PmTtQ6HbMbs=
X-QQ-mid: zesmtpgz1t1753779658t6c34df16
X-QQ-Originating-IP: ccvnQl2r3lBFVqXjPv6mrz6606tw2gXyLioL8U8B5zk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Jul 2025 17:00:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5067649708474818546
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
Date: Tue, 29 Jul 2025 17:00:32 +0800
Message-Id: <20250729090032.97-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250729090032.97-1-kernel@airkyi.com>
References: <20250729090032.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NXAwOXNh0CeG7jbNHxcElhLVrQfFYAhqdTEs4V/ZTJBVwCx78nClAISt
	87x66kFyoY2+adZbOH0TJrpSY70cn3c8JzkcDdEVpPvOYBr4sMNodopvpjQa1iGbIkYVMYh
	ANyNq9yd5G1YavWHVwzlG83I/0+tuDX53KtUlvzKfEHprVAscENVEp0/pQET801+ZeVo/99
	kTrlSeR8nYunJahmpIxoHwT0XnapI3SFd8y8frX+U1vxD+HHSkReXK1mLPc/uvwwZ7rmVqT
	ZMvD98EFe4IbDCmiTtasfklY3LLmlpLmTusKhI86xbH6MOueKHPU4BPObDSctlM77AZHBCZ
	g3R3nIrlgZpFciyAKrsrm7F+duztFHUu/cuE+PJwk4qckjPYPpdYo3S14PStSocbl0nDT3r
	K9w9EkSvuySdf6F6e2uTBoHmhOG/DaOTHNgObHTv9/c9s0O72dYtNTfdM9+UQmvqwGDHndl
	/EHAlG9lcv/PvC12v31+y5ze1IpfCgzCX8LL2+t7rVLVA2BfbBkXNzFuDxVpfE+IidGz4qa
	vCElrqca+fghYJu6u3UKkoPp33kcGe4102PP+LKJokjjxCKYM4v95FOMemVITHBhyC8YF2A
	uC+64zpT+3Vj8/iVtcPJyvLKhkH0r9n3dueRwZt87LvPVYE2CvkYNEefu+nxJBMHgpY2eip
	oZbZktGd4v7T/Vn86VopyXg6K/Ja2vYi3m+NLk6DcFOMCX0soA9MYlruujE6r09WzmrOhCM
	9bYwZ1tMgo4Z8umYhitW5/NFvvO+3f7hOc8qWylk2vXGmDiZUynGhV4h63xouSacnwWSuwl
	U1y+juTgzE1LW2an7KiCDHiEwQ6KO0zQZOAR5zIbfvRQ9dSpviTiQH8ygpRQrsYM+GkAkvI
	Zyi+JKnHLHX3pPDicPWKVpXVmXZ/KTyagxAO/y3cUUm/50ZHyCaKF3LKcRmlP0mYoPSsr/s
	lSkxQVwVh3XwOSZAPg/9+ApZEfXt9b87w/D+YhNzDyafTqZBxHjSkYAD0
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


