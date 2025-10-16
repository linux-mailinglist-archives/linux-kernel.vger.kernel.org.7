Return-Path: <linux-kernel+bounces-856532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84FBE4682
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5913E585B37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B536CE03;
	Thu, 16 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRRtTiNt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C672DF12D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630335; cv=none; b=q7fH6CbDTUgy7HhY3mRxngCzllJYV4sdYEpHWFEdcujRM6mtM5S/XB82UGqxOegi4r/n57BBVCs8I329doTwRRCUTIhBLKi07muHyHg2M/uE2AI55AF4x8JL5bKS+WvkaBpnRFDUIu6Li77Gx9omQVJh8I1TfvNs0rfp1n0JVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630335; c=relaxed/simple;
	bh=1qxgK+yguVHCcnwDi73qQ+fgj7/mfA7XkqtibLKJhdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fR+b9m/0CnlMCKiDX69NiPvQHrItS9T8/n/sbYfx7Iyj0KoTncsOnwcNb1mrP/A6R76nHK9j0otyYpBv7r13vkP8zOvl9mVMwRVtHJJuuzvS/trAmKXYdv5mnpIgFDLvll2BjCCO2qNmikw6V8EQ+paxJ8NTmECD7jKzskt+Jc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRRtTiNt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b54f55a290cso134479966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630331; x=1761235131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOMGO9xFi2Mtx7k0vCEAwcztQ4BN53A74nGNrcyF4+o=;
        b=gRRtTiNtyewB/Nx7QFsxoBnuZb1MkAAjXeRLSPqdqifEYlr1RvmzYqaSN5Mt1x2fYd
         askKGSP4zQzhzCugEWpBb+ecPlu8Mi/E6dBbD+EiTYbfLjFti9wrkHlt8rTqZM7Qf3no
         brPiZkPbv4nxuaGTcBI+7S/a7ISjGHhID7SbFl34ntizzvNfZge3fOP22fLTvTQXF35Z
         rAjSW4uTQA96Dsm+nHcu0CZEBwS9Xp0kE7cOA6atb8DkD9vTK5TLQ7a3Aiqc3dsSTHcB
         uVhy3R9CZ02LgwC8Y0HL8Ka/GWfBSTehujv/ARA7FMfIf2dogPA8GuWDXMBGXOyStNtx
         +2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630331; x=1761235131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOMGO9xFi2Mtx7k0vCEAwcztQ4BN53A74nGNrcyF4+o=;
        b=xNapQlqxg1KLYQ+TbyBdmnjDFBgg1X4PHHhIcJCIKgTXu84DeQAyxmWq2d5Fy+pczg
         QGq2mVAJUZmfhesDeKd7dyihIKKZDEnM+SQUMPScUb0Sxn1Ea3Xxfh+iOrhuQGrCoupP
         A3uZ/olfGIdhbMP3Rl2JB3MV1DnOODcZY1yuBaUt+tzkrHa3U/qSGygRijVE7DdhPGPb
         OZI9AwRA5kkgrAlQzyKwywCr1B9HTXdew4UpKc5OuqwhPcdfGCbsZWFvJEZWTap2NMKW
         Dv7A/uYuhnilanxEmSU8xxlcWriOasOc00b1KIOLSZv/uGt6pkQYazNyMP8lnp0X1KfE
         Cr3w==
X-Forwarded-Encrypted: i=1; AJvYcCVMdOkyPtQWOojmTL1A3LYZBg4rPdBnOQ6povv+4LZNTNtZh1k04UCsPFZtQsU/TfMYneyIggM4kUQ9ak8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqup8oPZxfAzfM4r66gba4acDfTHvfTV0Itsjxzljc2sRxWB6
	4aeC8t/ndO1HFgED+d9N5MnPwEH1eiYCVTVSOvdliAg/9AXPngTbQA65/mJRDMmWhgk=
X-Gm-Gg: ASbGncuN07QxclVnNI3Gy5yuKv6l2lr3rHlQko3ZU246pqaAgJ3L7Rp26N76XBc6ULb
	UIXhjiST1L83/Ihv7Ts+oO7MOGmGqiO6xrTTU7AsConbSUqNQbezndBuMemjG1KvEnLTU5LUW1B
	s4OhatosZH2DYmrYthNAp/pxoCMsp0TFxkaAPcwljbMImoyIiH0W4rfsu5mWsxMxOtEF8ZaRiNP
	y7BF89zy3jRBvl/EFvzf/KonlF5qJfHKBRaNJaJEAENh9l8ixZpHycFOkxx2dAVbacF/YGBifcZ
	4v2YLbk7lL/nOlnORBiSItNvzgzOdsn+qUEIiU9vtULBeyakTHjCrjagltb6nxwzg5yj2aKCO2/
	N/soq9J2ExTR4dr73LebMvb/JwoHTZJveL4+Bkf6ei3sztL1E/4MGPAIj7+7HaP2ViCGUTGFx5O
	QaT8B2EO85mWOhjKdx6saxlP+nGvMQe5DMAgBUHJ6iorYoLcmi3ualD1hS0RW6JvxfH5yoN3U1f
	gwGbu5kMw==
X-Google-Smtp-Source: AGHT+IFYdstIK88h2DzNqSnXkoNZZTxC+NFmDH+MQK4MClgJpcEBcvp9PSTTwQIBKBRNe89kOYx4bg==
X-Received: by 2002:a17:907:d0d:b0:b41:873d:e226 with SMTP id a640c23a62f3a-b6472d5bbcfmr52909966b.1.1760630326396;
        Thu, 16 Oct 2025 08:58:46 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:39 +0100
Subject: [PATCH v3 06/10] pmdomain: samsung: convert to
 regmap_read_poll_timeout()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-6-7b30797396e7@linaro.org>
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
2.51.0.788.g6d19910ace-goog


