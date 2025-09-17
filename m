Return-Path: <linux-kernel+bounces-821738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF3B821C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC7468673
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41830E85E;
	Wed, 17 Sep 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NTFYdMyu"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFB30C118
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146856; cv=none; b=uSytzvDOnXL+XDt1sw1hFG7fnj81eo/OMgUx0EMt019E39bVVr51d2zlVlxO3ab23WVXVXftKAsXcGT7mr0t/BE4SyoCJZX+zjC7lTVqwYhiUrcA78Glddt2JlG5zI7HOpx53h32ALfUeGrWx7ZuMc/q0NcwMbnujbS6BuxeVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146856; c=relaxed/simple;
	bh=LQuphTXldy5NKx8fqzkFlqI6SZIIEj7x/KiY6+KNrTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLw6f4SkTm1YZFnVoMeJq8/QosoJBAWpAg1QLib0qwIdwxXWfUyIPgb9Psu8cdbuKRR2yRwyHmb9eGAT3/rwLW7nl7ruN0t5F8jKHGJoP4ycfsEn3gkCj4Rm/6ITA8F/49Wb/LACYUxdxSznpLmtimxtrmSaEtAk3tevUHgZUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NTFYdMyu; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-40f9e28b09dso1272085ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758146853; x=1758751653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plxR1Q0OTlig1zTxHt8JGiXb5CbrsV82EqogeHId9hQ=;
        b=NTFYdMyumvwM6x0QuZqfXj/8HBW0YAiJ3jCP5NfFhf2fGcF5bgL6tF4GDr+1dDnuS4
         TtKnXJmGdzLspKROep+6DrMc8pSxMIXJYCYoqBXUW5bjLd95j8mB3bdbg6DWnEnh/0Oq
         6DgETnTjv5PNbCW2QROCIKqk/5YY3bBBG2kMORLG5H8gMXDyN1n6nf8KlACM7bXU01EI
         rbi1nGtY/kAjdqIHdm3jUORoiYevNnR6UHX9jK5XShjELV7CfgaQ8V/K59V1R4lY99Yk
         qCf3BCnCM834brXnXL39J1L6fSxZRH3X/pRpjcCJ5Aq4Lpw/dbAE29OLsZeyckMC6+GT
         eanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146853; x=1758751653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plxR1Q0OTlig1zTxHt8JGiXb5CbrsV82EqogeHId9hQ=;
        b=jQWcO1t63VFRJyoXiQbwU/pE3xo6mGbpDaPReL87Rkb2XaZKqRHRj/4BW9d/sUZ2O7
         qJJ2e06tiPhPeg9552a1a6zcg35jsvnvkn5y3YbXnI/F7NnamARqVaES98THSExAIof8
         1JCRD8s9iNxTQGMr4ufSE5KAQCVJVCgDNxwHQ6Jk5UundEKuR+Q4CduvxcEC+qlJ6W70
         LaPmH+HFma1IgCPgXGqUbKOY+wRiYndcuSEUqUCGHcJ4OUI6jgfkRMJhQUyaefjSlW2n
         gQg6QgSsrko/WG88e/O2577qPMJalGacCLbC4pztOE3ahWbwNkRyV4p3E3xnpN7Gfr8K
         VgWg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Ph9PIsHoZHQMNiVP/h/ecEfFeXkiZv3nbS1HExFiIVTypCCpjRjzem5bgSBfdRU0jQz4GufT7o/hZ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyChP3RGmfvzZUBdvdbMJuyH+CWTyfzgidUg9FF8OC3iYgR8XN
	qrJi1FXTWoOj0EK2xphTKuFfeimgRIoEOsKG7f0dJWgbPOpTMST/74OLbKUZsFRA+e8=
X-Gm-Gg: ASbGncv+wGg6xsjJAHcK/1rmx7G5IeYyk+63kTdwnlKzvhozvVYh/sKCq8wnQwB02o/
	51WUDzZKrXBlG81a74mdvMglmdUJGyrmnASk67rewDKCpVMSTCPYKxfuUgw5bMUW0QFdNDS8WC7
	LB5Zi5bWriQGQXABrV639AGXkLPntqhkk7d8ySazCiDAxZF+rimViMumRfoqEiIweain6emu01J
	CtOb0W4ny6rZjiIJyBe8GTfTT7EGCR176r0yMeAC7cCPMfmY6xQx7setTV1ZYdeQSx6PpQdx6rQ
	5vZ23O+iURxL93mIa7xiJedl8cjOQO5yNwiD6LJb78HpkQTPZG2YdfZP9PnirALvU2AhHluNM88
	E4Ee04QLy1hTGogQtowrgyy2b1gg09aS9iQniAC75mzdQ7tn73uCwJi1ZCxZod0Gv4MZtddCuif
	P8hdaOsjbl
X-Google-Smtp-Source: AGHT+IEhEgpu/y6hcFx432FAALiFyoyiIEe7VNM4oad62y0XdESrMbIYe4L7CYQ1KsF8cTepL/COMg==
X-Received: by 2002:a05:6e02:164b:b0:3f0:7ad2:2bf5 with SMTP id e9e14a558f8ab-4241a4e1040mr57294085ab.12.1758146853240;
        Wed, 17 Sep 2025 15:07:33 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm2346335ab.22.2025.09.17.15.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:07:32 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
Date: Wed, 17 Sep 2025 17:07:23 -0500
Message-ID: <20250917220724.288127-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917220724.288127-1-elder@riscstar.com>
References: <20250917220724.288127-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a node for the fourth SoC SPI controller (number 3) on
the SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 19 ++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 6013be2585428..380d475d2f3f3 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -44,6 +44,12 @@ &pdma {
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssp3_0_cfg>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 3810557374228..16c953eca2aaa 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -28,4 +28,24 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-no-pull-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 66b33a9110ccd..a826cc1ac83d5 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -834,6 +834,25 @@ storage-bus {
 			#size-cells = <2>;
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core",
+					      "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts-extended = <&plic 55>;
+				spacemit,k1-ssp-id = <3>;
+				dmas = <&pdma 20>,
+				       <&pdma 19>;
+				dma-names = "rx",
+					    "tx";
+				status = "disabled";
+			};
+
 			emmc: mmc@d4281000 {
 				compatible = "spacemit,k1-sdhci";
 				reg = <0x0 0xd4281000 0x0 0x200>;
-- 
2.48.1


