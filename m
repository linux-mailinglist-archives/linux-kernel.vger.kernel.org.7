Return-Path: <linux-kernel+bounces-756860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C68CB1BA7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4595A625107
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70D299944;
	Tue,  5 Aug 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUcOi8O0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608A1E51EF;
	Tue,  5 Aug 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419886; cv=none; b=LEit9D69X45+Qjxgp3QJurZ1G1YtUwVybFhYxKjKfCfOSNRgwAIJlkz18gwaqXOr/XJ67usbP6Tw5XFAgibLnq/roPBfLSRXjulXjREc2SJvJzZ9rLyhwZh3yKg2EpzOk+F042xc+6HdN5rXlZZ88xV+5NfJKDzZVNiDp51C+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419886; c=relaxed/simple;
	bh=1foawzQDKMWTN3rf/TiKTCzlWcGktjNZWFrsshx9B+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sfx2sj58yIy8B/0ww6Y5CWshKo6SA9I52KcOLqSMayV+GYJ2wu16xnr7at75Qny3xjpsdxrw5TQMI8qHW8K59A5+EZXPNindWpEF/rFUpYrvpf4aura8RVmNikKSiJmqTdBc7yeOME6SFGz1Z8SJxwMiI+m+8Azckav/sG+SygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUcOi8O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD44C4CEF0;
	Tue,  5 Aug 2025 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419886;
	bh=1foawzQDKMWTN3rf/TiKTCzlWcGktjNZWFrsshx9B+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUcOi8O0X1C8mUjrGriiMDakXjw8/PRPLbCdwUmlxyG4ieRvhIfEtOy9XVHncDd67
	 WYluf/e6wJSAYelOyk/tHal/cUcRnltRlZRA+XnDqGvBcFvbD1huS+BsnENzrxOdln
	 JVl49eUHVNmh9Y7yDhJ5yBbxe8mQyUKeM5jjoln5ALf/PuWm8NkzSJIorn9c6/2Wub
	 ioy9fyXkceJrBbTEZtXL2CQtrc+emA0r4f9PwgDPLCBQjd1J9c/bEZ16wg2JHq+rYE
	 1QKQ1uI3HVN4L3HBlL0rEFMaHI9qV/F6mc0st4VXOUOxZXVBHNlF0yEJHS0SelN9hZ
	 qqca8KvbqwPJg==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Tue,  5 Aug 2025 11:51:23 -0700
