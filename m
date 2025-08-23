Return-Path: <linux-kernel+bounces-782901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D2B326A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E7DAC7E10
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7922425B;
	Sat, 23 Aug 2025 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xT1HTvgm"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475D221FDD;
	Sat, 23 Aug 2025 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755919411; cv=none; b=Ip+Pg7DpfbOFVv3RxPIOK/rHemdznaSh6JvgukcNm4IDMR9Wf9G4elDa7mrqt54gr9AfXkaVwXR/x3Tp1n4qnAPRVaQXfOw/d/8GojzrjYjC/6LcCimA1wrR3eFQDFfoZ8lhI6PpZcckhv1a80ZGWmpdIsekvV+gyK/+QHamEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755919411; c=relaxed/simple;
	bh=Gbhk8aFLXqcWnlXmcAy60PPWXIWWF7F2AaVLHai4YlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYe+TlAWanv6BF4Mta8TCFWFl6oKg5DoMCpUkjyBbLHfzgE9frrCuLwRQL6wsuByZpjfZty7tN8RXs8FhdpTjXgo+Q2VuXoQVShfsJSd9zTa9X+dVF8v9d90wWqs0Z0qtBZauoJbQ9hJ/FFURViUFhfDg+W5prwIzZ45V7kRHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xT1HTvgm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N3NPuG848517;
	Fri, 22 Aug 2025 22:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755919405;
	bh=w+MLiM7EUbI3t1OpzggJOR4OBB9Y1zswUtgZzzSde6c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xT1HTvgmryKpZp2SfvfspbTM1qf14V+ebRa/z11qjn5L1XO7V1OfhnScOvAEbChvx
	 igPR8Pnj360KqppOf7VJ8wJvU8ajsNZHcWIw4gsEk9Vm9a6cuT6Ipab1D5ei00EpqQ
	 Q3GqXgNlGnih99IhQ8NC6QczNY46G8M91u8rHOmU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N3NPFl3726678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 22:23:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 22:23:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 22:23:24 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N3NNjF288146;
	Fri, 22 Aug 2025 22:23:24 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62d2-evm: Enable USB support
Date: Sat, 23 Aug 2025 08:53:04 +0530
Message-ID: <20250823032304.1085775-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823032304.1085775-1-p-bhagat@ti.com>
References: <20250823032304.1085775-1-p-bhagat@ti.com>
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


