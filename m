Return-Path: <linux-kernel+bounces-764734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75BB22693
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37BF5029C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BA191F98;
	Tue, 12 Aug 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpnRh8Tr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE0155393
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001001; cv=none; b=tjnwqyPVT8a1KU6uxdND8OtJ+sbIRq24/SckCJD2sPoQ9Wu4UMJ8SHFiKxIlmSnOzORMxKK2SLezyv5JSVlX4Pdj5dS27vufkuslvmLp3ug9JrToiDxGqgTNfuB0j+1A+5jtbBV1DVSLI26a9eRdHbZxA5BmvZjNLwtUzUpDHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001001; c=relaxed/simple;
	bh=XzZlQ9CpcqoRYra25hFMzQMZp+oWGKxRUW/UE7qxBY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W27CTjFV+dUDNTNaj2WCW7TNG3nVecxIFuOE7xoLnzHFWVRy1bx4jvA9+JkHxV6YhUFNe9AdQ5PGc3c6mbv9q9XJw6393g95C7+tyUkomzGLQIFuda3PKeky/0sFz9FeAEwvHzBfzhRInjSZ5Snee6bDWpe943Mmjrvt1fBCTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpnRh8Tr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615877015daso883591a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755000996; x=1755605796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OneOXe0VhrrvRj4ZZoP1wvaAywjVM1pAzoyJgA4BqFs=;
        b=HpnRh8TrinU9wEIMCx0P9yGkZDV5eZT9M/ZZiL6Fg/gbeyhXKEV/ftf1TiBsSAi9Mx
         s4XLxJTzY5PLrN2U0m/4aJ+skj03duOuTtFwmORlgKHPUZq3nsoeqzttzSjKX9DrStCU
         3vC1hKQgfcxXTkxh69HjZCopMHgLrXwchjTIDP2l5lT8Im9oez9AkO+5VuPUQB72CBdP
         SAouAeMMe3gRH4mYujOjGFVUmCJFqwxQcEaZCJCPVLZHMHLhP57lMIVnsyBhdKrlnRg8
         2exqTwZuJWcpb1o/tG0Z3VHF9JemdG3dxit49lBp8XAcIjuatr8/atUXJklYWfbJuZHm
         EpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000996; x=1755605796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OneOXe0VhrrvRj4ZZoP1wvaAywjVM1pAzoyJgA4BqFs=;
        b=oT81ImiWwq+1o+rK+HNL2se0/6B66aoizPRK7DeO5flA+Dl1FDybd6HhX622AgEaDF
         vhSM+zIvFLMl7xcYjO6NHMX3XZi85Yl+SN+3f186a00tBkoDPCmAM5faixm1ASXl6sSl
         W6HZdNJI18jcGkEEKzbXGqVjNhuKI0Zz2K1rjrmsNHxKijmNtfZkcEiAL6UJSVqplaIm
         walyioBDBH8guCG6VfGWV73u+zLZjij1oc5Vc8Cbi9IoV6jUTx7TkfQFUg10PXpXuGao
         80dwfsWUmo7yUJ1ddIbfGS735Tqp1sONl1fwtRoqOGNt1hMYYGRxlIkIZURN+4GW4ptf
         yGmA==
X-Forwarded-Encrypted: i=1; AJvYcCVDVpctwh6Aic49R/1mywWqFAidjOsIPVv7m0iQNX1K4IQDinBQocT5ICZFDlPPn3a6blIAcCuzZhbmm7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfZrBPh4bGJ9AQE94we+AiooCn3QqKzzBCXvxKSqkbWNu19MY
	tcmiZv2eB88qnHv+WkNgBWT8AdR6Mpx1FmwoMhoG81Od80HIIHU93y8DOGuzOjhwG/o=
