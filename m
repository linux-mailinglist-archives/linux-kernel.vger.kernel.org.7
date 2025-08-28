Return-Path: <linux-kernel+bounces-790805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0DB3AD43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9020516AF45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A022BF000;
	Thu, 28 Aug 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW2LI3Rd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90824196C7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418832; cv=none; b=jv/7BLDoH0buHzEejDFGp30mrNDv+DtWR7E6So72apTy48C7k9ASggGLQBBqFhM9URYAG1SfDrmnX0O+oQM9nizZnpTxph7Bi+1td2CoRJsIQ7N6xA7RvCO+ojZFoNDKQQSsa1w5inMGNp9sX6QkMNI9oI8YO0yQgS7er3OCevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418832; c=relaxed/simple;
	bh=W3G7bqKDXl9XFBo+S14aYpWS46+pyWeVOLhJr4HmGUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm5j4WhMv3bOaedFmouCSulaethQPq123GNrC7xEqEVSRgJcXKpcAhmNf5mtad4nWOdb6VWg1PWOLkWnSCjBBErH1WtoGwGDW4wLAXgKeKlIHHGmQbzQP4NTAoLgkm8qfD+IbTilHBtgWR7j1hlF1KiiJKG8RltTfIokSVsfEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW2LI3Rd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b7d485173so5952815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756418829; x=1757023629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/AnHM5Ys5MspHOXR+HJG2nQahjdzPCxrStRtIapffc=;
        b=QW2LI3RdyydHBG2W5Q/5REf48604WCZV54dpJ7fWuj0hYlTT+uQNd1iSRLwz0RbdDE
         3d2U61i1zZ0Jy6RdqNj/2iUFRYwewI5A9NiGjR5peva+ea550HWeJnW3WhPpGKCRfImv
         gWc17FsfCgODgENxP9Uf4iu1Iy9b611/Ob661N/No7MbTn4hC6RAuO6H7pcHaO2Tdgcf
         VhjAsrpz0QE9H6hXeEJwCjlkWw8D4puxvXE9TF8yY7cQvf6xgNO7Qri+PRdnEfWNs1h5
         cFPz/PZevku9++qGO8Dyz52e/zM7Jp2tzlw+8VLzAUt2hh/vMmQ6QDsvOKOGYp2us94P
         efZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756418829; x=1757023629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/AnHM5Ys5MspHOXR+HJG2nQahjdzPCxrStRtIapffc=;
        b=xKWWNk5Nr722QFhV0hY5vIwpKdURqYyA8lPQiNA5CGmbvBgwmMNlxl8X3JeElzvOPv
         yJxt2Lfx3u8VyFW9agtUiJ6ZhEVxfEIfBE7rVIKDgiwpRjtq1P04MXxUmuV8PZciYJzs
         TUX1pWXTvwQnUg+UvKMGuRmnpJ/eijoqfQr8sS2CwHy2KcVUO2yv6ejRoehns4qXQ1nt
         6UK+E4m2ZSya0Ef53V/61aKva1P2XDDYZkjvkFGk6YQCyy8eZOYFs4Yo1PcBZH1DAOAz
         c1BI7GSnk2EzBu4/VaGLK3tJ8agm3n2sb5KaUd3REa4WGRZWorPWE1/zkuIUKuFaKJhr
         zNKw==
X-Forwarded-Encrypted: i=1; AJvYcCWdFA44oLxVyHF1esvmQ350xDtkieoZCMX8x1wNTXLAIUoiKdYyyn9mQfR93V8ZRtxHJAxIK4/YL25SLDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJBA9uPI0AR09st46HlPe19A4NCmu/92WBO0xntsdCZM1SKY8
	h7xz5r2Fg2UePZBVZTYizWmvqMLZz4w3BwqUp4Nt69e+mdCl19w7b+c8
X-Gm-Gg: ASbGnctRZfcMnuid4eQp29jcFiETs8ZuIXi3oyq9a9tTfz0CjMatiV+5P86eREVUxLa
	Z5PRc5i7v+CjlVHYk+1zL052zJDtLo4JugPYs5PXX3gcgWkyL4ctYBnma7mQ3sScflXMpMVUKH5
	XJJ5KtceVficBM1dR8yvWWQ0Gw+nHA1eMW1pXoc8falcXQ3dzmUugJRHyZX8rlLSCZ/6jHgFGAS
	IpFmPgc8++ehTxhjdiXmdHFqnREjUAh944QpGBOiNdTFs/B2KaFFNfk+0Cqs8tI53uD69fnTEdQ
	yxFuU69kyHasRdier6RgS59s0dfFgpTZqGLLns+Kiqb+XrXYdAmEt4u5yoEI5F0n9U2bLbUOV5P
	iWZOxA2s5gadx9cSm8XuVBTDIkrNvnp2U6JdbbJ0=
X-Google-Smtp-Source: AGHT+IG1+AIr99KFjMYVoVuiy5WkytM9+XOL5QNqyv4VEiPFHZ/q2dKTsnCr0aimIS6RwmgQIysRjw==
X-Received: by 2002:a05:600c:1f88:b0:45b:67e9:121f with SMTP id 5b1f17b1804b1-45b67e91509mr135069255e9.16.1756418828609;
        Thu, 28 Aug 2025 15:07:08 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d141esm12130995e9.2.2025.08.28.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 15:07:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:07:01 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mm/show_mem: Bug fix for print mem alloc info
