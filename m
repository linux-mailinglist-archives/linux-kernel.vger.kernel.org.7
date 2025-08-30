Return-Path: <linux-kernel+bounces-792968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487ACB3CB00
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B083E5E5946
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185D276052;
	Sat, 30 Aug 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PupEOCZS"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FD1DF24F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558839; cv=none; b=qtpc/Bz9RJ58gldMtQGuHcNGdoZkdtRbtoWHZRV3dDr71xbmDybtmZjFbS7zXrvl0+4uCu7XjA6CPTHAbK30d5TYm3hWNWx2x0vgMswW5KlHTFdWUyZnwK2W2vgZSLDzwsJkUPCpr5JjYfWAvqrFvNm6pRha5liQFQRMiv7PaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558839; c=relaxed/simple;
	bh=yFbXJjlzfsFuZCCgVMCRBEgVOln4MKOWzsk05OwyRFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcaPAZguZPVRQIvUJHBSI8gbIJSwBRzZNYS1xLPj9V7wHO1IIqBoSABjNDQw5IjVxh48KRUYfG5bUwq+oxjsRoLs55iExvc6MavI2suSXmQEvAS90L8C71t+ZjpuvNZebUDAb6XTNBjw8mMhFvbxE/oAmVVZ5guNVi+x6geMPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PupEOCZS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cd151c38ceso430998f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756558835; x=1757163635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0YOj2I/Emxrd9bkiEwP9k7FvjfganDLhXhpwxzAHFQ=;
        b=PupEOCZS0Z6ZnYfJOP5PlC6iAieBBKwQYfcy7JxYn3/24dDBbr9OwzwD+v9ncG5111
         f4+XXNL/X8f8vRMyltxx9BbkyRqwyPx7nIUduYtoUgvOno+maPBZ3RCSr4myvRJwCC7Q
         hBm9uil+BboL29sotIGb2O/xkDqeuJSP0NMc3vrznIuJByEbWZS8aJ9nI2U6Fh+F+YGN
         /Ofc/gkBrOaWetD1FdLqQxz9HJAGJNO/0LFRWvNB4SHztG1cYbJCLybYzwoO1lbBXAVT
         +VvsKmuMCbYnQp1OAcQGXvkI2JjZB4Qcjq8jP3sTCNTEX0tXZoIiFr0nbmXLNrMxj5g1
         CXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756558835; x=1757163635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0YOj2I/Emxrd9bkiEwP9k7FvjfganDLhXhpwxzAHFQ=;
        b=Hx5O5/wpVmI9tyfZ30S5iZcBkhAlBaK1pCwV0+xfwBbHNa8wtigKpRrklQtLpuZmKW
         nOkrH4wwoTp+xheDCfbqFZBtgUgshSIy2N0jnmpoMzavTck5UObooNFhzHuhxzZrGS2c
         IxVmsIPRJHYby3ja6jY//ZvW3p3pcmGToHtQln68qCRfAoP0kQKWapKY584fiPayxRcI
         +IZVwn+ahgqeowe0IqXh03wE1YKkPSSBnxNWZzvYT45rRdMKkZsAK6hMq4rPnV3x8Gfx
         4wKiqYm/ofhjB47/W10A0HMpwXUMPCoHs+isctLoaXM49Mod5m95E2GGdkYJyO/AvE4x
         wW0g==
X-Forwarded-Encrypted: i=1; AJvYcCUrMMFMAbmqm4FUIN8PFrZvJQZ7QcqyPftD0tYXykXaCdQjMc6SvGZP6SxJXGgeSPMOO1cg3unPMReTR8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfqknNrRR/y4fC/CIads1faFT59A7Z34SO8Yfa1inPZtSH1k5
	V3PFcrNbWiFQkmKqtcBMnju/WGVa6hVnUkPaIPNEfk939Zn6KHFurOKa07wCmCYJ0mU=
X-Gm-Gg: ASbGncvz1NSDKQOao24cTuDOT2Tc9B8hAk0jWeKSh4mUODUJDrYdcrdA1aEh7Cflp/A
	l+O36P8Mk2H5rHRAVKPUSFnGcJUS8+RXKXzQBoaNdO5u1XzxtGLrumEJr9n2bVjX8f9T0OcJR2K
	UC94ctJ961WWM1sBzsw82cJci6tLVGPXjUNGUjdVMHZ1XL2e2PA2Nz8AUD7WIi47fI6TOVcx4ou
	ZkTHdZbeBFHPmw4Ku1CQE4XTTlxY/avGzA0wT8wMbWp+7BpJd/9dSYWKesitE8Nh7TnItwRpzjj
	G5XGnahg9LL2zhHsJRAV/jvh+ihpWeaCgMfll1LBAmiFTOukDAYQ8UeSo/z+DtgX+4V23nCSekz
	4LQReKiuLMlL15dBRsKFsN31BB8ZPqKefAg==
