Return-Path: <linux-kernel+bounces-843235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF1BBEB77
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00DE4EF814
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69B92E0919;
	Mon,  6 Oct 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFEHqKBd"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C62DE719
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769015; cv=none; b=ePs3IPDvVhGnK5mcX06FodNak6Yyu7Zhy6RS8Q7iC+2pA203F3mGz8bRDdfQHj/eys19iFHoW9EJK4u18BQoFfqwMuMc84vYaYlJp5ex0OCXkPHzJNStAy/lMQhiSUjER8wBgtWqehjBnIZw3PdAv9ETFl6G2m0Netgz4jhNlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769015; c=relaxed/simple;
	bh=geIKgWF2ALweoM3YZgXz0Zorhb0jTxVcchCl54bV0Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyxiyBfG5LuKUieIngI4aHfeh3yUfJ4DrOUbVD++yQkAjIoIrQCHTrqE9EGsEVk5RnRSEV4XcPRuCAVCLt1eYtzkh55jjP2ZjADwvoQ6chtN878tM2zJiN/71W0lRsCvwRw3ss79NcEa3+JFidNk4TvJCKh4dy8pMdJgmHwGfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFEHqKBd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so867574666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769011; x=1760373811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxwnlAP3n5M7cyJiouK6nx2qCN8Hw+Sbnl76f2YXigk=;
        b=wFEHqKBdBeQ2ei8jpQHWd7l6Tm/e7UCOh5/su4FIFADv9zrzduqO4UJQ3Cx5yX4K9A
         klcDvD6QWcrLTQGJvrIay1XWz3nJ4GKsC8xHIangXHXKcpmBFKD5ytX65mXaGD15yTl7
         +e0SoNE4SuBDUHin48IYvlwrti9QYXrGSrCHrxnvmKnObFuWB19st0oDeD9PQubGOLn0
         IdPdnvo+xS+qMhRu2/6vo2In9CFADENDaII3X2OjBvSvfPBzUD7uwv14MlS4Lwdi8/jX
         DZJ7EUbB4WuldhwMVvL+TkfCkh9YCxqBMXwhmOjU1+qcWKxhCogEPo/7K2tdyHG1ZHXf
         j5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769011; x=1760373811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxwnlAP3n5M7cyJiouK6nx2qCN8Hw+Sbnl76f2YXigk=;
        b=MDITyfjOWTaxqoDo6sfKR3fd2uw71vS+KNfc7lZc4oiRePiJPZ/GlbTPTEM9x4Xv3M
         gkJ2SztD2HUh3hdAgq7yC+E8ebNqzacgr5GZlfR7GZ1HUaHZ2CqpA06V8aEVZiwE/azH
         AtqR8PyUW+qNz8FwJmQi2ZPOV1z2q3fuwB2dpcfFSpr8CSl6bQnqbxzUQQLyJZVEVvCD
         7rC4F/6WDYY4lWbM0/AiQ4NyhQ08Qr3vpJN8jJaZxhblWB+c8BtL8DhfLVfmbb7a3feN
         e0feQvZsrn+wIZ0dFZP4cccrmXIwJLtwWPt62BjWnHioxf2DBwyK6VCaz4Fel+n12ly+
         77qw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jLLZRkHOF9duEJbqs06uWVRaC+yqkPT4d4cQz0qpURUAnxWQWkoxle1Y44Vyj4ugwNfceqxCv2WKKXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kDuE6FWSiedGui/QL9CySAt53XOVOoK2OSElgZMoQ5zwfmdZ
	XHqyTOC0+MvNlHZzpk9W+4VVuIw5C/vyVsf64x7hdoXg33oWOGi1nmmKCvyW/uXh3lE=
X-Gm-Gg: ASbGncvSZgVGF6j/pvFb9U/GJQvCWMwxLF86BEfj/jpAzwjigxl+TND3KcvHUKemIzG
	JQ3qBf0xQCdXFA5uE/gToAMUmWneqIpkUCtFK6Piw0HhSaxzM8wqLWokyTIsq1CVIEQYb4ADqOI
	42kq9SZBVn5EdbcP/LLfV+K4NQuLdx4ohMasry27EsbGsh1AnTZdM6w5zleo6PRutE2HzXY7Ed/
	JtIOsnyywJF5GFcv6xlSa+N+4zgNEUF+oxDpY1d7sAfhPqTBznChKsPVXRCwt+60VKisYXUHoLB
	JeDf4pxZH23wGwYaQfTBm2aXzdmUfIlokxJvmTPeA2jpLR5Nc2Y92as7NkKaQnYS7LlX8pAAM6n
	5Zn0s2Br4e+e8xWgVKlmsIK298X7AmzKl0rl1R7rWnaZfAjoRqr8siRJTgXBEKb+2fAahJ+vNu1
	/cxOzcTZK+iQT8BXYgB8jKEIkwk3q1UKO/r9NfHlix
X-Google-Smtp-Source: AGHT+IE6Qi3Ngqwo98RrZzSI9Sk/ybN3uGg/1PQQF+EI33WkQU1ToLbh1rIvJ4g1vAv9PRSJV5XHUQ==
X-Received: by 2002:a17:906:c108:b0:b45:66f6:6a17 with SMTP id a640c23a62f3a-b49c429cf5emr1502411466b.45.1759769011299;
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:32 +0100
Subject: [PATCH 06/10] pmdomain: samsung: don't hardcode offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-6-f0cb0c01ea7b@linaro.org>
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
2.51.0.618.g983fd99d29-goog


