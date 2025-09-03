Return-Path: <linux-kernel+bounces-798281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F726B41BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F651A87A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313B2E9748;
	Wed,  3 Sep 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asJlr7IJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C342DAFDD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895066; cv=none; b=UVnDst6i5F2Y2qdZHM7fMLFE51/NoUOruVvnNnd10F9Qe6tSCTmSogo1CRhJbredwrM0iRIUKiX0YAsdbbB/ZnMioeGHdCojw+NIDISl8TaQt4SMOPdZGDZhO8eQpW4GwtExb9FGM6PDbH2kS1X+L4zMFdXAOXdSpl3awxOWq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895066; c=relaxed/simple;
	bh=2bsuSPa5RSiA+pJ8tdEfR/bTf9nbuZTAkLBuJJINhj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee/ABuwAi8+C0xT499vWX4lb3rTJTmmw6wCLUQSVpAA6+4y2YMOx/wyaHiS3WXzAWmEwANpgommxB79uNSw3igK7S6URUcUhvTWztInMEeqm8ZTje7ieXuC103ejZH94TnZDBo+J0IwJwkWirpGgP31ZzYqSMJTl5YNqAoTWdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asJlr7IJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so20600485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756895063; x=1757499863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iq+2oZ/KcgO95X7z7Iwm4V3d8FmvBHKC4zBSx2fR9sg=;
        b=asJlr7IJySWGitYhheyGh4FqSH8lbYK+bu5ZYBxbfY6V5fWSdK9VFrESE4OniZE9IN
         dSHbQttqpMBMmKO/rdzhu2QuQ5VWyIL5xHvCRq/wr5rijsJAQ2A23TOHMedQtuopSUS6
         1KPHTvr5p5FBrO95AVe1LmQVsvNamohT5q+mLIe57DHPBZMIT99w95Xqjo4/F9AgbMC9
         qzj4E5SB4CqFKpqho4NCu7ohSP9Z2ao8lqLt1I8jU/iKIPnxjJGiHB5SY+gpqbZ3tAxr
         2B0kSSuIrYHfrYVLQ1rvREFm75y+1GEF8CI6zX+WiIo4KV9lYE3QKkW3rCyqJjiQnJuK
         XhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895063; x=1757499863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq+2oZ/KcgO95X7z7Iwm4V3d8FmvBHKC4zBSx2fR9sg=;
        b=GiYziJqVVbKjwjlqMpbRdfizgIOAnuKSeRSTfecszXQm5s+ZkSXrtDHC/qTepBY2ZN
         iyxICp672hv+KGmQqbnWiWKJrnDJrBLevsNi5cC8ZXtnufEwXFnGrc3Q71UaBpQY1LuK
         1BxcTa2s/7dremWYFnWoaBHWEfdbEx8zjJ4e86p5TewvOVIYgFAnlGjvmXQUOyREovIf
         iQo3IVrH7rEhoecs7O4Ti3jzavZRT2z4OeBoMrBgKQTq4CRrkq9tfftlJfMTiRRgNatX
         rqHmIppKx9Q4xq1/x33wSFZTdiVRWYGRK/xlVC9yFaqqvKhSWMCM0WhfOxRIC4xBOzie
         h4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbTII2SYPNhfh/+6Gd4H7WUP8W3T/5BuWFl09Q7tEAdgwZEQl6NSmLzQD2qKRCJQA1Bet+dG4V7cZPaY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmpbjHEjG6IrRJpVM6aeXMEtXHJWK5tmH4ZyE53DwultmYJiR
	/PsBovqj9IApYhrzs3o97/of5FyyURy/w5nooSn8eZi637WMfkUt8KyZ
X-Gm-Gg: ASbGncsMJxfXfjzsWVzieqWf0E3Y0ZfrV7LsDGDsdYFPBXknhbCOE1t1jcv6MLer/fd
	8rQd8XtkoSIAv6PWk4CEWgvtCwJU6//JeLWxLkYcDToq11T/MNa2D5K/a8D5BaC3+quPsz+Wq4o
	h77JmCwZX5TxwNpwIrSkEuPAQPvBYof4UiFtKi0xjAYM6YSBfsBkSNylRLDd+l4tvvzGXBwkY1+
	NVLs7Ml1VikrCveaVuM/VnnYFUMu/dqXgg5i3my1VbAJZlWi0HBp6yLxGA3ZghHvicAj1aA+bSD
	UVJXhTW15vJx27ObbVvqQ8e0fJzcHwjcSsNOXqwNscZsuvOh7qTQSbtCV3KrSpseTH7IpK62peY
	huIKDsauCWDzoZ+L0k+z8XLzEwYJFVaEHfPjNuUb1VKqIaeJZ7Q==
