Return-Path: <linux-kernel+bounces-856529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C89BE46A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 359255090C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54E36CDEF;
	Thu, 16 Oct 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIY0wBqE"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753F3570C0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630334; cv=none; b=ldubJpxeQeTBS82oJC7qpN0BpE9PpVaTKMaxTiBe1S2gW6NpdnNXddWQ2/kHSpsAtaU3Sc52HSfXSVaxAJV5YN4NxKU8Hlnaq3IvSTXfdGVfaoTK1feN2i1oLX4xrBn9p+tkDIsyWogpXSq+1MIvTVWP/VuLoJvCzsgA45SX1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630334; c=relaxed/simple;
	bh=EEsquKkEeBg70sExu6NBhMPgtI1d6LaAxzWYM2RtBsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lc3pQNCX7ujQyXuKAGuoZV4yz45Ap2QL3b3h59S2bskMGFa9ogybJ5VKKgyzFYDdhBa6SemEWhgfbzZbhsxr4SFB5rkDTNUDkqrwc6AOVnJCU8DnYRmtKiR3cnw+66F1122OHZKiNgThJab78039nWm3M9bccaKAJTwHqUXxK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HIY0wBqE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b5c18993b73so151415166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630329; x=1761235129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsw3nGMrSykhH7OS6v0fNa6J+UTT3lDdTIT4s5cDl2M=;
        b=HIY0wBqEwwRpQUgPqCzQh4gHbZg4aYsoFSsZkUzYjWH04UnkSLfywIWMsLYmDesh5e
         8xbx7RQFO+WVuQlEqnRRFQPahOPDdWlMbG6yi4IB0D9ZvK3pa+3uWxSRT67N6lg+/jud
         ypfj2ydOIjT52WdlFxb/NpRy4g9214Xo+Hvo7c9m9MurHMrJLz52Fl272vo2lkJ4psgO
         g4RGBg16rotTu9xXByMMn7W7fKl2uZpaFHdYOPsdJEaDL1t3AkDlpXHAxZnehzqh4Ap4
         9WxwnURT2q6z77rn17Dgjvp8t4XgSfgMahcGz1mUSdbej1nCIjkiWghii6m1SXWp7O9Y
         sk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630329; x=1761235129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsw3nGMrSykhH7OS6v0fNa6J+UTT3lDdTIT4s5cDl2M=;
        b=LVa7UFUrcHLYmpkd3KUC71RW8HEN/7OQcs/Trbovlp8XfLImQj/R/MXZd9YA0jq9jY
         w2bZXKcNWXMbmmzWQQNmBAm7t3o9xoCfVZBKfq6we5n4aNo5yfuuHVSmv8zdchfmlLJX
         l81h047c7/bexOuNcp8OTxN8QVqquIgkCHvwTeoeLLxzbNvWvK0oXr+gyerY8sAmkj9o
         TeRW7eEi0IN6FN42uXOrHtAw+3/LFHZYDFoQgvWUcO3VgbMRNWKLDFAQKQ+WQ96HAVnG
         v9fbr6R2vPRvMVuUKTiNbNXQk4ZaV+SoEleT574A1OmYk5Gkim2eLSc0gsRUmdxxw3CG
         NL3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDnM3IpsR7/EQIaFSu+mRPSX7RSS2UsEQGvv5X8MdgbEjj0XHNaCJR7X2zAjeIo4m3bo41aProYEOGLS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIYVf6cxpWxVOoBVXm8y5TS5bnrodxvB91oM3bHuzGIDBiomPO
	MNZiGBZKVnIHstVNGCf3uzU43yZNMVxxADDFqZVzBMkdLPGB+cS646pDJZhbjL6x98M=
X-Gm-Gg: ASbGnct5UqA348MdqBp8NbFJd+2dhJLuCPPg929e1Qzhoz5bqFSF2mwt7oZZc/kqQay
	eylI2roWLCtqrFiNX4zivj8EttlCK+YIHrA9Evwr8/XjsZiJGlks8dq+PqohbNHr/NpxuEXrKuQ
	PAA1I9CIaTW+mqO0yBjW3BKR9065X1/Lqg/ANE2pIE0V5RyJQvBTU6M6UAtaZkpmTNJ1PmUUmXa
	449ilkMXxH4AfR1utFFlTciMXNsD/bVIPNOfVojQKVCDcCt8zDW26FVjK8OEIFoP59mEjtetXSq
	EQNDlTPuWQ0jsaj1CfFFZ7vfhI2BqmDnbKOZwc3VWYzq34UZWbezqs0AEXNymxXPjaXhYObp3nY
	Bfgix/TTcubiGRfeKRLWMSbNaeTGZn9Dk9SzoXFI6kV8fMyjIQkA60+TenY6PmodAqoR/MiX/Fp
	g1Rw6/m5XHY5in670CXPvbmPd4ENtn4WQsms2AgmI44PW1TKjPmM9r/00eK66MYckZBMhSdiE=
X-Google-Smtp-Source: AGHT+IGMnDfjfOzAoSs5yqEhzRvyTEgvB4V8vlEt+WcTbrwh6jjeesT23Hol4E5oowOHUJe3KnWaFA==
X-Received: by 2002:a17:907:1b21:b0:b3f:c562:fae9 with SMTP id a640c23a62f3a-b6475703a96mr48316366b.53.1760630325277;
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:37 +0100
Subject: [PATCH v3 04/10] pmdomain: samsung: plug potential memleak during
 probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

of_genpd_add_provider_simple() could fail, in which case this code
leaks the domain name, pd->pd.name.

Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
simplify existing error handling.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
mark as fix, as this isn't a pure simplification
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5d478bb37ad68afc7aed7c6ae19b5fefc94a9035..f53e1bd2479807988f969774b4b7b4c5739c1aba 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{ },
 };
 
-static const char *exynos_get_domain_name(struct device_node *node)
+static const char *exynos_get_domain_name(struct device *dev,
+					  struct device_node *node)
 {
 	const char *name;
 
 	if (of_property_read_string(node, "label", &name) < 0)
 		name = kbasename(node->full_name);
-	return kstrdup_const(name, GFP_KERNEL);
+	return devm_kstrdup_const(dev, name, GFP_KERNEL);
 }
 
 static int exynos_pd_probe(struct platform_device *pdev)
@@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
-	pd->pd.name = exynos_get_domain_name(np);
+	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;
 
 	pd->base = of_iomap(np, 0);
-	if (!pd->base) {
-		kfree_const(pd->pd.name);
+	if (!pd->base)
 		return -ENODEV;
-	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;

-- 
2.51.0.788.g6d19910ace-goog


