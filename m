Return-Path: <linux-kernel+bounces-792918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6653CB3CA6D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954271C206B0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF58280308;
	Sat, 30 Aug 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4a4fOjL"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821027E07E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552199; cv=none; b=oGAt11jJOkvFeVlKzenWzLMpmYHGjLic948fQIsz8tRV/qI8C7oI6M6fPOdeW5iN/6HPqlC5mzOdXxKTUkkILFJOij7ZJnvGqQWJdEWQZaibwUf6EEnIc4P47B6Dy8XFVICbbnVFyEHMrHD8M+i8QZP+H1Z+hYQiKx7YrDMSDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552199; c=relaxed/simple;
	bh=cHIEU+NPJpVUCzgTWpzKVI4NuSvxjRXzW+gY2ZxvjWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiQsi298LpSVFJkZUzw+vArG7QKX8+s++N8I5ggu442aUhCeb5one/ILpFpMDQXn0C2IB1jP7afpKsizqnMJ2Dsyyn4CLxvt0pvT9MvseN1JTw7fjRoc67ZcOc44Jx5Nj6jtuOW3kquLZI5rKbrMa7jWd/3xnmJ30GPxf+ern0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4a4fOjL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5e3de6so402351a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552195; x=1757156995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bh4erFgymhHXlSdczQn09Ns70cyX8l95wuvz4MlLE5Y=;
        b=r4a4fOjLUb0IORCS5OaM6pWMM/4KNwjkrtyCCjakqXM4BcyBL4DiBUcA7daRtCYupp
         M2jfhdaSlBek78ClA2XqXOcqUhtoExnEy7NXSek9gZQT7K7Cc8F5uv2WIZAicvPjDQ2i
         75+d6gSwutA2yWMQHjEV0s8TWEgqmGseTusFXtGcO7D6jiO3gg9JZIZGNmj0Daeur83q
         3Z4/VVIqVMRpGT6mCGKy2Nemu+8I2/BHpHwNjTaiCO6cHFhBcL/OoDwfciOB08eWoZ9y
         Fhblr8NgdHwC5SCUyyH+L5OY+yaQvI4cJZcypspMdxAEJFRYlYRW5Ov4utzkVVV1s65J
         P7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552195; x=1757156995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh4erFgymhHXlSdczQn09Ns70cyX8l95wuvz4MlLE5Y=;
        b=BAp2RYk0MGySZKmRSzed8/7yUgLHDwgJrlYpQfH63n73Qd0dRpKOnKYlHEV+q+OYLn
         +ztbiLRtBv6qsLuWDF3W5ybsrjnbZ7Xj3TBbb/qbIJgnG8RjYol1XWHaI3G58l5BmbEl
         UmAt+pTj9TyOyCKKA+VMTuh9LPoaOVu00mHzNf9+XguKk/9r7lesbWjSRTeeqXkcd6Wd
         0LV4HXZPQbYA8XIPm2GJ+aqLey8m/Ue3ILGS2P0lR4/a7uyY11jzaDejFcvP/wbcSmje
         Ry0CCGhrJIJws4TXx03mvPvFkw9x372NHonU35t2OHOZC7+ZxZ1rhmfWk2Oo8Xag7cI5
         pP+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZ21MNtn40zf7K9pGPFk1pTMVFx7NsvJ+EFH0lnRzUQ1bCc5G2FkdoYOm5emCj5A/AXv5REa49BKIg52s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEodo66XToZk1icW8T3ZYmQeQywq96WgmMv3Jd/UWGjdm23qel
	c3UtmT+S4W2MiIczML1NFzh+Me2ihWxRk56bR5fT+D2VPgMFBGBVsGHUdmm+utgIucc=
X-Gm-Gg: ASbGnctnUNLTH9GRRqskYrysDhMwGI1pIfCsNiAiP2qc5PgjeBt6+HyUW/QvrpxKHLz
	HpByL4M33/IQ8NrdI3qDGXHjGa7cDxe8Tb2gnW+KkOhlaMCZzE0ri3V0kEk1Q7jLak5ONEzUrm8
	PRQgrlBgEaBqrcPs8xdDGfe+pTSr+qccocuCGulhDi7Xc587Z19Oht68U3z9Ew660ml1EiYm7s9
	INx9tYuigxn+ayJ9R2kqM/eW46R+9uPrxR7lwQSCN0LdRQSljV3dpr7i5PvbU0PWYMIPUpwDU4W
	3UZcpcIEwp9amrqWR22avvSDa9csKAYQguM8R0pJapLad6LR2hb96v05pz4SUAVaOytlrzV818+
	a+k63+XzJQJvAS8026tvUxJhD5lKM8kdXXFxKQ/U=
