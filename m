Return-Path: <linux-kernel+bounces-775825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF306B2C569
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBE685960
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504983570DD;
	Tue, 19 Aug 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HacgI+OP"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3923570D2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609479; cv=none; b=TPAeK3rA1SGq3hRL+7WmN2bFTfNuAQ1hgs0cdxxeic1AHYFP4uY5wh6y8i2VEVK+/aVKHS6AYDHvGoR0nKEQON9F1IQUCazE26z5sxGHiOk9gdrE/wYmNrAjREg1AOMhdji6wN+xuZnK7IWZ636T+qgFxZclXe2J25XFXetToZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609479; c=relaxed/simple;
	bh=a/1Am43qkovn1U45ePWY9QossHBqqTSsbI0vixo31/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUBvhsEadW/g0rMFVtdQ/TZJlTkuYUDWu6bnlwI0nfFKrpOWn5TkJwZTmaa4+AMk77PhvbmR3nRK+0Pkdkl2hZwRqgBm0gVjgaF6FR5Gc+YwqoomBgTEz1xMzVDI0qZ+M30GROQCwlxag6sMlL3vqrN0P4Sd4Vik4ORvB/IfWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HacgI+OP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcc96bb64eso93338666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609476; x=1756214276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dwxhOWr2tfFUazQ0vTmv0AWEueIJvOP+MVDAxepHzKE=;
        b=HacgI+OPIYzxtThCf84BuQHLpKpAzanqcGFlGrZPcw6Yw5WvkSF2iVVSw+lmFxrjRp
         L855dZxSDsIyT3mATumZ7zz94Lpa3EF6/e13kN+FKqVXg51apbee5A7PGI5jP8ITDOdC
         /ZT2LQ4By+NMM+G3H/DOTNhWT4FHhoDY53gdUJOlf5MLCAIBMFMDyTAa/ckxlwYcVv/J
         QLkLHmues7PMqGsPDWnUlYFGv/JOGM24dwyRVmb53Igy3wxt17Hr4EEeTsh/wktuaFw5
         avMqcPJ3MY7Td00bQ/MeszhfOjbGuF+DtH5/bXUCh5KqkqstdPPh6WkmNdCddLR2yE8X
         mB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609476; x=1756214276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwxhOWr2tfFUazQ0vTmv0AWEueIJvOP+MVDAxepHzKE=;
        b=p0Y9RSINZW4aIl7Man3Ss1zk1DTCx6bWaP178WX0GI5Br58Y6/3irCOmHx67mukC1I
         uR8aI7POc41JLTOydYHrBJ+4xNaj9BnM9teUlP8ethOSX5twoEi6u31hN7PJk8HJMxva
         tab4TfpRs9DjFSEeP4cgZ+9NP1GTpwHauj6DnAZEX7XtALtqoyqUa4HgFuhLAHNjfoh/
         x2YKigON8LKCNCOvPJkL+L5JDuLtGPgYtj/lY/K+TFtjGxBf/a/qyyeEtvYNBZZ5yr8i
         D1vPSJL4ANuctphO8EbkMV0Ja1pWY8dwVV0AFshFiPCm3jHcD0S7m3A5CgRLI26u4Bsh
         ONkA==
X-Forwarded-Encrypted: i=1; AJvYcCVekjRph2DyFaRwApD+rf1oVzzopJk4uRDef5Dx2mRHCWYWR9F8bmiGiVbe+q/SVvlOLmDSdlxpEabTwQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2xzyRSMt2wLvpxs5Mp9UK8zK+0HcShs1eVqfQJbGG4lZXVOg
	gWOg9C2Yk2Qz8gqG9bihKPuY+r7gahLEz/rqbZYEv+AHfe5xpw3gO17id2uSZfni4PY=
X-Gm-Gg: ASbGnctLYV+hQdsFgLHajvrJAxsndAOn7cUDbxosIHHcc/Wwx4obZpHGi0q1NOUOYyU
	41ciVvcuVAH5rt73rgfeLh9kzvF5s791g6ZwHcbu8LGsa2Gll2uO9WVc0lgiXMir1i5ff5g++Dr
	AD8Aof187LzFi8qUXcDoe3eaHwu7VFHQDmFvwOlNbjxnUe4PRUhKY8iX60mKOx7QL4SHvPlncL6
	n0XyS9znP7fyHNX6HogcnZHNNzKiHA8tunTili9hgpQ3aUwJKyIx/ip5HNbRdztX4znFz4mDRQz
	5MDQ2YvN87JC2gQcuFPxWRaUNo7krLRpBUjdfyRLN1YR+HRn474QNxyNg8M2cuAXSOjgDevDBp4
	XP1hZw/gSua5PnquIz54+Hypq1aq3Vsu9ww==
