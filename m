Return-Path: <linux-kernel+bounces-795131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4768B3ED2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD11A815F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C863451C8;
	Mon,  1 Sep 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXiCTppp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45114343D70;
	Mon,  1 Sep 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746511; cv=none; b=PPJXHsAtbPQ6gkPlWOyI7qxcnCa7HsujlwMFaMMWpRdKd08EHwlJV//zOtmKJkyaKPaXaF0QUCMD8O1Zdq+z0JQbkM3WiWtyYpeAmmcqHsIYRsLxaE7nNF/BqTJuFKJpeSqIhpzON5DRtTUeRAnEO91YFXuoRGzzx1mjSdcru78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746511; c=relaxed/simple;
	bh=jZ6SN7U3gtrOXPIdIQzLylVY/8dXMuB4ayQmv6+f1VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MtecuHB6JfZz5jadZNerblmHPJn8kyo48n8I3pkkG9uOFwKVGj2QqSOr8KxIIUWN6i8X4cklU9NmtL7NFqzFNE+N61hIKBFPzoRbxiHxPpOL4MjcI4KvVzBPmMT6P/hlUNALOga0XKnn050NRG6chNls9yhiF/lEQuSI1Q1XHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXiCTppp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f6aef1a7dso2960420e87.0;
        Mon, 01 Sep 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746506; x=1757351306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzcedc5ariPE0ii4husYv8u/WHZjFrvu0Oy0OmgexK4=;
        b=dXiCTpppEA2K+P/TtAfX78rgLv7QnfBU/ynp4eXe+NvViz+YDZMBb3UCtprWzvHD8y
         2cEucH4RZWYHX11n6z9RrAmNWXuQ5StbAvqzstaXx0bzYDbH8wAX+XML5pJpYgFlZ7m8
         vHx0TiRxHF47aW5ZmCaIrRUXrq0wmrevs+gn4KF/m9tGWOjSa+xnOxWaEQRmJPwiLRaK
         kJ8lfkGjCeZulm/2E37FGfBPo04NrNok5Jmd1l+dkmibkFaDhQt0tEvyVdpIXZJ5aSVB
         TGQTv1sdth3aO8FLE6qrI8H+5U8mZGN6dfYmFltdpiisS7oclfY+jTdV+Agx8xhNi9XC
         ljjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746506; x=1757351306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzcedc5ariPE0ii4husYv8u/WHZjFrvu0Oy0OmgexK4=;
        b=a6Bb+7ftm8wvoRcL+0yWR6+4B9g1JC439ZOFleOc+0Fg4jGMBxNWqPlFaXFhKSqbVm
         jNIcLR1tUQZZBwha9VwgV01T82K6MlOrRxRSuRgfrQVUGsKl3GMD0CA3aWhngH+5iAaS
         0x+gjyvhnp0sD0fCZTTDaIqY+y7W7sCOSe/Bn17BDX9PiVBMCJDPF4yxDPLmgh/IF9LD
         xr8gHABN5bYlZqfzm2FoKpCqddd/13/JdXxp4xTo8aZHzvRdSEqUXkvvpbdXM6iff/bF
         hNDNV4aPfDWpgBSzaTqaRBCZUIchfW5wlgAerp6HS4biYDQ29mx8TkNV+yPcwJlbO9Uj
         Xd9g==
X-Forwarded-Encrypted: i=1; AJvYcCVo7alX6MyuVGjg+guryDqwtigoNwd6JeWTVKCg/PD0mki84/pWxqQNz9ZgSp2ZuLLf+dgm0uxYzKGhL7WH@vger.kernel.org, AJvYcCXL8uGq+KntaLsmzuQpQcw+nKIzQR5oLQ1lYz2H9NsxE+OzpX1RVNVNQr6tp7w9ur1A05Fpab9Cs6aR@vger.kernel.org, AJvYcCXUwD5akKuMqLvYTDXdxnF2QbmNR6PcsxDJ3FLxUptk63pkLgMHGFzbkV7q5yl5vi6eivAJ8kF0MioX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3L2USbYZqnxFlUUNNFSYU2kJRfJmr55f2VKAn2W2VlFJFlnlc
	hcdix3RxxA43ND7jHnLwTlUn7/8CZyVY30JurBtuXddLtoR3koJEW3WHsHexTg==
X-Gm-Gg: ASbGnct7DG5DPML/q21EWdEI8d7cBQ9i39YCAhc/1TTvjvXWomGIcg802bxhzBWoAgX
	6GCW6A9ooID/uJ0Yl0/Sg/g8EqmIAdZm5eZ0e8bllPfddRrvTQoHYp+rYesJG0N5hDpCn6SOmXP
	oVpoAJ1I71oINKroyg0Gi1PUA9+z9ekr/0fAPXvflGkrobd4wFhMrxFU/Dg8UI0qr2wxVDBNput
	DIwDeqLuFHLAZ3RuddjhEtCI9VFsN6FwWcZE6YB46zZVWHl9K7JAjrUyVnWlgGAshzDqHgXXj/8
	YXeErMrikF293Kfl5FQITrMuyBfFSKtdB9IV84TwU/09MxFavpMUg8SwoPj0YPyzULFcihmr9D8
	pwNDG2bPt9JLxHxeiqAgkIzK5TMd2qBdnE9w=
