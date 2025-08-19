Return-Path: <linux-kernel+bounces-775809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE067B2C542
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6891219605CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E4342CAA;
	Tue, 19 Aug 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjSnhilO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0AF25E814
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609401; cv=none; b=tkxPK/5BglChFTY4ZYNVPuNm9KSUc1LvKelaYAzOb4oZ0oFq8Ywy/Aojn8NdHVowNT5ZXf+YQuzZU84rlPdz+yACr3HF11WuxH+kZpUtf96I6Rr3juDHheGHGRRSYunZ186tSPdfCVDJcjYlqJGOBuB6YLikmBvWpntrefVGtjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609401; c=relaxed/simple;
	bh=25w9nGp+VOPFwF4xTLHunMmNW2bcpRsbxGsrD/LXVBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ms9okC1IpQKSPW2SYpHrostaIeI5koBtw9QbTCT6SDELHyng77hyh53wddxDWM7xusniqpqDQ5dJCKdt+fmTvwsslRtPNUtjwh2FwvU56w5CK1RfvPmASWTtM/xncEDhm9SldPPJy6xWvdUcPen+BbCY60nwbaa/uO45cNUkohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjSnhilO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb736dc8cso69758466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609398; x=1756214198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFTccCtP1uRd9Wzn26xkl65ZZWOAVPiCAiod9SnwQ6w=;
        b=TjSnhilOQoSAohWBrFhcqun/R3tE6lI68y50mYYg1JgSsoGdZNwQWXKzzwGqUrHcqR
         rklHpTIDP+mbAW9VtjEUfWiyDC28JJDFhMedxqveXeOSW3ENcCqyFtBIeVC3Am+NXUKH
         OnSPBqiV3cDYHpcljo7jtk9XCoBX5CJMqD6PR1l6UgcR77Ki379qgDCeD7YLO/zYEMaO
         YWrIghhxl91mQKnHSyDPJxJ+bKiJm6+kzA+wM4zpkIDzsyD3TT9ytXqfqzk6r4in2cQh
         IQaeNEMsK7wZ6HU5EI1xlCummyIl5sYYsl1I4NDA1HXgtNobucYLkC4kWrVh9blQno2+
         09KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609398; x=1756214198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFTccCtP1uRd9Wzn26xkl65ZZWOAVPiCAiod9SnwQ6w=;
        b=do2cju1nJREu240wtB8MeEyEpQR2pvoGgKAfgdY9Gsj/gMNPEl034q2UwuKgBgpbBR
         Knz+7lk5cDOG7pQyLT4kj1hrudU8evEjIvDfnbKCyCMNjwgigI94PtU2+tBgGFVNY52z
         SRZRtaDy/nwuYVOFq4lkUyciohwPLYZShz0WDZqxTlcZp6Jpz28h7KBtDKtXeT4bvu43
         97xB7SR5kGGaI7gn8rhN5XepzNRrZXu3njdfqxyuApjPt5FNssAjJoo4kc0f7UhTQHEN
         isMijlggQrifMtwAK+KlPavMTzryM7/u6UThdTsBG4j4QBtG1rBPB3z00Yk3ofkKy+vY
         bUYw==
X-Forwarded-Encrypted: i=1; AJvYcCWT7yQZm2pEajLhH6N3URB85jgiRKBQPdEqe7T5ydnYQIsd34A/QXZb3jitsPrqaf9dZeZe2e1HE3Z7ke0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNwSvziH9krCp9s2DEKFtXpzDhcTIN+EeI6yyU0FcvpL2kSvh
	jWs7Qj/NZmVD81+LrdVNp2+WS+CnHg6b4hbDzqw01a+9SApf5arTxGejLUovs+kQ4zI=
X-Gm-Gg: ASbGncudiUMOdQl1Ll2orUQl9AytHSkV4Gkk4U7q4UEcpL/z21KrBuea2t7VoacbVE0
	dpq8I0PQEJi1HvzgyOXPZLBldtbFllA2mu62yz7PVnKETLMLa44neZsyKPYjOMcrXHDEvdZS2oF
	ET9Vbrv3TRkmcrGlUpICAbJgF6+t3sZK9RbD0fwi75w2LxMBYm4a+lo8I0mo0V5Gs7NDUNs+kZm
	tRPoOhB5vwbKM68u/EVA5deqHwBqnxjvfluZmVC0OU8+eH0hGpRf8Zjy5xxaYWIY95rwgrAA4Hm
	uItGjPHJipcdo3Yo4YXwRrmpoGZR4EVhpoJO++oHXgQBMR0AwdqpO69jdyr6AczqUU9pBaOC9kD
	tPABFwb2z1nEegfwtI1tRjq04ZA+7g2Gemw==
