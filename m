Return-Path: <linux-kernel+bounces-861512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB85BF2EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770843AD685
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD3A2D0C8C;
	Mon, 20 Oct 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDzUyQSW"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559818871F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984616; cv=none; b=Gi6lLykAvbfOt18qtUZvjn9vrSMXMH27bC6k6wCtXwe7qhHslEugiWRxACnRGEm2Nz/3lZe5f9fzZbemsyGnimFDlwJhg0o7emVh2cpY6EgNg8Z40L5+3pKPUL0Yvwy4b1Uy0ftMQgCN+6pcFyb2EahRrhucmfX5mZVknAhOpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984616; c=relaxed/simple;
	bh=vqI0mfscvojXq6/+yfiQwqv8j5NXGQ7XSLGUVFr3aKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9uqgETa4LdpGnlOlmljydyo8mLMAdQEnCYkUwF5pajWnkQucjyksZkxLPOvtudQkl+KM/3xZhJpJ3HK5pAcMGK+0wVhRbTINUEISF8t7rOcv93cHF8m8g6KFarvQ6dhYtjCi3fEBjokVYwqlg73pO6O/3c3BMRnAkz0SVyY78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDzUyQSW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so44216875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984612; x=1761589412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM3lb+nkcJ7701WZ1nCVSRPcoybWb6DxOoNrWe3kEL8=;
        b=BDzUyQSWR00EpHAeg8NG8exFO5ufqkTfo9PnjnrZc6JDXtXEP11X+9txb7/8pHUzeM
         xkZFtWv3nqMECyDBAbDwcnqpuxVm8JHys7fnzo9INoRmK6Df5+VnoqPBkSSOdb+R8Qbq
         fKHwZwpQk7TrdA4SHOYiLUXicAVBzAph3jQZAHJHjv9JvLzJMf8jZ7T7XJZdsulUHRuu
         s6GG3K06NYR6ed7+76Zo45ynVEReKcHNLcf6Tnwd/E7Dd87kQ2Qe3FuomixJA5Rlc09X
         XfMMdyj27OzNybb/eig/MtUk51RDQR72rmJmpl0vfThzwaYP/4hlS+Ze+SMHqh/I38me
         eT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984612; x=1761589412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM3lb+nkcJ7701WZ1nCVSRPcoybWb6DxOoNrWe3kEL8=;
        b=Yo5/hWILPN/LKU1z5JPBVQtPOH5AIzhcVoR1tiBtrsqBnPEA3seRhuXsfJpS4MhlFX
         qRJQw4RXC0H7imKPw7eIx26eg07h6HnW/WjNKvcX2qE6GW9dyXf4TqcCkXJPa2FCJPpQ
         zhqglZ2iGRnwYdrkFQHgBA5vo2oP9dfXrVtWzlcxyixztND/5aTOc+5oVq0ncETvgoi+
         C2f/FXO9WU3pBvSVxbo6z2iZK3xtaFwm53WRCk40tEk22SXEnQrWfSR04Mn+TRdib26+
         JxR3QHudbIiOdXaU2zkVr2sRFVXA0aYBbFgBTowXEeA7JIcDIb6z/EiuhYkf3M6MrHSv
         9mAg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5nFEu6Cz21cAZWYmprzvtVzdksH0773hAyfzMJT3u3bfRWA4Ky9Xr6XuLGdgudehgg7/k/fkpNe2OLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiOeLxcTRzWphmr67C8HkRmpOeTRDImdNDjr5wrnYxdikA6Yl
	koT7cl+YZw1RXb52KMrb9+CJqRpJ6GnoOlNllxbNCGlxNnghZQX+DcmQ
X-Gm-Gg: ASbGncuLxghwK22Kmf89dapp4QSX4UoQLl1Ji6BI45lQEYaZid6q3aB+92ZLbdtisx8
	HerKv/DoVyF6Dz5jZdjfy8to4F33VEwnwe89qYAz9dDPdnDpDZPMQYqcBH3nM/ZmZwWX2OGUN0K
	+1EzcVBAtXZDsAUvfNn5J7e3R2AaaCYRz6Ru1u+olm0kge8a+7jXi47k/HD9yYMFvDI7M+X49iv
	7tSikqK2dgTkTbCkZnhW4PEdFw5PMZnZMs5RxoViAOTboEf3tyus/B0JQLmszn15yK1FKg5AVRf
	PiNJtMcZlhgub/T6lUz7IzEGJGj8yLNnYkzwH+Hc0OIInEmwEkNCjKECxspn4gwooX1CE0BTDZL
	rLCVTKOnC01xf0iUPh8m4LLnWRn8QoQeQM7YojfY2toMwRtssud0umn9N+Klo2OvDd3HrS7ur
