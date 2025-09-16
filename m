Return-Path: <linux-kernel+bounces-818332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CEB5900C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9371BC2A66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D67328643A;
	Tue, 16 Sep 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Yqx/j/r/"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6F215F5C;
	Tue, 16 Sep 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010167; cv=none; b=ALTiyPDyFsrlojqsZsgja8RO88/kGVuZ3xWAv3KFK9gE1iy6zWlK7CJjbARy9ozS49+GFblD2TgCylZMX9bV5+VuRyee5aRNtoK8tRlqwo1lLVlywgIN8ugd1IXEPWAQJnSkpm8pHAZBoL5wuHNhRc5U9YjKIazoWj37N4EZqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010167; c=relaxed/simple;
	bh=zCsQM74xxQ/YFa9HAgDC9C0C9+24BpvrEsptMKAGWtA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tdLqDuXMmqFBT709BMSWySIwQ0VDHE6kpmHNj7Hi59fgSqtkmnmSy7BDexKLOs1l+2SBvr8yn6p7+MfMDCDje2+Jj0t5wR7/okZWt503udAU5lfV7OPxCiBmNWrYcPp0931qKy9YxhizpA9c/Uc8pqpN0p1woTH8yq776iIUitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Yqx/j/r/; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1758010089;
	bh=hnz1bmTaV/5rTkG6fQYUXPwPMQpIN6l4+8uksyKRibc=;
	h=From:To:Subject:Date:Message-Id;
	b=Yqx/j/r/sywiY6HXX33Um5SkHpij9EiSfRnVjL0jzZOrY2k5YlP9a7MpDWWpSXBCB
	 EpgcsOZ16fV4MN3cp9emjGUtUt5LAYeDsQjtc7FACM1CiCAjHdh2UNcPzwghmBCN/O
	 x8DYrslNVj6/+mUbE7j2B6C9wvEJPX7RTcpJCNXI=
X-QQ-mid: zesmtpsz3t1758010087t3fbefdff
X-QQ-Originating-IP: /Rz0qBK4PaPleHiuURFFZblXxEBkxSyRKTOxW50+KgI=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 16:08:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1933021998724514567
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
Subject: [PATCH] arm64: dts: rockchip: Enable DisplayPort for rk3588-evb2
Date: Tue, 16 Sep 2025 16:08:02 +0800
Message-Id: <20250916080802.125-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OYM+rvgdyOKCfzKs2hBoZ41UqiVw1szp+Uvg0bdOZNWRXiTfIrvq65Ig
	/ptJtjWX7z+PfjPWbYpLJySNp4qy9HTM/rHj0pV6WBWBvovoJ32LlpYITquyi4lNouCtZSA
	b6NGWtbhEzmx3NrMuyjMwtx29lieFCBzmmZj/H6pmz46i8WgEBdE4tyXzUf+LjMFBls9Nbp
	8ODzFrzdZ/ShMUFQvim1nUVEoU94FPjv02pXr3xiv+f9ZAuTEy273RwQVwju8savNdJaJK5
	J6zL20sLestjtmxugzNRlKIGOhwgn6t0KjpVlWZxnbJmCFk0rGLm++rQzMXb6atWFE0DFjh
	SE00FXOq3X0i9dhrSrUr7uw8k2K8QcyNRg5xYEkAu9ymjhvm6O/8kcS2+0mDncvUJFpyVy3
	s02+M520kYKTMWI8/4e95d5XZOQhccDnUYvZUglwtrjUU3uVuioDTeR4vDDwNqAYSQ5xF2r
	rrfubO20dborA39qadDADZ1btectN6eitSOti05GJneHVGvXHVB4Ro4DN6yFnmbY5W7EFI/
	jbuOtWsgwG5c6hkPSPyOaZf7AncQP6PSsERT5rjEcnxofdHXEi30/IHJtSRHaEUogvmeLqx
	gb/j1YPW8wMandPRp3FSO08mZVFzqGHOIVUohoqQ7vlRxvn9qD5zoQ8Q41taeUn7YUZxftj
	8bsby9+HfLW8erpzpWz2JcG6ZMMVU/0g3hu1bdNumwgt85ztTX0Z8otsOJ+j1gBTCRoYC+a
	n8j2lltEk1ZXaAwtfjjUfJTnz/pxZAsCMKrHU4YpyqX1O72z+THIo6nhIS21EsXXyGQ1nnT
	8Hz53O2PEJBFOqZpSKkg3oXGTVfdZt4PmFVHlbLKy/puALErIxte1H8mX65rVbuphEjHvjq
	+tpnpX3TFuLrKPOtcP8ZBTOYXgI6StCQQtmdoz+ey0IF5UQ8O1DELDRjGno/JDuyRw1mdkg
	nPZDDqy9OZCeQ00bcFJuuX2A1GrWEPIzrz0jfMygR8cyaTuRcJzBDQPIMPHF/Dl3lyRo=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
 .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
index 91fe810d38d8..0e5af61f66fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
@@ -25,6 +25,18 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	dp-con {
+		compatible = "dp-connector";
+		label = "DP OUT";
+		type = "full size";
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
@@ -916,6 +946,8 @@ &usb_host1_xhci {
 };
 
 &vop {
+	assigned-clocks = <&cru DCLK_VOP2_SRC>;
+	assigned-clock-parents = <&cru PLL_V0PLL>;
 	status = "okay";
 };
 
@@ -929,3 +961,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
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


