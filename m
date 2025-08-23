Return-Path: <linux-kernel+bounces-782861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF466B32622
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40635C707B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885718FDDB;
	Sat, 23 Aug 2025 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOEKyf30"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042D2B9B7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911621; cv=none; b=mQzElPa89DMNYMkY2Se0i2rLFxx7wT2EUhLfsJ/oQfbdm8doHUqXCyyspvwr14vujRBZaF/PSwBPzKD1Z8Pr5XoSeZhC6Bn7/leBt9MZR4ZjR9WFRbaOelgiDJy42unn1AZU0dQI5zeu2gBdL1xHd6EAYquTcFWMrwB65P300+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911621; c=relaxed/simple;
	bh=RVLKjjZLdx8yvrmAw16b56ireGELPgtEDeceEtuX9g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMiBSZdXuwrwLgP0zURq7q5ae3Ve4M/5M/h9+jRzX66PvU6FBB2+ni+8be3GGP/BaaSbsEl1vYcL9miLZgB2c+AbdN2Zntpqpp6dd7mwbOkXg1jbKfytP+3EqH5WmpHLjKs/JrJZzm1R+NDYVX5DmWohzqVy+9uKMDjkdx5KnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOEKyf30; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-245fd2b63f8so26535165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911617; x=1756516417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QoZ3TofrcVoIvKwU0vK7vJwa9rmGdByuy9bMZQGk58=;
        b=OOEKyf30EVs+1cuRWhCiBEEnMWLxZEEkUADC4s5gfNb557OoIZqEtr+qUm1sqA9aKq
         sDKM2kvGJOAP+uv0FUozcuwl+oMNYMlIl6Y8NzTVeG8+rLzrr6RB5QQ1p72YQslqECXN
         LlVYnZ6vKOb5rcYD07TAKf/yyTqV2ItiODOPsM/1VwvTnxS3LBQUcyeaui428l7LN3w7
         MSoaAxmn70mAb7cUs/aXsky1zZRejNmu02gzn/o6dKVHNQGgHZwhuX0un9vKAd/91JFc
         bc+UK4dg0ECAhNCiNqlqlzcta1q3PNkjL/1voQ+FbB0HOajea2C1bufQ2Al1tvMJFmbc
         SsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911617; x=1756516417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QoZ3TofrcVoIvKwU0vK7vJwa9rmGdByuy9bMZQGk58=;
        b=cUO14ItQqNCRsuqaZ50ehfSqEv/kcNAvI5L+7rjzhkgqAz+Srz4K0xw0naK/Y7BJk9
         OJck7Zal1h1G971urKzAia8t8xppiHnQROIKDpFwmnq7gzK/tDdD4Iw9ltcd/7OEmRvX
         K55cmNpswuxM2F2pOzsOsvEij1SpVR+pygC1u7tAHoJJdotT6M2GAlrgQv/2F75gM9c6
         pBwrIQ3B/9PJNOdHbedkPSaX+PHg2S8xupgx4gcTGjoY6ho+BzlSuUYRFbagQwkfGH0U
         LU3iOWSbY0SxEcKmQ7me895lHrdDJ9C/zorO5OvKxfzvBqwXbay5gqo808wba3XX/UC/
         zMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0Tw5vgc91ihj2sMCff0qIPpzbKT8Hmxs9NITUOMa4CDG2wfRWd8l7IDZTYXOJGILqEWZeu2DNoF3jCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Zm51jr1zUcHfNokVeOf1Pp7wlLsHQb7hja8f8E2zwJEsieHE
	LkHLxHgMQj6LDN3eXgu9F4ZAc8UwuDT8RFTEBSfxVBdSowGJdC3fD+62
X-Gm-Gg: ASbGnctTakZP4pOeuhcPlAU8piw5mPen6L/9y6GkCCO/wvXx2udwJmxp5a4tH2Lb+8L
	KbkYjHzvP5qKe15tDWYD8PWWdaL04B6gxVFUXyzcFlOQmUtpDISPIjdca4oNl6Wl7f5fThXcsLp
	U3UkN8qQngTIe474kaLbPOz0Nmu8RxeWqrLMRsxaVK9vbGfmto8dg4ABMZ+FnptNOJQzlWTb7dq
	gGDqddw/Yyc3daXTxMxzWZB2iwkxQAUwX0f7+RCegxWoC6H2MkGtmrVMFTz8EN+s/5hUOmm7G7W
	3PdtZM31yLnZOs0ZLZyK8IOgsr7eqCWnj7NTCJyzvTzjRlUjXmCKOfGUAc3S/fYB/tuXwM1UB4s
	n0ITk6+4Xu7NlsmASJTJx6EK3M+kxnI2VAGc=
X-Google-Smtp-Source: AGHT+IFwZeKarCGNYRWu3YsRiMLpfDki1BFBVBIo586EqA3YIs6Fs0u3vFmpNvOnJJTKTaUgsY/jOg==
X-Received: by 2002:a17:903:2f08:b0:246:3583:394d with SMTP id d9443c01a7336-2463583555emr60370255ad.29.1755911616542;
        Fri, 22 Aug 2025 18:13:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688643a2sm8168445ad.83.2025.08.22.18.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 18:13:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Aug 2025 18:13:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 3/6] genirq/test: Fail early if we can't request an IRQ
Message-ID: <7071c813-538b-4f57-8a71-2ca77ee70bfd@roeck-us.net>
References: <20250822190140.2154646-1-briannorris@chromium.org>
 <20250822190140.2154646-4-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822190140.2154646-4-briannorris@chromium.org>

On Fri, Aug 22, 2025 at 11:59:04AM -0700, Brian Norris wrote:
> Requesting the IRQ is part of basic setup of the test. If it fails, most
> of the subsequent tests are likely to fail, and the output gets noisy.
> Use "assert" to fail early.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: David Gow <davidgow@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> (no changes since v1)
> 
>  kernel/irq/irq_test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
> index f8f4532c2805..56baeb5041d6 100644
> --- a/kernel/irq/irq_test.c
> +++ b/kernel/irq/irq_test.c
> @@ -71,7 +71,7 @@ static void irq_disable_depth_test(struct kunit *test)
>  	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
>  
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_EQ(test, desc->depth, 0);
>  
> @@ -95,7 +95,7 @@ static void irq_free_disabled_test(struct kunit *test)
>  	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
>  
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_EQ(test, desc->depth, 0);
>  
> @@ -106,7 +106,7 @@ static void irq_free_disabled_test(struct kunit *test)
>  	KUNIT_EXPECT_GE(test, desc->depth, 1);
>  
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>  	KUNIT_EXPECT_EQ(test, desc->depth, 0);
>  
>  	free_irq(virq, NULL);
> @@ -134,7 +134,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
>  	KUNIT_ASSERT_PTR_NE(test, data, NULL);
>  
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
>  	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
> @@ -191,7 +191,7 @@ static void irq_cpuhotplug_test(struct kunit *test)
>  	KUNIT_ASSERT_PTR_NE(test, data, NULL);
>  
>  	ret = request_irq(virq, noop_handler, 0, "test_irq", NULL);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
>  	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

