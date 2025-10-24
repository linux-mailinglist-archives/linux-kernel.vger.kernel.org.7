Return-Path: <linux-kernel+bounces-869311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98649C07979
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775E31A62681
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB47346E56;
	Fri, 24 Oct 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlTrcbAg"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E160343D87
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328271; cv=none; b=X3bWDqcFZsjIpRi4Buq9xDk50Oi13O8SN/WEKyWVTAjM8ED2+SjLTzqVHqq7vUcD3m4uEANihxOuKmZ7AaEw68rdVfMi87IPwfvDKDFpX8UDprK0TEByB8ilSC4q0hAOlXGvptMehb0ZWADvM46koJoZMcSe3anOxkwV5r/kw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328271; c=relaxed/simple;
	bh=raBiU2TNdnYW5GXBQGKlY34qsI95KKrr7UkG+dolrPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kp9nTXepymjBuC8pMOKsGYS/1wYxwu4T/KBNmxHEuhpc1anIxzI26iJfbs1m4VxX+dnIlG/CAYQKWfzgnFxAijDTvG6prYpDIxVf38cwkuOykxRRa8rTUywIETxd2LUA86iI5P9T+QbmbQ/s+i6nBxeb4guHSV7C3Ctg2JDbl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlTrcbAg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so1531425f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761328266; x=1761933066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1HvYCNLV5CI0boyLI+MOBTwgyqBxpYEqfcX5SoAEoA=;
        b=mlTrcbAg88rvFSUlVUqQxfJFqv2xGpB0p23PZOYywlF52PN5KBGz9aHB5ezK8TveCD
         G6HMV900q9myUo5JPKG+UeophXjrvB0zJiBp08QeULmgMWh7+YKCoA1MTy/SR0OIMZ9P
         zQTIWmjUbWKz7Y3OqZTZwvEJcPSqA5LSk9q+A2ahbL9EGHoKoSmzCfA3oHfDg+oFwP7b
         hI1wrufI7qpQEMqRxNo47BB7eT3s0q1Xrl15rdyzeIu761hUJ0ldxfJfc7nP5qGeqBSZ
         qXE4qnuHNkm4WA+bq557JFq13idy7e2+nS/SXMCwZuQ+PipBONgfR84mvom7Exdm/68H
         uKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328266; x=1761933066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1HvYCNLV5CI0boyLI+MOBTwgyqBxpYEqfcX5SoAEoA=;
        b=cZnXRQoSCgc38vK/blc2/PYZRFItS9BtECGzxOxi4nscJA3+dCMK1mTNYbCaiQPCxd
         E1QBK+KYDjBq9nDG/aIrjYVqeEBXQJ/b7t21ECit7e0aeR8gkP477LIzPcULfkYJ7FI3
         9JvXA7h3Vt5gijfLCNhWX5B1dTK4N51y1A79LXcuPhXNPUd6p0OpOJTWkJhsF94KpMQK
         vikUNwTI4jpzqSGm8NuCsdtOhtKS1IAwxj3zf6EOhbRe0XRaFiwfykrsgN2/QIQfdJs7
         hGWCpLAmBZJg/y8sKmnR6Xy8byzW+LwB3RatEMF0NzvTH8lDk5hLjrh+IFHBV1ZHUBPV
         699A==
X-Forwarded-Encrypted: i=1; AJvYcCXD8aOkiSGkqeUu19rHn7xL1z5HGr3Jof98jzwpEtF+R+PIu/1eUE16u8YxNdlrhgXsoendSolk5as7orI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEaJuSGWEbGvraxS5J/Itbzh2fWmPAEeHECb0NcJHdL4mZtyv
	hqkfuaAe0t6ZZV0GuAxdJpu8kxr24NLv5tqzeuvz7lIk/aFZK1EkRU3uWDoOHiirzk0=
X-Gm-Gg: ASbGncvWUEiICEHRC+wCNjB00fFZIwVL/Din/oT+RufNHvcZ9z3b1Trsd0SlFQ1YN6V
	fqw2DJ7LN1TYtNjLtKe3baVGh/p9QCxFuR82WsxDZhxkL51QvSQb7rQpYeeLrgw7mnIhiRVCrFS
	ilLdn+YG5kSXIGQX2MRm19o3/Ywfz1d66uAmJyDE6q4ZCh3gSTvWT7PWCgETHI44VK+4Eu8C92y
	LlcPocgakF4EQK1VJFIczFtw2BM6o57+AN+McgtO23tWqGXAQGqhkhFwY2+UzXBNE8lfT0ZOoF/
	dA3oXg3ligj4pMIm7pbYrV27kbYOQgPmQzVKsYybXjoe+VTBm6zbtM+HEFgDSAx7caCbrfCku1t
	HhjKwTqVC7qDRWO0WdnFlizdlQF/cVvcQ+eTTEWbpbeNSXT2erghq9aqbsKir0PJP8Z3zktsSRJ
	wbcFw+5erSalEFkoVJSqBDXcPrqnd27r8W5CJ/f2WIU3r+aIiv169uqtw2TP5/iS8=
X-Google-Smtp-Source: AGHT+IG+eLRf8YPCXCIvX1Icim3foq9BCM0qVymaKl3/VkViHXuuqGJB+jB3dPU4X7R8xwku0ueZeA==
X-Received: by 2002:a05:6000:2f85:b0:428:3bf5:b3b8 with SMTP id ffacd0b85a97d-429907467e1mr3127739f8f.44.1761328265663;
        Fri, 24 Oct 2025 10:51:05 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e7622sm10321900f8f.8.2025.10.24.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:51:05 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 24 Oct 2025 17:51:01 +0000
Subject: [PATCH v2 2/2] arm64: dts: exynos: gs101: add TRNG node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-gs101-trng-v2-2-c2bb81322da4@linaro.org>
References: <20251024-gs101-trng-v2-0-c2bb81322da4@linaro.org>
In-Reply-To: <20251024-gs101-trng-v2-0-c2bb81322da4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761328263; l=1126;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=raBiU2TNdnYW5GXBQGKlY34qsI95KKrr7UkG+dolrPs=;
 b=e1UEZMWe5ikZ+mjOHJ6zxj4LdozzJBMXJBQkXRXZTR6davdh/DgSzg4n+2rpnv8ebPSQH3L5u
 GH+sVbHAu/sBN1oTyQY44OWkPjPvlcgeWGZUXH/mWGz27nhPuprVPia
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Define the TRNG node. GS101 TRNG works well with the current
Exynos850 TRNG support. Specify the Google specific compatible
in front of the Exynos one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..380f7e70910ab8bcc28690782532fff87ca7e30b 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -630,6 +630,15 @@ watchdog_cl1: watchdog@10070000 {
 			status = "disabled";
 		};
 
+		trng: rng@10141400 {
+			compatible = "google,gs101-trng",
+				     "samsung,exynos850-trng";
+			reg = <0x10141400 0x100>;
+			clocks = <&cmu_misc CLK_GOUT_MISC_SSS_I_ACLK>,
+				 <&cmu_misc CLK_GOUT_MISC_SSS_I_PCLK>;
+			clock-names = "secss", "pclk";
+		};
+
 		gic: interrupt-controller@10400000 {
 			compatible = "arm,gic-v3";
 			#address-cells = <0>;

-- 
2.51.1.851.g4ebd6896fd-goog


