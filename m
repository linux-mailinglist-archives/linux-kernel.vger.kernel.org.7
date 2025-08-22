Return-Path: <linux-kernel+bounces-781998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79AB319AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8E9BA21FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA13090D0;
	Fri, 22 Aug 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgD0vncG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30668307AEF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869501; cv=none; b=R1FMCfIWgEnLGGH5/iRS2YCar4HJ6CSgmDdgxXdsJlKMaj/Bu85pb96n96SuW95kDlecn2E4CAYo18RuiDdSvlibjPd78Un/4H+Bzf8cnwUQSIvDA8nesz1DGtzZuYG57f/4ogoqDPNNJDvC29s7S6AP62Mhf7hz30TT9nZ2uPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869501; c=relaxed/simple;
	bh=ZgO6eUDKdzkFk380nvHSCOPF+LK4HXHq8MSxWowHtBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNwt+vd55oTTQUCduA5b8xgoz4L/vYxTEbXjytkL/SA/bq6v6vCAB4uXzqAAcZpEdiE0zk7MsvoLGAIYyHlrRbfWUnp2DTeSYVeWSgoHma1gC81gxcZQjazXItemxi3lvBf+HHbWMMSCSX6NVSl1ppxTetuVN4wIeP1C99fRSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SgD0vncG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b5e3de6so311640a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869497; x=1756474297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/I/B1Xgl4R7nkzvCP7ov1Z9+wk36ipL18Hy/fu/bOM=;
        b=SgD0vncGxYK5RdYkuBcSHy5f8UNo2Tj6wBbUgIoOJpmLto2h7mv8gce4Z37RRbjr9g
         IMTFQEg9P5ngaOlCTs1q4XmEBKpMespxZqMzWMLMUBYSc3HjzDkilniElZcvimLTCKwo
         MEYXaS0hNG9v5dv/5rclWTJCXCuc6zhcl/nhUdFilQP8oLn4h/0FFWb9M1rGJXPH8S+S
         d5nA/UaVl1qbt/lbBsirL/DQrgOQEoGBGSXFJVXsteyImLhzrWq9HB/SsIyssGkiEmfP
         FARJI6UA3CdwcgTceXQD7uAw4/zuAJw5ZVyCrSfZ3onrxm5w8B60aEFhwr/lZU4I429G
         2x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869497; x=1756474297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/I/B1Xgl4R7nkzvCP7ov1Z9+wk36ipL18Hy/fu/bOM=;
        b=DR/azlATzSgxeCmR6IE5yeElpHs/4g4ExDHou6sp3peIdz6WL5+3/s9wxEgksi2Nmg
         BJmF4z6lShRLhUM/0PxMUnVcLK5MAZISljYYujkF0r+yfaSB2J/O4xo37bjfng9UTzFB
         Jvyb/iWq7ZElKGFdzpG2ZmO4J+uN7SEKhj5HCCshYBPvufAmIsKjFZ+Kf9l2nR4BVg+R
         9P+4mh8rPj58r30kwuI1I90FuuffcyJuRC9QTmd4/zcQELpxUQOSiWdFA3ijSv6eA9cD
         xw1YQSOSG2LzDThBNS0mnTcWUDovB/VInfCuE3+fGrWf1f39OOZuvNQwtnqbtbPuP19B
         tkwA==
X-Forwarded-Encrypted: i=1; AJvYcCUnEZSix6IHT4+bptOZ+VbIcDv8ar8x08aVYKmZuF47TBdkw5Y+q6HDTggasoA+sJ+f+LhJXpDdY414EJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuvVf9aT3lpIJJmBLWZz/a836HHquP31XhFBSaEf8dYjjWIwrR
	Nevp2pP8gO5Ss46nE5WyLAauipGZkwWZdQWlW3/i+x1FyIKK08B5ZZPGfd3+JJPr+ug=
X-Gm-Gg: ASbGncvuCNfcmBhi1aFqYApk65txeVytmRREMS3Er1raNmYlOzlnl0Jh+4FZKIx3W8I
	jEozvFMl8Tw40DvtzKh74xHoHAyMx7S44zbKWGed65qKkYFTa14S5+ka64A/tVvEqoiKEgd9yff
	QR8Fr//9Qr8bmnn9HQP7YMPQd8OFpV8HZPnsdRFQGkdeJrlBT2CbrhUV9a7c7b7FH/ba9q0DCuM
	rEA08wLpDto3p1U2mIM+FK2pYUXeHyUAgCBj20CSM5rPOV7mOufN6R93W1ohHyozb1rTI8tr2Zv
	r4xsOibafuN/+9STDQQcMg9HZXekxSyZ6zizvzOJCeHfFtsS9pEOcUoCMwK89KJFdIY83YU8Znt
	91/Xh6hAtC94Z1dn25LEvB/evWsgQ0ofu3PG0DSc=
