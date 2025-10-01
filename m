Return-Path: <linux-kernel+bounces-839220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22682BB114B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0153B7EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322F26FDBD;
	Wed,  1 Oct 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fVaCowwg"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14281F03C5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332804; cv=none; b=Hz/3DDEZXH4AVey4AS0uiQa4yby3KE9PTEZ0hflF3pkHOVofl0DyrM+SuRBJo77uipDKnc5wiqRavtbFwHUvJxfphyg6QZU2+s/DS0PjAl48kCp0U7UaBEEmECa7n13d1Ue1wcv4eCM6QdEQbWYM5nuvAJgla9mROnlLLiSAsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332804; c=relaxed/simple;
	bh=AfoyVEJO7r2iQqFi0MOuWt9rNW8EZPCQFxiYfZkw08Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWCxP47PqQEfwniIVNycSo6YIGxGB/hioYiCCpVkDW4L/V5L3852BKDWSzwLnEBBuudLNcPUObb+SBVOJui6/L/QOkGCdnhWbLRluF9I4YwpcjPhshe7gm6O8loSiQkFZFFVt4cMqDECTR6TbZPAT8joL73GLNfLH9qFbogNYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fVaCowwg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 Oct 2025 15:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759332798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Yv0CwkielXUFY13Tke9yDHu46iA3m89ltKb+trU33A=;
	b=fVaCowwgrrW4wG/jzU1zmwNJvtpZ07/RFYUBwwSe7afqIXdgVgQ6tU9Dg2PNGvbgbNN7Lk
	Rj1UQFZNqlWPIqjrPgfeiO1Pl4SDn+QbT9yuD1DHae6U0TMP/nBSeq//qx3HWFpK2iYLsC
	SvEgMc2jmmmwjAWhsAAvOYVu+W2Y/Gk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, 
	"sj@kernel.org" <sj@kernel.org>, "kasong@tencent.com" <kasong@tencent.com>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, 
	"davem@davemloft.net" <davem@davemloft.net>, "clabbe@baylibre.com" <clabbe@baylibre.com>, 
	"ardb@kernel.org" <ardb@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>, 
	"surenb@google.com" <surenb@google.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, 
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v12 20/23] mm: zswap: Per-CPU acomp_ctx resources exist
 from pool creation to deletion.
Message-ID: <6frwacvukeaqrmtja43ab3nkldkrupczmhelrgjljvtk5eh4km@4pebysubl3dl>
References: <20250926033502.7486-1-kanchana.p.sridhar@intel.com>
 <20250926033502.7486-21-kanchana.p.sridhar@intel.com>
 <j4o53f24yeegzrj7aj2mbu5c2xyqksnb6uz2fjkwgi3dbbtqsw@cwatjnrsgbco>
 <SA3PR11MB81201CE73D6CCF274BB2265FC91AA@SA3PR11MB8120.namprd11.prod.outlook.com>
 <7gnj6tcuvqg7vxqu4otqznvtdhus3agtxkorwy3nm2zobkd7vn@hqanfuyklt7u>
 <SA3PR11MB81209CF02417CED3C0459504C91AA@SA3PR11MB8120.namprd11.prod.outlook.com>
 <6xb7feds424kfld4udwmbtccftwnnx6vmbpvmjcwlionfdlmuj@vz4uzh6tog5g>
 <SA3PR11MB8120D4BDA8A6980A4BC5447FC91AA@SA3PR11MB8120.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR11MB8120D4BDA8A6980A4BC5447FC91AA@SA3PR11MB8120.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 30, 2025 at 09:56:33PM +0000, Sridhar, Kanchana P wrote:
