Return-Path: <linux-kernel+bounces-834482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8ABA4C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741087AFA79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AF52FF66C;
	Fri, 26 Sep 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP/0kHkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA241B4138
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909007; cv=none; b=UgMbdsRm4ddP4++JFGqudNGJOFZv/VPxjccDrXS51/T6/Fi1lzKDrN7YCSekHnFLe04Tneq8Q5ysnlloUyNSo+O3H609HUpOwFu8GUzVGUSY5rtFRR+B6RFZnjzm3jZFWnZxWISfUaWsUMkZ3jlqOewoMdf4ui2JBSLSgRqyjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909007; c=relaxed/simple;
	bh=SNVyu5gv5hl8E6Qx2wc/yrakuqwwjH4Ub9je2xkzgaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZTxB47kC5QHh6qvV09efScB6bN7XFGoVaqdEushA1LnGW6+r/xltGBhdog95mBea8cI2nLYaGatdadfhYyrMvCQ83vyhH+iP+QFGRuFN9DajZSzC/fQKjHh7j1LFqzPrqypYivHMkiHv9Bi3kmPQyWgJeG2ApQoC3PLHA/dPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP/0kHkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC5FC4CEF4;
	Fri, 26 Sep 2025 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758909006;
	bh=SNVyu5gv5hl8E6Qx2wc/yrakuqwwjH4Ub9je2xkzgaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iP/0kHkAX2Ih1cjA6REv4/yQ/PVDQLisR/NNCt3epWOJp4WR6kWUJN/yZ9paUrlTq
	 QOT8HRoKT6acsywhGEG6G83EZqi0f5E3Ql0m4tfodVM2sVSnCNIlGfXLXuQj/7rY5s
	 14dD8pJ5yXexC0GAyCwJIvxlo1wBR6TnPpvGKg6GdkXTkgg0GCwKdy/1yZpLiLpukD
	 lI1Yrandmm1t1SbyfKYzOdUX1WdTo65t/lOpXO7W0h35vgCj4oeU/gbJKwQlWJ40qK
	 wZARlWd05vyx1cx8OEaxwmqy8kQ8VUvLVZrtIcXEToAdBMT8TO0FpEmrsKte6s4C/e
	 d4JCzshH5uDmw==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Fri, 26 Sep 2025 10:50:04 -0700
Message-Id: <20250926175004.54610-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924204409.1706524-2-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 13:44:05 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Currently, refresh_cpu_vm_stats returns an int, indicating how many
> changes were made during its updates. Using this information, callers
> like vmstat_update can heuristically determine if more work will be done
> in the future.
> 
> However, all of refresh_cpu_vm_stats's callers either (a) ignore the
> result, only caring about performing the updates, or (b) only care about
> whether changes were made, but not *how many* changes were made.
> 
> Simplify the code by returning a bool instead to indicate if updates
> were made.
> 
> In addition, simplify fold_diff and decay_pcp_high to return a bool
> for the same reason.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/linux/gfp.h |  2 +-
>  mm/page_alloc.c     |  8 ++++----
>  mm/vmstat.c         | 26 +++++++++++++-------------
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 5ebf26fcdcfa..63c72cb1d117 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -386,7 +386,7 @@ extern void free_pages(unsigned long addr, unsigned int order);
>  #define free_page(addr) free_pages((addr), 0)
>  
>  void page_alloc_init_cpuhp(void);
> -int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
> +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
>  void drain_all_pages(struct zone *zone);
>  void drain_local_pages(struct zone *zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1d037f97c5f..77e7d9a5f149 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2561,10 +2561,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>   * Called from the vmstat counter updater to decay the PCP high.
>   * Return whether there are addition works to do.
>   */
> -int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
> +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
>  {
>  	int high_min, to_drain, batch;
> -	int todo = 0;
> +	bool todo;

I know you and others already found 'todo' should be initialized. :)

[...]
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 71cd1ceba191..1f74a3517ab2 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
[...]
> @@ -839,7 +839,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  		if (do_pagesets) {
>  			cond_resched();
>  
> -			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
> +			changed |= decay_pcp_high(zone, this_cpu_ptr(pcp));

I'm not a fan of bit operations unless it provides clear benefits.
What about below?

    if (decay_pcp_high(zone, this_cpu_ptr(pcp)) && !changed)
    	changed = truee;

Just a personal and trivial taste.  No strong opinion.  If you don't strongly
feel my suggestion is better, please keep the original code.

>  #ifdef CONFIG_NUMA
>  			/*
>  			 * Deal with draining the remote pageset of this
> @@ -861,13 +861,13 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  			}
>  
>  			if (__this_cpu_dec_return(pcp->expire)) {
> -				changes++;
> +				changed = true;
>  				continue;
>  			}
>  
>  			if (__this_cpu_read(pcp->count)) {
>  				drain_zone_pages(zone, this_cpu_ptr(pcp));
> -				changes++;
> +				changed = true;
>  			}
>  #endif
>  		}
> @@ -887,8 +887,8 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>  		}
>  	}
>  
> -	changes += fold_diff(global_zone_diff, global_node_diff);
> -	return changes;
> +	changed |= fold_diff(global_zone_diff, global_node_diff);
> +	return changed;

Ditto.

>  }
>  
>  /*
> -- 
> 2.47.3

Other than the above trivial things, all looks good to me :)


Thanks,
SJ

