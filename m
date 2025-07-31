Return-Path: <linux-kernel+bounces-751437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515EB169A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B953B2CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050018641;
	Thu, 31 Jul 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVGayxLg"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A413440C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921319; cv=none; b=EGQZP/NbtBwwB+F40uISv0T/CWr390ykAu7XPW/hh6jS/MBH0hd2rPu2Pp0g18JGKsQl3KJhvONPZLdetxPXhxWsz+jmtrXjtsiTWiOTnBwhjMN6PXI48BP0fLHMiP52OwTQGTy4fsGWsu4GFckt3XTquPPD3AFBfvsgwNdMEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921319; c=relaxed/simple;
	bh=LUFKRp4oIKanWbnkRx8xszQ6YG+gET6Ghc9D+W0oTz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIJooGzbUCBgK0jBYSoEUQsLm47aZYfSjP58LfIJkjmjgNAW/SJfMgEw3tKOcG/6VLfy76fdn/dyUUCNxB6zOtrtVMiJ8JbbDXy8v0eB50w+g+3WZAqUU7D0cV9/9sKgxBApUaavNsRL7RVWw8QEI4O/jZAuFPwkOerdwPdUREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVGayxLg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70749d4c5b5so3247516d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753921316; x=1754526116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qmscoAnHoIG6R5YX9cX4pv/hC+euWOdOfPTfLGXkZQ=;
        b=GVGayxLg5LFu3Fgh1NPuA848wpo3NqmsJQzMMcWmzaSEiHm3XISeBTzLB1Sk5c1ChK
         fzTi6l3CCeCYPb+GDfcdaSCXA7VovX6I759suJxvwA7X/ODCrvjX8tVJwi4uqofqWbUp
         GJcG4mrvZjssweTRXgXj0oZH5tlOgq3pjpvCiJGoNuU7fYXBGDRjtZZJ9WsTox6R+JUZ
         CP4fZ1j2FOhvU9X+TupP6TYXN6DDQU0VrguJ757T7KQ3jsWyG3dHJEMwZEQT4zZ0rGyl
         p4axy6ioQd5YuH/TiGPYimpqIPy3UJJt1BHfnfFrUCej7eSvCJFfbyseseB3nb3VdOLS
         0QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753921316; x=1754526116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qmscoAnHoIG6R5YX9cX4pv/hC+euWOdOfPTfLGXkZQ=;
        b=NcqD+dJ7/nrcg0pNgwfQOQXGge05pgKZbFcpfvtAJ4XAAxxHA+rwstG/A9CVBu2ksY
         YnXkPErfde41eeyUnnbZAu7HlEmK0Y62zgq9fEea9F71xN8ORhh+FhzkdBGONgJeSbyS
         5nRtdx8O73cCyX+3ZBEdRR7xrO85iXhlSbpE/s5sbR1Uvt0pCRFEcK6t7grNqWXhF5kX
         AXMWCcBu4LpQXIqRRFTfrblRBIpc319USg51bMpYNJKkowEEQ/H9IFFOQ6SKIN5PP8Uz
         9G0JLTzVVJodiRaHDW7OU6gYHn8UnKJZWXk9T+85yCVAAw5UF7sJ+aJZvcfsNTNBwFeI
         T+3A==
X-Forwarded-Encrypted: i=1; AJvYcCWy1FegE9fpeH/cDRRGPwVbGtvwl9In3SaTvm0jmdaBXtQOG1B73bpvDIWchB7DUCPx/Rkarv+gtA2/BHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2o12MYB5PS6twaa5EQP3bVF2Trvba7/7uI45yXF7TjLMcpzp
	EVQaB6UkVDjFdXf19uzO+m4QYTMnOilCmq9yeeAft7l2w3KxmrYQucWWikyQ/oWFnaimrHoxBon
	f56E3v4ohh90XS1k4iz28iJ8Gq7Y1gjd+Ic+m3UY=
X-Gm-Gg: ASbGncshecQKkz4+wEQ+gDEuwKNDtnng8IHHVN299gwmlYzxIOT94YhPRLcHJJmXYn4
	sZY5EOTaCkbI85shEIZQ0YRe7M0xl3WjnlrDHyV6hN1LJXqVon8lzzvUjKsmv01I+25UUXcwkYy
	NDlMOds7ft3IqV/RRONa8CaFQXFg0HaMYEGcDxd1LBSxHsfLH5VpGsEZSegUg9mrdujELThWxcn
	7yhRcLx6Pt5H8doP5R7dQw=
