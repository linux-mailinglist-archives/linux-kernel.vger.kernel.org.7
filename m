Return-Path: <linux-kernel+bounces-749169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00FB14AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D8116C542
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F42C2874F1;
	Tue, 29 Jul 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXz5gaM7"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858F287253;
	Tue, 29 Jul 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780442; cv=none; b=S4EnSEkpxtypFE4EHboBiGAzR2UP4EqkSSqUSbQloWHVY6PfPvX2Z/RlDCg13S6BcAKK5tDKhs7KCT7TNAMidWHMlxbnPMrgL755lJ1Ge0upZeYc0XlyxPzkjSBx7DlxG6HdYOqi26PMcPL5RLV9CxpDILfSh3aF0pGYDwiLPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780442; c=relaxed/simple;
	bh=pWMmo7vTsMCtYj9PvjgESg/bmJl0vOv+aFFj65sjgBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Po/msIcryqvA2yjZtHiVj6kNNv0rKzkmLFWW0a31o4mnGhn7QEhMoKBmZ2YoTMEAgr3Ka+Bf/APoDKAdtspB43c/uMlQwtwYOSMbnFGDOnkbxhhq/tb7Fg8ef4Dr+Qpu+vcRpvTbhG19Gby51Hs2QGhvXjsmtgQGvkMsOHNr3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXz5gaM7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-769b19eeb3fso487546b3a.2;
        Tue, 29 Jul 2025 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780439; x=1754385239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
        b=mXz5gaM7cNdV0CpmzP+/+PhctEpcxKSVGIIjFYuPis6k3bVG8MqqGfwou0hlFbWweO
         sXGx+MgscshySuxkHrDMHRsBrqV1VW/0Wqa7mmKXCFm+Yk1FBIMnhoAX/aZv2HyQV/Xt
         DOHPwiprKRoL/BrTh0BMy07JYZGDAU4kEUzWtLQbLCuARhWetd8rZpcUh6Wf94IJoRDN
         TCi/QbCkDC6Yp7R/Ai8qSgfTF2DPxvr0iznjvD4byqrDrqDysfp6LrZ7ZcKpe5J4AB+k
         gn8lBLDY0pHv0Nsvgs54mmu8AmBj+p5G9v12zRkh2VSd8SrBf8Crq7k7l0g430HKcqrM
         fwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780439; x=1754385239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
        b=rNMV3xRevRCrs1N0GkrI36G2xxq00Bz5mGHeMcAD6him1w983Wfwnal2REqJlzf7lG
         wEWV4JXA9rNT3CWAffi7WdgNuSKIMOL80GloPzXgS4BreC8DvDwHWAMkqDvdky9lX7ju
         oBDqFR2+WN0TYm32rDmhzNXu0xQfjIrAQZJbN11wavYfaUc5bGI1ja52JGXisiubw4CZ
         ovCozb4Ad+CeubdWXJY8TXk+/OgNBO0X+GbGn+DgesqrRKFasnpCtJChXOMe+/cR/ac/
         Jo3lYYKGBCDfJnONGzCWTuNUsHNguayqnG/5KwalYXtSJ1yUD6xRp+q3APRbz7Qi4TK7
         F74g==
X-Forwarded-Encrypted: i=1; AJvYcCUCSnUmmN4kxeRaLMhRSIyJi6ROq1a5D5yqa9cv8GvjxB5fmz7az1g30TLJ1SOazZUUal/C1axAYLaR@vger.kernel.org, AJvYcCXD813c0y0+wEaX6uqfhRSoSTI55Q+awaDLNqyR6sCKOdn+6ne+jY9YikNV+Wp/QF9sYRhsInYyrmcQYtzd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+qHrPrAh8Mp+rNdGooyzP2LszAZHU2QSyvn5FDgNYPJOWrmK
	DwZ3oSXdBJ/BGWG8Rx/JdPoYUFZ8lzKOwiYL3a0XdQd908ua2rOwvNi3
