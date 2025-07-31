Return-Path: <linux-kernel+bounces-752435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A25B1758E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B4F1C20308
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3A27A12D;
	Thu, 31 Jul 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtEdBgX2"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7F25B1EA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982414; cv=none; b=MMCvn/8STmG+RAipKC93yvHKCion/aTSt1zf/5u6ZJzu/p+4ySjll5JXePmfs2nMeJGT3SvNzfp68zka00LpBCog7S48rSRssLSVcU2orFyBkQHlfj7jYw/EkhKZm9RF/aE5EwDUrzPRh71bqRxyKMH27UMKMeChYc3PKqOJKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982414; c=relaxed/simple;
	bh=sW3ZHfe3Jqa6hAcYkJyX9RCeQ0A/ZEX+uAGOaEht9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne/IQYdTXHoATXVlTCid1HG5fZjXg1O2q0vDddciydr8bWwG1Sl7PxVRmSk/37JZTDX3HyPDcbfkJM1x98ES6MJq3QVp5360PFTtDaQ9S8X0Fvm0GAbMLMTYYM2bNfwvtf4M0PuYNgJ7IYviO5+yL7KiPoVYqyranzifGOBnz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtEdBgX2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-718389fb988so12705807b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753982412; x=1754587212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6nAbG39Z1jFnWom2CgJ69NEBgVbiO+leBKVM9T+DMw=;
        b=NtEdBgX2FK3I41dbYp4KZs2m4+PVKVRwbPqXzAVS9GaSKescpTORCHaK4L1/ozLzaV
         rYx94+jQzAKSOUwxwj9zkxJa04zluEpeKXMcPf0dv8wRnpiAWLCz/7eoeblzQqW0kNcW
         /+8T1hPPwlE5+4en81ozC4ibCp+pA/SECale8qvar03HoFlfCc2C9xY8G4KJZA1+lUux
         qHlcgvM1ErmBsnstf88UgTuK3APRj6RDpEIBr72kmB5qlyTyLErDO2xqqZTpepgUo+QY
         Fv+WZBxSLnEbIsjfh/k8mPM38CG9KBYr2A6t8QdnVshN9ZHL07bFmhQUzdekhH2EVo/F
         LjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982412; x=1754587212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6nAbG39Z1jFnWom2CgJ69NEBgVbiO+leBKVM9T+DMw=;
        b=rS5b2BC1h8+W6bXyfGeukSZP1rUNdZmRQgNNxYiTVKSSisnfXrYulZl1pYfJqry15Z
         nAwONsyyLKxX7MRGpEhK4q5ohVT8RQrWf9xCne5twStQyCaD8wmxYMyA/ZYHQLeYworR
         +sD+qWAQTGtRmSpCo7G1aOQwd+AonhM4WAYTpIBrwoTU63Q5POEDWbkZrb23G0HdHmox
         Di4dOH2OUQ3keNcPEeujlb9PVbYb8dMYllnoBdfktup5hxYja+NbAZYMTOuI0VMiLfKJ
         sAjcl5rsBBcfJMxwgek57w9sLdeFWkKHzYwIfCf0U4oXVY2FlW9T3cU4O/L38caGBcSC
         92bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWSve9rwIUGfRmqaPUxo/8EdTeLz9oJXj/Un8tw3xSpl2cUN/mlClZRttAAheAOkdkbV8Q7Lhe3EawIAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDpOnMWTiKHwfwP4Rs318OonY6g7y/r0Th8P0Nu8B7eG4KIgP
	CifitXLUKg6mD7icCqq6xf386NyMq4HEsyY1CteyBnNi+nvKQng+P9wT
X-Gm-Gg: ASbGnctw6niNiXDeFdYMjCVecFnds3huUs4NcngH+/fS6u3wr7TPNoEedDaIaQiVMrd
	hqtwQB4xZaerZDoGqwmPnAaEWKmMvM3OttCkJSU2rFW58Z4iKLlb+QpPg41KcdOpXDHMx4USMYw
	O6CZaL/lngK36fxsEg10J8EuBAWn0gEEEq4gzTHRAAuvBFB6ppoeC5WzH3GTbQELXa8h/SHveRy
	R3MeoCPHNwkggmqKMkEkZOyidGvhxwwNEjJ89IdRwrJil9gP/tz/nDOX8GNlpFZj7kecafP9B79
	nT67N8tkgfBNlIqY56t0Rnxn/yL6P5YvLosSPXC7lnW9Xfyp67wep0T+WGLF7RTPMttHYuVbjrz
	k4grepDkVI9udUvdTLv7Q
X-Google-Smtp-Source: AGHT+IHX8dsmmfnYqaV/26i9WDGI+PlUI9lsnzW1uGXze00lTlb0Qq/X5fisNvODFFIFJ6O/oC4rHA==
X-Received: by 2002:a05:690c:6707:b0:710:e4c4:a92f with SMTP id 00721157ae682-71a46521feemr86511047b3.5.1753982411679;
        Thu, 31 Jul 2025 10:20:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f9eb4sm4798327b3.25.2025.07.31.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:20:11 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Thu, 31 Jul 2025 10:20:05 -0700
Message-ID: <20250731172009.108025-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250730234059.4603-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 16:40:59 -0700 SeongJae Park <sj@kernel.org> wrote:

Hi SJ, thank you for your patch! This is a really cool idea : -)

