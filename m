Return-Path: <linux-kernel+bounces-793059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0116B3CD73
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F7956455A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F522D4814;
	Sat, 30 Aug 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nASJHhB2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED022D3740
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572532; cv=none; b=pP8o0I+0eHLjFP5U4D5krkTc7E/Kis84KK5YycIorqt0xfZyhmhJkEYkwh4Wh76SWm+DSCMxr5l7TDRcw/l0uM02bts0H6ZIwuppJvzU7sV3CDtnK/HQnt05fFF6WNSPz+N5MObRgT+SM03obI1cRo6B7ktITM8X9StmjbhP8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572532; c=relaxed/simple;
	bh=ebjPcUawDuyYiStYmNU5ZL3R3L1PNedniR0atYT+P1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XynvCmkxEXh33HUnNYUAcqmUz28Cm79qDXyPBcG3TmQ5lprTmCG72GjnW8uPLQDZo4m4j96uE5kGQ1aP5YzqhdUwJoTTwLszv/SXzAIuiO03rC1+6psSzJMjMBXiwnHNOTTUZoXfU/KPHZYQSr03Qim88SCk7wi36k+sVpg6Usc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nASJHhB2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3cd99b4bb72so274874f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756572527; x=1757177327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR2F57pXZlUmDDCYEA5++08US32un21m5O7B8t3ZqrM=;
        b=nASJHhB27GAWfqIrPfwhzZLmmEJrZPfQFU8WkT1oxfsDcWkZx8Id2GeKaEdn+AA0xJ
         VdF4ELszycKD/WozZlDxoMko6i9gi0LHzdcHeeD8/OdSq+S+SBiL9VbKugpbOU0mPOo1
         KinXYOVEK43cLaGA45KvnpGfV7K9nGOZ0BdYL6cCdVm/kjdsS9Hu2CjSvreBwWiM3MSN
         g3xB7rdO1zdvp68bhcEb5heKMjlWsl+PYHoW38VPXUaqO3jPigjeLoXx+3HuB/x2bUeb
         99t/F6N1rZSMrYY3ch2KVI5VUmooj3qL10NFVtoykQ1rnP0R473DWUPVHWzOdDSCiWAz
         2VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572527; x=1757177327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR2F57pXZlUmDDCYEA5++08US32un21m5O7B8t3ZqrM=;
        b=DLEWx9oGAQzEQnec31Mnr7pixL4VJ1TVGmATUvJC2Y6cU4LIin2ugwRYtXxTrbDeCz
         qP7oMCo0NNbNedMU/n3j/bNIgJRuEF5YAhwuRLJUA3TsSInJk41AcdA5gC7Ktgj2PvPz
         WGo+sueu8MuyTiPDuDdzLh29wMeU3m5j7tXl9Nj/WTXNivMSDr75EAalRMCw04nccnRz
         qTc/Ya6+sByZM5KEfpos6oXOOakagEPTi2HUJ/aQDJebmzUvtaaLyAN5xRHXVS4cH80C
         WCXMU475kOzxLVArCGt60lHpQmeX4+uEGSiL7+8URUZqFkCXdWCuPGynk9FyKw7mCzCL
         5ikQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyuZAt102iBG4YtjnPIOXDWgs2ltB+JqphGQJjLZEb44KoEHdH6mLugIEy1r5/yp7jpVZK1y/4cfqZmug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzPcSwe/J/OKssHBkLIn/dwoqVhQPwNAKXR5x0DibYh/ps1Fa
	1JKB4SQ0SyXq4gRFtyJ+7sLL8ApSwDrSnMtw2waaOgP7OdAJQMe9zixBUadhNZDxFc8=
