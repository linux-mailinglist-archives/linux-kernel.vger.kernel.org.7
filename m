Return-Path: <linux-kernel+bounces-833163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7527BBA1515
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311D54C2919
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B5320CCD;
	Thu, 25 Sep 2025 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/lbWK7x"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E9320386
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830795; cv=none; b=RLJJrbaIUuZNYcbNMU5CPibHKEsMerCLSDILKz6OTVniNNDWCJHrbP44iqRaHaIlApYSVXJmIErZCjTLjKthfT+wlOG6ViYncAbnK6DlSSIImcFIV4bSp5J3TpUcV+NigVUTxvX/q62lv+pg0TaSGY0m8415OHSr6t6vnOQ4Z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830795; c=relaxed/simple;
	bh=sYMZf6VzU68Swxw2Hbq7Zqu4iz46HDLkHIwlbbykqSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjYmChZCjSUx4U0xVOUvuXRu4BnwUVna6E/O3jEpa2E9fdCPnsumV1BT6vCEOgNRHwb319yWZqwsSRW09jHJozWJL86up+UF1soGyg8EIGq0EHim7Epmlhmx+7Ae9+5kPnIHx0UybGv+K+h+2RcR7INF+HMfHoeTYsObCtW+43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/lbWK7x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e317bc647so10072955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758830792; x=1759435592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAFYbKOCSpWWlldyOJtQlThCD39zJYVIpayPNRXRheQ=;
        b=Z/lbWK7xbNedvcbhR7aT9mq2tc92SN+t8lRFWeRgewuTcfFjI83yKfzlCbcF0mi96b
         apgeZaqNqc917ETMc5ma/t/WgTW88iCjsHKRXOI+vAP9rPyPXF43/+Ypn0jW1glSELKm
         37Di64n/MlxztsTyuWUHMzlYHipYtMYhFMcka3vUXK5mXWSgtbVlEOpFFWYSD8Geutx8
         +P2aT2l69o0ZmxRfUDD7JDn66QQSNLcSJMmoUmfN3T8+K59K+x+OwvnK1n8PIKDAclDi
         WlQaljs0ii3VZPa8sZFEVeZqm9CFXWZv4le7N9LFHNrBBkCq1smpwB7DEmzCgcMn3Ync
         mExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830792; x=1759435592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAFYbKOCSpWWlldyOJtQlThCD39zJYVIpayPNRXRheQ=;
        b=UrGhi2pBXp8RLk306Z9YdwunXx0eRUtf56MIF16W2YPbzSRF6MRpIc0XjLMQzwaDSP
         2wB07NaGyMKt46Hba7h1wwbASmizGKLpS4lu6mubyb7YGm+/W40u+Pf4EdPFZcjvjL5R
         EgwSNQHAhbFTf1qSWsRsxs1Z/LjC+AkfvouVr4gEtcRcUUYXqDpTDrTW7Gc4JvmbqpAg
         SiqAf++HO1T3rC5j8L4QpB4kGTMiNfRlaP/N+zQ5WerqrVQ1e+9nirBMlStmKwBbVh/p
         Johhbv93RclqzAPidzqYwBnwcJzHnKNBLaDEks85VibvSeXHPVF9g1P3+7B/sPFTfRnk
         ZH1g==
X-Forwarded-Encrypted: i=1; AJvYcCWqAkQqZWGuq5PfQGDc0fzY0L4dXrFMnZ9FLIVDY3I3ijARf/WX+qI4GxMalRWoQ+thD2YdCZa2WGr2HyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxuHKSOd4+cyQQj7XECqJhnKydhsURNGd5O6ieG1wEW7+b1lh
	5N9nZSbxq8AaKle3kJ2tqwOloa/qR+Ce8IuqrIbYS2ko1DbjkGNHo6pc
X-Gm-Gg: ASbGncvJSCuJP6KDQi7tUM/uRMmXk+STq51m3Nmly7dWd7U3e3rSrHVB5cNnS89IjPg
	7qE2IQDegiiZN9La60htTDgS7h99NW4vzCKSGg6/fa5dLqQ3q2NBQF996Cfs8ZpMWNXAacQwkUX
	M1ezB9j3Zo41gty2AWshByAeGwbreNfi/q87ZDbGUvZhxEhf3qEOSF+YpDA+Qdq64mSlR4cy2yN
	rhdxgQVi//sA87htDQlQA6NzjykLRNLJ67tzUJQDPqZQFSkxkr38Qg3aygtSw1i3UupnX9ptGQu
	uAEHUM6UGDYN4chpIpJuv75Ak/BIVuBWKerK3g0pKWyur8LzALQP9EcZtlyHEQ4PNI8cHxkAZBz
	pSfGDzAEXSOrtakRGunTEtb6cvX0780n4QA==
X-Google-Smtp-Source: AGHT+IHXylFhn9UHizEh2nzghDwK4WxN/3xzMVvMOLLq2D6z7kkiJdJs7LTiV/hUeq3aaR+Brk67nQ==
X-Received: by 2002:a05:600c:3551:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-46e32a11b17mr52158175e9.31.1758830791663;
        Thu, 25 Sep 2025 13:06:31 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm43901835e9.10.2025.09.25.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:06:31 -0700 (PDT)
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
Subject: [PATCH v3 1/3] arm64: dts: nuvoton: fix warning and nodes order
Date: Thu, 25 Sep 2025 23:06:23 +0300
Message-Id: <20250925200625.573902-2-tmaimon77@gmail.com>
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

Fix the warning in the gcr and timer nodes, and modify nodes order by
ascending unit address.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 35 +++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index 24133528b8e9..a43514f624c0 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -18,7 +18,7 @@ soc {
 		ranges;
 
 		gcr: system-controller@f0800000 {
-			compatible = "nuvoton,npcm845-gcr", "syscon";
+			compatible = "nuvoton,npcm845-gcr", "syscon", "simple-mfd";
 			reg = <0x0 0xf0800000 0x0 0x1000>;
 		};
 
@@ -59,23 +59,6 @@ apb {
 			ranges = <0x0 0x0 0xf0000000 0x00300000>,
 				<0xfff00000 0x0 0xfff00000 0x00016000>;
 
-			peci: peci-controller@100000 {
-				compatible = "nuvoton,npcm845-peci";
-				reg = <0x100000 0x1000>;
-				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk NPCM8XX_CLK_APB3>;
-				cmd-timeout-ms = <1000>;
-				status = "disabled";
-			};
-
-			timer0: timer@8000 {
-				compatible = "nuvoton,npcm845-timer";
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x1C>;
-				clocks = <&refclk>;
-				clock-names = "refclk";
-			};
-
 			serial0: serial@0 {
 				compatible = "nuvoton,npcm845-uart", "nuvoton,npcm750-uart";
 				reg = <0x0 0x1000>;
@@ -139,6 +122,13 @@ serial6: serial@6000 {
 				status = "disabled";
 			};
 
+			timer0: timer@8000 {
+				compatible = "nuvoton,npcm845-timer";
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x8000 0x1C>;
+				clocks = <&refclk>;
+			};
+
 			watchdog0: watchdog@801c {
 				compatible = "nuvoton,npcm845-wdt", "nuvoton,npcm750-wdt";
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
@@ -165,6 +155,15 @@ watchdog2: watchdog@a01c {
 				clocks = <&refclk>;
 				syscon = <&gcr>;
 			};
+
+			peci: peci-controller@100000 {
+				compatible = "nuvoton,npcm845-peci";
+				reg = <0x100000 0x1000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk NPCM8XX_CLK_APB3>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.34.1


