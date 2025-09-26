Return-Path: <linux-kernel+bounces-834535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FABA4E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9363B813B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9E3090EC;
	Fri, 26 Sep 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo5EyZTC"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80922D7B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911083; cv=none; b=KFMyB4kfkp6t9KfU7mrBYZ9zQ+ca/R5uj/C+rpFx6b2BNsg91SUIoocGTAFhuD2Bkr/oI3WXqon/VX4iRK5o9rwsjY6xjL1pLXH5bJcq5WjAsMsr94uGfC2vj2MNm2Y39ZGSgI+R/fvzpAlaB1ZhPDjsdNWXeMlEgKGT7R5Y174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911083; c=relaxed/simple;
	bh=4CWMS48jRBHxEKjXVkSoFOnWY8CUaD4FD65BhHNyJ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNr1SH547iXwEP015mitemebQPsgaKEnooQqLR6oYSVTfaJbfrP+SOV0w8KGufEvpFOx0FrcSNPkpgW+ipevajreUQFdB4zFWZEgIXIVGerVzpCF5E7LsROIrPePo+IuXc++JNeMVBdhkS+CcefAPhcZsU39zqbi2oW4dcVk2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo5EyZTC; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d5fb5e34cso33552447b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758911080; x=1759515880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgMaTmzAW2IsbHkewTLtsw0ymxufZZwBMtrCMFxVR/M=;
        b=jo5EyZTC6+aHuCBfRpTCwUt40+p3MnABoQWnkMwatdQc6GryDzkV+meet73dZU5nO6
         vTIDJF3FsvoWYhVxPi0AeQugmAmMHT/k8IaSmm8lZI3IezWT0U8SPlRiHcmkXJ+X5fj4
         Z2583aHgm46voPKWEBKeIS922KVhzKaaxte99iCxcqbO4JyL6s/xdodM78D/q/oRIAj6
         RbTFoPR6ouA27+PpvIbbjZw+m6wVDL+eY56sByrZnoH0Q42o7PELyqn/vVx8L6w/mu8H
         krOzH3qiPg+en0cmWCtSBkcJSTw1O8hTbSgr2a0BEPAoJtGgpX7hjHA5BBSucuE4OX+T
         0nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758911080; x=1759515880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgMaTmzAW2IsbHkewTLtsw0ymxufZZwBMtrCMFxVR/M=;
        b=Is3oZTOoFFhaHep3oRT/yMfzdDiVv0uffUkCQrdqvG8UepCIjv6eP8i79yM0qGMOuZ
         cB2zzxFMnZGc+Ev+DlAeDXnCYjRvf63wnrXCWotTWWso/FoVLooOGTlXt2KrlF5Wo7Ab
         A0Us0JemJzd2jNNeSHWGpRjYtr2TBBrUPh126LBmR3QPvzHNcii1863QhuqbxBI+/+eS
         2VAAR/9A7psfZs34AszKjWByJSQxmiyvpkbv4xnMG7hgPQL9mq/cTEDRkGLGZYv6fZq1
         vtzOQF5iZ1P4cu6byUhr1fVXSgUr5EUjYyRAFae78HvdI6ovrvyw+DbZVwTWxAQIZICa
         jiwg==
X-Forwarded-Encrypted: i=1; AJvYcCW8BXQHVgn8PvvLKZMpxlE8FUHyRirRBIrCs3sJ2ktoEBYFdG9pm4oJGy5WI82gnEohnAbE3XtQcTo+IVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAIyuhWxgxieOARLBWjb3VL30nRE53HbwuPPKgjbZBzp8dSnA
	5WrLe7x6OHTJgQxkvtr+pYVyHBENcz+ZK0+3gWUFHbjfERtGQi6KFlFa
