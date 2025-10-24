Return-Path: <linux-kernel+bounces-869317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820EC079C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7E73ADC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352F346E5B;
	Fri, 24 Oct 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F17Xf9aS"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5E345CAE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328679; cv=none; b=J7gzEpGfUx8wvI9kP0YKSeI2dRzxWRFHfy4f40LQHj7SX8QUbvQaw4nZTbJWvb/98PdqAvIH17P+GBHa9boJXOxDoeiem3aoFCP0/9fSOkB1k7NOLwH6OL/G4th5IBARM48IN4AtSoXSCe0SWEBHxj4FsJF0NjS3uBEyXzk85iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328679; c=relaxed/simple;
	bh=raBiU2TNdnYW5GXBQGKlY34qsI95KKrr7UkG+dolrPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVwwUv2dd4fxDTY4n3TalJVX5otqpJQmAHToNunrpayFakipouAHIBiGvjjCM+/wY9XGUuriwf8DJtx7vECPbENXSiD4JoawcwSduIYieLTlso0/5gc4WHfHCLVmYoZZy8MBuubDEgngBWgyI2nG2zJVQEAP1iVAjn61SmnmDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F17Xf9aS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso21286415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761328676; x=1761933476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1HvYCNLV5CI0boyLI+MOBTwgyqBxpYEqfcX5SoAEoA=;
        b=F17Xf9aSnLvT04LtJ0LKU9uLAdbF2LPRegMpXDfFLbulXv1i3rpyAtjR9+wR+iPzsO
         VLQgIoArQQ1MBQLcSFwrLQ7JQ8oHIaoSeR4a8A0gZOYZUuC1NBwNv0YJe8KxWFNuKGH7
         eeWRW8KDdYNJMG8WCdyVdUzZsZveWsVRSNEs+7u22hiQtwJ+1bnEFJyIXwqQ2QNOi9k9
         5+gKSi7jEy58w8A+QCh1pkF8uIHAMQiJ4CJlTJK8m20N3bPubqPYS1qqLtHVr6WrDYqX
         uYMLf0SCgJaggjsSafFmfgXk+nLikBOOGbJQ1XhBzcbJe6WVfudKxBGpGX12at/EQZAt
         eIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328676; x=1761933476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1HvYCNLV5CI0boyLI+MOBTwgyqBxpYEqfcX5SoAEoA=;
        b=fJ4X8IPuc1jibDYxFgTE/5u/rbiMu8BCAZoL4pDWz2Z9sav6b8ne15TL+JSY/rWCl3
         rPNpv0o5qcq2SZCthoW4o2DjOx6Bde+AlSMSIjM814J0gQ0CcQmGXbqNbATlfx0v4y0Z
         fgtL1LoWfCY/PMHFnwBy8uaypv3+GRuE8/U3TRpuDEykDahZwGWKbnBoukbbtc7Ds76+
         V7OgjDrlfNPJxEEKrzIspYyCFVYK2+jFnKgFRt+Z3Rtl60IUJj7/n3wGx1XHZhp57z2b
         30OYapqv3UHiByJbzycczfUdEA8n61KsRKbWeoLq3v6JxKoVXqbMq6N3DNQER8pGHJc2
         wAYw==
X-Forwarded-Encrypted: i=1; AJvYcCWp8eIp+U6TVCbyMykPvdL/9XieTLFyh4rvrA1MjDj5CrQea0ZVsdg7RWVXFAuMRyxKMotNPVBzXn1/jm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiW9mxB5EZ4S+mlhc34A9jYQ4y18JokzjBr8qLVMeVnbHbs7m
	y0DZLohvixJhobLBP4G30Ry8boZeY3IDWOfW+xQKtLbamVeATN1HHtoKp3nywftda6Q=
X-Gm-Gg: ASbGncvAQBbUkiSXcvrtNHnWtxeqIPF6CRH15EPEuvzBuzC+2dLSSegOEhoGfyWRKAp
	VcujpqL7F3vq0RC/gj3Jdk8K8jP91TEmESCMeYiWIcLQ9OH6J65v6ScHaXKOgJE8VMd03xACYow
	i/vJ4aStlu26j6Sq+xl/UgC5yh4YxvjI7AvKVO5GTjZ5vH3r1WBRttGwd8qmbJHFDynaC2PxGjC
	1oM9Fo4kfb5T3Vbs5xTk/A9OJSPzEOA1WAQTN/nkQo9vPwpm4XJy6Za/5BUIbJu8Ebuj/n3b8as
	wkk0qz2jtuTb0uDaM18g7dCW6aWhQADPFnUDsGxqIsCClYtSyTUNIK3Az2Ct4lD5wgcDViu/k5Y
	N+rVp5qUJlOBpGLQ5TiQXfxvJn8LFtuVZswIINUs8JDk44eyaLlhUBvRDen1iSMjIjf4x9u1wnm
	wBLDfueMlM1nB7TtjkZCKdckXrsw3MG46nmA2Y/Po4mfkBm+z3XO3u
X-Google-Smtp-Source: AGHT+IE+5PmFi1We1tilKXscowMasxj24erK04eAcHqZVpBCNsemi8AXPZs34q0XanuKK/hwWTSoFQ==
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4711791dc89mr214479995e9.41.1761328676155;
        Fri, 24 Oct 2025 10:57:56 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cad4c81dsm104062465e9.0.2025.10.24.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:57:55 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 24 Oct 2025 17:57:35 +0000
Subject: [PATCH v3 2/2] arm64: dts: exynos: gs101: add TRNG node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-gs101-trng-v3-2-5d3403738f39@linaro.org>
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
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761328674; l=1126;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=raBiU2TNdnYW5GXBQGKlY34qsI95KKrr7UkG+dolrPs=;
 b=n8ttb4+2yhuOeX73uGYQwTvsumIUfL2WsqyJ9Prm3ZBf2zclOGKO4Uu6jkQke19TJjW5R1dqp
 D/80qq4n02cBz5QO5G2fQ9BjuhqxLSHVCZtf1wEDrPzpH1pJmHwJyCA
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


