Return-Path: <linux-kernel+bounces-856536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD59BE46C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BC15E1AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205923EAB7;
	Thu, 16 Oct 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IytOev9E"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA41FC110
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630340; cv=none; b=RQ4bu4TJiFM5Vld7SL316jTRfsA8KSVJ2aWiElA6gP0h8wxBFFfJXOKGzMtEIUiIt5cHi8y/WaxGsdHrLQyzcFHhOauPjYODDRrBY8tpAxhEq5wfYoDOQg/636mT8hKIFPjMVhwnZ+Socv7Jzxk3trJ7AuQlnMSp5j2sxRkQgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630340; c=relaxed/simple;
	bh=ngrM+eWn9xbaRjAU/VwFL/GK16Xs8solvHiQs5E/TVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Emb4wUVlnWrchSwBLsBbuKvtyYT8avoxE9LOxhSu9EQDg1LEQ8oxuYs6tcD7sg1oI8JGsUEx4734Yy+ERpEMd6jgIkUQ/Q+yKHtWm148EMQFCtbGnJ3HcbfVLrce41Yx5EaeppPoJEz/0sGisiapJfAdFxD3WdYANY59fHTfeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IytOev9E; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07d4d24d09so147526466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630332; x=1761235132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRtuCWl6DsZm6id43RaQ+ggcTZIQA9X1wHdBvSFgFgY=;
        b=IytOev9E/QILIygCo15TlnAtXJvDl/fxruSM9RvNvnlOI8jIDle3TDO5NIAkByMiqE
         6NmYGg80GCs7+B3JHJbw44EggHlnKxkKG23u9Ic2oW16pcZBWRHcm1JXsckVC+sClPtx
         HSI1YuQJVyA9EJxd8Yd8mPQP47O6kDCDgX0zkU+6qceGCKa6CAWSLYJdTDNJcJqJu34U
         7T7p4Dai//Dx8kYQBoRKLPNbXGL4qVYCyCT+SZkFH+/jyCTbDt5A3PssNgacCRpTiLXr
         bwIX42Z0B9nly1KS50SKujx+HeKWqU/zmafuTY69FtlMLlEoA80E5qPMkM0D/Myr60+N
         t2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630332; x=1761235132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRtuCWl6DsZm6id43RaQ+ggcTZIQA9X1wHdBvSFgFgY=;
        b=pl6iOq4C7oDISvtckaLIdy9vgmz/dKYGkcMKUrUG3pc2Zs1QXSbsOd4x9gbscAesCY
         WOYLTgeGDRtKpMemK1Osg0KBZiGm1nThtKEH03cF5tPfb0TkQYgor3yiLc4AJeWJ7H4d
         QzVMfqGTInYTZk0hkrX5+M5NqFjb0Qj8ZiNzMnmpwDWQ85reYtIjDDZMGUmMltK90Q9I
         BxO/bh6Aiq2pvkwIF92VH4qqaAjyKQ6yZMRYc1U6KQPCQra6/Bf2g4wjDW1TuWTcRcI6
         aFP6pERIHCheDlq49zPw/p9jWQiC4rVOethR723PF6olCZ3CTbj59SDo6yGR8w8U/tlk
         T0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVyavELQHbRpDd/PC/rFF0tuYb2p+Fw54KZ1Gvelv3/A8+m6QGSCkcGrrP3g1I9+4EGwEiaJuE6LdPu7g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JE0o5iIXQjBHWTmfEb0yRIfncpqn2uHz+aKjGN/a0ANknSun
	8sV5a8utm3AZroh+NHFztoNebyXh7a81aePx/PFpSEjDVuXIHP3iazr4xVXQkUf+TTc=
X-Gm-Gg: ASbGnct0qfzx0yV+vheqP1mYtfj8sPQBWF4vR4633EOACUaGK17cuI3AfYO6TeIOrVm
	IS3i3M8vcQwytjlm9B4yVsOE7VCBtaJYivfed0/3QU9oSFm1FSteFU3opCdwpR5/omXW3gMZg89
	cu+KonM76eI8Y9dFK8fRgSBi2r2tmu6DYrttxboF7rrh6tHN9rxtaXe3QyjUxTIkE8NGTjLk40K
	AZQEZ9nUB/pkcH9C/DkOdrDEUruUmSddAB24lUKY7wfYl6MczkwsB4TM9NJ6xWtubGk+0tg3Wif
	R6VXTMJNeUIvPiai4+ac0G0/3eHvCokheuofl4jhbCvAIO/IP1dt4OQ0xPAe9gRNms+st0ojQeU
	aOHK6xUYZFJMHSkXqfCmS0uczMJPtujVu2QTMl4u3Fee1ijCKyY4T5GnL2pvWdw+bQh0bzZnVdV
	v/Ihwghudrup0Jzwa6Wd8ls1HZyip+EQBn1jtDR1VJbVe+6xSpIi1vivCUVVso
X-Google-Smtp-Source: AGHT+IEbUoUcanooKZDlk5mEzvgz5a6q2790fxYwvUg/eU6pRWdoDgf3AvUevu67xFJRES2YBilqRw==
X-Received: by 2002:a17:906:4899:b0:b4f:f6ff:a82f with SMTP id a640c23a62f3a-b6474b371e4mr39583466b.32.1760630332293;
        Thu, 16 Oct 2025 08:58:52 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:43 +0100
Subject: [PATCH v3 10/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-10-7b30797396e7@linaro.org>
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
2.51.0.788.g6d19910ace-goog


