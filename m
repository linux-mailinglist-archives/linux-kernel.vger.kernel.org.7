Return-Path: <linux-kernel+bounces-753784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0BBB187E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D108E7B4510
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B428DB73;
	Fri,  1 Aug 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLjlUGbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F76F53E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078280; cv=none; b=VtninrhfuSxb//XbuXoEVVQL7dc0faYjdtjQMkkHxaQYugwRZsBjl8zIIvAjkqVpcT2jZdbZ/LiDv4JqA0jWejkUkNXUBAaKId5HtqUB9SKQwat1OcpsaYtAFFKk9WygDPbFLuEXnpElWLzKWiX59QOLdMB+eedjnfRpoS2V2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078280; c=relaxed/simple;
	bh=tUEYr3HZyXjC24pkcxwmm2u2X5diq/zyBh0xRAimDJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rE7MF2/ThEQRciSk0ZYWJl6xj54IU0rSfuozQDbeVEgVJ+Nc2rmcwH8RrDZICjHHgF4CTwJdp54t9L4zITH+sX9/mVEFwH3FUwcZAylxAU8SCQ2Fsia7LReLzOA/IJxFyrGv196YXgaJKxZMD+8A59NBm/TxTyk1gK1f6nWxSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLjlUGbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6336C4CEF4;
	Fri,  1 Aug 2025 19:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754078280;
	bh=tUEYr3HZyXjC24pkcxwmm2u2X5diq/zyBh0xRAimDJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLjlUGbRDq+Ne0c/edVOLhD+pSlZxu5jCJKXP+FmnAkAmUzVkgi5bXyB/SsKO7S5x
	 qz8uwOQsPEOAmhzXVKRIYT6SncnqduoPkjJC9N+SihafN7HOYyhGsCSIBp76xgPVUA
	 8j0D88z9/2BDT8xU6TIbtTQpiVCiI2X/A7MXz62fJoZOA07nM3wMrPlqct+DLT4xBc
	 XIynfZFssWNeZtVOUKMyLbMn+NnjQnXn5eYqQ/YLNAFJNIxUYqcT1Bhv88n7XcfeAh
	 PurPB4AEgxBf/XB1dm76xfVH9iatPCxXp3gO8nHnfrOkuVQtoaMtzuEjj6D7fvUCE3
	 HoikNGPOxnNcA==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Fri,  1 Aug 2025 12:57:57 -0700
Message-Id: <20250801195757.1384-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731172009.108025-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 10:20:05 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Wed, 30 Jul 2025 16:40:59 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> Hi SJ, thank you for your patch! This is a really cool idea : -)
> 
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
> 
> I think one other benefit that is worth mentioning here is that by moving
> the incompressible pages to the zswap LRU, we prevent wasting CPU cycles
> on pages that have not changed since their last compression attempt.

Thank you for adding this.  But, isn't this only for writeback-disabled case?

If writeback is enabled and an incompressible page is tried to be zswapped-out,
a compression of it is tried and failed, and the page is swapped out to disk.
The compression will be tried again later only if it is accessed, swapped in,
and then again tried to be zswapped-out.

After this patch, a compression is tried and failed, the page is kept in
memory, linked on zswap's LRU list.  And the compression will be tried again
later, if it is accessed, zswapped in, and then again tried to be zswapped-out.

So in terms of number of compression attempts, this patch is not making a
direct difference, to my understanding.  The correct LRU order _might_ make
some indirect help in some complicated scenarios, though, but I wouldn't dare
to claim that.

Am I missing something?

> 
> This concern is a real concern that we have seen manifest as wasted cycles
> in zswap wasted on trying to compress the same pages over and over again,
> and failing each time. This is also made worse by the fact that wasted CPU
> cycles are bad, but even worse when we are reclaiming and must free up memory!
> 
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
> Indeed, and your patch fixes this problem, at least for the writeback
> enabled case!

Again, I don't think this patch is really fixing it unless I'm missing
something.

