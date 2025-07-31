Return-Path: <linux-kernel+bounces-752225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E90B172B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE29E7ADB32
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD32D3744;
	Thu, 31 Jul 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvqE5oat"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994D2D23A5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970523; cv=none; b=bGDu6Y8vU8cxtnxiE+f+9Uy6zFXSaQ4GQjZ3EmzUbM+d2ldzomTxC/2KYbXQdLOcW1I3aFmiZhlH2P9MjhqmUnC6p7ng6QleWzk7R/1RSh2gruJDNe2NvJScI8uCxvGWpwXrHbdGSgnSKjJcHBgB3SIo/Adf6BNykrSomCWCpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970523; c=relaxed/simple;
	bh=vcA02yLSNwMr2sw3WTjr/QQMCrQppMAlK1ftMTli3h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyQGk9y+T+iyZKcPVOnYVPHBBESqeNlIzsLlRd1YhOS9ZfaY1/SDOQOMWdMXq/MH1bnCs0CLenoy0ZOTVLI2RPT6rOKaTmllQALF+6zN2Ft7ABCi+YZfYzmUWXzlgu92GmlrdQtEUjEyWAHhuC0F4Xxpq9/bDrXW0Bl3Juwy7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvqE5oat; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d3f72391so4619215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970520; x=1754575320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB00SSfP6c+OHo+3LviFK6KTCkRiE6kjMG1sy5ThVvM=;
        b=pvqE5oatdDMxVpLhdugSamCoWqFPJboKanMleT8QPbmOIKbvCGGMV5AzRzFGVxPE6o
         WOLtuAmq5+wx2FcENC2Nw1EZ3c1Rv7Ci8fyiaUFZEaFniw8e6/uuC4/j2dw6Hr1yvcyv
         T0hxbtYJUS6g5/apg6uge6xnhJ9TkGtGi4iHZPhyS8490ZMFb5cxki7zwrfxcDN54yxF
         NR/Mb6rG7AOCKv1RZGPOCMiKYGjQrk7Ay9HJejGq4WwU01/QPuKAepRb3aSgWdRRKSrr
         GrpMiKQojygNHC7a8MnIRf7Uj3k11zj00ymtyh1W/uMWgDnmcdB408ugvQyUbDtLy5Da
         gAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970520; x=1754575320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB00SSfP6c+OHo+3LviFK6KTCkRiE6kjMG1sy5ThVvM=;
        b=JE63+1GovfedEyFqyoxG2W2GKz0y+ShiM0S/boozg4Nzhf1njwf6UQzsxJYQ9IKHID
         xfDjawlIiZaclNLD/Q68Rjih3ejkPF87Auei+W93ushaVhIStUx9Z53nTGZi0D8rJ0nE
         w+5prNnX4KYf5CYhVaqz2fHSWyJQ2FeTYxHpWiimxL+biJHI64pCH/snLAN/3Q78Q/kW
         5xJcHYBDBFmqu9AIGXxy6j9TAP2WOS1YNhDj1VNbhWy1gJWYXg7jYK2R7go7qXsxWsv2
         4yNE1cmlc95ur3LOSyuTA78kz6nN3ZAEqsjSI7vJN9uo7eTg8A3UF86ukbdXvsZBcxqZ
         kJ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXntbBv+zKz0tl3ETFJcOXH9JV5IiTLcGSlhSneUlWeai1tuIzY1ljtVUxZe5JhmZpPM8i79Y+0prh1y+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29WyTZEEFQHYyaFYZjI2SL4nTuteucGE8Pc5qYqahoiZ0QJK8
	QERWv14P1kZN6wRPqYqsMy52E4j3sQk4WqqvXdE/B8NKPSrDmUCxYr0HqeGfi5ALEXdC1vrmPJE
	lJX9b
X-Gm-Gg: ASbGncvKP6EIsr5Si6Cqc5fCsx/X4ELAgm2an7ja13aZqQnUQB/1qq8rZTwnZSNNA4Z
	5KaNkO9aj67S/27n/wZrfJH95vmvFKux4El2iQY+oGn4l6mm+OY2OSPicSzMS/8QmQaXpyEvWS0
	jPo2SQLMLwYw4DFw3W3SzrFXblcQaXYu6D+Y6iZ5J5yb3oyLZ43iSIp6eeLno08SMWEvqds1xhZ
	cHq63011IwV/5vjF2+9QI01Dqs21GMQkbc3Op3SufiXIrTjhGV0MhwUWOaVjS4FWjwyWIvDIvlk
	p4OlReMu1muyZ62eUZn1LeyzkWV8KaIXa+PvVovSoWcsC11fzob2PNTHamRVY30XF3uc4PAZHQq
	4WYLDRaeYTMJ+YUEhvN230GDXi5rOL72YTy5/ajIq9s/Ccnr8
X-Google-Smtp-Source: AGHT+IGqwlW5ma8WPKveKqUhTUAr3VgKYFhAtuL+0U//6ALH9ryJa3alHyJCYGFqgrUVq1o4bMWuuQ==
X-Received: by 2002:a05:600c:8711:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-45892bd7be5mr65100585e9.33.1753970519969;
        Thu, 31 Jul 2025 07:01:59 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:01:59 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH v2 3/8] arm64: dts: s32g3: Add the System Timer Module nodes
Date: Thu, 31 Jul 2025 16:01:36 +0200
Message-ID: <20250731140146.62960-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g3 has a STM module containing 12 timers. Each timer has a
dedicated interrupt and share the same clock.

Add the STM0->STM11 nodes for the s32g3 SoC. The STM7 node is not
added because it is slightly different and needs an extra property
which will be added later when supported by the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 99 ++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 991dbfbfa203..c2c986f03986 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -374,6 +374,42 @@ usdhc0-200mhz-grp4 {
 			};
 		};
 
+		stm0: timer@4011c000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x4011c000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm1: timer@40120000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40120000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm2: timer@40124000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40124000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm3: timer@40128000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40128000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		edma0: dma-controller@40144000 {
 			compatible = "nxp,s32g3-edma", "nxp,s32g2-edma";
 			reg = <0x40144000 0x24000>,
@@ -471,6 +507,33 @@ i2c2: i2c@401ec000 {
 			status = "disabled";
 		};
 
+		stm4: timer@4021c000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x4021c000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm5: timer@40220000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40220000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm6: timer@40224000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40224000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		edma1: dma-controller@40244000 {
 			compatible = "nxp,s32g3-edma", "nxp,s32g2-edma";
 			reg = <0x40244000 0x24000>,
@@ -560,6 +623,42 @@ usdhc0: mmc@402f0000 {
 			status = "disabled";
 		};
 
+		stm8: timer@40520000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40520000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm9: timer@40524000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40524000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm10: timer@40528000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x40528000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		stm11: timer@4052c000 {
+			compatible = "nxp,s32g3-stm", "nxp,s32g2-stm";
+			reg = <0x4052c000 0x3000>;
+			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+			clock-names = "counter", "module", "register";
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.43.0