X-Google-Smtp-Source: AGHT+IGHUYoXmddIw92+qME6tnuYAuOMrQdL8QRukN+6lCRGWfNdPq95JXiT0QQ5qbS6qIZ64FWm1g==
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-471179123admr101994905e9.21.1760984612069;
        Mon, 20 Oct 2025 11:23:32 -0700 (PDT)
Received: from fedora ([31.205.15.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9853sm16487755f8f.33.2025.10.20.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:23:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:23:29 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPZ-IbX7K8f4Jngp@fedora>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
 <aO9pUS3zLHsap81f@fedora>
 <aPEZdHJlNOofy5tm@milan>
 <aPEubI4kWvzSC5RN@fedora>
 <aPFBY_OtG0YTAaHv@fedora>
 <aPJrmdeQY1QvbVdc@milan>
 <aPJ6lLf24TfW_1n7@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJ6lLf24TfW_1n7@milan>

On Fri, Oct 17, 2025 at 07:19:16PM +0200, Uladzislau Rezki wrote:
> On Fri, Oct 17, 2025 at 06:15:21PM +0200, Uladzislau Rezki wrote:
> > On Thu, Oct 16, 2025 at 12:02:59PM -0700, Vishal Moola (Oracle) wrote:
> > > On Thu, Oct 16, 2025 at 10:42:04AM -0700, Vishal Moola (Oracle) wrote:
> > > > On Thu, Oct 16, 2025 at 06:12:36PM +0200, Uladzislau Rezki wrote:
> > > > > On Wed, Oct 15, 2025 at 02:28:49AM -0700, Vishal Moola (Oracle) wrote:
> > > > > > On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> > > > > > > On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > > > > > > > Running 1000 iterations of allocations on a small 4GB system finds:
> > > > > > > > 
> > > > > > > > 1000 2mb allocations:
> > > > > > > > 	[Baseline]			[This patch]
> > > > > > > > 	real    46.310s			real    34.380s
> > > > > > > > 	user    0.001s			user    0.008s
> > > > > > > > 	sys     46.058s			sys     34.152s
> > > > > > > > 
> > > > > > > > 10000 200kb allocations:
> > > > > > > > 	[Baseline]			[This patch]
> > > > > > > > 	real    56.104s			real    43.946s
> > > > > > > > 	user    0.001s			user    0.003s
> > > > > > > > 	sys     55.375s			sys     43.259s
> > > > > > > > 
> > > > > > > > 10000 20kb allocations:
> > > > > > > > 	[Baseline]			[This patch]
> > > > > > > > 	real    0m8.438s		real    0m9.160s
> > > > > > > > 	user    0m0.001s		user    0m0.002s
> > > > > > > > 	sys     0m7.936s		sys     0m8.671s
> > > > > > > 
> > > > > > > I'd be more confident in the 20kB numbers if you'd done 10x more
> > > > > > > iterations.
> > > > > > 
> > > > > > I actually ran my a number of times to mitigate the effects of possibly
> > > > > > too small sample sizes, so I do have that number for you too:
> > > > > > 
> > > > > > [Baseline]			[This patch]
> > > > > > real    1m28.119s		real    1m32.630s
> > > > > > user    0m0.012s		user    0m0.011s
> > > > > > sys     1m23.270s		sys     1m28.529s
> > > > > > 
> > > > > I have just had a look at performance figures of this patch. The test
> > > > > case is 16K allocation by one single thread, 1 000 000 loops, 10 run:
> > > > > 
> > > > > sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=4
> > > > 
> > > > The reason I didn't use this test module is the same concern Matthew
> > > > brought up earlier about testing the PCP list rather than buddy
> > > > allocator. The test module allocates, then frees over and over again,
> > > > making it incredibly prone to reuse the pages over and over again.
> > > > 
> > > > > BOX: AMD Milan, 256 CPUs, 512GB of memory
> > > > > 
> > > > > # default 16K alloc
> > > > > [   15.823704] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955334 usec
> > > > > [   17.751685] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1158739 usec
> > > > > [   19.443759] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1016522 usec
> > > > > [   21.035701] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 911381 usec
> > > > > [   22.727688] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 987286 usec
> > > > > [   24.199694] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955112 usec
> > > > > [   25.755675] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 926393 usec
> > > > > [   27.355670] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 937875 usec
> > > > > [   28.979671] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1006985 usec
> > > > > [   30.531674] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 941088 usec
> > > > > 
> > > > > # the patch 16K alloc
> > > > > [   44.343380] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2296849 usec
> > > > > [   47.171290] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2014678 usec
> > > > > [   50.007258] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2094184 usec
> > > > > [   52.651141] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1953046 usec
> > > > > [   55.455089] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2209423 usec
> > > > > [   57.943153] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1941747 usec
> > > > > [   60.799043] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2038504 usec
> > > > > [   63.299007] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1788588 usec
> > > > > [   65.843011] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2137055 usec
> > > > > [   68.647031] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2193022 usec
> > > > > 
> > > > > 2X slower.
> > > > > 
> > > > > perf-cycles, same test but on 64 CPUs:
> > > > > 
> > > > > +   97.02%     0.13%  [test_vmalloc]    [k] fix_size_alloc_test
> > > > > -   82.11%    82.10%  [kernel]          [k] native_queued_spin_lock_slowpath
> > > > >      26.19% ret_from_fork_asm
> > > > >         ret_from_fork
> > > > >       - kthread
> > > > >          - 25.96% test_func
> > > > >             - fix_size_alloc_test
> > > > >                - 23.49% __vmalloc_node_noprof
> > > > >                   - __vmalloc_node_range_noprof
> > > > >                      - 54.70% alloc_pages_noprof
> > > > >                           alloc_pages_mpol
> > > > >                           __alloc_frozen_pages_noprof
> > > > >                           get_page_from_freelist
> > > > >                           __rmqueue_pcplist
> > > > >                      - 5.58% __get_vm_area_node
> > > > >                           alloc_vmap_area
> > > > >                - 20.54% vfree.part.0
> > > > >                   - 20.43% __free_frozen_pages
> > > > >                        free_frozen_page_commit
> > > > >                        free_pcppages_bulk
> > > > >                        _raw_spin_lock_irqsave
> > > > >                        native_queued_spin_lock_slowpath
> > > > >          - 0.77% worker_thread
> > > > >             - process_one_work
> > > > >                - 0.76% vmstat_update
> > > > >                     refresh_cpu_vm_stats
> > > > >                     decay_pcp_high
> > > > >                     free_pcppages_bulk
> > > > >                     _raw_spin_lock_irqsave
> > > > >                     native_queued_spin_lock_slowpath
> > > > > +   76.57%     0.16%  [kernel]          [k] _raw_spin_lock_irqsave
> > > > > +   71.62%     0.00%  [kernel]          [k] __vmalloc_node_noprof
> > > > > +   71.61%     0.58%  [kernel]          [k] __vmalloc_node_range_noprof
> > > > > +   62.35%     0.06%  [kernel]          [k] alloc_pages_mpol
> > > > > +   62.27%     0.17%  [kernel]          [k] __alloc_frozen_pages_noprof
> > > > > +   62.20%     0.02%  [kernel]          [k] alloc_pages_noprof
> > > > > +   62.10%     0.05%  [kernel]          [k] get_page_from_freelist
> > > > > +   55.63%     0.19%  [kernel]          [k] __rmqueue_pcplist
> > > > > +   32.11%     0.00%  [kernel]          [k] ret_from_fork_asm
> > > > > +   32.11%     0.00%  [kernel]          [k] ret_from_fork
> > > > > +   32.11%     0.00%  [kernel]          [k] kthread
> > > > > 
> > > > > I would say the bottle-neck is a page-allocator. It seems high-order
> > > > > allocations are not good for it.
> > > 
> > > Ah also just took a closer look at this. I realize that you also did 16k
> > > allocations (which is at most order-2), so it may not be a good
> > > representation of high-order allocations either.
> > > 
> > I agree. But then we should not optimize "small" orders and focus on
> > highest ones. Because of double degrade. I assume stress-ng fork test
> > would alos notice this.
> > 
> > > Plus that falls into the regression range I found that I detailed in
> > > response to Matthew elsewhere (I've copy pasted it here for reference)
> > > 
> > >   I ended up finding that allocating sizes <=20k had noticeable
> > >   regressions, while [20k, 90k] was approximately the same, and >= 90k had
> > >   improvements (getting more and more noticeable as size grows in
> > >   magnitude).
> > > 
> > Yes, i did 2-order allocations 
> > 
> > # default
> > +   35.87%     4.24%  [kernel]            [k] alloc_pages_bulk_noprof
> > +   31.94%     0.88%  [kernel]            [k] vfree.part.0
> > -   27.38%    27.36%  [kernel]            [k] clear_page_rep
> >      27.36% ret_from_fork_asm
> >         ret_from_fork
> >         kthread
> >         test_func
> >         fix_size_alloc_test
> >         __vmalloc_node_noprof
> >         __vmalloc_node_range_noprof
> >         alloc_pages_bulk_noprof
> >         clear_page_rep
> > 
> > # patch
> > +   53.32%     1.12%  [kernel]        [k] get_page_from_freelist
> > +   49.41%     0.71%  [kernel]        [k] prep_new_page
> > -   48.70%    48.64%  [kernel]        [k] clear_page_rep
> >      48.64% ret_from_fork_asm
> >         ret_from_fork
> >         kthread
> >         test_func
> >         fix_size_alloc_test
> >         __vmalloc_node_noprof
> >         __vmalloc_node_range_noprof
> >         alloc_pages_noprof
> >         alloc_pages_mpol
> >         __alloc_frozen_pages_noprof
> >         get_page_from_freelist
> >         prep_new_page
> >         clear_page_rep
> > 
> > i noticed it is because of clear_page_rep() which with patch consumes
> > double in cycles. 
> > 
> > Both versions should mostly go over pcp-cache, as far as i remember
> > order-2 is allowed to be cached.
> > 
> > I wounder why the patch gives x2 of cycles to clear_page_rep()...
> > 
> And here we go with some results "without" pcp exxecise:
> 
> static int fix_size_alloc_test(void)
> {
> 	void **ptr;
> 	int i;
> 
> 	if (set_cpus_allowed_ptr(current, cpumask_of(1)) < 0)
> 		pr_err("Failed to set affinity to %d CPU\n", 1);
> 
> 	ptr = vmalloc(sizeof(void *) * test_loop_count);
> 	if (!ptr)
> 		return -1;
> 
> 	for (i = 0; i < test_loop_count; i++)
> 		ptr[i] = vmalloc((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE);
> 
> 	for (i = 0; i < test_loop_count; i++) {
> 		if (ptr[i])
> 			vfree(ptr[i]);
> 	}
> 
> 	return 0;
> }
> 
> time sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=nr-pages-in-order
> 
> # default order-1
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1423862 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1453518 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1451734 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1455142 usec
> 
> # patch order-1
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1431082 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1454855 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1476372 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1433379 usec
> 
> # default order-2
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2198130 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2208504 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2219533 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2214151 usec
> 
> # patch order-2
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2110344 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2044186 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2083308 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2073572 usec
> 
> # default order-3
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3718592 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3740495 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3737213 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3740765 usec
> 
> # patch order-3
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3350391 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3374568 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3286374 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3261335 usec
> 
> # default order-6(64 pages)
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 23847773 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 24015706 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 24226268 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 24078102 usec
> 
> # patch order-6
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 20128225 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 19968964 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 20067469 usec
> Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 19928870 usec
> 
> Now i see that results align with my initial thoughts when i first time
> saw your patch.
 
Its reassuring that your test results show similar performance even at
the order-1 and order-2 cases. This was what I was expecting as well.

I'm assuming this happened because you tested exactly aligned PAGE_SIZE
allocations (whereas somehow I hadn't thought to do that).

> The question which is not clear for me still, why pcp case is doing better
> even for cached orders.
>
> Do you have any thoughts?

I'm not sure either. I'm not familiar with the optimization differences
between the standard and bulk allocators :(

When looking at the code, it appears that although the pcp lists can cache
up to PAGE_ALLOC_COSTLY_ORDER (3), the bulk allocator doesn't have support
for anything outside of order-0. And whenever order-0 pages are
available, the bulk allocator appears incredibly efficient at grabbing
them.

