Return-Path: <linux-kernel+bounces-880221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD763C2522B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D39188B349
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB034C819;
	Fri, 31 Oct 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hV203SNC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4834B1BC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915373; cv=none; b=OUz115XAEVCXqWlPN2eHvxYmObCRkM+CZttJb7pVrzQkmbDZPVrb+nJgiCgjV8eeUZyJNAO4OKVf75asUznssGtNFpFjDFGySTUchPQsZWqgqMd/g9/sm7V0eV9dAw7doSMfX98SrsOAN/LRSdASCY3jc7/XRmXXDlK48dyFJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915373; c=relaxed/simple;
	bh=2b2RMRAbQHJoSplfNlNFCrm413eCNhV1Uu0eYavspbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxMwtDh5jWK7kDZyJAaJL0pxtovgQrwVjbjLGSugAsL9yWp7IBzCtz8fPxzrgGwaevoA6v0FNtCV+mI6847EdXWak+2J8WZ8AnKrMW0txGf4wofjBteMIPl9KyTdH8GtHOOZ5iGpbh6BmOcxnhWG7UbqjevDSJ0sHnSUA4nl1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hV203SNC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so17862955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915368; x=1762520168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itYhsB6fPdpzra7msCKHByUBTLvmx3RYWl3MrAXGf0w=;
        b=hV203SNCoqGVtfoMSp/Pz4x50UyUpYWd989qiWmNNiHOXZZjEjBxysdXydfd/0OKLI
         PxXiW34dqJxl5xJlqg0yZDOqAyrPf0/ICQ7efOUpdJ8kGuzybSE/aQqEc7REPdsSr1T+
         M/wvdEseoqyqTb7CvwzqyufhZH54wYguJkK6Tq/LgeUucpIUxhLAfG0Q8Zv3B1ILESeU
         L2CqNu0yKg0/nbKvDJBhBG3MMpf6TEKUlDzIlndIIUcIHij1VFw8FnS+Kpy44IzIuq+k
         DN4lk0MqTmPNywUtGSQPos310Q6nlONJQFOeh1lFUbLSaPTPDNOHu6aYat5EmgTtN62C
         80cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915368; x=1762520168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itYhsB6fPdpzra7msCKHByUBTLvmx3RYWl3MrAXGf0w=;
        b=DP/ZHTsI5p2NTbUSFep9AXvSU19BTcl0SPY8pA69m1MON61X0jcKPPHAkFhQqNzo5B
         BnyzoE9OzEwKS+gQxbYfcZCex+pIzDwFbXkB6RjyuLMWKstldvTfA70ZqZ4B3T4bTLh+
         qmOEUDTvbIa+m01YTho+tT277tWlhFu6MjPIQYz4vzHeJt9u0H7In2JXexazLee77uBQ
         gbJiahAmmQPRwIR4lnQ/XkhqrmrjfpowtUlq1t1CjssqpkKb0fhYFr/5nAT45aYJfgO/
         X6+jgFFv9S6TRggsJrJghWYY+jYptHw6cGQMn0+EMEgK/n9asJQWrxM/tj40vLjiVg5f
         MTJA==
X-Forwarded-Encrypted: i=1; AJvYcCWorP/NvaZL32RGzk876kI5K5ulk5Nbu91wGi0qQ0tVR/ffKgA090mfSZo0ftOsv73pGXLx54Sb1P9oMlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9z0NU8H8spmib82LbqzgI31Z1y6vvPdNkE+rXR0OkS+yLdnvs
	WojhtPm/2rtbmjWYFTRCJtYp8ZAXKn5kl39JH1PXL3K7w02WCREniqpINyUZjT9LBpiVISlcL5l
	nxy+IyhU=