X-Google-Smtp-Source: AGHT+IHlC7ysRbsLcBtEPKwS9FBVQoedjhJLnYOWxUsoDRK2aWs4dk5zeB2gqXHe4+Cg7/2Yb9pX9g==
X-Received: by 2002:a05:600c:4f8b:b0:455:f12f:e3fc with SMTP id 5b1f17b1804b1-45b81e92f7fmr21916495e9.2.1756558835309;
        Sat, 30 Aug 2025 06:00:35 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a5asm7077534f8f.55.2025.08.30.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:00:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: rtc: s3c: Drop S3C2410
Date: Sat, 30 Aug 2025 15:00:27 +0200
Message-ID: <20250830130024.142815-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830130024.142815-4-krzysztof.kozlowski@linaro.org>
References: <20250830130024.142815-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=yFbXJjlzfsFuZCCgVMCRBEgVOln4MKOWzsk05OwyRFc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosvXsgOxVuQ1krqadUAKXr8+ZKXJ3/DOITkL4T
 5uhnPsOqRGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLL17AAKCRDBN2bmhouD
 1/TzEACPR1uNynFBvE9S1nGD1EBp56FenjGhj3C1Y4nspLO7n8L+TEfdLDqM2mLpPi5Yeneem0I
 O6QP/XDuhCnZeo7JTIt4Wt/6Js5MxTm3lH/my7r2ZKh+03RqnJ9DCgvOTODLpmaCV7YhHKp6KvS
 lBvRyu5cUsJfAXFqFIrnYOPkaMRQrGIEsLmdpydrkkbv7p7MzXdONwRMfPozKoTUoSKCHnWtzHc
 UxCognoaDPRH87NBkkNNN04DF/AeWfvSiBOthq80Jw/STaI/8YAsrmcHThnrtx9G5ctBB0vSvTF
 ulZa3xO009pUw+OEzxrrq2LoRyrT0f91DvvGKZFPqRFKx8VALbX7DptU9lWMd3gX2yyWd4/xdwM
 uuF1mmzlewQZaLfdwiJuE6Yd3qBtq3Ectkp26Gg88ikLhytgWlhDwvIAqGZYrL8SlImyHirQNt9
 arqDq6dqHgP8QjNqRSOd4jxh6uR7fQIfADDszqzVtlHHzGKAFk173So+wYt3L6Fr4JFsVxZmBQz
 irhja6+hjtFdb1khE5dx0EQ7Hq1dIDFY5KwDEKDFrz+ik6MMLe8AzLtSYG411T1gJHN7ePUxY5T
 gtKiCq9mRYaS01/eziIYd5V1LNyiwM+b4IZMuOZqLpMqvl5w30P9hSvQtV2EwUzUFXXjASXfUe7 v3x8oLWuDtieM+g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/rtc/s3c-rtc.yaml      | 40 ++-----------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
index bf4e11d6dffb..338874e7ed7f 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -13,9 +13,6 @@ properties:
   compatible:
     oneOf:
       - enum:
-          - samsung,s3c2410-rtc
-          - samsung,s3c2416-rtc
-          - samsung,s3c2443-rtc
           - samsung,s3c6410-rtc
       - items:
           - enum:
@@ -29,19 +26,12 @@ properties:
     maxItems: 1
 
   clocks:
-    description:
-      Must contain a list of phandle and clock specifier for the rtc
-      clock and in the case of a s3c6410 compatible controller, also
-      a source clock.
-    minItems: 1
     maxItems: 2
 
   clock-names:
-    description:
-      Must contain "rtc" and for a s3c6410 compatible controller
-      also "rtc_src".
-    minItems: 1
-    maxItems: 2
+    items:
+      - const: rtc
+      - const: rtc_src
 
   interrupts:
     description:
@@ -54,30 +44,6 @@ properties:
 
 allOf:
   - $ref: rtc.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - samsung,s3c6410-rtc
-              - samsung,exynos3250-rtc
-    then:
-      properties:
-        clocks:
-          minItems: 2
-          maxItems: 2
-        clock-names:
-          items:
-            - const: rtc
-            - const: rtc_src
-    else:
-      properties:
-        clocks:
-          minItems: 1
-          maxItems: 1
-        clock-names:
-          items:
-            - const: rtc
 
 unevaluatedProperties: false
 
-- 
2.48.1


