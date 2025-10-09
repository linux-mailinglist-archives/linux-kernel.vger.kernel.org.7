Return-Path: <linux-kernel+bounces-847060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6750BC9C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B296353B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35E1F3BA2;
	Thu,  9 Oct 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXLgTyXI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC91F4631
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023514; cv=none; b=StSS4LcvbtdDcxhvbhbQo0R46o8o6gRniacoTbOJa9qy6RSBIFPQ2pigRbNrNn5AdUgne4wiOqtCRWrzt0egJRyV97VwUHaK1PNZYLnAfOix2DVum9TbfOYaKkpVgq8QENX4STSsMCzey3MskDX/Oz2yyHraV+uvLkQauN5/rPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023514; c=relaxed/simple;
	bh=i1nOHrUCe5k8EnZKJDt7L0OKYnEuaY/Gf2nz0HIUrG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWr9O2rkpGBTJG1kAHzTtl0YmW2XrNxwSDI9PTYApMtmYt94t0lwvvBMxnUCzmfUotw6vWGXhCvkCNZd5Oz66RykCGi/t2665gJRtXbejvnI0zyk/yrJOoRK3ZE7YIdzTnDiur1jHvpBvvhaV83CcP0rA9dldZsT4bhknBHRZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nXLgTyXI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4f323cf89bso194181166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023508; x=1760628308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpnrETzk7C6oZhvz4jEn6YRTv70n/RyEUTvN5Rj5ca4=;
        b=nXLgTyXIaewA1g87ifGGL5YXxWWTnpc0gkldBuM7oj8eEF0hA7sAhJ2wlPeWcOo4+q
         kf9k2a/lLT+f9prpx7JYOoxQ/zhATJhzK0r6n11TfjZ5QZi8u3Il86s8oQtTsbGfUA09
         G6ECoZlWLvmSmiDWV6isPcwz0CQgtgfTkGDa4oNQYe5Xw1IusAWYUA5hf6+t/hxNJPHj
         cyxRPj1RySgnlZ0gEm6E6zD/w9DWie/kK9WK3JmSht2nOvW514Uz4wGhxBGeHLOvVpYc
         kjlli18ZUNt8xv07FP9t5WTdUECd2qn04P48WH2TTvJQOGs19xcUBvSdaP9BwhmNYVg7
         SzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023508; x=1760628308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpnrETzk7C6oZhvz4jEn6YRTv70n/RyEUTvN5Rj5ca4=;
        b=V/eQNCB7i7enN56Y9AUjBtopWdgdTJJ2lI/pH4ZmIUzEih8C2WFS6x+z49lSbBFx6T
         1hmSABG1aXrRFDfGC5U7Yf7zqyUPkyvw0BrYmPdIUZaGKJx5mecj6N6SYMmlRGHUd6TK
         UTeWNhQ9Xl6UrBUWNSmmoR8rRoCI44qOlsnBxP7GuykAZ+znMkLm/xzwWJcHeXQJocRQ
         E8IHb8osSjYqMrxTsgtwznC+Q9wnse45zzg9AQW8M5au5qU3InO8sSvhZ91+L8GMOgew
         c6WcYNPRBkdNyOB587wUDaw0gOawgNF6ri1VfBIuauSUKdqIdsXrmYeNEZv2tOBnf1gv
         qj4g==
X-Forwarded-Encrypted: i=1; AJvYcCXw57JJf7nKT0GVH8+CtyfQNiASNhXJ0ik8hgFm/mVX1XSFoVxO3XNxqzEfgBK0jXRyKRUhEVlYIlgfe0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52vFWSiyHzn4gaWCCXBv/1XfA9/36nqlIdHD01Wt0SbHKJiap
	sfBW/4xwQanOanSAgQuhues+nH081T+sG+SzjNndAoWZT65PTOHKExxyBWdFxEgqD+g=
X-Gm-Gg: ASbGncuZa2CeAG/AG/uJpOkadKvj5JL/UFb92mIHE1xajIlkViKmLZp6MkVtW4M5Zgg
	7pvCPcBmuH8N4nuXDguMAgTAfLz2i1DIBL+vwUI4razEuhgBe9zO9pTO64IA3CEo/A8X3/6/T6W
	jC4rWeDjqOMq9Y7E2C6pnP69rOBQIgyXSJql6srGXyaC7qeUW6KMKESU6JkWsFZ8HLn4bjYb2GI
	LyF5JaBev1oJZU8hg451glNQmUIGPGaCiogm7aRMfr4XeAZ87iWw6ksv+c4wRORdIEDvdqepeoq
	e50PDStR1Gbca8kDSgcDBMtl4xMiKu9QxzaCKtHFsFng4xyngHUTasd4ptxVpieZIg/xbJsQ4YV
	/686ADt1ynNc7uKE3LaKFRBbkHQxI7qXfbtZaP2BR7L1bZIXXZTbs5cgMB8cuO3n0J86KaFTw7z
	PzTaH1B5YGrFWysC8eCIJK8sF60g/szELhzrgh8ZWdSNiyaOvY8OY=
X-Google-Smtp-Source: AGHT+IFvQJQZp5hIxcQ/kGfkBnVxpXqrxsrxpjhwZEJjbYHGciKRJL502yUl2gppViGVoCmsbV0c/w==
X-Received: by 2002:a17:907:1c15:b0:b40:e46e:3e0d with SMTP id a640c23a62f3a-b50abfd6af4mr953221766b.46.1760023508552;
        Thu, 09 Oct 2025 08:25:08 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:08 +0100
Subject: [PATCH v2 06/10] pmdomain: samsung: convert to
 regmap_read_poll_timeout()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-6-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Replace the open-coded PD status polling with
regmap_read_poll_timeout(). This change simplifies the code without
altering functionality.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 29 ++++++++--------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 383126245811cb8e4dbae3b99ced3f06d3093f35..431548ad9a7e40c0a77ac6672081b600c90ddd4e 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pm_domain.h>
-#include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -35,7 +34,8 @@ struct exynos_pm_domain {
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
-	u32 timeout, pwr;
+	unsigned int val;
+	u32 pwr;
 	int err;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
@@ -45,25 +45,12 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	if (err)
 		return err;
 
-	/* Wait max 1ms */
-	timeout = 10;
-	while (timeout-- > 0) {
-		unsigned int val;
-
-		err = regmap_read(pd->regmap, 0x4, &val);
-		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
-			cpu_relax();
-			usleep_range(80, 100);
-			continue;
-		}
-
-		return 0;
-	}
-
-	if (!err)
-		err = -ETIMEDOUT;
-	pr_err("Power domain %s %sable failed: %d\n", domain->name,
-	       power_on ? "en" : "dis", err);
+	err = regmap_read_poll_timeout(pd->regmap, 0x4, val,
+				       (val & pd->local_pwr_cfg) == pwr,
+				       100, 1 * USEC_PER_MSEC);
+	if (err)
+		pr_err("Power domain %s %sable failed: %d (%#.2x)\n",
+		       domain->name, power_on ? "en" : "dis", err, val);
 
 	return err;
 }

-- 
2.51.0.710.ga91ca5db03-goog


