Return-Path: <linux-kernel+bounces-752420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A233B17558
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15729A80816
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CD23E32D;
	Thu, 31 Jul 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8wslyPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F931C07C3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980972; cv=none; b=rxbjWsUUFcCjEblZ0kIPgd/i4a0w2JlYp3ECRWben3Acn+/1a98CyroW+PPSirSbh2utnyNEzRmBbrBZyHdZNSLjLAAyVy/EEe/GQM9HWKRLaMZn0DMOi/5QMMkVuw1XLE3PJcgtWmUkV03Z4khPEkMAjiOaaRgzpqzlhyAuyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980972; c=relaxed/simple;
	bh=/tV+H3nZX38CRFBkLsRcF7IVCUTCMklz5ImNjph4/d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjX7FCj6xGJQztaT9rDi6qkmWNfLr7iqIYsiK+amI2AiU2pYsJKpqVGVe6X8/GrzXzs8QESQivS/19wqxRISk5zIHxmOfW4rwaSf6xJ/F/jron1G6KjNc7jTjtJqVBCw+rrmDMQSSPttMnjDrnlmKIBNDPV0xXbGrvPLkmbmWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8wslyPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDFEC4CEF6;
	Thu, 31 Jul 2025 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753980971;
	bh=/tV+H3nZX38CRFBkLsRcF7IVCUTCMklz5ImNjph4/d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8wslyPjITtn6e+QKlXiWVgTTuisc0/Z2NFh6f6YvIIGZQlmd1oXvL+E334I3UZVo
	 dZVbUn7BVG0Ch/yd3RVYKCMIXXlyUq9ZHS6OWRrPimkgLkcxOYKx2mYpuC1LAfXpw8
	 GqK4r+oRlXJuFzb6RpFi8F54hDriuFsNl0hSXNz1Oi7dVo6CmLRvVR94j3sjVyiiqP
	 T1eF1yIwb2t3uUA8VacO4E/0KBvnl1zK7aBtzWCT+Th2p3fc4e9s9z+o21eds13tvB
	 LWKPVfiGHl5YGUqzJFCSqin7Xh3ueCuK3rGEu9RWo9dvimkneRiaS3oEYmd5kKbTVP
	 +c3R3yWFWn1/A==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Thu, 31 Jul 2025 09:56:08 -0700
Message-Id: <20250731165608.15347-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=Mv_NC27HWe=MneiewHTSZ-0icJqE2PSikTW-o30n9R-A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 17:48:09 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Wed, Jul 30, 2025 at 4:41 PM SeongJae Park <sj@kernel.org> wrote:
> 
> Now, taking a look at the conceptual side of the patch:
> 
> >
> > When zswap writeback is enabled and it fails compressing a given page,
> > zswap lets the page be swapped out to the backing swap device.  This
> > behavior breaks the zswap's writeback LRU order, and hence users can
> > experience unexpected latency spikes.
> >
> > Keep the LRU order by storing the original content in zswap as-is.  The
> > original content is saved in a dynamically allocated page size buffer,
> > and the pointer to the buffer is kept in zswap_entry, on the space for
> > zswap_entry->pool.  Whether the space is used for the original content
> > or zpool is identified by 'zswap_entry->length == PAGE_SIZE'.
> >
> > This avoids increasing per zswap entry metadata overhead.  But as the
> > number of incompressible pages increases, zswap metadata overhead is
> > proportionally increased.  The overhead should not be problematic in
> > usual cases, since the zswap metadata for single zswap entry is much
> > smaller than PAGE_SIZE, and in common zswap use cases there should be
> > sufficient amount of compressible pages.  Also it can be mitigated by
> > the zswap writeback.
> >
> > When the memory pressure comes from memcg's memory.high and zswap
> > writeback is set to be triggered for that, however, the penalty_jiffies
> > sleep could degrade the performance.  Add a parameter, namely
> > 'save_incompressible_pages', to turn the feature on/off as users want.
> > It is turned off by default.
> >
> > When the writeback is just disabled, the additional overhead could be
> > problematic.  For the case, keep the behavior that just returns the
> > failure and let swap_writeout() puts the page back to the active LRU
> > list in the case.  It is known to be suboptimal when the incompressible
> > pages are cold, since the incompressible pages will continuously be
> > tried to be zswapped out, and burn CPU cycles for compression attempts
> > that will anyway fails.  But that's out of the scope of this patch.
> 
> As a follow up, we can reuse the "swapped out" page (and its struct
> page) to store in the zswap pool (and LRU).

Thank you for adding this.  I will include this into the changelog of the next
version of this patch.

