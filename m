Return-Path: <linux-kernel+bounces-892602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C540C456E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6BD188FBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D042FD698;
	Mon, 10 Nov 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QakBKAIe"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067632FD1BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764545; cv=none; b=EJdq/jDWRUJDukqsh4U1P9b083tSC86NVOMQ96nPBFxLqWQAkbmtjlH7OFev0vvbXUx1EeJH8Sll23DQTzwnK86zlQDIR4vBoNKoKE/5moNsr0dohxXEQL7rDOsXo0nbnJqtqsZXZp9IIs1SHInJzNCMEFge7f6NEr1wIkNQYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764545; c=relaxed/simple;
	bh=SYX+Wy7bJsOihCfrh07XC2V+14ZgJEkkJ3rX4N05Puk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVFALSQlCS9OOtwzN21jRCI5OF+r1tA4SANwJ4wSSShM7qV8xd+blQY/0z4f1gdyk0I4E5uNOh1S1wtN+Vln3Qk6zj9ZYp7zvXUjJpCTStlcaEgjB6FuFT//QrjNeItesQn7wt6wsMrywRvvEeuQY75fq1GoaAGuAlT6fzn64do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QakBKAIe; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so413484366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762764541; x=1763369341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYB3eNFBCkjH9q1uLbtzcXRkRk6p1kh+Sygy8eTu3sY=;
        b=QakBKAIe/3yS67qIEcpuvukggq1LgUspMnGX4htskEVXk1zn1I0y2o8KYWPr2CUE3d
         fhhLcSOtLH7YMw4KhZeH6/TPHOiWE4z9mCihclFUxyfrXSx2cZ5O/gxJ+eVp3UlxgBWk
         savu48/aDFOsqYzHGARsRwBBfLrVmdVkQi3m9KNNvzA2v9XeC5kteHaH6I4+l8uepCS/
         35NGsA3G70gFeCWFw4mLot930jUX716OxTtWfPZeutu2a3rJ7MPQ9RaOY261Y26l9woi
         q1cgnMz6OMLAtqcSamq/EV+rJDeUd4obdrOd05K6bd2qbpFwNkYrwXcIDIvpzI0Blb0Q
         5hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764541; x=1763369341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYB3eNFBCkjH9q1uLbtzcXRkRk6p1kh+Sygy8eTu3sY=;
        b=pmw/mPdph+KG4hFXLh4l/FPiire8ugT91bSYerJRLbILfGz6M0+fC77bCTz3KOdAC1
         DOpGfZ5o7x+/VQq7Is1aDZz4xq70cVwgdY+g4EixDuba48OPE/H7e9aGRyIT2u6FbTVL
         OHri7IImUl1DdizNH+XiJMoFzUiFvRy/zGkC8JYO2/hbH87ATXT/vrkzkFNS7LdPwCVs
         mGUv1iaz0Sy2hZLR5dddohj+rKK6vK9/POm/NNjz1a9wUkxzkR93orr5rdwU9h1ansUH
         xDiMJyuj2AgNjWuzv5XRxWAfocCVbOy7czZxIIwlBoEfzqjTBFe36fyMjMjXmAql6CMZ
         T5GA==
X-Forwarded-Encrypted: i=1; AJvYcCWAeD+Cyc457BPrJsPhDUVqsxSWhW5Vw8XCsAES9Fo71VM2yP5qKH7nDk7wyBCQCh8blr/rjxkPYnemJkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOF/G3tg2P/iMOe/UQ58CpEJgBmN2ip7cjIM7fw6xBQbB6pGZ
	S3MCqqtAFX7mPZA4MK1I74OGQLOXuglIR+aNdEaDMJpd/Cus2Nxu2r9kQshP1maoZHE=
