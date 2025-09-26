Return-Path: <linux-kernel+bounces-833470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C158ABA20D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78886560A77
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACD72626;
	Fri, 26 Sep 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH9s3eJ8"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046C2B2DA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846348; cv=none; b=qwaA9tcbyWucCCBSnAk/aj1NwEiHahAHtWgi6XKnv9Kqjdb3zS9VXqSgiRfwm7T3TBODUgt3+P8j9P9OlDjZz3GpkuAW3a+LoGXztfM6Nr/YCGB1MO+1VM0MEG/jEGr3+bBblOPjfWU/WeaiDzcQQdbzAD/gPxxfHUbMmAUK1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846348; c=relaxed/simple;
	bh=1uA3yEOBufbrVgvLobLg87q0BEPdhVFbgKjqu7vMoiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P62RI0vy7DdXDnpSwjHns62vR9yGWmzwOX8imi0nb9tw36t3iBNow7NMupqeLdx8BaCivzVM7RlMprrTtY7ggFjf59CPrNWy1opqDg0aWsrbLvedX6802NDJfH0K+ROksJkb5QQRY5eYOeXxuJjTMB7PHnOdCVo+4nlbgPGCQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH9s3eJ8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3727611c1bso151673966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846345; x=1759451145; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMC81w+JaNK7q2bunYAj8hHN6HLRojIWD4Z/O2pUXCA=;
        b=KH9s3eJ8ngSnFZyMtS/+GtDeLGLwwF8msuuXbtfZkTvcN1u6BjCsh4mR/JlgG+Ygxb
         o2lTeffPgrH/w35PoBTEsPOH/Fssb3jZ9AIOPR51pEY8+6cJVBWgAYrMpXC+HUmdE6YD
         0DBjOQkiXgp1jAzL0TvmKJswFxhaAknFQb3y4U7baoR7u/bj6erhDaUoPLZsQBX/jJjE
         7gKXEyEzyu2RZkK3wiY6eLSKkjr+d4o99wFOGcPaSzNdqqDAN7CtZwqPN4LjUtKJkZJ8
         2sJT6F+jX/vOlSwGwLFdAIBMnKZvx8aBH5X0OdDOwrtEYDQAsk1B62Jbja/GQMq1x1Fr
         ovcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846345; x=1759451145;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMC81w+JaNK7q2bunYAj8hHN6HLRojIWD4Z/O2pUXCA=;
        b=BfdwjexniYPl3jSi+emiVdFEuwXQpYvVbOoW0Qv5l/kR3syfV/FrK0pkDIi4BWKIZe
         AyVNgz5DpiTJFrFxYlYNg8VvZZMY0zAXm4+CszbyvRoITEcnAtB3WmqdJ+vhGPMN3LO3
         KV2vRp7GbNQQaVHf1+Fs5lUpw3bNU3gaRv92hYC6PDI5GKCt5eNpz8fvRQEN4KEDY4Dm
         5as3wd7rSB0uHpurD7cPjL88rk8LvFNQuUxjFVGnHgFwNvq/H7wPV34RCF3+MzLoQ/zQ
         wz7wF8Fgc/4Gw/4EvKrpxRipRR/RQ/AsYgw21cJ/smLJIAV1CpKMPGvcu6qNlpcXXqyK
         w0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWUtwL4o6AsFcxfFN+O+QFtutItnnWAyC5k2FlYW7LspMxKkS62XI2kbB8d5VPdIL2Emyu8CfrxKFzfZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vuC8b2bB3eJga4hY98CY3XFVq+Fyzi4LJ6WYED8bWjbOkvEG
	3VyjWZfUlXW/Lu84zH+dDPTkFFGivEJfH5ZxcFDfclBXRhvQGFJMegHo
X-Gm-Gg: ASbGncsm5BgTGI5SsXtT6iyooKAvZepPk9ztAE65MkAwem5bm0sYNGopHCFKnXYui36
	fQ3mJeb7/+k/ZdYcx8cwSiOIebztuemNeX48ntyH+H6mieSi0yU7PcPDFDVvCB0gzSL2XpuJUxc
	RHx216syZAQw1CMCTVEUd475/TdSBGzUcJjBOi0iyP8K14EeiOqeZYLNXfGgtwy3WafVrptm0L3
	1pYk5AZ0zp0JlWL0a8TAILJNVsz/Cyy+j5/50SiiLY3GkTZ/U5ZSt6qrFvTKbiENitRZynuJldA
	dx7+Rlf/5fm/fGEtJOSXqJKG4l/1lTpNsFgICiPCn9DhOzkeIMQ/2KWhPNxJNbLNte7vFmKQh6J
	AJSlXIznJ3q8oz5fsEM9l89y1TQqPaKifFAKP
