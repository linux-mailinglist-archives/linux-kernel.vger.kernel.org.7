Return-Path: <linux-kernel+bounces-781810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7856B3170B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A79E7BE305
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4ED302CD5;
	Fri, 22 Aug 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWd/+e9l"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451C3009D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864290; cv=none; b=JzgXDXIEw4ze7Ns/eiV1gY0sw1pQEomy+co10xRFNF4p3RZmsQfPODfLztyZWaazmVVIcfibvcD6/46zwWk/Tg+oVoFz7tP6bFNYF8rAFuH6Onx6j50gEkOdVS/T0fYJHms3HgaPtrcwoT87tO8fjXvSd46M939ksSJNPJeZ1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864290; c=relaxed/simple;
	bh=sf0Een9IScr9c0j6MFmqmJyBrBaYB5bJVup8dzyPFhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTmaO5K9SqpfszS9og4+sV3TUKdMcwgk4odSYalQiqWp8nrMiUIXuLZchV7CZ8ALWRs1hcoDMYuShx1eOKcWZazGQpQy2415qQDKHBSLTQUeRSFFGizbQdASlKfRLZlbeTCXg/wf51Fv6qGtQToeOmN8gO3W0FNcm+7PGHRmlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LWd/+e9l; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c297e8306so21941a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864286; x=1756469086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvNy/mJryJIlPjRSQxP90NLnPA7/xQU0Cvx8YGHA4zU=;
        b=LWd/+e9lWHANMffyl4wsZBPyvOTf4pWj9s+kr397ErolGmlUDftYxsIVxBnQCCo8LK
         y8LdGV1Osm02qIrHnVs8QWZV3lVoiuZyMdmmP7oPdnN4OV3+vj4MqalsXsTHTiYa7f9E
         haG9jMJ+FO2lgqZqEiWOdSZSoFHPJCXe+k/SKFp68rDbFalAc7p5FPlWF6EKOBjYoG/B
         O6hgcf66xTYL5nXLA4ZHL1QIjypjGZc9+3gvyCnYwA6rWWWUzaxd5JsX+ttz4a+EO82w
         rKr3hm220PGX6kJ4Elf3znGe+BiccxN+0R2AlkL/PUj300c9zdr/znf4AgX7njmVTyIu
         DV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864286; x=1756469086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvNy/mJryJIlPjRSQxP90NLnPA7/xQU0Cvx8YGHA4zU=;
        b=gA1YR07+Tf6w6Lk9w+Sh2nO4/7ghMqvCh99d4Fydx8oTu9fKB3/7QgVO5rMYOeJYIn
         5ijuJwNJacm4sD1rJezLgzbaf/ihHrpw40pGZORzy7XKh4y2bNjoaYljCRUH/15sJy9w
         bnKwTtiiYviACbCP5uP9cT2WsJzPxLypgugkkvHdI90bgItz2J3Iym4iAys9UO9Eg1bq
         Qv7kxrrpoGgDoaZPVxPTx/c2zTBHUNPet8WV5EWNOTEoCgEXZzdUIMVJL1vGxsJ3/FgA
         PvFjherlqKgfM2VPGXtuIj29/BKcq/5+qSm8Q+/+/fufzQ9u/DmpwBwFpEEFHqDQUICz
         SOyA==
X-Forwarded-Encrypted: i=1; AJvYcCWT9adwIupaB4ZOT/o/5+1rv6psl+mmvWkfx0eBAn00HOTW9MI7lrE941LdEKWTD6WQ+EKLcxxzEnXyR4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YySk2kgsoB5GuZjfTLBpOkxQITt+LflDtWRL2VCQheCqgkupfWY
	PtpEshscKd5HQHZhaZuN9zmY2FTx7PNVgvwhnc4TjphgcWiaJdbMHntxMXwawl+Gyz0=
X-Gm-Gg: ASbGnctL9g9DHZ65EwRl7LtO5bryriCSDgK3jKg6e7pOD/aTe68ynZL5igRUub4AlcZ
	BziSKFzAQWqez/nMD7uVAXHsdyQ470ijAWZh/hKEXyrSbXfpaoowRnlSNT1UQTdkvGnPwCzUoYp
	2JUkCFnqQoeyHXgqFtCMui0ZGJWNWFm4Yji9KHMfFHK+kycN4reuCOgPdf+1ZIklXRCgHMYdlEY
	CkjJGjK2b1QTf/0fpAMh22xZQmrDPpcGWrImJHAa684DWzYRHxpScgS4WpvFJt0hURT5Ajl3qpe
	85DN4BNOgrAgH8qZZ0MADm67FW8rQ164szzRD3nw6xnEPXbvEwKxSWvqp1ZjYOnKFLzfUYRAVbC
	+yfDU7TrgCLdL4KRszTx3VC8WVi0fXnW9vofrphc=
