Return-Path: <linux-kernel+bounces-886252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0002C35163
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E76188DD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC83019D3;
	Wed,  5 Nov 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i6wiBcXu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF023019C7;
	Wed,  5 Nov 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338413; cv=none; b=Ns6P1KLarR1S/U/OJ7EYE0yI3Ni/EnsP4pv9k0zkyykmmVxHweTQlmsFiL4s8CsRNYpvc92fRJ+Ks5RoBewWookKxuN6KmhQ5gdA8qieHwFfDeWpeNR50eM2P1RB7IMJ52uX1DugYgxo4vlrL6i86FWi9vx9A3KTH9r//mQ+Q3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338413; c=relaxed/simple;
	bh=eRRdklshI7mD/jKpP/+UY9Ouf/OPJc0IOGMFoHTVdHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DR9jYCBP61QebxL2BC99u7BRELs8VcA8X1rDOVEpu8sJHiTjN48yY9TVyb2NxvTxkrSnRRB/TAT6q4hBD8k8Kga1LxZFLn6/pZ49u2FI9YWA25/7nEJ4TIOa863ZFe7o9j4pVcM7Yl+u7/D21yaT/rmjDE6Ggjp75YgmbG1ZcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i6wiBcXu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762338411; x=1793874411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eRRdklshI7mD/jKpP/+UY9Ouf/OPJc0IOGMFoHTVdHA=;
  b=i6wiBcXuFLTnpllMQA88Am4iOhe/SxYV7yTkLk6CahzmTc0vsJ3tTTIT
   on1dN6B0iPa3H+XG6+VOC/MsRgePqqVhczTBe+s5/U4Mg3pavn+ZC4FlD
   UFctHRxc1TtgyndNsZ5MYgs6ve0lfbMUCSLpYh7RlJxhIszcqtS06X+I7
   q6EJFi1P9mkA7G99CoqScs/Qdrr8NR3+zk8sBDW5jokefE21mEq5BULpy
   VUtgGEBLNrzhbFr//DupIoCiO0dAFU7/pitLO92QPl/F6nGKKQ6iEwxsl
   bBND7lN64+OXgsRiPzm7richbvKqvw7KLAlB2VqvD1Px3Ju+lRatv7tc8
   g==;
X-CSE-ConnectionGUID: OcFlDweQSNGA3u0TNJi5vQ==
X-CSE-MsgGUID: 4B/jomYMRXmUwg7fOqOGBQ==
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="48709554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 03:26:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 5 Nov 2025 03:26:10 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 5 Nov 2025 03:26:09 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-riscv@lists.infradead.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [[PATCH RESEND] v1] riscv: dts: microchip: enable qspi adc/mmc-spi-slot on BeagleV Fire
Date: Wed, 5 Nov 2025 10:24:24 +0000
Message-ID: <20251105-unrobed-agility-c9c242a5b344@wendy>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=eRRdklshI7mD/jKpP/+UY9Ouf/OPJc0IOGMFoHTVdHA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDJncqjf2qklP935wTaBKfOLd0+nxzKnHGWx+nH98yj6VrYR3 wZmfHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIIn1Ghp7ABXXsv2o2PeqrfHrk8D 67m7XzX0VumvImz6NSfMZxxWsMPxkLz4T9+hpldPN4dra47tGEKtXCLEf3GSkNx6cLBO+RZwIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The BeagleV Fire has an SD card slot and an ADC connected to the QSPI
controller.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

I believe this got sent a long time ago, but somehow I lost it.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../boot/dts/microchip/mpfs-beaglev-fire.dts  | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
index 55e30f3636df..f44ad8e6f4e4 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
@@ -79,6 +79,26 @@ imx219_vddl: fixedregulator-2 {
 
 };
 
+&gpio0 {
+	interrupts = <13>, <14>, <15>, <16>,
+		     <17>, <18>, <19>, <20>,
+		     <21>, <22>, <23>, <24>,
+		     <25>, <26>;
+	ngpios = <14>;
+	status = "okay";
+};
+
+&gpio1 {
+	interrupts = <27>, <28>, <29>, <30>,
+		     <31>, <32>, <33>, <34>,
+		     <35>, <36>, <37>, <38>,
+		     <39>, <40>, <41>, <42>,
+		     <43>, <44>, <45>, <46>,
+		     <47>, <48>, <49>, <50>;
+	ngpios = <24>;
+	status = "okay";
+};
+
 &gpio2 {
 	interrupts = <53>, <53>, <53>, <53>,
 		     <53>, <53>, <53>, <53>,
@@ -199,6 +219,82 @@ &spi1 {
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+	cs-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>, <&gpio0 12 GPIO_ACTIVE_LOW>;
+	num-cs = <2>;
+
+	adc@0 {
+		compatible = "microchip,mcp3464r";
+		reg = <0>; /* CE0 */
+		spi-cpol;
+		spi-cpha;
+		spi-max-frequency = <5000000>;
+		microchip,hw-device-address = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		channel@0 {
+			/* CH0 to AGND */
+			reg = <0>;
+			label = "CH0";
+		};
+
+		channel@1 {
+			/* CH1 to AGND */
+			reg = <1>;
+			label = "CH1";
+		};
+
+		channel@2 {
+			/* CH2 to AGND */
+			reg = <2>;
+			label = "CH2";
+		};
+
+		channel@3 {
+			/* CH3 to AGND */
+			reg = <3>;
+			label = "CH3";
+		};
+
+		channel@4 {
+			/* CH4 to AGND */
+			reg = <4>;
+			label = "CH4";
+		};
+
+		channel@5 {
+			/* CH5 to AGND */
+			reg = <5>;
+			label = "CH5";
+		};
+
+		channel@6 {
+			/* CH6 to AGND */
+			reg = <6>;
+			label = "CH6";
+		};
+
+		channel@7 {
+			/* CH7 is connected to AGND */
+			reg = <7>;
+			label = "CH7";
+		};
+	};
+
+	mmc@1 {
+		compatible = "mmc-spi-slot";
+		reg = <1>;
+		gpios = <&gpio2 31 1>;
+		voltage-ranges = <3300 3300>;
+		spi-max-frequency = <5000000>;
+		disable-wp;
+	};
+};
+
+
 &syscontroller {
 	microchip,bitstream-flash = <&sys_ctrl_flash>;
 	status = "okay";
-- 
2.51.0


