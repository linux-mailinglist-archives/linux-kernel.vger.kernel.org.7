Return-Path: <linux-kernel+bounces-730138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A68B040A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6AE188881C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6EF254AF3;
	Mon, 14 Jul 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOm10/54"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74F1991B6;
	Mon, 14 Jul 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501286; cv=none; b=Lp83SwNwe9FRKBOeL3n4uVHfKndiH36W2i+bn57h6GGt7aswi//DZgmKLIf3+DsOucDoJsktgU4B6W8ppp8CnKEVZvV4t0by79hOGYMMfhHbowFQj1+ww6je4FY9jyazRpqE2h/25tVLJEztzincwORPZzdPBo4Zk/9A2X+qlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501286; c=relaxed/simple;
	bh=gS1HbsK2yctgEQPDYKhh1GC/x/c/E9cYrQK8O0dE8Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGKkI3Qt5M3HQQsQ8kwpW0mbghF6xskSIzm1s7YfgPXp2wT1B6PoilDgt2j9lf8qjdrFxBqwPuf4m9o3qc9Zl3iv5MxfULmWxHkPIRourMrfEyJD56ziOYFyjhgu3t9Fx4s6rspSgieN72cAharqaRmEgOFaqri+r6IdK+Q1XJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOm10/54; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2846360f8f.0;
        Mon, 14 Jul 2025 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752501283; x=1753106083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGSW5MLOnZEjMDuGJkkmT4oAKQwsUUEgTK+EsICMEXA=;
        b=IOm10/54DlwM+7qboseOAnr4pWJCOsLpJ9AnNIo11IH7lBJeNcOs452Z2GGGMJB9Mj
         /WeudyG+V/GaV6CdoNQryJJMeajB6MsP9C3Bu9Dh2R9hpEKcIvz+MOSuTU+3afRoQjLk
         52VyQehvAteiXUFk+1N33BJVhqHHFEC2TpVf9QsnJFPZigliFtf++Yo4pKBZD3StFwtz
         EXyA7rAfE4UzLW/eVzn+Ryi61MhflnJJCz01yCgxvPKNxcYL1EUqZkBmLu0P+Yzwgytn
         VpbwHMNJM/+M2jjKx6nHicDgaCTJOMub9QJ35sGVlo5FXMSgLoiuOS/H3gbIUladjC/v
         Uawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501283; x=1753106083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGSW5MLOnZEjMDuGJkkmT4oAKQwsUUEgTK+EsICMEXA=;
        b=NRpoj2f0VJRRJD0+ZLdIJlbmxOGDsYefT+NrQaj3ogLBuHSR8cdULkHM0xkn/eDmZ3
         8M7PcHyT/wMRpN0Iz9JLrIbUaZWHj34CUiOhU1liMvoNUOgPiU/wXLnaLeaJJCqyUBxb
         G6ci7WvgafQx58sfmb7+PBjKl95IuWU826zOWEgtvQflv/UQLQXLhSMSxlbVVNa0MVmm
         y7nEL6yRm88+NQd7ZSm66SrBsXMSQGfhIaXOCFaBDb0pw+95Gu2qcO8e4Gj8NjsCq8kY
         1axtpg2u/nWmDfxa8zTrf5f/8E7Suc+FYE8z5r24oLJskIUPnxO/wQMyb1Xbdq/Swee6
         Fu0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7koxW6Qchz9i5gDd4o+0/AnHCQAnB0Oa6OFgfR9mxGFVe4K36JTpfq/sBM4hlW/16e2JE5vysFmAvZWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03O47C/QVX+VLXCuHweiaHB75XRW3DeW8aCf90JepEfXBs7bf
	s3eF0y9LRbm1tdUugmY1rgxnDz7Z8XTsTAM3o/tvlSLso438ylOXUgav
