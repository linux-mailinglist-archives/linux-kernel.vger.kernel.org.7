Return-Path: <linux-kernel+bounces-804192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C12B46C67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6F0188D452
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE842857DE;
	Sat,  6 Sep 2025 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShSjTWcH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D11C6FF6;
	Sat,  6 Sep 2025 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160499; cv=none; b=edWiwmteVVoVNC3+ul0oZwtDDbnNdy92ZdT9MaAHsYBcxF0qObp41iVEjZ/LZPM1GjlMLjB7b2pxHnpNf0P8LZFPp9yfrwEJ9gmSejocnu1MiS8Q3bD7h6QG4dCg/D0CwAxfjSyYcpfWwhNIhBy3tOYzYe9g+RVWtti0Yj0Ji9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160499; c=relaxed/simple;
	bh=T0uCk3whM4TQLPmUloGoHnhyxENgGtgovJSMe4EuYTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uC0qdR6fV2CWXChfIyFmjX5naP1JRHyJSIoGfFjXUjYxXkn8JCd5bxMWznnwO1OThI2F86ep2oXNYQplW/Q86/veX2mufFYP+NqNqhM4m5NcLO667paO4Z4z3Yo36FlAVuIrjaTqbh64wMTl1sSJg5YNEDF6M8Y9iJQJ9izCx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShSjTWcH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de221da9cso98345e9.0;
        Sat, 06 Sep 2025 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757160496; x=1757765296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Mr/6zv4AcMMEkuwvT+ySaDwWnup/zkHcnhD+HTewc=;
        b=ShSjTWcHMrMkU4a061tk0vQTST5XFICOn+wY1mfF4ObpOJ0qbppSUsQRbNapSRqz1k
         lMVEnrf4s9AHE+ldN/WXDTLdtcDjkzqq1glRDIRqqDYmcHpvW7vef0qde+KtTNYF6x6J
         53uXHFbQ9Yvm0TDPWgTN6hZIXhcWm9LjFZBRmjzTW164fyQGlkN+qygOZOJPENszntxe
         zLHV3U64SWFOXJ3R0LQhmk/1HfIwKVxzoxxEyxmubgGk9X2T33z49QlV4bJKlt7YXHyW
         b/Injc/kK1bjb5I7OWhqN6BPBZ1ZoySxnIsNZPCx79qc0U4MqFdcisu7oay4DbjmU1tS
         OHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757160496; x=1757765296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8Mr/6zv4AcMMEkuwvT+ySaDwWnup/zkHcnhD+HTewc=;
        b=QEuzy8VlSC7QIHv/I6Ohte7Q5zrB5qYnE5QsAE/8b0WzB4W7OCH82iIQCk70fMW1PC
         /jbFjFpggP+MpJI/sEwGE877Vrx7qxgFPXWXbVR4xFJtVYbLrUVsIL6d55cwPBL/fJN8
         Um8PMm9x2fxPCnLx6DBCqCBH7qqsGkD2pXD62bQC9y/5eLRaRiyOjv3ju5dqxRSa5Ik4
         LFU2rkl5fxJBthb6nTC9/n13ysZV7Kyf7jaRDWfNePIj+j+nTfQrJaow6/0AoVvcZLyM
         KVFThUkuoTpjWeDIvP57Ceq/r2+tiwGMpWLhBpq3MYFBKDDDiIi2SwAQA0qrzpspESWk
         R/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMZfVxdEAqE+OKlanvuQPfycmxGRncwTqfMU08oCSrHN+a1USyoA5NmLFN8MxGmbTqpDCpjNsT5B5gF059@vger.kernel.org, AJvYcCVS7pvNrV+2hqokTK7XZNSE123gKWnRJW6kVJ34khbrJ0mUsOMzQ8k7Ft3vrs/Zd1KjNVCUgOQOy5Mo@vger.kernel.org
X-Gm-Message-State: AOJu0YwEC8Fh/UKYHt7wBEwusvtbp3yWLNwYdVGlFGzkrWmn9B1eTIo6
	xozE6xJsHo4N7cxX74ZpoY4V3zK8Zm3gtiPM6ne9HrH+RdAHaRE7lsyl
X-Gm-Gg: ASbGncuhiAlo4RIRiB5v6MnI0CdgZgo0bveqsHCmE8XOaC4/EIokK5aiMv9RSmgWqBz
	Ho1OTfTuKf/Xd9FwogrlOB/f4sl4csswREz32dTWFzLYAB2RKHD7thQ1aXlP4IqnZR0ox53VAUw
	4NuYmWi/6Sb/Dsx/1gN+SbxzRN0H1YoTx9lIydnAx/9GB8L17vBJduav65wixx5skXhUCM7Kwid
	2pZWyq1Xaex9FwE7AefnCl7RLBe6BZfe2CMyE1QHQiztE4pCBJferdUlsrRaL30piRdOgc1FleO
	u3nk4lJ95Px+qmAPQ0rhnIYKTl66brOAqCQmlwvoOw9b6Bc9Dll+5qjjgZFOzEofDMgVsSVBd9S
	71rRX+B4k8QeSaknCoo4OFFzyHnq4yLxenwLyjg==
X-Google-Smtp-Source: AGHT+IEGnMuR1OcLq5hi6KejZJYg5UBBpTJ9CwU7pKvWahTivnfLTRqyzm4V0K2QWcSXvSQ2S/JUpw==
X-Received: by 2002:a05:600c:8b71:b0:45d:d903:beea with SMTP id 5b1f17b1804b1-45dde034574mr20619905e9.30.1757160496089;
        Sat, 06 Sep 2025 05:08:16 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd058ed5esm60978455e9.1.2025.09.06.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 05:08:15 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 1/2] arm64: dts: rockchip: add GPU powerdomain, opps, and cooling to rk3328
Date: Sat,  6 Sep 2025 12:08:09 +0000
Message-Id: <20250906120810.1833016-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add GPU powerdomain, opp-table, and cooling map nodes for the Mali
GPU on the RK3328 SoC. Opp-table frequencies are sourced from the
Rockchip Linux v4.4 vendor kernel while voltages have been derived
from practical use and support work: keeping voltage above 1075mV
and disabling the 500MHz opp-point avoids instability and crashes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v2:
- Revert to gpu_opp_table but retain opp-table-gpu $nodename
Changes since v1:
- Use opp_table_gpu not gpu_opp_table to fix dtb schema warnings

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6438c969f9d7..610c1c27b798 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -331,6 +331,11 @@ power: power-controller {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			power-domain@RK3328_PD_GPU {
+				reg = <RK3328_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+				#power-domain-cells = <0>;
+			};
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
 				clocks = <&cru SCLK_VENC_CORE>;
@@ -570,9 +575,13 @@ map0 {
 							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					contribution = <4096>;
 				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <4096>;
+				};
 			};
 		};
-
 	};
 
 	tsadc: tsadc@ff250000 {
@@ -651,7 +660,35 @@ gpu: gpu@ff300000 {
 				  "ppmmu1";
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
 		clock-names = "bus", "core";
+		operating-points-v2 = <&gpu_opp_table>;
+		power-domains = <&power RK3328_PD_GPU>;
 		resets = <&cru SRST_GPU_A>;
+		#cooling-cells = <2>;
+	};
+
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp-500000000 {
+			/* causes stability issues */
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1150000>;
+			status = "disabled";
+		};
 	};
 
 	h265e_mmu: iommu@ff330200 {
-- 
2.34.1