Message-ID: <aLDTBSuM3xVbUok2@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <aK9htWRehfJDLFJD@fedora>
 <aLATVGnVx4Z+aHAh@devbig569.cln6.facebook.com>
 <aLCMTu-Ci2yV40zn@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLCMTu-Ci2yV40zn@fedora>

On Thu, Aug 28, 2025 at 10:05:18AM -0700, Vishal Moola (Oracle) wrote:
> On Thu, Aug 28, 2025 at 01:29:08AM -0700, Yueyang Pan wrote:
> > On Wed, Aug 27, 2025 at 12:51:17PM -0700, Vishal Moola (Oracle) wrote:
> > > On Wed, Aug 27, 2025 at 11:34:21AM -0700, Yueyang Pan wrote:
> > > > This patch set fixes two issues we saw in production rollout. 
> > > > 
> > > > The first issue is that we saw all zero output of memory allocation 
> > > > profiling information from show_mem() if CONFIG_MEM_ALLOC_PROFILING 
> > > > is set and sysctl.vm.mem_profiling=0. In this case, the behaviour 
> > > > should be the same as when CONFIG_MEM_ALLOC_PROFILING is unset, 
> > > 
> > > Did you mean to say when sysctl.vm.mem_profiling=never?
> > > 
> > > My understanding is that setting the sysctl=0 Pauses memory allocation
> > > profiling, while 1 Resumes it. When the sysctl=never should be the same
> > > as when the config is unset, but I suspect we might still want the info
> > > when set to 0.
> > 
> > Thanks for your feedback Vishal. Here I mean for both =0 and =never. 
> > In both cases, now __show_mem() will print all 0s, which both is redundant 
> > and also makes differentiate hard. IMO when __show_mem() prints something 
> > the output should be useful at least. 
> 
> If differentiating between 0 allocations vs disabled is the primary
> concern, I think prefacing the dump with the status of the tool is
> better than treating =0 and =never as the same.
> 
> The way I see it, the {0,1,never} tristate offers a level of versatility
> that I'm not sure we need to eliminate.
> 
> I'm thinking about cases where we may temporarily set =1 to track some
> allocations, then back to =0 'pause' on that exact period of time. Memory
> allocation profiling still has those allocations tracked while set to =0
> (we can still see them in /proc/allocinfo at least). If a user decided to
> do that just before an oom, could they see something useful from
> show_mem() even when =0?

This is a good point. I agree with your suggestion about adding the state 
to print. I am still unsure about if we want to print it when =0. The first 
reason is that memory allocation profiler does not support runtime enabling 
now. We have to set it via boot cmdline. It will make more sense if we 
have this feature. Second is because memory allocation profiling is quite 
light-weighted, I would assume user really don't need this feature when 
they set =0.

The original reason why I tried to disable this is because in our production 
table we see a lot of 0Bs coming from the machines where the changes in boot 
cmdline have not been pushed to. If we have state info, we could possibly 
filter this info out before sending it to the table. So I agree upon adding 
the state to print.

Maybe others also have thoughts about this?

> 
> > > 
> > > > where show_mem prints nothing about the information. This will make 
> > > > further parse easier as we don't have to differentiate what a all 
> > > > zero line actually means (Does it mean  0 bytes are allocated 
> > > > or simply memory allocation profiling is disabled).
> > > > 
> > > > The second issue is that multiple entities can call show_mem() 
> > > > which messed up the allocation info in dmesg. We saw outputs like this:  
> > > > ```
> > > >     327 MiB    83635 mm/compaction.c:1880 func:compaction_alloc
> > > >    48.4 GiB 12684937 mm/memory.c:1061 func:folio_prealloc
> > > >    7.48 GiB    10899 mm/huge_memory.c:1159 func:vma_alloc_anon_folio_pmd
> > > >     298 MiB    95216 kernel/fork.c:318 func:alloc_thread_stack_node
> > > >     250 MiB    63901 mm/zsmalloc.c:987 func:alloc_zspage
> > > >     1.42 GiB   372527 mm/memory.c:1063 func:folio_prealloc
> > > >     1.17 GiB    95693 mm/slub.c:2424 func:alloc_slab_page
> > > >      651 MiB   166732 mm/readahead.c:270 func:page_cache_ra_unbounded
> > > >      419 MiB   107261 net/core/page_pool.c:572 func:__page_pool_alloc_pages_slow
> > > >      404 MiB   103425 arch/x86/mm/pgtable.c:25 func:pte_alloc_one
> > > > ```
> > > > The above example is because one kthread invokes show_mem() 
> > > > from __alloc_pages_slowpath while kernel itself calls 
> > > > oom_kill_process()
> > > 
> > > I'm not familiar with show_mem(). Could you spell out what's wrong with
> > > the output above?
> > 
> > So here in the normal case, the output should be sorted by size. Here 
> > two print happen at the same time so they interleave with each other, 
> > making further parse harder (need to sort again and dedup).
> 
> Gotcha.
> 
> > > 
> > > > Yueyang Pan (2):
> > > >   mm/show_mem: No print when not mem_alloc_profiling_enabled()
> > > >   mm/show_mem: Add trylock while printing alloc info
> > > > 
> > > >  mm/show_mem.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > -- 
> > > > 2.47.3
> > > > 
> > 
> > Thanks,
> > Pan