X-Gm-Gg: ASbGncsSdUnKTSlgY/mXgdBOREc38v4c+G9V5LHluuhS/o0b7fD+6KfXGn2aYHXuoq9
	rL02O0loxPZOVGT+agY/sqR+xF7u/jP0nYihn8D1FIrkhG9cGc7KNu+nCBhWRwDfe1FDI1hN0bx
	VAMuCInDaiVP0LslNeLFaLgpAXdaSP8DjiAs2YFc+nFP97gItT9EXZsI+UwN2LZZeZdKgLT1H7I
	Zs9YGVOC5l7MTF9AvDZxZZnfL4VlpD2ll6Cb6gZHt4cHk/U/prJoVJGLFXE9okijkV4UhTAJgEo
	8a9RaozapxoYhbQuGRB3k+lPhAp6Gij4qHIVlBaxXoJdZnIeAGJcrXNCGdaPiC5+woq4hKYm1QT
	QccQF9amLWKaisqtBtjZV0TM=
X-Google-Smtp-Source: AGHT+IGaU+UDih96eKQ4dgwKsHDyHJyLAccNsew+b1d6tv9wc/n8r3uyLDS7ST9d+p33NMDRDWhdaA==
X-Received: by 2002:a05:6000:2f86:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3b5f1c67becmr10006414f8f.1.1752501282870;
        Mon, 14 Jul 2025 06:54:42 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e1e332sm12556025f8f.79.2025.07.14.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:54:42 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 14 Jul 2025 15:49:14 +0200
Subject: [PATCH v2 1/3] ARM: sti: drop B2120 board support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-sti-rework-v2-1-f4274920858b@gmail.com>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
In-Reply-To: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12621;
 i=rgallaispou@gmail.com; h=from:subject:message-id;
 bh=gS1HbsK2yctgEQPDYKhh1GC/x/c/E9cYrQK8O0dE8Pk=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBodQwgsVm49yK9d/PpaeY9cyOkQQMjt+PLKNAMB
 oS95GDKKBmJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHUMIAAKCRDnIYpo1BLC
 tdWgD/9TyiCXqFEk43mN7BqfPPIXvwFHp/Z7Zn0koY158gtkxQxaYvrgjfvuhqRgf6/hAUmKPM+
 p4GtrEGtrowBV/q4Y4TO3fp/HuKJAzEi8Ue4YnUdp8IPQMiqHsBbSNOTXt+okPP6pnGtZMz6i9H
 kEb2yS4J0N7Bv+WtD0ZPOGfdJHJd1RMdnxZVX44xC84PO+nyy/3XfIty44Hkr7bhmRUnZSXRBFy
 7YFjxxShPTs2zEXcKT0h1kSsi5OAV7TGVSdM6G+dt5a+Kt3WovHtAOZFDSZl2yaMT+BSHvRfSbG
 pzqKu0XMXOzCyUwWyxGsTO3FqLxm3FaU0M/fEAUUGxllu6BN9cDnaUN5hnDgixS5Rwl5ZOmC7l7
 ZIL0MtNmuZe7ymCOkeaw1wDcSWmXMpNgfFgKg7hcQPDwovEQUCp9lVn+dD/+GsrCvN5BveeT/Yr
 wvLPO/jp2qrbGIoS5Oa+s2AHnKAwOZ+qu9Www4q8boyz2Uuhnv6c/e8k+lI/Pxf2ob86fTAX3Qm
 KGxBkW6HY/pPckOJwldTZ1Vdd1VF4KpvjRtHytsZGNLz+q4P8VsLXLSlsyXQgGW28o8aOeScYU1
 b3AQjdsmJOzn7+Q2UpWs5JrNOvdzJ6aHp89OZH7G7yU6pDHSr6NRZIQyZOMUbqqU2zzVXheQQRF
 q2VBGqNe2axVOOw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

B2120 boards are internal boards which never were commercialised.

Drop them.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/Makefile           |   2 -
 arch/arm/boot/dts/st/stih407-b2120.dts  |  27 -----
 arch/arm/boot/dts/st/stih407.dtsi       | 145 ----------------------
 arch/arm/boot/dts/st/stih410-b2120.dts  |  66 ----------
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi | 206 --------------------------------
 5 files changed, 446 deletions(-)

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index cc9948b9870f7f73629573149bfd342af75b07da..f57fc6dc48a00c9a9323b4508e5e4e161b197c47 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -13,8 +13,6 @@ dtb-$(CONFIG_ARCH_SPEAR3XX) += \
 dtb-$(CONFIG_ARCH_SPEAR6XX) += \
 	spear600-evb.dtb
 dtb-$(CONFIG_ARCH_STI) += \
