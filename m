Return-Path: <linux-kernel+bounces-822139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54EEB8324B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655E93AF302
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D42D7D2A;
	Thu, 18 Sep 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="tvE7Qzll"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3F2DA742;
	Thu, 18 Sep 2025 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177012; cv=none; b=O5NnA9TdNdj2+CK/29U4Reg+cLHCC2vMnlwc8LDFNf2446tD1MLlK1218Xe6B9nRBbyhAjNU/aCzOUDHQ9XjT/L5hRTHU+3vdnuC+941SnzKgmntcBMr+pOfdmRZHFGG3pZxDFXNstNUnqkSHr6EZ8NORmU4ROc4aByOjAFDupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177012; c=relaxed/simple;
	bh=AdY1jni5Z92YDmxLGp/LNmVmPykZCq3X4+GBfc+HmcI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sxkywKNmIo4qij8b7DzooNuq1+XXU7WsCUEsmk0WcJwRb57CnKiOBHrjWC2if5S21YPIYTYhcoMOFlskmd0DyDZWRq9sK0UgHa9qVXqsjtnjC+JDCXHYZauc6O13MFmdj4/+U/e52xFBKuRqjyuttJI+4oN7cKu7TaRB3m/y+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=tvE7Qzll; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1758176918;
	bh=/2S6tDpoUZ1SIuOdhsW6HAwbv5zQFWfuXkE0KYiPT8I=;
	h=From:To:Subject:Date:Message-Id;
	b=tvE7QzllHb28Z1dD6sToqcmx6puNPMjcypFTX8UfjpRQ6++JLSSq6hbDktEMNVyWN
	 cZtygTtSehwoXN5HgMfFNt+NM43Jj/w0OFQ9/c3DklD1BxaxMrG90udcC47uTn8AXR
	 jlSbRnxfSIGjqo9/r4o+z71oG5S2oKr59qYSA9Ds=
X-QQ-mid: zesmtpsz8t1758176916t49f2e520
X-QQ-Originating-IP: kounfVWLm9bYpqAv0zEPs9uq4bYOiCpyxYAp46ogmAE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Sep 2025 14:28:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13016871167258728996
EX-QQ-RecipientCnt: 18
From: Chaoyi Chen <kernel@airkyi.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Peter Robinson <pbrobinson@gmail.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Enable DisplayPort for rk3588-evb2
Date: Thu, 18 Sep 2025 14:28:25 +0800
Message-Id: <20250918062825.194-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MtOtFzEWJwk1a2Yz0B+5e1VkbUQkzCPYB1qYPVFi3facMGEu/b4RuqV3
	FLL0TkPI1mPMPMzic+ifAtREhEdxE5z0EkYFgLRPSjLVjFTCWzl/1cSrJyLvJPbO0kwyfak
	dDHBaHVz/7o+Xkq7bkOdMrN1lbt6pVKIFwPUIopg7ugPekL6q0pY0Qe+TgCAgyiciOmYp3C
	m9AfJzEosYS1OjQxP+DPiNrHa5JEIIGiXAgt0rq7sPB/VXTO5hAFeJUCaUtx2MHrrDXuma2
	dNTDgBMEl8cBMQJoHPZDDnztNLCYtR1uTvDATfHOitEzGj1/x5fsf6rdzjUZRGBOlhkZ2VH
	WNnIOJbDZPaQy0ar5yB5+Gz8bP1bU0KDz2Z+VmWirJQr1hC+0luINy2rHj2Cnyo3MFj/qEj
	gDcc38bKPMo4AssQTUaj7AYoyBQW+CfFE5JNR1E+kPbNl5CRd/qtJ0SQuMC4Z964EW3GrxK
	c0f5vyipEvsa6M2FOp9VCP4XdbJDho1dIDay2kGnV2zTZ9X7GwZVoekm7HDRrg3yNLHHSIw
	UCt3497VpjoQZR6tDp4TPizjtLZl5sZs5GHvsV3kUaAwWix0rAQCpO4+aqqXWgEZpBC6nIi
	ftgTLE5nc1h3H4ajPnOiUfgIY6wIzcUFY4l/iXM1B3IOptBLB4abPmqqU0vZBsepCwJsvma
	K6c8EvR5f0q2iexOxVUaiz2nnfD7hAIQHshaNp6bmUE4hBmWb2Nrg6TevVDzUGN3YpuR8P2
	VQSMMe8/yv1zoJLvW5e1ecbud49rOwvHdfSm1sjpSEKL2oz5ANifFPixjrmXLiOqx74OQH7
	P4MbgmgfaKCUXIVu8qE/bdxno7fl0TRMHqwA8FHvi7v9c05gmzvG4TExtjdlqvMvk8uI0oK
	4bpDekwgNpBJVRPl91dkz4xWL/emE/3uHzgJB57UZwNYx9aLGCzGt34iLQ8R4BUWC8pz+kk
	2ZH0URmE+sabTvL80eisnli42GotlsAH1IitqpPIEGFOtl9tQILfCPz6xTOlL9hLXyOp7Nr
	ZkBE9nvA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The rk3588 evb2 board has a full size DisplayPort connector, enable
for it.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v2:

- Link to V1: https://lore.kernel.org/all/20250916080802.125-1-kernel@airkyi.com/
- Fix invalid DP connector type
- Add more comment about dclk_vp2 parent clock

 .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
index 91fe810d38d8..60ba6ac55b23 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
@@ -25,6 +25,18 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	dp-con {
+		compatible = "dp-connector";
+		label = "DP OUT";
+		type = "full-size";
+
+		port {
+			dp_con_in: endpoint {
+				remote-endpoint = <&dp0_out_con>;
+			};
+		};
+	};
+
 	hdmi-con {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -106,6 +118,24 @@ vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
 	};
 };
 
+&dp0 {
+	pinctrl-0 = <&dp0m0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&dp0_in {
+	dp0_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_dp0>;
+	};
+};
+
+&dp0_out {
+	dp0_out_con: endpoint {
+		remote-endpoint = <&dp_con_in>;
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu_s0>;
 	sram-supply = <&vdd_gpu_mem_s0>;
@@ -916,6 +946,17 @@ &usb_host1_xhci {
 };
 
 &vop {
+	/*
+	 * If no dedicated PLL was specified, the GPLL would be automatically
+	 * assigned as the PLL source for dclk_vop2. As the frequency of GPLL
+	 * is 1188 MHz, we can only get typical clock frequencies such as
+	 * 74.25MHz, 148.5MHz, 297MHz, 594MHz.
+	 *
+	 * So here we set the parent clock of VP2 to V0PLL so that we can get
+	 * any frequency.
+	 */
+	assigned-clocks = <&cru DCLK_VOP2_SRC>;
+	assigned-clock-parents = <&cru PLL_V0PLL>;
 	status = "okay";
 };
 
@@ -929,3 +970,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp2 {
+	vp2_out_dp0: endpoint@a {
+		reg = <ROCKCHIP_VOP2_EP_DP0>;
+		remote-endpoint = <&dp0_in_vp2>;
+	};
+};
-- 
2.49.0


