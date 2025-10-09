Return-Path: <linux-kernel+bounces-847063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A171DBC9C87
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBBDF4FA806
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1802EFD99;
	Thu,  9 Oct 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Af1yyeZA"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AB1E1DE5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023517; cv=none; b=AFOq1yxXWOh610YJYqCaNxWU7GkBvmzBs9ICB3WWgCUJGw1MMXX06adACyNoH1RQOgzLAWRTRQfoUMn68h8axtARsN9pY5lbbliEd6nNS9h3l5ovNcIbi9UDKdAop5vpmk1iDjk/efkSID5OzS3YVKGbVOefvGK5Gs5+R6atSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023517; c=relaxed/simple;
	bh=QW41kS606/q0M1jPNHEOuZDX62lb/ReQ5t7lhOrXCD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJSt2vzvQMPvas5eXx5xi+C3sFfe9PTEBLjnM1jzeicAnNdd6nDklEyVoANhEMRE9lMLE0jOpWNRAA070B77k+pgYdb/GuouLTw5PLCf1o+MCl9d+4zEANGNpAuQdBuvUzbSSx46ezlE3Unr5Ii3J/cwdryA7ncQEsyt7qJfu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Af1yyeZA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b4aed12cea3so172484966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023511; x=1760628311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MC3uJwytBymNcNNUBl3ACIVe5vrNsKsuMCXz3oqIuhI=;
        b=Af1yyeZAOAqEbOeGgYTym0mDHmPAwMGaoPz1O7eyYQz+Th0zjj+ivDHa0RsntCB4tL
         wEFlq6qBrVa+eld8SXbwd/ccrNfz9gJt9fPyzShxT9XgMfXKjQkE7lnqvpbX4I8aaNUQ
         uJeeP/2qDVl2yBHK359MBgqYBescyCVvLFXaL/FWBSYFmVs1smoyfBzcX3Z56QLc5gcM
         RPlyf+1ZFuEChLJ1shNdr3K8sL8ZvTNiS3Tk90dN4bDLoyNvO4flR9o64PPBMfUXGbYa
         dVbaFiejbNnYeErTt7svvejGNY983fv0l/z5i1D2YNvJnxZYkcUYUgtRM+Hh/I+0SGtA
         HqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023511; x=1760628311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC3uJwytBymNcNNUBl3ACIVe5vrNsKsuMCXz3oqIuhI=;
        b=wXz3X+W35JGn9eMepPXz19hljGVvZUqx6csYPVeTrZatnacAWZh7vscbPqrk9z6SEc
         r5kYgpaCyeCdzrAfUtopxxLe7fqPrfZZvtB6DAxOoLytky2Gj0FJgYstx7J/uZTq68yk
         cE2Go2mnEFQLjUGu1IWZaE0pfZBh2VNPGjCEuR+EjROVjDTB5Nha8Fx8VQVc5KdT8l0Y
         xdjgnHQ2xuwaLksyvJUNogbGT+rreZq1hRWTOoVKI6bg4+UxA0YbtZHuqiQyJYg9tAm9
         eGcBSJUw16zEB6QYQtPEArZ0QVYKDSqiVEvGLqq2v1rMsKKUcj3CaO8kvLFisO5MgQD2
         fRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZn8kSry1KxUnf+3OI0mo+GHC6J5JNen1MOjOVeV0CuI64SlK1bT3ZiNMbA0Hq9L6lGkwxVbIKz4Wpn2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYxUVBGSLNIIdMN9Gi3DJQVFnZz2yImcSV6Lm+q2iZJSR9Qh9
	mnZM4fXfoMd0zmVyLtvlJJ1msJ3CcIxvmMAtzJ3GZuCngV5eCz8KdETXzQH1tP+0Me4=
X-Gm-Gg: ASbGncsF9liW9N+KLO95C5WJnlX9BGZbjG84L0tCKnoOSjA4tdipp4JaLzSKUpUoSfw
	MsCR9VN6xbIAL4jTbTjqsr4TFYAHlQfjivNobOt5RlR0y7ugFyQNspHoJux1IzlQc31qw8x2CZZ
	G97N8JD/TdILJ+JW41axBp+uXMdXZE6hhJfjBl1MOtwXvzQsMn7Uc9DwrBXFbENlfWl4f1wmPSh
	eMtBAd7lV4JC7+3h0SLEQAkn0UvKa/cC4JL1eK2HKyDQmwWkx7J+GvEHyQd5l1FP8GdB6IC+r+T
	xFpfuMgCQ8ck821yV55uxpciMErMgBg0Q0Wd7/F8jA4QpG0UY8BCb2C+rBKZqTikW7RMYhuHi7d
	70qTY0WliWAeMKZ5yc9ibNBuUswOROt2VHJ659Skemxhmer/VeY6ijwaCG9GRIlghkwI/UxnUeF
	5UT12mtaQiXMRyaLcedHRBM/mq+VlJEXIqXHBren2t
X-Google-Smtp-Source: AGHT+IGUCw5TbDsbNDU12n89wz1xnvXjoWKEOoQfEfCs7xti4zjASJ6sSLgSUPyBLFyQO2HMcf/P7g==
X-Received: by 2002:a17:907:6e8a:b0:b3d:5088:213d with SMTP id a640c23a62f3a-b50abfd4902mr890576066b.42.1760023511315;
        Thu, 09 Oct 2025 08:25:11 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:10 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:12 +0100
Subject: [PATCH v2 10/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-10-3f4a6db2af39@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

dev_err() gives us more consistent error messages, which include the
device. Switch to using dev_err().

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index a7e55624728a62545eac049c9a51012a229f44c2..387ee1c91caeae4519237af2ec659f56782e7bd7 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -29,6 +29,7 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	struct regmap *regmap;
+	struct device *dev;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 	u32 configuration_reg;
@@ -53,8 +54,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 				       (val & pd->local_pwr_cfg) == pwr,
 				       100, 1 * USEC_PER_MSEC);
 	if (err)
-		pr_err("Power domain %s %sable failed: %d (%#.2x)\n",
-		       domain->name, power_on ? "en" : "dis", err, val);
+		dev_err(pd->dev,
+			"Power domain %s %sable failed: %d (%#.2x)\n",
+			domain->name, power_on ? "en" : "dis", err, val);
 
 	return err;
 }
@@ -123,6 +125,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
+	pd->dev = dev;
+
 	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;

-- 
2.51.0.710.ga91ca5db03-goog


