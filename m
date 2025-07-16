Return-Path: <linux-kernel+bounces-734183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D6B07E16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B564216AB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA912D876A;
	Wed, 16 Jul 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lS71hOlU"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745172BE645
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694674; cv=none; b=ina41XK7elgNmgqt3PCbyCOtskjBLT2fwU5AfdWlBEzxQwwpt4ucH0J7sfAE6DFhkN9r/grp+FPXfZG1Nna4gVA87BXWgKINHs+yk5czTzSee+nFto9eQmNvSqw50//+TuIStNr8/afatSYU4eUryxPJsMPpRV08FWziWM5b3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694674; c=relaxed/simple;
	bh=xR4yIUY0Q0WGyfNya63zg6sTYeFwNv31XU71XhscGGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ehz4g4UxXNGUbfUwpoj0TUeRHSgJtLaFdp7Sk9eIXLYPWttlYbhZ3g9WWz7iRnCT/oArGlqR7TntTANq/SQQFpG+pPGzZkL4YvIyR9TkdR3IMvqOBD5a1IUMy5rSI61vKXwlwe8PgEtOJuU6irKiUDlod3BPXlXGsU94JCXsFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lS71hOlU; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-41b4ebb157eso189060b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694671; x=1753299471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlhGcA1+SMRJvkNTiF59+kJkm2bBxNCy1RLn8jrW2jg=;
        b=lS71hOlUtItWhkbSj6xsxZnHYoUdvAzACGBIl0M+G0nWU/Qxct9tcToPK8vFqzT3bn
         kLnwmgyIqD+OJfkar/mqb5a/QhzXvWclmrW20T2mfQveroyzGV1uiIyOjr/5GluXMoYA
         nzIXuDRva3sI8yoGhG2lyn2wdFWdURS/n2ocWuGaQ0Gy17fEJTxayW9W73Wk3bB+f+ec
         9zTS7awJMY4rZAmVKxVd3srD72HR3zcWABbMzfH5GjIs7xjJfm2IRVM7M1h5U9PpJNmg
         PZlgWNymgTxCas/ymA/0ZZLUKVfpYkt7rXipW339ccKOFQDAEbZIEagjyxU2srOZ14GI
         u4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694671; x=1753299471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlhGcA1+SMRJvkNTiF59+kJkm2bBxNCy1RLn8jrW2jg=;
        b=e1X+DVBO7ie+qxMXOaJKIhVKzKJKeK3eXbrNaFHyKBycbxVyK71AExiqf5yLl1PIM9
         wcvDurQVtj84OZOpkWeKjnbvtP3vnEn1NvHxqUfXSXGimEcP8r1DWfKMJ9wbOAeKgX4l
         gm4geKoKPUqKF+y5RH9fPOZDvhSaOmjqW5krFQW5xm3B11NG/228mb4g6PPlu3GBC/16
         biYCH2aVjYrWW3jZICZlCTgrEJSB7JmfotqJpw4vn1Zf2rPsIaPihsVaFk/YddFH+hgW
         6psYpCybyLccYbw8CGmHJ7MUwAJh0shbA+VRPe1tj7t9tJJ/SLvEURVcqRStTweKAeiU
         NjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtldrzCJE/y6MMrXnzhxX3cRZNvRHb22s9vLhaYnj46ygpI6rqs/hXm8nhJEUhR0NybOqXO46V7eJ9VdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbOEmPyBT4EprAZfzJS8ODcQfkHQ7QKmHTPsueUW8too7LgPK
	gaNiRe1xO6xqQ4hTJJFuXgLKr0u7gVnvh9Iq9vxcVzvEZwiN1KtweS75MteFrZeA9jE=
X-Gm-Gg: ASbGnctp1hVzGiwR8u6OrPcexLOzPn9Nmr65egVWx6to+NHc8ky5dMG+RmJCbcPCBdE
	3Gm/wXXYclDP9//q7AZ57vl+mR1689owotYjecrwbPtsQ3qfkc+MP7yX2NneuTuRzoQN0+vgzX8
	pVNdE5PtxXqFaJTsn5OLDx2KwibTA+IWTZL+iNk5o6J6p9mr0qd+VjSFNNruNW7h4acSERrkTzy
	IG50vz0CsvPPj9EQTYfgXVc83HQtfXdjSkUfvME90Ua9FHAdjvz04zfWE0dOxqJZN4Sboa6fyP9
	WZxtJvi+NazTHreqscik/mX4yei/FCGQJODgDr/LTISSPEkis2AM3A0+DGQlEBffFBh2ecuFyl2
	6AiOnUlEklfUewlNe+MOLVopWv7iOPQ==
X-Google-Smtp-Source: AGHT+IGGKvJLp/fhPwmU1Q/9ypsIGaSvfz/Mhue64rW8YBuOSpnqPTVe7w4asOutp9MiDek7/enEMg==
X-Received: by 2002:a05:6808:1a28:b0:3f8:d2f8:d735 with SMTP id 5614622812f47-41d0545fc7emr2878205b6e.33.1752694671547;
        Wed, 16 Jul 2025 12:37:51 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff111c3776sm3762394fac.8.2025.07.16.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:37:50 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:37:49 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] irqchip/gic-v5: Fix forever loop in
 gicv5_its_create_itt_two_level() error handling
Message-ID: <863a729f-c57d-4ebb-a23c-b22bc720642d@sabinyo.mountain>
References: <cover.1752693640.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752693640.git.dan.carpenter@linaro.org>

The "i" variable needs to be signed otherwise there is a forever loop
in the cleanup code.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-gic-v5-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 340640fdbdf6..55360ae9f1f6 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -191,9 +191,9 @@ static int gicv5_its_create_itt_two_level(struct gicv5_its_chip_data *its,
 					  unsigned int num_events)
 {
 	unsigned int l1_bits, l2_bits, span, events_per_l2_table;
-	unsigned int i, complete_tables, final_span, num_ents;
+	unsigned int complete_tables, final_span, num_ents;
 	__le64 *itt_l1, *itt_l2, **l2ptrs;
-	int ret;
+	int i, ret;
 	u64 val;
 
 	ret = gicv5_its_l2sz_to_l2_bits(itt_l2sz);
-- 
2.47.2


