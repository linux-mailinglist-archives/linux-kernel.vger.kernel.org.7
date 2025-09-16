Return-Path: <linux-kernel+bounces-819224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7DB59D05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB21C044A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D4265CC2;
	Tue, 16 Sep 2025 16:05:25 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18731FEE0;
	Tue, 16 Sep 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038724; cv=none; b=cV5EVgTxl7HcRmtZDGA2XbAwdrjuF72XN4X2CWEZ0XuSoLN/YDW2SOsFaPD1GEjamo1rmt/X4FojvxJ3rUqFedaFVSdACRwkRwMayMiBxX4DfeDGdKCwsya0mowOJPv4iKlnAOIvOtUCmtFRUmiUz+Hy6aBW7f/p9luWmJwv4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038724; c=relaxed/simple;
	bh=WIxP2qR5U1ixkXM68bYaTGvt8gd48mVwHndBGk+yf4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHDfCIsCVk0C2vg+hbndOYkPmgqPOFj19oSnIZHxGfms0H34qr8zq3PlWCydh+S1tawWNvBjEtnYAdFa6f/65Nc+Lvh34sCvM2/1o0T+a/sgjfPpC91KRyHKuu1+rUSJILg6A1flzgh4RpMZZwKGEOchifPG9DCc+ceQIPaReUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uyXfI-00Aysu-Hn;
	Tue, 16 Sep 2025 15:32:20 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/7] arm64: dts: imx8m{m,n,p}-venice: disable unused clk output for TI PHY
Date: Tue, 16 Sep 2025 08:32:11 -0700
Message-Id: <20250916153216.1042625-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916153216.1042625-1-tharvey@gateworks.com>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the unused refclk output for the TI DP83867 PHY used on
Gateworks Venice boards.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts  | 1 +
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts  | 1 +
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index 37db4f0dd505..baf46fe28133 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -115,6 +115,7 @@ mdio {
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index c09b40fc6dec..468c7e993c52 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -253,6 +253,7 @@ mdio {
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index a5f52f60169e..5aa0e2cd155e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -248,6 +248,7 @@ mdio {
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index 303995a8adce..a1232a4f8485 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -101,6 +101,7 @@ ethphy0: ethernet-phy@0 {
 			reg = <0x0>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 12de7cf1e853..7662663ff5da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -228,6 +228,7 @@ mdio {
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0x0>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-- 
2.25.1


