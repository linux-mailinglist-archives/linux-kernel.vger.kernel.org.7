Return-Path: <linux-kernel+bounces-746738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811DB12AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4BF4E7194
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260B25179A;
	Sat, 26 Jul 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ha83cEQM"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7D24678A
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535423; cv=none; b=RwA+zFAslwdBEINRCd3nlAyp+toeRlK+SClZb3tDqC+j3QRDA6RGKQIyWOXO0ZbWkcSohfwIU4MkgMBicuZRnMuXyivXTcWfNE/e9WEgvOMFoe+ZB3lcyoZ+WJBzf9n+U+yvAZeBTJWQkiMi0NQn03nYAn4N1r45TfCmvbFWvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535423; c=relaxed/simple;
	bh=QGEqlYXIwxO55BW2Qob9nSxq1Am14CofBss2UkP4kt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLcy9f0iJ3wu1Y94SszNouGtLfGp5RA7bBAtoXNyzgVMba/mb3XMj2xebEs5bZ0TpYxcvA8tcFLDFgMTtygqXhEA8mKyPKcz8uc27vrIh6BSv5TerF5LzzGdQ2ryI5bWP0qqcKPTi2aRY9j25NnOFwwHwkq0/YA/RqiotJpOxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ha83cEQM; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-87c205ca4easo70873239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753535420; x=1754140220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO2Fy/81E/WhCOJwM6NoWD+/CZxHHhnDjYEWoZW3i/Q=;
        b=ha83cEQMyAac6y9RdUpuNluiqdFTtq6vqW8WN0rUikBbLmVlvFPixN2VFCR+zEu7dw
         El/GzfRbowVdEGSlGKpvqYrGedqm5p+2SK1uzLHCeFmMZ701aZxcvVVlZGhLHYpd4afD
         MpkWeYzbuxBGwr2uCigmS1XrSZ6AOrk7NOM+PQKGFS0uUIKMZhZT+I11cBTpOnPAc8iI
         Ct/h18HzGkHBdEnsHQthq04cRQS+jXELPNTFSCMOsIHTEweES/mSSjwtAs/DNQ4ekGWH
         VEea/xI6ih7XF/zCsE3rQ7mBU8i5xaFijZd6HEgSWUsyH3l/0HlY/BuCWUy6S5H0og3g
         tQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535420; x=1754140220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO2Fy/81E/WhCOJwM6NoWD+/CZxHHhnDjYEWoZW3i/Q=;
        b=F2b5ytvOjwjE8IQKFLHjtuwG7/nAUsKkn8jeER0AE+qaHpL+ogba9bZfJFcjQPx6SL
         tOR3QYSa/GIb9AoTojR79eJIKf3my7VwSE6YMrXBWJfBqW2Xi9AGu3sc8yzJHj3qzMgW
         /wtDp+5pL0DBj3GjOlHMhmDQTsLdq0vw/wzvxUv8GR9JBfkEY7FfmzDWjMWOFYgzoKZX
         sVb/Xc/YM9walaiM0PxhJJEN9p+8De7we9DGII01gfVEH2FT/SGv21u9TFrNgfsMmPrr
         DDMnEQSPdkbh8oeHB92ADrCy8HBqzKBiIzoYE7olprufeh8qbJ1GN58J8CxXYcK1wTxX
         O/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVUayJCLJVe10EkJTE4JR4Xtis3AzsW/xHQItr2Yppg3+hXVbzZ4bumXN7uMqCODFxEdxoTJJd9l/x5I0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Zw7J4WT2qxkNlDNvjK2/+6W5Ks+Ihb+yjI4mgkUbah4QuvXF
	X05prN48VnLVzVizwFzdXw3hDuzi0EuFvgj6aUMSga5xlYsA/8GfClQTyGdp0CKkFG8=
X-Gm-Gg: ASbGnculxiOeU2ZR5ZNIb3n5E8/dcCJ/9+9z1lc4W5MyZO61aU2S6W+yhMDYuR7GE/4
	a44CRsyRzkJFu/tABn5wIuhKYRriIQZn0ODbPE+Q+8dd7LKdFHO/spJu9oO/tikhrIqOAZ3MtU2
	Ddis97CwStFih1JSReV4yipSK/8fkqeuTu/FT/V8wYYyBbgZoQkVavZNWb4OPNHKd3M4RfjcR/D
	CFjVpGtA9gWtaItDkC1On3xrKfo0Ezshp2QKie+BvvitXvGsK0krLRk7vHsW0QLdVEH0TQl8YG1
	YOKcMMbf/7ZNXWckZH27M6CT5ASUayqE9Uc3raD5WgNbVqsBvplfbO77xhpN1p/1VNCHbk2uD0c
	KaJSjmmR3jVClHdWUwvGDy9wXg4ghMpUDAWKdKxBd0QARPvMD4r6IBa9g5hjHDxtr0A==
X-Google-Smtp-Source: AGHT+IFowWZBk8AVURVAXWPSaWfOPiE/GFgKH2Cki+djIREns99xE2XqEQbxbnTzUozYyQveuIR00w==
X-Received: by 2002:a05:6602:2dd0:b0:86d:60:702f with SMTP id ca18e2360f4ac-87fff9442fcmr893288639f.0.1753535420282;
        Sat, 26 Jul 2025 06:10:20 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a4ee9fsm49551439f.33.2025.07.26.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:10:19 -0700 (PDT)
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
Subject: [PATCH v10 6/8] riscv: dts: spacemit: enable the i2c8 adapter
Date: Sat, 26 Jul 2025 08:10:00 -0500
Message-ID: <20250726131003.3137282-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726131003.3137282-1-elder@riscstar.com>
References: <20250726131003.3137282-1-elder@riscstar.com>
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
v10: - Move a few things around as suggested by Yixun Lan

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


