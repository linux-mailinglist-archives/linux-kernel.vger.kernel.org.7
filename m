Return-Path: <linux-kernel+bounces-823191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263FEB85C30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCD27C8372
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD96315775;
	Thu, 18 Sep 2025 15:45:11 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071B314A6C;
	Thu, 18 Sep 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210310; cv=none; b=U83r5P1NrBFVXAlPjEsQPmPrc9CYrvjd3ZGRecKdGVFJJ+ucPdR1Fsd621WhQlblSk2494T2BMo2PN1PvaU9VMTM3JigZrfWsJ7v028gjkOlKigmTFUD49CF68onW0TyabbThp2U1T5EhpiFYKTPuQnMLjrsW6aeQ7vS+ULgehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210310; c=relaxed/simple;
	bh=cWu0cfgd0FkeMoYqnPte0uTSYcAjL7fMLOhaAJqTcAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QG7qCGjzxWLFMyXhPU1iO74XUodF32jtLeO02obDfOO9ez0C2KsOgIbZPeAGLin8m4a906JePfDdsunS+4MiVUOYnjn/hhxzBaNLoS01/Z1/1kUgo52BMTdxrMP6yJaP9RpvkAbBItSu++8xnKP+KZnPZy0lcEOLwdz7GLjJc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uzGoZ-00B1eF-3U;
	Thu, 18 Sep 2025 15:44:55 +0000
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
	Tim Harvey <tharvey@gateworks.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 2/7] arm64: dts: imx8m{m,n,p}-venice: disable unused clk output for TI PHY
Date: Thu, 18 Sep 2025 08:44:46 -0700
Message-Id: <20250918154451.2531802-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918154451.2531802-1-tharvey@gateworks.com>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
v2:
 - add tags
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


