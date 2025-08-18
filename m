Return-Path: <linux-kernel+bounces-773868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E0B2AB90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5B75853C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25623816A;
	Mon, 18 Aug 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyCO9Fpy"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF0233707
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527857; cv=none; b=quB0ynDImJpiIuseVe3g5MBDgJNHtAG1BuR9QVplwDzVfRLaC5nH0ZGMcPRWGU7JMpwEMUzjTF6cBp+it1kA2xLWvxxFyckEOXCJejC8SRKS92t5NBvuJ4x4aEb/AtLSjKxdBxaSnQshGIysPyta3TyBTQ7bmn4DrGFIZlw0Qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527857; c=relaxed/simple;
	bh=yyS1Kqa6YjNQyzYaGdt68e52WccpJuLwtYCRzw/J6gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYUeiJ/nP20xKBei4cePLIKM7usRP3QazGVWc/jx56NiBv6+BUeY9/buixQuAn4w9FETc3xYIhRBBvOD6jMfKvDPzQeJ7M6fU652kaiqEBCcGj8uGNX3QSldbwrIOTNyoPckWKp7zF/IB90NNPBcP6AFC9G9qnQDNI3BRnAXGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyCO9Fpy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78fd0c2so56783966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755527854; x=1756132654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMsmT8h0+DT9fjYWadJv14KoJwGukly6TmVYhBOPfZo=;
        b=xyCO9FpyVdR7aCSQQsC7/SCb7bdItBH5KNo0INYxGIyfeMlEbg/K1giIURJb6a5BfP
         ySZuwfMUbjVFquvkoB/FhJQOkJOx6tyuNxJo6THPN5lF5JBliORQDEhIwM6WsbXl9DC5
         46+R2XpFf9fqG33k7zUpfjovDVq+itGPf/aRdTYxw7efhv7zQrxUl/CmXwQqAqP1bmxW
         kKFLD8unkQHKLDGOA8PCaXBxVTFmCxt2NULmUuf6r/cn9IOdw9KvjUerD2rYkEwjGdiN
         ZHIxQ2C9nXmi+iq2uI00ujzBJVlFobyphLijog8DX2EOz54mbN2hXYi0aUHlvCzOVf2R
         657A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527854; x=1756132654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMsmT8h0+DT9fjYWadJv14KoJwGukly6TmVYhBOPfZo=;
        b=f2X/Mr0TexGBrk5w3Vc+e+28oERQU7vtBNtIxKif/sUdpxPDnfy3ByPBjJSKthmR38
         1cQCjq2zsa1ub5Z/X0Coi2MdLoKXNxOJV5KMEU30BhuBleuGcK6JMzu4HdYJ+17yOCTt
         bwnet/VYvyzYLoCxhf4pvL+MlR/D9f+EyPg1Rh0dwnKbBR1nSoW6t2hEMxLH+MWGNeMR
         +EDj3kArOM2UpWJn3FQpQdTtpdG/goAd0xc7FA5QNkWrMUJkpfxMlkOZs1bzawk3AeSD
         LrlhkeW/kh2mu0B05S/brPspiTM9WXuB040UCrGvPvzox0xe8L8c5YgFLP35SBd2i04v
         kPXw==
X-Forwarded-Encrypted: i=1; AJvYcCWgsyn+UbvFk+M7e4MmU0dZgdsgAtcCgRUkNB0GqujUfp6TLWPZIuEwTLwC3hl78XjyuH8lNLSFim39Qfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+68lD4gaSrveZ9LQQckppZt9E7eTdXKRVr6InyLIJKVlkMZW
	3tuxy/VgjiDae2/PSPHy1TONniaKFpubgg0i+U7AXe4T2Qmj/tEOdN7VicXQCsYt/XM=
X-Gm-Gg: ASbGnctHSw54QidWqtvLkKx5kwz/Ql9yBZjFsvw2ASeTIGpLc/tDHlMT6aWzk7ThN5Q
	B+miaxpPb3Ro/GsODAHjiOwuCSNQG7emIzTgwdTkFfmhc2tUxD/OmC0cCC9N/6DjRl7TCoJ0e+w
	wfBxKhbI0qXiSioRuCFli4FlMeIFTNL+lnOt4lXFjvi3LBH7Ftm9xZUXwKzT+5/CsxrOAyMXnhL
	qkVvgH3SOIIdFr2sYHLSTasTSjjxvwApfY/4sgnpNpYI96HZigV/aQYZW0jE8b9NoGPtoaW6B16
	39927dO5F8AVxUUc8xmmo9keQyg/X1H2t7U6JYksIKnmP/+znaWPAV/xHRjMclislle1ygWBU9x
	vE3Q7Tld2GZrMrMDYdsCvQATrUOnoIoTixw==
X-Google-Smtp-Source: AGHT+IGEt3nsu4aHRovyycnvzxGKQTMOhKdYlCUCXv7/JvtZLGn3dwu1jc2cK5FnprCTehHbYLnZyQ==
X-Received: by 2002:a17:906:40cc:b0:afc:ebfd:c285 with SMTP id a640c23a62f3a-afcebfdc45cmr327163366b.1.1755527853856;
        Mon, 18 Aug 2025 07:37:33 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f37sm816752166b.21.2025.08.18.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:37:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Marek Vasut <marex@denx.de>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@dh-electronics.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm: dts: stm32: Drop redundant status=okay
