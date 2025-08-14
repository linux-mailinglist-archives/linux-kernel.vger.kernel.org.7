Return-Path: <linux-kernel+bounces-769346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6AB26D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B1E5C20A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C81C5499;
	Thu, 14 Aug 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g03bXXBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7A1E4BE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191069; cv=none; b=sWbC2n2Pzc+uteFhFU8gbDcXGg3dXRhqvXJtn2O9JKXnvFPFxWnWooydYkKan27IjsphlLZyR1ZWWyl50Ye7uOtN4mes8na3go8hlwJvlGqndiglhFl2BD5MFN4wl2snO8aPyYdDMSgfOlBlzIWoWyxVc3950UMO91RUGDq2lFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191069; c=relaxed/simple;
	bh=ehLWibI3luHVPPGBO4K8NQgsDAt/gZl+g1zfAGJiJNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM1i9kS6pu7YGvgWFKW76vsbapXQaWw3GrmaSHxnX/WxTrkxZT5H6NLxgUHka/iJ819tUOHQarZWTaP/b67QYs1kfEPpMnWnl+g6nWTEM9tNN/RCw8rE1b/e7ir1Y4ggaC+evOxMelnM/Rr1JkYuZ0wv/ZN7fmKQQ1CYXQNZ5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g03bXXBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B21C4CEED;
	Thu, 14 Aug 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755191068;
	bh=ehLWibI3luHVPPGBO4K8NQgsDAt/gZl+g1zfAGJiJNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g03bXXBiILvibSwG51TANlNRiafCWjWykDjDfRUHYoztyU7J8yZ8vTOrSSysZlDN5
	 R2IFE9tx0CGUZlM90EbZ2oUx4efrQw6DZUSNdxB5LipOvRVNJRBplPNp6LVr5hn1Jt
	 By2wC3wvysbjuQHrQ37O/kcwFYlxGuTcc9zQzTxPbmAd/ByB2ZE1/46j6uE9XG7DqI
	 z60BpaWc9fBbqrjf8LQ2MXF1xae4vAa4sZO5w5hlKSNh3lT69qo3EFLnuRF30UsFAT
	 QSmtnb6dCurbAKlYkGCIp/JPQRgmn5/C5fbrkkTOZiPIORy/MElTGZri1Lz+VEs2aq
	 l4iuIM54oBs8w==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu, 14 Aug 2025 10:04:26 -0700
Message-Id: <20250814170426.71159-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814162350.GH115258@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 12:23:50 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Tue, Aug 12, 2025 at 10:00:46AM -0700, SeongJae Park wrote:
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
> > 
> > Keep the LRU order and optimize unnecessary decompression overheads in
> > those cases, by storing the original content as-is in zpool.  The length
> > field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> > whether it is saved as-is or not (whether decompression is unnecessary)
> > is identified by 'zswap_entry->length == PAGE_SIZE'.
[...]
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
> 
>                                                four?

Nice catch, thank you!  I will fix this in the next version.

> 
> > - 0: memory.high is set to 2 GiB, zswap is disabled.
> > - 1-1: memory.high is set to 1350 MiB, zswap is disabled.
> > - 1-2: On 1-1, zswap is enabled without this patch.
> > - 1-3: On 1-2, this patch is applied.
> 
> I'm not sure 0 and 1-1 are super interesting, since we care about
> zswap performance under pressure before and after the patch.

You're right, the main focus should be 1-2 vs 1-3.

I added 0 and 1-1, too, though, just for showing how artificial and micro the
given test setup is.

That is, as I also mentioned on the original mail, this test setup is for
pretty extreme pressure case.  To quote,

        config            0       1-1     1-2      1-3
        perf_normalized   1.0000  0.0057  0.0235   0.0367
    [...]
    Note that ~10% working set pressure is already extreme, at least
    on this test setup.  No one would desire system setups that can degrade
    performance to 0.57% of the best case.

Enabling zswap improves the performance to 2.35% of the ideal setup, and this
patch further improves it to 3.67%.  But still no one would want a setup that
achieves only 3.67% of the ideal performance.  The performance itself is also
a pure memory random access performance, which is again far from those for real
workloads, though.

So, this is a microbenchmarking test that pretty far from the real world.

I will add more description about the intention of the configs in the next
version.  Let me know if you think it is only disturbing reading of the patch
and better to be just dropped.
 
> 
> > For all zswap enabled cases, zswap shrinker is enabled.
> 
> It would, however, be good to test without the shrinker as well, since
> it's currently optional and not enabled by default.

Agreed.  Actually we ran without shrinker for RFC v1[1] of this patch.  The
version also showed performance improvement in the configuration.  Since we
made no big change after the version, I expect no big difference.

Nonetheless, I will run the test with zswap shrinker disabled setup again with
this version, and share the results.  Unless the results is far from my
expectation, I will directly post the next version of this patch with abovely
promised changelog updates.

> 
> The performance with the shrinker looks great, but if it regresses for
> setups without the shrinker we need additional gating.

Agreed.  If I find a regression from the abovely promised rerun of the test, I
will share that as a reply to this thread, and start a discussion for the
possible additional gating.

[1] https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org


Thanks,
SJ

