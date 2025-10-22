Return-Path: <linux-kernel+bounces-864898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D9BFBCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519F6189B88D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69556342151;
	Wed, 22 Oct 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a348WHO2"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7373126BA;
	Wed, 22 Oct 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135176; cv=none; b=d19LbDHn9VrxxmfiNj/SP6kV4KFgZ+YPie91aTObcLumctdyZg7Sl0dGoRzx5cSiBlN0bK0JE766u0LhG/7rMgcwKTpWdQjNgwAtFhqnN4bmSXIkTLaGbSMC4EIv9RtxS5UPPAhHUkkGrL0EbVZ2I+dsHT847igGM/Kqh0y2JDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135176; c=relaxed/simple;
	bh=bnYmrdnJ5nXbtqY8lk+ZVyuMM3focOV0ncxkglR72A8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8ie6QIqQYmnYh7ir0jmlPiz38wywmHqu+FdjJE5xebJqIg1RGurBWEHJtkIzqi4j7oej3HnllNim5urkLZDPupsNEpSJ/wCOkNu1D6orDVc/BzMZlHw5eEcIppYOa1FhKcBsrtBvxxh6vZjszGKG+f9sOx29ukGABsqiKzG5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a348WHO2; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MCCkDs1399372;
	Wed, 22 Oct 2025 07:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761135167;
	bh=Im6PoCOaKHLn9fCxkHUqD0r00FkT7Hr9IrkbupO3vpM=;
	h=From:To:CC:Subject:Date;
	b=a348WHO29uGaUg9l2pXWuEP4jUns7kqu6kK+lFUN4VA+aXGzGQv33Kd/fhNPXOqDu
	 XN4M+8+vqtNQBT303A46rPkxBGi3Ge5P/E26uXFvGUC3nbD15281JTuQdmD1WK3zKo
	 ydIOcfeW6WfOEaBjukkA1Af+lRoMtYZ0mt4LiEW8=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MCCk5P1999166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 07:12:46 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 07:12:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 07:12:46 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [172.24.234.127])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MCCgMU1176371;
	Wed, 22 Oct 2025 07:12:43 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <gehariprasath@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4: Fix I2C pinmux pull configuration
Date: Wed, 22 Oct 2025 17:41:55 +0530
Message-ID: <20251022121222.220113-1-a-limaye@ti.com>
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

Fixes: e20a06aca5c9 ("arm64: dts: ti: Add support for J784S4 EVM board")
Fixes: 635fb18ba008 ("arch: arm64: dts: Add support for AM69 Starter Kit")
Fixes: 0ec1a48d99dd ("arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header")
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
v2:
- Added Fixes tags
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


