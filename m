Return-Path: <linux-kernel+bounces-801662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCBB4487A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30BD1C8692A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCD2C0F89;
	Thu,  4 Sep 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ue5JSvdR"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB12BFC73;
	Thu,  4 Sep 2025 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021319; cv=none; b=gBkJ4VCYI40+whsoz/Z7EIrVk3zu/jrCwuiH7Rt6Wt4S0d+HG5TQANOmJOmXthzDvLARvia+8PrZLLNdkZrw1rozpy1O1+DCv7hSo4t1KRNKinS6KUO3VF9ohPjNK2xC3HVM5pdzu/dMHercU1JTpH0J8sGZClkQDn3jlGheag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021319; c=relaxed/simple;
	bh=PlUfpeG8w136W0GW7WScKwVLqE29amrIbEl44ed9VBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2c16RFXVWEgjXpiYElrIMA7XLXEaCkTW/g1JRk43Jiw1U6emwY8Ig1I3CPcYgb6ItZ4XU7CowDX0DWVahuqICwITS7xlSLYB5f1AKwbB7TeMmgdw2yT6OS0sd/RN9O2VDJgnS2kGitOaNp3xEHiduV9UTK1aLLTjMh/k1geMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ue5JSvdR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LSUBp3104793;
	Thu, 4 Sep 2025 16:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021310;
	bh=GfvcRGl7/19ANRlwYBjdSCqN8kFyLh4KJhsVTEgnAbE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ue5JSvdRGYR88DZdmziWJWuYOUf8hkuG/uUUdEOLBfJxw7IE68MSNVDK/51X+MfGY
	 MjEFSZCdQwNZMY1LDg5p1yzxCe415YU86FQHCXZkCQgL0PZ6vk4cIMNO2GIGpFPSJg
	 SxGLD7/GwBY5SxHqjSI1VkGKHg7+PjtXJM/E3j3k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LSU1N4090288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:28:30 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:28:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:28:30 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LSTnO3903903;
	Thu, 4 Sep 2025 16:28:30 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62x-sk-common: Enable Main UART wakeup
Date: Thu, 4 Sep 2025 16:28:25 -0500
Message-ID: <20250904212827.3730314-2-k-willis@ti.com>
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
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d51..72801cf890d20 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -163,14 +163,26 @@ &phy_gmii_sel {
 
 &main_pmx0 {
 	/* First pad number is ALW package and second is AMC package */
-	main_uart0_pins_default: main-uart0-default-pins {
+	main_uart0_tx_pins_default: main-uart0-tx-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
 			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
 		>;
 	};
 
+	main_uart0_rx_pins_default: main-uart0-rx-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
+		>;
+	};
+
+	main_uart0_rx_pins_wakeup: main-uart0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT | PIN_WKUP_EN, 0) /* (D14/A13) UART0_RXD */
+		>;
+	};
+
 	main_uart1_pins_default: main-uart1-default-pins {
 		bootph-pre-ram;
 		pinctrl-single,pins = <
@@ -342,8 +354,12 @@ &wkup_uart0 {
 &main_uart0 {
 	bootph-all;
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_default>;
+	pinctrl-1 = <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_wakeup>;
+	wakeup-source = <&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
 };
 
 &main_uart1 {
-- 
2.34.1


