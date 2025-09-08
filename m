Return-Path: <linux-kernel+bounces-805272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE37B48648
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB8E171C75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F12EA47F;
	Mon,  8 Sep 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQrA4RJM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC82E92BB;
	Mon,  8 Sep 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318551; cv=none; b=N0Y64S+ooaIlEiIpcCZiyWR6tIg/GWxjNx/YjNLe625SvM7kn/JGyt1V8JhViWS0EJKUrvLcldWGOAr2PDpFIsiyJBJmU25t9Fi3/dvhLbv7qUpn+/R25xV9sq1x3ShaNGIZrkcH5HM5eknbt5Cr82j5kYWYCh7reGTYrtOaY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318551; c=relaxed/simple;
	bh=pWMmo7vTsMCtYj9PvjgESg/bmJl0vOv+aFFj65sjgBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCFSwy7pb+qxKTC+J8WlQ4jRAxCTVXuO9Mmqu2zLavhKyYHQECNzIhOdnjJeQ4T5Rm8oia+dWl7ZWoyZtOkO1As1fwDUzH94LeFEMcPaOTR93aUpEv2qU/9ks3esm1E71EffTdjouEvcidF9STW/LH6BXV2hRH6rf7M8kX08oDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQrA4RJM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so3315961b3a.3;
        Mon, 08 Sep 2025 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318549; x=1757923349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
        b=MQrA4RJMAGrvxna+crO165Ni26XX+x7M1DxoS04oHDZo0X0/5TNRXPt9KcsTQD0P2r
         sP7ksneuzuW1DUYIFLhmw/4hcBSxw7EGEKbWMSFKcrEqmSfdOlaRGtvs0+Hshcbwa3uj
         eQOB0cK6mU7MH8nhblLcjRaUegx5n12iBWjlLDSyeNxLZavYVn0gxqysZZAl5t7zli2Q
         Kd7ODw9edM4GRnQvR+++qhglBlgfj25EkYV1hIDTkDW5aZoj3auPypGcsUL10RAM/vPQ
         gTQsuVnikU/xJYqhhHXCh4BB7lCdFzoxcMV6z5Mx79IKgZOwMugtQcLkBHeQUBHvslPh
         5TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318549; x=1757923349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
        b=dJ0LmL99jIPkarlpl2Zx4xjckQrZ+Y/38t/zw6rsYpPc/Kyw6tVSe6LyFXkaeGoTyE
         i3he6ehUSaR3bShh6+ynUoxE2lqnIYjPtV95RfHE1Ovvf5P2r8/Y3PUpOVtnoIRgT3So
         iNINyXggAPNXjD0L61YwEkKyLIAcN/6PI+Du63acdexE4ZgXO10/L5eVsjyHfQfSCfKt
         SLT87axbJiFIHvRpl03NIeqNWhfZnuE/H6VBeKDe0TUBvcrXXO9a1GbJGLCmT2ORyXhN
         wFVC3AQjLwOT5t+wnV3qhW2ChqJ4B4QGAC4moRCivlSTzGzaXBUFk3raCDJMHfuUeeAx
         4X0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqLzMxw4moBvmpdv88ccWsuzjSsQHh+MSgXp5bnnsgNZSQt1lGACqSDQNrpxKJudZgkBsRZK9Rglyv@vger.kernel.org, AJvYcCXF/ZyZD88nGR5FhX1H8rZseGa0+MT7S33aQCR1vs52sqWnX/IdtJA/Vi167qq7YxyCGS5EKr7/6whd6LOY@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrhVyGt+aWmyf1XWMW2l3+boqbM3oSw7tyeQa+JraHOQGXcih
	dFF/GKuZ5o+cDMEZR3h83knb8k10zdVRYlX23yjjq41OYK4TNo4Jrm+I
X-Gm-Gg: ASbGncuHUb5i5gg0bZ1soypDNwI7Gw51igEgUNnhUBPiZPjvdn529kpe+dIVpEh62eK
	kXOTZuZnr7oa8tnL0bxHxTtH0GRfORkmINfuss+q2jnAUpmK10hX6F/ZtweRYs4BHPErsqoozfS
	YeSDBXAdY5qtn+Uyph8HtdAD76z2/gaPm6p1LqfJXts73fv2oCGZW6qu0nE5gG08suQ1RSIUzb+
	qqYdDxuGAuio4FZdCqUZu90SHOhY8eAIQje3GgpFIF70kwpZlaYk5z+w9gvcbnutncAb00REouq
	wtYVQoxMzrtOwA4ibVIfUayC7uqDDGbAwN1qgiTzAFpSdGXNM9rvIVAnXREUX/xBnTcMNfoM3Bb
	1mQNjiKTsqnF/YFSw4OxJll7LqvuPigju7/me4fFEzONluZYEuKP+kotB+bOZeX9fxJ68nrqbXj
	UIdDYsjBMiB0BOzrrtvbzVspJhr99Ph1YPUQRAis4CqVOxYVtSLNOtmw6zDubKxo5Yrec=
X-Google-Smtp-Source: AGHT+IF5xuJKrndVnQJrr29v05c6QYNtUIFOS76fOYQ7hiiP6yT0C+Eh+nmZB7rDRHBxj/cT+rWaKA==
X-Received: by 2002:a05:6a21:6d99:b0:248:ace6:755a with SMTP id adf61e73a8af0-2533e5727ecmr9790095637.11.1757318548740;
        Mon, 08 Sep 2025 01:02:28 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:28 -0700 (PDT)
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
Subject: [PATCH v3 1/4] ARM: dts: aspeed: santabarbara: add sensor support for extension boards
Date: Mon,  8 Sep 2025 16:02:12 +0800
Message-ID: <20250908080220.698158-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
References: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
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


