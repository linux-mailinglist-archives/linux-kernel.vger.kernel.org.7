Return-Path: <linux-kernel+bounces-788909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA1B38CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59D418874B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627C313E26;
	Wed, 27 Aug 2025 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJQ/ThAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB19313526
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332381; cv=none; b=BnDPAYdo3BQZvOBmg4/6lsm5y72l6gF1uQ8TF6admKRCHB2F4ryD4bki3RrhbbVEcvW294SlSrv4kEFpgJk9qZ6cy7za3eVaYpZ9LSCEMMtD/yY3LWoNnPlg/b7iUvsEMO68CXAPh+wdAI2h/3V6v/3guIQW8+rfWJ4CI1cwV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332381; c=relaxed/simple;
	bh=QtZo2wLiVrvIDs2z9ZU576b2zdkNZlOfu/w0v8RzTyg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wv18LTewYU0eaL/kcpyx0wfCweFnU3y6aolbHFTwWsjMgawQDhuj84tng12sO62pNGY9jcwF95a2Djbyg5rPcsKO5XlkqZ/N2rEALSPvMQ2jPqvHNXMl0kb/pHJ0xaO21qh62/i+f8nU9PByE5kd1vySN5WtAo4UAZCdYs7ltn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJQ/ThAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A622C4CEEB;
	Wed, 27 Aug 2025 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756332380;
	bh=QtZo2wLiVrvIDs2z9ZU576b2zdkNZlOfu/w0v8RzTyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJQ/ThAi5yoG32jd5YVCjvLgkJikRs+8dIWYeDUSIQWJlAVUHVCDFk+DbZjXzo5pu
	 D4flKoikmxH5XOGDCcJXUsdft4DTEqTNgOexDp4nd0Sedd3EeJ+GNTHkUvNmvk7/ow
	 KhBUBGsDfq6f2HuNoA2o3P7VbewK4UZHYq7mW5/g=
Date: Wed, 27 Aug 2025 15:06:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc
 info
Message-Id: <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
In-Reply-To: <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
	<7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> In production, show_mem() can be called concurrently from two
> different entities, for example one from oom_kill_process()
> another from __alloc_pages_slowpath from another kthread. This
> patch adds a mutex and invokes trylock before printing out the
> kernel alloc info in show_mem(). This way two alloc info won't
> interleave with each other, which then makes parsing easier.
> 

Fair enough, I guess.

> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -23,6 +23,8 @@ EXPORT_SYMBOL(_totalram_pages);
>  unsigned long totalreserve_pages __read_mostly;
>  unsigned long totalcma_pages __read_mostly;
>  
> +static DEFINE_MUTEX(mem_alloc_profiling_mutex);

It would be a bit neater to make this local to __show_mem() - it didn't
need file scope.

Also, mutex_unlock() isn't to be used from interrupt context, so
problem.

Something like atomic cmpxchg or test_and_set_bit could be used and
wouldn't involve mutex_unlock()'s wakeup logic, which isn't needed
here.

>  static inline void show_node(struct zone *zone)
>  {
>  	if (IS_ENABLED(CONFIG_NUMA))
> @@ -419,7 +421,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> -	if (mem_alloc_profiling_enabled()) {
> +	if (mem_alloc_profiling_enabled() && mutex_trylock(&mem_alloc_profiling_mutex)) {
>  		struct codetag_bytes tags[10];
>  		size_t i, nr;
>  
> @@ -445,6 +447,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  						  ct->lineno, ct->function);
>  			}
>  		}
> +		mutex_unlock(&mem_alloc_profiling_mutex);
>  	}

If we're going to suppress the usual output then how about we let
people know this happened, rather than silently dropping it?

pr_notice("memory allocation output suppressed due to show_mem() contention\n")

or something like that?

