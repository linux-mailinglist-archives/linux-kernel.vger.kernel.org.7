Return-Path: <linux-kernel+bounces-739060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C70B0C141
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2BA3A7E35
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C228F534;
	Mon, 21 Jul 2025 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnQkshEM"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A31DE3CB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093656; cv=none; b=DHNwl4zIG11QVscpapLhTx46mbcy4H7mPY1OvyoN3oQ5zfWuoJdNbB5Id2ARdeXB8fFvKNzeoTp4oTpV4uQSe82JT0s7U04NB3f/UhfUk8by49rpEeQiB9h9rkcs9K8mcIycQOfkb+ldEFxGc2pyAd/X88vjmZLUmUC/Z4p/OPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093656; c=relaxed/simple;
	bh=AW/4itnPY32Sho1nYBj36W6S8mEbDpq3uo8svbqn6ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHMzWDAvvv+KSWXgYkujUFDwD+1Jn6K+s1kD9mE/UOO0p/l/lzRxEeII0m5JTq16sK/WKNDNIBjW4atXjGko+RZIkFKyx01xVpz/DMlYr4EQEeGH1vZoZ+DbjC8jIqRD0uG5N6hXUOQEyMRV3KtTe3T/3ml9NlsP7+ojb3QYFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnQkshEM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2978803a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753093654; x=1753698454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhXCOZdCTK+rp5PK/GDZrJoAVepARcz/eMC1pojYzP0=;
        b=RnQkshEM975vDqUqg7KhaNbf1+Dwlx6/qMYE5kY+4W7fVx1lmiGvtnNg4DFwJurPo+
         ne+gAVsSan0JhsFk+oCEde5EtX2ExgQwfSK/mYKAluptWIzKUS3BASxuSf8z/V0ClsXf
         u/GppBqpIsr7x8PnX7Px6pFqdN+z+X2CrycuCgclAWeSw3OE+KxgEWy4VZ/GyWTRf+aK
         GQegKqLpdX44sALY6A+4aXQFU1VHjk78GNpgdBYajAVCQBpQpyvhe6HCnCupMsmzqwYx
         ygOHSjyg9qaPTE5zzB0DaAA6xaXCnvm9/IxU/QJYKlf/fRNuPp+wplDKHiK0fgNaM3wJ
         j6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753093654; x=1753698454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhXCOZdCTK+rp5PK/GDZrJoAVepARcz/eMC1pojYzP0=;
        b=Bzr+qCn/goBj5uKGr1a4d+GDDxaw/hrW+DY+kvAgFciwEGlDLjgrDXekXo0wGNdhv6
         kAJFiTpkDBtlD33zUhYTwzyYWMINpUeWpnwbrOu+hnlgsdWVq8ovHE3Z8WveIawupZU6
         FMLhcxZA/tpM/2pxwfuOCNKvq8StAxdoRJNsaXQJ4xXwxttNwCQ/1pcro1PCCm6P4Tqx
         Kbz0eNrU6jc7r8017XZVANA1xXyXaytu3rcjhAt4JGvi2q9zEghdrOFwAa4V/QzIQz5M
         ITu5FktpByW3NcLrtH4OwpB4l+Fn+1jo1v04EZALYGbi84uONIkdeCNh5z/rugcy30zT
         wLKg==
X-Forwarded-Encrypted: i=1; AJvYcCX9mETUX9Z34hVJU6IwyCW47QTG69xICX/f/uTi73S1Xdac2ped2P5tYe0PcbUjIkYr0iy0x2LU/C7ZyhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1xFnwAhIhaC1prgefBPPwB0WymrVtMopHUlhhCO7BT109fBG
	D+8kYLqAwMK8RPl+J1FLfGoxdQUaTzHB+8apzLMlwgcW0drP3sZ6c0EwDuHj2f0lynLNOOcuRAf
	FQyhk21qTTL3yVARUtNmqXI6u5oW4HqTOBLzfYtng
