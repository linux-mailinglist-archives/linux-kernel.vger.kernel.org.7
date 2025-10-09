Return-Path: <linux-kernel+bounces-847061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA67BC9C81
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05B7E4F9476
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2442EF665;
	Thu,  9 Oct 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6WKLKzW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446B1F790F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023515; cv=none; b=T8hyM0zwIcRhzAfbMQO/FPPR65TuIDP2kQZ5E1LppujE6kLKBEYhS+r1P233PV9U6yYef+akygSpBpG/E19EH1YWicc2X+FXKfEFrI8fMyr0NYRSYd4cdwZY1katl+nF8zJ5bRWJfJX9VvQprqTcKvrphzgfO++OJrt6VhM3zYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023515; c=relaxed/simple;
	bh=iZThJdSQjh6h5xEt5L4Z9DubAuP7tX0sVKnmOyDdoGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1D37oPzwOWNnD1GCk4swMo+SDp/NBy4o67Q0/7NdUXfSsLpdhP5yDAnD3vH1/lcqiw0iBwKPP7GyjPEZKI2R523ncuw2pVxbBTUzC0m85O4/1AtuAr9V7wynDERd4xHSKiDAnPgFNTNNkF0I5hW2ajdiu2eVq2cZQOoMwvSb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6WKLKzW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b00a9989633so98126666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023509; x=1760628309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If4su5VGSArDtM6ZmAq2TrN2LVZ1m2nsNGX5iG7vCMs=;
        b=a6WKLKzWkGyx4y8QnyfXSIB8su55lspBNyJeoGocuLHaWDxOBSHx0fGtNYtcv16OuR
         IH2GSmntSav8c8rL422urHtwI8VCbYdXR3o0ovMk6IaoHPJRteNl6HmUR+mfiPlPqvgg
         P7QZ8GoW3+UJQYbh9dkAlSFTZLKsbWE7dVAG/r0KiJUXRaW4ovdLreHb1L0I2ObzBjo3
         lSGNN3PCL8pfa3YL2F1LCwjdP3oQH7pr47rBqancja7iij1vbK4Kvto5A7IWObtzzEHB
         xrLrZ8kVabiPKsLCqznnzg7NTDTGesYEB1C56APTcb0lBf/sTHrOWYVHqbFi8uR9huk3
         jKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023509; x=1760628309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If4su5VGSArDtM6ZmAq2TrN2LVZ1m2nsNGX5iG7vCMs=;
        b=F6Ajxkptf61o1aij5p7jocEL6y81HkTTWlWzrwx3AImy7veE91AwyY7x4y1r0qpWYP
         BipQJA46Ui+Kc1XYAwHBfDINUVQt+VIdgQbKe89yMGZSBLZTZvNfl1ORnpqmIuD+8Sy0
         lfFnrawHh3BfXRephv9prkRWjSEcbnx065a5j0KgoBJxCXoZCGih2KMeuYyzm4fcc5kR
         UBfYeyGO211JVwBJ+NTlG9KNnuD0UjfhKOrgv+uaUuoy3YMc1BLLx6mOzLEZcV1CPBwc
         Vtgr/b6Pz8o80Td9n6yc3Vhpd24kDdilXlp0OsAcPn1kTT3PgkLON0iLa5Me3N3k2lTD
         3ZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBo/fnjwUMNAzBdOZ5gzvLqHzeshx4LlV8ym07ctM9H3ZXfHiyR7YfFuvzkcjoGfBAtnQIiERisKk8row=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PNxaNI+TYtlbP6bphhgwu1vctFP5qpp02OX//m6+dTvXcWFn
	DZrJCAHpR0XKtifRRwVGQ3FjFMLaXm10oHyDrDPRul6ipcx4TUX9ZqAyHNvOCdtkjPg=
X-Gm-Gg: ASbGncv2dxQa1r39Jy0HDqG4KML6kLQ5Ugn+HaPWk58G0B74dRdD79lbZYEx5BgGTC6
	vx8KMeNxRu+Rx0bK69BxmYg5Gj9Bb/C6OK1Rrhn6josy0hChDV63gsnqQRY3LTab4wyVMOpDY7R
	THEoUBZoX0djjFff9F8U1z7K8tENw2ceN25XTeLOu4hFDTC3ACgipanHWBvzluuAvvo+GadRR/E
	amS0XZkGLy5BSXtdpz3K0ngRnlD/Rk4pD0bpmKAnLNS4xPmJvdV3c+IzK/Yf8N5+e+1rgjXZWNy
	Kv13fyrpNaBlbT4OvKeQYetz1z6yZTh8GCblZdCQQAaHpWPTvZzMtn2olCEA66s2JD2n7oqYbRP
	TkRXtW6rGd62Bz1fGqBAz3oeyMr1lJ8LVOZtPScB2eFPzyIIpfHM9o1tnug2sykJiGaTKiLiqVT
	kAl6tTslCUHtzes3sJ098QdbSExpX5D+5f4hVW080mNAK+/L8YYrM=
X-Google-Smtp-Source: AGHT+IGqgJYOgxpScnC7w6lgZwCm7ta9CxHWmpR8whF617JOpHOk3iVVQV+J82lvEfnmp6mQVRG2Mg==
X-Received: by 2002:a17:906:d554:b0:aff:1586:14c2 with SMTP id a640c23a62f3a-b50bcbe2790mr1084898366b.4.1760023509102;
        Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:09 +0100
Subject: [PATCH v2 07/10] pmdomain: samsung: don't hardcode offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-7-3f4a6db2af39@linaro.org>
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
2.51.0.710.ga91ca5db03-goog