X-Google-Smtp-Source: AGHT+IHADlenz3AdOd7FQc1EL+ISVUt3VbFHxgCFL2F4EgiCqro4WqqKqiPXtAlrEaDVo3hCIju+Ug==
X-Received: by 2002:a05:6402:40c4:b0:618:1835:faa7 with SMTP id 4fb4d7f45d1cf-61a7e6b6437mr995125a12.2.1755609476324;
        Tue, 19 Aug 2025 06:17:56 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9b37sm1734573a12.7.2025.08.19.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: allwinner: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:53 +0200
Message-ID: <20250819131752.86948-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=a/1Am43qkovn1U45ePWY9QossHBqqTSsbI0vixo31/s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHmBLoUxXgl+pLIifvNbA+bzGXESv/qvlnAnv
 KJqtnvJQFKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5gQAKCRDBN2bmhouD
 1408D/4+3v8iYk/kQH1Z+B8Kr9TVDiNW9AGM6dhlicodidDswX6yq4R7L3uHYrTgy6D9DYOMEdu
 fFOh3dMyd4r+ifvr0b7k6sCPRUD+Kcgx43HD0zpp0/SJCRxXx9qT5shxaF3D15gMO/NB2RreH8D
 MFPf2qMJRBhEiHqWjay7Q1UPC6iP3f2YhAA7i8TuunoQDknp1UrqhB1ZHjzVqo6qJQe9NEnTYjc
 E7PXWUP3ywhYvv1NqwdtWz8TS9YOHB+AhBXSv0+ss1C2rOH0dpUWJEamidIoHUrRJFxpIP1+S9e
 fLWuqLHf9njYf3FVpy6IdqLSwOq00wcEoupYtSO7FVPyX7+2CxJSh5GEIYd2DZitCEVV/PNGP+3
 VlkjHdcEl7cYowWa+kPhfuJfuZfFTK+pjtVKWsDyIrm4cAUNA+l9lMIeQ+CgMsNV2yoeinUgo/6
 v4Dgn6rCndS8yLKXhFrbSqYuFQrDI2RW/haQ21PbbCRLhWq4t22xuMMv4CfeQsBU3GzOBWMdfsI
 nVzMZXfXDWj3aI5cNj0YC6I0EqwsbDFPKC2mrgEII6wGpa5fUY1sC8PUx4FaMHf+aef60jx6tq2
 0KYUU11eJ+K4hwElrfDLLI9wWWeI9IEm/9lkARv/liujs+x6PMt/iI0P3mYXiBFPwAe+k332Rt7 Cjv/D/Z9mQ6ZYeg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '=' or '{'
characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts  | 2 +-
 arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi          | 2 +-
 arch/arm/boot/dts/allwinner/sun8i-r40.dtsi                | 2 +-
 arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
index 83d283cf6633..d425d9ee83db 100644
--- a/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
@@ -218,7 +218,7 @@ &usb_otg {
 &usbphy {
 	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
 	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH5 */
-	usb0_vbus-supply   = <&reg_usb0_vbus>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi b/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
index 272584881bb2..a0f787581dd9 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
@@ -82,7 +82,7 @@ &de {
 };
 
 &ehci0 {
-	status  = "okay";
+	status = "okay";
 };
 
 &mmc1 {
diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
index fa162f7fa9f0..f0ed802a9d08 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
@@ -705,7 +705,7 @@ uart2_pi_pins: uart2-pi-pins {
 			};
 
 			/omit-if-no-ref/
-			uart2_rts_cts_pi_pins: uart2-rts-cts-pi-pins{
+			uart2_rts_cts_pi_pins: uart2-rts-cts-pi-pins {
 				pins = "PI16", "PI17";
 				function = "uart2";
 			};
diff --git a/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts b/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts
index 5143cb4e7b78..cb6292319f39 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts
@@ -29,7 +29,7 @@ chosen {
 	clk_can0: clock-can0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency  = <40000000>;
+		clock-frequency = <40000000>;
 	};
 
 	gpio-keys {
-- 
2.48.1


