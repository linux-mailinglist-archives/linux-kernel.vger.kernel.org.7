Return-Path: <linux-kernel+bounces-733042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED041B06F63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30897A6211
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281752673A9;
	Wed, 16 Jul 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSbui4JH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7D260588
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652210; cv=none; b=sWFcY6c4wOmKgkLadfA6RhtmlBMXMUrQavtEDd+QWZozG6Up8bIZm0S0UrsF5CMYLx9OT1CxJ84lqhGVipj/p0ElB5NNGOLtmfUnQOXdCAKX7gJ0LWLyOUpBrRZ+ug6QR1+X9Z6p9v9tYMkRjyE8uuMUhsYeRGrvjkEfxdSIbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652210; c=relaxed/simple;
	bh=1ZRb0G6cYOmLEfHqu50vnKjcHuLohcwEx1xHyXDSWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbG4+MwszKwTqHpHEAcxuo2BEWB8aHUAsrtjML7s1UTY7wBBi4/S8cA75i19slxbP3Ir1zn/xmb4HCguWagAdhjx6XnE1YaxMFxfUT0Hg2J1HUdWabihjOpZGNTB6APFxqGKkShqzyG1wCHPYl3YhaguLdQ27w66Y6TbrFJ8Wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSbui4JH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a52878d37aso724093f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752652207; x=1753257007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=If6iFrnbvf7J8sBEQeb31M79uFX7ow0o3Z1tlhPnI1Q=;
        b=sSbui4JH8MlOmY9u9YHdckm06ySzbU8uUioksY8GS2Tz+//kVARuoYxmuwMQGqXJzq
         eRpDGFH8TuD9VzEWaKtg6o1Cap9703US22CGKboRYBbzSacvRVz2wEk8e3kXMhkIV6A4
         cUBOMNhvXhbtl88WBv+Xpb6Q5fW5pKBTSNAUcsK653ysWAehDfi1RINttsTqmTCM2S+8
         5ANgA38bsYOqmlB/SpMQoXjXWOZ80ej2pRgnsw1Y9kzoTeWtLz5CBLSeCEH3DYM6QZ0C
         qRMSS0hMIv2GREH1/qh03rA6CIO5jBv6A/NKKZSmEbh45W8xbZ9A/+NraXvZCNULCbUL
         roNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752652207; x=1753257007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If6iFrnbvf7J8sBEQeb31M79uFX7ow0o3Z1tlhPnI1Q=;
        b=dNTClJQbu00I7yrufMemepDcBjW3Vyio9RJklQr8wkJmH3c2+fzeh+QnSuvO2wBvsd
         oGHduclCIERYrJRr9eZCGalBzdVHq0hNSEeG19sK0m8k5qQ9Bx/gc06loYjPHwrBrMIc
         LewVEAn7p5OMPig7XwXS+lzjTMTHoY6WLMCxzVWv0d4fVq1lKBxEIOQoZKj+gJSwhCmz
         xRokF2fwbYClYKPkdvvwzhMT4rfwF0gjcwvExO75LZ4Iuf+BNGiqv8CRSsMGyoWxjzXt
         1JfZyMS3tg8CsoLyJWi1tw5306tMlmS4fIB+b2Kyd3QS3VyO/8Uv5/59zJiqnGvEMSic
         Ck/g==
X-Forwarded-Encrypted: i=1; AJvYcCV8cPEoBv+awO8b/FGqe8Sm0VltXy9XvtaoQstg7gZ4/892GTuI71fFrLCAiplVWbn4etLE5FOIvFSOJ3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TMabr4m0ZsnvUIZKJWj9f7EwzLUf0GT5Hd1IQ1FQy/94yExD
	Hp6ec/4tXttqM7tdFtbc9O9CChu8F317kgblLVGygiu90IiYrAe3QnOq99o0FpezAGk=
X-Gm-Gg: ASbGnctPaylbC1PTR9scKfhVeoNZuQM3E2iRPI8wfNzWIdqW5BlpfWSXvPucjYUONlc
	NzsCOlYKh5cDjKqpE/3UQI/iTnLzXYRidEuGYZqn8xhDU62eZrY736DOWtgrGfvgY6R17AKgkHX
	ZtOQzyqUHr/4LjrK8R9EW3FcU94w/08UIVziYTDuyKj3tdiji9dA0FVOfNHSMnSAtc2ai1NgiZh
	ReCCEJ/vHZWBsK3lQ+xaE02RryM/JntRje4nrR+oRrOm7BPRYYO7qfWWa6mkhU383w4YLVbKyJm
	eRyc84szeBRpW0SdJoXHV6P2CTF/7S5gslIiFEtPN2KfI7TsS75BeGRwwUCX6doT4k9DCMCk0t4
	bOKslxPGN/8XX1qhgMDiBDDpf6xIEOsmok18=
