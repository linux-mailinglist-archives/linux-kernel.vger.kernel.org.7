Return-Path: <linux-kernel+bounces-805857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D0B48E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6467AC38F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EAC307482;
	Mon,  8 Sep 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzWDcKX6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A430597A;
	Mon,  8 Sep 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336391; cv=none; b=D+FTQuUMRwFq+zoNoSQw42qLLM0ifY91bTlHJs2qaU2hWmz8/SsqfNpbvF5qFR3fHPCEagAWiQmLtFekHBT7yAKqL5J6fnxJmXP1FggMaPy77k68w24OezQV1zlqNVRPsbpr7nEuWnlSw0LXp7i1+0F8S/5W0+2VZmfgT/l+y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336391; c=relaxed/simple;
	bh=Qgd39pgx9crrIkLV8uHwx3KIavurA4LcHv3S5wpeAmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUn6mYZfFYymQuiriE5GUX6oqYMc9q9eHnBSgFJsontGRMgEk1CWaWVWvK5wZvfqATkHQiK+WgKahePe6OPFoqHKGczyARFHIPe4T0PGheW02bDl2rOihXez2xThLOVno6gUdnzmtvTnc2pLNKGkJ1k/ckzgd+VHfKS07FnlpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzWDcKX6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so1285639f8f.1;
        Mon, 08 Sep 2025 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757336388; x=1757941188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohTjPehvEZpnbTZWGGl3LmVxYQyjSBeyFWblJS+0WIQ=;
        b=kzWDcKX65c03THgUQwv+k8hR0gRAtS7Kndm+0ZAolqbQXYQWCMP0ZMFMxtHhnbiPqn
         X+y5jqiiE2wHlYH74vAxcdpwwWAKtbY7cNeykDT0MC/A5/bxrkzuZnTHLg3KSBUdbwrp
         SjsBpBhW+6+vswCbeAY4oJyfxzSapU6sBY8/AsHqY8TN4hQCrapgmWYPjtxorZ9ARFMp
         jXEcDTz6XNO/opJeSqBBP9qQsTrkYZORhSO5crPgfnseO5jHF6ZO2rYGg+oPdFUzjto4
         3JbDzB/xYCVGA3DUOjR49EStC9rUYAQPmz91QdgCgtdFQQgItkfOUJUfAXFG1PVcVa2F
         WVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336388; x=1757941188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohTjPehvEZpnbTZWGGl3LmVxYQyjSBeyFWblJS+0WIQ=;
        b=LR0GpTy0BrBNEd1V46EuTNd88MEURqmlHHcDgjLYGIa/lceKTYt8h12xQLfsslDTdO
         25Kp4NuDT9z6I0RiAVHy9BaWoXr2TyvP5wTFWSApVMarY4LDN6uKOljwcrJLMtjS0JVE
         Gu3v6dk00WXwCEwMY5UQm6ry7XpBP1HdNtC9u5yYcBwqxCmFtXZpTAApj++/PAQ4ty/0
         FqnlAR509xZBKi6KPKGNdg+y6u8cN34onii4KmzkDohyJQXB3IOKNvcnz4nV2dAMok7w
         2DyWye0eSXl/YnNz6jVvXxnl6cRY3oMsKjXLlmsPDcojwp+nqQYrwSNn2RG+Yxl0AsXF
         uVxw==
X-Forwarded-Encrypted: i=1; AJvYcCW8yU1/KWb4IaBVIxun61X5IFP0DUrcsdKnBRDSnQizy8fDHGgR9Vq7f/o7uf7PvVjCjAIvM+7dcO1He7O/@vger.kernel.org, AJvYcCXOgQcaEhNvqhqn5XipRk6s7/mdmwsvSShk2Db+Q5oXnDnD8rTChI0D0Pb1maJlQXS/X5J3UbK/iPOh@vger.kernel.org
X-Gm-Message-State: AOJu0Yygeg58/wv2YePG7gSX1iukgZMf78U96Qt83K1YNykYMf70q8Pu
	c0KS8BFxMmWjToOPrmwlSXAU1g1+QcosnKKaxGeN5qRiu3YtJYNgkzOY
X-Gm-Gg: ASbGncuA0tNnUx5aruPdtCIh1pvGM2wHYwvnSIhAWp6VE7xGgCQUPKEZlgbw3g28Z1v
	X/pQIyNURVpG8YjBBcsIPZhCwd5c10EBiC9WoI73/WqaYKapu+5IcEw5WH4svr9O3W7Rh6mbmuQ
	TbtlzNrIImiyncgRXZnRD1HA4vOTazDdz7pl7ae78PL/zM/CdB4RJZ65UVApBHyUwO9n4eoU0TJ
	Nm5LHUz6c/1vDi5aF6HXflU7nwj8No1IoO/+ftBOwRm5aVAlVSQ7GqPGTqT5IlSf0rYkrI7mC2e
	9/v6O44UN0R5g7igtY7cff96yjJJu2SU8zxhTzM7kEyl7jX2J6Ae6iPbL4/6+dvbp40ix/K9Wv6
	WcButWYdPsTYGlscAueVhM8j+TpuiWA5IEkSeQr2C+8Ua
