Return-Path: <linux-kernel+bounces-847062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E09BC9C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE33424D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7362EF677;
	Thu,  9 Oct 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzbCeriX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35131F9F47
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023515; cv=none; b=lNYAcS+t1hEEPzOee/cOtB0cPEQ/RGsKckMt9hhU5i0V5en+0v5m9/O8jT3Upa4owDsaqzhmbxf8xbVZ1BVFBck8v/lRwj3+TGFgOSuIALNvX2TRVy8YY/BdMckW/1LxxoB19cNeb/9O/9yA5kV7RmaUZM2vezEz2JyUDFdyq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023515; c=relaxed/simple;
	bh=0A/EkduQWdAahGq43hrLsndr/J8Gpiy72o41hnq8yS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJfWmkKFwiJVaJHhglZpZaeMlIGOjao+Tgw5cSuelTpsxFVyWtYpQgkvWyRJocsjEcPvlnnkJCi5+EGydWNvw7SFRVqPeQqkDsjmfXRmKTvENrW65LvurK6jSuj1Gh+EFiWZoCEBtTzd66+8RqV4i5OtNqC7dVHX6RQpFJDZ0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzbCeriX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso2109178a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023510; x=1760628310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/1/8oovwXsAv5LJCHXYAg1gF9tOSXyOhotyAm6lDms=;
        b=JzbCeriXQ4WU+Wnl7MRj/pT+e0xUruwBfEUSpI+DHtDCL2rd2rPA+U1o0RrRr2eb/i
         z9049y81jS0y1oel34WkbNnUwLdDiZziRHcQUgWwrW48YpxKxvY9kdNEJUnoKt3w8aYI
         HRzlNyjKg/cemMMBj/BNcqbFXuVYaB4LsibCrQcgLOdMLsRU2Hw09QSE8xNBjWuY5RfW
         r27Ggv/1tVCVgFrTIGtTfCJ40cX3afgR2KyWrGe+OKFjCCbFqrBRRjA1BLuzPvuVxOHO
         IPoXRjIug5gird4HqlEBoU8Oc1JhTJdeGm7jemWB48YfhTOIIKRzaSG3L7m03KMb/7do
         ll7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023510; x=1760628310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/1/8oovwXsAv5LJCHXYAg1gF9tOSXyOhotyAm6lDms=;
        b=CEcfEYBf23A9mZz48KgVHgoKZRjL4bXmlsyfp9NbWs6sgeSBI/jt2dAU/Way2RnYJ5
         wdyz9VEKBJaTBK5VbMdHi6wH75fzOZCHb12wT98TsTkNYQQ7H24IXMjzntZzKHF8nZ6r
         xZCIiUQTHbCjQcIQPa3t3wH30l1BR+R7RmkmK3P+2DMb8tDHxLwVS6KDJHYsWT2lJh59
         BBrNPKj1fyxMi651MlmVbp8B0vB16HrInIzLAsQ3+lWE4mcP+zmKS9E4TrYOOSkzKTI2
         apu+eIjcpbhuWEZEjJU1duaj4zMikAYQxSAp77UIb3+j+HJqtaP2nLjM5eJ9LkN5cEXL
         SJGw==
X-Forwarded-Encrypted: i=1; AJvYcCXSL4COLYSIxkr11zakLZni+f9R9gwCLVHwZ2XnpTLkdCFr1/ipaCXR5EAE+dCyLWtXOJ/+QxnMkqc+dyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCz4qGjDQxxyhjQYTjkOmJ6Mr4doDmk/2dld9YeeHxGyP93XVZ
	g9HmN47xO3TSZUQ40fQf9hhnY1k2nWB4XZeEiGYeNGq0vAh2uD5cErmpbQp6/bwqcAc=
X-Gm-Gg: ASbGnct47JaxIIJO/tU4EUcJVwFG1V0jXov2XDIpXlqfQQxou1PfdcnxWXx0micQaUL
	gHwYszlWMn9DCahGKy8mO0ZTcCl9n2g4op8bo+/7t0SXXann7Y622lsTCAjEErqTYiKrBdCkEz9
	YmG7Uwmd14j+XpVliLFFdUcg1ctaWeyKC79IqHys/NwsQV2cXffu6HKG5JrsdWhxN3WdpHf8tba
	5MkjszbyN1yYccR9m6hhFMo/Xpzif+nYSaJhVSJRArPSiRaVJQnvqCZMbh2xSOppLkF7iaP0/up
	pl1F58ukRiqXSaUwDyOw0Ll/2sujQl6zcFsvdqGiFcNk4U0FQ6HHgpX4jr6IlGdNpcW0DfkjpDK
	yaC48pt752QUkH+zvrR6UHnQf1T1fGqoeOYaUGYvrvKo5PTOlNYlomhLqvF2g+iccQGBPkD54eM
	KitUXqvtC5kQY4J1RRJ3rakOrwyPTdrbMNVEAezkAT
X-Google-Smtp-Source: AGHT+IGaGkcuokARZTfmmbCwfalPWL2pX6NDBn0pheQXnCrw092W78kTYfWHrm/WqInuH6GM9reI/w==
X-Received: by 2002:a17:906:c149:b0:b41:2209:d35d with SMTP id a640c23a62f3a-b50a9d701b3mr803859766b.1.1760023509699;
        Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:10 +0100
Subject: [PATCH v2 08/10] pmdomain: samsung: selectively handle enforced
 sync_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-8-3f4a6db2af39@linaro.org>
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
v2:
* use bool for need_early_sync_state (Krzysztof)
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335eb681600d9415369fefd 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -20,6 +20,7 @@
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+	bool need_early_sync_state;
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
2.51.0.710.ga91ca5db03-goog


