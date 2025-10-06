Return-Path: <linux-kernel+bounces-843239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816FABBEB86
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7576318983FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB52E0B58;
	Mon,  6 Oct 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRiEdQXS"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428662DF129
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=oCoijFTdxeNJR4f10Kt6cFnBOs0AC/MuvkVG1DqIcHFLipW6ubsWCM1G+vGey5yIyB6ci9ww7ilBlCpWWPvmtp6ajnMykMciMtl/rDLlFcoCTaZ8MGa8Hyf+VA7C24uciSF3irKU/kNklMvRRg7mgy7vxzRygirGsWXhHue/I5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=WRwzPyOkvSFyJq+EK+JnNwxrggXXpznQVjTj0iqWREM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXZVZOFbNsftsXKv9PDuK/Axhn4y87l3im1Jx8+oJeyzk9OpMXmFeIKLVOyJG0ynQsOMzqVggJyDr9oTSBNtS6gSmyFg+Rx/LTWiSlZbIAaG1ZDveS2jGTySdZKxs0HddiFcMSMH4n2up9GZS8iLWk0kCs2/vZXJIUsPbW8kZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRiEdQXS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1067507566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769013; x=1760373813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioPTwS2f0Ag/7Xgv7v9kcfqmqd+rCK/VtVviQkcgWcs=;
        b=zRiEdQXSknS7fB2cddTuE5q9MzVvGJwUp/JOTgXRQUoXa+vg3b8sTWlvoiZGlA9IKQ
         JGNxx+G4nTEpWdG23yVi5wtsv2J3uOS9U4TL+0RWW6dgcB66wFoXZf4rzJrTO+0EX8pz
         ejY5AN52URLHsLhxKT7hMkzc8/AadDO6pd4Lb9p/bpFGIqGLYYUR+FKmJAd+iK/VhXkA
         Y39vCGliEI7MnVjnpq/p65XmoI+CKUlRtkdwvSKQ52tsyJYEA1HFT7xR1RHePXonj2+l
         61NlnT1PRMr99HsFQzmd8DPO50VJgezn6ayjLNycASWa+HZqyQoAjPDxcSR05J3lLkpr
         6xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769013; x=1760373813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioPTwS2f0Ag/7Xgv7v9kcfqmqd+rCK/VtVviQkcgWcs=;
        b=oX74WhCJwsfNmSTN3jvKnqK9RO8pabF3guc9TxMDJXYQ0Jbz/5yYRCBkISJ53uZhBO
         wPvpU+wYGRIMpXbwh1yBok9vVINhT3aX7zpPjpMS/leorX0QExu3LUJeSnY/GW7GT1JL
         kPuLFNfQUeTeioOxWiFJd5j6LgFiSTTCF55SiCZFnFe/2RyyZJJZY/CiBZhV2tR/kDn0
         5U2s31ziTFKF7RkgwYqWtWbxyzHL5Q3EEJg1NpCxLroQmuZrmWB9fo4VzF1NVLg851tj
         YoS3trzNAMZpLaYnB1KTQW8Mhw8ckL7VkeveFMYIp+ChL89KmbmJR41cv/hPaBwcqWWM
         EiKw==
X-Forwarded-Encrypted: i=1; AJvYcCUx2Lkbi7qiKj0iFluy1r9Mr4nHb38RkXdq+nnZT16LZzY25MLij7dTkcerli1HsJ4nY7SgBEF/5ZTrWqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBpMyx61B9wP6cDqialmtKgX+OqK2qyuiFId+Zut0mBAag5xi
	7tvVregFjPYMnPSJQ0bMo6QvDWPqWdcAwhjxpoDLIR9wgWPVbinvlMqEQV0foZ51DXI=
X-Gm-Gg: ASbGncvdZKhpYtogTksDuvDIcih8VLBj5fa+66/1gAPfp8B8lG5qyCSoNN4uiqUrnbg
	llTYKaY4rx4k95xKVO7SBsen/uDP+CjkabHNzxI0pTyDOCQHcKWFXmDe/NxmJaUNMpj6PzWiGdP
	wr1qKd3abp34AM4FhgOJhoiNNGpZGgxiY49yRwRLzkb1Wjn4d67NcgODIGrEf0kHxG5NwQELw/O
	JRvFgjxtxl/Inb5mBGnWxli8FHRk3SOn332ODrAnfI3J8S6WPHmcpBeA0zao0dDm2caiTT9fAhw
	oRfzruMKS47fyei4Ud6eJD3IQp+FvK7aPCZ4g4QVGbt/DH51qBv3PVNKRhoKdSKMB8d//fNSi3k
	FWHhDz1Zz5ITxDisgQ93OwSD+yn13IlUs2RlmBADefDe6bN/lIRvAEW//gJcXuQUWhKku7P29Vp
	8BkOJ235B4TnU6Xr3qVVqTB3JL+rQ2fUNGlcuHafH2dpcicK72bdI=
X-Google-Smtp-Source: AGHT+IE5SECCGzL2stnGeMyacolLo8BRZWSL0FXQl2+Uco37ci1RopzDCJHNu/u5f/tWpHXHwAHqpw==
X-Received: by 2002:a17:907:d90:b0:b3c:3c8e:1896 with SMTP id a640c23a62f3a-b49c47ad11bmr1593290866b.42.1759769013168;
        Mon, 06 Oct 2025 09:43:33 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:36 +0100
Subject: [PATCH 10/10] pmdomain: samsung: add support for google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-10-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Compared to other previous designs supported by this driver, the status
is just one bit. There is nothing unusual here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 06e1b0eaca18205a549c8e8136ee15279eb3089d..9e62da2162884fbc1f4b3809cdd89181fb534095 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -81,8 +81,15 @@ static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.need_early_sync_state	= true,
 };
 
+static const struct exynos_pm_domain_config gs101_cfg = {
+	.local_pwr_cfg		= BIT(0),
+};
+
 static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{
+		.compatible = "google,gs101-pd",
+		.data = &gs101_cfg,
+	}, {
 		.compatible = "samsung,exynos4210-pd",
 		.data = &exynos4210_cfg,
 	}, {

-- 
2.51.0.618.g983fd99d29-goog


