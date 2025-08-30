Return-Path: <linux-kernel+bounces-792923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39BB3CA81
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CE31BA7C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7C2765D0;
	Sat, 30 Aug 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/giByel"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F31EA7D2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552628; cv=none; b=YXtyZ4JEiWkUj6jaUJYXXp2uWYS1E7j7dU/OCUSfK4oQHOI1VCdG0phDt6ad2mlDnAla8Zd6vRkhw+0E1BE+FSuCxDW4j9eah2VC1PejU3iTGMG5N8v8nfbseELnO5BoGHRk0x+wxGrM6Xl106KlkjjlDqCLX73tX/ihIohe9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552628; c=relaxed/simple;
	bh=BRm9jhP8w8rU/kwHuy64JB8q87TYx9kSQxPNxxu95xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUL/93qlztKpwMYlgOIJlZ5w+BfWg7QxqyG2D4mUg6R4zvbpF9bvoxYTRe3tNlutxfzwseVJf/T9eiQZT1FmJ2p59qjJX4GkIb7GTYGx9tUBcnJ/rItoLxdCjwO5PTGJrWv2U27zLO++06bn1PGvimw5mHJRxlK8lF36NzDkHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/giByel; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cb4348ac4so365756a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552625; x=1757157425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60upd+BKvn0xz+C5I56bG/z3TpNZllLyLlel/0JDTmo=;
        b=e/giByelnyKYzs33k+NsKjTfX51Hp54AMtrxaeE8xXHuu5r1q+ffhEONkG7jjpOYk2
         tJHtEpPB4ILsDukKIWW2yreKXl91mzC6DE3IIt+9Ggq6MLdh3oXc4rQ+oD2PgLe5Vf8V
         9a1AUe2L8YVE3N2GYmRls2IJPOeFVeb7MmA4AhQGY4DNBs2Vr4lbKgl206gr1Be2LMuB
         I7umnyLjbshnuEpBFRqZf2SNLUdXtxG0YpWGvZQaSGPfbB8haOn0vCaL62vuS39Mn+xL
         tODzUplMYVrulgQRWfUrHDXMGvyjOsKPT0t5ZRwjcs2dPbIkjUwlwY0nRV457q3QrsnM
         OSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552625; x=1757157425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60upd+BKvn0xz+C5I56bG/z3TpNZllLyLlel/0JDTmo=;
        b=W23A1oP0b3U3N9xQDVYk6E5j5iVK4vUuskM/2SfqTudm4bDtEzBc8f5ZHECbv3Cy+z
         0tRmjMLuZHtq7NG9c8urlILWlMtM+YeQY/c/qOoksw5a8g0Zo39A2TkR6rbSn2w3Eav7
         VxaR16h8RWL0AStxug9tQJ2wQr98HIQotLu5S3IvtWTemhJq1DHFIko57elW/dxS/XFV
         FVPM2EpRRwkKajdl14N4MlpGqhCHw8ds1JQ6A+kk7DZFA1oiQd3YMunLjDy3/e+uwNaO
         ox70LOUnRmwSXXxG4080K2e+3iBNp4mD24TV3aO3YvMbY3gxDhv1l/dXQUgM/p8hg9E/
         vb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqRpfPYEakskdpIw3W4AhCyg/7nhFCQSihFd2xVN8Q7+CvfYZuNLLfbPxweiT7gWxi6YmFlwfDIEphQqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6lC/IQYYnstIVE70RE+6c2Vf0GRp5f2ogkbNh0dqUgXECL2l
	R1mkmXn+iJWBb7nFZEd3Q+OPM68cygrpmNIIXnnkPr6dnKpYfsLsy2+QK5dP0SP1n9Q=
X-Gm-Gg: ASbGncutjLTTpV/bXqsTuTtUCvE4d/u1aiKsRKn+u04AA1ViVSFIJXjwmwGXPd8jqaz
	YiN7yWeOctfBXpCgIzlIZNWOGW7yAzoerZirtMiYIHYqsj+Ypy1aV0f8+XxObimzteokx1Igyzl
	lliNCRKWP/kQBgTVIXlPIjwA9UCd38JEYPjnz08zTC1hjfSsisZLMnEA/HqbKWiuGMB4JgTD2u6
	gkSOKaI0gj3R7Ccj6DQ26G/Y3O9tvs9C7/0S8lIxhERGyKSpTfypWpJS2S+uZOx3xzOmlJnELh9
	D155I3e8WqcsRgAKuSPVui3kbTPgN/R5vPmtBSyaUdLbRFadwt6jVJ/iwuWIUcKFRd86OZxuja5
	qat/ZOSJQYut//4Aqtxsghg3wxDFwDvbEOw==
