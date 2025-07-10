Return-Path: <linux-kernel+bounces-726271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94CDB00AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C293AC4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C42F5497;
	Thu, 10 Jul 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="xw8s3dGW"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FD2F5337
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169882; cv=none; b=sq6UVV9m4H48pO5Ap5Sh5+M5TqyH4jkk/O6xJDsOeg3MOZ/exGzQrDTbVq+s9nbbPWJsv2pBI6/TznGCdFtV+766pCXMwOntbQxTaQ/0kgYns14VwsPwhFgWSc+V8sCXX12E/NjxMKU2s+f3oHNlglTQ7z3Tk17zPArRH5h0IpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169882; c=relaxed/simple;
	bh=s5NHHbNv/ujgrIV/Cb3Li36tJwcZ44x/4V/i0tucfqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guX5CcmJ9LNvGurjR6py+VF0ITwTiCuJ1ZPUG3uozSufYkyep7fq7PYRHQrgyjWjs6idhjAGNdHYbK3fa0uXE5+91rvPLDwbxmxh5LOxc4mNcLOgaMsytXObdqPSVsqbjVWzrirq03NjjPvr68v/rcKp2Fc9jO1lNcd2lQnRlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=xw8s3dGW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a7f61ea32aso22765631cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752169880; x=1752774680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5l92a0u3aEn5H5uLHNniuYjNUr1Z2m83Q9b51ZTAqs=;
        b=xw8s3dGW+sf8fbTKzLZwKTnw8UwQcJ2eAJGaGpXc37GDSJVMMr3H3Y9sn0RXhIZlJH
         FUjflbSIZ7ZRwQJOcqN0UyuzfQVuxD0H81oqYTabDGBz/ZO62fpxMYxJYdrfaMi3hLFs
         jHVOvyH1yeaFrtmt9envnyZiUqsye7aI+XYYVneT1Sk39Ved0SL2yAzfvnaZHWoEKF+/
         RgD7lTKVFleSWFN05sJDzfuMKgHTboksJCFgmyvp/F4fycS2m0g35rINWfvCJdMjBEo0
         M0B2eMwK+LBPRvHpZy9PEiYaXu703JHzBw4l3J7THAUh6s0aOKnQrzASbzy9CicTNdaU
         rZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169880; x=1752774680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5l92a0u3aEn5H5uLHNniuYjNUr1Z2m83Q9b51ZTAqs=;
        b=ROTkIhj7J8u6DN1eTKi/ozKLJJ7ouGVX4QUT1NarlwgGAFSqeweWB/7RZtlXdM5kWz
         NShPL1vJvP2L5bZBSCQRMYv3PwBTzD+nD/Ge0cvjkTFNtJri3zGiXsrysoN+B/+nknuk
         JZ2M/8R+pQ7vBltHmgk07yO9kfiMUZ0Es00B2UpzamCwHsqZSpKSC7mO0+LT+FXdc1s8
         PaP/QTmBIHyJVfoCD3nXqI/wsyn4bGVudKei+gsJkqI7XT3jLQbdHWS6fXxlQayIWbm2
         9OA3zcvpth6tC7c4tlCW0SdnbAXmlPQiG7ZZ9DqLTjyr0viR3GLR7kKimJnNYQQoTTdH
         eCLA==
X-Forwarded-Encrypted: i=1; AJvYcCWsH0U4xHfskf5CpLr5e7KJVlbpBzamHeXHk7je09gYrOKqF03X5cqP0mdRcNGpdENvyP39mjwI35ZxJd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZhbK37WY4PfD6FL20X9HPB88dHWsalM4vi3CZ/h/snXqmSkh
	U42QN/eG+wrYfVSqqkkO+wasZgt+2J5IsDeitnAKZ41EUadiNLCeOPWTy9K8UXYUwzI=
X-Gm-Gg: ASbGncu/vn6cbysNURe+K6tub08bsE49MHCZPbUPVqFWTBq5s4p5aTs9l5hIiL5ZUBh
	p5jq3n7JRB2ZQnOhANExmwVYGxoQQ4WgKVcHrppdbcJdOxB1QOVPdXGPfp/uuex5LUFp9Iqdgfe
	97L+nppHuGS69jSJzUcIaMXjBKaThE6Tp0Dd5LR7GL+Vyg/zpJE1pkB3o60zCfuj3o03ZL/N6eZ
	mRhpmufv8785xDy0BQBm8xkmuXOFPY+yomLVb9utOJ+hCtDgSLnf+W0h2QBSg3vgbM3pAmTFE+Y
	8+2SeYzrF/Jzt71hUcC4NGnrUTYe9Gwf+Z/lHUa7XfmM2mc2zYxqiSbdEnQuE8JKiv8junKbbbV
	CzxiUmBQxlnXm0kByQt3BRIkGLzuuiLNz+Sg=
X-Google-Smtp-Source: AGHT+IG+gA6k2s44x2USnRDQuKJqGd3W7ZyAlmp/eZAKTxA53qYYitzNYMjkTmaqX9EZT28ElFOI6Q==
X-Received: by 2002:ac8:5d94:0:b0:4a4:3b41:916c with SMTP id d75a77b69052e-4a9fb88f9b7mr4651941cf.17.1752169879757;
        Thu, 10 Jul 2025 10:51:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee300sm11165941cf.73.2025.07.10.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:51:19 -0700 (PDT)
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
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/8] riscv: dts: spacemit: enable the i2c8 adapter
Date: Thu, 10 Jul 2025 12:51:04 -0500
Message-ID: <20250710175107.1280221-7-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710175107.1280221-1-elder@riscstar.com>
References: <20250710175107.1280221-1-elder@riscstar.com>
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
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 15 +++++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012..7c9f91c88e01a 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -40,6 +40,21 @@ &emmc {
 	status = "okay";
 };
 
+&i2c8 {
+	pinctrl-0 = <&i2c8_cfg>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		status = "okay";
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
index abde8bb07c95c..2a5a132d5a774 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -459,6 +459,17 @@ pwm7: pwm@d401bc00 {
 			status = "disabled";
 		};
 
+		i2c8: i2c@d401d800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd401d800 0x0 0x38>;
+			interrupts = <19>;
+			clocks = <&syscon_apbc CLK_TWSI8>,
+				 <&syscon_apbc CLK_TWSI8_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@d401e000 {
 			compatible = "spacemit,k1-pinctrl";
 			reg = <0x0 0xd401e000 0x0 0x400>;
-- 
2.45.2


