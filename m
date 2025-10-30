Return-Path: <linux-kernel+bounces-878248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42DC20191
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B12B4E70B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64E3570BA;
	Thu, 30 Oct 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="G9F2tw29"
Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427F34217C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828669; cv=pass; b=IhtboN3SfCGesR2unFJAHkqPhCe/WfuTxO/mniPA6o1whuZtka+fnGspr8zWsOOI6C90CXU0kvOQdklBPkLgXMSC8gbPbJxHNWSENt6CvsCiGQGxMsle+2nJpOyCX7feWFo1rcWUyTc1CudGrjanJ4dzh9/ikGYUzCG0iO+w9f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828669; c=relaxed/simple;
	bh=a8HQgogvK4zUKTZ4FzXujcdIdsCm+/5nLbwQ0VbXq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvfMrBuNOafv0qh6if0Suhk9asS5JgYvJETiRjtXERlYcbpsSNzQBqQZuWN1ZilQbpS0EZV+WPIA9lH5KLkRk0ZjZrMLIa7pgPI9lrzrqWBPtEXtXjGOJKxfYOWXsEX3tMCW3vHMejBS859TL2N4flZWHbh/RA3SI3xTRgf7S70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=G9F2tw29; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=PK5ZZtJo+tl9vrIOwQupM3QlXvu4Jm4LnZkxXhrCHtU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828618;
 b=s3SdqDxwBHl7U35s9BWUcFwVZmhYxnK8nbpbHZJ+VjXCX8UVC6GJXJ5kFWFNIS7oveGthOeJ
 V1ZeIiy9WJXWzwEdJzQxslNAFIxi0keWmqTOM5LfWJDB8/qcdA0YqZzD+GUa3+m/WdpXiWuaams
 Fo9hed6VdETyRI1ftSIqFXK8XDmI1qE4pbc9XIS7xjpbH/WOcqBOeaUn7ZRYHxgwD3GvPhazEVA
 KE95ArzmzRKW0nDTwITIr6GhtiVodjFmq5Tgp/EF754h8uCbDfTThNcLAFoGbBItlwteFkRHzpb
 +J5v+nj+XOfMBsQaRnQ7Z79hlIoGDuYqaX0ubD2/PXrkw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828618;
 b=UWAjxVL6FxMFkwQllV5kuq/h222ksiBL0S7/DqznJm14rGPkSenCVNJh41xpKF/19FC2udRj
 bQiPdBt7q602G6Tt2w1tvEDr00MwenYldvAXcD0xTk997sZokgGKLK3FsVk36iFWvcSAdsEO2Cp
 L57UksXpgS/CxdRJGcRIVmfc2O25Ag17ga1iUYGfBFPbgxOyGj8SLwra16Y1+0Vy91Z7rOot1Un
 6l6ayOTplAqB3TUDc9Yc0+uoqt8KAUJhlR/Yc4+EUqBfh5bwXpoaTbi2kZYSr4chQ3xZ0Xj0eve
 h8Fi/Y1GNTd+XbrrbyZMgznyutTSIPhgYlxV5nn6lXSQg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Thu, 30 Oct 2025 13:50:18 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 7E327220D26;
	Thu, 30 Oct 2025 13:50:00 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] arm64: dts: imx95-tqma9596sa: move pcie config to SOM
Date: Thu, 30 Oct 2025 13:49:15 +0100
Message-ID: <20251030124936.1408152-9-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4cy3qF1SYTz3yc2t
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:6e315f0fcc0e47734d335f45771da7a3
X-cloud-security:scantime:1.865
DKIM-Signature: a=rsa-sha256;
 bh=PK5ZZtJo+tl9vrIOwQupM3QlXvu4Jm4LnZkxXhrCHtU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828617; v=1;
 b=G9F2tw29AUWMv3xhMXl/xBO9QfDQYlVAG2j48Zu2taI5Rdqo8QiesbGRDvMv2YT+2U3xaYp+
 FGQ5Vwv3VzNJ7n3D4A+OnW0BFof1HOYqLNjvEuutQ0D6uLrZxGbfCDyWdKWpqHyTJQChT3KOi7V
 xaBbKOo0l/Z8RRc34UmH8q2C3yJArQxPoEyLBhDlgmblYHjKCkKibKjSFOiQ1W9qPEd1c5CEGPf
 D+9TmBgWYeDlUouAri3/LYlEusjFxqU/Xl0X689r+111zRNSAEx5jJFvaV2FAhG7CLXnO2JDo/x
 lJFmaQorshS2L0F02g6nH8YVV3+m0IU9zWdOf/7pItVSA==

The muxing and other features are mostly determined by SOM, so add it
at this level.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx95-tqma9596sa-mb-smarc-2.dts | 16 --------------
 .../boot/dts/freescale/imx95-tqma9596sa.dtsi  | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index 5c94d8cf28c4c..8caf0c68ba9fc 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -225,27 +225,11 @@ &lpuart8 {
 
 /* X44 mPCIe */
 &pcie0 {
-	pinctrl-0 = <&pinctrl_pcie0>;
-	pinctrl-names = "default";
-	clocks = <&scmi_clk IMX95_CLK_HSIO>,
-		 <&pcieclk 1>,
-		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
-	reset-gpio = <&expander2 9 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
 /* X22 PCIe x1 socket */
 &pcie1 {
-	pinctrl-0 = <&pinctrl_pcie1>;
-	pinctrl-names = "default";
-	clocks = <&scmi_clk IMX95_CLK_HSIO>,
-		 <&pcieclk 0>,
-		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
-	reset-gpio = <&expander2 10 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index e7edeec712dcb..832c753abcd75 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -391,6 +391,28 @@ ethphy3: ethernet-phy@3 {
 	};
 };
 
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	clocks = <&scmi_clk IMX95_CLK_HSIO>,
+		 <&pcieclk 1>,
+		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+	reset-gpio = <&expander2 9 GPIO_ACTIVE_LOW>;
+};
+
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	clocks = <&scmi_clk IMX95_CLK_HSIO>,
+		 <&pcieclk 0>,
+		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+	reset-gpio = <&expander2 10 GPIO_ACTIVE_LOW>;
+};
+
 &sai3 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
-- 
2.43.0