X-Google-Smtp-Source: AGHT+IESzw14SfBx5ze5UZKu76aylPC6/8IATI5aiR9tuQyDgPAZqo4yCWAwk6R7aQI2r6EYS73T+w==
X-Received: by 2002:a17:907:d17:b0:af9:8748:2bb0 with SMTP id a640c23a62f3a-aff045d17ebmr294201866b.10.1756552624846;
        Sat, 30 Aug 2025 04:17:04 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0236d310casm117780166b.44.2025.08.30.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:17:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: pinctrl: samsung: Drop S3C2410
Date: Sat, 30 Aug 2025 13:16:59 +0200
Message-ID: <20250830111657.126190-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830111657.126190-3-krzysztof.kozlowski@linaro.org>
References: <20250830111657.126190-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=BRm9jhP8w8rU/kwHuy64JB8q87TYx9kSQxPNxxu95xA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBost2qIP+/+3cfZa+euI3pngE+iT+a+WHylVNyo
 UKZDkyDRr2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLdqgAKCRDBN2bmhouD
 15g7D/4uTfN6vaakcLmeYTWcMPINmB+4QHznc3DmRIsvt/HwJlEfzF3cf9vWU0kan2QhXIVns+q
 osqNMKWIneBJC3JaHTi9sTGnUGW9cj/SIuOKolDRvHS70gxzN+l7IQoJDVO0N01F1GgTFSolDIF
 Oq1RMQw1uwSgG0gGI5xTlLeTmcnCIe8NQ881Gh9TTzL/e26qUKQUWm+O+ITpje5wIUYCfxGP3BC
 xfLKdAEI6PFqAj97TaWtOt7uOsK2IUjvnahfTgaI3wiSrqfQH19tx+DTd2eSQP83hiQZtZqXqtE
 bBUZrdiYpIaZ/jaSNkt397mWi5QqHvw58QqUu6FpoPA7NkZ2F0Ak2rZ03ff7+jcLdIy6W2cGRTN
 O1ladZxpP8BIsUM3aPCFmLFf/Bo8LnYD+CMsCFRHuBTH0BTRMS1PJRDPeLNVdadIuY7VQOcEtrs
 FhiOv0agVPkld1UV8kwakqAwNSWWDIriYUZu0TdxjoUCXfuTRqyFg+ieR8znv6hxfW5Rw3AyO5p
 2SQjgT+PKM4cT9wSIN0y/EFqdTiupaB6keiPPwxdVxJFkDQYxv3Lxmv3aIccKPFUWSqY+IqcVWD
 WmN/pvjTj707/EFVbyzRxJyKHFWhL+sNh36dTmJTv9E58DdWMDhTFppTm5Bp/7k7XQ52MIWyj41 rCOtHz+e2oSiWQQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../samsung,pinctrl-wakeup-interrupt.yaml     | 19 +------------------
 .../bindings/pinctrl/samsung,pinctrl.yaml     |  4 ----
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 0da6d69f5991..dd11c73a55da 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -30,8 +30,6 @@ properties:
   compatible:
     oneOf:
       - enum:
-          - samsung,s3c2410-wakeup-eint
-          - samsung,s3c2412-wakeup-eint
           - samsung,s3c64xx-wakeup-eint
           - samsung,s5pv210-wakeup-eint
           - samsung,exynos4210-wakeup-eint
@@ -59,27 +57,12 @@ properties:
     description:
       Interrupt used by multiplexed external wake-up interrupts.
     minItems: 1
-    maxItems: 6
+    maxItems: 4
 
 required:
   - compatible
 
 allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - samsung,s3c2410-wakeup-eint
-              - samsung,s3c2412-wakeup-eint
-    then:
-      properties:
-        interrupts:
-          minItems: 6
-          maxItems: 6
-      required:
-        - interrupts
-
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index de8460856141..e48c4f467a28 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -36,10 +36,6 @@ properties:
   compatible:
     enum:
       - google,gs101-pinctrl
-      - samsung,s3c2412-pinctrl
-      - samsung,s3c2416-pinctrl
-      - samsung,s3c2440-pinctrl
-      - samsung,s3c2450-pinctrl
       - samsung,s3c64xx-pinctrl
       - samsung,s5pv210-pinctrl
       - samsung,exynos2200-pinctrl
-- 
2.48.1


