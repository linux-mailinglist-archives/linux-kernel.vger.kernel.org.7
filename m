Return-Path: <linux-kernel+bounces-789532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A1B396F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CED1C2406B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834812BB13;
	Thu, 28 Aug 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsCABFyf"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E41E285A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369754; cv=none; b=S65cz0PWaMDtCTeEhrsjYuQrN+RKwUpHYL+JuypGs1C4Zi7ijB722fIIS50cmkv57TkPJojA4TikF39q028TrUNRxmE+9pyrmbn2mmaodHebSBwfGMLeBkwQZr9VBhugPO0NtLkqIz6H4LBv5ToG+2Yv7TgLiWyPWL7qoag29aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369754; c=relaxed/simple;
	bh=qF4ILSLe5H8Nph+HZGeLigGoeuHqoG3P6JcZrB+3xrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjW1S2t1DfDR2qrZMbbcka9wfB9l7BinagwobtRpAOBu7h2dk0r+ymCaFKUru+eVKt9D+o/qJFUk25Oy+1n0dQG9x9YSuA+ANaQk2G3ggbQNu7Fxnp7OcirwFakvWrQsKTmNzJtZAVaRmoJ36pKGI0ezwufQzQczP9v/hVVsYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsCABFyf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so435827f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369751; x=1756974551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryFoikwhtamjRw1NiA17KwMCvHI+xUzbwz7LQyXdMfk=;
        b=YsCABFyfYhNWWoVetV2Ev+VHY1EsKQwZU0su7oFOKTXd4VtULntgWIeHJmEZdxL+to
         DzKTkMC3wM1koN3ssnrzRLuUfHRe6JTAXhKodz7bn2t4NlOyeh1q15TwO1pk59x4BkcY
         nqSRCjRzdBStlxXwczkS7ZbHwcG/Fr+tBPhBIx0jVUaKvjyjXDq3HiHs71jZcc8aq0f0
         PpNcPcuvKcgVJ3m4hcT8f93k/gbnr/JwEGH87SfI+3gN2kn6ecQnfKA7DngqZkHP95By
         pLbmjtXsWmQYzMdQEkmnNQeFUvefRQz414rJeYeczFW3MSoCCLz/mKQOR3W8jy3nVe/4
         X9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369751; x=1756974551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryFoikwhtamjRw1NiA17KwMCvHI+xUzbwz7LQyXdMfk=;
        b=Wq08pxCxN2vaX1p1+La/hplalUCfllnc8i8WuT2dD6TLraC0V4RPObS5gcuttA/aXV
         mUIrFFAWYT3EEO5w2YghRuvz9W3+X8aO/OToRwvpA8L4NTIq5KqNWjEceV8olaGRwEbI
         E3e6r00nsQLXbpaTQ1fbsj4N17Rzh6SDSTpRmudp2yYFTVEXlKfdUyAJW0ZsSioAiI2u
         rViJngtqcoqmPCIcAKPb3KhuYDII10zpDeMPRb4UeTRpoSeu1n/OO5oPMTvil76eN2U3
         jY1dVgqduivGd3jVmQOZmbUf8x8r5jb9SqSkP+zRZZL5eWHIDCt7BKCCxYMl4LBbjupL
         k09g==
X-Forwarded-Encrypted: i=1; AJvYcCWmaI1yGPFUTO9ZXUHgpfv71zYajuwl1S5CWfHO7DdDuk5/gtj4WH7wLXZttlAFnYbpgJiPO08WU6CujNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8m04JYQ95LP6tockZUGec2NGLjKkuTt7pin8xJqKF6+VR4Owc
	TefMRZwfzy3NBeQFRcOUZIiG3P4YzT5HKMhlnkh8+DWu/XoU3WLEGPty
X-Gm-Gg: ASbGncvUEU+u21X2NXixtIiOYyDaGUAln/AOBwbl1E/2qaU6709NGnjtSVs3pWMpsIF
	+obCj5CMWgFPxCvKwIaw9Ewa3GVQSQMviyHvEbp4w0z2XTCmloWJp11wbQmIawSVWKRE4odPter
	mN3aUJ4JcO31KVO+Mj2nR2ylrxhlqbP3g93S6koJsGpIECVCAHmRXsNrEHiXq5q1okl2Ze+AQ26
	gXxfxkxB2NkyjuTlAYWY8uXLrDUVFz9zOEwUGzLA/bj1nOQgPurwWjbCLZj5RcLTM/hGEL1ilff
	Q4Tl6fMVqJ84WGH9ZgwlUiLvlhhlBnvGTNjcJjV3xynjLlqx6FWWeA9TI+1f9OdDCr9UcR4PsI/
	ZJcPKj65UgpRAoEQn1o6l8vTlEMBKup9SlAkFDcvCPAk2ZK/Ln5cliXu5p3o=