Message-Id: <20250805185123.8691-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=Pv4+nhG5j=qech3ox6CFKJL6Ox-xy_Tb+cyyXgZU1oPQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 5 Aug 2025 11:25:38 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Mon, Aug 4, 2025 at 5:30 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
> >
> > Keep the LRU order and optimize unnecessary decompression overheads in
> > the cases, by storing the original content in zpool as-is.  The length
> > field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> > whether it is saved as-is or not (whether decompression is unnecessary)
> > is identified by 'zswap_entry->length == PAGE_SIZE'.
> >
> > So this change is not increasing per zswap entry metadata overhead.  But
> > as the number of incompressible pages increases, total zswap metadata
> > overhead is proportionally increased.  The overhead should not be
> > problematic in usual cases, since the zswap metadata for single zswap
> > entry is much smaller than PAGE_SIZE, and in common zswap use cases
> > there should be a sufficient amount of compressible pages.  Also it can
> > be mitigated by the zswap writeback.
> >
> > When a severe memory pressure comes from memcg's memory.high, storing
> > incompressible pages as-is may result in reducing accounted memory
> > footprint slower, since the footprint will be reduced only after the
> > zswap writeback kicks in.  This can incur higher penalty_jiffies and
> > degrade the performance.  Arguably this is just a wrong setup, but we
> > don't want to introduce unnecessary surprises.  Add a parameter, namely
> > 'save_incompressible_pages', to turn the feature on/off as users want.
> > It is turned off by default.
> >
> > When the writeback is disabled, the additional overhead could be
> > problematic.  For the case, keep the current behavior that just returns
> > the failure and let swap_writeout() put the page back to the active LRU
> > list in the case.  It is known to be suboptimal when the incompressible
> > pages are cold, since the incompressible pages will continuously be
> > tried to be zswapped out, and burn CPU cycles for compression attempts
> > that will anyway fails.  One imaginable solution for the problem is
> > reusing the swapped-out page and its struct page to store in the zswap
> > pool.  But that's out of the scope of this patch.
> >
> > Tests
> > -----
> >
> > I tested this patch using a simple self-written microbenchmark that is
> > available at GitHub[1].  You can reproduce the test I did by executing
> > run_tests.sh of the repo on your system.  Note that the repo's
> > documentation is not good as of this writing, so you may need to read
> > and use the code.
> >
> > The basic test scenario is simple.  Run a test program making artificial
> > accesses to memory having artificial content under memory.high-set
> > memory limit and measure how many accesses were made in given time.
> >
> > The test program repeatedly and randomly access three anonymous memory
> > regions.  The regions are all 500 MiB size, and accessed in the same
> > probability.  Two of those are filled up with a simple content that can
> > easily be compressed, while the remaining one is filled up with a
> > content that read from /dev/urandom, which is easy to fail at
> > compressing to <PAGE_SIZE size.  The program runs for two minutes and
> > prints out the number of accesses made every five seconds.
> >
> > The test script runs the program under below seven configurations.
> >
> > - 0: memory.high is set to 2 GiB, zswap is disabled.
> > - 1-1: memory.high is set to 1350 MiB, zswap is disabled.
> > - 1-2: Same to 1-1, but zswap is enabled.
> > - 1-3: Same to 1-2, but save_incompressible_pages is turned on.
> > - 2-1: memory.high is set to 1200 MiB, zswap is disabled.
> > - 2-2: Same to 2-1, but zswap is enabled.
> > - 2-3: Same to 2-2, but save_incompressible_pages is turned on.
> >
> > For all zswap enabled case, zswap shrinker is enabled.
> >
> > Configuration '0' is for showing the original memory performance.
> > Configurations 1-1, 1-2 and 1-3 are for showing the performance of swap,
> > zswap, and this patch under a level of memory pressure (~10% of working
> > set).
> >
> > Configurations 2-1, 2-2 and 2-3 are similar to 1-1, 1-2 and 1-3 but to
> > show those under a severe level of memory pressure (~20% of the working
> > set).
> >
> > Because the per-5 seconds performance is not very reliable, I measured
> > the average of that for the last one minute period of the test program
> > run.  I also measured a few vmstat counters including zswpin, zswpout,
> > zswpwb, pswpin and pswpout during the test runs.
> >
> > The measurement results are as below.  To save space, I show performance
> > numbers that are normalized to that of the configuration '0' (no memory
> > pressure), only.  The averaged accesses per 5 seconds of configuration
> > '0' was 36493417.75.
> >
> >     config            0       1-1     1-2      1-3      2-1     2-2      2-3
> >     perf_normalized   1.0000  0.0057  0.0235   0.0367   0.0031  0.0122   0.0077
> >     perf_stdev_ratio  0.0582  0.0652  0.0167   0.0346   0.0404  0.0145   0.0613
> >     zswpin            0       0       3548424  1999335  0       2912972  1612517
> >     zswpout           0       0       3588817  2361689  0       2996588  2029884
> >     zswpwb            0       0       10214    340270   0       34625    382117
> >     pswpin            0       485806  772038   340967   540476  874909   790418
> >     pswpout           0       649543  144773   340270   692666  275178   382117
> >
> > 'perf_normalized' is the performance metric, normalized to that of
> > configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
> > deviation of the averaged data points, as a ratio to the averaged metric
> > value.  For example, configuration '0' performance was showing 5.8%
> > stdev.  Configurations 1-1 and 1-3 were having about 6.5% and 6.1%
> > stdev.  Also the results were highly variable between multiple runs.  So
> > this result is not very stable but just showing ball park figures.
> > Please keep this in your mind when reading these results.
> >
> > Under about 10% of working set memory pressure, the performance was
> > dropped to about 0.57% of no-pressure one, when the normal swap is used
> > (1-1).  Actually ~10% working set pressure is not a mild one, at least
> > on this test setup.
> >
> > By turning zswap on (1-2), the performance was improved about 4x,
> > resulting in about 2.35% of no-pressure one.  Because of the
> > incompressible pages in the third memory region, a significant amount of
> > (non-zswap) swap I/O operations were made, though.
> >
> > By enabling the incompressible pages handling feature that is introduced
> > by this patch (1-3), about 56% performance improvement was made,
> > resulting in about 3.67% of no-pressure one.  Reduced pswpin of 1-3
> > compared to 1-2 let us see where this improvement came from.
> >
> > Under about 20% of working set memory pressure, which could be extreme,
> > the performance drops down to 0.31% of no-pressure one when only the
> > normal swap is used (2-1).  Enabling zswap significantly improves it, up
> > to 1.22%, though again showing a significant number of (non-zswap) swap
> > I/O due to incompressible pages.
> >
> > Enabling the incompressible pages handling feature of this patch (2-3)
> > didn't reduce non-zswap swap I/O, because the memory pressure is too
> > severe to let nearly all zswap pages including the incompressible pages
> > written back by zswap shrinker.  And because the memory usage is not
> > dropped as soon as incompressible pages are swapped out but only after
> > those are written back by shrinker, memory.high apparently applied more
> > penalty_jiffies.  As a result, the performance became even worse than
> > 2-2 about 36.88%, resulting in 0.07% of the no-pressure one.
> >
> > 20% of working set memory pressure is pretty extreme, but anyway the
> > incompressible pages handling feature could make it worse in certain
> > setups.  Hence add the parameter for turning the feature on/off as
> > needed, and disable it by default.
> >
> > Related Works
> > -------------
> >
> > This is not an entirely new attempt.  Nhat Pham and Takero Funaki tried
> > very similar approaches in October 2023[2] and April 2024[3],
> > respectively.  The two approaches didn't get merged mainly due to the
> > metadata overhead concern.  I described why I think that shouldn't be a
> > problem for this change, which is automatically disabled when writeback
> > is disabled, at the beginning of this changelog.
> >
> > This patch is not particularly different from those, and actually built
> > upon those.  I wrote this from scratch again, though.  Hence adding
> > Suggested-by tags for them.  Actually Nhat first suggested this to me
> > offlist.
> >
> > [1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
> > [2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
> > [3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com
> >
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Suggested-by: Takero Funaki <flintglass@gmail.com>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> > Changes from RFC v1
> > (https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org)
> > - Consider PAGE_SIZE-resulting compression successes as failures.
> > - Use zpool for storing incompressible pages.
> > - Test with zswap shrinker enabled.
> > - Wordsmith changelog and comments.
> > - Add documentation of save_incompressible_pages parameter.
> >
> >  Documentation/admin-guide/mm/zswap.rst |  9 +++++
> >  mm/zswap.c                             | 53 +++++++++++++++++++++++++-
> >  2 files changed, 61 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
> > index c2806d051b92..20eae0734491 100644
> > --- a/Documentation/admin-guide/mm/zswap.rst
> > +++ b/Documentation/admin-guide/mm/zswap.rst
> > @@ -142,6 +142,15 @@ User can enable it as follows::
> >  This can be enabled at the boot time if ``CONFIG_ZSWAP_SHRINKER_DEFAULT_ON`` is
> >  selected.
> >
> > +If a page cannot be compressed into a size smaller than PAGE_SIZE, it can be
> > +beneficial to save the content as is without compression, to keep the LRU
> > +order.  Users can enable this behavior, as follows::
> > +
> > +  echo Y > /sys/module/zswap/parameters/save_incompressible_pages
> > +
> > +This is disabled by default, and doesn't change behavior of zswap writeback
> > +disabled case.
> > +
> >  A debugfs interface is provided for various statistic about pool size, number
> >  of pages stored, same-value filled pages and various counters for the reasons
> >  pages are rejected.
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 7e02c760955f..6e196c9a4dba 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -129,6 +129,11 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
> >                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> >  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
> >
> > +/* Enable/disable incompressible pages storing */
> > +static bool zswap_save_incompressible_pages;
> > +module_param_named(save_incompressible_pages, zswap_save_incompressible_pages,
> > +               bool, 0644);
> > +
> >  bool zswap_is_enabled(void)
> >  {
> >         return zswap_enabled;
> > @@ -937,6 +942,29 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
> >         mutex_unlock(&acomp_ctx->mutex);
> >  }
> >
> > +/*
> > + * Determine whether to save given page as-is.
> > + *
> > + * If a page cannot be compressed into a size smaller than PAGE_SIZE, it can be
> > + * beneficial to saving the content as is without compression, to keep the LRU
> > + * order.  This can increase memory overhead from metadata, but in common zswap
> > + * use cases where there are sufficient amount of compressible pages, the
> > + * overhead should be not critical, and can be mitigated by the writeback.
> > + * Also, the decompression overhead is optimized.
> > + *
> > + * When the writeback is disabled, however, the additional overhead could be
> > + * problematic.  For the case, just return the failure.  swap_writeout() will
> > + * put the page back to the active LRU list in the case.
> > + */
> > +static bool zswap_save_as_is(int comp_ret, unsigned int dlen,
> > +               struct page *page)
> > +{
> > +       return zswap_save_incompressible_pages &&
> > +                       (comp_ret || dlen == PAGE_SIZE) &&
> > +                       mem_cgroup_zswap_writeback_enabled(
> > +                                       folio_memcg(page_folio(page)));
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >                            struct zswap_pool *pool)
> >  {
> > @@ -976,8 +1004,13 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >          */
> >         comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> >         dlen = acomp_ctx->req->dlen;
> > -       if (comp_ret)
> > +       if (zswap_save_as_is(comp_ret, dlen, page)) {
> > +               comp_ret = 0;
> > +               dlen = PAGE_SIZE;
> > +               memcpy_from_page(dst, page, 0, dlen);
> > +       } else if (comp_ret) {
> >                 goto unlock;
> > +       }
> >
> >         zpool = pool->zpool;
> >         gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -1001,6 +1034,17 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >         return comp_ret == 0 && alloc_ret == 0;
> >  }
> >
> > +/*
> > + * If save_incompressible_pages is set and writeback is enabled, incompressible
> > + * pages are saved as is without compression.  For more details, refer to the
> > + * comments of zswap_save_as_is().
> > + */
> > +static bool zswap_saved_as_is(struct zswap_entry *entry, struct folio *folio)
> > +{
> > +       return entry->length == PAGE_SIZE && zswap_save_incompressible_pages &&
> > +               mem_cgroup_zswap_writeback_enabled(folio_memcg(folio));
> > +}
> 
> Actually, this might not be safe either :(
> 
> What if we have the following sequence:
> 1. Initially, the cgroup is writeback enabled. We encounter an
> incompressible page, and store it as-is in the zswap pool.
> 2. Some userspace agent (systemd or whatever) runs, and disables zswap
> writeback on the cgroup.
> 3. At fault time, zswap_saved_as_is() returns false, so we'll treat
> the page-sized stored object as compressed, and attempt to decompress
> it. This is a memory corruption.
> 
> I think you can trigger a similar bug, if you enable
> zswap_save_incompressible_pages initially, then disable it later on.

Nice catch!  Thank you for catching this and giving this nice explanation.  I
agree your points.

> 
> I think you have to do the following:
> 1. At store time, if comp_ret or dlen == PAGE_SIZE, treat it as
> compression failure. This means: saving as-is when writeback enabled,
> and rejecting when writeback disabled. Basically:
> 
> if (!comp_ret || dlen == PAGE_SIZE) {

I saw your reply correcting this to '(comp_ret || dlen == PAGE_SIZE)', and that
makes sense to me.

>     if (zswap_save_incompressible_pages &&
> mem_cgroup_zswap_writeback_enabled(folio_memcg(page_folio(folio)))) {
>         /* save as-is */
>     } else {
>        /* rejects */
>     }
> 
> }
> 
> 2. At load time, just check that dlen == PAGE_SIZE. We NEVER store
> PAGE_SIZE "compressed" page, so we can safely assume that it is the
> original, uncompressed data.

Thank you for even further giving me this nice suggestion.  Again this makes
sense to me.  I will make this change on the next version.


Thanks,
SJ

