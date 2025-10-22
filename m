Return-Path: <linux-kernel+bounces-864814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A05BFB9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253FC19A860B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0A334C0F;
	Wed, 22 Oct 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjAKZ/mc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70896331A77
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131983; cv=none; b=iIs0fTisgRCH38aDgYSPKFZ5Zk1aiMG83S53Lr6PDrzAJp1HIxAbFm2i+7w1VpchqB/oGlgvdKIGq2J+DDxzVCLsJfSxwBOXR6gKzKiMlfjbO/1i/RFtNB68SrnE2JPbQnY1gVx+SFt9heHkdle4yv7UxtscEyyY4DK5DROhOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131983; c=relaxed/simple;
	bh=wFL7EaC7oajWS8si1y0wmfU9HL7IN0yiHQa1hCUg5Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mssEDbdubzjf0JGJDFtEZ0aj1Xfhs3Q1fFBgnIpoX5BmICRni8pbPwgmN7/YVKrL44vYRHTewuxYJ1PUImQs2pZ/29qnZWNcWFNhYmuWfzok0GS8OpcKvVJ/B6VtiDdOXtJvzE3U1FniIrg1exyARiOnoWAp+haIm5mm1i2xeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjAKZ/mc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so4346051f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131979; x=1761736779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TkKDb8seGZ3p0bb+weF9fHd1+l2SxCH4jqobx5Z0NA=;
        b=AjAKZ/mc7EWnnQzrNesITi72sW4ZFm4O/4KccWtbn6ml+5ewC3EedtTk73cjVJ5Rjk
         tLOcdMm73Rr/Zr401m0XnkMbyKodbiHmUXhNADOgIhxsMcxOHgk6kRVY01ef1N9tJIP+
         pggt58RXe6L+8mv5WOwnH3SXFqgIsvguDeBYW1Zzi8QnuNJRkfWJCi99do2DKW6p/0bI
         c1QW1MSwLkMj+EE+zxtmbFtHEAov5zhiDZ0Va48A6ZaH/EchiqMy09tHCHc4junXQe8o
         4+eqIfi517NFIONqqT/v+8MrbPW4zVCq3yUBQXYPOHaloOMyZNWIEDNDlXdjuH2eISAI
         gncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131979; x=1761736779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TkKDb8seGZ3p0bb+weF9fHd1+l2SxCH4jqobx5Z0NA=;
        b=eSOAtZD6q530z/NPTB/dHoWf05tsCiONw5UUcf5ZYMnlVH2VYpozMBj+sri6szCI0e
         JtlGA78eLrmJZ4EsXVqRGDapjMIHNnDVRBMNgWxCZyrb/dNpYdzYIvRM69ohnGVuZN63
         nwtwpm9CZ+SAQC+zxz44CIqMPKxhWOOX/x8wONdWFTZSUpUqUnczKv90gzqTIXCTH39B
         cnOWLZRc8mt9Jy04IVzjW/7R/0Kz2Ht30qs0PWCYgb9lywvPh24VkE4tvn4aN3gldXIW
         //Kzs6Y4IwM5yPUPQeDQMrbQ6QyB/ebbC3cAa+y/LuCoANSMqTll2aqSFjmDlRhO7y1p
         L+iA==
X-Forwarded-Encrypted: i=1; AJvYcCXDmlgDKWIpmE611c2DM/CU1NSpzVQ1NHfhqZl+FKVuoNx0r1IZ6uUPdmOTiPSVAWeQn+zKQdP7rwoHlHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBPJgErpSGZ2yIgvPg9U9WpDheZFxnArte+L/fXT/qm4K345L
	31wxyK/WW7qXJBC/BvitgPfvgbrS1uUAFaNWZPkpYbfBuazI5r0FI9XD7RL5LVXI9QE=
X-Gm-Gg: ASbGncuoAerPAg4PfXGdh+8gjK1EzaEcK4XkfJtNObMECX7DqqKRk308r8s3Sua5QSP
	Y71P4IQwAo62UATJO/jsmQcXVkewVzpU9CbtGVfpc+7nlCkwJErzsu9BaKen7Rmcm2zPtUuqiRP
	3lhrDDm4uULbiQSh0QySX2aFe0L5dkOsoYn6JJWEC8eqoXxY6SCR4lLRYiwRQH3aD++sQejV6DH
	2a6cUKzqg/1BV+FVBDAssYpA/DHpk59yEv+4ObwWjIHaSVaTve0LUU/h1IWZvjVCqQxiLygGtQo
	ISBMUhbzkS8vl2ZpSQAzBxUPM5pLkuUlqDbTIXosaLwwv1JhnYpfPhKW4+BZ7ynjWWRnKqRwDrT
	gYdF4kFlRUATVAIEeMXgFCL7/5twq+E2YSQ4ko7q+N6w8R2f0ybhLvMpVji0sN1PqWf44t3hTER
	2rq7WpoMeGsR5WoSjuAuQ9XX9Xs0Pl+Wz0/a3nAt94CZwnrEUSjFgS4h9e9IAsml8=
X-Google-Smtp-Source: AGHT+IE/+qEk3SjQE0WaGw/Ate00STQbnaD0YtCC+WFT4/Fbr+bdpqv2kFO9m4rVu0eXE78+nSoBzA==
X-Received: by 2002:a05:6000:491d:b0:427:55b:cf6 with SMTP id ffacd0b85a97d-427055b0cf8mr14963659f8f.7.1761131978900;
        Wed, 22 Oct 2025 04:19:38 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a78csm24820692f8f.26.2025.10.22.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:19:38 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 22 Oct 2025 11:19:35 +0000
Subject: [PATCH 1/2] dt-bindings: rng: add google,gs101-trng compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gs101-trng-v1-1-8817e2d7a6fc@linaro.org>
References: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
In-Reply-To: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
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
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761131977; l=1108;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=wFL7EaC7oajWS8si1y0wmfU9HL7IN0yiHQa1hCUg5Ls=;
 b=BADVR+Jf79pRXQQP7OJ+g5sLQY7l/hCEa6RUAs9sGn87SwsuC7w4rRwpSLmGz9MKiaePKpFtk
 kdDu7pTDMneDUah7lu5PkCdDDp1n5XfUkpHjxqyC9OeuHgEpauWIQ/v
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add support for the TRNG found on GS101. It works well with the current
exynos850 TRNG support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../devicetree/bindings/rng/samsung,exynos5250-trng.yaml       | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
index 1a71935d8a1906591439c03b7678538e656324b6..4cae7dccbb915cf50dfa8db86b43293a66200002 100644
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

-- 
2.51.0.915.g61a8936c21-goog


