Return-Path: <linux-kernel+bounces-848505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E99BCDE97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AB33B07B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A914127877F;
	Fri, 10 Oct 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUZh9YSE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19E271470
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111792; cv=none; b=DuQNOecgoFzodMm+broP7HbU2e2pOIJ+MXmPpXH5ywIbkI3JjR4AVgQvQ19STFuAIO2+XFWe31cJMc3AdNTCZAGCty7s5AUEgcMHpnCmQs0F8/D1dvl7kOVmWRaTAwA2f5T/40lFdnfB5v4i/gKPs25Qd7x+5dchJ3L5Ln9OACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111792; c=relaxed/simple;
	bh=qy58+hYfxQW2mQ5sz6S6JQNjtjzjW3pl/fdczNT6W+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NFN8WlQ9pgcF+jHSG3oTqMWSaoQCz+/rTspn3YSAo5StUyNqWDFYckfQ/flK/iq97JvB020EF6FpJHjROCtL5L3+IA8GnY+zCyRgVRUG+siZoVS1H0iIV10us6Yr4flHQVg2N+BDDVED+YZ1Snba/TGfmiRHukjyWNnKiorND5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUZh9YSE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e44f22f15so323739266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760111789; x=1760716589; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZoRFa4EgNbo9YHpT/rgkVAy6RF2nhrPvBGmNOSTvII=;
        b=OUZh9YSEqwPb6zNfLojcw+4urecEii+dnSI4Hm1nUOo2OU/9VY3GUy2hEDase9DnoJ
         ryGFcI4Yom2LUHLmcEQGhNPyh/GU7tOkJ47UT5VM6AkY6fLNwJYwtDoRtk5urFVsBM7B
         41fdr0+xYkp+AqWU4RDR3MZGDAxjyv7JVbGBZiamhNWZl59fgprXnuo2aEYe3Nlok7SR
         LVYBcoUuZ+Pat/boIaedK+tfDRkkMOa6CMI95BFZJeEvJlGUnY2cxnb0LSr5U229Yaqt
         yTGTRoAFRxMF7gLSY3w+qvNI3rJf0DKWHoOhvOkA2ndLNNuOke9qs/aYRNibuHACp4Lo
         zJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111789; x=1760716589;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZoRFa4EgNbo9YHpT/rgkVAy6RF2nhrPvBGmNOSTvII=;
        b=dxKDBkJPg+diZ354Gvshqhu9Er+2BYiGUbmR/WP2wL+gTYI1lZpTg0gVxb+BZ74xPs
         ceEJInFGMkRyXgd1qxDuxsT6G2wK79qfKFAy+CZ2u+9XySfozhHvIwACA372pj0SGcQC
         r6ZQISmcjW02uqDllogAKu3SRe42dh0B90cGpFqdyLFtYz1puY4u6I7DQXjkd8QlzhW5
         OsYb/B+omVy2TTe8hlDrmiLKkTuj5K7kD6PXc6bX4+gyR0IBP6kwOk9Y0UgXtohRB8+v
         QgwnpXtllc7UrlqO+lE5m45M0419GJEBZpUrKKEAfQkP27k7Avb+P/o4HsuFSv4/SjmI
         MX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ki3Lolv5Qj1vF/KiUpkvUgNOYxdgyP0i045rPaWqAOLvPMEmvgcMgewOL9yZ8kC04Wwk+PU3iAyFOcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEz16OdIcl44wa4BAszlqAP66RLHRxi7XsTUyR8D4n3HO569fI
	KGARauyhrM3YxE1eSTSiZGT+dT0WP/CRZTQu3m5n2zRUEP5wl3pHqoXnEJx36unbmLo=
X-Gm-Gg: ASbGncsBCS4d6UuiHStkhMeHyYTXbczKXnmA8Zg4C5wxyxXR822L0NE68dwdPpW3aEB
	r5D36sQ7UNvJ3UmP0n2imI0wA8Gn/xOv4DJVlT0jzPomTVFxFBKWNiZXNp6ibVtu9Hezg3whStd
	LJGyw7QPFpLsEeBMkFhnitiy/tao0qN6ruTAo0ZErZ+T9W9/gE1jddMDdS/EUjwzB/tpIlbUwW2
	gsCyHoqDHQwTnGc8XycjN487pgsCEak/1bBniSGokCZIIZRJlLkegGFM6v7HheRkGG2wVE5fY9p
	RreyzYdBFjOKRr/LrgvxeKwO1oxTgomk8BQFSBTeKl5SSCogazkU293zXcUJXvV7SEssHGhJiXl
	vecXmK1lABD6624LoRJAZyeJB0SZNuwfFtAN+ICGovrMumrDNa3SIifqPEQBW1ZsrV1mTdNgCA2
	WrnJY3I1/t5DTKwFRAW7KlwxR+vWNK/Ej9c5A=
X-Google-Smtp-Source: AGHT+IFPrLD0cpURVx9vlEq9MIRSEh4Uvrp2QcOigo0VAcKE9vYjUK34xwAVj5/gi01gKaUb5M2abg==
X-Received: by 2002:a17:906:4789:b0:b41:c892:2c67 with SMTP id a640c23a62f3a-b50abfc861amr1291709266b.45.1760111788585;
        Fri, 10 Oct 2025 08:56:28 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm261285866b.5.2025.10.10.08.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:56:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 10 Oct 2025 16:56:26 +0100
Subject: [PATCH] arm64: dts: exynos: gs101-pixel-common: add node for
 s2mpg10 / clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251010-s2mpg10-clk-v1-1-dafb5d179395@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKks6WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MD3WKj3IJ0IJ2ck62bnJRkkZxkYGaQbGimBNRRUJSallkBNi06trY
 WAJcH5UZdAAAA
X-Change-ID: 20251010-s2mpg10-clk-cbb8cb060c16
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On Pixel 6 (and Pro), a Samsung S2MPG10 is used as main PMIC, which
contains the following functional blocks:
    * common / speedy interface
    * regulators
    * 3 clock outputs
    * RTC
    * power meters

This change adds a node for the clock outputs which are used as inputs
as follows:
* RTC clock for AP
* GNSS receiver, WLAN, Bluetooth
* vibrator, modem

The names have been chosen to match the schematic.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Note: This depends on the samsung,s2mpg10-clk binding which was
only recently merged into Linus' tree via the clock tree.
---
 arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index 84ff3e047d3b31b5f96d4d6c78ec933bb05f3e6b..93892adaa679439bd87b0630cf9416b05c9d4536 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -109,6 +109,13 @@ pmic {
 		system-power-controller;
 		wakeup-source;
 
+		clocks {
+			compatible = "samsung,s2mpg10-clk";
+			#clock-cells = <1>;
+			clock-output-names = "rtc32k_ap", "peri32k1",
+					     "peri32k2";
+		};
+
 		regulators {
 		};
 	};

---
base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
change-id: 20251010-s2mpg10-clk-cbb8cb060c16

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


