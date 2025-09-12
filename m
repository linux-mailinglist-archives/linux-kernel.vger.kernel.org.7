Return-Path: <linux-kernel+bounces-813823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B8B54B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53BF483A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197D3019DC;
	Fri, 12 Sep 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb4x58F7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9D30102C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677029; cv=none; b=UsUxCWywrkbBf+urrTkD7eim8HDVcetAlImYiFTDOqMXhgxBIx6UvWOt+zuzzCyvI39m+k69mQeIGzia+s+f9+prMuuVIGSNzGSUNOrmxOfVOstN7hWZkC/YAHPebZiCUDJFEKsB3oWF5PEPdFoe46/EnseA/zFqyY4YGbkKdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677029; c=relaxed/simple;
	bh=XF1bRpc0ObWyS+cD2Ghn6MZhsvCJLu5t2zWEmdPQhM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxGVtvHdyH7soQzxiPWQeSXjlrDnY9MKwYvcoOwmDUmQmwS+/mcY5eFjbKcuDFz99D3TphjYhPdIXvJHCMniaLevos7A2HSWJwkIReDuCrJjQ0VtoieRQ3RjU2E0zfj9sCtDAlsTV+AHPKtZjb2bOrylawn8Ijyz047A9yGT4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb4x58F7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so1306531f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757677025; x=1758281825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/EEUIoM/1Dg6RSe9h1HVQ97ZszxaYd8mFPaG1MGvUo=;
        b=Pb4x58F7mHJTVc+aZa3VOsXC9SsATGUBb80D1Q1IdW9ixkAf1IIxHL8bQzQnXnn+3/
         WSPlUDc7yUpg68eCjI6rS0RPW6g7CL6KnLjIj1m4TvPwvvs9Js2YUzHNfsq1KADTUgwx
         pVhaBFKyqkiKy75WZCCEg968EdpEnb2XoE0x1ovRmDds7MpP8rQ0pAwCoMNbGoSY78fV
         GdNe7auO/21wdYKWeBDD5+F9mNNQvwqsjRJbUeuycvRqQJw5d7lcjOxiWH6xaUWUOL8T
         AMiVpjwxMqKMGRZ6DTs8fjId6bpUX077wcoqNnVa3VLFRdfwNs6ioKuvuL6S0WI4StQC
         81zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677025; x=1758281825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/EEUIoM/1Dg6RSe9h1HVQ97ZszxaYd8mFPaG1MGvUo=;
        b=w5pvByNEElEuicSqLtBUtYRCLEtIvO/ynqz1f6Bd3vyef2BjBbgiqdFT83hmZapSAe
         LMTjZ1JxEXDndYuuVAxYMGVPkDx1Y/q7Yn6cxAPqQ0Rhap4APk8yK8rlmBYMOwh+Bhc0
         RQHLZoSbM4s3ncoiK4hQtPBl+NUDCRYOo7ZJTKh4ZgxeEeKovrXojZGXqPKr+xAnJB2i
         m/GxawmPLWa17vcsb0nznCkByBlB1OkfAuIij1YOjmg4fme0RSkcWnoiO59YCOrqQbny
         U9gjIW/OUanAt/pUODaOoDi5lnys4A3bHkK1n3XRtMDRwUoeDlQuQe4hFLkDU2HzX/+7
         D/JA==
X-Gm-Message-State: AOJu0Yz23fjt/H598oOr/bx1o+W+vGKU92Zidwwem9lc4AqbYjrF2T/b
	c+nQJ8LjXTrSkc5DRTcGaPSlWbcryP+K8Xn0tuIJz68l1QFG33P49cChJZ6ASw==
X-Gm-Gg: ASbGnctin7X1aAhppJX/mM6vqkf7M3vCZfIhetF4SI2gWwMHjBuW7BpxqOlqVO26C3M
	DfpXm9X4iGtKUfC1CZHMeSxVTFVwmznByPssk5VITNLJIhDJXr1vO/y6jz2LYUmdKj0au+xHQnC
	DZRqCsAWQ6tLUTV0ywmGSv1R0lfaIc2CpAbivP7j+yytfPEZmq7pvJ3B2uzziq6/F8Ddp8+wUB+
	WnJy+2FW56Qj1dlCTLdfSGnY7EnoIfJVYwBVwafLC0JtESu/YwdDYum8sVx5NgPVYBDqaj18cqZ
	VRtr6Za8RdQWpzaBLbNHPxSZQaVT4dmZM2gjmSa2nJNRsn56E+bPSHSwK9VpMf4XWizogBrmcri
	3uKDxayVXisdafAA/vhTd/w2VTI2tRKpUslfHx1JAvY0q
