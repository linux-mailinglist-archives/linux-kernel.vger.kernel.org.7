Return-Path: <linux-kernel+bounces-879959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473BDC247C9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8E3B6530
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CA336ECF;
	Fri, 31 Oct 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IEmiozuQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939582690D9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906955; cv=none; b=iVsN5tTkRUYihtsSTFwBOqJQG4KdevOYFTcTBFM4jcfyP5sQZylQb45Br5PvMH0O0VaQs8JyrLO1DtsCsgvHmAGi8sZNcF3rKx1Z0JgHOU1Z2PV7IXPXg2Hp0pTl1ZIuPRCUOlcLFvddaNibiHyryKiJu5WxxTK6lc2jibZ8d64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906955; c=relaxed/simple;
	bh=1eEt65Ofs+/r5l4cleXlDhf2myoCEBlgqwIcB0WQFuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp8LbSWv0oCS8int2SqfGDbFJyArYR8fST6SCzO1Xn0q3fTiFjt1Q6MJFCKyD6rtjhPsJQx4ZGHbGCOjpxAnZPFnVMAUt+bWSXQnbXFXu6pT4SfMcEPJGXkoRNKT9VA6xQGlYcbmcfilk870L5jZoqyktjOLY8Q7sbescF2qVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IEmiozuQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117f92e32so17777635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761906952; x=1762511752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzZMIk02Nqu6V1427BR/J6vEzSH1QrB2vBKOtaJmgIs=;
        b=IEmiozuQNrOOtEwKzBBIDLeoQ+Mu5wyjQW9isKu/ZfIVyzRFZK+k/4CQDByE5NYXvn
         wTFtdKgODOpwLn9LtxapCh61CyEZtcuv3e2CTNrIbIOKbU9FsmW63Rpz4V5ihUhFxou5
         MO+02xGRIJ/xSnvn3hyxymv3OGYVYaGXNZg/RCoKHwsD3os8xpXrVfMwC21Pbn5W1umF
         hqBYXyJ7TgF12ZZLkLzfaXhzTLqkYHqfV7bM+ZvIljb087mYvQev07SF+g7d0+wgaWRH
         rnMPdU7LwMwbgtEJuc7Iu8YStNKr7pyyrxv9sTzhJhw7L5q5NMaPSsoYhKnEhnbrC1m8
         bEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906952; x=1762511752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzZMIk02Nqu6V1427BR/J6vEzSH1QrB2vBKOtaJmgIs=;
        b=JCnAC8hPxxCvw0Bp/B7NBxK4GAJLWnEGHxEiHcrX0b3nNPhT1R5/xWvZuUdL5eXwhA
         RxWPDEnNN1mDIjYeLvB0CpFrngEsJvlUZAK8H0g1uajKNYK2K3Tg/YUOYg8ROZEnu4n0
         NYisRTUfh3iEiLZ9WxCHd6zlBfb57Qavauyb7r6jsh1Tslpy1UKhxJ3ZDA7sEnctuulL
         nmGfTMGXKaULGfPksYr7OvylnEGkkOpH82DSuKR12Z8NiDZQnju2I/KqhkiRQGHPlkE8
         V5FwBmWVzaTB1dnarASu2CeA0DetSG7deXHN0ncCiqt3H/6gQGO/PdNK73YdNl4sEyWr
         c8WA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+wcNxFjmKtX9vHHaW5Gw+iX/jBVaGQnN0nJNg9v7J2g2yCfgGps70XFPY2+6Q4s72c/3vGanYXqeeSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws61C7Sk5KLHFpUz6eLXcAmRebk3Inj4tfJGRy9BsANbh44fBD
	jHmpXKdG4VVbcmH+IB626YE4wLk/LlmAatTt+2r95GJsqscimAxuO0GFEo1fD8o1f1g=