X-Gm-Gg: ASbGnctbRgh+neyxfjVCpLBV4VjlYpkppgxu0qX1XlpaXQVRdX8rxS8/37y5oqA86ft
	8ff0UOoXm1qVJh/vQ0GKbLflaH6RwllAp9aVkIQPmKx/1HdxuzxJbiXR27GyiCpqPJ+e3B4mMsm
	i0dbxNKJKdd5AwZGv/LIQZeUbp9D8pNa8vCSvsMgDFffURwhVsCU1oqqMVTg2LRfINWZu9fbhM8
	SOc9vQSwagAlYSevUra3JRNN4yPJ3ZrqZios9NeKxphhE1BQNcbkjc27WytEsoTjn307igXEtZb
	6xw4Sea6FpcYZ3lXtHUGF3wOopuFePEK5d4sVIewSivoFVSX3AZBTn7KZbAyeQSd3fvgO88hfy3
	rQMHsh4xQyexfmFezxqjjVBDjS2fq2m3pCkaH6X0AiLts
X-Google-Smtp-Source: AGHT+IGgkpeCBHiMX+ZCXuYMNHSA3+r79eSoJ++4bt1uHFFktJRJKVYvOUa9RPJyTGturdLEcYtmug==
X-Received: by 2002:a05:6402:2684:b0:617:b5bf:f03f with SMTP id 4fb4d7f45d1cf-618599c6889mr544726a12.4.1755000995890;
        Tue, 12 Aug 2025 05:16:35 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm19888749a12.38.2025.08.12.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:16:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks
Date: Tue, 12 Aug 2025 14:16:31 +0200
Message-ID: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=XzZlQ9CpcqoRYra25hFMzQMZp+oWGKxRUW/UE7qxBY8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomzCerwxWnIoEgaq14ySKDTWBOjr5uoLvVvf/R
 SDtaLlL/bGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJswngAKCRDBN2bmhouD
 1xsCD/96YrcHWBUbiFDVP+LAlTvkyA3Yk3QTKe6l+ISGm31TGejijRzLkdkpVmwIiRqu3WdMgKg
 p5INDv2pq5URbuC/07E69YJw/GJyyTzmilY0iiM+njU9kF8m1N9jr9E+VvS+72/vm57yycYo/y4
 LHC0dykO+fm0DtV4dqTydXzTJZ5Vl87W/i37zWg+90+QoX+mnqEE91J8WNdJMLDo714U8rWw3SN
 BN3YIsGrmpQe+8d/6Fo1ZfgXXS7Ibk6M+E+IieZg8QuNNxjYC40tFulqgeFbG0IsiCXlyufbt55
 APR0a1RhgfbfcZFnTzDlaARDIgcGx/KNpuPxuw6kXY74DM/cKApEFk6Cq0b91u+quT4XoKidbPI
 y+bcNobU0zkBPsvTm0ar5JPfvTLaHltGGInwIKcMzqwSY/V09qui0u9doi9BvMdpJU2ytmof5uq
 7d1pyUqnKzR33nDyL3Moj05O7jZ7zNJiIZZtUgkXWT8OdMYWA7S1tq7PMRqzztXdnXNlf8gfRkQ
 oQ5bBsjddk6YxIXf0M2ZhL77bn2Y9phMbQNu+KqRKnEZRCw7XghE2lTi4cU5a0mqCmSI6hbhbRp
 B1RfTg6s1PgM4aCSRU/TjaWQuZYRCTeHMInX1Dbh0c/rilQ+ZZAP/KFTX5CF50IcRaAzZSmcLj4 J0yl7rALCFW6KKQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Lists should have fixed constraints, because binding must be specific in
respect to hardware, thus add missing constraints to number of clocks.

Cc: <stable@vger.kernel.org>
Fixes: 88a499cd70d4 ("dt-bindings: Add support for the Broadcom UART driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Greg, patch for serial tree.
---
 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
index 89c462653e2d..8cc848ae11cb 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -41,7 +41,7 @@ properties:
           - const: dma_intr2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     const: sw_baud
-- 
2.48.1


