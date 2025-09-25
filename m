Return-Path: <linux-kernel+bounces-833165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A44BA1521
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0826C125A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891732143A;
	Thu, 25 Sep 2025 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTgIeHl2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1B321278
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830800; cv=none; b=G5jYkw+upsUxOf+J4amuRKZvTkY2vSJPOMBYg2XKlre8r9F8YV5O8+ULA8uqhGuJ/x4Smsuebo92kjcVGfx9FXtD+YqCAX69elBVcUtNEAd1ICwNEs9HJcDF8lNMGhcl8pe7WXqGxetsaQw+n1vavm4d5VsUJP2p3U+3YduVi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830800; c=relaxed/simple;
	bh=I2ht6Uz7UJIwNBWGB6eaK1ad/VVAPQ6A529BtjCkuP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/oe4lIGlXGfeLicWhn+QvPtshPSuJVXOKvTFDaYS7zAEM3wUgYPvwGkNiWkpI7twPV2IV0WrLpmk2uIcz0CPcGQbSYOxKLgZ892wouHWNDkpT9HguVBvc46kQryodZJBYRSX07eN3UPoowVjfcT8Pbfj4w2zDrsHAYlR3MYkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTgIeHl2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso10180265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758830796; x=1759435596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jqvr6aZqMFctJyCbwOIGg2m9JnfdEm7BBcrrO1JbYo=;
        b=cTgIeHl2cracQnsCrtnEKf9uewPg+y0HTkFkmRxTt51/zYppF6/QDasX+ijqtqbDrq
         xCPf5hoqCac2G4Rtk3t0kSApXQ21ouyeoLXCswF7PV+xy0VeZcX6+l3XLP2NoaChD/On
         sethjLMJUsQ0K8q29llpGF36PonW1soy1j6t/F89HA+/RTKslcz2iUQ82H45BXEyTKPK
         oBimzKg+soi3nLoHlfL1RrG+oMkZNSJNHvcBNmb/Wk+u1s2MtM088XRGfBeX2xi59W9Q
         FkYlxahyib9iIvhiwULfEpTfuZWe4njUZH0aJlqbCbEMEGen3HPuKa6Sl40Y9h5UVJWL
         SLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830796; x=1759435596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jqvr6aZqMFctJyCbwOIGg2m9JnfdEm7BBcrrO1JbYo=;
        b=ppGItmeLfFGlsQRR3EjKo29AHnFLnr2OAbTMM8efQINxzPa658popIfNgUNGMWaNo7
         6sXCtHX8+jn72wnrkYXXvKDwM8o4naXJqVXPEzYE1OGHHQfDi/s1CiAZvDYSb7/lwJgP
         RNllr9ow9VPHKPAq2HOxy6MBYtZOFyyw0WqCN8MnN9Iwjzp8XlsLddKE9qvajVvvgBeu
         K4QKc/NyFRnJJkz5dPMNlYzw361MWiNl+5Q48j42UL8qlFYmi3v/wyE1RMzqvazTr4aw
         +etohVeP782cxa3U67fQTGJ4ofa3/M2n/+i9JRiXXv/ZUmf2EBi74Tq7siCUxsLRJAtP
         GNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe2pjlY/RTYdvaQV7Jp/upEua0JaqxMKaR/OT48R37SaxaVuoARTzJw2Nz0UpBchXqgJKAzdaQccG0Ndg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfY4WpJtnvTdhZpFtO/Pf4ZSpUP5Fe21EHAAJr9C7vOW43RGsA
	rhXcXJ0Qn1jyxQiWIPiGyvUTR+NeM/2ZdG8VEQl+z7FPyy5v2kyLkSnE
X-Gm-Gg: ASbGncuTBIoHn7duPcPpf9wqZ7HzE/P6CZNnLsUzHFJjr277r4RNujXkzMsBzv755ta
	KqFgBcbRZdZM4/g9/qcqOLMYMIPyF704JopfZtmrNuq/OOuDgeN0t/RKBBlsutrtaWttlRLCVDR
	y40DYAKj1z9gzS/bXB8oG4/BoFQmC81Y/VVDQHAC/NTdD6kGx4DgH8+tlIYzXe+owr8MZoK91Se
	xZVqmTlbxz2nwiVQqdtIx86HoEpL55+T2yrXPlQJdS0y8KXMNJvtefo25Z0aN6aN9RxVooSBpoZ
	rtrPE557HECNH562sMfPpUkaJqGUByeNjvehYSgnk7ak3uJSQAKADhe6RJlWuB9xQVpmWNxhz5F
	YCIuwJh4Z0K2TMomDckkoCLM6Lac/LQ4xAjNfgs2PD+43
