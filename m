Return-Path: <linux-kernel+bounces-752316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A244B173EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F88584403
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE001C5D5A;
	Thu, 31 Jul 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vFrEpAyF"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB4156C69
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975631; cv=none; b=I5pw8hTWvkFqkZWFGOcRajM2/GweyszwUm/gT4CQD9kPkJ7OODbX1yzlNJOP2bSKQhcrdDVzt44EPZxqcJyhUtb/D8EPaEbsq00ZrRHNIJynDfPJSOzA7Z6Kr3Qb0+shPml5jB6EhASX2lDp2BUA27b5UVTx0+tMh92aBnimqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975631; c=relaxed/simple;
	bh=ecR16owlk4aVLFMd5u+j15Sqa4upT44qjgEREGStQPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4Gd4fcmdVdcDTogY4XvyTybFsD4H8KMrXs/EoqpIoPtyS6PRBgmjO+2MBVk18+2zHui463oZ9KCJFyexXbEj6QFVEMVn9/tMywzoRHJDdLXdiMJTDIlIdZow1Ng8Adx6rrVu1Nz5HdYcciBse0WJpm+YYzTibSX2Bx6jnk/djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vFrEpAyF; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7074bad0523so5371036d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1753975627; x=1754580427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4pg9j1SEq8vQjGPle5FHzKv/ap1qEHXDcWwxrXohmU=;
        b=vFrEpAyF2XkXbnToBSv7gvEpDPHRlP6fNeOcOhz4uabloUn07YjvewEU1yphBvqnoX
         pbcGd0TNUvF9RsofmEoSFdrK3Gwuvb6MNrSGHAi3exRvk1W/NYgOYd6owV8FNDQGZlok
         mcMNqQ6UVrpEodRZpvdc5vn1XoUq6sF/zzIQFIFamDjF0AQX1aM2oXVZgP/zLfi1Ry7i
         wchNFBqxhLeF8bLNqUtIdQiHwsh6DG/yZ/wNeVjid1vEVUceP2iwkWDSGHNC/y3ekzAJ
         Zg2Q/hWP8DkhdiozR41WoNidFuY+DHpNb9MNil4TjTgX8bE/SJJ2WljYK/wSiQYiFZ50
         rIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975627; x=1754580427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4pg9j1SEq8vQjGPle5FHzKv/ap1qEHXDcWwxrXohmU=;
        b=lREupnFpNN4cGKPR878CcdSwzPJQZjQRZsnLEQyd1BQ9c8JdeP6AxqOm97W9hqr2vF
         w/AP9ZgpcuoXQgvuIYlrMjYhqsq0acKBlVqLyYVayXs7eisqEpFNdNg4MP60oJtOJBft
         F+zN3YtoOdoyGABIjiW2VK9mezQmVp3F9DTmCo+mkH8c9oI0vJy5W5i28lk8b8AoXbIY
         B9DhhELPlPyxN38FKpeBt7XwkLbwREa3RHrH3l1acuKiRCaROHvRxMottSIuq7RDKClH
         DJGUbAU41QiL1catU10Qxe6RyXodbMEAvSnV1G0hMepLfDjFjIFYVwEGh/yws98vUA44
         QZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUuGBTeBHzwlUE4P24y7tlmghxjs43pjELHZ9QPlskuBUFZqWVKxnjZ85KpqP5HQsj1XrMgTaN6LQ+v4lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnEZM2MFmx37x6yI8OHBzZtKeKz4eAxqckJ+qXUQ18Zz7tkUr
	C6cYg47jK3FzYASGDVEYCs7mV7aXRgdsrDlOk+CLsIZeSj8gMZXOe2ZOe0gBOTU3md4=
X-Gm-Gg: ASbGnctb3tQ/6G42+ivNZYztgDJtX8bM9SCSvy+Wbi6kYELeooBMxD7trR4+ESxu+hI
	krsfxmwC/fMv0fvECO5FJ3XlYiBi1NybvbyGZEYWTIzl0fYfW0CqNMm3F9YDCwTP10QFKeyO4MG
	P1OTe4TAUmjt0RUOhqz2go04k2WbfR/7AyJLpcbgnYlazZ5DCymnFjHgCvQB0V+/ftxsGO+tCL5
	7XPJvYgyAVNZWFyqB6KwEyekeJKlpmbEAfUkThI2HHRVqWpdGbc2iA9w1rEkK37Ghs0FF0dT4sy
	6EVkT+KnVKeIbeW2JYnfCH7WweBXNtYv2iw5tduH7InRLPkutsW/ets63zj1SdkgWu7Qwe5l1fF
	/l4HRqHNiwjHGqxmzSK2GgWiyOywoHMcP
X-Google-Smtp-Source: AGHT+IHhDifmV0d/gDdHQwtEHVVScsTm8lEu8Ton90aAMSsO61i5mZMoEKb5oe4dUy/RvmzB9IJg5Q==
X-Received: by 2002:ad4:5d47:0:b0:6fb:3579:8f07 with SMTP id 6a1803df08f44-7076710ffe2mr121804966d6.31.1753975626405;
        Thu, 31 Jul 2025 08:27:06 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077cd710a1sm8467236d6.56.2025.07.31.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:27:05 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:27:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Message-ID: <20250731152701.GA1055539@cmpxchg.org>