-	stih407-b2120.dtb \
-	stih410-b2120.dtb \
 	stih410-b2260.dtb \
 	stih418-b2199.dtb \
 	stih418-b2264.dtb
diff --git a/arch/arm/boot/dts/st/stih407-b2120.dts b/arch/arm/boot/dts/st/stih407-b2120.dts
deleted file mode 100644
index 9c79982ee7ba8fadb1a2a92e732bf7f652b74c38..0000000000000000000000000000000000000000
--- a/arch/arm/boot/dts/st/stih407-b2120.dts
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
- * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
- */
-/dts-v1/;
-#include "stih407.dtsi"
-#include "stihxxx-b2120.dtsi"
-/ {
-	model = "STiH407 B2120";
-	compatible = "st,stih407-b2120", "st,stih407";
-
-	chosen {
-		stdout-path = &sbc_serial0;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
-	};
-
-	aliases {
-		serial0 = &sbc_serial0;
-		ethernet0 = &ethernet0;
-	};
-
-};
diff --git a/arch/arm/boot/dts/st/stih407.dtsi b/arch/arm/boot/dts/st/stih407.dtsi
deleted file mode 100644
index aca43d2bdaad44ef2a0e8a120c679c217709af44..0000000000000000000000000000000000000000
--- a/arch/arm/boot/dts/st/stih407.dtsi
+++ /dev/null
@@ -1,145 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2015 STMicroelectronics Limited.
- * Author: Gabriel Fernandez <gabriel.fernandez@linaro.org>
- */
-#include "stih407-clock.dtsi"
-#include "stih407-family.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-/ {
-	soc {
-		sti-display-subsystem@0 {
-			compatible = "st,sti-display-subsystem";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0 0>;
-			assigned-clocks = <&clk_s_d2_quadfs 0>,
-					  <&clk_s_d2_quadfs 1>,
-					  <&clk_s_c0_pll1 0>,
-					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
-					  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
-					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
-					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP1>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP2>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP3>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP4>;
-
-			assigned-clock-parents = <0>,
-						 <0>,
-						 <0>,
-						 <&clk_s_c0_pll1 0>,
-						 <&clk_s_c0_pll1 0>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 1>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 0>;
-
-			assigned-clock-rates = <297000000>,
-					       <108000000>,
-					       <0>,
-					       <400000000>,
-					       <400000000>;
-
-			ranges;
-
-			sti-compositor@9d11000 {
-				compatible = "st,stih407-compositor";
-				reg = <0x9d11000 0x1000>;
-
-				clock-names = "compo_main",
-					      "compo_aux",
-					      "pix_main",
-					      "pix_aux",
-					      "pix_gdp1",
-					      "pix_gdp2",
-					      "pix_gdp3",
-					      "pix_gdp4",
-					      "main_parent",
-					      "aux_parent";
-
-				clocks = <&clk_s_c0_flexgen CLK_COMPO_DVP>,
-					 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
-					 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
-					 <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP1>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP2>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP3>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP4>,
-					 <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>;
-
-				reset-names = "compo-main", "compo-aux";
-				resets = <&softreset STIH407_COMPO_SOFTRESET>,
-					 <&softreset STIH407_COMPO_SOFTRESET>;
-				st,vtg = <&vtg_main>, <&vtg_aux>;
-			};
-
-			sti-tvout@8d08000 {
-				compatible = "st,stih407-tvout";
-				reg = <0x8d08000 0x1000>;
-				reg-names = "tvout-reg";
-				reset-names = "tvout";
-				resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
-						  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
-						  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
-						  <&clk_s_d0_flexgen CLK_PCM_0>,
-						  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
-						  <&clk_s_d2_flexgen CLK_HDDAC>;
-
-				assigned-clock-parents = <&clk_s_d2_quadfs 0>,
-							 <&clk_tmdsout_hdmi>,
-							 <&clk_s_d2_quadfs 0>,
-							 <&clk_s_d0_quadfs 0>,
-							 <&clk_s_d2_quadfs 0>,
-							 <&clk_s_d2_quadfs 0>;
-			};
-
-			sti_hdmi: sti-hdmi@8d04000 {
-				compatible = "st,stih407-hdmi";
-				reg = <0x8d04000 0x1000>;
-				reg-names = "hdmi-reg";
-				#sound-dai-cells = <0>;
-				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "irq";
-				clock-names = "pix",
-					      "tmds",
-					      "phy",
-					      "audio",
-					      "main_parent",
-					      "aux_parent";
-
-				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
-					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
-					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
-					 <&clk_s_d0_flexgen CLK_PCM_0>,
-					 <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>;
-
-				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
-				reset-names = "hdmi";
-				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
-				ddc = <&hdmiddc>;
-			};
-
-			sti-hda@8d02000 {
-				compatible = "st,stih407-hda";
-				reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
-				reg-names = "hda-reg", "video-dacs-ctrl";
-				clock-names = "pix",
-					      "hddac",
-					      "main_parent",
-					      "aux_parent";
-				clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
-					 <&clk_s_d2_flexgen CLK_HDDAC>,
-					 <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/st/stih410-b2120.dts b/arch/arm/boot/dts/st/stih410-b2120.dts
deleted file mode 100644
index 538ff98ca1b1b6542f98a18f68968f030b8c55c0..0000000000000000000000000000000000000000
--- a/arch/arm/boot/dts/st/stih410-b2120.dts
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
- * Author: Peter Griffin <peter.griffin@linaro.org>
- */
-/dts-v1/;
-#include "stih410.dtsi"
-#include "stihxxx-b2120.dtsi"
-/ {
-	model = "STiH410 B2120";
-	compatible = "st,stih410-b2120", "st,stih410";
-
-	chosen {
-		stdout-path = &sbc_serial0;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x40000000 0x80000000>;
-	};
-
-	aliases {
-		serial0 = &sbc_serial0;
-		ethernet0 = &ethernet0;
-	};
-
-	usb2_picophy1: phy2 {
-		status = "okay";
-	};
-
-	usb2_picophy2: phy3 {
-		status = "okay";
-	};
-
-	soc {
-
-		mmc0: sdhci@9060000 {
-			max-frequency = <200000000>;
-			sd-uhs-sdr50;
-			sd-uhs-sdr104;
-			sd-uhs-ddr50;
-		};
-
-		ohci0: usb@9a03c00 {
-			status = "okay";
-		};
-
-		ehci0: usb@9a03e00 {
-			status = "okay";
-		};
-
-		ohci1: usb@9a83c00 {
-			status = "okay";
-		};
-
-		ehci1: usb@9a83e00 {
-			status = "okay";
-		};
-
-		sti-display-subsystem@0 {
-			sti-hda@8d02000 {
-				status = "okay";
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
deleted file mode 100644
index 8d9a2dfa76f1fe55b954803cab8d00003a8ebec0..0000000000000000000000000000000000000000
--- a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
+++ /dev/null
@@ -1,206 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
- * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
- */
-#include <dt-bindings/clock/stih407-clks.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/media/c8sectpfe.h>
-/ {
-	leds {
-		compatible = "gpio-leds";
-		led-red {
-			label = "Front Panel LED";
-			gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-		led-green {
-			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-	};
-
-	sound: sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "STI-B2120";
-		status = "okay";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		simple-audio-card,dai-link@0 {
-			reg = <0>;
-			/* HDMI */
-			format = "i2s";
-			mclk-fs = <128>;
-			cpu {
-				sound-dai = <&sti_uni_player0>;
-			};
-
-			codec {
-				sound-dai = <&sti_hdmi>;
-			};
-		};
-
-		simple-audio-card,dai-link@1 {
-			reg = <1>;
-			/* DAC */
-			format = "i2s";
-			mclk-fs = <256>;
-			frame-inversion;
-			cpu {
-				sound-dai = <&sti_uni_player2>;
-			};
-
-			codec {
-				sound-dai = <&sti_sasg_codec 1>;
-			};
-		};
-
-		simple-audio-card,dai-link@2 {
-			reg = <2>;
-			/* SPDIF */
-			format = "left_j";
-			mclk-fs = <128>;
-			cpu {
-				sound-dai = <&sti_uni_player3>;
-			};
-
-			codec {
-				sound-dai = <&sti_sasg_codec 0>;
-			};
-		};
-	};
-
-	miphy28lp_phy: miphy28lp {
-
-		phy_port0: port@9b22000 {
-			st,osc-rdy;
-		};
-
-		phy_port1: port@9b2a000 {
-			st,osc-force-ext;
-		};
-	};
-
-	soc {
-		sbc_serial0: serial@9530000 {
-			status = "okay";
-		};
-
-		pwm0: pwm@9810000 {
-			status = "okay";
-		};
-
-		pwm1: pwm@9510000 {
-			status = "okay";
-		};
-
-		ssc2: i2c@9842000 {
-			status = "okay";
-			clock-frequency = <100000>;
-			st,i2c-min-scl-pulse-width-us = <0>;
-			st,i2c-min-sda-pulse-width-us = <5>;
-		};
-
-		ssc3: i2c@9843000 {
-			status = "okay";
-			clock-frequency = <100000>;
-			st,i2c-min-scl-pulse-width-us = <0>;
-			st,i2c-min-sda-pulse-width-us = <5>;
-		};
-
-		i2c@9844000 {
-			status = "okay";
-		};
-
-		i2c@9845000 {
-			status = "okay";
-		};
-
-		i2c@9540000 {
-			status = "okay";
-		};
-
-		mmc0: sdhci@9060000 {
-			non-removable;
-			status = "okay";
-		};
-
-		mmc1: sdhci@9080000 {
-			status = "okay";
-		};
-
-		/* SSC11 to HDMI */
-		hdmiddc: i2c@9541000 {
-			status = "okay";
-			/* HDMI V1.3a supports Standard mode only */
-			clock-frequency = <100000>;
-			st,i2c-min-scl-pulse-width-us = <0>;
-			st,i2c-min-sda-pulse-width-us = <5>;
-		};
-
-		st_dwc3: dwc3@8f94000 {
-			status = "okay";
-		};
-
-		ethernet0: dwmac@9630000 {
-			st,tx-retime-src = "clkgen";
-			status = "okay";
-			phy-mode = "rgmii";
-			fixed-link = <0 1 1000 0 0>;
-		};
-
-		demux@8a20000 {
-			compatible	= "st,stih407-c8sectpfe";
-			status		= "okay";
-			reg		= <0x08a20000 0x10000>,
-					  <0x08a00000 0x4000>;
-			reg-names	= "c8sectpfe", "c8sectpfe-ram";
-			interrupts	= <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
-					  <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names	= "c8sectpfe-error-irq",
-					  "c8sectpfe-idle-irq";
-			pinctrl-0	= <&pinctrl_tsin0_serial>;
-			pinctrl-1	= <&pinctrl_tsin0_parallel>;
-			pinctrl-2	= <&pinctrl_tsin3_serial>;
-			pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
-			pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
-			pinctrl-names	= "tsin0-serial",
-					  "tsin0-parallel",
-					  "tsin3-serial",
-					  "tsin4-serial",
-					  "tsin5-serial";
-			clocks		= <&clk_s_c0_flexgen CLK_PROC_STFE>;
-			clock-names	= "c8sectpfe";
-
-			/* tsin0 is TSA on NIMA */
-			tsin0: port {
-				tsin-num = <0>;
-				serial-not-parallel;
-				i2c-bus = <&ssc2>;
-				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
-				dvb-card = <STV0367_TDA18212_NIMA_1>;
-			};
-		};
-
-		sti_uni_player0: sti-uni-player@8d80000 {
-			status = "okay";
-		};
-
-		sti_uni_player2: sti-uni-player@8d82000 {
-			status = "okay";
-		};
-
-		sti_uni_player3: sti-uni-player@8d85000 {
-			status = "okay";
-		};
-
-		syscfg_core: core-syscfg@92b0000 {
-			sti_sasg_codec: sti-sasg-codec {
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_spdif_out>;
-			};
-		};
-	};
-};

-- 
2.50.1