X-Google-Smtp-Source: AGHT+IE0sIvr/Dhg2uhwu5NF3Oz+4LbEkvjZJ4QN1Fgg3xTGv7XSA8AcvCWCc5jJRXG3OPVYl6SreA==
X-Received: by 2002:a05:6000:4023:b0:3cb:3490:6b72 with SMTP id ffacd0b85a97d-3cb34906d34mr8075280f8f.13.1756369751190;
        Thu, 28 Aug 2025 01:29:11 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ce318fc9f4sm1368041f8f.48.2025.08.28.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:29:10 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:29:08 -0700
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
Message-ID: <aLATVGnVx4Z+aHAh@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <aK9htWRehfJDLFJD@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9htWRehfJDLFJD@fedora>

On Wed, Aug 27, 2025 at 12:51:17PM -0700, Vishal Moola (Oracle) wrote:
> On Wed, Aug 27, 2025 at 11:34:21AM -0700, Yueyang Pan wrote:
> > This patch set fixes two issues we saw in production rollout. 
> > 
> > The first issue is that we saw all zero output of memory allocation 
> > profiling information from show_mem() if CONFIG_MEM_ALLOC_PROFILING 
> > is set and sysctl.vm.mem_profiling=0. In this case, the behaviour 
> > should be the same as when CONFIG_MEM_ALLOC_PROFILING is unset, 
> 
> Did you mean to say when sysctl.vm.mem_profiling=never?
> 
> My understanding is that setting the sysctl=0 Pauses memory allocation
> profiling, while 1 Resumes it. When the sysctl=never should be the same
> as when the config is unset, but I suspect we might still want the info
> when set to 0.

Thanks for your feedback Vishal. Here I mean for both =0 and =never. 
In both cases, now __show_mem() will print all 0s, which both is redundant 
and also makes differentiate hard. IMO when __show_mem() prints something 
the output should be useful at least. 

> 
> > where show_mem prints nothing about the information. This will make 
> > further parse easier as we don't have to differentiate what a all 
> > zero line actually means (Does it mean  0 bytes are allocated 
> > or simply memory allocation profiling is disabled).
> > 
> > The second issue is that multiple entities can call show_mem() 
> > which messed up the allocation info in dmesg. We saw outputs like this:  
> > ```
> >     327 MiB    83635 mm/compaction.c:1880 func:compaction_alloc
> >    48.4 GiB 12684937 mm/memory.c:1061 func:folio_prealloc
> >    7.48 GiB    10899 mm/huge_memory.c:1159 func:vma_alloc_anon_folio_pmd
> >     298 MiB    95216 kernel/fork.c:318 func:alloc_thread_stack_node
> >     250 MiB    63901 mm/zsmalloc.c:987 func:alloc_zspage
> >     1.42 GiB   372527 mm/memory.c:1063 func:folio_prealloc
> >     1.17 GiB    95693 mm/slub.c:2424 func:alloc_slab_page
> >      651 MiB   166732 mm/readahead.c:270 func:page_cache_ra_unbounded
> >      419 MiB   107261 net/core/page_pool.c:572 func:__page_pool_alloc_pages_slow
> >      404 MiB   103425 arch/x86/mm/pgtable.c:25 func:pte_alloc_one
> > ```
> > The above example is because one kthread invokes show_mem() 
> > from __alloc_pages_slowpath while kernel itself calls 
> > oom_kill_process()
> 
> I'm not familiar with show_mem(). Could you spell out what's wrong with
> the output above?

So here in the normal case, the output should be sorted by size. Here 
two print happen at the same time so they interleave with each other, 
making further parse harder (need to sort again and dedup).

> 
> > Yueyang Pan (2):
> >   mm/show_mem: No print when not mem_alloc_profiling_enabled()
> >   mm/show_mem: Add trylock while printing alloc info
> > 
> >  mm/show_mem.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.47.3
> > 

Thanks,
Pan