Date: Mon, 18 Aug 2025 16:37:31 +0200
Message-ID: <20250818143730.244379-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3879; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=yyS1Kqa6YjNQyzYaGdt68e52WccpJuLwtYCRzw/J6gI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoozqqlSZHPCX1JVOLnWGeDyGAz2oBjWeBgmsSm
 mPxRUw6D7+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKM6qgAKCRDBN2bmhouD
 15tTD/4mYTyNavHV0cMsp4HUZQUgzwJDBkUxjibEQCPqdYAlZ3NfPN78IOtHpB+1ICSA7AiHwEH
 XvD146rmBVwaVVI5I6RXrgFaAkImu6dSgjJJWxV/BZThEmkTRymxGhKHyIV2HFnfIV41pFnoh+s
 PA8Upx+IRiWcVcu+qS+sM8S7wrIUCsqNUCvPkkeDottSR2MHnF+ZbvjVFJ3H2NJ0MbDPrHtyZph
 Xc3+G3uZ/SZy5jAcHnsv4K7yenlUZdmNZbgFoyMcMttEnl9X743L7lgSNRe0x2Pj1KhzAaL/0vG
 iLLK2TjN7HUP6sw5ZmGkaM+05WXJuIGilYbNgt893aVnr1/4He9FZbch1b4IRFdeUI9ypSKMl+V
 zfDNDUXI+0OQ5CPRVxTP0g8Ny7YGIWPd3nNN9Ocu8Gr/dprYPv8xUj4kDTb4JZcttvFq/O41ZB7
 ffc/qQ33grySJOHKqJ+nez6upL5iPbi6VnELUc3Std1p/a2IkiEyDQpd4MQ+VNnY9Hz4kHyTz8V
 obVltkt0ZtSDFhwfL+/DIIcF5fJVptbNeOrNqFneWzSXSAlHw00SHLa8mKwXTcvNzHU7Ml18qEb
 +/U7ijgJ90xxbKJD+UJnnXqqr284UWIaqf5j3gBpqLXLyqcEUqrMkh1D7E0nAaoIrFxZ9VSKCPv zKQDgBrudjsJvCw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Device nodes are enabled by default, so remove confusing or duplicated
enabling of few nodes.  No practical impact, verified with dtx_diff.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts          | 2 --
 arch/arm/boot/dts/st/stm32mp157f-dk2.dts          | 2 --
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi | 1 -
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi  | 3 ---
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi   | 2 --
 5 files changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
index 1b34fbe10b4f..78165c7865e1 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
@@ -45,7 +45,6 @@ panel@0 {
 		reg = <0>;
 		reset-gpios = <&gpioe 4 GPIO_ACTIVE_LOW>;
 		power-supply = <&v3v3>;
-		status = "okay";
 
 		port {
 			panel_in: endpoint {
@@ -71,7 +70,6 @@ touchscreen@38 {
 		interrupt-parent = <&gpiof>;
 		touchscreen-size-x = <480>;
 		touchscreen-size-y = <800>;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/boot/dts/st/stm32mp157f-dk2.dts b/arch/arm/boot/dts/st/stm32mp157f-dk2.dts
index 43375c4d62a3..8fa61e54d026 100644
--- a/arch/arm/boot/dts/st/stm32mp157f-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157f-dk2.dts
@@ -51,7 +51,6 @@ panel@0 {
 		reg = <0>;
 		reset-gpios = <&gpioe 4 GPIO_ACTIVE_LOW>;
 		power-supply = <&scmi_v3v3>;
-		status = "okay";
 
 		port {
 			panel_in: endpoint {
@@ -77,7 +76,6 @@ touchscreen@38 {
 		interrupt-parent = <&gpiof>;
 		touchscreen-size-x = <480>;
 		touchscreen-size-y = <800>;
-		status = "okay";
 	};
 };
 
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
index abe2dfe70636..52c4e69597a4 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi
@@ -62,7 +62,6 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins_a>;
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
-	status = "okay";
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
index 0fb4e55843b9..5c77202ee196 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi
@@ -20,7 +20,6 @@ display_bl: display-bl {
 		default-brightness-level = <8>;
 		enable-gpios = <&gpioi 0 GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_panel_bl>;
-		status = "okay";
 	};
 
 	gpio-keys-polled {
@@ -135,7 +134,6 @@ sound {
 			  "MIC_IN", "Microphone Jack",
 			  "Microphone Jack", "Mic Bias";
 		dais = <&sai2a_port &sai2b_port>;
-		status = "okay";
 	};
 };
 
@@ -150,7 +148,6 @@ &i2c2 {	/* Header X22 */
 	pinctrl-0 = <&i2c2_pins_a>;
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
-	status = "okay";
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
index 142d4a8731f8..4cc633683c6b 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
@@ -269,7 +269,6 @@ pmic: stpmic@33 {
 		interrupts-extended = <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		status = "okay";
 
 		regulators {
 			compatible = "st,stpmic1-regulators";
@@ -388,7 +387,6 @@ onkey {
 			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 0>;
 			interrupt-names = "onkey-falling", "onkey-rising";
 			power-off-time-sec = <10>;
-			status = "okay";
 		};
 
 		watchdog {
-- 
2.48.1