X-Google-Smtp-Source: AGHT+IFBgu1ofh08wSJsUXZGfBTpuxs1IaZcrmEM87+9ZBrU5RDUdFz4gzUARIltFoHjOTc1YvjmYA==
X-Received: by 2002:a05:6402:2105:b0:61c:1bb3:2473 with SMTP id 4fb4d7f45d1cf-61cfe999d10mr2852784a12.3.1756552195504;
        Sat, 30 Aug 2025 04:09:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc21542asm3285666a12.18.2025.08.30.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:09:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 13:09:42 +0200
Subject: [PATCH 5/5] dt-bindings: iio: adc: samsung,exynos: Drop
 touchscreen support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v1-5-de54dfb1d9ea@linaro.org>
References: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cHIEU+NPJpVUCzgTWpzKVI4NuSvxjRXzW+gY2ZxvjWs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostv39456voN2g4Wi5/A6Obv1+NtJbj+zc4VQK
 FOmRj3bE4qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLb9wAKCRDBN2bmhouD
 1xcNEACEkHrmoaC5qwjaF2gjYtInfNH8N/FKtg7etMoJXRrCaNqinwSklAwwUFZD654hDJDLZ0K
 MAQSvEnfCZVLggE5Ts8O9z/uk+ggfYvWin1Hfp6/FNww3cEwXYp6j5ynb6oyPow5c/ItmdeC9JX
 gK7Er1IlJ5+Rz0L5TU6J5EoJZn8F500lY5ExkpXOXhNB7A90+bUPomCzG4f3hLnhWWpFRj/w8Jv
 YwRDtXCVjkJ8Tj9I5scGmKzYEzA/xlSx1KkwAMukQoyLS6ROqFLTiMIjqFqqTOI+salro3quSHi
 diJu2y6tjzqIQrEUSPYwoEsmpClANA7B9w4L2PY7hJ6DIzeep8NwIhk/PY7ZZZQ2ThOLLWQpX3s
 sw7ZPXny5LSkBzE6A5kbMGklrjBxD54AkfkHOxIdtiqJBp9F4ls+lLHUpKCtKMvvzX23Myy5OsD
 yPTUXtgxbMCEQuDAfp1hm0xWBD+zJvWux2FIe+mjeVnahghukgzHPq+I6Bed1TkkYMAUnhSGIA0
 DYg6ZzTNkQCHHatjYCTIENVOtgKWL3Mxj12Q4CEwA49yXJZnGgNU0kMsjaJ8BRxRIL0+TnjBQ5c
 MHpV3EKFFGdREqfcRqjEw2pyuB5g8hoDtb3NxghjgkDGX9nET07QYhAaAORF80N8du+EP+MNzz9
 vGDcv9oR5wso+3w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

With last user of touchscreen via ADC (S3C24xx SoC) gone, drop the
unused has-touchscreen property and optional touchscreen interrupt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/adc/samsung,exynos-adc.yaml          | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 73d7ba0fda1def433a97d10bce21e762a307e36c..0654f8972525bf67089fe7fd4f3ab3ff506515c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -42,10 +42,7 @@ properties:
     maxItems: 2
 
   interrupts:
-    description:
-      ADC interrupt followed by optional touchscreen interrupt.
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   "#io-channel-cells":
     const: 1
@@ -58,11 +55,6 @@ properties:
       Phandle to the PMU system controller node (to access the ADC_PHY
       register on Exynos3250/4x12/5250/5420/5800).
 
-  has-touchscreen:
-    description:
-      If present, indicates that a touchscreen is connected and usable.
-    type: boolean
-
 required:
   - compatible
   - reg
@@ -113,15 +105,6 @@ allOf:
           items:
             - const: adc
 
-  - if:
-      required:
-        - has-touchscreen
-    then:
-      properties:
-        interrupts:
-          minItems: 2
-          maxItems: 2
-
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

-- 
2.48.1