X-Gm-Gg: ASbGncvn6m9XwgDImQRyYodqi9AlzwRqL/MSGs41miIkxIhjrsWsBcFkYYbStBsQ7/A
	QHZ/FWS2vLXH4AHHa+qqRDxKKx6npGTKt3rTOPtbQQkwnkiw0KJttQkqbU/uLbo0WVHCPu4RR++
	PbuYWmTZKKJEGVWf4dLCLCUROKVytDfpkjtzJEJ7BFX52tE6RQIvVTVWzpD2XH4jiSasVJw72+x
	oewYxNShrVMWhxUyuDA2q/gcHLrEmIooLGVhh7Wp/l75+VgcmXgEFUumlBdfuvdnmsXL0XY6MEH
	WGcyBZQT9l04FyLEMBKOU1p8DLoxvyO8Sm5OXF037Xoc7p4DCuPRpRTdO87fC2k1iaR7PyDUnUh
	C/SvCDeogx8lmGE4dGDmuCnaah//4IMADEZfoWdhkKYCf+hiMmt+F9ekYxnvfRWwsz0DiaEOuvN
	wpKpoFVHSxCjzj5Q==
X-Google-Smtp-Source: AGHT+IG7O9Y6l9WMooa1HgoKgieD6/ZhET+Ll2xATp5EvgMTaFPocp0XktS42l0peKgogXQ+h4nHIw==
X-Received: by 2002:a05:600c:4f0b:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-47730797bbfmr22646085e9.1.1761906951752;
        Fri, 31 Oct 2025 03:35:51 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ddff0csm26082275e9.8.2025.10.31.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:35:51 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:35:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v1 00/26] Eliminate Dying Memory Cgroup
Message-ID: <aQSRBjdhdMR8iD6n@tiehlicka>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <aQHIDWDx3puT5XZd@tiehlicka>
 <8edf2f49-54f6-4604-8d01-42751234bee9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edf2f49-54f6-4604-8d01-42751234bee9@linux.dev>

