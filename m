Return-Path: <linux-kernel+bounces-735839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0078B0944D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646FD1C22437
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A272C3271;
	Thu, 17 Jul 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1qfBGOd"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA32F949A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777962; cv=none; b=bBcsp73A8kYrbkI46zRS1UEE26Ryp+tjf9zYzPHmWmL7c13co+BC3SzfybnzZQ0Y6UYH6n7Z00hbFUhuT6UwAW+G448aTPLf80T941Bf7u5da+IyyvLsw9rgknndgB7loXkV59afiGiDo/mkqTRqbB48VDolu3q2M+lVXR3rmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777962; c=relaxed/simple;
	bh=e4AyjuKurTzGZyQ7IsSv9noLYB11adiT1hgcxjMHk64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9UXf5tbcszjaRRgfRYZtYTCyrKqKNr2j7cV1O9HmG4G0anZ4C8WQBek8NjoqTpT2TBor+u6NSB2AdNBgFXyrz8KbBNmM9isL9gWJaskEegIRX83qcg4vBwL/wcVJLAzNAzN33wVlnxWryyXghrzhvGFOxQ8MaIkH84ah2uqU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z1qfBGOd; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so859547fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752777960; x=1753382760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ppg9NFBaFqyEViTmHd7vwh3QVG6vwbeyv4M1sjO9lQw=;
        b=Z1qfBGOdVRwnsrxhkHm/Pf1W02fvRi1WVRtR4YSwGrtDpFHo32wFNwGecCfHR54z4M
         U6hyWgOgpO80R/sUZbJHlkaL6fscHRW0zcpROv4HGCRx3emvVTCr1UhN8W8UzQt5NIza
         yaRxvbV2kPN+s2NngpZSQg8NFkbD76sizCiHuwDmx/A9KPSc1YOQwzhkHfh0HYJII6sp
         tjYSXjR2/WxMEei+HzPLygc2B2OgNizj6SL+94pbWE+oWI77lecNYm+3nou2G26PiQUh
         0PeR0ycrSs5P6dKcwiv6RKSkT457zRd617Y8LoOdu4pb5eIN+1q0KB/3J7qiwS0XnCxs
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777960; x=1753382760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ppg9NFBaFqyEViTmHd7vwh3QVG6vwbeyv4M1sjO9lQw=;
        b=RjWrX4ao6EvErFWDkqbGKcLmTw/X2SZyZV0PwIqr/d9bSrsQ8VWuEkwGqmKQGKS2aJ
         TPk7nA0tkIwz7nrO7QIn+BFS7BUZcJcc04eGZXcUqLvJm2uabagrnSHwOkCMSydFXGN8
         lGRvP4ksPh0w1RPiM5EoXlIjlZIKqvoD7G28i6OA2M65jrITrqstx/OyUPrPMjSrrkDu
         BcMn4ud13vJmaOjdVUhdUFd8MeX0IBBEvjdJhrB2Pi2C6Tm5sxl06CYGG+AB5VDkllE+
         lbYX5yOV5N5RWfx/CcMWKYPIaeN3VIGurY6OEI9YeCM8sU4YInBp6Y6mOsfS8nXqEbD3
         FFTA==
X-Forwarded-Encrypted: i=1; AJvYcCXJpxgvm3qrH6EXWxQiVLzLWrBKUjgRHVXGch1wdTX553bWWslwXvDoMF1Mv8ayWDtrZVgbQOqLFXO+ov8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3QBbCqcefLknkmGrp564Hhkeom0a6wo9fvWBlZ3UEvPKdwFX
	iD4Zz9xbGAM1KAsSvHZMIB2erxup4NgIIiUfZ6XAzYKxHtEu4Hqb9AGIM4qfHAWwgWI=
X-Gm-Gg: ASbGncv44fuLcsR2NMNfk5T7+iIbzFXWEnsf7QC9zkeHdDy5I67Fp0D87dBMg/nJcxn
	Q5BF/qhFnBJ2EUVaNLl8uxTznRXDvLyGeXXD3TmRKyNzC2EvVLQ6jNWz0B8nB0hwC6VN1OsKbsZ
	QwDf/G+QG3cs9KPDxqwDSO8Qi5YZBIJhaCB1VhIwApvYiopAS4GbSgWYimWAKVJZItKWZHdlFq6
	xR/Ye8mQfbhSXZm1SBbDVwX0R9sGqWlCOar55dKrR+PcJXLUUob157BvTZII4UjZUmVcDUVwzRo
	oW5ldFiVJRrqaaVn33pIANenj+88+EGgq/gOuC9l44q0OGaSOwb1WEaZhzD86jFQyG5JeZXnm+/
	lcUPzRatXMmL7dupryTM1Jqfpmtlu1w==
X-Google-Smtp-Source: AGHT+IHxFpdmg1jv/EBACz/Mfw+u9EqxSDZacKqFZbISEkaUgQNdX2Tnthbd34XjvoUXtDcoFnV+Ag==
X-Received: by 2002:a05:6871:68c1:b0:297:24ad:402f with SMTP id 586e51a60fabf-2ffd0632288mr2506200fac.12.1752777959956;
        Thu, 17 Jul 2025 11:45:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1982:bb13:46f1:2e60])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff1127a238sm4687687fac.18.2025.07.17.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:45:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:45:58 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
Message-ID: <c9ee3799-8b70-4109-aa13-2febaff9973c@sabinyo.mountain>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752777667.git.dan.carpenter@linaro.org>

There are two issues to fix in this code:
1) If gicv5_alloc_lpi() fails the original code was checking the wrong
variable.  Fix the mixup between "ret" and "lpi".
2) Clean up from all the previous iterations and not just the current
iteration.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: In v1 I had the wrong goto if gicv5_alloc_lpi() failed.  Also change
the label name from out_free_lpi to out_free_irqs.

 drivers/irqchip/irq-gic-v5-its.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 55360ae9f1f6..40e361d5499c 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -949,15 +949,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 	device_id = its_dev->device_id;
 
 	for (i = 0; i < nr_irqs; i++) {
-		lpi = gicv5_alloc_lpi();
+		ret = gicv5_alloc_lpi();
 		if (ret < 0) {
 			pr_debug("Failed to find free LPI!\n");
-			goto out_eventid;
+			goto out_free_irqs;
 		}
+		lpi = ret;
 
 		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
-		if (ret)
-			goto out_free_lpi;
+		if (ret) {
+			gicv5_free_lpi(lpi);
+			goto out_free_irqs;
+		}
 
 		/*
 		 * Store eventid and deviceid into the hwirq for later use.
@@ -978,8 +981,13 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 
 	return 0;
 
-out_free_lpi:
-	gicv5_free_lpi(lpi);
+out_free_irqs:
+	while (--i >= 0) {
+		irqd = irq_domain_get_irq_data(domain, virq + i);
+		gicv5_free_lpi(irqd->parent_data->hwirq);
+		irq_domain_reset_irq_data(irqd);
+		irq_domain_free_irqs_parent(domain, virq + i, 1);
+	}
 out_eventid:
 	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
 	return ret;
-- 
2.47.2