X-Gm-Gg: ASbGncvVki7eE1o0vzeGKEjJ7XsN9gURZPUPN5Y6VjUA+PAcshCZKB4CpNRZ5Atxbrt
	j4NxYy+NAm/1MpSeYh3BUCi3b8HF9ZBPyUhX3Zhw0t3LFgjO3QCEmbh9NAUVvyOIa0ZlVAAirf+
	D+qjuLGoLLNI5dkdO013kius21lbwnuXvBYGL7irmC/sUu0njxULQIq1AAVZWA5as+3V4BDGFNN
	qri7mZxEPYaaqzmOl3S4Wk+xKrWLvoP6AEPovILSOh3xaCsmh84pYkrAAK3+M1sIA7blx+LCQiS
	bVTDNFE3hrN72t8D9HWHJqUMtRqp0WBaQPA/hN0LJQT13SV9MWsytM0QAbAeGjYM+l/cub+YkmS
	TsAgC/jn9tGn8p6nXrfMbpJvZfREY/20WBEe6sz9VUFTyi/eZvvTDsv50O6wyPCDK
X-Google-Smtp-Source: AGHT+IEFGcClrlUqJB+X7Lplug9ocElXcU3pHZrLwxFTnZfCeSZz3sfK4XzJe6Ni77BoZ8MwB3ILxg==
X-Received: by 2002:a05:690c:a083:10b0:75e:28f2:15f0 with SMTP id 00721157ae682-772213722b8mr5553137b3.6.1758911080241;
        Fri, 26 Sep 2025 11:24:40 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c60b7a4esm12518807b3.40.2025.09.26.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:24:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Date: Fri, 26 Sep 2025 11:24:37 -0700
Message-ID: <20250926182438.3108364-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926175004.54610-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ, thank you for reviewing my patch!

> >  void page_alloc_init_cpuhp(void);
> > -int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
> > +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
> >  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
> >  void drain_all_pages(struct zone *zone);
> >  void drain_local_pages(struct zone *zone);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d1d037f97c5f..77e7d9a5f149 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2561,10 +2561,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
> >   * Called from the vmstat counter updater to decay the PCP high.
> >   * Return whether there are addition works to do.
> >   */
> > -int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
> > +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
> >  {
> >  	int high_min, to_drain, batch;
> > -	int todo = 0;
> > +	bool todo;
> 
> I know you and others already found 'todo' should be initialized. :)

Yes, I'll be sure to fix this in the next version! : -)

> [...]
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 71cd1ceba191..1f74a3517ab2 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> [...]
> > @@ -839,7 +839,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
> >  		if (do_pagesets) {
> >  			cond_resched();
> >  
> > -			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
> > +			changed |= decay_pcp_high(zone, this_cpu_ptr(pcp));
> 
> I'm not a fan of bit operations unless it provides clear benefits.
> What about below?
> 
>     if (decay_pcp_high(zone, this_cpu_ptr(pcp)) && !changed)
>     	changed = truee;

Here, what if I change it to just:

	if (decay_pcp_high(zone, this_cpu_ptr(pcp))
		changed = true;

Since even if changed == true already, this will be a no-op.

> Just a personal and trivial taste.  No strong opinion.  If you don't strongly
> feel my suggestion is better, please keep the original code.

I feel like if someone (you) feels like bitwise operations here makes it
less clear what the code is doing, others may feel the same way as well!
Happy to make the change to hopefully make it more easily understandable
what is happening. 

> >  #ifdef CONFIG_NUMA
> >  			/*
> >  			 * Deal with draining the remote pageset of this
> > @@ -861,13 +861,13 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
> >  			}
> >  
> >  			if (__this_cpu_dec_return(pcp->expire)) {
> > -				changes++;
> > +				changed = true;
> >  				continue;
> >  			}
> >  
> >  			if (__this_cpu_read(pcp->count)) {
> >  				drain_zone_pages(zone, this_cpu_ptr(pcp));
> > -				changes++;
> > +				changed = true;
> >  			}
> >  #endif
> >  		}
> > @@ -887,8 +887,8 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
> >  		}
> >  	}
> >  
> > -	changes += fold_diff(global_zone_diff, global_node_diff);
> > -	return changes;
> > +	changed |= fold_diff(global_zone_diff, global_node_diff);
> > +	return changed;
> 
> Ditto.

Will make the same change here!

> >  }
> >  
> >  /*
> > -- 
> > 2.47.3
> 
> Other than the above trivial things, all looks good to me :)

Thanks SJ, I hope you have a great day!
Joshua

> Thanks,
> SJ

