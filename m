Return-Path: <linux-kernel+bounces-721196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21AAFC600
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0898B188D10C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43A2BEFF5;
	Tue,  8 Jul 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="anCmuZ7f"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BC29B224;
	Tue,  8 Jul 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964197; cv=none; b=QUZ0Nwm7qSKsL5A0AavL35H2kNaOMxb89Hg6R3S46YJU7tFM34XMxlkFdrEdKNyfKPxqtbyIHdruQFYwVdSiwFX6OYAJ6SiMbnMyDiZSG2h81jiUw53/VDTtnLsPpUB66DEiyfVw8L8/XojWFdPZ1u2mSvQC9RKyPQVTjS21mVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964197; c=relaxed/simple;
	bh=CbY1Z0HlqF1zdrhuzAOYfkmxX+QUimBNoTYYJ6G4ADo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb1ryITUzz4TpGVqbUhaSXb67GBKly4CTMyGlLqwPB/C70Ch3PCraRYvm5ncxz2NIT5rTYr/FIq+1k3WivtP5QvkNAIYN5j+uXnZdAf8xAsm/OemTh2cZDfX1EHnTN+HqRZQgh1mZIsk9xFwARR0S3cdY/4oZr4p/2znp9Fj70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=anCmuZ7f; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5688hB551106687;
	Tue, 8 Jul 2025 03:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751964191;
	bh=2poAyTjaJisKv9dsHGd5+dqWdpZE+YAFDR/b1OlxWJw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=anCmuZ7fERKb0ugucjioNLELJrsa7BZCuApAfio35DbW9VjyabjGqFd4AXJ+SmS3D
	 8tMF/THFw8LTjm9Epyqu+j9nJ7eFgvYBzD1Fztfu7N1eyBjFLzPGL2Kku0lzsomIsW
	 0803uS5PRUQwa3iVFZjVEExAKOIsU0RgUjvanjF8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5688hBHV848090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 03:43:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 03:43:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 03:43:10 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5688hAp41768283;
	Tue, 8 Jul 2025 03:43:10 -0500
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
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 4/4] arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ethernet boot
Date: Tue, 8 Jul 2025 14:12:52 +0530
Message-ID: <20250708084252.1028191-5-c-vankar@ti.com>
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
for SK-AM69.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is introduced new from this version.

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index f28375629739..a1a16151015e 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -568,6 +568,7 @@ J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
 			J784S4_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
 			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
 		>;
+		booph-all;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio-default-pins {
@@ -575,6 +576,7 @@ mcu_mdio_pins_default: mcu-mdio-default-pins {
 			J784S4_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
 			J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	mcu_rpi_hdr1_gpio0_pins_default: mcu-rpi-hdr1-gpio0-default-pins {
@@ -630,6 +632,14 @@ J784S4_WKUP_IOPAD(0x0, PIN_INPUT, 7) /* (M33) WKUP_GPIO0_49 */
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
+&mcu_udmap {
+	bootph-all;
+};
+
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
@@ -968,6 +978,7 @@ &mcu_cpsw {
 &davinci_mdio {
 	mcu_phy0: ethernet-phy@0 {
 		reg = <0>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
@@ -978,6 +989,7 @@ &mcu_cpsw_port1 {
 	status = "okay";
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&mcu_phy0>;
+	bootph-all;
 };
 
 &mcu_r5fss0_core0 {
-- 
2.34.1


