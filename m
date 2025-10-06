Return-Path: <linux-kernel+bounces-843237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9B8BBEB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A969F189613F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C72DE70E;
	Mon,  6 Oct 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDDj6WTE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2F2DEA70
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=rOk6XkfbfbvjKgXZy+mI1XIcauo04XZHTHQ9TzFTfuyIulCVgO33SkuWdN6Npht47u5WhNbHnJtqRAKriUYzpwa9pUiinUYttrikF0KT4+yogcjW3FpvSPQGOOc+GkCerC7HLaUUBOlyhZg1blDTdnvQHihCbS+14l1wHQRQdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=lQFRfvIZm2QIrTnGZIlapJJgk3a/yMVJrj+Qv49vZDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RY6vbVEpcM001OkqJtdtM0xBSONzgyI0N6b7OUxmakWZ6MlcKdVl5neQ3QgZw63rGpo7sqOaMrdksPrrMZAIGG6vFJ2nHtZHeDUa48LlRmMRUDhI7j5uIlqhp7hlRorJp4mbZ6zh+MJX6R6JYyKSSOWzVtaAAA45dfu1akghCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDDj6WTE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b00a9989633so671101366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769012; x=1760373812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0ZdGtbeD0twmfxFXcR2wb4AL4tjk6OMYa00kx/YCo4=;
        b=bDDj6WTEUFAoTklqJxVyDFsSrH4c+YN3JvKDUER3xlvL5UmJaTyfGwZX8NDgkpsiWx
         4327LWkeZOszgVNWFiriEPxcmMp/vPygim+aDK/yxc+IJjy/2B5T068WC6CtcGZWk6Nh
         Wou9zwNO5IFbdkTMzJN47xuKCwM+RXub76teAKKn+SJrvtUud7TRqiJhcFgJaEkvSqQ7
         zKLiVl0jRoNTUuLU7N8MHhrEE0Og6VEDAVAmNY7GifQiFCVVZCMjz4VvCbxqNGwKtj/i
         l2RWah3LIWmC27du6gLgY5I1ttGf0SU1QUtNZg9OTxNllQyehnDER81MWs5kV4Ao5gwU
         T5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769012; x=1760373812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0ZdGtbeD0twmfxFXcR2wb4AL4tjk6OMYa00kx/YCo4=;
        b=m1qLOTuJ7hF0HwMhs0yyBVtdVgQ16fB908EF7fq6xwQG31Oj78Yp5YMlluTIEq/oLa
         9YCYENBDI5PPHyp2Nrnm/icsERmZBqO380Om6BMuyWkEJI7TouJj0p/++zaBI79AKqmz
         WjkreVZmJ0rHLrKZ0qIsc87WQf6bikDUKdAHmu0sRDqUJF6iu1Q1LYcKqjgiZ6bwgpub
         KEK7pNTiv28eQ3KoS5aLxqcjkood/xr0idmIs3baAyrdcKrvuCYaDUUC7FwfcoGBMh8L
         V4yI4sVlvyC9/8+hR81BpiJ7FYLv/+rM7+ZpQL8GFQJn1gRzj/xUM04KDMCm3+b8HIVT
         /N5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzCYPziDnNhmtcOYmyMWrT2kDhoopzBmBmqRUjkOqQll4tmEjCGUbNoXKTGDu1aK852WmN795jYIZopfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3bmt3lYluMzCsXqP0U82ZteiTNBPcFJi+yWjSWVvALpkq4fk
	zVZIk2K6zQVDk/Ds+Czy3jKqTu9D0J5324V6sA0Vmf8DRdxWp3d5d52psafxcEKDwAs=
X-Gm-Gg: ASbGncuuilr1HvdcHMzw18CFKh7imhPJPCU1elK3DJUehdW1/xQlrBFv/4H62H4RoDs
	G+1WA4IGCljJa8BomMJEkv2upyeOXdQmezo7M2+CmH8+Qd7+Z89JefNR7OaO/t2tcGbKskJegr8
	OAktY6inlzLR88z5Qf9ERBdpCt4GCjYml8QrfetuXrqgspGBBoBAPd2jVU9c1pIHJqwcjzYna6X
	d9/AurhKyBzstyy5x5C2SPc1J/q7d4LnDJj/QXcf6bSsBZfqjmNmL0NGXYWeanwLx+u6KuIMrAY
	nj8LMw9RONUUNTheCy+OMkaSiviGiWho155MJogWbvELC48/2e261USKHPv7mApF5Sta3EraFkU
	8nFghyPH2tY8QuAA1kcuAYrRZqPaBQYuOsua8U9CdpEKHepvCqGVJQerFxrn1gr23iE3c4r7HDX
	uDriCZtUkr8+7X/67XFBt3pQXGsXWXs6FdtvpfCHLCqzbNXPM9eGQ=
X-Google-Smtp-Source: AGHT+IEYfOZF1TQm9DGlW5kpM0S9/tKDSRvPCFa/7dsa/gaWYvJTuZDOfU68MoruhNwe6zCqc77lsg==
X-Received: by 2002:a17:907:a710:b0:b27:edf1:f638 with SMTP id a640c23a62f3a-b4f43106a07mr28397966b.23.1759769011758;
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:33 +0100
Subject: [PATCH 07/10] pmdomain: samsung: selectively handle enforced
 sync_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-7-f0cb0c01ea7b@linaro.org>
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

Unconditionally calling of_genpd_sync_state() causes issues on
platforms with child domains as the parent domain will be turned off
before the child domain was even registered during boot.

This in particular is an issue for the upcoming Google gs101 support -
all operations on child domains registered after the parent domain
misbehave.

Add a flag to the probe data to be able to sync_state conditionally
only, and enable that flag on the two platforms currently supported by
this driver.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 638d286b57f716140b2401092415644a6805870e..5a87802cff394945cb0202d08f2cf6bcbbcc774d 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -20,6 +20,7 @@
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+	unsigned int need_early_sync_state:1;
 };
 
 /*
@@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 
 static const struct exynos_pm_domain_config exynos4210_cfg = {
 	.local_pwr_cfg		= 0x7,
+	.need_early_sync_state	= true,
 };
 
 static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.local_pwr_cfg		= 0xf,
+	.need_early_sync_state	= true,
 };
 
 static const struct of_device_id exynos_pm_domain_of_match[] = {
@@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	 * reset during boot. As a temporary hack to manage this, let's enforce
 	 * a sync_state.
 	 */
-	if (!ret)
+	if (pm_domain_cfg->need_early_sync_state && !ret)
 		of_genpd_sync_state(np);
 
 	pm_runtime_enable(dev);

-- 
2.51.0.618.g983fd99d29-goog


