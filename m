Return-Path: <linux-kernel+bounces-766541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A9B247EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ACF5A4823
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0E82F7441;
	Wed, 13 Aug 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg/PLN6s"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD412F659A;
	Wed, 13 Aug 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082839; cv=none; b=Paswj1Us+82lHgLz9ruPngdGpZkKziN8RxI1KRYRM8ARXybz59AKR/QoFrXbIZyOmO/p3ubttRzE0sFFxXJhyJ2uqNwVRZMfSVfprgI2HrJJCHjoEYezHXB5fTNeU2GpUO0/o/tN8X0lobshPmPdxeaNrEJdLRyK9ma5gP/HSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082839; c=relaxed/simple;
	bh=h392+mnpg7XL/aXcx1eoF94ujTiYzX21EL9Uh5HDyNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JC1l2sU9BlXkI6zb6vKV5IVLf/51WyZFm1Pp7bpmLzRPQBjpgX1lgsLqZz56k0wEr768bqwlgLtKoxF6hpJruAD2KMFoK4jUqbs7AM3TJ7QXiRJyFO4cb7NWp6M2MOMYLAJa3ex4Ne/fukE4jjjKASLiBzb/kyaRolc0PPi7Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg/PLN6s; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af922ab4849so985767066b.3;
        Wed, 13 Aug 2025 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082836; x=1755687636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZfW10zFYbqBNwsmMYYxG2KbvaoSIbM1bx9G5szi1GA=;
        b=Dg/PLN6sSFCqzly5VT2yz2rcKnAgXY6kV5JaTf3LO4897aY5kBCUO7dZ61tsWeCGt5
         W+FpD/w9zeanItO0UbQmzLLQQDEzuk60Vxcb8UliEZMJJ+q5ayWBqqeE1cLxmKTJ11ts
         /W9YqH7WrVj2fmA/V8jfSCaG1rW2QUI4CAqb6vhzx8FdGIUEJkO1sb0O0x+fVVEZVsCV
         uIcNcHWJhv48KTlpbyl65VzaOwn+PUKP7D9UK02Hl6zl44xMzY6N+EgbjSB6dad+b5Ar
         yF6B9i6fOXYx8z7UFErQM4YkHLc9groaKt1Dj2tj9RJ3OsNwHjfh608dGmJIPz7/6bUv
         No6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082836; x=1755687636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZfW10zFYbqBNwsmMYYxG2KbvaoSIbM1bx9G5szi1GA=;
        b=oHcGgR2c98XUt+J+3lZaaZmImIfOsiy2gkh9lzey1e19qgT4bOpgWVBY0whirkbp28
         97hFdqdSdsay4jYKwmvckTWVziFk2KJdrAnd842fwl5sL7vc3ueL5W0jtjSlfJFikuqY
         F/5SFtBIXxmBeuTW8+KxxvpjFQgVDih9bosPR5jB6fNcZAjb8xMgP0XBTBXhTEPlJmbX
         ORB3pC9wO6hbOgHqlirOqPCORECCHKxUii6KUqw1SluOueYGtwX2CFW+K0OrSlfOzspQ
         bXSeIjoynOv3EtAiVrPgpEYfXSuOR51R4u7oETYeNgK7xTe8/XA4RsoKu8OxoVQ5wqy4
         iRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV570CJg/fD92MBCGL+G0cDN7mp03Nc+z8/SObKg96RgmoeBuI15YPaATG1EGpaMy2NzsdIq9YgdNp8@vger.kernel.org, AJvYcCWUpvLnBCfvlyVsd8GQd+9qR4/RHhgxpSEW6N6i2d7mb+SJdSjP8sCjGrTvIFXoGY+D96CurKrjegL2@vger.kernel.org, AJvYcCXFJJrWpsmUvPlop2K2IjyOQt1YHTwtKFAsUORDrInbQmxSXyo8cmkqZLu42TRcZ7vrUTMgg1j49wET7ao0@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDFGrNNm7tN8B/6JMceCgyU8Iz3Y3wxcbAuMsHpMYoYp9Vt96
	wNKX/wV/4cmksHUQzt3l4LcEcJApziojLXZSEuBo6X9BhUOEcE7ZR3CT
