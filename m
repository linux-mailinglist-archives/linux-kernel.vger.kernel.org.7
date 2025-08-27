Return-Path: <linux-kernel+bounces-788954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287DBB38E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2ABB364A17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1C2FABF7;
	Wed, 27 Aug 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vr0a0HgC"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C542D9ECD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333733; cv=none; b=meS7hHoe0iyvxUQlobi8zu4U0LrYJ53vaeoFC/3xRIpPRBg4S0v/Rhz/+M8aMHqKoCyhgmJPt3gUzXotZRAhNzkPx/rrQaIEX67U097xfPa24dBLLCCIzjYcp3mTMXlW7J+oaqaZR7xGm646V3SFhSHr6bhzurPcKn2Y1c8WLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333733; c=relaxed/simple;
	bh=1MyoQ88Dlx5SVBOs/7KpZ0Ch+PC0HTBltKj6Jfd4Dwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR+daWJXAHazIA2VtUCaDxT3+T71chfN7Tuoh3g99vE5YSCii8yqqDarPoyLNoGk5ENSsoU6qLWbj9pLdN0449Px4XhJH8c8uCW8OnciAVnjaiFa0cqTltkW8qGvfFnf4LnVGkt2nF7F0g2yNsulOamzAaXqn9iWHpwx8P6h1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vr0a0HgC; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 15:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756333729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRq+gbpGkmW/G/n6vBoPnBK6eieMpjXC5ktdU2MfsEI=;
	b=Vr0a0HgCcBfciF92/PnFlQZt4IMQfE/HIXcAjf5pACT23rNjPUxEZQ7Hs958KzalpcKMp+
	lN07CxWfsKLiBKciYvbvibpJZKloFj+q7PozrBB5SkiH/QbGiHQwyJ/b4ArcwNl9Z26y64
	hvY3KWLj2aMa/nJ+LzONEfEe0r70igo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yueyang Pan <pyyjason@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <aouiudhvbuwegvkdqwtkp7bk6gvrsxkqe7us5uj6ylg3pivjin@nl4ri6fbh2zd>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 27, 2025 at 03:06:19PM -0700, Andrew Morton wrote:
> On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > In production, show_mem() can be called concurrently from two
> > different entities, for example one from oom_kill_process()
> > another from __alloc_pages_slowpath from another kthread. This
> > patch adds a mutex and invokes trylock before printing out the
> > kernel alloc info in show_mem(). This way two alloc info won't
> > interleave with each other, which then makes parsing easier.
> > 
> 
> Fair enough, I guess.
> 
> > --- a/mm/show_mem.c
> > +++ b/mm/show_mem.c
> > @@ -23,6 +23,8 @@ EXPORT_SYMBOL(_totalram_pages);
> >  unsigned long totalreserve_pages __read_mostly;
> >  unsigned long totalcma_pages __read_mostly;
> >  
> > +static DEFINE_MUTEX(mem_alloc_profiling_mutex);
> 
> It would be a bit neater to make this local to __show_mem() - it didn't
> need file scope.

+1, something static to __show_mem().

> 
> Also, mutex_unlock() isn't to be used from interrupt context, so
> problem.
> 
> Something like atomic cmpxchg or test_and_set_bit could be used and
> wouldn't involve mutex_unlock()'s wakeup logic, which isn't needed
> here.

+1

> 
> >  static inline void show_node(struct zone *zone)
> >  {
> >  	if (IS_ENABLED(CONFIG_NUMA))
> > @@ -419,7 +421,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> >  #endif
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > -	if (mem_alloc_profiling_enabled()) {
> > +	if (mem_alloc_profiling_enabled() && mutex_trylock(&mem_alloc_profiling_mutex)) {
> >  		struct codetag_bytes tags[10];
> >  		size_t i, nr;
> >  
> > @@ -445,6 +447,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >  						  ct->lineno, ct->function);
> >  			}
> >  		}
> > +		mutex_unlock(&mem_alloc_profiling_mutex);
> >  	}
> 
> If we're going to suppress the usual output then how about we let
> people know this happened, rather than silently dropping it?
> 
> pr_notice("memory allocation output suppressed due to show_mem() contention\n")
> 
> or something like that?

Personally I think this is not needed as this patch is suppressing only
the memory allocation profiling output which is global, will be same
for all the consumers and context does not matter. All consumers will
get the memory allocation profiling data eventually.