X-Google-Smtp-Source: AGHT+IHN0TBag0QSsRSDWduzkIy6OUCRFCvdWPD/ebsFVUtkWO66aGV1VB+eze/GZl6PA2FIIunq5q3QZUkVWLrKslU=
X-Received: by 2002:a05:6214:234f:b0:704:f4bf:10a7 with SMTP id
 6a1803df08f44-7076749b2e0mr101386936d6.45.1753921315869; Wed, 30 Jul 2025
 17:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730234059.4603-1-sj@kernel.org>
In-Reply-To: <20250730234059.4603-1-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 30 Jul 2025 17:21:44 -0700
X-Gm-Features: Ac12FXwvSN2M-LuRuvhR722berBf026bW1H7fvE13_q77egRGP0G5YrVLDFcVj4
Message-ID: <CAKEwX=NC65XCkmX1YzivEJtPc+sEJ3pLHUsYhF60QJnk_OtpVw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Takero Funaki <flintglass@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:41=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> When zswap writeback is enabled and it fails compressing a given page,
> zswap lets the page be swapped out to the backing swap device.  This
> behavior breaks the zswap's writeback LRU order, and hence users can
> experience unexpected latency spikes.
>
> Keep the LRU order by storing the original content in zswap as-is.  The
> original content is saved in a dynamically allocated page size buffer,
> and the pointer to the buffer is kept in zswap_entry, on the space for
> zswap_entry->pool.  Whether the space is used for the original content
> or zpool is identified by 'zswap_entry->length =3D=3D PAGE_SIZE'.
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
>     config            0       1-1     1-2      1-3      2-1     2-2      =
2-3
>     perf_normalized   1.0000  0.0060  0.0230   0.0310   0.0030  0.0116   =
0.0003
>     perf_stdev_ratio  0.06    0.04    0.11     0.14     0.03    0.05     =
0.26
>     zswpin            0       0       1701702  6982188  0       2479848  =
815742
>     zswpout           0       0       1725260  7048517  0       2535744  =
931420
>     zswpwb            0       0       0        0        0       0        =
0
>     pswpin            0       468612  481270   0        476434  535772   =
0
>     pswpout           0       574634  689625   0        612683  591881   =
0
>
> 'perf_normalized' is the performance metric, normalized to that of
> configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
> deviation of the averaged data points, as a ratio to the averaged metric
> value.  For example, configuration '0' performance was showing 6% stdev.
> Configurations 1-2 and 1-3 were having about 11% and 14% stdev.  So the
> measurement is not very stable.  Please keep this in your mind when
> reading these results.  It shows some rough patterns, though.
>
> Under about 10% of working set memory pressure, the performance was
> dropped to about 0.6% of no-pressure one, when the normal swap is used
> (1-1).  Actually ~10% working set pressure is not a mild one, at least
> on this test setup.
>
> By turning zswap on (1-2), the performance was improved about 4x,
> resulting in about 2.3% of no-pressure one.  Because of the
> incompressible pages in the third memory region, a significant amount of
> (non-zswap) swap I/O operations were made, though.
>
> By enabling the incompressible pages handling feature that is introduced
> by this patch (1-3), about 34% performance improvement was made,
> resulting in about 3.1% of no-pressure one.  As expected, compression
> failed pages were handled by zswap, and hence no (non-zswap) swap I/O
> was made in this configuration.
>
> Under about 20% of working set memory pressure, which could be extreme,
> the performance drops down to 0.3% of no-pressure one when only the
> normal swap is used (2-1).  Enabling zswap significantly improves it, up
> to 1.16%, though again showing a significant number of (non-zswap) swap
> I/O due to incompressible pages.
>
> Enabling the incompressible pages handling feature of this patch (2-3)
> reduced non-zswap swap I/O as expected, but the performance became
> worse, 0.03% of no-pressure one.  It turned out this is because of
> memory.high-imposed penalty_jiffies sleep.  By commenting out the
> penalty_jiffies sleep code of mem_cgroup_handle_over_high(), the
> performance became higher than 2-2.
>
> 20% of working set memory pressure is pretty extreme, but anyway the
> incompressible pages handling feature could make it worse in certain
> setups.  Hence this version of the patch adds the parameter for turning
> the feature on/off as needed, and makes it disabled by default.
>
> Related Works
> -------------
>
> This is not an entirely new attempt.  There were a couple of similar
> approaches in the past.  Nhat Pham tried a very same approach[2] in
> October 2023.  Takero Funaki also tried a very similar approach[3] in
> April 2024.
>
> The two approaches didn't get merged mainly due to the metadata overhead
> concern.  I described why I think that shouldn't be a problem for this
> change, which is automatically disabled when writeback is disabled, at
> the beginning of this changelog.
>
> This patch is not particularly different from those, and actually built
> upon those.  I wrote this from scratch again, though.  I have no good
> idea about how I can give credits to the authors of the previously made
> nearly-same attempts, and I should be responsible to maintain this
> change if this is upstreamed, so taking the authorship for now.  Please
> let me know if you know a better way to give them their deserved
> credits.
>
> [1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
> [2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
> [3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com
>
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
>  atomic_long_t zswap_stored_pages =3D ATOMIC_LONG_INIT(0);
>
> +/* The number of uncompressed pages currently stored in zswap */
> +atomic_long_t zswap_stored_uncompressed_pages =3D ATOMIC_LONG_INIT(0);
> +
>  /*
>   * The statistics below are not protected from concurrent access for
>   * performance reasons so they may not be a 100% accurate.  However,
> @@ -129,6 +132,11 @@ static bool zswap_shrinker_enabled =3D IS_ENABLED(
>                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644)=
;
>
> +/* Store incompressible pages as is */
> +static bool zswap_save_incompressible_pages;
> +module_param_named(save_incompressible_pages, zswap_save_incompressible_=
pages,
> +               bool, 0644);
> +
>  bool zswap_is_enabled(void)
>  {
>         return zswap_enabled;
> @@ -190,7 +198,8 @@ static struct shrinker *zswap_shrinker;
>   *              writeback logic. The entry is only reclaimed by the writ=
eback
>   *              logic if referenced is unset. See comments in the shrink=
er
>   *              section for context.
> - * pool - the zswap_pool the entry's data is in
> + * orig_data - uncompressed original data of the page, if length is PAGE=
_SIZE
> + * pool - the zswap_pool the entry's data is in, if length is not PAGE_S=
IZE
>   * handle - zpool allocation handle that stores the compressed page data
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
> @@ -199,7 +208,10 @@ struct zswap_entry {
>         swp_entry_t swpentry;
>         unsigned int length;
>         bool referenced;
> -       struct zswap_pool *pool;
> +       union {
> +               void *orig_data;
> +               struct zswap_pool *pool;
> +       };
>         unsigned long handle;
>         struct obj_cgroup *objcg;
>         struct list_head lru;
> @@ -500,7 +512,7 @@ unsigned long zswap_total_pages(void)
>                 total +=3D zpool_get_total_pages(pool->zpool);
>         rcu_read_unlock();
>
> -       return total;
> +       return total + atomic_long_read(&zswap_stored_uncompressed_pages)=
;
>  }
>
>  static bool zswap_check_limits(void)
> @@ -805,8 +817,13 @@ static void zswap_entry_cache_free(struct zswap_entr=
y *entry)
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
>         zswap_lru_del(&zswap_list_lru, entry);
> -       zpool_free(entry->pool->zpool, entry->handle);
> -       zswap_pool_put(entry->pool);
> +       if (entry->length =3D=3D PAGE_SIZE) {
> +               kfree(entry->orig_data);
> +               atomic_long_dec(&zswap_stored_uncompressed_pages);
> +       } else {
> +               zpool_free(entry->pool->zpool, entry->handle);
> +               zswap_pool_put(entry->pool);
> +       }
>         if (entry->objcg) {
>                 obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>                 obj_cgroup_put(entry->objcg);
> @@ -937,6 +954,36 @@ static void acomp_ctx_put_unlock(struct crypto_acomp=
_ctx *acomp_ctx)
>         mutex_unlock(&acomp_ctx->mutex);
>  }
>
> +/*
> + * If the compression is failed, try saving the content as is without
> + * compression, to keep the LRU order.  This can increase memory overhea=
d from
> + * metadata, but in common zswap use cases where there are sufficient am=
ount of
> + * compressible pages, the overhead should be not ciritical, and can be
> + * mitigated by the writeback.  Also, the decompression overhead is opti=
mized.
> + *
> + * When the writeback is disabled, however, the additional overhead coul=
d be
> + * problematic.  For the case, just return the failure.  swap_writeout()=
 will
> + * put the page back to the active LRU list in the case.
> + */
> +static int zswap_handle_compression_failure(int comp_ret, struct page *p=
age,
> +               struct zswap_entry *entry)
> +{
> +       if (!zswap_save_incompressible_pages)
> +               return comp_ret;
> +       if (!mem_cgroup_zswap_writeback_enabled(
> +                               folio_memcg(page_folio(page))))
> +               return comp_ret;
> +
> +       entry->orig_data =3D kmalloc_node(PAGE_SIZE, GFP_NOWAIT | __GFP_N=
ORETRY |
> +                       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page))=
;

Hmm, seems like this new buffer is not migratable (for compaction etc.?)

My understanding is that zsmalloc's allocated memory can be migrated
(which is why zswap only works with a handle - it's a layer of
indirection that gives zsmalloc the ability to move memory around).

Besides, why should we re-invent the wheel when zsmalloc already
handles page-sized objects? :)

> +       if (!entry->orig_data)
> +               return -ENOMEM;
> +       memcpy_from_page(entry->orig_data, page, 0, PAGE_SIZE);
> +       entry->length =3D PAGE_SIZE;
> +       atomic_long_inc(&zswap_stored_uncompressed_pages);
> +       return 0;
> +}
> +
>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>                            struct zswap_pool *pool)
>  {
> @@ -976,8 +1023,11 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
>          */
>         comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req=
), &acomp_ctx->wait);
>         dlen =3D acomp_ctx->req->dlen;
> -       if (comp_ret)
> +       if (comp_ret) {
> +               comp_ret =3D zswap_handle_compression_failure(comp_ret, p=
age,
> +                               entry);
>                 goto unlock;
> +       }
>
>         zpool =3D pool->zpool;
>         gfp =3D GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABL=
E;
> @@ -1009,6 +1059,11 @@ static bool zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
>         int decomp_ret, dlen;
>         u8 *src, *obj;
>
> +       if (entry->length =3D=3D PAGE_SIZE) {
> +               memcpy_to_folio(folio, 0, entry->orig_data, entry->length=
);
> +               return true;
> +       }