References: <20250730234059.4603-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730234059.4603-1-sj@kernel.org>

Hi SJ,

On Wed, Jul 30, 2025 at 04:40:59PM -0700, SeongJae Park wrote:
> When zswap writeback is enabled and it fails compressing a given page,
> zswap lets the page be swapped out to the backing swap device.  This
> behavior breaks the zswap's writeback LRU order, and hence users can
> experience unexpected latency spikes.

+1 Thanks for working on this!

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
> 
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
> 
> Tests
> -----
> 
> I tested this patch using a simple self-written microbenchmark that is
> available at GitHub[1].  You can reproduce the test I did by executing
> run_tests.sh of the repo on your system.  Note that the repo's
> documentation is not good as of this writing, so you may need to read
> and use the code.
> 
> The basic test scenario is simple.  Run a test program making artificial
> accesses to memory having artificial content under memory.high-set
> memory limit and measure how many accesses were made in given time.
> 
> The test program repeatedly and randomly access three anonymous memory
> regions.  The regions are all 500 MiB size, and accessed in same
> probability.  Two of those are filled up with a simple content that can
> easily be compressed, while the remaining one is filled up with a
> content that read from /dev/urandom, which is easy to fail at
> compressing.  The program runs for two minutes and prints out the number
> of accesses made every five seconds.
> 
> The test script runs the program under below seven configurations.
> 
> - 0: memory.high is set to 2 GiB, zswap is disabled.
> - 1-1: memory.high is set to 1350 MiB, zswap is disabled.
> - 1-2: Same to 1-1, but zswap is enabled.
> - 1-3: Same to 1-2, but save_incompressible_pages is turned on.
> - 2-1: memory.high is set to 1200 MiB, zswap is disabled.
> - 2-2: Same to 2-1, but zswap is enabled.
> - 2-3: Same to 2-2, but save_incompressible_pages is turned on.
> 
> Configuration '0' is for showing the original memory performance.
> Configurations 1-1, 1-2 and 1-3 are for showing the performance of swap,
> zswap, and this patch under a level of memory pressure (~10% of working
> set).
> 
> Configurations 2-1, 2-2 and 2-3 are similar to 1-1, 1-2 and 1-3 but to
> show those under a severe level of memory pressure (~20% of the working
> set).
> 
> Because the per-5 seconds performance is not very reliable, I measured
> the average of that for the last one minute period of the test program
> run.  I also measured a few vmstat counters including zswpin, zswpout,
> zswpwb, pswpin and pswpout during the test runs.
> 
> The measurement results are as below.  To save space, I show performance
> numbers that are normalized to that of the configuration '0' (no memory
> pressure), only.  The averaged accesses per 5 seconds of configuration
> '0' was 34612740.66.
> 
>     config            0       1-1     1-2      1-3      2-1     2-2      2-3
>     perf_normalized   1.0000  0.0060  0.0230   0.0310   0.0030  0.0116   0.0003
>     perf_stdev_ratio  0.06    0.04    0.11     0.14     0.03    0.05     0.26
>     zswpin            0       0       1701702  6982188  0       2479848  815742
>     zswpout           0       0       1725260  7048517  0       2535744  931420
>     zswpwb            0       0       0        0        0       0        0
>     pswpin            0       468612  481270   0        476434  535772   0
>     pswpout           0       574634  689625   0        612683  591881   0

zswpwb being zero across the board suggests the zswap shrinker was not
enabled. Can you double check that?

We should only take on incompressible pages to maintain LRU order on
their way to disk. If we don't try to move them out, then it's better
to reject them and avoid the metadata overhead.

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
> + * mitigated by the writeback.  Also, the decompression overhead is optimized.
> + *
> + * When the writeback is disabled, however, the additional overhead could be
> + * problematic.  For the case, just return the failure.  swap_writeout() will
> + * put the page back to the active LRU list in the case.
> + */
> +static int zswap_handle_compression_failure(int comp_ret, struct page *page,
> +		struct zswap_entry *entry)
> +{
> +	if (!zswap_save_incompressible_pages)
> +		return comp_ret;
> +	if (!mem_cgroup_zswap_writeback_enabled(
> +				folio_memcg(page_folio(page))))
> +		return comp_ret;
> +
> +	entry->orig_data = kmalloc_node(PAGE_SIZE, GFP_NOWAIT | __GFP_NORETRY |
> +			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
> +	if (!entry->orig_data)
> +		return -ENOMEM;
> +	memcpy_from_page(entry->orig_data, page, 0, PAGE_SIZE);
> +	entry->length = PAGE_SIZE;
> +	atomic_long_inc(&zswap_stored_uncompressed_pages);
> +	return 0;
> +}

Better to still use the backend (zsmalloc) for storage. It'll give you
migratability, highmem handling, stats etc.

So if compression fails, still do zpool_malloc(), but for PAGE_SIZE
and copy over the uncompressed page contents.

struct zswap_entry has a hole after bool referenced, so you can add a
flag to mark those uncompressed entries at no extra cost.

Then you can detect this case in zswap_decompress() and handle the
uncompressed copy into @folio accordingly.