> When zswap writeback is enabled and it fails compressing a given page,
> zswap lets the page be swapped out to the backing swap device.  This
> behavior breaks the zswap's writeback LRU order, and hence users can
> experience unexpected latency spikes.
> 
> Keep the LRU order by storing the original content in zswap as-is.  The
> original content is saved in a dynamically allocated page size buffer,
> and the pointer to the buffer is kept in zswap_entry, on the space for
> zswap_entry->pool.  Whether the space is used for the original content
> or zpool is identified by 'zswap_entry->length == PAGE_SIZE'.
> 
> This avoids increasing per zswap entry metadata overhead.  But as the
> number of incompressible pages increases, zswap metadata overhead is
> proportionally increased.  The overhead should not be problematic in
> usual cases, since the zswap metadata for single zswap entry is much
> smaller than PAGE_SIZE, and in common zswap use cases there should be
> sufficient amount of compressible pages.  Also it can be mitigated by
> the zswap writeback.

I think one other benefit that is worth mentioning here is that by moving
the incompressible pages to the zswap LRU, we prevent wasting CPU cycles
on pages that have not changed since their last compression attempt.

This concern is a real concern that we have seen manifest as wasted cycles
in zswap wasted on trying to compress the same pages over and over again,
and failing each time. This is also made worse by the fact that wasted CPU
cycles are bad, but even worse when we are reclaiming and must free up memory!

> When the memory pressure comes from memcg's memory.high and zswap
> writeback is set to be triggered for that, however, the penalty_jiffies
> sleep could degrade the performance.  Add a parameter, namely
> 'save_incompressible_pages', to turn the feature on/off as users want.
> It is turned off by default.
> 
> When the writeback is just disabled, the additional overhead could be
> problematic.  For the case, keep the behavior that just returns the
> failure and let swap_writeout() puts the page back to the active LRU
> list in the case.  It is known to be suboptimal when the incompressible
> pages are cold, since the incompressible pages will continuously be
> tried to be zswapped out, and burn CPU cycles for compression attempts
> that will anyway fails.  But that's out of the scope of this patch.

Indeed, and your patch fixes this problem, at least for the writeback
enabled case!

[...snip...]

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7e02c760955f..e021865696c6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -45,6 +45,9 @@
>  /* The number of compressed pages currently stored in zswap */
>  atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
>  
> +/* The number of uncompressed pages currently stored in zswap */
> +atomic_long_t zswap_stored_uncompressed_pages = ATOMIC_LONG_INIT(0);
> +
>  /*
>   * The statistics below are not protected from concurrent access for
>   * performance reasons so they may not be a 100% accurate.  However,
> @@ -129,6 +132,11 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
>  		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
>  
> +/* Store incompressible pages as is */
> +static bool zswap_save_incompressible_pages;
> +module_param_named(save_incompressible_pages, zswap_save_incompressible_pages,
> +		bool, 0644);
> +
>  bool zswap_is_enabled(void)
>  {
>  	return zswap_enabled;
> @@ -190,7 +198,8 @@ static struct shrinker *zswap_shrinker;
>   *              writeback logic. The entry is only reclaimed by the writeback
>   *              logic if referenced is unset. See comments in the shrinker
>   *              section for context.
> - * pool - the zswap_pool the entry's data is in
> + * orig_data - uncompressed original data of the page, if length is PAGE_SIZE
> + * pool - the zswap_pool the entry's data is in, if length is not PAGE_SIZE
>   * handle - zpool allocation handle that stores the compressed page data
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
> @@ -199,7 +208,10 @@ struct zswap_entry {
>  	swp_entry_t swpentry;
>  	unsigned int length;
>  	bool referenced;
> -	struct zswap_pool *pool;
> +	union {
> +		void *orig_data;
> +		struct zswap_pool *pool;
> +	};
>  	unsigned long handle;
>  	struct obj_cgroup *objcg;
>  	struct list_head lru;
> @@ -500,7 +512,7 @@ unsigned long zswap_total_pages(void)
>  		total += zpool_get_total_pages(pool->zpool);
>  	rcu_read_unlock();
>  
> -	return total;
> +	return total + atomic_long_read(&zswap_stored_uncompressed_pages);
>  }
>  
>  static bool zswap_check_limits(void)
> @@ -805,8 +817,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
>  	zswap_lru_del(&zswap_list_lru, entry);
> -	zpool_free(entry->pool->zpool, entry->handle);
> -	zswap_pool_put(entry->pool);
> +	if (entry->length == PAGE_SIZE) {
> +		kfree(entry->orig_data);
> +		atomic_long_dec(&zswap_stored_uncompressed_pages);
> +	} else {
> +		zpool_free(entry->pool->zpool, entry->handle);
> +		zswap_pool_put(entry->pool);
> +	}
>  	if (entry->objcg) {
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>  		obj_cgroup_put(entry->objcg);
> @@ -937,6 +954,36 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
>  	mutex_unlock(&acomp_ctx->mutex);
>  }
>  
> +/*
> + * If the compression is failed, try saving the content as is without
> + * compression, to keep the LRU order.  This can increase memory overhead from
> + * metadata, but in common zswap use cases where there are sufficient amount of
> + * compressible pages, the overhead should be not ciritical, and can be

					      NIT: s/ciritical/critical/?

> + * mitigated by the writeback.  Also, the decompression overhead is optimized.
> + *
> + * When the writeback is disabled, however, the additional overhead could be
> + * problematic.  For the case, just return the failure.  swap_writeout() will

					           NIT: s/  / /?

[...snip...]

And I think Nhat and Johannes have covered the other concerns.

Thanks again SJ for working on this, I hope you have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

