Return-Path: <linux-kernel+bounces-721198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D9AFC603
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC4A3A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A62C08AE;
	Tue,  8 Jul 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j1HYzsRS"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D422BF01F;
	Tue,  8 Jul 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964203; cv=none; b=CXuXAXYq3behZjGHtQ3rrSO1AuRX840Pwc/WYtEKW6j2ITPkSgfuY94uwEDwDIqTklDdprBOwi9gKPtTBds68N3WWLNVydJ2SjWpWVikErXkac4xHajbeLurFIRXtgaaEVLThlQm5JGH8+wi0+ZHjXR3h7AtOKoWm2fsgrQtAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964203; c=relaxed/simple;
	bh=oMAEBrdkRRkpqRgdvTeGNAAMHOGhLhnt+NrobgaLxgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhmVN94+ggxKM9dBt32701gHWoULSMB2ID7CKCVn28i/EedHOby13aK7H5iRTOBCRzLa116j3VqWFXECZwcYk2q957QQCNzjWS1jn4vYT/1++w1ITsmHZkDfqiUixOgRBzRMCVdOWdyPksbpt3nkGDTwb9gRevpQw6J+oLMcCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j1HYzsRS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5688hAoo832362;
	Tue, 8 Jul 2025 03:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751964190;
	bh=yqLx4OXXk3PLZD8Eon9lnQ8Cr2fJ693Bv9Ym6u1tHZ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=j1HYzsRS9h6DYpATK2gcd7sHH71LXfuFeyzvnIsWy5zLoJRRLNMIGWucsLTVi3jf+
	 /gVLTqMuMpnWyFo/1RcXWEFekLWWClx+eFgi3pXEELmsmbuG7jg5hGHYxuJVHkukOS
	 NyGNeBNj23ARiHe/H5d2Z5QJz/XYI3JpXJLstjBk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5688hAFb1287373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 03:43:10 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 03:43:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 03:43:09 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5688h8M91768266;
	Tue, 8 Jul 2025 03:43:09 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <c-vankar@ti.com>
CC: <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v5 3/4] arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable Ethernet boot
Date: Tue, 8 Jul 2025 14:12:51 +0530
Message-ID: <20250708084252.1028191-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708084252.1028191-1-c-vankar@ti.com>
References: <20250708084252.1028191-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Ethernet boot requires CPSW nodes to be present starting from R5 SPL
stage. Add bootph-all property to required nodes to enable Ethernet boot
for J722S-EVM.

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Changes from v4 to v5:
- Split [PATCH v4 2/2] to [PATCH v5 2/4] and [PATCH v5 3/4].
- Added properties to board specific files.

Link to v4:
https://lore.kernel.org/r/20250429072644.2400295-3-c-vankar@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a47852fdca70..08a2f26f1f58 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -282,6 +282,10 @@ csi23_mux: mux-controller-1 {
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &main_pmx0 {
 
 	main_mcan0_pins_default: main-mcan0-default-pins {
@@ -346,6 +350,7 @@ mdio_pins_default: mdio-default-pins {
 			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
 			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	ospi0_pins_default: ospi0-default-pins {
@@ -380,6 +385,7 @@ J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
 			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
 			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
 		>;
+		bootph-all;
 	};
 
 	main_usb1_pins_default: main-usb1-default-pins {
@@ -424,6 +430,7 @@ &cpsw3g_mdio {
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
@@ -434,6 +441,7 @@ &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
+	bootph-all;
 };
 
 &main_gpio1 {
-- 
2.34.1