X-Google-Smtp-Source: AGHT+IG/sznJSOJRWqTPYkU9mtj3z/JTHqvpHXVfviEB9X7NQmlAgsa7OmrD+qN2TANTMUAGW3TFnw==
X-Received: by 2002:a05:6000:200f:b0:3e7:4c93:18d9 with SMTP id ffacd0b85a97d-3e74c931c04mr1957542f8f.60.1757336387588;
        Mon, 08 Sep 2025 05:59:47 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm41260581f8f.25.2025.09.08.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:59:47 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
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
Subject: [PATCH v2 2/2] arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
Date: Mon,  8 Sep 2025 15:59:38 +0300
Message-Id: <20250908125938.3584927-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908125938.3584927-1-tmaimon77@gmail.com>
References: <20250908125938.3584927-1-tmaimon77@gmail.com>
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
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 439 ++++++++++++++++++
 1 file changed, 439 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index 2638ee1c3846..145a2e599600 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -10,6 +10,42 @@ / {
 
 	aliases {
 		serial0 = &serial0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+		ethernet3 = &gmac3;
+		mdio-gpio0 = &mdio0;
+		mdio-gpio1 = &mdio1;
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
 	};
 
 	chosen {
@@ -25,12 +61,415 @@ refclk: refclk-25mhz {
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
+
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
 };
 
 &serial0 {
 	status = "okay";
 };
 
+&fiu0 {
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bbuboot1@0 {
+				label = "bb-uboot-1";
+				reg = <0x0000000 0x80000>;
+				read-only;
+				};
+			bbuboot2@80000 {
+				label = "bb-uboot-2";
+				reg = <0x0080000 0x80000>;
+				read-only;
+				};
+			envparam@100000 {
+				label = "env-param";
+				reg = <0x0100000 0x40000>;
+				read-only;
+				};
+			spare@140000 {
+				label = "spare";
+				reg = <0x0140000 0xC0000>;
+				};
+			kernel@200000 {
+				label = "kernel";
+				reg = <0x0200000 0x400000>;
+				};
+			rootfs@600000 {
+				label = "rootfs";
+				reg = <0x0600000 0x700000>;
+				};
+			spare1@D00000 {
+				label = "spare1";
+				reg = <0x0D00000 0x200000>;
+				};
+			spare2@F00000 {
+				label = "spare2";
+				reg = <0x0F00000 0x200000>;
+				};
+			spare3@1100000 {
+				label = "spare3";
+				reg = <0x1100000 0x200000>;
+				};
+			spare4@1300000 {
+				label = "spare4";
+				reg = <0x1300000 0x0>;
+			};
+		};
+	};
+};
+
+&fiu1 {
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			system1@0 {
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
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			system1@0 {
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
+&sdhci {
+	status = "okay";
+};
+
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
+&mc {
+	status = "okay";
+};
+
+&peci {
+	status = "okay";
+};
+
+&rng {
+	status = "okay";
+};
+
+&adc {
+	#io-channel-cells = <1>;
+	status = "okay";
+};
+
 &watchdog1 {
 	status = "okay";
 };
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
+		fan-tach-ch = /bits/ 8 <0x00 0x01>;
+		cooling-levels = <127 255>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		fan-tach-ch = /bits/ 8 <0x02 0x03>;
+		cooling-levels = <127 255>;
+	};
+	fan@2 {
+		reg = <0x02>;
+		fan-tach-ch = /bits/ 8 <0x04 0x05>;
+		cooling-levels = <127 255>;
+	};
+	fan@3 {
+		reg = <0x03>;
+		fan-tach-ch = /bits/ 8 <0x06 0x07>;
+		cooling-levels = <127 255>;
+	};
+	fan@4 {
+		reg = <0x04>;
+		fan-tach-ch = /bits/ 8 <0x08 0x09>;
+		cooling-levels = <127 255>;
+	};
+	fan@5 {
+		reg = <0x05>;
+		fan-tach-ch = /bits/ 8 <0x0A 0x0B>;
+		cooling-levels = <127 255>;
+	};
+	fan@6 {
+		reg = <0x06>;
+		fan-tach-ch = /bits/ 8 <0x0C 0x0D>;
+		cooling-levels = <127 255>;
+	};
+	fan@7 {
+		reg = <0x07>;
+		fan-tach-ch = /bits/ 8 <0x0E 0x0F>;
+		cooling-levels = <127 255>;
+	};
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
-- 
2.34.1


