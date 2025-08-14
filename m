Return-Path: <linux-kernel+bounces-768291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA695B25F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AD59E8109
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE42F067A;
	Thu, 14 Aug 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjgLBkhT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA592EFD88;
	Thu, 14 Aug 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160951; cv=none; b=UzxBZe/fSEhNzux5U7ImmlNXJBBvpB/LNBtOHMU390y/JGPUlCJAS0x+WZWtfRoHdn3CV87IOTciNdN90mlsR3lm+vNvhsgEUN3IM0/LO7yTdbBi1m8VsFfPST6FuHcPHc9TYeqK8lj+dW19IbGYgcNPckqiy9qgvFIq2IbQHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160951; c=relaxed/simple;
	bh=sJWYGnT1WWEG+kqtUxqmZBzwgmvbVmwP8qD+SOYqeyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeGjeGqXtSsm7c5E6JWABpd6EBGRJghzUUnkZ1kZTg36X1khYKF1HeyXKZxjV9nRc0710qQ4JGPusdKCR+s2/iIBMepE/5hPX6fH6+p2KTa34X524RUmxOW7TdVZG+nRgQFJxUbK22MS65uS6GNG7K6IovoEzX84n6Bhfp3JZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjgLBkhT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so4611985e9.0;
        Thu, 14 Aug 2025 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160948; x=1755765748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWlw5Ms5yTVtOwXxGv7Ts8LYQp05G0qkRwNzIO4qfS4=;
        b=VjgLBkhTFVXG+HuwEomlkG8A8GeOZL+WW/FQeCE/JwkDu2Js+P0nmAlgVE6TW59O/L
         xIDSc0EzfdsDOSraew+W+mP5rGF2EVQUhBijIADfbaGMhe8aC8LdINwI9vRVxh/Iqs8/
         S1TF1MZ1HjH4/U7PhNNBdDmDZpcb90f8I39tbjV4kmbz+uFz9hvc+Rwdy7SNDrReMX2O
         no14HHKF0+MReDFRJKOYMrSxtIuzUklahq2hv2jKKk+TUC4iU0kZX/cbTFpUMBbovt90
         qNPo3kGq1Y05nq8CTae3tOTcbBtj5bJ9TgruU7iE2H5DOO9UnfnB/tDhMWZ0b18a6y7P
         3tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160948; x=1755765748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWlw5Ms5yTVtOwXxGv7Ts8LYQp05G0qkRwNzIO4qfS4=;
        b=nRA8kAP6kQwM3yFRabAHZO6qNT0Adh6c9ZJtMm/YIYC27yCfEcRu5vYfOTK51YwE9Q
         50GzCKnArVemtZiJIX5k7mfrRix+unsObZ2G5hUnzuVKQshoDGuDgqD6ebmHHdLn7Sjo
         H5i2ksIvIQKwZ5M4xetYmGDhgYhSRVVzJW1I7AbzHSQ0YzHf3aHR0O15hFl4svfF49Pe
         b2/7icSMRT4yP6VkkekG9dsJJLqmz5f7UVtZwgqVp1OGf7irgSJnu6CV7MoCLJs2vUHW
         +8NML/LVEgOQn4r6cxyYv8ICUVoXfTWZQXLYrU3mASWmvlQyumbWkJe2Wcpr+HPNlMGN
         RLRA==
X-Forwarded-Encrypted: i=1; AJvYcCUcBhNwITYOVprNpr+BUQ+/98W6Y0WGa/FrQIA5Ckn9QFPObM/PoAVgs8+J+JpzrpIrQcmH0bb/5EKi@vger.kernel.org, AJvYcCWfhUpEcMB2rfqTXBvikL3OZteyuAznfjkS3DZpweVClf6fW1shX2ZrYSJgohIN5UdK0/J3EM1+07GrH/EA@vger.kernel.org
X-Gm-Message-State: AOJu0YxeH1uz6A9kKG67WMBgJ/exZAATyzofeZylCkt7MZPIxdxakfd+
	N1HfzU5ZO0X7OdPPrj1ivDjxqXtPxoR/lcvSQVS8Me1Sp7+0kiAunP/W
X-Gm-Gg: ASbGncuTqWl8FVfbwCztsPW4+4TIMaA0wRpN8EJyjkfKc5zne42o0X6JgcQDiQbdITn
	3n1QAQV0/aKJ+5n0llUTsZWmUt6sAyOWipifB8CywoOPNMQ3p09HXExcCIhmJ4Vn50Gi5YL6Nj4
	Y3UnUp4cUYOYdXvac1Atuz+LoJYVyuCTzqveGX0wvcTaCTFCeHB5JnN6hgJwhK6AYcACmiqeb9h
	WEOST+O44CwjyBY1rxXCIVL22b/TgBFPvKN9KamnF0DTGzIx513RNM8OJVwUGlEPIIe4drfamCs
	drhtAIFLspTgsjUXABf1wFgkO5xyXnvUWNpOYU4EM1sdJfQVACx79unXXmHpEL97+1525ia6zlG
	fPoR2vebX6LC9AOr49YQN3vsLPPDDStvsyg==
X-Google-Smtp-Source: AGHT+IEU57fYybpMMX4gtzdy06CQx4fqP4lkitpYTPTwDLN7UudJOEyCJmNn9h6kaZbB3y6cb0LX6w==
X-Received: by 2002:a05:600c:3b93:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45a1b605070mr13966415e9.2.1755160948068;
        Thu, 14 Aug 2025 01:42:28 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6e336csm13114565e9.16.2025.08.14.01.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:42:27 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: nuvoton: add refclk and update peripheral clocks for NPCM845
Date: Thu, 14 Aug 2025 11:42:18 +0300
Message-Id: <20250814084218.1171386-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814084218.1171386-1-tmaimon77@gmail.com>
References: <20250814084218.1171386-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a 25 MHz fixed-clock node (refclk) in the NPCM845-EVB board device
tree to represent the external reference clock used by the NPCM845 reset
and clock controller.

Update peripherals (timer0, watchdog0-2) in the NPCM845 device tree to
reference this refclk directly instead of the previous clock controller
output (NPCM8XX_CLK_REFCLK).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 9 +++++----
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts     | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index e4053ffefe90..ee7da5e8f95b 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -47,6 +47,7 @@ clk: rstc: reset-controller@f0801000 {
 			reg = <0x0 0xf0801000 0x0 0xC4>;
 			nuvoton,sysgcr = <&gcr>;
 			#reset-cells = <2>;
+			clocks = <&refclk>;
 			#clock-cells = <1>;
 		};
 
@@ -71,7 +72,7 @@ timer0: timer@8000 {
 				compatible = "nuvoton,npcm845-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				clock-names = "refclk";
 			};
 
@@ -143,7 +144,7 @@ watchdog0: watchdog@801c {
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x801c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 
@@ -152,7 +153,7 @@ watchdog1: watchdog@901c {
 				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x901c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 
@@ -161,7 +162,7 @@ watchdog2: watchdog@a01c {
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0xa01c 0x4>;
 				status = "disabled";
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index eeceb5b292a8..2638ee1c3846 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -19,6 +19,12 @@ chosen {
 	memory@0 {
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	refclk: refclk-25mhz {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
 };
 
 &serial0 {
-- 
2.34.1