X-Google-Smtp-Source: AGHT+IGXH4lqI39nCU0zSwguEl4sL5D7Id34fCpD/KDFlB3EXwld0Rm4kgJwdsT+lGfI6UTzewn3KA==
X-Received: by 2002:a05:6000:2384:b0:3e7:484a:7428 with SMTP id ffacd0b85a97d-3e765a3dee2mr2289020f8f.60.1757677025106;
        Fri, 12 Sep 2025 04:37:05 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e760775880sm6350620f8f.2.2025.09.12.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:37:04 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Fri, 12 Sep 2025 13:36:10 +0200
Subject: [PATCH v2 3/5] dt-bindings: media: remove support of
 stih407-c8sectpfe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-master-v2-3-2c0b1b891c20@gmail.com>
References: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
In-Reply-To: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4940; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=XF1bRpc0ObWyS+cD2Ghn6MZhsvCJLu5t2zWEmdPQhM8=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoxAXb1svCIRowE1g1QQat4UmFM71bQvXe2rD2+
 KGnQsQyQoWJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaMQF2wAKCRDnIYpo1BLC
 tf9jD/99nXzgsJvUgyHGXoUSh9VtOb++l1XyokxLYZyOPTjK/t8F7yNgTE5+yGXrXU6ijRF6czt
 1eg3RfPWzUE+6Ze3+SSWwkU9Qjg8ciVueA45rXmHKsXLYhsrXsMRmpaYFI6YHBi12Ua5N9vmBMN
 cNcM5DGxej4+im0bPQXaqA9+YavT0sqq3PbbJGcVKeOtjzCR4C82KsztCxwqVcZVx5aeu/0ZMkL
 A9q77NMlzD7IcuEFxCk9gRoy/HFZf0nPjVu1rFWVGrGZmDrKbNkgF1J69AL7MXnYnGuStvjnJn3
 zpkdWfcd0VSIK/imbwY+uHqwzCaR85OWLwKhXf2i1zZUH6CWJ1A2FOAFSW8c8+zyC2gh1lgVc90
 HN+csTeU381e1/unlSBPNSf5kRinTin7r0xwiRBk/7HvKegf6CwUPX3gkNzn/rVtpaaBNwm1nAh
 R9Ectu0AMLYx3SNnGRxaGRUj2JlFRYX68GUzED1FZzIZqKCVCch0U2vocPS0RhBtc7/6f8pbOpA
 X8sqMom7EqZ3Wqr5Cnibb5Zu1z5vAERKrB0BybfEw8mh//W8j8xTckKFEP4ZQ/rcME2D/EM3i8N
 xMyClDsV3lfKBFqjrAhH3HZZzfUKrz9qEwk4iTaaF9sGZpu9ibnJSk+0J0nHAc/f8UVIcOAZ7Tj
 IjMLxYFYIiWADeQ==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Remove files documentation from stih407-c8sectpfe driver.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 .../admin-guide/media/platform-cardlist.rst        |  2 -
 .../bindings/media/stih407-c8sectpfe.txt           | 88 ----------------------
 2 files changed, 90 deletions(-)

diff --git a/Documentation/admin-guide/media/platform-cardlist.rst b/Documentation/admin-guide/media/platform-cardlist.rst
index 1230ae4037ad551087d4cddc8a02eab5eac2be71..63f4b19c3628f3488fd2ccd1a6dab385d46b2503 100644
--- a/Documentation/admin-guide/media/platform-cardlist.rst
+++ b/Documentation/admin-guide/media/platform-cardlist.rst
@@ -18,8 +18,6 @@ am437x-vpfe        TI AM437x VPFE
 aspeed-video       Aspeed AST2400 and AST2500
 atmel-isc          ATMEL Image Sensor Controller (ISC)
 atmel-isi          ATMEL Image Sensor Interface (ISI)
