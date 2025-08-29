Return-Path: <linux-kernel+bounces-791399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9CB3B662
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D571628EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A432BE63A;
	Fri, 29 Aug 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8NBodn/"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC632D9784;
	Fri, 29 Aug 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457319; cv=none; b=gXrQdd71V5jup9NxEmrbmQV7S7tWZLbbNQT9OJ8rFh9bXq38bQ5+rZJ0gu+/vF8SL3nKXnV136+YzQHFNPBfNTG/lQdpba7NGgN9XltXwUR9MYu51qcPEt41ZmcVqQpEaJfnZYALmm82yiKdOSTS6R7cELX0haSOo0phRCYy+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457319; c=relaxed/simple;
	bh=IXmE83WrLHoojz0Htjo2nqONfoaTszNCQ2HISt7DOmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/cyFU0f83Tn7p1Obfe5U5ECmPsnYyDDswiFDNjcUUq8YKekSQu56g4jq8TXp9lKDeoBV7kbeSqaaPmo23HQeWE0HhhuFI2uzlQ8d4yCUXcZ5oNgankmIdI5XBqxBmTYWGYFFlo+gnTDLauxf5s+qfsKhWCK1mmJTg0Scw6S+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8NBodn/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1317687a12.0;
        Fri, 29 Aug 2025 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457317; x=1757062117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huo6UKRZvOysKzlKK029Ak+BDZSM4j9x9AL+B8QBDmg=;
        b=e8NBodn/t9cOlqa0hHxTaxdb7yUoBkHu2rZldhWHpzZtXPfvqkjGrg6uwmLusSaWpH
         DU0uIPfAqOjFvaY/V/Dx44JJyoLaAD1Q5NHdi7V8UWTDiatzH9NZRp6w+zD2U4N7mVb+
         qhqf71h8qmsig2RjttL+cHoFM3Gu8arSqpamdcjG8zuFbBg7IdoF32oSE9HC5St5MfM7
         QWiFCyXrwbpiu7yL8fPFT98p7EygIEJbYy9A/saBJSPmQ9EGib63INsyx2hxr6O1r7IM
         x4YWiuHwSMi31+hf2F1C0g6LBp4yNwNo2LOQMnhSBhfUA4Lf5wVnqCViGUP+K776wDCp
         c6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457317; x=1757062117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huo6UKRZvOysKzlKK029Ak+BDZSM4j9x9AL+B8QBDmg=;
        b=eycF19VINE5pOJSpLtI0nUz+Ai26BD9/wTz9iZQGQo4ak8iwufa6wofD/UkosY+o2o
         JoEYKx9YUsSIRDmg0WcC+QM1K76L60JTILhQmFiAoJxzGkwffJoNkDo3fFhFPENNvdrz
         UhQkG0Yoe1XD9ULTt69K23yjsfxYRGG75rzbWGSfmNwIHpkvGoXd9Y8hMwAM5BVQsXnK
         qqfaNt5rXIaAVJxQSOSzEIATt+fZmIVR/uqBBfjytf0PVVcHu2cexkf4m9LJYv5IzWDy
         wVuBbfOF9M8Y8w395MiwFRRq1RXPGK/jdMGxyZPuiE7yCiT0jxuxFzNPDYgfjfJQlqPF
         xDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7dK9LLFeruyQHaoPNOSJXRri2xoiDyv+TFQkbYXpPV/ck+cKjPZa609ZTjnDs8iks96qiBu0POkU@vger.kernel.org, AJvYcCXn4oaKuZZpctzY+jbptrO1wCNUctllACZDn3KVjeExTc+Wqa7yOVHE6qHP08riozUHZlLwu1MLYjbGut0b@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYZXNGXxUAzoXz0OofjNNZtPdhzW6xcmAEUagrsV/PSYXSIDK
	pp7xTWmdFSSwqFZjXz+ZRHh4h9Cw76pe5/ImBByB5f7oCzFXN49YI/gw
