Return-Path: <linux-kernel+bounces-790448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6CB3A74D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6C33B3DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019193314DE;
	Thu, 28 Aug 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSjdJZCm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D61624D5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400725; cv=none; b=L9CUbOOUG54bzvizNRcd+6dGLlh6jxhmSmnVb0lFplDlnri4CBggDJ1JE3+bNsKkQMlw+8Ew8QeEJDUuj7qw8oUKCjE1xefmuxq4i4wTApH4cCjcz1aDMDtgYGQifSIZOSJUfBZ/iXdYtgqKKcP3irCFY9HWbTVnL2GytuUVZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400725; c=relaxed/simple;
	bh=WRSwlhIChhiVx7HcrqYUou7g6PyUaCkFSxYirK7DIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnKwYlNyNlKHGRKyhuEXo480070qFu9oZh19yJYIvWOEqPBccL5yaU3wE6n+c2gJBK8zMemmeyD+YQLIpafAby5q266yA5oiBVm4+PLLxyxeSexOAgJvBdpbUTVFYhq1JGjdrkLWoNYuKJD8haz6GJJtCXHlQEFEJdt7R1L6zXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSjdJZCm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24884d9e54bso11668435ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756400723; x=1757005523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaKngwQqagIZTuDtH8xBI75d9Ygzs4ncLlpZaeJH/So=;
        b=CSjdJZCmapkJ9o8ZZQpFnn7jRCbFY0h9xLhwuG0/8ew5XkL0pWEkM8Na/CibCOtYhT
         JK2x2khw86A+Tsycs+W41r6oci5G/CjqMLVd+9nXG1EtEyMmVosokF/RSyuY9OTFukLb
         qs+a86k+nvEXDUok17s+kYjOqvIr/cjT7TIo0cp5XppcldT16xj+zoT5h1gItx2a/fPI
         D5AJPniukLSPGu4XSUhdHj72ceKW9Is7pcBpVz/QzAPdzGf0E/aRPjUCGi6d28TzSLZN
         /BW9+jpFabyAiieLaQpUlJw/6wFVsnXMaweGAIydyVYUXdF1+J5lF5JrE3Qy/OVQ4QLZ
         uT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400723; x=1757005523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaKngwQqagIZTuDtH8xBI75d9Ygzs4ncLlpZaeJH/So=;
        b=OtUHBfkRlxJcqO8MDDXrEFF4HumLrwPq/CwaMTkutLy2IZmi2wirpH1IGDE2uVrSh7
         Z8SMNUfYg/TzvkI2P76SemCVAZq0VlUQjAY3Xoi0Sopp/T/PqQKdgAHN+JmQ+7YZRQhE
         TQ7ki4ZI8AuX91SUkTM1YedWFE3UPaVlR55xyRCD0BSZQTqoXbgElmeWxFbvNGmHj0Yp
         y654ll1W+ydzNhgETnLXGFApbCcyRGL7pcVvRSicBtXxHwY87/VOJRCgkkU0m2OTwCsf
         o3S92ByYb6KygOimpjktPenkIH/zrWWVObZa9gaanH6dFlOGNGH9ydnmWeSXkt5KErKe
         rmaA==
X-Forwarded-Encrypted: i=1; AJvYcCU6YsV0rUjo381bbUVtEIHDuUcnLGRFO9hXw3g16mYNGx1WYgk/SKdBu4nOkXAW2hPNn+hBdINuKh15ktk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMZBIW8DNwMvo5U2Wzk8DST4mJXoEPCYcG2jeEwW9cgFYZf8U
	smFwBQEFBhoVhTPv08NHZDG7lLtfMmTIRXsZJnNMJKvysDBIEDEAJEVp
X-Gm-Gg: ASbGnct9Gn9KznaaEOTMnr5b36OMASR7Ioxn8QChf0sOo44Hh6Yqn0bCO2ROzXPlFOZ
	1bNdmJ3/hPTA/oE/KImR/KqwW1ndf4ZNbQhRsiz7KBxtygkyI5HFCOq6SvskyRnw+FFsVp81QU3
	ZsbdNlDMxell89C9JRLLuk3E3svNxGIOdWuraK0J3+fV8xLOQaxK5z6pm6Ca2AM14MdUacKMtHY
	gp5aJ7LAVRsfF90YNw1TMrxuTrLC7//bS28GlIddrttP7Hs2s6bj1gKrwPaqR208HyiLn5Fc0Sj
	n8zwPS6K0OBIeNI19BZDgZyV+mjAKuEyZzY7L/eJQ8aFbvd/BCpw8xXUmmkvCqffpHKeeZoLNm6
	oUmc7L3HpXDmhylmXSiu20mwR3WcTTiv4VIav+hNHYgA2MIIO/wYoFA==
