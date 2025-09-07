Return-Path: <linux-kernel+bounces-804638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA1B47AEE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BC8189EC68
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F4261585;
	Sun,  7 Sep 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="bzxGOcGy"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A92261B98
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244273; cv=none; b=oSPw8TfUOUK9TLtaMFcnaRLGe0N/5atu83Ly7aN5WPVn9cNIiTNuzgX0JKw422FTq1f1xfTd9DwzsFPigBotfbT4uzLVT9vjJ7d5WUtUE1WXi52mZcbBq3blJo6C2WhAdbzYxRRhpUuYJq4imR/nxZHxfpZPS+8smkomE55gtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244273; c=relaxed/simple;
	bh=m+SK6RZu81AvceUb2EhrYY1h+etFykloM9qWjtaZIcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlmCQfdr9WO7j5mAAcRnIBLtYnVtnMlzMJZVgGdcIa+QLe2xVtVu/0cXIE+CF24KkJirZn7N8vqPyLaXnb1UeCD+66GPHwmH5t0/QGcJ0NBo/ea72IQAzWJv5IpcPvCX9RUwRsKNOybYZy+yM5vkmCr/MOggrB5L5rHI/PTzjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=bzxGOcGy; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 25405 invoked from network); 7 Sep 2025 13:17:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1757243866; bh=1Czx2eU4pmBOj1uB61N886Er/ocYFYwRqZXYBAxfJrQ=;
          h=From:To:Cc:Subject;
          b=bzxGOcGy7Z/+wTbNHxVaRjRAuZv320kdengLw5JnETPXEnquJQdv79jZg4L55V2pK
           fZLUmh9igePuvD4NkArGachhvybjIDsSx4u3wT/O4nCHTCnZjPAkZycgyvrDQDindB
           b21PUqttlIvder7aiDlNurfaFV2Ht3ovEFOxcdCcXoe0aCDyTLaWBMuczgrgE5YvqV
           XEciil14KBWp19oZk7pJSLqT+99n3Mv0JgQS3GpUylu0/CSSBxUDZnSzOvBPy0GQKx
           4EkOew2xYnTnyn8T5d+rSPw4SjWQrgRvNP52yClBUJmUUyiz+tYT6KBIRpG3YTjWIv
           RunVfsYoIpzjA==
Received: from 83.24.123.254.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.123.254])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 7 Sep 2025 13:17:46 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH v5 1/1] arm64: dts: mediatek: add thermal sensor support on mt7981
Date: Sun,  7 Sep 2025 13:15:09 +0200
Message-ID: <20250907111742.23195-2-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250907111742.23195-1-olek2@wp.pl>
References: <20250907111742.23195-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 24360e36277411bda771a55fa12e8a08
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4XOB]                               

The temperature sensor in the MT7981 is same as in the MT7986.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5cbea9cd411f..277c11247c13 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -76,7 +76,7 @@ watchdog: watchdog@1001c000 {
 			#reset-cells = <1>;
 		};
 
-		clock-controller@1001e000 {
+		apmixedsys: clock-controller@1001e000 {
 			compatible = "mediatek,mt7981-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
 			#clock-cells = <1>;
@@ -184,6 +184,31 @@ spi@1100b000 {
 			status = "disabled";
 		};
 
+		thermal@1100c800 {
+			compatible = "mediatek,mt7981-thermal",
+				     "mediatek,mt7986-thermal";
+			reg = <0 0x1100c800 0 0x800>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_THERM_CK>,
+				 <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "therm", "auxadc";
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
+			#thermal-sensor-cells = <1>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
+
+		auxadc: adc@1100d000 {
+			compatible = "mediatek,mt7981-auxadc",
+				     "mediatek,mt7986-auxadc";
+			reg = <0 0x1100d000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@11d00000 {
 			compatible = "mediatek,mt7981-pinctrl";
 			reg = <0 0x11d00000 0 0x1000>,
@@ -211,6 +236,10 @@ efuse@11f20000 {
 			reg = <0 0x11f20000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			thermal_calibration: thermal-calib@274 {
+				reg = <0x274 0xc>;
+			};
 		};
 
 		clock-controller@15000000 {
-- 
2.47.3