X-Gm-Gg: ASbGncuQwnp3uCHYdKYZEh2eNLYhVZLi5tXxVI/T+O5U2aAhVSyQtvWJVWPjCgZRUeT
	S9Z190Kcvp7dxtIlGyBxt2mrLo8Gj/zYvoAC771e3V9WepcpNXRxxeucW6lITxmkdz1Xkq+FOav
	ObS35JkSofU+orgn1qlfEmOjMWn9RQM1KshWtijFLzBfHKb6tOIniPeM9BsmdMb57ttUvhrFD/s
	y9MaLIrgmIjG3S0s6G7VMd1uJFRtpfisiqxquW0Sxj/Zha4CiyshT0bjEtl6hW74+BaljryEgSd
	S4QeFqxPEJO5QonP3mUbh2aCrEuCA6kXBeOshl97Y1hWgmZo0K2Iq4DodXxM/q2cGZ/z9dRxjqF
	TJUsnlnJ5umaK/KFLX96mjBJZI7fK4YmERtceFQ==
X-Google-Smtp-Source: AGHT+IHNprSHX/gtqW7mH6PGrQAeU90URpR1MuRLk66CvGwjz133vsdLxYv6Yhkc0Ldb3CFt1gYuaA==
X-Received: by 2002:a17:902:e891:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-2462edc4507mr413113905ad.1.1756457317009;
        Fri, 29 Aug 2025 01:48:37 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249066e042asm18162565ad.146.2025.08.29.01.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:48:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 29 Aug 2025 16:47:02 +0800
Subject: [PATCH v3 3/3] arm64: dts: apple: t8015: Add SPMI node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-t8015-spmi-v3-3-58b15ee2c825@gmail.com>
References: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
In-Reply-To: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=IXmE83WrLHoojz0Htjo2nqONfoaTszNCQ2HISt7DOmU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBosWlVRHFdQdeFy3aisUkxWV9ZA27SfibYMoV0R
 fxOZJPauX6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaLFpVQAKCRABygi3psUI
 JDzFEACGVhhRSiF4ZqOskPQJhky+N+NRBdF+sbQNrZ+xlazYZfV2JNJ2y0VtjSDu5Dm7ebqPDh6
 K3uh1eeiv92PqwLIYi4IpoSgzjhikJ8OXjyley21JBEF/Wy6q5rTHI5ds5weqL51AArgrWeN3gb
 k5k+6Ty2fGtOomkCh3vwYerV/0Oiv17108XRCEC9T/o8W9Xejkd7zBc2VwThLm61BOLZT2sCq9N
 t6cvJP/WY2a58Trz713eLyMZOGwXSdBNS3WOk3qwEgB6heQ6LA8NVFjR5sMWXwa0dVZ5OhPZJZ9
 En+FX7fPu7zpic7sg+LkHvtc+PYVLa4gDFO7WV725avPvD/9BZbo59h0dR/hhSAJ+J9ToxClanp
 J8uYbnDZgDUPpBwy7YOlcPkaEOocxaD62ooIgZpETZWQBj/R+d/hNzLnnxHR/1/ILwXB1kMvY/z
 3bJeoBmON9pWo9EoOVImUQ2jh6trqcYepOCv+J3sV/UmYFfRC5H6mBjTknBEZlecV94khWSWYcI
 1bRZPAQLDGYfZci20++ga3iSQHDIh3q35iWUsZS00LDSnx2hzhG6V6lIdiu7xzPaWy8t5YDnCVv
 dSKXupFEeHCIsB1VK0lfdOiA0Bmn7vEtzgr/fGR+h+ll3/qIv+L6JEs390S5NzId4lUOeRN0cnE
 uaXN/vJs2ZicH6g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add SPMI node for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..63b2a1ddaf44012a03bbbe3d7ebbba91becda015 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/pinctrl/apple.h>
 
 / {
@@ -344,6 +345,13 @@ pinctrl_aop: pinctrl@2340f0000 {
 				     <AIC_IRQ 141 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spmi: spmi@235180700 {
+			compatible = "apple,t8015-spmi", "apple,t8103-spmi";
+			reg = <0x2 0x35180700 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@2351f0000 {
 			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x351f0000 0x0 0x4000>;

-- 
2.51.0


