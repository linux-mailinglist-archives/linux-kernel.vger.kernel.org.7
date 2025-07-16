Return-Path: <linux-kernel+bounces-734184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF43B07E19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440A61C42F44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113B2C17AD;
	Wed, 16 Jul 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edqvch8x"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4917287504
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694707; cv=none; b=DXlu2GykqE35PU40NEt13eFDhdgZ3DMKH2hoAb7nooQ7wz2W15C9y3WhEPsGQWFiWxqBPCgdOvu5y/DDmcJ4TD71qYrKlaiwUZhw5AO8y4+YQ4GICYW/u1CPdgAYk8bIZm8G8zVdZxHqtiaqsED18xuqRRzaEOtn/wSE/2pwDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694707; c=relaxed/simple;
	bh=Y6WwoxlmTVXn6Y1qGMv5LxeqqcmtUghbddXY0BV2Ui0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTmoIJMuZTQtzSuxwOwl+owg6quRFm7I4cbz4Za94B2t3EVpiMg+BXJclY3k7lcm8nm7ANMzchRy9u0p+BGR/UP+Azm1jk+CH1lhTBNIhrgZKImv28rZcUiUNwmLrmpjxATtopbOtLNkaLQ6VPy3PZQM6EZ/YkqxFbb5KV5P5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Edqvch8x; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e5523ef8fso81513a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694705; x=1753299505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZAoUJYms1QaVhptgTz8je2ALyqZ+PUtTYIx/F8896E=;
        b=Edqvch8xZ9NvZTLCuhOl4BCVtQ0QFWw+wu4BEQl/InGprbTX9Y/wsDyAMd2baeHUZr
         +r5yHobebvIcAEOTbvdiOynN67dYHLDkKGLmurJKDSJxiRpEn96B8e/LFYNw+FxRIjPZ
         Hu5X5HnV0gUeb/JwRDhBjtdfJyMEY2eLYsetUoz5VBQetCpwPf1rqT+E2dlAa74a79HQ
         MipXdWmFRiNCbZEUELNFJN5JZQX6oYU7gcRyfOqLpYXl14zfoyYdLniLuXWLzgOp7Jku
         bkU/PafX5qmpDwPyNKzVUO9TYEbuizw42m3Bh8c7UgwBim6UV+b4Y65QAR9BAJoWZJkQ
         AwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694705; x=1753299505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZAoUJYms1QaVhptgTz8je2ALyqZ+PUtTYIx/F8896E=;
        b=D5rRR4oJ/alkngB2pwcDPjt1a1xdt6ploT17SJqXKNg85mUsXL0qppWuSGawS9Dws9
         TB9ATkKeoEwHJwAdy63HeuzMgV6Mfr1LYO0BE/Ws16Eo6IHoHow16nMN/yBeZEnrwQ5M
         FYFWFZ0tiCZrslT4sz3qK5zxbwmGvKGD3j4wkNGdz4njCQOfxfZzvxJ5h6k8tyHvBynu
         Ek/Vo5HWil3T8OCA3eLgt7wUG0aGJrSwMquFFHgy1nM8XjUIdVMh3+d3FCJ7WsbrNmY/
         dDwOdfJZ2ZDoVYl9h9VRD8h2nZuzoiVIetuuoBC3ccyCrLXEkPOQYjrQtoYoHeqfT8YZ
         b01Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8kHbOTAzBpyJos8EGXVbQ5JsgFfPFUBdZLwYUp6J6j0o9kaHhLsxKEU/tuBD3B6ivp8OTDZO/jenv2s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOBav27osa5PgyIprukteSkq+6+uFdcjCC4CJS8lPdIrWR5NF
	hK/I3vmyW2ZgZ2o+FphcMa5nCNIdjaLN8YnpBYgJp+moyHtk1Zif3LVBAGQjAEPQACs=
X-Gm-Gg: ASbGncs11jTL3FQt4nc1PrNKAFa6/fEBqLP8PAQgyqkHvSlNTjok+4QcoGP7UP8a45w
	r6++H0YbLn+0RM0ASBRJ610cn8uJRVmMIlkS/Ab7UFTmq7gU/MUJcnSnTjHpxLoc5RWtTeGJBHo
	Zc5ZPB/NxuqIlYrIvSgm1VssoMq8lWiOImHhjUDozgJEvLGqbPXaHVoymDPnZCZ6XMzCkoqugUj
	wJ1kwEOtnuUdo/kXmiNUxcVwCi/qUkqqYzG90JDyfJukfmujDBLhBdYKUG1FXETM6Y0qg8WZ8V3
	O5rlKdBmQ3b9Q4fmDE+gEQxPSbRjrzXs9hyHJcVQmZN/XkI6ILGzFCkRHef1nlXPPwZEOx7plU0
	Ri1gdvx9Hrq77vAQMsOL76VfOK+oyrA==
X-Google-Smtp-Source: AGHT+IGQe+9SacOULBoqYnLHIC+00g0T35D0fGvm1xJAYdkM18zC0nLDztSUBFlr9z1zvwzIUmVl4Q==
X-Received: by 2002:a05:6871:6017:b0:2c2:542b:bce4 with SMTP id 586e51a60fabf-2ffaf22e373mr3628465fac.8.1752694704743;
        Wed, 16 Jul 2025 12:38:24 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff116d66ebsm3755808fac.41.2025.07.16.12.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:38:24 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:38:22 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] irqchip/gic-v5: Fix error handling in
 gicv5_its_irq_domain_alloc()
Message-ID: <4787a3c4-9713-4b99-9b8a-7ba227e91d02@sabinyo.mountain>
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

There are two issues to fix in this code:
1) If gicv5_alloc_lpi() fails the original code was checking the wrong
variable.  Fix the mixup between "ret" and "lpi".
2) If irq_domain_alloc_irqs_parent() fails, then clean up all the loop
iterations instead of just the current iteration.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-gic-v5-its.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 55360ae9f1f6..8cc8563e27d5 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -949,15 +949,18 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 	device_id = its_dev->device_id;
 
 	for (i = 0; i < nr_irqs; i++) {
-		lpi = gicv5_alloc_lpi();
+		ret = gicv5_alloc_lpi();
 		if (ret < 0) {
 			pr_debug("Failed to find free LPI!\n");
 			goto out_eventid;
 		}
+		lpi = ret;
 
 		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
-		if (ret)
+		if (ret) {
+			gicv5_free_lpi(lpi);
 			goto out_free_lpi;
+		}
 
 		/*
 		 * Store eventid and deviceid into the hwirq for later use.
@@ -979,7 +982,12 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 	return 0;
 
 out_free_lpi:
-	gicv5_free_lpi(lpi);
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


