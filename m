Return-Path: <linux-kernel+bounces-775822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A1B2C573
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E9D1C21490
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710B35083F;
	Tue, 19 Aug 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6F1z96N"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCED342C90
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609463; cv=none; b=Bwo0hYTFKayODih8AGipX3oDEgIb59hp71AWP2danxLnhCkDoZJW9tJiqF0Qxx0FibpCjioqKie+sPNACMiLvhIYoGEBuLRbmDW9C+mqi4DbmcUMJjbQs60mRbQOM7FAxsgbV4s3BnqN7JUcClGwNre/ftxY6EVOuTYU60C/IH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609463; c=relaxed/simple;
	bh=OI8xI4rriuzUcSjkeIqrlqCQ7LKECrbj3Rl5VDM/qiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E38FnKVnOocIv0gDh+HGCla/vSlk6Vo0uf26hKJBWNvIM6r94YWzFusH9Tgjaj6q5URoQJ3zcOyxarF9j9+5iCdsRN5ziNySZt2iRy0vG7G+kLAT90Idk3lT0jyr+Q2kgoNxEea9zzWPmr7gqO3xQun/ZgNxZsxFaRf59nTy/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6F1z96N; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61a20bd7a72so214835a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609460; x=1756214260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85wyCG8coVc4P+dYQ1rAaYOx8gFIkg9y2ilOKc3W8A8=;
        b=P6F1z96NFgw+RA809HVpn62EKK7ubBRamBCZQHY5VOpFgH72FLiXAnOqsFItpfeUtP
         HgzecxIOf1I9fX1f4vZGIKPKv14OFSPEI3zuJ0/QLVCTeWvTd67FZcfUVq1d5QJPnkOn
         K8nVPAzp+pO523zvBH0r3RNp1gSrsfCtj3T6wmgPA+MlxWvLZs7ejXdk7Gj8snMX+po6
         UWCT7ncyCLsg6a71BHacnxK3tcLC/37Yyo4ey1CI9fkqxJUWAR0Gam7VN4YepSd/k19S
         h0+2WEn7mKUj2G1jQBt/sT2kZDu8ujhv4nKY7OAwaW0lYRB8WEvPVSPmE85gPAszHwt3
         Yg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609460; x=1756214260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85wyCG8coVc4P+dYQ1rAaYOx8gFIkg9y2ilOKc3W8A8=;
        b=YlqJASFhQ/8XA6rd5kfNtjRsHmGEEIOWgeZ8filQDlsR9E3JcwDnO6xXnw4Ivl4254
         m2XE1fXOyo26/jJGhxMy1UwGP4lCN/QoprCUANc+agyHbtLfedS9hXOvq1h2tS7vgN1Z
         AiHZ/u4nYx/7HR7pGS6SHUqtF3fPnsWjqJVv0HTbTMK2FGlhECyiKEDbCCpP9P9fZErT
         c1POKum0u1ghRsl77oMA4YlrwYNhvFXUNcSJVsU66X+vPCFCvXaVRvJpMFOuVOWYd09j
         5vqPVz0XP+Bt5E3LSNV9FKxe1/xtXFyInTgv8xi6SSyQp7mT18BSYQhaKIaVgtb8AgRn
         Vv6w==
X-Forwarded-Encrypted: i=1; AJvYcCUagmZQJaMdCU/WmAim4nDU496KRLpvxbdkNErcfQF3XceF+icHu09bgtYSlQC6iz4QzWpIllimcylUfCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBPXq5dhNeTMVyBzcTX5oCThopJi0Or9+tKFVsmzfViY4oAL9
	U5SYoXUFbdO+jabde5OMV0S5uA+nTt2aThVS4OeTTFRIq7JGPq8dmrvHqvcsRcSOjgI=
