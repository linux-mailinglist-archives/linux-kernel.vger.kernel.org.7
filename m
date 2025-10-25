Return-Path: <linux-kernel+bounces-869768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D5C08B05
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53BB1C87C61
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261528980A;
	Sat, 25 Oct 2025 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoCirQMk"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC61494C2
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366808; cv=none; b=hvQawGLFlN7tiIl8CE/eM8ddiqoqorFQmu4ef1vGHlIvO2RcoDflzhsFjuUOkOGQgjZar5L1++EmBs/drRyIj3363fJ8Yt44VWSd/zFcD131C7JpMrkcucQtjcKcnpEK+Jdq+v0eI9sJgb1nKdSBUt0mX33ktbytLkpMkX3YWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366808; c=relaxed/simple;
	bh=HLkZrRq3NGY0xnF3Ajij+/FlY5p+nZpDzyvy6gl4718=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHpjL4n5Ral9Mq6qb5kn/Qz1jWdYpVDl7/Lb+KfH3XEtoJIR78C79lkk/9UJFL+R97Mx9hnh5WEnYaik4xzQb5ssYKzTdJEZzjjrA5urdFUhZYlCjO6BDZVvxmN7Uxb1x/otqQmmcx76i54xLFVv8cYUN8WCx41if/P2/DWfbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoCirQMk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378d54f657fso33856931fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366804; x=1761971604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGpVSnY2YGnC6StYjZi+g05NBMCnFA0794RPi3L6J+s=;
        b=hoCirQMkw5YFtqaX4tBDfoaWOlUNrfXVLQsp7qAjEZe+0xfT8aFeCVATC4bDN458Tx
         V6/SWYhMGJVCSX55kF/q1p18fWptMjw/E9NPSQI8tfsTn5Am06mPah4tK6o/Kt1tPF6H
         q1xXOYhQaEhJaUW1KXCtTtMt+URehJD5fs6vS68hQRvKrX50ZQCB4w44p50SfNFR0j0y
         3+hxuviMgpBxFnmugOE/2+0qq3drcxynlhGGp6sDPvjX4D+H3lfWxHm1B3tylvn5Ed3m
         mt/71MhC/fnh2q8Wgpnucxz7fgHvBoqBoi0EU5JB9ScNbKQjNdmRgAHMMyHOaclAO0Yo
         rL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366804; x=1761971604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGpVSnY2YGnC6StYjZi+g05NBMCnFA0794RPi3L6J+s=;
        b=NhWZPPT2yenOUIr7130lmr1pk6S13tO9ATbdFQwFOBUV1rPSa5X4o3XS936TpxtipH
         bRt+4Dn0k/7kLeORqbJZ47usKoS83vL9ai1/0xrP5GHpm0ylPte02jK18sg1lmX5ftkt
         yMlvzWUxeDliEuWaldN4maYWEWZ/CdFzk+0+c448Ldabqa8kxFibaJ0I8jq0xnfDgNhT
         ZzLHSB6jBqSOn18mO+fcCD543sM0+l4aSPi677o5RyzPvrsQYEisKG0ezNkuFX/QrnYG
         WRHLyplat/aBddFHRmlfpQeJ/Uu9dvXcmcnjb1U9G6KwaB+nV03Fxkyry3xx6CpnrDGl
         /7yA==
X-Forwarded-Encrypted: i=1; AJvYcCWcOHo37wdS3equyDVYUDkQGa87EHrAKP63lK7vDwByfDO5sYKQJHgr+k5hD041SbV/frRNcr01+DQN6do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsML5JERj6ezy0vOHdcsW3zQrtaJXjq5Z0PbmMGqpDH1q33d0V
	W6l2vGaCpv5XFhzFgQwWBzuMshdvvwoRPNJyxvuAZPpnhF9HoZWCVaKI
X-Gm-Gg: ASbGncvYChJEf2HBRVGUIHoxGz5fgI867Zybj654f9DyMSrW7KGVshmv7rIDL2UL+ka
	swb+52Qb/deXR/9mg0tfcO8ZMQ74i922GI8MSi9G/jsgP4XdAdd6oAIDBI+8DaVW41YnI+corv8
	KzNBN8Hydx3fPinh6AoQWO13LIleJ3pqGxP8l5fdhN35LcqiWQTrpHcwK8mQFQ+bX+rRS6ITwd5
	JWn5tHgrnvHQ7mftlR1+DvOplMnPdKeOOvJ/k5iF5EDqZq5vMtW5VmXYlBfwRSj1wKWMjNzHJLu
	WTFARShhk8CqZtFWfe9jpcJvbF9HV1YgqcnY1Tw3HPG2nLhvbjccnn/2WRPTifF2UZCrHUQZ3gn
	E3q/kHu0sHKEXI/BlaJf8FgGtArpvBrvTnUYa0Tw/TNMQBr5RGBJc5vodKZaC5rz3BfQ+UngmWj
	Ks