This might not be safe.

It's conceivable that in zswap_compress(), some compression algorithm
"successfully" compresses a page to the same size (comp_ret =3D=3D 0). We
hand that to zsmalloc, which happily stores the page.

When we "decompress" the page again, we will attempt to
memcpy_to_folio from a bogus address (the handle from zsmalloc).

So, in zswap_compress, you have to treat both comp_ret =3D=3D 0 and dlen
=3D=3D PAGE_SIZE as "compression failure".

> +
>         acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
>         obj =3D zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buf=
fer);
>
> @@ -1518,7 +1573,8 @@ static bool zswap_store_page(struct page *page,
>          * The opposite actions will be performed by zswap_entry_free()
>          * when the entry is removed from the tree.
>          */
> -       zswap_pool_get(pool);
> +       if (entry->length !=3D PAGE_SIZE)
> +               zswap_pool_get(pool);
>         if (objcg) {
>                 obj_cgroup_get(objcg);
>                 obj_cgroup_charge_zswap(objcg, entry->length);
> @@ -1535,7 +1591,8 @@ static bool zswap_store_page(struct page *page,
>          *    The publishing order matters to prevent writeback from seei=
ng
>          *    an incoherent entry.
>          */
> -       entry->pool =3D pool;
> +       if (entry->length !=3D PAGE_SIZE)
> +               entry->pool =3D pool;
>         entry->swpentry =3D page_swpentry;
>         entry->objcg =3D objcg;
>         entry->referenced =3D true;
>
> base-commit: b771a67861b3538324c3df25d337f4713ee53e03
> --
> 2.39.5

