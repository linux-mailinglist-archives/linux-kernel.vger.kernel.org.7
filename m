Return-Path: <linux-kernel+bounces-795129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53EB3ED1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252B57B0016
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AF343200;
	Mon,  1 Sep 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwpFIvB/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940C341AA3;
	Mon,  1 Sep 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746506; cv=none; b=GOGMPfM/HQ/yuvShfCqD5k3HbJ+jC/TFG3ef3k2Ak9Jsvjt61tPa6tKbvlh+XUVcIHGmkap3kA0Aibyrlm9X7WTom014mZ+o51OhiObb+6AjlWqN8hHuBpLKTD4TbQczzLr45rF779BNAQpBe3X2yIJgTI6V2Rz3gfze0pD59Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746506; c=relaxed/simple;
	bh=OMng8naVRXMXeI95f6muap+cKQ9MSMRKToTbyrOWZkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXH5x7wzZiUVPjARU2WGIbgp+7o9SzEuJuAattCpD5h5kF1WN11WzCTVWKP1Dtdoc2ECfM9jL0vRqrNEcu9qWstAkAooTqoB6B4A8v8mQYJnAMcnXZl9kMV3q6TnaoR2HtvYkbWH74YNqxatpN9QIBk014vHC5Wbux65be1Knrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwpFIvB/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so1098132e87.1;
        Mon, 01 Sep 2025 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746503; x=1757351303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8P+m7Y/nxWzgTwgV0lOUpGrfM4BscgupyGBe9TnMFyM=;
        b=PwpFIvB/4kQ14uq3/4a0hZaJKo1klkHw4Dz185h6oXZVtAKVPn2QcJ9wjFdsSaEYw6
         uH4lT46Q/sokn1YMgspRqQFDwak0+3gSI8/Oivsc9JZrRlXR+lBNDR3VDjjzb72FrJ/T
         92z3IarzoK+Vb9kR4FAFEcfc2H7WZdPLvSMYpOKpjKrmUss+8g4pCOtYKbOisgz9qsqT
         RRAKjiw6/CivpLPd3ZtDjRVPoVt+FGBJmWcyEwun8CJOtX1fdlbuQNxRQ+MbK3oRq57Y
         kfU0h148mIBiU94f//VMpF+d0Y87NaEFlfYLr/NYtxT/L9pag4jlmQT0fsPcGY+Vc1nb
         mI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746503; x=1757351303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P+m7Y/nxWzgTwgV0lOUpGrfM4BscgupyGBe9TnMFyM=;
        b=a0ktixEgB+iiXMt10DSDTejU7bvKy/p19H2V2VEOUriYQ9RcU366AcJ6pqZZjOdNA6
         7boupjQC5WVg/xllETlJc47w+Otcv3rfrP6Wnonrs8wkzRvA0FDYDotQbFAVQ97JBKFJ
         7x6FURzqpjE5k8nCxxmFBDVwMD3JvgGcb0SUjrlYscGBDV4TIj94ObWUiGzlEDC6pyai
         8V1DAxZRsyHRTJCSiUFWDLaUjifEH0LTCpGXtm2O2hdZLweUhEOWT9kIkMoUzGGomaHq
         sMmuSdQUDUZI+RY5GupmyNmySAsE0eUv0cpnmCjhy7t+3rD/Tdg5Xqz5wR/8QstfF3ME
         1YFA==
X-Forwarded-Encrypted: i=1; AJvYcCU/RonKaAYG2xcU3hi+4oex//r4/KkbfVLLgiDBMHgJSq0/5w0erRh8yWiSU47Woh/hOgGAXVccKcNC@vger.kernel.org, AJvYcCWp4Mnojv+G81C49TZRfX9qCz6AMO/UT71Zn2HG0wT1f4eQLVrxGExTpFrV9ESYLSSUL1yCUTlAyJ19@vger.kernel.org, AJvYcCXKrF3RNML1NbViX9lml/Eo/4AauoMEA3/l6O8RwGafPHsnlQTzF7bb0RLJR1wSgJ2c2foTax5WfOHShQjW@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuKAyw8hElcAd/l+PDJn8pM4euRuaVQXYhBbvaJ8WUiSNLHjn
	5nevYvZ22rQbVmny/pVtC3d8dVvoknlwilcmBX73/J/SeTv//pnoM9eatEgfXw==