X-Google-Smtp-Source: AGHT+IEUjEk985nnWZZmAjTTpQ5LEJO/pws+gSqB87/tDY1yUfuO7gwUbG4RBQkqZqYe4K2BbRRygA==
X-Received: by 2002:a05:6000:2387:b0:3a4:d0dc:184b with SMTP id ffacd0b85a97d-3b60dd52efdmr606087f8f.6.1752652207043;
        Wed, 16 Jul 2025 00:50:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e2fasm16842269f8f.77.2025.07.16.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:50:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: qcom,lpass-va-macro: Define clock-names in top-level
Date: Wed, 16 Jul 2025 09:49:58 +0200
Message-ID: <20250716074957.102402-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=1ZRb0G6cYOmLEfHqu50vnKjcHuLohcwEx1xHyXDSWDA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBod1mls1BxkwzpHTFJNzDPEYinCzt8GBFEw8y/7
 rmPe1g8IGOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHdZpQAKCRDBN2bmhouD
 14DEEACVjdwsw5u44zs/5I8/ss8mI6u8MGlbbKxxIOP5ouNZGmAuXUUZ7qu0fN1KLI4jmMpPdfV
 L/7ML2TZYpHDBAa7w1chRYO05GCoYsIBcIXEiabwiaTlRgVCO4cfFlcfSuMPbmOIT8B76nAixp4
 62tz0Hwf+8EtYDcrnjpC1rbVkZHapdN+fKy8wpzIUHAuqqFNJBvRQ3d6Z2q1qrcYfcSb+wU3Hns
 G4+68mMCTM/+RGKiGp+v2jdTXDuqHyGjDjLkxU2PiG7JJmykxaouEfinR8PQHGlTaZ6A+enKbd2
 R2v7Xi2OVwOhyDHyTaFN5NfXHnizpB4CwZsCywvoESX18sr1s8j+vfQJpTmsGXeHt9cx/vDfb8p
 QPgkWQyFZd7o1IW3A5YBRGdPT2jtxPv8IU2oI/DKxJGLV2ft3qm+peSeQrJHisfuX3F4ZElOFpH
 rkrBbWsjV/fUa4J9l3DJmSmfuilpbh2uA47cBqFL6Xde/eITEejS/NoLfz5L5wusTLuXIZoCyoI
 7tW9Eu3d6EK3NiMWjJpkYFRi81uga0ENgDs3fs561HoqH4Y7cMA87mF+4avKpTC9Z/ovq1CdbEi
 hRk5mahclOFOW0VBWC7jxukO4KcLf+poQmUKgJf0NOJ7sXkCFNKPJEtC0nEALqkiUYcECzYiN3N fWCqVyklhP++ivg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Device variants use different amount of clock inputs, but all of them
are in the same order, 'clock-names' in top-level properties can define
the list and each if:then: block can only narrow the number of items.

This is preferred syntax, because it keeps list unified among devices
and encourages adding new entries to the end of the list, instead of
adding them in the middle.  The change has no functional impact, but
partially reverts approach implemented in commit cfad817095e1 ("ASoC:
dt-bindings: qcom,lpass-va-macro: Add missing NPL clock").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 28 ++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index f41deaa6f4df..dd549db6c841 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -40,7 +40,11 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 4
+    items:
+      - const: mclk
+      - const: macro
+      - const: dcodec
+      - const: npl
 
   clock-output-names:
     maxItems: 1
@@ -80,8 +84,7 @@ allOf:
         clocks:
           maxItems: 1
         clock-names:
-          items:
-            - const: mclk
+          maxItems: 1
 
   - if:
       properties:
@@ -94,10 +97,8 @@ allOf:
           minItems: 3
           maxItems: 3
         clock-names:
-          items:
-            - const: mclk
-            - const: macro
-            - const: dcodec
+          minItems: 3
+          maxItems: 3
 
   - if:
       properties:
@@ -112,11 +113,8 @@ allOf:
           minItems: 4
           maxItems: 4
         clock-names:
-          items:
-            - const: mclk
-            - const: macro
-            - const: dcodec
-            - const: npl
+          minItems: 4
+          maxItems: 4
 
   - if:
       properties:
@@ -130,10 +128,8 @@ allOf:
           minItems: 3
           maxItems: 3
         clock-names:
-          items:
-            - const: mclk
-            - const: macro
-            - const: dcodec
+          minItems: 3
+          maxItems: 3
 
 unevaluatedProperties: false
 
-- 
2.43.0