X-Google-Smtp-Source: AGHT+IH3pC8k3xQeBOb/wW4FK2pwYVKYg0crcqd0bKD2RvBOb6fMiSJN0mQaI0dyPcIMeY6TJ6SyCQ==
X-Received: by 2002:a05:6512:3d18:b0:55f:6f76:42b with SMTP id 2adb3069b0e04-55f70995a8amr2636282e87.30.1756746506104;
        Mon, 01 Sep 2025 10:08:26 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:25 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:15 +0200
Subject: [PATCH RESEND v6 9/9] ARM: dts: bcm11351: Add corresponding bus
 clocks for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-9-c3ac8215bd4d@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=jZ6SN7U3gtrOXPIdIQzLylVY/8dXMuB4ayQmv6+f1VU=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLKHjx+ECuGJdyX/Z4riBATTgknEagxk7FP7
 0Dcob8ewOiJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSygAKCRCzu/ihE6BR
 aOGIEAChVctWAwTWP6uIYuZGmmTCvZPBte5WgDTJxGyAwWGzzJZj+CrvdZBOcLVJMIvmJr/DzcI
 TrLz+u6+Q+D+zmu1P0wPm26Xt9upRBGJnWAyv7lHhuPMS1QdUzxEwIgrpyHPtytK2gEXFm/2Ae8
 pn4jac85PbVPK8WJweLR/nVpgEyUVL+7SIARo8qXhq1Sum3AqVAnTewki5+5I7kKDYM5ArDSj9d
 eIZ0B7DDnUJ1cP5QyWNtUYHvOQ9Vl5aUeeQQ5r3z/phqXULjJqxpyfUCJ+VFx5w/82OwUWkm8lB
 O5BwPpd0ZRE0+yhcOqY4junQ1h/DaZAoy7h2utOqcXquBDaYytgB44Vx2HV+IlC8hgxyzeRJXMG
 2uB9FT3iUcjMAhg/+3KIokEJ6UQO4v/Ol900VY5/cx/bs1FTmNkEkdgaidz3kNbCOjBR8mkaLWD
 H1eej5CLmh5EXtQ4WRr+QOrY8VQan12pPqTut1ZZlOU99oowPQzosQ9AucWiQ4c9a0ymkG+kLVz
 g24lxjAXg4c6xmS6ty6ZgoZ9yYVMuLiwOaoAGkqhTaTwqVgrNW3an6UwbKTP8efDTtkUV8iarMC
 4c20Gv9CC5Rx1V7S3GwKf9RuiVTSAayYzn6U5yRLF4iM+eB4avJVd5zwX/SOTgULl5mHjFubcM3
 lDpcBIhS85h6+pA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Following changes in the clock driver, add matching bus clocks for
existing peripheral clocks. Replace the usb_otg_ahb fixed clock with
the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 arch/arm/boot/dts/broadcom/bcm11351.dtsi | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm11351.dtsi b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
index 53857e572080d752732c512ed27f942756d59c46..fac5cf5a46bd9a4b7e09a2e65c3e807d1b4ef960 100644
--- a/arch/arm/boot/dts/broadcom/bcm11351.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
@@ -233,7 +233,9 @@ aon_ccu: aon_ccu@35002000 {
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer",
 					     "pmu_bsc",
-					     "pmu_bsc_var";
+					     "pmu_bsc_var",
+					     "hub_timer_apb",
+					     "pmu_bsc_apb";
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -246,7 +248,14 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio4",
 					     "usb_ic",
 					     "hsic2_48m",
-					     "hsic2_12m";
+					     "hsic2_12m",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_ic_ahb",
+					     "hsic2_ahb",
+					     "usb_otg_ahb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -262,7 +271,17 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "pwm";
+					     "pwm",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "uartb4_apb",
+					     "ssp0_apb",
+					     "ssp2_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "pwm_apb";
 		};
 
 		ref_1m_clk: ref_1m {
@@ -325,12 +344,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-			#clock-cells = <0>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -396,7 +409,7 @@ usbotg: usb@3f120000 {
 		compatible = "snps,dwc2";
 		reg = <0x3f120000 0x10000>;
 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&usb_otg_ahb_clk>;
+		clocks = <&master_ccu BCM281XX_MASTER_CCU_USB_OTG_AHB>;
 		clock-names = "otg";
 		phys = <&usbphy>;
 		phy-names = "usb2-phy";

-- 
2.51.0


