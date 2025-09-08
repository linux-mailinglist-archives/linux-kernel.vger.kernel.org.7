Return-Path: <linux-kernel+bounces-805427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8330B4886A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687FC16E0A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7482F2908;
	Mon,  8 Sep 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3qiOu/N"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4B2F616C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323708; cv=none; b=T/Ix57p+NxULGJ7DZzxU8L3YfIPFcrBnIJnTqF5bokAYDV81Fo2TtgmVk9picdUnyuCe1HUbBfKsrrB9W4A6vqyPpy54G+Bz278Yj/qyKiuxyPjO+LVw+rwRDdrSzoyopu9dPGns1gNzTHPZ+Cix6BMUt6GSYSQACTThmhzSPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323708; c=relaxed/simple;
	bh=TBVEeAm7Jtahmfw3TwXLAhZmf3DGQa3stylZWm+XYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlKTxXDcDLygZySuzfIpNbZwzDYiXrD7X3dU+Krmt1ztLe8PdmEw1qNZNnvKalK34br+d2U4790o/kCNLYv7iZ0PoKwKtYFKAhr8eHazlysr+pVR42LBN1pVseI1OeUoZBOePS0izyGSn6qyEikpu9UMcKsvMuD5/Kg85jgWiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3qiOu/N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3dce6eed889so3488815f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757323702; x=1757928502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oULmcJMXha8v5gh2i1FU5HOTdqs6IUKbO31Sh0Sihfo=;
        b=Z3qiOu/N5JLeCGJ1KArDUResn2Ooekd2eNrUjiBarf5GOd5FCc0lNZfL9+2w0PXXbw
         SD/FqDX+a16g8ikki+1Ditu/8uB5GK8shol2pJY+23k9q2VpUH0V5yacstCgGQQxcUYx
         7FHIk2G//Ku9nBRKZw/1ZnOmPen/jJvOxaBMYRNhxWYPViZu2ehEd7SBzt0qZq/9tppH
         uzcTa0DWYbVYvZ3NLmfOV99WpEg1m9fQN5iPwCfDpEaZOsz8w0E08hwl+mEcJ1rLQDPS
         ObJFaqbwEGHa+BxmOfs9DLYbGEN9cT0pD9ifsXGiEg4pUyLAfIP3CL7S0b5B1H5iqwqj
         mYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323702; x=1757928502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oULmcJMXha8v5gh2i1FU5HOTdqs6IUKbO31Sh0Sihfo=;
        b=BTTNILIPbgQnxVhwBQX750JgqsIs8zpkZxCgOQzmWq405zEWLTV+jEdIo2dcKYxo1R
         bhSQik/l72q31kU0qbHMkNZH1LBqN6r2eeYGudgdKEUG+JkiDL4HsywoAix+5ds3HC4f
         zRLuolmbcM99U+HZ1Rg7LwyG/SGOEWP6ZZ6oHJLoID/wi69jvxQh2b7RexBPlwCHeqEK
         KlCLD4vz9KBpRdsbrPyYQFto1S4Npfd/7Ut3OGWm8WoSoULeKvZMQT+FRzV0HMbbQK/1
         l0kU8k1PsjJUarghyKalO27TK7sFhx6B+R/2vMPYb27gsvar6QQUd5myxktm8CrrfGWk
         m2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Q5VJN1CD3faHuerwLYSEwWiz6sc1t/4YrIuu7OLxcTuUlt/9qUK+Pf8rgSgn9gdPITOuxOxbCvpBO6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hz5LaAS/lP5ZfVgSEl1KnGsezWAFxXJzeBF95cV51V4XElU1
	/Gm3ZcnRgNgpkcWwqCxoXBIolou9cDiPNbb9L7yUTrCTES2L+UJe3sDepVV1J1ENLAE=