> 
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
> > regions.  The regions are all 500 MiB size, and accessed in same
> > probability.  Two of those are filled up with a simple content that can
> > easily be compressed, while the remaining one is filled up with a
> > content that read from /dev/urandom, which is easy to fail at
> > compressing.  The program runs for two minutes and prints out the number
> > of accesses made every five seconds.
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
> > '0' was 34612740.66.
> >
> >     config            0       1-1     1-2      1-3      2-1     2-2      2-3
> >     perf_normalized   1.0000  0.0060  0.0230   0.0310   0.0030  0.0116   0.0003
> >     perf_stdev_ratio  0.06    0.04    0.11     0.14     0.03    0.05     0.26
> >     zswpin            0       0       1701702  6982188  0       2479848  815742
> >     zswpout           0       0       1725260  7048517  0       2535744  931420
> >     zswpwb            0       0       0        0        0       0        0
> >     pswpin            0       468612  481270   0        476434  535772   0
> >     pswpout           0       574634  689625   0        612683  591881   0
> >
> > 'perf_normalized' is the performance metric, normalized to that of
> > configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
> > deviation of the averaged data points, as a ratio to the averaged metric
> > value.  For example, configuration '0' performance was showing 6% stdev.
> > Configurations 1-2 and 1-3 were having about 11% and 14% stdev.  So the
> > measurement is not very stable.  Please keep this in your mind when
> > reading these results.  It shows some rough patterns, though.
> >
> > Under about 10% of working set memory pressure, the performance was
> > dropped to about 0.6% of no-pressure one, when the normal swap is used
> > (1-1).  Actually ~10% working set pressure is not a mild one, at least
> > on this test setup.
> >
> > By turning zswap on (1-2), the performance was improved about 4x,
> > resulting in about 2.3% of no-pressure one.  Because of the
> > incompressible pages in the third memory region, a significant amount of
> > (non-zswap) swap I/O operations were made, though.
> >
> > By enabling the incompressible pages handling feature that is introduced
> > by this patch (1-3), about 34% performance improvement was made,
> > resulting in about 3.1% of no-pressure one.  As expected, compression
> > failed pages were handled by zswap, and hence no (non-zswap) swap I/O
> > was made in this configuration.
> >
> > Under about 20% of working set memory pressure, which could be extreme,
> > the performance drops down to 0.3% of no-pressure one when only the
> > normal swap is used (2-1).  Enabling zswap significantly improves it, up
> > to 1.16%, though again showing a significant number of (non-zswap) swap
> > I/O due to incompressible pages.
> >
> > Enabling the incompressible pages handling feature of this patch (2-3)
> > reduced non-zswap swap I/O as expected, but the performance became
> > worse, 0.03% of no-pressure one.  It turned out this is because of
> > memory.high-imposed penalty_jiffies sleep.  By commenting out the
> > penalty_jiffies sleep code of mem_cgroup_handle_over_high(), the
> > performance became higher than 2-2.
> 
> Yeah this is pretty extreme. I suppose you can construct scenarios
> where disk swapping delays are still better than memory.high
> violations throttling.
> 
> That said, I suppose under very hard memory pressure like this, users
> must make a choice anyway:
> 
> 1. If they're OK with disk swapping, consider enabling zswap shrinker
> :) That'll evict a bunch of compressed objects from zswap to disk swap
> to avoid memory limit violations.

I agree.  And while I'm arguing I believe this is ok when writeback is enabled,
my test is not exploring the case since it is not enabling zswap shrinker or
set max_pool_percent.  And hence the test results show zero zswpwb always.  I
will extend the test setup to explore this case.

> 
> 2. If they're not OK with disk swapping, then throttling/OOMs is
> unavoidable. In fact, we're speeding up the OOM process, which is
> arguably desirable? This is precisely the pathological behavior that
> some of our workloads are observing in production - they spin the
> wheel for a really long time trying (and failing) to reclaim
> incompressible anonymous memory, hogging the CPUs.

I agree.  When memory.max is appropriately set, I think the system will work in
the desirable way.

> 
> >
> > 20% of working set memory pressure is pretty extreme, but anyway the
> > incompressible pages handling feature could make it worse in certain
> > setups.  Hence this version of the patch adds the parameter for turning
> > the feature on/off as needed, and makes it disabled by default.
> >
> > Related Works
> > -------------
> >
> > This is not an entirely new attempt.  There were a couple of similar
> > approaches in the past.  Nhat Pham tried a very same approach[2] in
> > October 2023.  Takero Funaki also tried a very similar approach[3] in
> > April 2024.
> >
> > The two approaches didn't get merged mainly due to the metadata overhead
> > concern.  I described why I think that shouldn't be a problem for this
> > change, which is automatically disabled when writeback is disabled, at
> > the beginning of this changelog.
> >
> > This patch is not particularly different from those, and actually built
> > upon those.  I wrote this from scratch again, though.  I have no good
> > idea about how I can give credits to the authors of the previously made
> > nearly-same attempts, and I should be responsible to maintain this
> > change if this is upstreamed, so taking the authorship for now.  Please
> > let me know if you know a better way to give them their deserved
> > credits.
> 
> I'd take Suggested-by if you feel bad ;)
> 
> But, otherwise, no need to add me as author! Unless you copy the OG
> patch in future versions lol.

Nice idea, thank you for suggesting Suggested-by: :)

I'll add Suggested-by: tags for you and Takero in the next version.


Thanks,
SJ

[...]

