Return-Path: <linux-kernel+bounces-766311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE4B244EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68E97B80BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDB2F0C7F;
	Wed, 13 Aug 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nKxN741v"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCA2EA158;
	Wed, 13 Aug 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075811; cv=none; b=MgxvqlERl0JQ8r9f99DhEM3iWkSXUd8u/lrM9V1qvHQllfkAsmwt0Lt9927L60WDVTK7CVxJ5Gsz2XOMtbTM0mY1VU8QmLkmJrZg12iWAET9rTzRWAWhz3PkRvbQCPv4HLddAgnNJjLI8SN6eYEjW0ST+bCv5F/JD8aGB3TTc8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075811; c=relaxed/simple;
	bh=/HJ5BV9Tl/wMzaYKd4FJI7MonKqXA4dhk5zT6cSspK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sIqOk9DFIQCEW8lZvVpQLajbR6WhMkneSBIRBw7K44E2kNAFiMZs0lmQTICBS4mObqvtIDtONUJDy4J3IZRixKxVi2K+tjEMOKL3nguHLLAJDMXh8qkdiqg8SiiXh9S7C0/mpNf2Rda1njWML3hEyXAU7tthDTPRdrYvqkS6EAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nKxN741v; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57D93Mtv1666077;
	Wed, 13 Aug 2025 04:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755075802;
	bh=MGJVCy2K2rFeomeyTb+nJIJD2M0UrbgVKPDG9tdz29s=;
	h=From:To:CC:Subject:Date;
	b=nKxN741vvaYzCnk9q5FRLcT5n6SO8FBG+yx+iX0yQztvwbrXEn1WIeX9zzlHH31Rl
	 wilCNcacibEC4eBQIejHlmwGmT53QPcDw/CpYQ/Dg68keC5arDFkp1P+ldjaPLa8dN
	 1nho6C1SDigELMni1ncu/sMXPItGA5i9djlNUGjU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57D93MfB4138200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 04:03:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 04:03:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 04:03:22 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57D93L3u2074113;
	Wed, 13 Aug 2025 04:03:21 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-k6@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash
Date: Wed, 13 Aug 2025 14:33:00 +0530
Message-ID: <20250813090300.733295-1-p-bhagat@ti.com>
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

AM62D2 EVM has S28HS512T 64 MiB Octal SPI NOR flash connected to the
OSPI interface. Add support for the flash and describe the partition
information as per bootloader.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
Boot logs
https://gist.github.com/paresh-bhagat12/262d8c64e692d22c4e48363d246fb083

Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
Schematics Link-https://www.ti.com/lit/zip/sprcal5

 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 86 ++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index daea18b0bc61..aa943ef52fb5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -25,6 +25,7 @@ aliases {
 		rtc0 = &wkup_rtc0;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
+		spi0 = &ospi0;
 	};
 
 	chosen {
@@ -367,6 +368,26 @@ usr_led_pins_default: usr-led-default-pins {
 			AM62DX_IOPAD(0x0244, PIN_INPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
 		>;
 	};
+
+	ospi0_pins_default: ospi0-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
+			AM62DX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
+			AM62DX_IOPAD(0x0030, PIN_OUTPUT, 0) /* (G19) OSPI0_CSn1 */
+			AM62DX_IOPAD(0x0034, PIN_OUTPUT, 0) /* (K20) OSPI0_CSn2 */
+			AM62DX_IOPAD(0x0038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
+			AM62DX_IOPAD(0x000c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
+			AM62DX_IOPAD(0x0010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
+			AM62DX_IOPAD(0x0014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
+			AM62DX_IOPAD(0x0018, PIN_INPUT, 0) /* (H18) OSPI0_D3 */
+			AM62DX_IOPAD(0x001c, PIN_INPUT, 0) /* (K21) OSPI0_D4 */
+			AM62DX_IOPAD(0x0020, PIN_INPUT, 0) /* (H19) OSPI0_D5 */
+			AM62DX_IOPAD(0x0024, PIN_INPUT, 0) /* (J20) OSPI0_D6 */
+			AM62DX_IOPAD(0x0028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
+			AM62DX_IOPAD(0x0008, PIN_INPUT, 0) /* (L21) OSPI0_DQS */
+		>;
+		bootph-all;
+	};
 };
 
 &mcu_gpio0 {
@@ -613,3 +634,68 @@ &c7x_0 {
 &main_rti4 {
 	status = "reserved";
 };
+
+&fss {
+	status = "okay";
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+	status = "okay";
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+				bootph-all;
+			};
+		};
+	};
+};
-- 
2.34.1