X-Google-Smtp-Source: AGHT+IEDGdjnSAyHBeE9MTUce7G4V5CtnVHQ5MuvcLxNqHjArd56/Drml7Qh+LbolqzPL9NaeoaQHg==
X-Received: by 2002:a17:902:da89:b0:248:cd4d:a72b with SMTP id d9443c01a7336-248cd4da80cmr60475305ad.20.1756400722854;
        Thu, 28 Aug 2025 10:05:22 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e042asm441305ad.146.2025.08.28.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:05:22 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:05:18 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mm/show_mem: Bug fix for print mem alloc info
Message-ID: <aLCMTu-Ci2yV40zn@fedora>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <aK9htWRehfJDLFJD@fedora>
 <aLATVGnVx4Z+aHAh@devbig569.cln6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLATVGnVx4Z+aHAh@devbig569.cln6.facebook.com>

On Thu, Aug 28, 2025 at 01:29:08AM -0700, Yueyang Pan wrote:
> On Wed, Aug 27, 2025 at 12:51:17PM -0700, Vishal Moola (Oracle) wrote:
> > On Wed, Aug 27, 2025 at 11:34:21AM -0700, Yueyang Pan wrote:
> > > This patch set fixes two issues we saw in production rollout. 
> > > 
> > > The first issue is that we saw all zero output of memory allocation 
> > > profiling information from show_mem() if CONFIG_MEM_ALLOC_PROFILING 
> > > is set and sysctl.vm.mem_profiling=0. In this case, the behaviour 
> > > should be the same as when CONFIG_MEM_ALLOC_PROFILING is unset, 
> > 
> > Did you mean to say when sysctl.vm.mem_profiling=never?
> > 
> > My understanding is that setting the sysctl=0 Pauses memory allocation
> > profiling, while 1 Resumes it. When the sysctl=never should be the same
> > as when the config is unset, but I suspect we might still want the info
> > when set to 0.
> 
> Thanks for your feedback Vishal. Here I mean for both =0 and =never. 
> In both cases, now __show_mem() will print all 0s, which both is redundant 
> and also makes differentiate hard. IMO when __show_mem() prints something 
> the output should be useful at least. 

If differentiating between 0 allocations vs disabled is the primary
concern, I think prefacing the dump with the status of the tool is
better than treating =0 and =never as the same.

The way I see it, the {0,1,never} tristate offers a level of versatility
that I'm not sure we need to eliminate.

I'm thinking about cases where we may temporarily set =1 to track some
allocations, then back to =0 'pause' on that exact period of time. Memory
allocation profiling still has those allocations tracked while set to =0
(we can still see them in /proc/allocinfo at least). If a user decided to
do that just before an oom, could they see something useful from
show_mem() even when =0?

> > 
> > > where show_mem prints nothing about the information. This will make 
> > > further parse easier as we don't have to differentiate what a all 
> > > zero line actually means (Does it mean  0 bytes are allocated 
> > > or simply memory allocation profiling is disabled).
> > > 
> > > The second issue is that multiple entities can call show_mem() 
> > > which messed up the allocation info in dmesg. We saw outputs like this:  
> > > ```
> > >     327 MiB    83635 mm/compaction.c:1880 func:compaction_alloc
> > >    48.4 GiB 12684937 mm/memory.c:1061 func:folio_prealloc
> > >    7.48 GiB    10899 mm/huge_memory.c:1159 func:vma_alloc_anon_folio_pmd
> > >     298 MiB    95216 kernel/fork.c:318 func:alloc_thread_stack_node
> > >     250 MiB    63901 mm/zsmalloc.c:987 func:alloc_zspage
> > >     1.42 GiB   372527 mm/memory.c:1063 func:folio_prealloc
> > >     1.17 GiB    95693 mm/slub.c:2424 func:alloc_slab_page
> > >      651 MiB   166732 mm/readahead.c:270 func:page_cache_ra_unbounded
> > >      419 MiB   107261 net/core/page_pool.c:572 func:__page_pool_alloc_pages_slow
> > >      404 MiB   103425 arch/x86/mm/pgtable.c:25 func:pte_alloc_one
> > > ```
> > > The above example is because one kthread invokes show_mem() 
> > > from __alloc_pages_slowpath while kernel itself calls 
> > > oom_kill_process()
> > 
> > I'm not familiar with show_mem(). Could you spell out what's wrong with
> > the output above?
> 
> So here in the normal case, the output should be sorted by size. Here 
> two print happen at the same time so they interleave with each other, 
> making further parse harder (need to sort again and dedup).

Gotcha.

> > 
> > > Yueyang Pan (2):
> > >   mm/show_mem: No print when not mem_alloc_profiling_enabled()
> > >   mm/show_mem: Add trylock while printing alloc info
> > > 
> > >  mm/show_mem.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > -- 
> > > 2.47.3
> > > 
> 
> Thanks,
> Pan

