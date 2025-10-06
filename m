Return-Path: <linux-kernel+bounces-843233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26562BBEB53
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85CF1895A16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45D2DF6F5;
	Mon,  6 Oct 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmDDOGB7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F032DE70C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769015; cv=none; b=FbhplzjzRLW49g8MFlZ1Nx8kMCZqJgcEdF5BofYrfBbyB1lS6bSsyWrDFErFB8mwZXXyhixXyXQZz5slqYBzqXUrg8F9dc/nlRK6JTsClDrp1E5feIv3kqhNk0rH6btZvFr528NKpdK+6ey7ZQ7jxuLTqclYRKjuovzeOlgOCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769015; c=relaxed/simple;
	bh=F1uL+g8fHIdluDJ17bb7cBAahVnwEqXe7c0YoRzXMUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkGGRW7QKTG+5N7QK1hRUnrdnzyWQnzYwnNNR3s4CGqAuqVvFIk9cuNRSdVDQGf96Br+V2axScP+YfdxOVYv9Xmw88dXNAk0LBZnkLYVcHBj6fYucuebehfEX8kgtYoIn9VDnAqd8BEtLAuK51Zd/aGs+IopoUBWMIka5fGQ5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LmDDOGB7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b463f986f80so743214566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769011; x=1760373811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WkKVU8kwH4FiIJkp0DFrv47tH1tikibDwgyehQFExE=;
        b=LmDDOGB7GKg+D5zNzk161J9w9e0PqNDyaEI9HNsDaljwYGSIu6cV4nHwu98Ln2/Z3w
         XG4+PxnxnexQ77blutt7xbk22BBL0I/8Z1CuUVfPODz8W8UF1VLd3sIZWNN4AAERbwFL
         qbozblaHYi/bVMEOz+rSlHolH/zKLgCsczCHpTDU6amCHbFw1UUeaZ8QPxPCrpw6zuAy
         xdTqIdQJJtsubFhcFt6cV4PwNn+RUdJyNqGUYUL2iPdLXEC8wPYQK50cKd2ctxtgwzXn
         IaEYNq2Oz8j06aKQDmRL81I3ia17NUgOhPQLcORYjj/9c3/8P7Au5X7wPGsHpvM9vMtC
         ldNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769011; x=1760373811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WkKVU8kwH4FiIJkp0DFrv47tH1tikibDwgyehQFExE=;
        b=Up7NsNDJcgkuuftLW05DrrRLNedoXTpNcXm+QPCFVjPCZHfcajfs+LMYrmHpKc2lue
         PfozTO472okml5Wanz/PJjSrHIz8TzwgJsMCbYbBWwnU9UXSgTDQcvKwvLbQFDn52KoT
         vYTBcRTeesGLERzjFcXHFifAIUHFbXl5fpL8asXblvqkmQWUhuZeDmJoN1rHleCeOQjk
         TRKezs3hmdnK2rLNdaQIR/COhWf0Ch89I50O2MjDf9KTFLesiJu38Emn9WDnBwho/7tq
         /bPla9Zudb2zrazhnGQGUdSaH/iyidzix3A82tW17s0+f/tVE2Pa9obZiHJwNhZ00evQ
         CGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkBruinCBWJcUniC5BxIytIE2aXCfxMZw47pWVaZXHsaGVtOPTklGhi93TVelQVnuYHIErbRbPuxIQNvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/u7juTaT9UWjabia+Kt0ut7Fr0buHCmCGiBO529U773Zr6UO
	6nqmaZaunHlwzIsg3ItICgopHica+YT6/96MIy1pttH8weFYtQfsOumsg5nPc8V6zEI=
X-Gm-Gg: ASbGncsnUQWejhZwRDIr3/p+RzFCspuGiN+qbviQ4guBMskwHDOieCW8hSdyZ0QMyVB
	NN5aCvfyaVs+ZZ/UOkMrwiJF7+nWUyq7Kwi0D9bEMXkjHm9LciWAgX3xvB06RbmcmB5T8HkkmO2
	45fLpbQkaSeS/WOxfEaRd8fv71jUd2cjHaAFCUzMZG17RqhxYAVkqA3K3txFON+DVhfdZqq/zf5
	U6yqUeKo0Dzv7u0mMDD98SXIvxmI6LVqxE9RGOgWenb7/5TDZW7A7nV4mUkf3WliU+VyxavwUSK
	UsxnyULVOFm94qi+6m0sinVp/WPtlXMJoQvnKKp0G2r+cUHszCzLUnwAOgQz+GAPABXXISWk/4g
	l4OP0vlyN4D/KDaMcAq4WOiKJ7eQIE6KjBcyvQR4beW+EVKXv8U+50vQQFyBtRt1+XApCTzhD4a
	FHctws4wsbrxq6aqBE4o4CM6BRbBwez1qj448DjB1huVqLeROF1g4=
X-Google-Smtp-Source: AGHT+IEG8W4Fgu15EAWixutgpzICMiJaZUNK8COlNrHcpfllaPfZ5W35myiVDFya7fewpU3c0gC6vw==
X-Received: by 2002:a17:907:2da6:b0:b2b:59b5:ae38 with SMTP id a640c23a62f3a-b49c2761ad2mr1799899866b.40.1759769010845;
        Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:31 +0100
Subject: [PATCH 05/10] pmdomain: samsung: convert to
 regmap_read_poll_timeout()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-5-f0cb0c01ea7b@linaro.org>
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
2.51.0.618.g983fd99d29-goog


