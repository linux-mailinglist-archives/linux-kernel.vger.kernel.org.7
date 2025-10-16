Return-Path: <linux-kernel+bounces-856530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB79BE46AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B94FE477
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D2636CDF0;
	Thu, 16 Oct 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9jtNcTL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F223570D4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630335; cv=none; b=Jfo5xDi627lxAY94ri7SU0jDbdVusB6WEj67XaRYDoWYp5IqAMtgKxb0ooMX5i2o5f9eI+ale1mR/22DQotlYen/8ALOwx04U2Usp4LwukJA06FbPX/XKZVyw7LEpeJ3XGZNpsxYuCCPXvtMaGXHidqcEACAPUopZ8DWRuFJZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630335; c=relaxed/simple;
	bh=Fd87VBZVE3t1XdL1M5TOtbrUL4Nhx964dcSf7oJuDP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPdoG6trv00yljpCVtH4fjEOQDVaZW8+yRBOtTAsWEYLJkTaBwossIi3ADiXKWW9MJHzAp3thWHB0tIJ/VRU4lys7UMbn2UaDILJLZzz8lQt41Fi0QvYS/CKAJwnKR4TTA6Z2+MlBwGbIovMS4+1iqoG1x5kI+cDbf+G7LptUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9jtNcTL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5e19810703so130590566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630330; x=1761235130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AiSVlBoay/rNWhpOjfQNUl48vUimN757HYzsRqcO8g=;
        b=E9jtNcTL5i6nXZlZBpthxHD82L00je5KuS30VK1q5zhnIgOaWAy3McYEu/E30AFurv
         cEr2NneCko5gz7hQavD9ZAzwvxThQoD9VeEVZCmBgsW7HH1W+cuevnUlzV1s0hCbCBQ7
         M+vNPgPPwwyLfHUCI4unNyCRvtmqbDygQKtlgf+Yf/gumu8OfzhIOY9eRdjmAl2ceTho
         OqwcbSTrF8whvvgGs5wEHFMEpbA1C0Q/0yDLS4Pdz6COyQLkOxzpaK48sxlnZITjE9ak
         C8y5ftN9EQeG7hW/7WFHMTc6NajFDwvJdQeLR1t+DrCd/77dAT36WdxL0DYsbWjbcY/u
         0DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630330; x=1761235130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AiSVlBoay/rNWhpOjfQNUl48vUimN757HYzsRqcO8g=;
        b=blhpAieX0sXfc2Bsd4p1Sdw8vFjnp8Mti8TdHEMkBWAF5V2Yie7jZ935p6/M4qs2Uk
         QO36bJ61jBu7vXhlBHdwEeNYVV9EkPLCbUujgsyfqRgIiF5pMwODDCMyNgn53eHSIZ2G
         +FWCodzw10TA/y60LaS+Mg+EaTYLE+Ye+9kPtAJDVQLMCe72DG/DgSnBfgEPkfbKgX4N
         pvyY4eoArvUyaIpf15iLBHUGuRfBB4Pd8xxE/ruWP8l25I1IydHwuw8aJvrzh/VHqMA0
         qnOr3g0YsilrLgCyXuAxzZRXQF1KmQfr30c7FevGoWJ87c+73XrvunWdl0ZNfvxRJL9E
         qEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+kaNFHmsLDV04j7TKSu0vCziaKrtS/n6syJ6RA3+rx/mf6CujJmk0a1VVl+9kwRML++/M2bs4G096RHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvlC/KK1GbripZbvPgsXWhkoOYbbBUFCuqjIvE+idRlvCe6ESy
	sx4HsByp5h5LdoWY36WdXPn8WvobzeM2gLyVO25USVLNsSCwq68p+bRWr6cDEBUGG7E=
X-Gm-Gg: ASbGnctMndhM3+nX4raJjYDoEZzzt65ao8gEwKn0E7I75tuWRTYXvARY9wsPcQ3cOjM
	d/5gGRZKLV1WrSRcjiQDeaBURgEVGdkPkeDEvtKSsr1MghgdSnATWmYIvACvNuOs9Nt4lI+IQ6T
	Vzl7pM6edUFEVitnWOz1H6HPtMHyjNoE/5+HZJ1w8DhFGCKt81cGDZL/bz+MX8QCrN1lUP5Z+jr
	yJpNM8uFCjjVtuYIfm+XM5MvNALkv69DFecg3OAY2I9Byn02QGq2r7gYQ2TIdspno5vv0QdHd1V
	6i65C+J0d1gvR6FftylSteEgUhzF7q2MJ5EaF96aSpiGnc/hkBHd6fzx9TLmQ7gza7L1l6orBJ5
	zb0u+dfTtGnh8yWXsvf+H1lycDRB5osjbzXOOwJmCB21JLmUbjK0lciRuYQnO66TCx4266ckCnc
	AjXhgVWYsFtYhqRkn7/mbGUr5HCygCO5giM8JRvtKc8tjvLMKAlU/ApzqjHh9V
X-Google-Smtp-Source: AGHT+IGPO+2Zewf0zB4l3rydvFCKk2iYa8qO/BfCMfzqYngcvlnWd8aJbjMUPzhsP0bqvo/AOWVLUg==
X-Received: by 2002:a17:907:728d:b0:b3f:f6d:1daa with SMTP id a640c23a62f3a-b647443cf06mr45875966b.37.1760630330042;
        Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:40 +0100
Subject: [PATCH v3 07/10] pmdomain: samsung: don't hardcode offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-7-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
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

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
(syscon) regmap created by the PMU driver instead.

When such a regmap is used it will cover the complete PMU memory region
rather than individual power domains. This means the register offsets
for the configuration and status registers will have to take the power
domain offsets into account, rather than unconditionally hardcoding 0
and 4 respectively.

Update the code to allow that.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 431548ad9a7e40c0a77ac6672081b600c90ddd4e..638d286b57f716140b2401092415644a6805870e 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -29,6 +29,8 @@ struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
+	u32 configuration_reg;
+	u32 status_reg;
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -41,11 +43,11 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	err = regmap_write(pd->regmap, 0, pwr);
+	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err)
 		return err;
 
-	err = regmap_read_poll_timeout(pd->regmap, 0x4, val,
+	err = regmap_read_poll_timeout(pd->regmap, pd->status_reg, val,
 				       (val & pd->local_pwr_cfg) == pwr,
 				       100, 1 * USEC_PER_MSEC);
 	if (err)
@@ -146,8 +148,10 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
+	pd->configuration_reg += 0;
+	pd->status_reg += 4;
 
-	ret = regmap_read(pd->regmap, 0x4, &val);
+	ret = regmap_read(pd->regmap, pd->status_reg, &val);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read status");
 

-- 
2.51.0.788.g6d19910ace-goog


