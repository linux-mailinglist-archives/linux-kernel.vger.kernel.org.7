Return-Path: <linux-kernel+bounces-752659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8EB178F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E234C1C80741
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D5D273D6C;
	Thu, 31 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g35nxxeU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34B270542;
	Thu, 31 Jul 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999962; cv=none; b=uDiiKdG3ENYCEAitDcVyo8UeK/dCesLH4ygECWVer8cjhQv2gANh9b4m4wof0pShxFjJgimvuNAkA6PYpUHGL5Ta2cwy0NMxvkHrJFRN+Lo3iHLb+xn+VnFYBV6LvQC3ARasdEdRntqoMufMWvAUBvnQRaNftvq0eSRuKIR6zFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999962; c=relaxed/simple;
	bh=tdDkXmNUX4O3VWO9zUljpRGtZvcgIcgJ0oBAw1ujc0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwG7rnfZl156caUvIRsa0QnXID85yVOb1lRsBReQ/vcxYwO7tRchSb6wjPcieeeS4La52jEV3DFPBGpTb0Ya5dmQJ7dHHx4U9brWtif3gexe+8En9JfAe0MOk7Jld4Yxq49C1LSPJJty3dGCbMklIDISJNu/I77nYVS7cZIYXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g35nxxeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F7C4CEF4;
	Thu, 31 Jul 2025 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999962;
	bh=tdDkXmNUX4O3VWO9zUljpRGtZvcgIcgJ0oBAw1ujc0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g35nxxeUbz4f/mQmvW8Q5iBzd6861+826jXm8MYGFoj1apAVSoWQCnKon2dnihV44
	 lj10o/xd8zFe7SyTPXXwnm+1m3cXx8nOf+yOXNE8GQulwcpVymZTTnrs+PMch7p4EJ
	 pslA2XsT3ik9C1pZU/kju+bPppN2G3sad396d38wo3yqZsFrtYyY1jBmobbRt9mGHI
	 r23bvPynjzG/Y6Fuo6nuTsNtEpePsji9uRj51gVF8YEKilo7U3S0rYPEu/wGxvbsjh
	 W7JlyjmEaacyN+qJtBzQsx2EAGAcgYXLAEKZig6a5omNNzZ3E+S5vKI487twBQtf6n
	 b05zlMAaGn8lA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:20 -0500
Subject: [PATCH 3/6] ARM: dts: aspeed: Add missing "ibm,spi-fsi"
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-3-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

The "ibm,spi-fsi" compatible is missing or incorrect in various nodes.
The incorrect cases used the "ibm,fsi2spi" compatible by mistake which
is the parent node of the actual SPI controller nodes.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 24 ++++++++++++++--------
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     | 12 +++++++----
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     | 12 +++++++----
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 9961508ee872..52a044b1e454 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2808,6 +2808,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam4_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -2824,6 +2825,7 @@ eeprom@0 {
 			};
 
 			cfam4_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -2840,8 +2842,8 @@ eeprom@0 {
 			};
 
 			cfam4_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -2857,8 +2859,8 @@ eeprom@0 {
 			};
 
 			cfam4_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3181,6 +3183,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam5_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3197,6 +3200,7 @@ eeprom@0 {
 			};
 
 			cfam5_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3213,8 +3217,8 @@ eeprom@0 {
 			};
 
 			cfam5_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3230,8 +3234,8 @@ eeprom@0 {
 			};
 
 			cfam5_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3554,6 +3558,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam6_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3570,6 +3575,7 @@ eeprom@0 {
 			};
 
 			cfam6_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3586,8 +3592,8 @@ eeprom@0 {
 			};
 
 			cfam6_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3603,8 +3609,8 @@ eeprom@0 {
 			};
 
 			cfam6_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3927,6 +3933,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam7_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3943,6 +3950,7 @@ eeprom@0 {
 			};
 
 			cfam7_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3959,8 +3967,8 @@ eeprom@0 {
 			};
 
 			cfam7_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -3976,8 +3984,8 @@ eeprom@0 {
 			};
 
 			cfam7_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible = "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
index 07ce3b2bc62a..06fac236773f 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
@@ -82,6 +82,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam0_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -98,6 +99,7 @@ eeprom@0 {
 			};
 
 			cfam0_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -114,8 +116,8 @@ eeprom@0 {
 			};
 
 			cfam0_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -131,8 +133,8 @@ eeprom@0 {
 			};
 
 			cfam0_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -249,6 +251,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam1_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -265,6 +268,7 @@ eeprom@0 {
 			};
 
 			cfam1_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -281,8 +285,8 @@ eeprom@0 {
 			};
 
 			cfam1_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -298,8 +302,8 @@ eeprom@0 {
 			};
 
 			cfam1_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
index 57494c744b5d..9501f66d0030 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
@@ -733,6 +733,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam2_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -749,6 +750,7 @@ eeprom@0 {
 			};
 
 			cfam2_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -765,8 +767,8 @@ eeprom@0 {
 			};
 
 			cfam2_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -782,8 +784,8 @@ eeprom@0 {
 			};
 
 			cfam2_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1106,6 +1108,7 @@ fsi2spi@1c00 {
 			#size-cells = <0>;
 
 			cfam3_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1122,6 +1125,7 @@ eeprom@0 {
 			};
 
 			cfam3_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1138,8 +1142,8 @@ eeprom@0 {
 			};
 
 			cfam3_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x40>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1155,8 +1159,8 @@ eeprom@0 {
 			};
 
 			cfam3_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
 				reg = <0x60>;
-				compatible =  "ibm,fsi2spi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.2