X-Gm-Gg: ASbGncs548FFziNUvM1y6/VfKYnGczFD6S4fx2qDzml2DXFk4tlEKq5hSrMFvtQ1S9U
	XEwg+ah63LAB3TGyRQ4Xuatq+ihbBQs3B57IiwrGiG04QjhqoUVYlO2kAp4w3Y04frRVMlBAAZi
	TFeAjUAQf/QZsh9DkIUukJnMl+EuQKsJMYXmTPEu4aoGaGmU/rcSM+UqDMrTmP578Emlp1qVLKU
	j7SNdEKONrTEM2lE1smrJYFPL0ltD8ZVI+EsKT4xGSsjDmKVkCJzuXjshxmc7yPEocIpBhyr3Er
	OPmYc7EJ/JuSQ79xhF1/XuEp2KgyjUSGvUrz3QEyRgY4x8i5FlTkril0BCFbtccsSqLUen6Lkpq
	N7+OFN7JxbFtEW7Ggiu8Emzuql95grFvuqYp7WH4WTdRZ15nAoXFw0bN1Ev/63hFIsHNctWAWqp
	KGP1/cG9SfvdwIw2atpNP/y5Zl7wYQ7oi/CNuJyp/e/03cX85UgLDpu+Ulxt3g9IE=
X-Google-Smtp-Source: AGHT+IHji7cnPXAM99TSnbeTgigh5KRVC5HbAljjx4ZpeP0cWM3VaZ+C9Ae0FF2SW0ZbMs1zBgOQJw==
X-Received: by 2002:a05:600c:3b26:b0:477:19b7:d3c0 with SMTP id 5b1f17b1804b1-477307dbbdemr33249365e9.2.1761915368337;
        Fri, 31 Oct 2025 05:56:08 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:07 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:05 +0000
Subject: [PATCH 06/11] soc: samsung: exynos-chipid: make asv_init opt-in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-6-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=2276;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=2b2RMRAbQHJoSplfNlNFCrm413eCNhV1Uu0eYavspbw=;
 b=Y7M8VEUe8Ma3wIFBHexvsVQYqz1qW9K3xn6HQU8oL0V54u5FhpPmhqkF0rW372bcl2eRdsAb/
 mahZ6Jb2R/0AW1hOGjVtZBKdJz6HTZeH+NKyzbFB+XoMLLo+kDS0/zg
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Current ASV handling is tightly coupled with a specific Product ID
(0xe5422000) - only one from the list of Product IDs defined in
the soc_ids[] array.

Since the implementation is highly specific, make te asv_init opt-in.

Note that the exynos850_chipid_data was intentionally filled with
.asv_init = true to not add any change in functionality, even if ASV
bails out early for these chips. We can follow up with a patch to
remove the ASV init for these chips, or better, to update them to use
the nvmem API that GS101 will use, as I suspect they reference OTP
controller registers too.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 7b1951f28e8d4958ab941af91dab4b0183ceda5f..5678bc85c4d93547e446caade64a0b650d06a332 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -39,6 +39,7 @@ struct exynos_chipid_variant {
 	unsigned int rev_reg;		/* revision register offset */
 	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
 	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
+	bool asv_init;
 };
 
 static const struct exynos_soc_id {
@@ -163,9 +164,11 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return PTR_ERR(soc_dev);
 
-	ret = exynos_asv_init(dev, exynos_chipid->regmap);
-	if (ret)
-		goto err;
+	if (data->asv_init) {
+		ret = exynos_asv_init(dev, exynos_chipid->regmap);
+		if (ret)
+			goto err;
+	}
 
 	platform_set_drvdata(pdev, soc_dev);
 
@@ -193,6 +196,7 @@ static const struct exynos_chipid_variant exynos4210_chipid_data = {
 	.rev_reg	= 0x0,
 	.main_rev_shift	= 4,
 	.sub_rev_shift	= 0,
+	.asv_init	= true,
 };
 
 static const struct exynos_chipid_variant exynos850_chipid_data = {
@@ -200,6 +204,7 @@ static const struct exynos_chipid_variant exynos850_chipid_data = {
 	.rev_reg	= 0x10,
 	.main_rev_shift	= 20,
 	.sub_rev_shift	= 16,
+	.asv_init	= true,
 };
 
 static const struct of_device_id exynos_chipid_of_device_ids[] = {

-- 
2.51.1.930.gacf6e81ea2-goog