X-Gm-Gg: ASbGncvaRd5h2JyRLwJ+MTzzSAwDgButBR7/xW15v1LO7esGFNRBFk8ywpueBmYRYwL
	jLLd/cMefnc0ZvhFN5yJCQQ8P9VWXWS/phEaXcxd3294B4nhETSAFHye0jFWxQdLHC3PyxkdpnB
	5QfVSOLy3YDDWxJtJRp3eT5ulYJZlxzGD8MAZ5/wsuKyg7mJ2n9WfbquIpqD5fEqumztsECEbi/
	lYPiyCG0GfR3IblQFclBnTRH2968aoN8nFqA2Y=
X-Google-Smtp-Source: AGHT+IHuI+F3IdOAl30wXx584vyzb62/wfKDdXsodUB5b5oeH0IA23V9/za8uBIgQWcLJKM1hapMe94IIK8Y9EfKG4I=
X-Received: by 2002:a17:90b:47:b0:311:b005:93d4 with SMTP id
 98e67ed59e1d1-31c9e778b03mr26573909a91.25.1753093653957; Mon, 21 Jul 2025
 03:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718153928.94229-1-matt@readmodwrite.com>
In-Reply-To: <20250718153928.94229-1-matt@readmodwrite.com>
From: Marco Elver <elver@google.com>
Date: Mon, 21 Jul 2025 12:26:57 +0200
X-Gm-Features: Ac12FXwmL5CpD_s8wwlgrDclkIOMKXETuyy3ojr83mYiTnBEmk8mzDdTf13vE_w
Message-ID: <CANpmjNOYwy4h9zWJVFANO6geakvcyccppNfFjs7qwSwmLpFLYQ@mail.gmail.com>
Subject: Re: [PATCH v4] stackdepot: Make max number of pools boot-time configurable
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 17:39, Matt Fleming <matt@readmodwrite.com> wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> We're hitting the WARN in depot_init_pool() about reaching the stack
> depot limit because we have long stacks that don't dedup very well.
>
> Introduce a new start-up parameter to allow users to set the number of
> maximum stack depot pools.
>
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Acked-by: Marco Elver <elver@google.com>

Minor improvement suggestions below (at your discretion).

Thanks!