X-Google-Smtp-Source: AGHT+IEyDwCsxl5L5Q6zhJRuvce0siTKlXqOHugCi96LaphpN2o879tF+yGlsn9uhsI+1vutjC60fg==
X-Received: by 2002:a17:906:c10e:b0:af9:5903:3696 with SMTP id a640c23a62f3a-afe28ec8575mr159462866b.2.1755869497446;
        Fri, 22 Aug 2025 06:31:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf24bc40dsm554863066b.109.2025.08.22.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 15:31:19 +0200
Subject: [PATCH 10/10] arm64: dts: imx8: Use GIC_SPI for interrupt-map for
 readability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-b4-dts-interrupt-address-cells-imx-v1-10-f1b479da9340@linaro.org>
References: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
In-Reply-To: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3812;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZgO6eUDKdzkFk380nvHSCOPF+LK4HXHq8MSxWowHtBQ=;
 b=owEBbAKT/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHEo8ebRuqypCpa68Mh2v7d5MUvPuEcsRySCX
 9cVV2D5SWeJAjIEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxKAAKCRDBN2bmhouD
 12G3D/j2os04TAukiAzO4cVt0bZ4ODbfZ8ElQZZugArIYddeU7K0aLR9h7anhmfB246YsCfa3/C
 5/XJ+YY/5EqzjywJxDY+IH1cSgK4UBy86W/JdbBkCLBkBxlu9qJp/LT8itKBaX6u1BwubCI0No1
 tJXCN/v+RPVZCs00QXh9ej1sXS/U9bbR70h8TETqgmc1mZXdVGxXBRml0MJ5BfUnreCl+i1+uK6
 Cp3MtFnsapo66aWskhohC+jcv//WLG/6LHJ2PKUzzrRI9YYG+09NPABlEwXy4PnoHMUjxXNm1Yx
 F8vCgZOmZ0dPAbxz2vZa7ibb9vV4JZz6RYC8OvZU5p9ZUTC07odvybnVT15f7m3kOMUIX6lE64b
 P5XCDPwwi40TIlKH/OKgAJmY/1gk9BU9BwD/8W2oSbaQseb/yPhhaRrJyKVoS5OeNduIsUjRkX/
 oBaY0EREk9kNocGp7kQ0V62RzkaD3dmSUFZFjxpWh//WAdH4XCOvjNxOF6BdwKfW79i6nKULuXs
 2plT0/ALA4dCbqEpE+9KQYQXPFRBAfp62NOFq2+vdDr/8qKyowWrbc/INq82kPAt4SCsNVVKPb0
 E+36ERJGOKX3vyRKxiLDo2EIh4EypzaCmh6079MF0qHBrG0+5gfPi2B3fxPoKL30U8I/MB0IlMH
 1XEuQclU7/FOi
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Decoding interrupt-map is tricky, because it consists of five
components.  Use known GIC_SPI define in final interrupt specifier
component makes easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi    |  8 ++++----
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi |  8 ++++----
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi  | 16 ++++++++--------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 9b8b1380c4c2bb25f691d72a0217915cf3824889..469de8b536b5866ea83cc0542941039996ae5f23 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -68,10 +68,10 @@ pcieb: pcie@5f010000 {
 		clock-names = "dbi", "mstr", "slv";
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
-		interrupt-map = <0 0 0 1 &gic 0 105 4>,
-				<0 0 0 2 &gic 0 106 4>,
-				<0 0 0 3 &gic 0 107 4>,
-				<0 0 0 4 &gic 0 108 4>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		num-lanes = <1>;
 		num-viewport = <4>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
index bbc6abb0fdf25b650dacb8dfcbbbe5dac9ed5cce..ec466e4d7df5467803243404795a9a6a1da890b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
@@ -42,10 +42,10 @@ pcie0: pcie@5f010000 {
 		#interrupt-cells = <1>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
-		interrupt-map = <0 0 0 1 &gic 0 47 4>,
-				<0 0 0 2 &gic 0 48 4>,
-				<0 0 0 3 &gic 0 49 4>,
-				<0 0 0 4 &gic 0 50 4>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-map-mask = <0 0 0 0x7>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index 50c0f6b0f0bdc2bd6fd3a19e08d1b7a723353783..bd6e0aa27efe90d3489c16c705d508028b268ee7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -30,10 +30,10 @@ pcie0: pciea: pcie@5f000000 {
 		clock-names = "dbi", "mstr", "slv";
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
-		interrupt-map = <0 0 0 1 &gic 0 73 4>,
-				<0 0 0 2 &gic 0 74 4>,
-				<0 0 0 3 &gic 0 75 4>,
-				<0 0 0 4 &gic 0 76 4>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		num-lanes = <1>;
 		num-viewport = <4>;
@@ -80,10 +80,10 @@ pcie1: pcieb: pcie@5f010000 {
 		clock-names = "dbi", "mstr", "slv";
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
-		interrupt-map = <0 0 0 1 &gic 0 105 4>,
-				<0 0 0 2 &gic 0 106 4>,
-				<0 0 0 3 &gic 0 107 4>,
-				<0 0 0 4 &gic 0 108 4>;
+		interrupt-map = <0 0 0 1 &gic GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		num-lanes = <1>;
 		num-viewport = <4>;

-- 
2.48.1


