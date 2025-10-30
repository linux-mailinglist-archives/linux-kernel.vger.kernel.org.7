Return-Path: <linux-kernel+bounces-878243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAAFC20185
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFD4134EB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C943570A7;
	Thu, 30 Oct 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="UuPuOMvu"
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73E34214C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828668; cv=pass; b=rQHwFCkBsg+bpGnNCwJJnwG1Ut9gGCShzeoDRXDqAk4npYZ13PGsLRYmXTd8CohlkeDJkaanAi69qnX4ZnvPcGUz9MU4xQIxTkgGIL7mQViXq9t2eegPnMJa6ZsSKtjk778d3TOaLqXsGCMXakjLNsOX56qhpRWeofMo535sa/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828668; c=relaxed/simple;
	bh=MxFVFohRZKm6vYmHBOWCpbni7KD1iEQ0SAmlRMH+Sfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2t+y/Ab02/S60XEkPDot8FmLbM55fAD+vGgLFB9SvM5U5C9aE4PgfpznaFjJWHHWCXL3sMjtlkk5e38QO2VASwsI5VrMaeX8j91O25uAv4RhOWuSO/Eoei75TX/SCNCDiKRSPwmSNLm63x7LsXQhnWsshN9w75eh3A57SEXNY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=UuPuOMvu; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=dJM31IhVnkrhRCrb49g6ODItYSKCRzC2GROjcDOi1x0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828618;
 b=rWHHFJ+8sn9YlyKYJi0ItVPrWoFX7I9pcMKDtWaogbut7tTWtGm9AZkCVVXuTSRi7eu0Z9B+
 RhnNnOu9eJvnF7JEK58sdKQAi9MnVno1TcqgiwA7qfkE4AHB1HSruLdoEJbmQ71ydIWZYU26lT2
 sCtVRTOVFvW9zH3qKsp4VZ6z35MzRPTe2F7y5JoW2iCG5CAp/8GiOPAMB0+qSeXocM9hw7H7Kst
 8unOtcZTegqspQpAx5UsYA3b5nylyBvUQ3G0wf8EJomcpjmCzWEo8Qog3nfzmmFF11rbZwUAjto
 vwf6dyrIdG+DnKcjda1F5Nlnqr1O3OBYXs1KvmUgCk2YQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828618;
 b=Aj9ZWyOIU0wpi5mZ8l3DEV6JXKdtL/JlFmG7x2ic2NXkVxUbsJUl+sa1yKjOrTJ9oIC7P3UW
 rc3xdPHyIGxCqtbbds9goS/uvaxSJbdXPPm47lijKXPZbs+F+a2tFQiJOJM0oX/p1scA7Nhpzvj
 4g4Qvf0weWiNpfdd+BA4jhen7trMlsbIu2qwJSViwKEqPoPsBHEgOTSejRWJvtALv/2/Iqp2Odc
 omwZAxZlVJCVLXVc0ePp9bOpO0X+W8vOQmytVnQzXJ8ehD8kxfP4msVNFg6AT8vSafZW2GmNCjZ
 ULyYTIyoEa+ayKImk22X0AShybgpOpgiQxR362fbVSwxg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Thu, 30 Oct 2025 13:50:18 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 9F4B6220D37;
	Thu, 30 Oct 2025 13:50:01 +0100 (CET)
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
Subject: [PATCH 09/19] arm64: dts: imx95-tqma9596sa: update pcie config
Date: Thu, 30 Oct 2025 13:49:16 +0100
Message-ID: <20251030124936.1408152-10-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4cy3qG2sY6z1kNh4N
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:0baac1aa37dfad4f2d55415cd4bd5fae
X-cloud-security:scantime:1.795
DKIM-Signature: a=rsa-sha256;
 bh=dJM31IhVnkrhRCrb49g6ODItYSKCRzC2GROjcDOi1x0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828617; v=1;
 b=UuPuOMvuh2AiJvqWTDv+JDCmj1Rl9Yred64JoY5JlViWT9vISI+xhYco4oJpA7K223hqKdyb
 BQ8cHZI3MyZb0eu7TtqS88L/HP9IhUT1slqSivtINRa0r8nq6p+/H+rdoruWIuCyVMzKcGNjs6o
 YetP2y55QOenn5RhFHAvOtyo5fj0NdWqmA3kY/HJRzS98HjnJIfExvH337Cn5/x9a4F5xc0i8+7
 bjXUj/cucP3oNb8seexiJP7Ol9M/P1MONUaVaMJDEnmkIpQ47WeyGSIOxMsIuaB9WTmO31cvXeS
 +Nxup0spr2Jehyv+kaas3Yc7hgKyeRIUVOVgVOblqvv8A==

Fix pcie clock config and switch from deprecated reset-gpio to
reset-gpios.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx95-tqma9596sa.dtsi   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 832c753abcd75..36da8ff8d1835 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -395,22 +395,24 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
 	clocks = <&scmi_clk IMX95_CLK_HSIO>,
-		 <&pcieclk 1>,
+		 <&scmi_clk IMX95_CLK_HSIOPLL>,
 		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
-	reset-gpio = <&expander2 9 GPIO_ACTIVE_LOW>;
+		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+		 <&pcieclk 1>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+	reset-gpios = <&expander2 9 GPIO_ACTIVE_LOW>;
 };
 
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
 	clocks = <&scmi_clk IMX95_CLK_HSIO>,
-		 <&pcieclk 0>,
+		 <&scmi_clk IMX95_CLK_HSIOPLL>,
 		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
-	reset-gpio = <&expander2 10 GPIO_ACTIVE_LOW>;
+		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+		 <&pcieclk 0>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+	reset-gpios = <&expander2 10 GPIO_ACTIVE_LOW>;
 };
 
 &sai3 {
-- 
2.43.0