> ---
>
> Changes in v4:
>  - Simplify initial stack_max_pools value courtesy of akpm
>
> Changes in v3:
>  - Switch from build-time to boot-time parameter
>
> Changes in v2:
>  - Replace BUILD_BUG_ON with static_assert()
>  - Hide STACKDEPOT_MAX_POOLS behind EXPERT
>
>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  lib/stackdepot.c                              | 67 ++++++++++++++++---
>  2 files changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 07e22ba5bfe3..273f6bbd56c2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6988,6 +6988,11 @@
>                         consumed by the stack hash table. By default this is set
>                         to false.
>
> +       stack_depot_max_pools= [KNL,EARLY]
> +                       Specify the maximum number of pools to use for storing
> +                       stack traces. Pools are allocated on-demand up to this
> +                       limit. Default value is 8191 pools.
> +
>         stacktrace      [FTRACE]
>                         Enabled the stack tracer on boot up.
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 73d7b50924ef..de0b0025af2b 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -36,11 +36,11 @@
>  #include <linux/memblock.h>
>  #include <linux/kasan-enabled.h>
>
> -#define DEPOT_POOLS_CAP 8192
> -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
> -#define DEPOT_MAX_POOLS \
> -       (((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> -        (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> +/*
> + * The pool_index is offset by 1 so the first record does not have a 0 handle.
> + */
> +static unsigned int stack_max_pools __read_mostly =

This could be __ro_after_init.

> +       MIN((1LL << DEPOT_POOL_INDEX_BITS) - 1, 8192);
>
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
> @@ -62,7 +62,7 @@ static unsigned int stack_bucket_number_order;
>  static unsigned int stack_hash_mask;
>
>  /* Array of memory regions that store stack records. */
> -static void *stack_pools[DEPOT_MAX_POOLS];
> +static void **stack_pools;
>  /* Newly allocated pool that is not yet added to stack_pools. */
>  static void *new_pool;
>  /* Number of pools in stack_pools. */
> @@ -101,6 +101,34 @@ static int __init disable_stack_depot(char *str)
>  }
>  early_param("stack_depot_disable", disable_stack_depot);
>
> +static int __init parse_max_pools(char *str)
> +{
> +       const long long limit = (1LL << (DEPOT_POOL_INDEX_BITS)) - 1;
> +       unsigned int max_pools;
> +       int rv;
> +
> +       rv = kstrtouint(str, 0, &max_pools);
> +       if (rv)
> +               return rv;
> +
> +       if (max_pools < 1024) {
> +               pr_err("stack_depot_max_pools below 1024, using default of %u\n",
> +                      stack_max_pools);

nit: I feel the choice of 1024 should be somewhat more documented,
because right now it looks like a magic value.

> +               goto out;
> +       }
> +
> +       if (max_pools > limit) {
> +               pr_err("stack_depot_max_pools exceeds %lld, using default of %u\n",
> +                      limit, stack_max_pools);
> +               goto out;
> +       }
> +
> +       stack_max_pools = max_pools;
> +out:
> +       return 0;
> +}
> +early_param("stack_depot_max_pools", parse_max_pools);
> +
>  void __init stack_depot_request_early_init(void)
>  {
>         /* Too late to request early init now. */
> @@ -182,6 +210,17 @@ int __init stack_depot_early_init(void)
>         }
>         init_stack_table(entries);
>
> +       pr_info("allocating space for %u stack pools via memblock\n",
> +               stack_max_pools);
> +       stack_pools =
> +               memblock_alloc(stack_max_pools * sizeof(void *), PAGE_SIZE);

Bike-shedding territory: Kernel allows up to 120 cols if it helps
readability. Line-break-assignments just look wrong and clang-format
should be fixed. Regardless, I know some folks just want to follow
what clang-format suggests without much consideration for readability.

> +       if (!stack_pools) {
> +               pr_err("stack pools allocation failed, disabling\n");
> +               memblock_free(stack_table, entries * sizeof(struct list_head));
> +               stack_depot_disabled = true;
> +               return -ENOMEM;
> +       }
> +
>         return 0;
>  }
>
> @@ -231,6 +270,16 @@ int stack_depot_init(void)
>         stack_hash_mask = entries - 1;
>         init_stack_table(entries);
>
> +       pr_info("allocating space for %u stack pools via kvcalloc\n",
> +               stack_max_pools);
> +       stack_pools = kvcalloc(stack_max_pools, sizeof(void *), GFP_KERNEL);
> +       if (!stack_pools) {
> +               pr_err("stack pools allocation failed, disabling\n");
> +               kvfree(stack_table);
> +               stack_depot_disabled = true;
> +               ret = -ENOMEM;
> +       }
> +
>  out_unlock:
>         mutex_unlock(&stack_depot_init_mutex);
>
> @@ -245,9 +294,9 @@ static bool depot_init_pool(void **prealloc)
>  {
>         lockdep_assert_held(&pool_lock);
>
> -       if (unlikely(pools_num >= DEPOT_MAX_POOLS)) {
> +       if (unlikely(pools_num >= stack_max_pools)) {
>                 /* Bail out if we reached the pool limit. */
> -               WARN_ON_ONCE(pools_num > DEPOT_MAX_POOLS); /* should never happen */
> +               WARN_ON_ONCE(pools_num > stack_max_pools); /* should never happen */
>                 WARN_ON_ONCE(!new_pool); /* to avoid unnecessary pre-allocation */
>                 WARN_ONCE(1, "Stack depot reached limit capacity");
>                 return false;
> @@ -273,7 +322,7 @@ static bool depot_init_pool(void **prealloc)
>          * NULL; do not reset to NULL if we have reached the maximum number of
>          * pools.
>          */
> -       if (pools_num < DEPOT_MAX_POOLS)
> +       if (pools_num < stack_max_pools)
>                 WRITE_ONCE(new_pool, NULL);
>         else
>                 WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
> --
> 2.34.1
>

