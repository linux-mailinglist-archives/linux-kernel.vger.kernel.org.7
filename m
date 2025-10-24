Return-Path: <linux-kernel+bounces-869315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DADD3C079BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE631B862CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A05346A04;
	Fri, 24 Oct 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCKNjb/I"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16E343209
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328679; cv=none; b=Ir06zKsJ6E4gnyUAjRedUFEj8FHE+0DFJ+qr3GTarIz2sGFT9y9/DdMnoAKS8AVfFP5bFw4hwY+ip6VDwWs+MOsraex/IKG1xmFoDOVWiyGxNF61sVOqKtvckpCLKXylsKKE8OVhptVOd07ojf1j6y9VgAEehBTDIZFnH3vPSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328679; c=relaxed/simple;
	bh=VSqkKAfAsASQV1wNAEnHQHuaUPvFzGicTvWIh5Er0fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoPSsLK1IJkjKRRgjbmDitGNCihGfHvJU4WnBcwsxLNY7FDUP28nq3C8pOtFEvFkIE/XB/UALKXxsmdgaWnphJYe8AU6Vy03AWDFbykL3Hf5iQY1Trrtdz/6STYucYhXPMQTz0BB4wJTLGGDs4Nezyz58wDveMB7hmSpGD3cDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCKNjb/I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so13380745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761328675; x=1761933475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdUt0RNaR2iDfSWCYFBAweXOdPy+lzj4EhVJE8ZDdzw=;
        b=qCKNjb/I9X/5OZimIEkf7QcbMYNbFdq7qOi1IsLLfTu1W0chklcVXHUGKsJp71kffh
         qVftJcQWh8kraAgKyLx0a09zF1lJk26P7HqmUz+aQ5gVCDvtraxRsat65kVkm5ShVWeO
         1ZOWAdY5SFwvb8fYQ1ggH9jltFzm361f6bIzbyAFoHaVK7INi4yFZ7vwKGuIeRq4kkCG
         FuesT8tPkKYdCSa2Dxj4DHKlouOyy/Aq0re8WNnVlFiDf7lknHUVLZEWSLRTuFU1flQU
         whx/tGYNxpjWhU/8kXd4vcHZqLQDl4iwSXbA3T1iiYvbr9jHtB3pqLtzqbTVLPTkSL+C
         cD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328675; x=1761933475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdUt0RNaR2iDfSWCYFBAweXOdPy+lzj4EhVJE8ZDdzw=;
        b=h0YEhZ6G4Ofs4dYiF0nHP7Stc6Ud7LCGPYS8AIULccwWKg7evGVphdPOTf7IxV/dK/
         NWvAWccmsHSkoksR2reI2m0gHnJGHSmdZN4uZ+csKlfAFO6B4igHmuMYect2i0luqz6b
         DkZauUV+rgkQCBNfq86hBzVqxvDWivxBi8Ymq7rEIARk+UdR5WiEu1g1OvS6xmdd7eEe
         Ar2M/bhBytauEI1v9FMvU5/m67cGkCEmDuN60GBPehYW3B3ElmpEfrH6dt5Nf3mUhzJu
         fsCRNB1V3VebpxzftEdpoNfmhsJxywE1aEKjAgcWWnJuS8DsAYxd/YGDldMRXb6LxQck
         Q+oA==
X-Forwarded-Encrypted: i=1; AJvYcCXE2OsIZL6TynN5ClVWBq8UrPN8Ug0j01XCbTt6KPMZh2ECYi7XdB0W2Al4+4PKW8sfo1pV8/wB2EOoDLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAn0g2YkIfhs4WoW5rHIkwTJQnBcHLleLaQus2itsRQ422J1c
	BmcuEi0fuLWY+Imc2RfyVuXKBmaPZRUFKmFqHdplbLm+nxVOBS6lfBgaqgDttVe7I60=
X-Gm-Gg: ASbGnct1e8adE7IEWG5zPwWfE5aOr4V0zWvUESsI38250iJw+2jd0D+5z1IVvTv+W6H
	uHUZZWP7NR5kmiBC37dyEw4EXNvQ+DhxDfHk43ZCdY4FTSeoOydfPAi2G7QfYe2Ux2OKNKsjUSv
	Bgtjdp6INSWIIfVZ9f7bgqxzRSfnFSVF4Po6LF3cDSvCzTzQiiA/MyQlaPeLZUkT19gLFH3x2+U
	AN7CS9SGH0ERjr+9v6Xjt8Sxm7gLfgSRiICPyBBsp+XGgNXEZXzR7BRrWYqc8C+ygkuc5RBQ++X
	Hm5r2SLtaNIYmk610UensIRqFhHc0A8uEG4JyC/jcYglUS8k8MfoyGCHKuWuKyMi/geMvrFvXoR
	G4A7krey+bws5bDG1LYFycoGOl0MHG4HAfaxFwjxGnxaLJu0NSyZBHFyL5lV3EBfzMuyTqm6084
	DFt7eiFc3fxBoGP599vraJ+xHBdWWf6yuZjck68trebtGoJJ/wpMFt
X-Google-Smtp-Source: AGHT+IFsoZFB0tp8+Ix3Ahj2qQkKTO41JFdcnIV2Y9pnCVaB8qxrPU8f/giCj+VPzq5b0sapD/+AIg==
X-Received: by 2002:a05:600c:8215:b0:471:a3b:56d with SMTP id 5b1f17b1804b1-475d2edace1mr37349155e9.34.1761328675489;
        Fri, 24 Oct 2025 10:57:55 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cad4c81dsm104062465e9.0.2025.10.24.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:57:55 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 24 Oct 2025 17:57:34 +0000
Subject: [PATCH v3 1/2] dt-bindings: rng: add google,gs101-trng compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-gs101-trng-v3-1-5d3403738f39@linaro.org>
References: <20251024-gs101-trng-v3-0-5d3403738f39@linaro.org>
In-Reply-To: <20251024-gs101-trng-v3-0-5d3403738f39@linaro.org>
To: =?utf-8?q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761328674; l=1416;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=VSqkKAfAsASQV1wNAEnHQHuaUPvFzGicTvWIh5Er0fs=;
 b=TUEcoNwwAwQ353epU4/TqYF+EqZtHiYEB5oZJTslCHQ7ANEPvO/wg0+dwkmN8uBeXDUXaXNFX
 K5fWbcR9GfPAkSc1/TSFsux2yQMkPQd5vyNUQWzGoc0j25Oqei9aMM2
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add support for the TRNG found on GS101. It works well with the current
exynos850 TRNG support.

The TRNG controller can be part of a power domain, allow the relevant
property 'power-domains'.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/rng/samsung,exynos5250-trng.yaml    | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
index 1a71935d8a1906591439c03b7678538e656324b6..699831927932949a433fa5dca767ad366fb76f2c 100644
--- a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
@@ -12,9 +12,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - samsung,exynos5250-trng
-      - samsung,exynos850-trng
+    oneOf:
+      - enum:
+          - samsung,exynos5250-trng
+          - samsung,exynos850-trng
+      - items:
+          - const: google,gs101-trng
+          - const: samsung,exynos850-trng
 
   clocks:
     minItems: 1
@@ -24,6 +28,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  power-domains:
+    maxItems: 1
+
   reg:
     maxItems: 1
 

-- 
2.51.1.851.g4ebd6896fd-goog


