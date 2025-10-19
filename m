Return-Path: <linux-kernel+bounces-859650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE3BEE33E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFB43B9D55
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1B2E5B32;
	Sun, 19 Oct 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="imx2nrju"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46A22A817;
	Sun, 19 Oct 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870465; cv=none; b=cC44I1Pu2cJaGP4po7tA7fthD8dFFCiR/CbEFXPbkKdiJvnskotZW0ztrwlZUXZyz51+9zojCDmBeDvgxMV3WVqF7kdgiuD7dVQuEOialvfAkFupB2nM0TTEGXm/ztFk5w5YF4JVvLAIH32vaomrWpe5ppayIQJbPOcLlI0kKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870465; c=relaxed/simple;
	bh=VSp2e5+pgoU9UclwQEAiSvie/P2W0BgKPz8f8u2EAFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mysh4zMlMngmu/yCOs2/JiiS/GbaPZDWkcvJVBMRKV71o1rv/sK18QnRL4ZH8XwrjXQoh70Trzk74KMXD6SEgTVBCWj15x9FTkMut/jQS2iZlM59aIXiBU+IZsyHUQNyb19caSrsKj+mszE9OSdq1nwcZzDr9v/VOHsZOwkmHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=imx2nrju; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59JAeFfJ664942;
	Sun, 19 Oct 2025 05:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760870415;
	bh=Q//6LQDm5vvBeQ9sEBAivNXMI2ny/HhHL/pL6Pvb2as=;
	h=From:To:CC:Subject:Date;
	b=imx2nrjuEIBCXItftYb7HVyHMShrMl3U1cRkvmm+hCYKpTVwvsYID6ZWemyGF98VZ
	 lt1+g7EBc1jBVEb73Wj7LsLoOVn8wbAt5UsakuEUPZecGDKWsauymehXI6HKRL1bm5
	 WlzuJ8E/+S8f96kXsgtPKj5YejGM+THcAwNQkOU4=
Received: from DFLE200.ent.ti.com (dfle200.ent.ti.com [10.64.6.58])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59JAeEXI3821906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 19 Oct 2025 05:40:14 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Oct
 2025 05:40:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 19 Oct 2025 05:40:14 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [172.24.234.127])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59JAeANM113965;
	Sun, 19 Oct 2025 05:40:11 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <gehariprasath@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4: Fix I2C pinmux pull configuration
Date: Sun, 19 Oct 2025 16:09:19 +0530
Message-ID: <20251019103938.276062-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The I2C pins for some of the instances on J784S4/J742S2/AM69 are
configured as PIN_INPUT_PULLUP while these pins are open-drain type and
do not support internal pull-ups [0][1][2]. The pullup configuration
bits in the corresponding padconfig registers are reserved and any
writes to them have no effect and readback checks on those bits fail.

Update the pinmux settings to use PIN_INPUT instead of PIN_INPUT_PULLUP
to reflect the correct hardware behaviour.

[0]: https://www.ti.com/lit/gpn/tda4ah-q1 (J784S4 Datasheet: Table 5-1. Pin Attributes)
[1]: https://www.ti.com/lit/gpn/tda4ape-q1 (J742S2 Datasheet: Table 5-1. Pin Attributes)
[2]: https://www.ti.com/lit/gpn/am69a (AM69 Datasheet: Table 5-1. Pin Attributes)

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                   | 8 ++++----
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 5896e57b5b9e..0e2d12cb051d 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -236,8 +236,8 @@ J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
-			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
-			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
+			J784S4_IOPAD(0x0e0, PIN_INPUT, 0) /* (AN36) I2C0_SCL */
+			J784S4_IOPAD(0x0e4, PIN_INPUT, 0) /* (AP37) I2C0_SDA */
 		>;
 	};
 
@@ -416,8 +416,8 @@ J784S4_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (J37) WKUP_GPIO0_12.MCU_UART0_TXD */
 
 	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x0a0, PIN_INPUT_PULLUP, 0) /* (M35) MCU_I2C0_SCL */
-			J784S4_WKUP_IOPAD(0x0a4, PIN_INPUT_PULLUP, 0) /* (G34) MCU_I2C0_SDA */
+			J784S4_WKUP_IOPAD(0x0a0, PIN_INPUT, 0) /* (M35) MCU_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x0a4, PIN_INPUT, 0) /* (G34) MCU_I2C0_SDA */
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 419c1a70e028..2834f0a8bbee 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -270,8 +270,8 @@ J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
-			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
-			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
+			J784S4_IOPAD(0x0e0, PIN_INPUT, 0) /* (AN36) I2C0_SCL */
+			J784S4_IOPAD(0x0e4, PIN_INPUT, 0) /* (AP37) I2C0_SDA */
 		>;
 	};
 
-- 
2.51.0


