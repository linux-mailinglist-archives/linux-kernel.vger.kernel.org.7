Return-Path: <linux-kernel+bounces-797770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E3B4152A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA39561F77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413B02D8764;
	Wed,  3 Sep 2025 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SkrobXqg"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15D2D7DDC;
	Wed,  3 Sep 2025 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880736; cv=none; b=YlLNYXl8DDngQk0FGpB3/g5ASm3Tv5gG/I6N9qgDLd5XH3vdhRLL1v6v9KGwKBSC3Hgw9QpG4XDTAVScicrlbRiLquEpWQxkcHwvutajLfonGTq1Y7CnnarP06dNm7ULjl/H4ipsdmMzpedNZU7eFNIz68oYC2+rC4KSUGSWpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880736; c=relaxed/simple;
	bh=/tPGvqA8uT4rEks2Yn2jHWSgdT4i+T/MsEddT9dcmYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvnFxfcHewa8TFlPzbrijMC5xZWwbhNEQUXlg3kXdBSMZKmDJma3teivU/WJnZKxx3fSE6jOwUhrSZY9cuAdqhtPdv2lWbfnOOjqLU2zII/FLN4HeomVdaMxtojD+WNW/1yKRn3w7jMRjE/bHIhrVRgfKZqU5z9m/fd+iAGxBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SkrobXqg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5836PNM12766085;
	Wed, 3 Sep 2025 01:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756880724;
	bh=/7FTaJZhLDxhmhQlwyhjmZLfj5m8XNLE0YLt4iyXpTw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SkrobXqg64dGrGUv6flyM5/mxGBswNLgDfh4/5Aj/0u4At8UH5Q4G6uz24SB+6IfP
	 21MXLLIYBZCNt7ATAbaQPHtc3iXNTuV/DnLY1mZGoTgW9HtZ8eOjrTlNEXOZ7SLuN6
	 qEmuReUwg53CyRIq3O77zoY0QGropMQbWc77mS2Y=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5836PNlW2839192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 01:25:23 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 01:25:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 01:25:23 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5836PMNP829293;
	Wed, 3 Sep 2025 01:25:23 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <devarsht@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am62d2-evm: Enable USB support
Date: Wed, 3 Sep 2025 11:55:13 +0530
Message-ID: <20250903062513.813925-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903062513.813925-1-p-bhagat@ti.com>
References: <20250903062513.813925-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add pinmux configuration for USB1 interface and enable the node for
functionality. Also enable data transfer on USB0, on existing power
delivery configuration.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
Reviewed-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index daea18b0bc61..9704c2d97f43 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -367,6 +367,12 @@ usr_led_pins_default: usr-led-default-pins {
 			AM62DX_IOPAD(0x0244, PIN_INPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
 		>;
 	};
+
+	main_usb1_pins_default: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (D19) USB1_DRVVBUS */
+		>;
+	};
 };
 
 &mcu_gpio0 {
@@ -499,6 +505,11 @@ &main_uart0 {
 	status = "okay";
 };
 
+&usbss0 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
 &usb0 {
 	usb-role-switch;
 
@@ -509,6 +520,16 @@ usb0_hs_ep: endpoint {
 	};
 };
 
+&usbss1 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
+
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>,
-- 
2.34.1


