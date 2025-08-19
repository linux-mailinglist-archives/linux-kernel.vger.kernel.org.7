Return-Path: <linux-kernel+bounces-775470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA559B2BF84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C401BC4993
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0FC25A2A2;
	Tue, 19 Aug 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WTpBHEr9"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFC322C87;
	Tue, 19 Aug 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601062; cv=none; b=WRnn8SDGHolGVO2taWpy6jtxXVXEI5ITqA533iRbOUFi4HaUKzY4RZk6WgBNbjSARaVMx/EeHVXPV8rC0g9ogsBN5QUu0USiNvhREKjhOIVgK4rhOeqtp+x1eHM7AJTe1Z9X6z5ww6HQTmWiv/nE4mDLh/LE5wI+Ne12tLbS++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601062; c=relaxed/simple;
	bh=dTec6aY8R6rLlN+6eoHwcknNrU7Yo8NGR8WXosKAFWs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kzr2r/EjIEmJlHskI+YBmlmglVsTGPctVcXpO9zYyxkyTvxLUOFOVD7T8rHHfquzaumLq0oivQKrDlHlQ96SR3IpV9qOfn4rohNP3PIC5Gf3frxrN1fZH3hYBn2vkjZtKLUjF9zcYysn/GUo9OO6RmOnOuyE48E07NVvQJ/A3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WTpBHEr9; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JAvLYE2878915;
	Tue, 19 Aug 2025 05:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755601041;
	bh=Yih4aNA9IcSfNBRMPy+Nrn2sMcUt3v3mug6AEfsuEZY=;
	h=From:To:CC:Subject:Date;
	b=WTpBHEr9F3yj3/aE4iE2ZWZ8wOfEo/dIenQk0sQd4OM051LXnJv0wiiAcJQj46tWY
	 bN+hFOiY17kPytVwhVlvX++zB/PEuGe2chnbtCnsj4X4OxCM8RbCJspCO2uXSXH79F
	 hiVEXZT6Df0ay8LBdN3CcvsEX+9R3QYjgSJTlh4M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JAvLtW538323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 05:57:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 05:57:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 05:57:21 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JAvHPC2599492;
	Tue, 19 Aug 2025 05:57:18 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am69-sk: Switch to PCIe Multilink + USB configuration
Date: Tue, 19 Aug 2025 16:27:00 +0530
Message-ID: <20250819105717.372893-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The SERDES0 instance of SERDES on the AM69 SoC is a Cadence Torrent SERDES
and it has 4 lanes which are allocated in the following manner:
Lane0 and Lane1 to PCIe1
Lane2 to PCIe3
Lane3 to USB0

Until [0], the Cadence Torrent SERDES driver only supported configuring
the SERDES for a PCIe + USB configuration whereby all lanes of the
SERDES configured for PCIe will operate at the same speed. As a result,
PCIe1 and PCIe3 instances of PCIe will either fall down to a common
speed based on the PCIe peers that they are each connected to, or, the
PCIe link could fail to be setup.

Since [0] enables support for PCIe Multilink + USB configuration, it is
now possible for the SERDES lanes allocated to PCIe1 and PCIe3 to link up
and operate at different speeds. USB continues to remain functional.

Hence, update the 'serdes0' node as well as the 'pcie1_rc' and 'pcie3_rc'
nodes to switch to the PCIe Multilink + USB configuration that is now
supported by the Cadence Torrent SERDES driver.

[0]: 351e07e6b2ec ("phy: cadence-torrent: Add PCIe multilink + USB with same SSC register config for 100 MHz refclk")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20250818.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 612ac27643d2..f4f7b89bf0d2 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -1321,12 +1321,20 @@ &serdes_wiz0 {
 &serdes0 {
 	status = "okay";
 
-	serdes0_pcie_link: phy@0 {
+	serdes0_pcie1_link: phy@0 {
 		reg = <0>;
-		cdns,num-lanes = <3>;
+		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_PCIE>;
-		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>, <&serdes_wiz0 3>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
+	};
+
+	serdes0_pcie3_link: phy@2 {
+		reg = <2>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 3>;
 	};
 
 	serdes0_usb_link: phy@3 {
@@ -1364,7 +1372,7 @@ &pcie0_rc {
 &pcie1_rc {
 	status = "okay";
 	reset-gpios = <&exp1 5 GPIO_ACTIVE_HIGH>;
-	phys = <&serdes0_pcie_link>;
+	phys = <&serdes0_pcie1_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
 };
@@ -1372,7 +1380,7 @@ &pcie1_rc {
 &pcie3_rc {
 	status = "okay";
 	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
-	phys = <&serdes0_pcie_link>;
+	phys = <&serdes0_pcie3_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
 };
-- 
2.43.0