X-Google-Smtp-Source: AGHT+IFrncgRgp1cO6kD9iqXJ1acMD+hFDb5TMf4B2VASiURfzNNm3MkxN444XZaQPI6JQA/i5XruA==
X-Received: by 2002:a17:907:7e88:b0:b0f:a22a:4c3c with SMTP id a640c23a62f3a-b34bb41ad93mr619135966b.48.1758846344556;
        Thu, 25 Sep 2025 17:25:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d2ddfsm260259566b.14.2025.09.25.17.25.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Sep 2025 17:25:44 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:25:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Alexander Potapenko <glider@google.com>,
	akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
	dvyukov@google.com, kasan-dev@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with
 KMSAN
Message-ID: <20250926002543.fwkf5qldhkapcmqr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250924100301.1558645-1-glider@google.com>
 <20250925123759.59479-1-sj@kernel.org>
 <aNVWzaxq82UI3wWO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNVWzaxq82UI3wWO@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Sep 25, 2025 at 05:50:53PM +0300, Mike Rapoport wrote:
>On Thu, Sep 25, 2025 at 05:37:59AM -0700, SeongJae Park wrote:
>> Hello,
>> 
>> On Wed, 24 Sep 2025 12:03:01 +0200 Alexander Potapenko <glider@google.com> wrote:
>> 
>> > When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
>> > for metadata instead of returning them to the early allocator. The callers,
>> > however, would unconditionally increment `totalram_pages`, assuming the
>> > pages were always freed. This resulted in an incorrect calculation of the
>> > total available RAM, causing the kernel to believe it had more memory than
>> > it actually did.
>> > 
>> > This patch refactors `memblock_free_pages()` to return the number of pages
>> > it successfully frees. If KMSAN stashes the pages, the function now
>> > returns 0; otherwise, it returns the number of pages in the block.
>> > 
>> > The callers in `memblock.c` have been updated to use this return value,
>> > ensuring that `totalram_pages` is incremented only by the number of pages
>> > actually returned to the allocator. This corrects the total RAM accounting
>> > when KMSAN is active.
>> > 
>> > Cc: Aleksandr Nogikh <nogikh@google.com>
>> > Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
>> > Signed-off-by: Alexander Potapenko <glider@google.com>
>> > Reviewed-by: David Hildenbrand <david@redhat.com>
>> [...]
>> > --- a/mm/mm_init.c
>> > +++ b/mm/mm_init.c
>> > @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *tablename,
>> >  	return table;
>> >  }
>> >  
>> > -void __init memblock_free_pages(struct page *page, unsigned long pfn,
>> > -							unsigned int order)
>> > +unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
>> > +					 unsigned int order)
>> >  {
>> >  	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
>> >  		int nid = early_pfn_to_nid(pfn);
>> >  
>> >  		if (!early_page_initialised(pfn, nid))
>> > -			return;
>> > +			return 0;
>> >  	}
>> 
>> I found this patch on mm-new tree is making my test machine (QEMU) reports much
>> less MemTotal even though KMSAN is disabled.  And modifying the above part to
>> be considered as free success (returning '1UL << order') fixed my issue.
>> Because the commit message says the purpose of this change is only for
>> KMSAN-stashed memory, maybe the above behavior change is not really intended?
>> 
>> I'm not familiar with this code so I'm unsure if the workaround is the right
>> fix.  But since I have no time to look this in deep for now, reporting first
>
>With DEFERRED_STRUCT_PAGE_INIT we count totalram_pages in
>memblock_free_all() but actually free them in deferred_init_memmap() and
>deferred_grow_zone().
>
>So returning '1UL << order' is a correct workaround, but the proper fix
>should update totalram_pages in the deferred path IMHO.
>

Maybe I did something similar at [1].

But this hit a problem for shmem, since shmem_fill_super() use
totalram_pages(). And before DEFERRED_STRUCT_PAGE_INIT finish, the size is too
small, so it can't boot up.

Per my understanding, shmem_fill_super() could be invoked after
memblock_discard(), so it is not proper to refactor to get ram size from
memblock.

Could we adjust shmem_default_max_blocks/shmem_default_max_inodes use memblock
at boot stage and use totalram_pages() after system is fully up? Or any other
suggestions?

[1]: http://lkml.kernel.org/r/20240726003612.5578-1-richard.weiyang@gmail.com

>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