> 
> > -----Original Message-----
> > From: Yosry Ahmed <yosry.ahmed@linux.dev>
> > Sent: Tuesday, September 30, 2025 2:20 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; ryan.roberts@arm.com; 21cnbao@gmail.com;
> > ying.huang@linux.alibaba.com; akpm@linux-foundation.org;
> > senozhatsky@chromium.org; sj@kernel.org; kasong@tencent.com; linux-
> > crypto@vger.kernel.org; herbert@gondor.apana.org.au;
> > davem@davemloft.net; clabbe@baylibre.com; ardb@kernel.org;
> > ebiggers@google.com; surenb@google.com; Accardi, Kristen C
> > <kristen.c.accardi@intel.com>; Gomes, Vinicius <vinicius.gomes@intel.com>;
> > Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v12 20/23] mm: zswap: Per-CPU acomp_ctx resources
> > exist from pool creation to deletion.
> > 
> > > > > > >  static struct zswap_pool *zswap_pool_create(char *compressor)
> > > > > > >  {
> > > > > > >  	struct zswap_pool *pool;
> > > > > > > @@ -263,19 +287,43 @@ static struct zswap_pool
> > > > > > *zswap_pool_create(char *compressor)
> > > > > > >
> > > > > > >  	strscpy(pool->tfm_name, compressor, sizeof(pool-
> > >tfm_name));
> > > > > > >
> > > > > > > -	pool->acomp_ctx = alloc_percpu(*pool->acomp_ctx);
> > > > > > > +	/* Many things rely on the zero-initialization. */
> > > > > > > +	pool->acomp_ctx = alloc_percpu_gfp(*pool->acomp_ctx,
> > > > > > > +					   GFP_KERNEL |
> > __GFP_ZERO);
> > > > > > >  	if (!pool->acomp_ctx) {
> > > > > > >  		pr_err("percpu alloc failed\n");
> > > > > > >  		goto error;
> > > > > > >  	}
> > > > > > >
> > > > > > > -	for_each_possible_cpu(cpu)
> > > > > > > -		mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)-
> > >mutex);
> > > > > > > -
> > > > > > > +	/*
> > > > > > > +	 * This is serialized against CPU hotplug operations. Hence,
> > cores
> > > > > > > +	 * cannot be offlined until this finishes.
> > > > > > > +	 * In case of errors, we need to goto "ref_fail" instead of
> > "error"
> > > > > > > +	 * because there is no teardown callback registered anymore,
> > for
> > > > > > > +	 * cpuhp_state_add_instance() to de-allocate resources as it
> > rolls
> > > > > > back
> > > > > > > +	 * state on cores before the CPU on which error was
> > encountered.
> > > > > > > +	 */
> > > > > > >  	ret =
> > > > > > cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
> > > > > > >  				       &pool->node);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * We only needed the multi state instance add operation to
> > invoke
> > > > > > the
> > > > > > > +	 * startup callback for all cores without cores getting offlined.
> > Since
> > > > > > > +	 * the acomp_ctx resources will now only be de-allocated
> > when the
> > > > > > pool
> > > > > > > +	 * is destroyed, we can safely remove the multi state
> > instance. This
> > > > > > > +	 * minimizes (but does not eliminate) the possibility of
> > > > > > > +	 * zswap_cpu_comp_prepare() being invoked again due to a
> > CPU
> > > > > > > +	 * offline-online transition. Removing the instance also
> > prevents race
> > > > > > > +	 * conditions between CPU onlining after initial pool creation,
> > and
> > > > > > > +	 * acomp_ctx_dealloc() freeing the acomp_ctx resources.
> > > > > > > +	 * Note that we delete the instance before checking the error
> > status
> > > > > > of
> > > > > > > +	 * the node list add operation because we want the instance
> > removal
> > > > > > even
> > > > > > > +	 * in case of errors in the former.
> > > > > > > +	 */
> > > > > > > +
> > 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
> > > > > > &pool->node);
> > > > > > > +
> > > > > >
> > > > > > I don't understand what's wrong with the current flow? We call
> > > > > > cpuhp_state_remove_instance() in pool deletion before freeing up the
> > > > > > per-CPU resources. Why is this not enough?
> > > > >
> > > > > This is because with the changes proposed in this commit, the multi
> > state
> > > > > add instance is used during pool creation as a way to create acomp_ctx
> > > > > resources correctly with just the offline/online state transitions
> > guaranteed
> > > > > by CPU hotplug, without needing additional mutex locking as in the
> > > > mainline.
> > > > > In other words, the consistency wrt safely creating/deleting acomp_ctx
> > > > > resources with the changes being proposed is accomplished by the
> > hotplug
> > > > > state transitions guarantee. Stated differently, the hotplug framework
> > > > > helps enforce the new design during pool creation without relying on the
> > > > > mutex and subsequent simplifications during zswap_[de]compress()
> > > > > proposed in this commit.
> > > > >
> > > > > Once this is done, deleting the CPU hotplug state seems cleaner, and
> > > > reflects
> > > > > the change in policy of the resources' lifetime. It also prevents race
> > > > conditions
> > > > > between zswap_cpu_comp_prepare() and acomp_ctx_dealloc() called
> > from
> > > > > zswap_pool_destroy().
> > > >
> > > > How is a race with zswap_cpu_comp_prepare() possible if we call
> > > > cpuhp_state_remove_instance() before acomp_ctx_dealloc() in the pool
> > > > deletion path?
> > >
> > > Good point. I agree, calling cpuhp_state_remove_instance() before
> > > acomp_ctx_dealloc() will not cause a race. However, if we consider the
> > > time from pool creation to deletion: if there is an online-offline-online
> > > transition, can zswap_cpu_comp_prepare() race with the call to
> > > cpuhp_state_remove_instance()? If so, wouldn't this cause unpredictable
> > > behavior?
> > 
> > How will this race happen?
> > 
> > cpuhp_state_remove_instance() is called while a pool is being destroyed,
> > while zswap_cpu_comp_prepare() while the pool is being created or during
> > CPU onlining.
> > 
> > The former cannot race, and the latter should be synchronized by hotplug
> > code.
> > 
> > >
> > > I agree, this can occur even with the code in this commit, but there is
> > > less risk of things going wrong because we remove the CPU hotplug
> > > instance before the pool is added to zswap_pools.
> > >
> > > Further, removing the CPU hotplug instance directly codifies the
> > > intent of this commit, i.e., to use this as a facilitator and manage memory
> > > allotted to acomp_ctx, but not to manage those resources' lifetime
> > > thereafter.
> > >
> > > Do you see any advantage of keeping the call to
> > cpuhp_state_remove_instance()
> > > occur before acomp_ctx_dealloc() in zswap_pool_destroy()? Please let me
> > know
> > > if I am missing something.
> > 
> > What about more CPUs going online? Without the hotplug instance we don't
> > get per-CPU resources for those. We are not using the hotplug mechanism
> > just to facilitate per-CPU resource allocation, we use it to
> > automatically allocate resources for newly onlined CPUs without having
> > to preallocate for all possible CPUs.
> 
> This is an excellent point! It makes sense, I will move the call to
> cpuhp_state_remove_instance() to be before the call to
> acomp_ctx_dealloc() in zswap_pool_destroy(). Thanks for catching this.
> 
> > 
> > Also, this makes the code more difficult to reason about, and is an
> > unncessary change from the current behavior.
> 
> Ok.
> 
> > 
> > The only change needed is to drop the teardown callback and do the
> > freeing in the pool destruction path instead.
> 
> Just to summarize: besides moving the call to cpuhp_state_remove_instance()
> to zswap_pool_destroy() and more concise comments/commit logs, are there
> other changes to be made in patch 20?

I don't believe so. Thanks!