X-Gm-Gg: ASbGncvdoE1Vn0TTa1+95MuES+bcr7K1bNXAb7I60aaUPpOVvb4dNDzgblrpOCus+I7
	7boodWGEv4ju34snpfLo+7ly5NO+DjPd9fOTdEsQ/KUyMSbKVYvWO+iSh0EpeF0+RyaQlLSNNfG
	sigPXmjdYHxDnVYtkV3yR7Hl+83F+/dzRcryo8eEdqNP3iRt7F7nxDRtqbJPMo9SkIUubEUg7cG
	n935g0OCtrMk6+LihiwHOt4JRaCOXg0w0yM8p8eMR4zymZmV7xidASwozH6Y+n4kttCtCD4kvzU
	bGqQbXmq4dmM2zf5Z5g8fWgKQuOGhhiTPTRLJu1QD9hcfaqhyBQrqzNXTd/QR6c2Jc5UuJ/lVja
	izDAHUpXxA2GQJ8iCdRfbXe+2GLwowRBEoA==
X-Google-Smtp-Source: AGHT+IG53VEovhwtR28QN2UOeD1JHPLe8QPkUrXRxvuFI47Q5JNDQ/MUoUcbuJ2GXmpU0iCo5CP0Nw==
X-Received: by 2002:a05:6402:40c4:b0:618:1835:faa7 with SMTP id 4fb4d7f45d1cf-61a7e6b6437mr994682a12.2.1755609459620;
        Tue, 19 Aug 2025 06:17:39 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9cfasm1769363a12.9.2025.08.19.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: microchip: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:37 +0200
Message-ID: <20250819131736.86862-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=OI8xI4rriuzUcSjkeIqrlqCQ7LKECrbj3Rl5VDM/qiU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlw00SZ3DQZKclRCv15IUoY9iPx4Rzzc6aYV
 sFbvLNEWCiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5cAAKCRDBN2bmhouD
 12erD/4h2ip3iU4zgw2e1b01drQrNo98Z1jSHTsT4xA5nSpzNbl0LdXz7XgEmPc3bihs/MklTyF
 DqjFuHRoJrECQT9jHMH4QT/+Apv5mGkg6nHwxEL4ahq8qAPG2LHQBIdC6cSMedWpipUSqckcm+h
 tgcdEI9Rg6mjoyaqUGekrIaPRUX0wY8CcOMs5tE1TJeoqraLmMtYgtwkEyx/b7/FcpM4fjL5N54
 ln/Hwpkhl7ZsxxiOkNFAqFimp6hP2HjSF6B5wY5O+7yra9Vd54ceEWXC2VHXmEBB5dzW5Lqz9iB
 MW1+bVIl7Dq+BPF7oJRzULAPtQYuAMVakib8djwSsb3SsTPipSl41BHVPiZboLe1QCaxFdElvGd
 YvIE9M+KBVwuRCOC1UokvM490vmq0vlUfnHtJ+10Y2pRtaRfjRGThaHUEzZFnA/yWMcTdaWXQQq
 XMoD1DzPIHrNn/Mg4ylBQhNi1NUEvJOV4oDnTVZW1uf1DYUutZpUjPwOlRnUwy+bXu9BiV+UFHb
 4qzhIHZcQAKUDJxp9ZUnB2DXF/hm0uSqltMkjH0VuzO3/iWU2F7ntHBCqwgDWbdvabYKXndSdyW
 vJNqgHxgwmGWf8+Q2+Pwer9GYzXryChyWZEwJzZQeV4FykJK9K7bnoQ6KHz/B22Thkxg5E+Hpla +8MKT+dZumZ6/RA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '=' or '{'
characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts | 2 +-
 arch/arm/boot/dts/microchip/sama7d65.dtsi               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 7eaf6ca233ec..c14c52936ecc 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -346,7 +346,7 @@ pinctrl_gmac0_txck_default: gmac0-txck-default {
 		bias-pull-up;
 	};
 
-	pinctrl_i2c10_default: i2c10-default{
+	pinctrl_i2c10_default: i2c10-default {
 		pinmux = <PIN_PB19__FLEXCOM10_IO1>,
 			 <PIN_PB20__FLEXCOM10_IO0>;
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index c191acc2c89f..84bac1d29421 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -91,7 +91,7 @@ secumod: security-module@e0004000 {
 		};
 
 		sfrbu: sfr@e0008000 {
-			compatible ="microchip,sama7d65-sfrbu", "atmel,sama5d2-sfrbu", "syscon";
+			compatible = "microchip,sama7d65-sfrbu", "atmel,sama5d2-sfrbu", "syscon";
 			reg = <0xe0008000 0x20>;
 		};
 
-- 
2.48.1


