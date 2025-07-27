Return-Path: <linux-kernel+bounces-747218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AFBB13112
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5BB188772B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237E122B8A6;
	Sun, 27 Jul 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Tmq1r5Vc"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F92236EB
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639417; cv=none; b=W1vZadlPEyMaHy3CZGh1f3X/uWEWr2CXfmy01dJPk87XeMxY1dYiUqOvMEmZ+KDVLWVXPWKUQPS6OIs2Yh/F1JvLuw3A4EuTsrNFnJTW3ui4J45NH2jL1nsOr3BtoTP7otRwY9HEYtWjJVty+nhL5tQ2TRdge/voyvaShsMrfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639417; c=relaxed/simple;
	bh=WIxZnDfBjy3+MWbIUs96xiEYfrzW7OIdSfiwwszp1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NORpYhmSVQiUh10F17mQ3w0xpPy6CCHxhAXLf9HMM5h49RGUY56BRSjQFVHOqKsOAzqTB3qsV9FSxfjmU0rscdf0dxVMrsjSptkPHrkmW+WW7dNo0nVCuGJenmkJ6fqLvJk1JHQZ6zFITJ56OhgHTGpc4iNMXW0Hx9saS/N6qUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Tmq1r5Vc; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753639415; bh=EeTBhSz8vgF+IOB9tNLiutH2dTp1nA31ocl9xEGhTRc=;
 b=Tmq1r5VcyfGuayV2LqXYS7PWy3TglYmwgPOQbPV7Yru/G7xdA4xTmOG5G/84OQcHataUdAjtW
 hVWznTXD3rlBVkii17Gqt2Urhsoh9hnKL0vaoiaC0vciiqAVc9yl0IjDlcbTPZeBodBD/62y1N5
 xQI0Tws7hgKoLS+SeLRc611y6mGQuOicL6Mg7Y/tlIa4K4ACMZ+fZLWUnF4mPBDyak+C8cHlb8/
 7j5Fxy3iU3Z9GYImoYAO/4j+BZINQRCXNz6iBFP5J5aT3M90R5XGf1ByY6ksdBI4C2Xb12aqgxr
 JzWvCsarlIFEWLAgYxPInhNVxcjXNQ86oEgPz3nNesRg==
X-Forward-Email-ID: 688669eec509b9ee169cf33b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to Radxa E24C
Date: Sun, 27 Jul 2025 18:03:00 +0000
Message-ID: <20250727180305.381483-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727180305.381483-1-jonas@kwiboo.se>
References: <20250727180305.381483-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E24C has a Realtek RTL8367RB-VB switch with four usable ports
and is connected using a fixed-link to GMAC1 on the RK3528 SoC.

Add an ethernet-switch node to describe the RTL8367RB-VB switch.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
and only around ~1-2 Mbits/sec in the other direction.

The RK3528 hardware design guide recommends that timing between TXCLK
and data is controlled by MAC, and timing between RXCLK and data is
controlled by PHY.

Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
seem to resolve this speed issue, however dropping snps,tso seems to fix
that issue.

Unsure what is best here, should MAC or switch add the delays? Here I
just followed DT from vendor downstream tree and added rx/tx internal
delay to switch.

Vendor downstream DT also adds 'pause' to the fixed-link nodes, and this
may be something that should be added here. However, during testing flow
control always ended up being disabled so I skipped 'pause' here.

Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schematic.pdf
---
 .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
index 225f2b0c5339..26754ff7f4ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
@@ -196,6 +196,7 @@ &cpu3 {
 };
 
 &gmac1 {
+	/delete-property/ snps,tso;
 	clock_in_out = "output";
 	phy-mode = "rgmii-id";
 	phy-supply = <&avdd_rtl8367rb>;
@@ -368,6 +369,60 @@ &mdio1 {
 	reset-delay-us = <25000>;
 	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
 	reset-post-delay-us = <100000>;
+
+	ethernet-switch@1d {
+		compatible = "realtek,rtl8365mb";
+		reg = <0x1d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8367rb_eint>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@0 {
+				reg = <0>;
+				label = "wan";
+			};
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan1";
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan2";
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan3";
+			};
+
+			ethernet-port@6 {
+				reg = <6>;
+				ethernet = <&gmac1>;
+				label = "cpu";
+				phy-mode = "rgmii-id";
+				rx-internal-delay-ps = <2000>;
+				tx-internal-delay-ps = <2000>;
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		interrupt-controller {
+			interrupt-parent = <&gpio1>;
+			interrupts = <RK_PC2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
 };
 
 &pinctrl {
-- 
2.50.1


