Return-Path: <linux-kernel+bounces-818439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E6B591C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB103218B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38B28CF42;
	Tue, 16 Sep 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vysoebr9"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A7299ABF;
	Tue, 16 Sep 2025 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013682; cv=none; b=Ghxhx5o+ZCkgAzrNdavVnYVbt6a4qePnDMTFVmfaSPTnpakWbappIPx/DS4zM/me/zS4tKf/1WxKKOI6iYYTeSI2V6XNHkeQ4GUoEVBC+HAXGbRM+Akw4M6M7XD0O32f06FZCQwr5lrfcVElI7FUBOjMCz1sm3Faecp3Ijeu5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013682; c=relaxed/simple;
	bh=6xt04xpty1JSfJO88ASmH0zplql7Vn6k9OxniC/OWNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSKMlVB4HD0qDEAjyNSEMHsbQ/cjTeHdX/JDBphsRVCbwNt7mdJXvMY6l4i/X31i6vRaJvNYjpCvVAVWSbEbIyUfa+M9G2MERUT0umP1nTcrm1e4527/FzSUObO+EiDRefYZID+bN3pqNAHDvkSNzhSjc+Aek6sWhlK1pmZwFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vysoebr9; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58G97j121334931;
	Tue, 16 Sep 2025 04:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758013665;
	bh=eC/sulH2mseeaiObNeLNUQGTpaf84l7yndW7viSPpP8=;
	h=From:To:CC:Subject:Date;
	b=vysoebr9SxI1haSqG0XZJLoHLedO/UH1CHRUpD9cEVGKAq1lRmRAm867MGKL2IJEu
	 QwNMAvPWO7xpT0mZoREShhL6fNxAPoAyXPToOk/tBgeTwnX48QYeOwkHqlgpgyOAUI
	 h3nxiCgjCVonq9ENfBKawTMp87dPXvNzJ4PEGiw4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58G97j5R4052228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 04:07:45 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 04:07:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 04:07:45 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58G97icV1377927;
	Tue, 16 Sep 2025 04:07:44 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62d2-evm: Fix regulator properties
Date: Tue, 16 Sep 2025 14:37:36 +0530
Message-ID: <20250916090736.2299127-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Fix missing supply for regulators TLV7103318QDSERQ1 and TPS22918DBVR.
Correct padconfig and gpio for TLV7103318QDSERQ1.

Reference Docs
Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
Schematics - https://www.ti.com/lit/zip/sprcal5

Fixes: 1544bca2f188e ("arm64: dts: ti: Add support for AM62D2-EVM")
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---

Boot logs
https://gist.github.com/paresh-bhagat12/9a4a1aec5119ceedb386743921432c91

Tag used
next-20250915

 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index 83af889e790a..d202484eec3f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -146,6 +146,7 @@ vdd_mmc1: regulator-4 {
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_sys>;
 		regulator-boot-on;
 		enable-active-high;
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
@@ -165,14 +166,16 @@ vcc_3v3_sys: regulator-5 {
 	};
 
 	vddshv_sdio: regulator-6 {
+		/* output of TLV7103318QDSERQ1 */
 		compatible = "regulator-gpio";
 		regulator-name = "vddshv_sdio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&vddshv_sdio_pins_default>;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v0>;
 		regulator-boot-on;
-		gpios = <&main_gpio1 31 GPIO_ACTIVE_HIGH>;
+		gpios = <&main_gpio0 59 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 		bootph-all;
@@ -334,7 +337,7 @@ AM62DX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
 
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
-			AM62DX_IOPAD(0x1f4, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO1_31 */
+			AM62DX_IOPAD(0x00f0, PIN_INPUT, 7) /* (Y21) GPIO0_59 */
 		>;
 		bootph-all;
 	};
-- 
2.34.1


