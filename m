Return-Path: <linux-kernel+bounces-801663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E14B4487E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6447BBA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000BA2C15B1;
	Thu,  4 Sep 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vq7aM6d0"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A542BEFE8;
	Thu,  4 Sep 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021320; cv=none; b=V6CK6Qz+l2mKU8+MLqCZRx5u4mDeafgIk5p+q8HTa6Witl59awNTcxZjSYTzT7O/7XByyw7ErD9o4uIAOgsJzMbkn7+3ZUs8tj34F4LuZfYXPAKqBKRDhzPsmm0j36L+gJe8Cv3fnVqQz6aKhtFsXL7oJi3VVip3BSVK7izcbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021320; c=relaxed/simple;
	bh=nf9ALlpHqVdANS8XTSvi8CO7dK0aKev3vsalyo47QCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9ngoE2JuMybor0yxHQMlk7DBQOghWs90PpCmS2juzKOZs16fIrqo5aqndxOhV8tCKB7nPRLwisxe1IqYwEI3kH+mqexfHJKyyFFu2oPREPfH/V3IW2Eg6xYcuW3QqdUeh3TLwaXy70YQ8YVQHegNKSt2fXFJR5Sr/WAkrotWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vq7aM6d0; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LSVvk3169119;
	Thu, 4 Sep 2025 16:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021311;
	bh=sRSF6N8lMw7xbMxdTuT9WCwNZfjdGkdjYuj61hNsKBI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Vq7aM6d0Ge/fr7plR3nk3BDd5W7iKFbCzyAbtEKw0CYY8iQqUdSwdSnF+vBnufJVl
	 DKt+HsYxtJ/4Gw/HFAgYojDcjiRAyjdQF1Qjnu3/2LZoboni7PlPC9Omuhpp/mjgaC
	 dyVnRrGClA9yPaTl3qjof6nM//D22lk10aZke0TY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LSVMx449425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:28:31 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:28:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:28:30 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LSTnP3903903;
	Thu, 4 Sep 2025 16:28:30 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62a7-sk: Enable Main UART wakeup
Date: Thu, 4 Sep 2025 16:28:26 -0500
Message-ID: <20250904212827.3730314-3-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904212827.3730314-1-k-willis@ti.com>
References: <20250904212827.3730314-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The Main UART can resume from suspend to RAM states when PIN_WKUP_EN
is enabled. Add the necessary pins needed to wakeup the system. Add the
system idle states that the Main UART can wakeup the system from.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index bceead5e288e6..1c0ef563750c8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -294,14 +294,26 @@ AM62AX_IOPAD(0x078, PIN_OUTPUT, 1) /* (T21) GPMC0_AD15.VOUT0_DATA23 */
 		>;
 	};
 
-	main_uart0_pins_default: main-uart0-default-pins {
+	main_uart0_tx_pins_default: main-uart0-tx-default-pins {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
 			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
 		>;
 		bootph-all;
 	};
 
+	main_uart0_rx_pins_default: main-uart0-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
+		>;
+		bootph-all;
+	};
+
+	main_uart0_rx_pins_wakeup: main-uart0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1c8, PIN_INPUT | PIN_WKUP_EN, 0) /* (E14) UART0_RXD */
+		>;
+	};
+
 	main_uart1_pins_default: main-uart1-default-pins {
 		pinctrl-single,pins = <
 			AM62AX_IOPAD(0x01ac, PIN_INPUT, 2) /* (B21) MCASP0_AFSR.UART1_RXD */
@@ -701,8 +713,12 @@ &main_gpio_intr {
 
 &main_uart0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_default>;
+	pinctrl-1 = <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_wakeup>;
+	wakeup-source = <&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
 	bootph-all;
 };
 
-- 
2.34.1