X-Gm-Gg: ASbGncvV4qhYeVyqcbe2RarwxEy9Tbvu/eKXgdTbxdujJbILfyQRUhHJ1t/mXxv+64g
	SbIuaI47Yyi3ZUST6Rk02msA2H/+wsDzr2r7uxDJ/zJgsTk7ULq5j3clCwFWAWLM7hWusOWDLgJ
	/GOzuVb5ktQXBBesY0Us267W8H39EFL3PSV4D+M2sXqE28rFNWKy/sTj/IfxFmuldIFPPBFLaqp
	QsbhTkKjej6IwK6HgIPTlYeW+DuZ1prrv18wdxGvrSkR+ExuLewBi7xdVVaHGLGmlN205EyUTvj
	O/l22gD1OUnewLWP3ZrNIqisnM73hbW3BwXpVtH0e30IBqJhUmDAQJsG4d0xQx98J+atlf1L6OH
	DlpLiuo9TRMrO42v0SmisDA3VhaJHN0mZxh8xVi4=
X-Google-Smtp-Source: AGHT+IHt0KuSMQTDPQqKwlDvsHq9uYVnTMb+JaxUV+LdGdK88mtHqEQl+7TJcM0mcCtVtJuqsHFZ5w==
X-Received: by 2002:a05:6000:2dc7:b0:3b7:8890:8e71 with SMTP id ffacd0b85a97d-3d0fdc6311amr1950866f8f.11.1756572527510;
        Sat, 30 Aug 2025 09:48:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf274dde69sm7818129f8f.14.2025.08.30.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 09:48:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 18:48:33 +0200
Subject: [PATCH v2 4/5] dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v2-4-4f8299343d32@linaro.org>
References: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ebjPcUawDuyYiStYmNU5ZL3R3L1PNedniR0atYT+P1Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosytleZMp+yMmU7xsdbFO7JlxlKksf/lRJNJaZ
 YnqE1JDQ0CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMrZQAKCRDBN2bmhouD
 10QUD/4gM1mCrSjYdcPTKpWDO6kCTZbB6/rtQiu0sGhp1ajK+tkWUy1YKGoYABMormyPFvjUzls
 4xbQEJN5gc40zxgmpfXhXLCfD7wl7VQsCVTtMAycfoR7jhL8kL2OB+vaNPXyE85AyseRAEnvYAv
 IDDGCmTzXLhDx+HejGYmRE/6Xeh2UWau1h6nkxpE6RPsTkr2P8VsGyYtqwuIvhluJShhDAW7DSG
 oPtUQr5q2g8KUANF6+JswThvWjwy0ImF+dNRp+1dHdeg46dbXLuzviBtqGzGw1syBI4N0uyS24D
 UcpQCZ+F4MZLpV0Z4TfQkf8bAr8gwB2DMAEkBZOML7culmARpQnlbqPA9do2wc+bDQkP66EuRsB
 7QzCly5CwNSmvfX5kOcmkhggEY7fSzm025jZLBwEVTs2iskQ8VZTnuUzTDU3jWkgF1bZY+olaVX
 s37qaxVKymOdFawq/CMkiAmqz3E/Nuwi1Uk0RzqejCeuqArxiwsWKp7QfqEribbB7X3BYbmgAMl
 tqsbPGMttaqCRBMqUi1B1UdZeP9DjS2ZNWfI/Jt3Bdgi0L5CZSJAIL/Td07t4tXZ3joYpp+p5Ou
 nGEmXkZeVdmhA8UPjHErtSQ85D6cRgivmj+rE1dXRgsgmZfpzXxRTx+sOGdE/R8pz2K02gZgJm1
 c0y2ypd7f+7giyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 8069e99ddac860b22c793c3ef9479f720cfd8c65..73d7ba0fda1def433a97d10bce21e762a307e36c 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -18,10 +18,6 @@ properties:
           - samsung,exynos3250-adc
           - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
           - samsung,exynos7-adc
-          - samsung,s3c2410-adc
-          - samsung,s3c2416-adc
-          - samsung,s3c2440-adc
-          - samsung,s3c2443-adc
           - samsung,s3c6410-adc
           - samsung,s5pv210-adc
       - items:

-- 
2.48.1