X-Google-Smtp-Source: AGHT+IGj8aCrZj29Rg9HWwRsU0X1CDkriVFw8huU9nZ548l08naKsaur1apTfOMiV+X0MeyojMrrVA==
X-Received: by 2002:a2e:b8cc:0:b0:36a:925e:cf3c with SMTP id 38308e7fff4ca-37797a39146mr98679831fa.31.1761366803946;
        Fri, 24 Oct 2025 21:33:23 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:33:23 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] Allwinner: A523: add support for A523 THS0/1 controllers
Date: Sat, 25 Oct 2025 12:31:29 +0800
Message-ID: <20251025043129.160454-7-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, THS0 and THS1.
THS0 has only one temperature sensor, which is located in the DRAM.

THS1 does have 3 sensors:
ths1_0 - "big" cores
ths1_1 - "little" cores
ths1_2 - gpu

Add the thermal sensor configuration and the thermal zones.
Trips temperature, polling-delay and sustainable-power parameters are
derived from the manufacturer's BSP.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 7b36c47a3..0cbe73601 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
 #include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
 #include <dt-bindings/power/allwinner,sun55i-a523-pck-600.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -26,6 +27,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0x000>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -33,6 +35,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -40,6 +43,7 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -47,6 +51,7 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			reg = <0x300>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@400 {
@@ -54,6 +59,7 @@ cpu4: cpu@400 {
 			device_type = "cpu";
 			reg = <0x400>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@500 {
@@ -61,6 +67,7 @@ cpu5: cpu@500 {
 			device_type = "cpu";
 			reg = <0x500>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@600 {
@@ -68,6 +75,7 @@ cpu6: cpu@600 {
 			device_type = "cpu";
 			reg = <0x600>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@700 {
@@ -75,6 +83,7 @@ cpu7: cpu@700 {
 			device_type = "cpu";
 			reg = <0x700>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -398,12 +407,46 @@ syscon: syscon@3000000 {
 			ranges;
 		};
 
+		ths1: thermal-sensor@2009400 {
+			compatible = "allwinner,sun55i-a523-ths1";
+			reg = <0x02009400 0x400>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
+			clock-names = "bus", "gpadc";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+			nvmem-cell-names = "calibration",
+				     "calibration-second-part";
+			#thermal-sensor-cells = <1>;
+		};
+
+		ths0: thermal-sensor@200a000 {
+			compatible = "allwinner,sun55i-a523-ths0";
+			reg = <0x0200a000 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC0>;
+			clock-names = "bus", "gpadc";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+			nvmem-cell-names = "calibration",
+				     "calibration-second-part";
+			#thermal-sensor-cells = <0>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun55i-a523-sid",
 				     "allwinner,sun50i-a64-sid";
 			reg = <0x03006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration0: ths-calibration0@38 {
+				reg = <0x38 0x8>;
+			};
+
+			ths_calibration1: ths-calibration1@44 {
+				reg = <0x44 0x8>;
+			};
 		};
 
 		gic: interrupt-controller@3400000 {
@@ -732,4 +775,115 @@ npu: npu@7122000 {
 			power-domains = <&ppu PD_NPU>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 1>;
+			sustainable-power = <1200>;
+
+			trips {
+				cpu0_threshold: cpu-trip-0 {
+					temperature = <70000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu0_target: cpu-trip-1 {
+					temperature = <90000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu0_critical: cpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_target>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4_thermal: cpu4-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 0>;
+			sustainable-power = <1600>;
+
+			trips {
+				cpu4_threshold: cpu-trip-0 {
+					temperature = <70000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu4_target: cpu-trip-1 {
+					temperature = <90000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu4_critical: cpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_target>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 2>;
+			sustainable-power = <2400>;
+
+			gpu-trips {
+				gpu_temp_threshold: gpu-trip-0 {
+					temperature = <60000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				gpu_temp_target: gpu-trip-1 {
+					temperature = <90000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				gpu_temp_critical: gpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+
+		ddr-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths0>;
+
+			trips {
+				ddr_temp_critical: ddr-trip-0 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+	};
 };
-- 
2.51.0


