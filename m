Return-Path: <linux-kernel+bounces-856533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50CBE46AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90C6F503A54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AAF36996C;
	Thu, 16 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSU8W/mN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968E369964
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630336; cv=none; b=CuvAv5GBEbWU3CBaq3jsTdiOURHh/PEhuw5xnoO7iXH70Nvg9hYYD7RvJLlqiSlSW3q3l9BDYqRBpkgHzBmgS9OltxwT3S6YXN4T3X8CYO/KR0wSPBWOldt943SuSyOLUS9VBaV8n79NbHYVQFrlSaMNhhK73BFnsdfT9KiS2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630336; c=relaxed/simple;
	bh=F1mHgJl9qBKql1N5d+dvVsb1yWt8kLOH6HBPs2Lyipw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCcTzEOFRPVHRcdPf/2oxjDrYWBgB+5ZNTVYF1aojEBz91vOLtNKRLIu8/2tt8yGH7Gc92nJzTMxXjAeM82LE6TPTGXHr1QM5rPSG4f9bMOxH2+/CZSx2Kb9A51EMIUTCa/f9lSvRBw0hBxHdCrBNTiTdqAu+FteNfbKxojCCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSU8W/mN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so152601666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630331; x=1761235131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SO9hd5b+FbsgvfRJA9bEqFwoXMIxby3A9uFM+TJl7N8=;
        b=wSU8W/mNab0Jn0GfQjEvqnmNuKDiQZj9ZZ159Lv/fQxiBy5VrxVqpsOHrwdBbxCmjr
         n2QIFLwYmzWvPGAXLOlRV4myHYXml1fP/lZgLlpXIZvZvfAiinxIO239b3CFwR13wz+m
         myq/inKjYuBXVSSwD4EKCWUWXGw/ojFHHICbCDJrlbdMVmRe42pBPUAOJ6PlsvV3GSI2
         aGcH/8072M0xfB/7G2b/VooLUZoiKdK5lARM9MTiUB2RfINPaVASu64njFYBzRGDLXWR
         cySvxVuSr9MtLfkUOe3W/xEwDMekwrNsgVKXX7a+7fkOPS/XfOB8nNUjANcZEKVCXGW7
         Sz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630331; x=1761235131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO9hd5b+FbsgvfRJA9bEqFwoXMIxby3A9uFM+TJl7N8=;
        b=PU66O0uDmmPf4l2UaCaQMpBF8TKkQtmgdI1/8ux11JNdyRDbsIoiprACQrm5pSA+qw
         5pLMpCcu9XLjpCckERyrSKvZGayJlPIPGdIGRfd5VV03kVHSEPj8MMPkR+G0PTUkptQs
         piI98y/43yXZIetQioamdQiIpToos1bnpdDc1mZvMtCnIZOgzwq/EKSAeecx9lU43Lp9
         CwsgPYWMjIfBgnqlRkSuxb6ViB+6CdFIFd6NYnpBT01mvucKYIdYVnshqzYfTpadyDpP
         9IHK8sb/8J2FNFl19Ymf4AAbgtxRZ+C6PydPHrYrWfcslZ5mQ6OW2bwuUeyC/ckqzg0b
         rq3A==
X-Forwarded-Encrypted: i=1; AJvYcCUv4F0YNfXwP6b1UwZerYf8sIP14UFqBjArdsu0+lDMsMapr+qxNJ7F5TFj0u6ox2DQqrmdks4HlO+XvRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEU/tvpsPRiM991iknJDZB95GHrQ6CUS/+ite79Ni+Cx+5SdRo
	fGsd9maiQhv/vyLbuYfillxaMMlvKWRc6wdLlwmPn4091666WWpS931mDSHAKVY2K/k=
X-Gm-Gg: ASbGncvY5iy8+EkvMy61LFuQVg+olairWAvjTvW7FHwoJf2/9BMMlcGuqVw0Ofzm0D1
	eDCj8ECMQvJy8K00Aij0ooZ9iACKgiVtS3PaoOgmFgMeidfIra4pSx58yzY2IQgfmEKwPNe1hmY
	+G84U7Wb9i81Ohsl7UYXXyYIVmx5f//V1eLVeJWwgWgKEnoS13YH8B0kE3TWzG4o9LBuNymu08R
	PGRmCerid7eotDRqiXd48Q9Xc3kPBoHICdRjeaCNjkfAbWy9hB9pKmBcGFkS8NrD6GoBSu6MdbA
	KASRKfvBTohxNla2crz4nt46w6+pGCLEd0JBIjsmcGH6WK66Xixlddybn6MYEes6bMcCj6TfZye
	QlIW7wu8u/ds5IoGV47j6T0ub8NeJax8gIcEiwDkh1dfJ/x7kNoPG6oIQg75gnkm+FwoeAGdjzv
	g+olHI4fWDTUl0Zqw6EC4komkpt+hs+uvlfUeaGb9h4Pvu+kmoAyxWBHGf3tmeH6xpOyjRUKg=
X-Google-Smtp-Source: AGHT+IGGU0OBvZX4eAhyBVw2Khouiv3ywhe0gW6+PNakLUoYmT3fXoe3XDWiMcszKrB34lkr9GEbsA==
X-Received: by 2002:a17:907:971e:b0:b3f:e1e9:22c7 with SMTP id a640c23a62f3a-b64769cd22fmr44681066b.65.1760630330714;
        Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:41 +0100
Subject: [PATCH v3 08/10] pmdomain: samsung: selectively handle enforced
 sync_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-8-7b30797396e7@linaro.org>
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
2.51.0.788.g6d19910ace-goog