X-Gm-Gg: ASbGnctap/enQFZ2z+6f4kpKKX3dYO3EDWXyWG1BaXLhrj4gwsOTXyQn8B+KihIZcKg
	aIuOTVR7jalAJN2O2Jc48uBnGA6t2TW6bormL2wcQ803daJ7TtBuISUnumeHCerlzf01ZCNTTSY
	1yEBUOAt1IBoY2G0mvedmSdyOOzvW/PGHLNxXhcm30h7T9p0GEqBwwnzMPC/9wetI7ntoYhjt86
	eptXO2QgF8O7q/+uDe/O2FyUYrqDj9MJ0brMOZDTaJw02aMj0z1v7NLH+Tp3n5dI512FGIJqQ3f
	9P/KyPaMvZ65jWWWsMCVc/rm3igYNaGDgZn/I+Vbs6B82I8glHst73+srXpvFgvGYMDSE8bUa32
	03YmzWca9/+zzCJhjUSjUpydqNG7LuMms5hPPV8lbsJCJxaLHqoMlKj+rxYIld122KCfXOLYqwF
	99xPLskEzNbdnDB5jvBnylp1EZ
X-Google-Smtp-Source: AGHT+IHkCcGZffVbGb8qG3xm/rRfqIb/GgVIQQoNThnr6QrJwoyhjqnbS9/gl3lEpfFn0E7hIkOGtw==
X-Received: by 2002:a17:907:9807:b0:b6d:2b14:4aa4 with SMTP id a640c23a62f3a-b72e05ac909mr660427666b.63.1762764541165;
        Mon, 10 Nov 2025 00:49:01 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be184sm1016802566b.56.2025.11.10.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:49:00 -0800 (PST)
Date: Mon, 10 Nov 2025 09:48:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: memcg: dump memcg protection info on oom or alloc
 failures
Message-ID: <aRGm-yJwkHIlF07I@tiehlicka>
References: <20251107234041.3632644-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107234041.3632644-1-shakeel.butt@linux.dev>

On Fri 07-11-25 15:40:41, Shakeel Butt wrote:
> Currently kernel dumps memory state on oom and allocation failures. One
> of the question usually raised on those dumps is why the kernel has not
> reclaimed the reclaimable memory instead of triggering oom. One
> potential reason is the usage of memory protection provided by memcg.
> So, let's also dump the memory protected by the memcg in such reports to
> ease the debugging.

Makes sense to me.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/memcontrol.h |  5 +++++
>  mm/memcontrol.c            | 13 +++++++++++++
>  mm/oom_kill.c              |  1 +
>  mm/page_alloc.c            |  1 +
>  4 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 8d2e250535a8..6861f0ff02b5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1779,6 +1779,7 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
>  	return memcg ? css_is_dying(&memcg->css) : false;
>  }
>  
> +void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
>  #else
>  static inline bool mem_cgroup_kmem_disabled(void)
>  {
> @@ -1850,6 +1851,10 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
>  {
>  	return false;
>  }
> +
> +static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> +{
> +}
>  #endif /* CONFIG_MEMCG */
>  
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c34029e92bab..623446821b00 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5636,3 +5636,16 @@ bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
>  {
>  	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
>  }
> +
> +void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> +{
> +	if (mem_cgroup_disabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return;
> +
> +	if (!memcg)
> +		memcg = root_mem_cgroup;
> +
> +	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
> +		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
> +		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
> +}
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c145b0feecc1..5eb11fbba704 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -472,6 +472,7 @@ static void dump_header(struct oom_control *oc)
>  		if (should_dump_unreclaim_slab())
>  			dump_unreclaimable_slab();
>  	}
> +	mem_cgroup_show_protected_memory(oc->memcg);
>  	if (sysctl_oom_dump_tasks)
>  		dump_tasks(oc);
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e4efda1158b2..26be5734253f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3977,6 +3977,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
>  		filter &= ~SHOW_MEM_FILTER_NODES;
>  
>  	__show_mem(filter, nodemask, gfp_zone(gfp_mask));
> +	mem_cgroup_show_protected_memory(NULL);
>  }
>  
>  void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> -- 
> 2.47.3

-- 
Michal Hocko
SUSE Labs