X-Google-Smtp-Source: AGHT+IHjlg0yHyZ7YsY89pq9m16v4pKhC6s3zw1wicDWknab221B4wj1sid8VcPOZQd1k2UL+vWaMw==
X-Received: by 2002:a05:600c:c8a:b0:45b:9afe:ad48 with SMTP id 5b1f17b1804b1-45b9afeaeefmr51851595e9.16.1756895063039;
        Wed, 03 Sep 2025 03:24:23 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:52::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm22895356f8f.61.2025.09.03.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:24:22 -0700 (PDT)
Date: Wed, 3 Sep 2025 03:24:20 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <lkp@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <aLgXVIxyFpvZ9PU7@devbig569.cln6.facebook.com>
References: <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>
 <202509031744.HcibSETe-lkp@intel.com>
 <c41c82f0-e5c3-4c2e-b711-3ddf8fcb0135@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c82f0-e5c3-4c2e-b711-3ddf8fcb0135@suse.cz>

On Wed, Sep 03, 2025 at 12:16:45PM +0200, Vlastimil Babka wrote:
> On 9/3/25 11:47, kernel test robot wrote:
> > Hi Yueyang,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on akpm-mm/mm-everything]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yueyang-Pan/mm-show_mem-Dump-the-status-of-the-mem-alloc-profiling-before-printing/20250903-000616
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason%40gmail.com
> > patch subject: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
> > config: i386-buildonly-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031744.HcibSETe-lkp@intel.com/config)
> > compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031744.HcibSETe-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202509031744.HcibSETe-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from mm/show_mem.c:18:
> >    mm/show_mem.c: In function 'show_free_areas':
> >    mm/show_mem.c:336:49: error: 'NR_ZSPAGES' undeclared (first use in this function); did you mean 'NR_STATS'?
> >      336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
> >          |                                                 ^~~~~~~~~~
> 
> This is from a different patch and being fixed. Interesting that lkp will
> report additional warnings even in presence of prior errors.

Thanks. Understood.

> 
> >    mm/internal.h:560:16: note: in definition of macro 'K'
> >      560 | #define K(x) ((x) << (PAGE_SHIFT-10))
> >          |                ^
> >    include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
> >      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
> >          |                          ^~~~~~~~~~~~~~~~~
> >    mm/show_mem.c:298:17: note: in expansion of macro 'printk'
> >      298 |                 printk(KERN_CONT
> >          |                 ^~~~~~
> >    mm/show_mem.c:336:49: note: each undeclared identifier is reported only once for each function it appears in
> >      336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
> >          |                                                 ^~~~~~~~~~
> >    mm/internal.h:560:16: note: in definition of macro 'K'
> >      560 | #define K(x) ((x) << (PAGE_SHIFT-10))
> >          |                ^
> >    include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
> >      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
> >          |                          ^~~~~~~~~~~~~~~~~
> >    mm/show_mem.c:298:17: note: in expansion of macro 'printk'
> >      298 |                 printk(KERN_CONT
> >          |                 ^~~~~~
> >    In file included from include/linux/spinlock.h:89,
> >                     from include/linux/wait.h:9,
> >                     from include/linux/wait_bit.h:8,
> >                     from include/linux/fs.h:7,
> >                     from include/linux/highmem.h:5,
> >                     from include/linux/bvec.h:10,
> >                     from include/linux/blk_types.h:10,
> >                     from include/linux/blkdev.h:9,
> >                     from mm/show_mem.c:8:
> >    mm/show_mem.c: In function '__show_mem':
> >>> mm/show_mem.c:399:32: warning: unused variable 'mem_alloc_profiling_spinlock' [-Wunused-variable]
> >      399 |         static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
> 
> This is the warning
> 
> I think you can simply move the definition to the existing #ifdef
> CONFIG_MEM_ALLOC_PROFILING block above the spin_trylock(). The kernel now
> uses a new enough C standard to allow this and not only at the beginning of
> a cuntion. While not encouraged to do that in general, this seems to be a
> valid use case.
> 

Let me quickly fix both and push v3

> 
> >          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/spinlock_types.h:43:44: note: in definition of macro 'DEFINE_SPINLOCK'
> >       43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
> >          |                                            ^
> > 
> > 
> > vim +/mem_alloc_profiling_spinlock +399 mm/show_mem.c
> > 
> >    396	
> >    397	void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >    398	{
> >  > 399		static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
> > 
> 

