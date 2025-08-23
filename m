Return-Path: <linux-kernel+bounces-782860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868BAB32621
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF2C1CC5D04
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E20188A3A;
	Sat, 23 Aug 2025 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdRuMuoz"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D02B9B7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911611; cv=none; b=UM9oNgeZRQuo8BbrmxycUAGWq9dbgXfoSt5l+xneYPeBzVg8AV06FHfwKlqsEc50xsOj3Yhyl+wRbkpINqLlJ2I33ivfa2GGkPVHSEfgddK6k8vOoOL8dTu4a4r7lhR9lQlaUacx+eLnUKWUND41Yp26Z1e3Uab386XGo0ZYRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911611; c=relaxed/simple;
	bh=9gnKipkYFeve3JZi2VA5jxJhSY7Q5lWtLdEdgGKlfN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEdTV6cUKWoHECCasyLBTvHfBPv2WkqXvmzHpq4JToYuC3lvh8wrhyLANWF7dy+Mmdu66H0i8D63rgcG7afUp/7PsWjsF/0zvw9fw5VrzVR9F/zM7EgUk/ZtOUG+0MnU6FRSEdZeUNc59JpwSrFqAGFe6TNmKt2Hmq35PRvDqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdRuMuoz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3252589a47cso836962a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911608; x=1756516408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nszECatjqOXT6pvjN3oa5w7hPidffKXsB+tPXBIx6+w=;
        b=hdRuMuozOy5nRDLhtSaIe0SjbClHHwC0/cUCCcf1D0Wkyb+TQNNjRXlVD8KDxnQHu7
         FYp4MoWcSyvtAt0nkHPk1lna9f2qsrcci7AB2bUUHhxO0gYKDH24m8BHR7RmAIqboicj
         kzlEQq496eJEl0l6TDI8vO4qjG7vMkX0YxgJgCiWsU2H92jTwPQ+PU4VNnS34mQOxYiR
         6gfd/9/yq+b4NaQW/rJ+3jxjWpU5WDa11m9JVzCECgSdwFRHo/1p0DdCL8qx1GCsLocU
         R5ZGa5ljPE+ieUbRSfVU7SBju4mcI0yq+W2nFdzO8IDlu3k1cirmFNhPCrh9EUDTh6R/
         5t+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911608; x=1756516408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nszECatjqOXT6pvjN3oa5w7hPidffKXsB+tPXBIx6+w=;
        b=RINiFAFrY+pea5+NXZiGPBz/XEF+gahrUmQZm5yiwqoDV/46eZzh8TOUZlDPrVl3N7
         TRb/Z6ompesRycxUFEQDkp8KedPqtL1N4OyTg7hgr2OpJSgNJAr5B5mIfXSr+ZJE+gOa
         jKKfU/4G+MkcG7GuR+r/jk5tsMoEK5fZyNcxmxCRKC+QJTFxrjZi/p6s5yedtVImfogv
         6/PLFzSQubrSQJTU96bBC8GsZZ7KBy9KCeYPh+K8zUeomBhoI2Il7DUd/B4iH5djmISU
         bWK1O5a1mPpNdZ4tBGbKHPwOUAR9oS0XKZnSdObkvZNVc7deA6d0vi+12NTuDW01jYTF
         TvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlPmLYOkLr81Avf7wD8F6ZHlqhyMfWKZlFiCwZcwvoEsWLLWwYpPzu54AWlg6QgtZ88ccHW2qLM0KALD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dSqm8rrIL1NfjSM2x3eaZyHdC+Ri+ZS+yCUD69Xxh2RXt+J5
	Yp5bRcRvIkCSygrejS+wje90CSOyAI8N7lksHhN3lPHTO4WDDUoLVPdS
X-Gm-Gg: ASbGncuO2MXlr4LMfsJYLrTaOWliwPrOWegLd+KNZEE+Hu4+Nlsb/yeBme4NhGwKdPX
	hRWYaqDeL1hgQMsZAHjj+u5XcNY9brIACnh4AhpoTo9FAYv29So1+ZIC8/NFrvywTHEczieAb65
	v9eE2/LRqMQZf648W4TZxJCCnkyPhsQ6zQOzM2tVPDExztHO1gJWu3+416Vyci5U4e66UrKk1zt
	t9pcKg045vzQMooZJ6n6t+2LMoX/8C1ubvkpPC5yK490BFcXt3bN3fK5Amf3i+GRGHkvFN1DUgr
	sROIxdZDnRNzVJ/OVcp22U/czVVDi4JN++3DheJdRQfsprBC7bxcnmuRe/6LAGTOHdIJVTj6S6m
	gDt8gcjRjiiVKTZRgn6oAL7b9rSKzaEmx/cgk20UCEo7kWA==
