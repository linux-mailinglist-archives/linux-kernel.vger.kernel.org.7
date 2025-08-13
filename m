Return-Path: <linux-kernel+bounces-765799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3BAB23E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F83D171AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B6218AAA;
	Wed, 13 Aug 2025 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IXtbbbnv"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0029202C5D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053127; cv=none; b=gFj2GQPE4vwTdaipNV4UINq9kviaC/cmKs5u8mlswyusOkif/G++DWXz2M0aVqS5+H/LEIhKjpqVizqz4nu/Mf3PrIFlCNG3N3nS/oyDESWxuaS7Xs4lvMdVOnlrzARi8Kgh35Bu9sWyMqoRrCHPScBCv80STsfmFxeMDKLK4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053127; c=relaxed/simple;
	bh=ooFOOV2isYxwgZ2SmK13jgjsTx8sBuH2wENU5XY8MgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQO5oRqm7gkedefMTlQTqljknPuynJJ5/IGu4AFOnnbdrB+iEAb53NZcEhb3pGURa0C3UzoOsnhcXTfzlGLVGSDwE/3cDeo+qHR2FHx8ZtQfYGMezQQ4o0tScj9Lff+9OCh/9sz3LTBwGk7eCZcxFdUvSTG+Dypyr65ilk49Zxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IXtbbbnv; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e547e3f36eso12262735ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755053123; x=1755657923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4wudv5OTn00PNZ8isBITe1KCx3hdy2uajB+8N6UIZI=;
        b=IXtbbbnvveJf1MZUCiB+41pGDx1lnkcx8N6SbOGJNl+xw4zoKizkUB1bG0r2+6QREA
         ESsgVd2lFPse45nQLHbEuVRLxPVtExph//lDjdCWfIcC8L8kNNlTstw89pVLXBRxlczw
         UBLunpjrliCirFI9vjDml52HakFP8QNGv/AuMITgfkX41/MtSJAeYGVAxzeXUx96xY9V
         5ZrCeGjqEkfsFtdVigOZp8aWKH5+vkiGsxCLJ5HjeZE9GaZzei3SA6l+3fgxbZHou9X4
         cB8dNrQFEOCE3QxFiQHFe01IZxb+pX6XiH+QNjJZZRDpu42kx0JNhmbgkxIUo+VGMyp0
         AORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053123; x=1755657923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4wudv5OTn00PNZ8isBITe1KCx3hdy2uajB+8N6UIZI=;
        b=u40POXF25F/wrHvog6KrP488rE8HxoAAX83AJUMWUuYro80F9/Bh8kVMo3MDCAE4Bw
         46Q1+VTvSLqu8kZGZvOgnd5ctjusjBg+RgEy4g9AxbLZSJpbttfALQILD8CnKZ/uLgfc
         ThO2yImPMR6eKI9Y5thTATVFQfpyhPW8iOG7w1VNlaJQIcauYVuh7LJ5DyGGMZALNa9g
         3i4wQWsgsGyhi6OPhCsRQUiqZH9LD8q5FqiSjk1ZiugroEEEp7evGORVcUQN4IKvIhJ8
         Z29v1VUgppA8FuxRep0WhPecaSMju5/3gvEABOpVImTma02Bcu4fpNKbl1xDuv9NBnLk
         xRsw==
X-Forwarded-Encrypted: i=1; AJvYcCVh+B2Z8MNdZBAlnihkt5yhMDZiFJZPIIzuFh6wTPQAmNyDi2vW64NFH9AWpQQjsuUXg14+ifOZ9J/fnY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgLgLP6Q4kHK2OpkaWISm/iYmiolwpG7wn9nMDbRxTlCryXTL
	kxr4vGwR1GF8WsMFcYzzxcQmUqE6QN9SEdJMDPA+7I1IYBDVBQpmB8AJ35drDh8xdVs=
X-Gm-Gg: ASbGncvbldLEdoQ14YKh+yOhbJjftercIMP5mKfy29fKjmDaS0HS7kPE4mH39xvZjar
	nskeirEaSIeNsL+TfnytqcpLws6nZ4270f3mDII/BESs0HrSYou5vmNF4pyp3kNm+cJpERJNj9q
	KawB0XSD+2NAVVOXpOQIiiHFG0nWSIzQaqQNRzbSyRHtP/8fueN+j91PMCzoTHWT6PN8BVukOoH
	vTMLRZlQhXggTDHCpfNf6n+c9dlT5f8nY7LOOUnY6vTDcJVQEUh1J8KoQUl34Qloqey0TXJYJur
	iN+w6Kva4nAs/oiCHm0XNh0apC3RtRskzgTG+Fi+ST4+5lzs51zY55/JSXkAFX8IgyI1KE4V23S
	gx8w+0pS2ml1VsBXJRa8Bw5FS/p6BJPutXNa8PDRNVEovcL69MuhQGvgcKWBvCUzDAA==
X-Google-Smtp-Source: AGHT+IHNbGkypv04NReHT7LS3KpLc44/pbzlP8yxnO8gc+9CBy6bawzkc+ztCNL8hpgqnMvaPSvV6A==
X-Received: by 2002:a05:6e02:154d:b0:3e5:5357:6df3 with SMTP id e9e14a558f8ab-3e56738b0e7mr29089105ab.8.1755053123016;
        Tue, 12 Aug 2025 19:45:23 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bcfbf6sm3430829173.54.2025.08.12.19.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 19:45:22 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 5/7] riscv: dts: spacemit: enable the i2c8 adapter
Date: Tue, 12 Aug 2025 21:45:06 -0500
Message-ID: <20250813024509.2325988-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813024509.2325988-1-elder@riscstar.com>
References: <20250813024509.2325988-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define properties for the I2C adapter that provides access to the
SpacemiT P1 PMIC.  Enable this adapter on the Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 12 ++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 13 +++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012..ae9409fe398b2 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -40,6 +40,18 @@ &emmc {
 	status = "okay";
 };
 
+&i2c8 {
+	pinctrl-0 = <&i2c8_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 3810557374228..96d7a46d4bf77 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -11,6 +11,13 @@
 #define K1_GPIO(x)	(x / 32) (x % 32)
 
 &pinctrl {
+	i2c8_cfg: i2c8-cfg {
+		i2c8-0-pins {
+			pinmux = <K1_PADCONF(93, 0)>,	/* PWR_SCL */
+				 <K1_PADCONF(94, 0)>;	/* PWR_SDA */
+		};
+	};
+
 	uart0_2_cfg: uart0-2-cfg {
 		uart0-2-pins {
 			pinmux = <K1_PADCONF(68, 2)>,
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c..580f77b5e838a 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -459,6 +459,19 @@ pwm7: pwm@d401bc00 {
 			status = "disabled";
 		};
 
+		i2c8: i2c@d401d800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd401d800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI8>,
+				 <&syscon_apbc CLK_TWSI8_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <19>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@d401e000 {
 			compatible = "spacemit,k1-pinctrl";
 			reg = <0x0 0xd401e000 0x0 0x400>;
-- 
2.48.1