X-Google-Smtp-Source: AGHT+IFF86HwdLSKUEV9TX+7km7GrmwlLKALDJ8tID0cqOz1ePpFerMxa+ut7Yc5lbHRVZxiuVBfIg==
X-Received: by 2002:a05:6402:354f:b0:607:eea1:1038 with SMTP id 4fb4d7f45d1cf-61c1b715cc3mr1072611a12.6.1755864286458;
        Fri, 22 Aug 2025 05:04:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:15 +0200
Subject: [PATCH 15/15] ARM: dts: qcom: Use GIC_SPI for interrupt-map for
 readability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-15-d54d44b74460@linaro.org>
References: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
In-Reply-To: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6292;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=sf0Een9IScr9c0j6MFmqmJyBrBaYB5bJVup8dzyPFhE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFzHReLFhcdshtdcfJ07bK9Ry29zetbAQf5TI
 VgG3mDRrnaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcxwAKCRDBN2bmhouD
 17IjD/4hm0evmDSi300QZDL18busBZPAAM1KRe7pXveom6+AbDprAK/XJLwF04TQiZJZcnZVt0z
 Utbxk2KN3N5oD5lQTlwUOiLx/An0ugg1RaDfSyLybTaKViZSNECrzUDv/ZOrbgDd1ygzdW/WUcX
 AtpF4WYH4LGNJJrxizdguuGFdqxkitiYsi9M8BzxGPuunfr/gAQn473VGIBnCsBDIEcj792LAFx
 A0pmgWfFj2cSpWdKfx6Msxj4Y+l567aZ/H6rpDt+PallwqEmZYftV0avQ7qQtysyWMvrW5Dse1q
 adwJO7RgO1cqOd5nSX1EuhJP2CHiDF2i9mk9q7SrOeFl/s4PFd0z5QKieJede5cSGnLXAmgAvB7
 b4NIKs1mB00O7CtfBj8/Ml/rsiKJw/40CkP9BemYQa9yYTAPKp+CZR15SNuhBwwgvufbU8Lb+9r
 GjUXEunJXCvjYW+DrryHibw/sWhqM4XgOpKsNZGxCZsqVM72k3bfU3z07lJxNF2tsYo19qSUJjy
 qLHl357IAClD6n9Um40+nCgrU7Y3PaxvtA0oLzrE00IFBMhAIKHTTjBKt4A43dOrGdnl3Re8iPg
 TS80TfBxenkR4Zi2/2+n1WaA3rAr84IWl6ESspSETFLE9/vzEDqB+r1N6tTYCx0QQhkSomeqioo
 iYC/b6LpFtctXTQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Decoding interrupt-map is tricky, because it consists of five
components.  Use known GIC_SPI define in final interrupt specifier
component makes easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi |  8 ++++----
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi |  8 ++++----
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 24 ++++++++++++------------
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi   |  8 ++++----
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 4c9743423ea880515a05148091ed97411f08e8a3..09062b2ad8ba550c3c2ee5849c96fb68fa2dff4b 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -1351,10 +1351,10 @@ pcie: pcie@1b500000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 			clocks = <&gcc PCIE_A_CLK>,
 				 <&gcc PCIE_H_CLK>,
 				 <&gcc PCIE_PHY_REF_CLK>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 5bf5027e1ad98fef92a012fefe0450c5a3df7e0f..8eeaab1c0be11175162b0ac17751ad48bcf293aa 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -429,10 +429,10 @@ pcie0: pcie@40000000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 			clocks = <&gcc GCC_PCIE_AHB_CLK>,
 				 <&gcc GCC_PCIE_AXI_M_CLK>,
 				 <&gcc GCC_PCIE_AXI_S_CLK>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 03299078fc5a2cdf9037770e9de2951efce9b487..adedcc6da1da5eafca3d403dc7a6547e2729ed98 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -1077,10 +1077,10 @@ pcie0: pcie@1b500000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc PCIE_A_CLK>,
 				 <&gcc PCIE_H_CLK>,
@@ -1138,10 +1138,10 @@ pcie1: pcie@1b700000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 58 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 59 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 60 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 61 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc PCIE_1_A_CLK>,
 				 <&gcc PCIE_1_H_CLK>,
@@ -1199,10 +1199,10 @@ pcie2: pcie@1b900000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 72 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 73 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 74 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc PCIE_2_A_CLK>,
 				 <&gcc PCIE_2_H_CLK>,
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 8d0aabfa1ee06f5bcebdbfd8ff620f500de7fb78..05b79281df571d1ac3b396588a43fa5558494426 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -340,10 +340,10 @@ pcie_rc: pcie@1c00000 {
 					  "msi8";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_PCIE_PIPE_CLK>,
 				 <&gcc GCC_PCIE_AUX_CLK>,

-- 
2.48.1