X-Google-Smtp-Source: AGHT+IG4ZGb8yf+p5wxKOSRz8XD+rbZ0Rt4Q2tBKCEDLguIDZjvSYrqcBCOoMBobxWvD8w7oE6q2fQ==
X-Received: by 2002:a17:90b:3dcc:b0:323:7e7f:d23e with SMTP id 98e67ed59e1d1-3251d5abd98mr6763514a91.18.1755911608508;
        Fri, 22 Aug 2025 18:13:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbc9945sm917383a12.58.2025.08.22.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:13:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Aug 2025 18:13:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/6] genirq/test: Factor out fake-virq setup
Message-ID: <bbd30cfb-eadd-49bd-b01c-6cc88d9243b6@roeck-us.net>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822190140.2154646-3-briannorris@chromium.org>

On Fri, Aug 22, 2025 at 11:59:03AM -0700, Brian Norris wrote:
> We have to repeat a few things in tests. Factor out the creation of fake
> IRQs.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> (no changes since v1)
> 
>  kernel/irq/irq_test.c | 45 +++++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
> index e220e7b2fc18..f8f4532c2805 100644
> --- a/kernel/irq/irq_test.c
> +++ b/kernel/irq/irq_test.c
> @@ -41,15 +41,15 @@ static struct irq_chip fake_irq_chip = {
>  	.flags          = IRQCHIP_SKIP_SET_WAKE,
>  };
>  
> -static void irq_disable_depth_test(struct kunit *test)
> +static int irq_test_setup_fake_irq(struct kunit *test, struct irq_affinity_desc *affd)
>  {
>  	struct irq_desc *desc;
> -	int virq, ret;
> +	int virq;
>  
> -	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
> +	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, affd);
>  	KUNIT_ASSERT_GE(test, virq, 0);
>  
> -	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
>  
>  	desc = irq_to_desc(virq);
>  	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
> @@ -57,6 +57,19 @@ static void irq_disable_depth_test(struct kunit *test)
>  	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
>  	irq_settings_clr_norequest(desc);
>  
> +	return virq;
> +}
> +
> +static void irq_disable_depth_test(struct kunit *test)
> +{
> +	struct irq_desc *desc;
> +	int virq, ret;
> +
> +	virq = irq_test_setup_fake_irq(test, NULL);
> +
> +	desc = irq_to_desc(virq);
> +	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
> +
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  
> @@ -76,17 +89,11 @@ static void irq_free_disabled_test(struct kunit *test)
>  	struct irq_desc *desc;
>  	int virq, ret;
>  
> -	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
> -	KUNIT_ASSERT_GE(test, virq, 0);
> -
> -	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
> +	virq = irq_test_setup_fake_irq(test, NULL);
>  
>  	desc = irq_to_desc(virq);
>  	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
>  
> -	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
> -	irq_settings_clr_norequest(desc);
> -
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  
> @@ -118,17 +125,11 @@ static void irq_shutdown_depth_test(struct kunit *test)
>  	if (!IS_ENABLED(CONFIG_SMP))
>  		kunit_skip(test, "requires CONFIG_SMP for managed shutdown");
>  
> -	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
> -	KUNIT_ASSERT_GE(test, virq, 0);
> -
> -	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
> +	virq = irq_test_setup_fake_irq(test, &affinity);
>  
>  	desc = irq_to_desc(virq);
>  	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
>  
> -	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
> -	irq_settings_clr_norequest(desc);
> -
>  	data = irq_desc_get_irq_data(desc);
>  	KUNIT_ASSERT_PTR_NE(test, data, NULL);
>  
> @@ -181,17 +182,11 @@ static void irq_cpuhotplug_test(struct kunit *test)
>  
>  	cpumask_copy(&affinity.mask, cpumask_of(1));
>  
> -	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
> -	KUNIT_ASSERT_GE(test, virq, 0);
> -
> -	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
> +	virq = irq_test_setup_fake_irq(test, &affinity);
>  
>  	desc = irq_to_desc(virq);
>  	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
>  
> -	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
> -	irq_settings_clr_norequest(desc);
> -
>  	data = irq_desc_get_irq_data(desc);
>  	KUNIT_ASSERT_PTR_NE(test, data, NULL);
>  
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

