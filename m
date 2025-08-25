Return-Path: <linux-kernel+bounces-785284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C7B3488A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2311A86A98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E5307492;
	Mon, 25 Aug 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="o/CPxvI8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D0305E24
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142474; cv=none; b=REkkbF+85etCXFszpjknFLkfpVCVeRHDJJBEZNeIvqBOpa/nshUBYxry0qyF/j2UDbF5O5SVpqZ+aDjmajkihlBH8CAOtoK5zmhPYkeVYtFcgNJVYW3/O4erhqVts7LeXIlym1ThGsstXSsDQ1sFbHK2zm05UsSktsdQ0BmKzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142474; c=relaxed/simple;
	bh=tqj+GYK1EDpUdWJT2hsmEmFYHp02iQVqmo4nfSM4fUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UphbLBdo5Mo8yqOhDSdEafq+dbhnZ+4Qxut7duKWm9QDtcxXH8hDA9MUtm40R/j30rDG+H9Rbbzh79/vOwLcdxfKjKzzbxdC4JvY9ACU9lBfHjOY8Ewmj5agmROHZtH1J8lfsEsWwuh8+LUGUvrBlMDuCb7HsbVvz4BFu+oVbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=o/CPxvI8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-886ec1ac877so4521739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1756142472; x=1756747272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaImj7HPDviB5XgBqpwJeOy4vyIIfyH+4F3V+wrd8Lk=;
        b=o/CPxvI8uZV1TryKV6Zx3kIuTVYeVy8w2/TybQXcWZXu6lBDOvp8E0OCIr3pZa4dRC
         Q+HYU21parYD92RQoTsYRivMDGuF2x2H8vJ4t3LFZuMgZT9/6hdCm9ROjcAyO0XzlD/S
         b5c8RD0jxr3nHqXB/eK4Gih/e68TXFDj4wHEiXZ4MMNt7VHlLd0M1ysffUixR0q83ZZ/
         ADP9TbCPcTUNLY795D+hM0w/uVJD/zpJ8TLmr2WDNYr0YM0hOOGKiOKbkiMtADrOEHpZ
         Bc5L4AYPlSto8rlhhdI5R3Uc8H/Jm2rnyacOwsVj5gqxdn1zdP+u67VSBhrq2Vtp6w42
         zHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142472; x=1756747272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaImj7HPDviB5XgBqpwJeOy4vyIIfyH+4F3V+wrd8Lk=;
        b=CwhZ8j5YUIvlvk8ONTeATSuJPG+5CE1Qo7hBO640RMijkRepE7lfl1AZ9Y23xMdueN
         oFM5rHNPogHY6fiwN7klaSNe0eDdG1tLtK43XVX7pjqOc9roecmwK+VdDdHRsrXcSsV5
         QC1PDQ/4tnQ4VOLWQdPvumI0ASqTrs8MhY96A/mlYKGnv7e04oSeZ1NXu/bKoYcxc4MW
         lr8yqFEYxO45TP3KGwfavuEW4H3T9ljfFHqWBgLDBBq4+7/HQJBJz1sdaT2VKw3Vnf98
         kJ+bb1fxdJbQO3yxuqFEnZLJQIDhvAMdSUYoeT0IkKKUwG2YyGSSMtDKtJZ5c7t4jAnL
         GJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKmPOWYamlUM9dCT8oiZkPYbSXuMBvmggQjucwjmaX3gcn0uEdoZT0S8g+8hvw8PxbsJO7yW+kqb4dgAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNzDvdt/SZ9T1TerZ06EADsT/HhoINc2SWKNowjkZRuSLwuMv
	9EsrWt0hbsirGsvpGIbgLofKwCXZvl3pp7KfXVBrPQ6a4wEmjC+CKe/wXvleU45Srjw=
X-Gm-Gg: ASbGncuAVlAk9MeWeSEca2FDmORFYawmOTiWr0/91BkXG+6tvAn1BgwBZ+Etktzn+FD
	1ObwX7SUaLllv0A4aIt6353WK0B+KU+tY5NIAEcYTDDqLM6hWYAEYw2ees4za+R1zSAr5DilCxx
	3f48SsyIpg6+oPYHP1FvHrIxCFC65uCrJoxpjKrvp/179471YJYO3IFAOk/rLEXyWNdQ5lCJwzy
	bca2fg4MPhPa4Rg4GhpXDZljfDpKiM4INIWS4h4VZ12VCn8T89vGYgROfqYYd5/czRZap7Z1T8V
	Yubq2gQxtvUraBnUrZvjGHqv+lGcFoEqvlwLX2bowoJYn/SIHF6JTQ+JJSzm68LZEDsC9zm8vBS
	T/5P7ss1G0fTtPsCRaYYVBPXC+aELSeqkh9K4V6VjqQzQYHdgjNqBjDNsvxe/yUcHuA==
X-Google-Smtp-Source: AGHT+IGMjww54FRdV9usG2bAND6j/10A3PtBf2JERSU5gXA+1FH5dtg3t7ajGlDWVwIXh5UXyCucrg==
X-Received: by 2002:a92:c269:0:b0:3ed:fe91:7306 with SMTP id e9e14a558f8ab-3edfe91737dmr19680085ab.23.1756142471734;
        Mon, 25 Aug 2025 10:21:11 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886e60c4737sm76275439f.26.2025.08.25.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:21:11 -0700 (PDT)
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
Subject: [PATCH v13 5/7] riscv: dts: spacemit: enable the i2c8 adapter
Date: Mon, 25 Aug 2025 12:20:54 -0500
Message-ID: <20250825172057.163883-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825172057.163883-1-elder@riscstar.com>
References: <20250825172057.163883-1-elder@riscstar.com>
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
index 6c68b2e54675e..cd9b91c3358e4 100644
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