X-Google-Smtp-Source: AGHT+IFNKexEYP6eXvdZomlwHexpTC6N+7NVPLHb2O9ndmfpNliFpqOhvZyQYAMlTJxAljpPMAkehw==
X-Received: by 2002:a05:600c:8b16:b0:468:7f92:5a80 with SMTP id 5b1f17b1804b1-46e329fbd2bmr34832865e9.27.1758830796327;
        Thu, 25 Sep 2025 13:06:36 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm43901835e9.10.2025.09.25.13.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:06:35 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 3/3] arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
Date: Thu, 25 Sep 2025 23:06:25 +0300
Message-Id: <20250925200625.573902-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925200625.573902-1-tmaimon77@gmail.com>
References: <20250925200625.573902-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable peripheral support for the Nuvoton NPCM845 Evaluation Board by
adding device nodes for Ethernet controllers, MMC controller, SPI
controllers, USB device controllers, random number generator, ADC,
PWM-FAN controller, I2C controllers, and PECI interface.
Include MDIO nodes for Ethernet PHYs, reserved memory for TIP, and
aliases for device access.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 440 ++++++++++++++++++
 1 file changed, 440 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index 2638ee1c3846..53e6a0af5a21 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -9,6 +9,42 @@ / {
 	compatible = "nuvoton,npcm845-evb", "nuvoton,npcm845";
 
 	aliases {
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+		ethernet3 = &gmac3;
+		fiu0 = &fiu0;
+		fiu1 = &fiu3;
+		fiu2 = &fiux;
+		fiu3 = &fiu1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+		i2c14 = &i2c14;
+		i2c15 = &i2c15;
+		i2c16 = &i2c16;
+		i2c17 = &i2c17;
+		i2c18 = &i2c18;
+		i2c19 = &i2c19;
+		i2c20 = &i2c20;
+		i2c21 = &i2c21;
+		i2c22 = &i2c22;
+		i2c23 = &i2c23;
+		i2c24 = &i2c24;
+		i2c25 = &i2c25;
+		i2c26 = &i2c26;
+		mdio-gpio0 = &mdio0;
+		mdio-gpio1 = &mdio1;
 		serial0 = &serial0;
 	};
 
@@ -16,7 +52,32 @@ chosen {
 		stdout-path = &serial0;
 	};
 
+	mdio0: mdio-0 {
+		compatible = "virtual,mdio-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>,
+			<&gpio1 26 GPIO_ACTIVE_HIGH>;
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+
+	mdio1: mdio-1 {
+		compatible = "virtual,mdio-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>,
+			<&gpio2 28 GPIO_ACTIVE_HIGH>;
+
+		phy1: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 
@@ -25,12 +86,391 @@ refclk: refclk-25mhz {
 		clock-frequency = <25000000>;
 		#clock-cells = <0>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		tip_reserved: tip@0 {
+			reg = <0x0 0x0 0x0 0x6200000>;
+		};
+	};
+};
+
+&adc {
+	#io-channel-cells = <1>;
+	status = "okay";
+};
+
+&fiu0 {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "bb-uboot-1";
+				reg = <0x0000000 0x80000>;
+				read-only;
+				};
+			partition@80000 {
+				label = "bb-uboot-2";
+				reg = <0x0080000 0x80000>;
+				read-only;
+				};
+			partition@100000 {
+				label = "env-param";
+				reg = <0x0100000 0x40000>;
+				read-only;
+				};
+			partition@140000 {
+				label = "spare";
+				reg = <0x0140000 0xC0000>;
+				};
+			partition@200000 {
+				label = "kernel";
+				reg = <0x0200000 0x400000>;
+				};
+			partition@600000 {
+				label = "rootfs";
+				reg = <0x0600000 0x700000>;
+				};
+			partition@d00000 {
+				label = "spare1";
+				reg = <0x0d00000 0x200000>;
+				};
+			partition@f00000 {
+				label = "spare2";
+				reg = <0x0f00000 0x200000>;
+				};
+			partition@1100000 {
+				label = "spare3";
+				reg = <0x1100000 0x200000>;
+				};
+			partition@1300000 {
+				label = "spare4";
+				reg = <0x1300000 0x0>;
+			};
+		};
+	};
+};
+
+&fiu1 {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "spi1-system1";
+				reg = <0x0 0x0>;
+			};
+		};
+	};
+};
+
+&fiu3 {
+	pinctrl-0 = <&spi3_pins>, <&spi3quad_pins>;
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "spi3-system1";
+				reg = <0x0 0x0>;
+			};
+		};
+	};
+};
+
+&fiux {
+	spix-mode;
+};
+
+&gmac1 {
+	phy-mode = "rgmii-id";
+	snps,eee-force-disable;
+	status = "okay";
+};
+
+&gmac2 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&r1_pins
+			&r1oen_pins>;
+	phy-handle = <&phy0>;
+	status = "okay";
+};
+
+&gmac3 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&r2_pins
+			&r2oen_pins>;
+	phy-handle = <&phy1>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <0x10>;
+		i2c-protocol;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ipmb@11 {
+		compatible = "ipmb-dev";
+		reg = <0x11>;
+		i2c-protocol;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	tmp100@48 {
+		compatible = "tmp100";
+		reg = <0x48>;
+		status = "okay";
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&i2c16 {
+	status = "okay";
+};
+
+&i2c17 {
+	status = "okay";
+};
+
+&i2c18 {
+	status = "okay";
+};
+
+&i2c19 {
+	status = "okay";
+};
+
+&i2c20 {
+	status = "okay";
+};
+
+&i2c21 {
+	status = "okay";
+};
+
+&i2c22 {
+	status = "okay";
+};
+
+&i2c23 {
+	status = "okay";
+};
+
+&i2c24 {
+	status = "okay";
+};
+
+&i2c25 {
+	status = "okay";
+};
+
+&i2c26 {
+	status = "okay";
+};
+
+&mc {
+	status = "okay";
+};
+
+&peci {
+	status = "okay";
+};
+
+&pwm_fan {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins &pwm1_pins
+		&pwm2_pins &pwm3_pins
+		&pwm4_pins &pwm5_pins
+		&pwm6_pins &pwm7_pins
+		&fanin0_pins &fanin1_pins
+		&fanin2_pins &fanin3_pins
+		&fanin4_pins &fanin5_pins
+		&fanin6_pins &fanin7_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	fan@0 {
+		reg = <0x00>;
+		fan-tach-ch = <0x0 0x1>;
+		cooling-levels = <127 255>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		fan-tach-ch = <0x2 0x3>;
+		cooling-levels = <127 255>;
+	};
+	fan@2 {
+		reg = <0x02>;
+		fan-tach-ch = <0x4 0x5>;
+		cooling-levels = <127 255>;
+	};
+	fan@3 {
+		reg = <0x03>;
+		fan-tach-ch = <0x6 0x7>;
+		cooling-levels = <127 255>;
+	};
+	fan@4 {
+		reg = <0x04>;
+		fan-tach-ch = <0x8 0x9>;
+		cooling-levels = <127 255>;
+	};
+	fan@5 {
+		reg = <0x05>;
+		fan-tach-ch = <0xa 0xb>;
+		cooling-levels = <127 255>;
+	};
+	fan@6 {
+		reg = <0x06>;
+		fan-tach-ch = <0xc 0xd>;
+		cooling-levels = <127 255>;
+	};
+	fan@7 {
+		reg = <0x07>;
+		fan-tach-ch = <0xe 0xf>;
+		cooling-levels = <127 255>;
+	};
+};
+
+&rng {
+	status = "okay";
+};
+
+&sdhci {
+	status = "okay";
 };
 
 &serial0 {
 	status = "okay";
 };
 
+&udc0 {
+	status = "okay";
+};
+
+&udc1 {
+	status = "okay";
+};
+
+&udc2 {
+	status = "okay";
+};
+
+&udc3 {
+	status = "okay";
+};
+
+&udc4 {
+	status = "okay";
+};
+
+&udc5 {
+	status = "okay";
+};
+
+&udc6 {
+	status = "okay";
+};
+
+&udc7 {
+	status = "okay";
+};
+
 &watchdog1 {
 	status = "okay";
 };
-- 
2.34.1