> 
> [...snip...]
> 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 65 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 7e02c760955f..e021865696c6 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -45,6 +45,9 @@
> >  /* The number of compressed pages currently stored in zswap */
> >  atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
> >  
> > +/* The number of uncompressed pages currently stored in zswap */
> > +atomic_long_t zswap_stored_uncompressed_pages = ATOMIC_LONG_INIT(0);
> > +
> >  /*
> >   * The statistics below are not protected from concurrent access for
> >   * performance reasons so they may not be a 100% accurate.  However,
> > @@ -129,6 +132,11 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
> >  		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> >  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
> >  
> > +/* Store incompressible pages as is */
> > +static bool zswap_save_incompressible_pages;
> > +module_param_named(save_incompressible_pages, zswap_save_incompressible_pages,
> > +		bool, 0644);
> > +
> >  bool zswap_is_enabled(void)
> >  {
> >  	return zswap_enabled;
> > @@ -190,7 +198,8 @@ static struct shrinker *zswap_shrinker;
> >   *              writeback logic. The entry is only reclaimed by the writeback
> >   *              logic if referenced is unset. See comments in the shrinker
> >   *              section for context.
> > - * pool - the zswap_pool the entry's data is in
> > + * orig_data - uncompressed original data of the page, if length is PAGE_SIZE
> > + * pool - the zswap_pool the entry's data is in, if length is not PAGE_SIZE
> >   * handle - zpool allocation handle that stores the compressed page data
> >   * objcg - the obj_cgroup that the compressed memory is charged to
> >   * lru - handle to the pool's lru used to evict pages.
> > @@ -199,7 +208,10 @@ struct zswap_entry {
> >  	swp_entry_t swpentry;
> >  	unsigned int length;
> >  	bool referenced;
> > -	struct zswap_pool *pool;
> > +	union {
> > +		void *orig_data;
> > +		struct zswap_pool *pool;
> > +	};
> >  	unsigned long handle;
> >  	struct obj_cgroup *objcg;
> >  	struct list_head lru;
> > @@ -500,7 +512,7 @@ unsigned long zswap_total_pages(void)
> >  		total += zpool_get_total_pages(pool->zpool);
> >  	rcu_read_unlock();
> >  
> > -	return total;
> > +	return total + atomic_long_read(&zswap_stored_uncompressed_pages);
> >  }
> >  
> >  static bool zswap_check_limits(void)
> > @@ -805,8 +817,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
> >  static void zswap_entry_free(struct zswap_entry *entry)
> >  {
> >  	zswap_lru_del(&zswap_list_lru, entry);
> > -	zpool_free(entry->pool->zpool, entry->handle);
> > -	zswap_pool_put(entry->pool);
> > +	if (entry->length == PAGE_SIZE) {
> > +		kfree(entry->orig_data);
> > +		atomic_long_dec(&zswap_stored_uncompressed_pages);
> > +	} else {
> > +		zpool_free(entry->pool->zpool, entry->handle);
> > +		zswap_pool_put(entry->pool);
> > +	}
> >  	if (entry->objcg) {
> >  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> >  		obj_cgroup_put(entry->objcg);
> > @@ -937,6 +954,36 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
> >  	mutex_unlock(&acomp_ctx->mutex);
> >  }
> >  
> > +/*
> > + * If the compression is failed, try saving the content as is without
> > + * compression, to keep the LRU order.  This can increase memory overhead from
> > + * metadata, but in common zswap use cases where there are sufficient amount of
> > + * compressible pages, the overhead should be not ciritical, and can be
> 
> 					      NIT: s/ciritical/critical/?

Thank you for finding this!

> 
> > + * mitigated by the writeback.  Also, the decompression overhead is optimized.
> > + *
> > + * When the writeback is disabled, however, the additional overhead could be
> > + * problematic.  For the case, just return the failure.  swap_writeout() will
> 
> 					           NIT: s/  / /?

I was intentionally adding two spaces between paragraphs.  I find a few other
comments on zswap.c file are also using the convention...?

> 
> [...snip...]
> 
> And I think Nhat and Johannes have covered the other concerns.
> 
> Thanks again SJ for working on this, I hope you have a great day!

Thank you, I appreciate your review!  Also, happy Friday!


Thanks,
SJ

[...]