X-Gm-Gg: ASbGncu0m7kjPd20iGvJpQWKIAADUqF85P9arAO+Zp2Sh/myTPQMCEonpIrwZaaiAC4
	JEtq0vjrFN7+Hazw3/QiY4L9iOdQwE2HrCADqERZ22I0oGHR5kYoY/08yT9j9DJ37CTRbIEF33N
	La0/Az8K9UBtlfL0qbFOB8RXZk7yFVR79SjUvhUoZc+0LyaII4q4bPYOo18LPPM2AN+i3duDptd
	ZGv9v3QoSKPljvM4hBuGuU9V7ONasCkNl5P3Uf75yYb3KAUcMeqkOWJgJhMKdJRoEjr/0xp7OOM
	177s4z2DRO2jxAfHCY2kEd/mhFkgsVdBUHHhIQszTUKoXQF49KFQ7VRWTR2FeJpv8550dpXIzsS
	ZHgQ8+xdVO4XLPxkYeXSLDTRqr8mnQ72QwuU=
X-Google-Smtp-Source: AGHT+IELIB4bITlhgOPTurMm6oZh59uaBBEBFYTOPZ6U/I2q6zrEZv9FpccN6USg6GENgO5mVScJCA==
X-Received: by 2002:ac2:4bc5:0:b0:55f:3e82:9c7f with SMTP id 2adb3069b0e04-55f7099a779mr2066829e87.51.1756746502867;
        Mon, 01 Sep 2025 10:08:22 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:22 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:14 +0200
Subject: [PATCH RESEND v6 8/9] ARM: dts: bcm2166x-common: Add matching bus
 clocks for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-8-c3ac8215bd4d@gmail.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
In-Reply-To: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=OMng8naVRXMXeI95f6muap+cKQ9MSMRKToTbyrOWZkk=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLKguyUaS87eDMZUI7MCjHhhosHT/OmHzMPf
 bhMLUpCljaJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSygAKCRCzu/ihE6BR
 aD31D/4wuD30cdNOi2kPvIwZvJywOqEaj3s5BdZ2DlFwEsFX+lAI2s/M/iajO3yN5lL1Tt0ntIh
 N/bv3O/Vm3yolUmy9rhV/r1LP3t5g+HAtNtmRuZ+21JYrrugcP57seO7iEwupUmHZwBRLe9/PyR
 AbP3YVWI1gEqBVXLUIX7Yc9+2WDpJtERhMAhJ+koHgvBPcbZF46P4Xy+4oyBUCRx0lA1TO31YrY
 84FmKasmp0xV8PxGKaWX0SAosUoxTQsThd2H6tCbHv2lPHRcP5MnwE/Zq6O3HiE4DeVklLjDiaF
 tqV5hewKD7xZJcTTvjPzZOCLZ5EArCsmbwdB1GbTFkGO18MIVO+7c8NmMHhsBFqQvTz1t6OUHll
 hbUgi6r7K95BAnCdWYi13G/HYWWwfvisBaIMBoGf+ibkdnic+Abp2y5I0u/iyvWbK6qvpUWQ7FT
 4FBJnuzq8dKZL0mB0N+S9RQvckXngNqMY+AkoBaTibRhTM1No42pU9AfgiXhRoxbT5XuHO4f0dA
 0lN1Dy1epfe2p0QoV1Wogsfpw6SgIxuj54Ax0MxZ+XXdz3VIsuqGomGZKSaGih5lowX20yl6x32
 h554c1b47jM1zbU1l4zoegZNII5gh2XNXuH8j584PsOVFQsqF5q+db4virt5jOgW8SbGw5iSbeL
 hDrAZCdLawi0CEA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Following changes in the clock driver, add bus clocks for timer, SDIO,
BSC and UART to the DTS clock output names. Replace the usb_otg_ahb
fixed clock with the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Change commit summary to match equivalent BCM281xx commit
---
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
index f535212cb52fec0668abfc06e7268bead70d958a..b8a6b81d2b7cac00cf393ee37aae4dcc379e487c 100644
--- a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
@@ -148,7 +148,7 @@ usbotg: usb@e20000 {
 			compatible = "snps,dwc2";
 			reg = <0x00e20000 0x10000>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_otg_ahb_clk>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_USB_OTG_AHB>;
 			clock-names = "otg";
 			phys = <&usbphy>;
 			phy-names = "usb2-phy";
@@ -253,12 +253,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -306,7 +300,8 @@ aon_ccu: aon_ccu@35002000 {
 			compatible = "brcm,bcm21664-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
+			clock-output-names = "hub_timer",
+					     "hub_timer_apb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -319,7 +314,15 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "bsc4";
+					     "bsc4",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "bsc4_apb";
+
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -333,7 +336,12 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio1_sleep",
 					     "sdio2_sleep",
 					     "sdio3_sleep",
-					     "sdio4_sleep";
+					     "sdio4_sleep",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_otg_ahb";
 		};
 	};
 };

-- 
2.51.0