X-Gm-Gg: ASbGncvVpYjrr+g0d6Owx1e9xvggMcE7/QdHUgeL4lCw9hCka8umMXXfKieamDu10EN
	4PZZ9W8BbKbUQV9fRRLTRJlZ7WfY6z6Vn8GuVIVyRQyA3GGXM0HLAwfIP3DYNw1jdlEYB3EGveS
	x8lbt4Czif0h/+e89oZmJT4qZsuYUo3hx79DtTR5adsQtzo4MDgngUTbp2pVkD38hG+c2i5GMOC
	BFimyFQDePQ+dBcXPw2HMGu0XNDUK4fev5WvAG+TycLXHeROXbR03O9cB5Sm9G3Bv3n5BZ9Bjyi
	rYhk24wdAxg9HQr5GU3VnfJauBaRQAXVAcuPEditrKYRcaHlPmpimtsbjCtJ/xd40zuO+zguuYW
	KnIu5m2whQbrMzfWRvoPtrrbfh6omJTKWouSIF+66K8G7V8m3viqlN6OLU7zZHHovt6rl6Gsm+Q
	vfHNM6
X-Google-Smtp-Source: AGHT+IHBVpEx8bhMMYRCjTIGjv0d9XitVwLkFklyI52qfh6/v+GfxUm3Hg0LhC3860E0Az0OXPHb/w==
X-Received: by 2002:a17:907:3f98:b0:af3:7645:43e1 with SMTP id a640c23a62f3a-afca4d011c3mr285818566b.17.1755082835744;
        Wed, 13 Aug 2025 04:00:35 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:35 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:14 +0200
Subject: [PATCH v6 8/9] ARM: dts: bcm2166x-common: Add matching bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-8-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
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
 bh=h392+mnpg7XL/aXcx1eoF94ujTiYzX21EL9Uh5HDyNo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA+FPFwVaGa67+guCmLndtPZd2mh94+S+aNC
 +bD7m65ftSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPgAKCRCzu/ihE6BR
 aM4lD/9ZThn4HMMUj01QvCYJZvSBvvL4SEEOnUmiqPFbsAroJrs65IGe6cnq8XWZihOlrNsHYaX
 prWjLiJGWhoqAS8SN30qVKpjj7KQaT6nxO1jeywZ2K1cnhg6/o7xnmVxuWKo9BL6e8e3klsw4NL
 n41b2m1nIzco3q7V/I2w/kvTj6D2PtVFsZNPa/grf8qKWcJJBMVoI95KnKDY3XtX/AR1XM3m2eo
 Zw73tC3mPynqsX6brsgMVsQkwBruX5DgVmRSpS7dFSBFDTgDUs7MxAQbpYSQAFiKqMtRuKJV2qp
 d3CG9sbqYooQkyimKXF+XVlbvTJfymJyvUbRvOpQtSm77Zy2oOJzQ0I6T2FRCm9wwAGvVLnvGXF
 piYrpg6swLCXkaotbciu7W2yp8g3wBVMJptVAxacILCbWoy8RbLipQvH4o8KSQZ8v2ZHyYGlyDa
 3srvDozPhLStuS4/wrZTk2sY5F+sMncG5UtaYXTysU1AIj4MmtZBlF6tEmZWftbLxy57umDzc83
 Suks8fpGbWtKcqay8EfZS5q0rWH6F1K8Wr9Wi1V0tgVHIxXG2Yxu/GKILQjvD5SvbUX9g/EaYUM
 qwhKRC2r1CWSOi6nJMefJu1QRiDnvhwv3SVrKdizsiJgbEKIXLUV8FWl5x8YZy+crX1V++oapnE
 Xk/9UbF+IF8wNgA==
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
2.50.1