On Wed 29-10-25 16:05:16, Qi Zheng wrote:
> Hi Michal,
> 
> On 10/29/25 3:53 PM, Michal Hocko wrote:
> > On Tue 28-10-25 21:58:13, Qi Zheng wrote:
> > > From: Qi Zheng <zhengqi.arch@bytedance.com>
> > > 
> > > Hi all,
> > > 
> > > This series aims to eliminate the problem of dying memory cgroup. It completes
> > > the adaptation to the MGLRU scenarios based on the Muchun Song's patchset[1].
> > 
> > I high level summary and main design decisions should be describe in the
> > cover letter.
> 
> Got it. Will add it in the next version.
> 
> I've pasted the contents of Muchun Song's cover letter below:
> 
> ```
> ## Introduction
> 
> This patchset is intended to transfer the LRU pages to the object cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup. A consensus has already been
> reached regarding this approach recently [1].

Could you add those referenced links as well please?

> ## Background
> 
> The issue of a dying memory cgroup refers to a situation where a memory
> cgroup is no longer being used by users, but memory (the metadata
> associated with memory cgroups) remains allocated to it. This situation
> may potentially result in memory leaks or inefficiencies in memory
> reclamation and has persisted as an issue for several years. Any memory
> allocation that endures longer than the lifespan (from the users'
> perspective) of a memory cgroup can lead to the issue of dying memory
> cgroup. We have exerted greater efforts to tackle this problem by
> introducing the infrastructure of object cgroup [2].
> 
> Presently, numerous types of objects (slab objects, non-slab kernel
> allocations, per-CPU objects) are charged to the object cgroup without
> holding a reference to the original memory cgroup. The final allocations
> for LRU pages (anonymous pages and file pages) are charged at allocation
> time and continues to hold a reference to the original memory cgroup
> until reclaimed.
> 
> File pages are more complex than anonymous pages as they can be shared
> among different memory cgroups and may persist beyond the lifespan of
> the memory cgroup. The long-term pinning of file pages to memory cgroups
> is a widespread issue that causes recurring problems in practical
> scenarios [3]. File pages remain unreclaimed for extended periods.
> Additionally, they are accessed by successive instances (second, third,
> fourth, etc.) of the same job, which is restarted into a new cgroup each
> time. As a result, unreclaimable dying memory cgroups accumulate,
> leading to memory wastage and significantly reducing the efficiency
> of page reclamation.

Very useful introduction to the problem. Thanks!

> ## Fundamentals
> 
> A folio will no longer pin its corresponding memory cgroup. It is necessary
> to ensure that the memory cgroup or the lruvec associated with the memory
> cgroup is not released when a user obtains a pointer to the memory cgroup
> or lruvec returned by folio_memcg() or folio_lruvec(). Users are required
> to hold the RCU read lock or acquire a reference to the memory cgroup
> associated with the folio to prevent its release if they are not concerned
> about the binding stability between the folio and its corresponding memory
> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
> desire a stable binding between the folio and its corresponding memory
> cgroup. An approach is needed to ensure the stability of the binding while
> the lruvec lock is held, and to detect the situation of holding the
> incorrect lruvec lock when there is a race condition during memory cgroup
> reparenting. The following four steps are taken to achieve these goals.
> 
> 1. The first step  to be taken is to identify all users of both functions
>    (folio_memcg() and folio_lruvec()) who are not concerned about binding
>    stability and implement appropriate measures (such as holding a RCU read
>    lock or temporarily obtaining a reference to the memory cgroup for a
>    brief period) to prevent the release of the memory cgroup.
> 
> 2. Secondly, the following refactoring of folio_lruvec_lock() demonstrates
>    how to ensure the binding stability from the user's perspective of
>    folio_lruvec().
> 
>    struct lruvec *folio_lruvec_lock(struct folio *folio)
>    {
>            struct lruvec *lruvec;
> 
>            rcu_read_lock();
>    retry:
>            lruvec = folio_lruvec(folio);
>            spin_lock(&lruvec->lru_lock);
>            if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>                    spin_unlock(&lruvec->lru_lock);
>                    goto retry;
>            }
> 
>            return lruvec;
>    }
> 
>    From the perspective of memory cgroup removal, the entire reparenting
>    process (altering the binding relationship between folio and its memory
>    cgroup and moving the LRU lists to its parental memory cgroup) should be
>    carried out under both the lruvec lock of the memory cgroup being removed
>    and the lruvec lock of its parent.
> 
> 3. Thirdly, another lock that requires the same approach is the split-queue
>    lock of THP.
> 
> 4. Finally, transfer the LRU pages to the object cgroup without holding a
>    reference to the original memory cgroup.
> ```
> 
> And the details of the adaptation are below:
> 
> ```
> Similar to traditional LRU folios, in order to solve the dying memcg
> problem, we also need to reparenting MGLRU folios to the parent memcg when
> memcg offline.
> 
> However, there are the following challenges:
> 
> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>    number of generations of the parent and child memcg may be different,
>    so we cannot simply transfer MGLRU folios in the child memcg to the
>    parent memcg as we did for traditional LRU folios.
> 2. The generation information is stored in folio->flags, but we cannot
>    traverse these folios while holding the lru lock, otherwise it may
>    cause softlockup.
> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>    may be updated, but the folio is not immediately moved to the
>    corresponding lru list. Therefore, there may be folios of different
>    generations on an LRU list.
> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>    found based on the generation information in folio->flags, and the
>    corresponding LRU size will be updated. Therefore, we need to update
>    the lru size correctly during reparenting, otherwise the lru size may
>    be updated incorrectly in lru_gen_del_folio().
> 
> Finally, this patch chose a compromise method, which is to splice the lru
> list in the child memcg to the lru list of the same generation in the
> parent memcg during reparenting. And in order to ensure that the parent
> memcg has the same generation, we need to increase the generations in the
> parent memcg to the MAX_NR_GENS before reparenting.
> 
> Of course, the same generation has different meanings in the parent and
> child memcg, this will cause confusion in the hot and cold information of
> folios. But other than that, this method is simple enough, the lru size
> is correct, and there is no need to consider some concurrency issues (such
> as lru_gen_del_folio()).
> ```

Thanks you this is very useful.

A high level overview on how the patch series (of this size) would be
appreaciate as well.
-- 
Michal Hocko
SUSE Labs