X-Gm-Gg: ASbGncsx5I6kzBdETuV8JUFRTYeBbgtF8vWdeufGn6RgVabpCa+jB/o07kRM/BVFreN
	IT4RePeCQERshj2ISkBbNvtmY3CqbdyeUjf3zRSadkBATmK9nHBW4GNw/L5ZrIJevIq4Vc7giuG
	7TjP1V8q/J+kTlHkWCvtGCyMh7wydmc14kZVAIhEhU6u/VBp6+LfmMbajh0m1Nxtq9nCvV4xal5
	SfvawRgQg20duyE0GHHEYdvffxW4Tec2087g0Yd55AoDS/dRv33jy1B60MFsu3r08q92ln8qN4u
	cyful4yJzkoOvzuxy+JcKP0oEkyJkZayYgq0G+LLn18VnT2cfNGsNeO1OaHt24Jz5rZySYBYQEB
	mVULxPJ0FBqRydYnK4/KLf0OHAi6l3Q==
X-Google-Smtp-Source: AGHT+IGGMokDFkj82R0pk4Z/rqNX/HhpeR5ehoF8XM4OAGAn6N/D/anNfAR0B0g0zuYN0L4mk8/Jeg==
X-Received: by 2002:a05:6000:4404:b0:3e6:a8ba:7422 with SMTP id ffacd0b85a97d-3e6a8ba779cmr2767890f8f.10.1757323702096;
        Mon, 08 Sep 2025 02:28:22 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fba9fbsm40887135f8f.50.2025.09.08.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:28:21 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:28:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Peilin Ye <yepeilin@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aL6htMt-jHAaCGLv@tiehlicka>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev>

On Fri 05-09-25 13:16:06, Shakeel Butt wrote:
> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 23 ++++++++++++++++-------
>  mm/memcontrol.c            |  7 ++++---
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9dc5b52672a6..054fa34c936a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -993,22 +993,25 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
>  	count_memcg_events_mm(mm, idx, 1);
>  }
>  
> -static inline void memcg_memory_event(struct mem_cgroup *memcg,
> -				      enum memcg_memory_event event)
> +static inline void __memcg_memory_event(struct mem_cgroup *memcg,
> +					enum memcg_memory_event event,
> +					bool allow_spinning)
>  {
>  	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
>  			  event == MEMCG_SWAP_FAIL;
>  
>  	atomic_long_inc(&memcg->memory_events_local[event]);

Doesn't this involve locking on 32b? I guess we do not care all that
much but we might want to bail out early on those arches for
!allow_spinning

> -	if (!swap_event)
> +	if (!swap_event && allow_spinning)
>  		cgroup_file_notify(&memcg->events_local_file);
>  
>  	do {
>  		atomic_long_inc(&memcg->memory_events[event]);
> -		if (swap_event)
> -			cgroup_file_notify(&memcg->swap_events_file);
> -		else
> -			cgroup_file_notify(&memcg->events_file);
> +		if (allow_spinning) {
> +			if (swap_event)
> +				cgroup_file_notify(&memcg->swap_events_file);
> +			else
> +				cgroup_file_notify(&memcg->events_file);
> +		}
>  
>  		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  			break;
> @@ -1018,6 +1021,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
>  		 !mem_cgroup_is_root(memcg));
>  }
>  
> +static inline void memcg_memory_event(struct mem_cgroup *memcg,
> +				      enum memcg_memory_event event)
> +{
> +	__memcg_memory_event(memcg, event, true);
> +}
> +
>  static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  					 enum memcg_memory_event event)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 257d2c76b730..dd5cd9d352f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2306,12 +2306,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	bool drained = false;
>  	bool raised_max_event = false;
>  	unsigned long pflags;
> +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
>  
>  retry:
>  	if (consume_stock(memcg, nr_pages))
>  		return 0;
>  
> -	if (!gfpflags_allow_spinning(gfp_mask))
> +	if (!allow_spinning)
>  		/* Avoid the refill and flush of the older stock */
>  		batch = nr_pages;
>  
> @@ -2347,7 +2348,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (!gfpflags_allow_blocking(gfp_mask))
>  		goto nomem;
>  
> -	memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
>  	raised_max_event = true;
>  
>  	psi_memstall_enter(&pflags);
> @@ -2414,7 +2415,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * a MEMCG_MAX event.
>  	 */
>  	if (!raised_max_event)
> -		memcg_memory_event(mem_over_limit, MEMCG_MAX);
> +		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
>  
>  	/*
>  	 * The allocation either can't fail or will lead to more memory
> -- 
> 2.47.3
> 

-- 
Michal Hocko
SUSE Labs