X-Google-Smtp-Source: AGHT+IFfradJwu63FUvwOcWbWyp08fd8Whf4HqNHMGG30wEYvsKB2XGXhYm0YYCzs8cM3Nd6qzySVw==
X-Received: by 2002:a17:907:d90:b0:aec:4f0a:f9ac with SMTP id a640c23a62f3a-afddd1e433dmr90382066b.6.1755609398378;
        Tue, 19 Aug 2025 06:16:38 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce73e22sm1014924066b.41.2025.08.19.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: marvell: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:34 +0200
Message-ID: <20250819131633.86478-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=25w9nGp+VOPFwF4xTLHunMmNW2bcpRsbxGsrD/LXVBg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHkxJCXGErwlGNb4uJVx8zh/NpiVZLUoMdgV6
 s1NAOw/hOKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5MQAKCRDBN2bmhouD
 11/vD/9KkTiJjpBqGx1OFTTWGwcAynI2RwbCno697sZX6nOadE1UXEXPVYt/raAiGjguhjov+zP
 4NewcszElKfspMkCFlX2RDpILBiNfGCdf+1Uazl3Zi+Ltmfo8YzB+RjrD2NIyzeK1IS8tvaq7OK
 rTcYVk17JbVGHeqh4L/ofJl1cpvm3rUq7F+RQiwEvCx6Ai9Kgb24R48y49+DR1XMOD30r7m+veJ
 a0qyaHz8opg1LJI1ktI9A2GeQUdAeelDe7PcgNNOHRkUc95qNvdZDdq/JX1gLFeo0WkZLw63wMd
 Zn/CsHu+Odo9L3p/YxLAyWN3p7byj7gKg1WSUSKTleIEca5/StBNqdTuuX+vdEn7OmevGhLj68D
 RFMFbsK2yBk7SWNQORW+nM2OUCywV/sBZnDd6Xcfach6gnAYWDJGGCdcDnga4VxTaEYNWkwNQoG
 WEgJd6OqacPsntBQG7cr8QrFBo9MLW1wvUSKquT90WkJQjuNk171q8RNmP566mrWiMlH6q6qF4T
 CKtx6yQOLseAJR/O+Jsl4nIWm/qaK5M31RoDcv7PWqy5TpSn3dybtAodNajbYmmkPhvKDfj2Bvo
 crn4Ax0STKTpxaYa+kIermy1ul++6DSrNCkLXPHIl6Gy7hvZ060ZE3zvaw4P27mnJ6+Nc7FigAR FaelHWw9cWGq7mw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi   | 2 +-
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 4 ++--
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
index 605f5be1538c..4878773883c9 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -322,7 +322,7 @@ spi1: spi@805a8000 {
 
 		nand: nand-controller@805b0000 {
 			compatible = "marvell,ac5-nand-controller";
-			reg =  <0x0 0x805b0000 0x0 0x00000054>;
+			reg = <0x0 0x805b0000 0x0 0x00000054>;
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 0f53745a6fa0..c872c8eca518 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -559,7 +559,7 @@ led@2 {
 };
 
 &cp2_ethernet {
-	status =  "okay";
+	status = "okay";
 };
 
 /* SRDS #2 - 5GE */
@@ -572,7 +572,7 @@ &cp2_eth0 {
 };
 
 &cp2_gpio1 {
-	pinctrl-names= "default";
+	pinctrl-names = "default";
 	pinctrl-0 = <&cp2_rsvd9_pins>;
 
 	/* J21 */
diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
index afc041c1c448..1c9996d8cb24 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
@@ -442,7 +442,7 @@ tpm@0 {
 		reg = <0>;
 		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 		spi-max-frequency = <10000000>;
-		pinctrl-names  = "default";
+		pinctrl-names = "default";
 		pinctrl-0 = <&cp1_tpm_irq_pins>;
 		interrupt-parent = <&cp1_gpio1>;
 		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-- 
2.48.1


