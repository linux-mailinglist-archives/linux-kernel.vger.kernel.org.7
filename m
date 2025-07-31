Return-Path: <linux-kernel+bounces-751454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B822CB169C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACC318C7DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE1182B4;
	Thu, 31 Jul 2025 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNosl/sA"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7D195
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922903; cv=none; b=FZjG7BYgTpH6wIviXCTlLkTPPGmOtRAuDULVVfIfqyEkPpGZLmrAQMzzJ075kZb5DcJ6Ftolm0IC7nAgRJjmBia7jWUTMaZBIn0zwBIkNGg8JR/csiS8O1l4vrmAR2y3HmQIYin2s3hYdNRp59tIvzL+s+gj9d9cFUFTkCbj9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922903; c=relaxed/simple;
	bh=bEYYhCCUk5PSeZAEm0Icz9pZWSO8LimgNXTkDr0shEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWZikwpnFYkRCPRL40MjNwCxklJmSOQFBEdDOInmb0b7yX7ZCotXMIbghbTMXTp3ffhR/sOrA73VM0gKjr+gLwxMbPeZrt6G7Xp5FDCuZO9mBiJKTwPqUtPA84E5kMc9UVWZsrcBGjyLebhIywuPE5zeklDsjciFrtqNdnlYRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNosl/sA; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7074bad055eso2902376d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753922900; x=1754527700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2pdG2l+TRW20nOHFA5Hwr80dKEOfvvWmng9pif28ms=;
        b=mNosl/sAZB0iXyPVdnkYpygDZT4Kua52F+ylwToDPoUKao+Gx8l7lGk7Hyr+rs+DSL
         vI7wNr0rjycmFyfKUTo/FtHC0p23WHOrE40dXPuHtA0tzwB1aL5dm8vt76M0NLUtET10
         UnKVxQZ3zziuhdX1pf0Wg3W93402XnLGfTnRI2Bd/ctn714B8CpCmO2UQFmrit7eVB8J
         nT2+7dtbNUg5ajV3LzFlfijxwAoi9GHWyVexrNEa2vFdubctnu46FLI721ITYJpqN7zt
         FqWBCdwEmFptkqjWUgi9NuL3GTvfNxQIFB6x4kaoCzniTEnNrg/T/v37nZNzEeeMf72I
         yEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753922900; x=1754527700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2pdG2l+TRW20nOHFA5Hwr80dKEOfvvWmng9pif28ms=;
        b=Zti61ZIEn2MxgFsD4WqompSRk8j1krekaEE0NjjPHxOnkXsfTBmYj3bk7hfmpQP5LN
         4l2dA2aC0G0mrLxqfmm+hQ2Sc5lNnUU4WhR4n66Im8QWbx0Dvq8wqBoMtIiuGu7p59pt
         Nj7mwsY8DKNsqsx+j3uxW/O7gjUMqLYiv8UNLeQ8NA2zmo0QMUjVZSyZzpGWEZqF5MQV
         RWz4YQbXScYs0Z4epBMCIDN0idCS6wadam5new2u54aSSODROQQ/YdHUs+ngD1AblB6T
         kXaOYwCtAuzb1zDkqrVFUU/AFmBJuJUSigmmkCZNqSG3N8ZkiY+L4BNwO+gBXmbfj/h3
         Swvg==
X-Forwarded-Encrypted: i=1; AJvYcCX6a2IJybTp/b9khGJEYc5qS6KYrCSOoCI33cJ1CxTKwQl/0Y1Qob2jbwRKlcQxAhgUE+bIT6j1ETyymxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZsIxThi6Fxlskwcg2EWryi9btbdNi9jUICBylSou9AMmCq8e
	t+amz/aD1GnMFIX2oZv9q5j1JkWUU/B6XNptYF/zsvo+CJKCkGmaQzsHAvKieWZpcBt1viU34s3
	OI085gLDhvsC16adyYWsMJG/wQIQzgPI=
X-Gm-Gg: ASbGncuO6X+v2waMbhnX2Ue2Xp2+ktpzf2fR4RC4yoUV0xGldPwTo3nRlKe6qANIpqt
	16reY/tkhLRW0lQJyLcUmjqctVlNPyuxyH1Rmjqi9594y8f3yBX/BI8QGyUsqCfDwa3pi5bI6+U
	7QaREMUjXXw62wmY/X9+6t3aKNdIKL9wbf8HI0x9VhrImXkrHwGgzu31Zn3yhvGKi0HeoXfdsNe
	03I1fRuK2OI5C/zqSkxmcAQ7hcRMrCTvA==
X-Google-Smtp-Source: AGHT+IECSE6F13Pl2EXT4UY8juNFt5jmK+rYXMEU03hUbNWVd8J3gDzLCT8b4E6RDPe15vC9enIIXOaAuTU45+GFFmk=
X-Received: by 2002:a05:6214:c45:b0:707:1709:8f5 with SMTP id
 6a1803df08f44-70767228347mr86668006d6.36.1753922899971; Wed, 30 Jul 2025
 17:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730234059.4603-1-sj@kernel.org>
In-Reply-To: <20250730234059.4603-1-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 30 Jul 2025 17:48:09 -0700
X-Gm-Features: Ac12FXzmfdj27ZJ5UM9yrtlWemnMA0gY-WDpmGDnlNyZakORuDFtXdFn6i4LL3Q
Message-ID: <CAKEwX=Mv_NC27HWe=MneiewHTSZ-0icJqE2PSikTW-o30n9R-A@mail.gmail.com>
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

Now, taking a look at the conceptual side of the patch:

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

As a follow up, we can reuse the "swapped out" page (and its struct
page) to store in the zswap pool (and LRU).

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

Yeah this is pretty extreme. I suppose you can construct scenarios
where disk swapping delays are still better than memory.high
violations throttling.

That said, I suppose under very hard memory pressure like this, users
must make a choice anyway:

1. If they're OK with disk swapping, consider enabling zswap shrinker
:) That'll evict a bunch of compressed objects from zswap to disk swap
to avoid memory limit violations.

2. If they're not OK with disk swapping, then throttling/OOMs is
unavoidable. In fact, we're speeding up the OOM process, which is
arguably desirable? This is precisely the pathological behavior that
some of our workloads are observing in production - they spin the
wheel for a really long time trying (and failing) to reclaim
incompressible anonymous memory, hogging the CPUs.

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

I'd take Suggested-by if you feel bad ;)

But, otherwise, no need to add me as author! Unless you copy the OG
patch in future versions lol.

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