X-Gm-Gg: ASbGnct32ChDUd0/aBC7jfGHijPfuhlnmC0ZH8OdAhSjd11FDuo2saIjysCSDn3xRxJ
	49LiwVcu+XuI0GsS3VVj8XSxPyMvmxVL/zveC199RBV/pd7CzBPUdKELO9E5w8y9/+h0EwOFiuE
	5bZJ/jb7/59PpIU1VisJyrtGoNNCRIUPDJ+Q2sSSfIxhsrxmk0J0rjcCOAB2xwy5zj4RRVqc5gg
	LGHQ/Eo2u6sznT8u2NvU/kPyraej6mMpTVmoqGXuHYNBv16TW1HFNEpLfEXQ3D6a7bQ7L4bq7sc
	AQadzYUH569+HVYXsSNCivZ12owuDKwxbWBrkPp57y7tiw6YCeXRzkXTIc4VLmFkF7upkijXHyX
	qrmTl8KqGRKNA0V/CMMD+tAumcrW9IWrtdrMTvkl6eyDYUtb2LQpuhNh2rzUSYzkuwiOczFxKmH
	EtbZFCOZt7SxJBy5nCvm10ng2dKGUmu8WzM2slQGuKpE5Ks9t5EkzwQPMK7g==
X-Google-Smtp-Source: AGHT+IGqVc8kW/CjjxVNzY8FasF+F5KZIuLBY5w92Xur7kp/aZMpOLaC9gys/5OjEFBRAksP1ITVVw==
X-Received: by 2002:a05:6a20:548d:b0:232:93c2:8851 with SMTP id adf61e73a8af0-23d700c695bmr23759842637.18.1753780439412;
        Tue, 29 Jul 2025 02:13:59 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:13:59 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] ARM: dts: aspeed: santabarbara: add sensor support for extension boards
Date: Tue, 29 Jul 2025 17:13:43 +0800
Message-ID: <20250729091351.3964939-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add power monitor and temperature sensors for extension boards in bus 6,
8, 10 and 13.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 824 ++++++++++++++++++
 1 file changed, 824 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ee93a971c500..2f5712e9ba9f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -39,6 +39,38 @@ aliases {
 		i2c37 = &i2c12mux0ch5;
 		i2c38 = &i2c12mux0ch6;
 		i2c39 = &i2c12mux0ch7;
+		i2c48 = &i2c6mux0ch0;
+		i2c49 = &i2c6mux0ch1;
+		i2c50 = &i2c6mux0ch2;
+		i2c51 = &i2c6mux0ch3;
+		i2c52 = &i2c8mux0ch0;
+		i2c53 = &i2c8mux0ch1;
+		i2c54 = &i2c8mux0ch2;
+		i2c55 = &i2c8mux0ch3;
+		i2c56 = &i2c10mux0ch0;
+		i2c57 = &i2c10mux0ch1;
+		i2c58 = &i2c10mux0ch2;
+		i2c59 = &i2c10mux0ch3;
+		i2c60 = &i2c13mux0ch0;
+		i2c61 = &i2c13mux0ch1;
+		i2c62 = &i2c13mux0ch2;
+		i2c63 = &i2c13mux0ch3;
+		i2c64 = &i2c6mux1ch0;
+		i2c65 = &i2c6mux1ch1;
+		i2c66 = &i2c6mux1ch2;
+		i2c67 = &i2c6mux1ch3;
+		i2c68 = &i2c8mux1ch0;
+		i2c69 = &i2c8mux1ch1;
+		i2c70 = &i2c8mux1ch2;
+		i2c71 = &i2c8mux1ch3;
+		i2c72 = &i2c10mux1ch0;
+		i2c73 = &i2c10mux1ch1;
+		i2c74 = &i2c10mux1ch2;
+		i2c75 = &i2c10mux1ch3;
+		i2c76 = &i2c13mux1ch0;
+		i2c77 = &i2c13mux1ch1;
+		i2c78 = &i2c13mux1ch2;
+		i2c79 = &i2c13mux1ch3;
 	};
 
 	chosen {
@@ -574,6 +606,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c6mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c6mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c6mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c6mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c6mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c6mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c6mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c7 {
@@ -588,6 +818,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c8mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c8mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c8mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c8mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c8mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c8mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c8mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c8mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c9 {
@@ -619,6 +1047,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c10mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c10mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c10mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c10mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c10mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c10mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c10mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c10mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c11 {
@@ -748,6 +1374,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c13mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c13mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c13mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c13mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c13mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c13mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c13mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c13mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c14 {
-- 
2.49.0