-c8sectpfe          SDR platform devices
-c8sectpfe          SDR platform devices
 cafe_ccic          Marvell 88ALP01 (Cafe) CMOS Camera Controller
 cdns-csi2rx        Cadence MIPI-CSI2 RX Controller
 cdns-csi2tx        Cadence MIPI-CSI2 TX Controller
diff --git a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
deleted file mode 100644
index 880d4d70c9fd741ac13101721ced18f04336c373..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-STMicroelectronics STi c8sectpfe binding
-============================================
-
-This document describes the c8sectpfe device bindings that is used to get transport
-stream data into the SoC on the TS pins, and into DDR for further processing.
-
-It is typically used in conjunction with one or more demodulator and tuner devices
-which converts from the RF to digital domain. Demodulators and tuners are usually
-located on an external DVB frontend card connected to SoC TS input pins.
-
-Currently 7 TS input (tsin) channels are supported on the stih407 family SoC.
-
-Required properties (controller (parent) node):
-- compatible	: Should be "stih407-c8sectpfe"
-
-- reg		: Address and length of register sets for each device in
-		  "reg-names"
-
-- reg-names	: The names of the register addresses corresponding to the
-		  registers filled in "reg":
-			- c8sectpfe: c8sectpfe registers
-			- c8sectpfe-ram: c8sectpfe internal sram
-
-- clocks	: phandle list of c8sectpfe clocks
-- clock-names	: should be "c8sectpfe"
-See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-- pinctrl-names	: a pinctrl state named tsin%d-serial or tsin%d-parallel (where %d is tsin-num)
-		   must be defined for each tsin child node.
-- pinctrl-0	: phandle referencing pin configuration for this tsin configuration
-See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-
-Required properties (tsin (child) node):
-
-- tsin-num	: tsin id of the InputBlock (must be between 0 to 6)
-- i2c-bus	: phandle to the I2C bus DT node which the demodulators & tuners on this tsin channel are connected.
-- reset-gpios	: reset gpio for this tsin channel.
-
-Optional properties (tsin (child) node):
-
-- invert-ts-clk		: Bool property to control sense of ts input clock (data stored on falling edge of clk).
-- serial-not-parallel	: Bool property to configure input bus width (serial on ts_data<7>).
-- async-not-sync	: Bool property to control if data is received in asynchronous mode
-			   (all bits/bytes with ts_valid or ts_packet asserted are valid).
-
-- dvb-card		: Describes the NIM card connected to this tsin channel.
-
-Example:
-
-/* stih410 SoC b2120 + b2004a + stv0367-pll(NIMB) + stv0367-tda18212 (NIMA) DT example) */
-
-	c8sectpfe@8a20000 {
-		compatible = "st,stih407-c8sectpfe";
-		reg = <0x08a20000 0x10000>, <0x08a00000 0x4000>;
-		reg-names = "stfe", "stfe-ram";
-		interrupts = <GIC_SPI 34 IRQ_TYPE_NONE>, <GIC_SPI 35 IRQ_TYPE_NONE>;
-		interrupt-names = "stfe-error-irq", "stfe-idle-irq";
-		pinctrl-0	= <&pinctrl_tsin0_serial>;
-		pinctrl-1	= <&pinctrl_tsin0_parallel>;
-		pinctrl-2	= <&pinctrl_tsin3_serial>;
-		pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
-		pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
-		pinctrl-names	= "tsin0-serial",
-				  "tsin0-parallel",
-				  "tsin3-serial",
-				  "tsin4-serial",
-				  "tsin5-serial";
-		clocks = <&clk_s_c0_flexgen CLK_PROC_STFE>;
-		clock-names = "c8sectpfe";
-
-		/* tsin0 is TSA on NIMA */
-		tsin0: port@0 {
-			tsin-num		= <0>;
-			serial-not-parallel;
-			i2c-bus			= <&ssc2>;
-			reset-gpios		= <&pio15 4 GPIO_ACTIVE_HIGH>;
-			dvb-card		= <STV0367_TDA18212_NIMA_1>;
-		};
-
-		tsin3: port@3 {
-			tsin-num		= <3>;
-			serial-not-parallel;
-			i2c-bus			= <&ssc3>;
-			reset-gpios		= <&pio15 7 GPIO_ACTIVE_HIGH>;
-			dvb-card		= <STV0367_TDA18212_NIMB_1>;
-		};
-	};

-- 
2.51.0


