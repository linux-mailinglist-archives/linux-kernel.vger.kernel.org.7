Return-Path: <linux-kernel+bounces-856816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B44BE529E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D666E4F7488
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E7231826;
	Thu, 16 Oct 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfcqZdCw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AD1CDFD5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641391; cv=none; b=DqKkKqE66N+brtLGT8CZjM42QPk3qzeKUglgCMemgqYPx8L11BuCrOmcHbKCoAaqnAkYd1qQkybHFZMkM1hrwlWZ34qg5w9+na1MNpfeBXJ/Y+K958y7rD/shiIdvx7gBzPKuufXdL5VbsaeJDdtS+mUghbJBy7MhpP9SYQ1ZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641391; c=relaxed/simple;
	bh=ZsHKQ5AActfUgl4mI1rv0BKSC1aW6V+ROa7gKY0/AgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnuc49tLrmboQ5oJ+qHrYbSFOB5G+ou0J71IbfDACsMGviHErtfRexstiF5Nf1lF05Y1E/2+vS6pYv2vN9fiv8DZ8hpbsZFEu0dgTHE79/hWkFTIXtevwk2uRYvrPj6/DwVFM1V3N6BlSbUVZb04FlvzfwZ34jMQwD+9OC5ZBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfcqZdCw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710665e7deso5589205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760641387; x=1761246187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bElOFzybJYApx11r2UithqZnt7BeVh4JMgw683hHLlM=;
        b=RfcqZdCw6RaNbO25iAcXYj5rtRBUoYRB7U9carTwer7KJobUdamnEzBKlxDWA89Lhx
         65p5Q4UPFccfqh2MEVR+rwkV1lXWeHknJlWSmCyIMfek+k8kmUd2bIRQWazXzsSTe5Lv
         Tde1QcAHJXbOQYKiy7xu1vE23sRoHekLHWsZtx2WRJpXN2h4mRr76TIP1M+cO6qO3Tmd
         wmQPvQ3yPEN7T+rK40SmJA7PVX3P330ESm//Dt+/oatPX9qw0kCQX4BBqnApH29gJdLI
         Uc+SFVTAIwyFwWd1ggyuumrdC/32awTCG360jRwm//ggJF6bJkz7rVFCFNIKt/0Oxqb+
         k2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760641387; x=1761246187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bElOFzybJYApx11r2UithqZnt7BeVh4JMgw683hHLlM=;
        b=AGu78JHKyqryGgIjjn+tbYavaHNTTMP6Z4aOhOFhNA58p3nPbnzFZZLn1/YFD/yNEZ
         1BznePZffxKhw1p1fPm74GkYTU59HqOcVE0YoXGrHvifhh5VJb3iHg0/OFxOxSFbQnp2
         /GFMkn0LsJMWRbivgDVURfDc/drx0UtRPCSDl/P5xcafI3uUx++IhyHIo/longKML09p
         vkaTXoKOCDhjmFwBGsY54Vscwg1HiQuGGTnrOxt4l32rYHgbr1Q7rISmPZaEysk5xagW
         hzTxNK8igCtp9MtHpGHX5oJuC3PUtDOWH1am8/EXIJrmVGw3m64mvxu263volCrUQAxw
         pkhA==
X-Forwarded-Encrypted: i=1; AJvYcCVwAubixIyk3JCUlz/yRVW2Sz5bDHk49osKnjDLsqipVxca2yw02RFItjo7IY1RHkLXl6WBVXM6ML0nMEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyML8uNanX+CL8vEt2CScEgjsIjNbLteFb7oGz40pEHYHjeXqo4
	pbCE5npjfUFM2GAzFRQ9fw0esxRSep+dd4z/el2we42/gbuAClIYB2J5
X-Gm-Gg: ASbGncveCC6aTjd4T+mQTWUWwrH4g//ZXo4Oxzm/7wZyV1/k+RWQCAHK98Dk+3m/c1e
	6zIgUtS/Jzad1MLpsOm4SIcSlr5BPepP1wt8wOcBcpZquXPuS/wpRJ65fTNhYujixAXTRqFwtJm
	KH+YAZyKo7jqPdw5ekKiQxPohd7rJfOcwibfO6eD80BS0dwbHVcEMdKiu/SuETmcBGrxIbmfb14
	4SvIdr4aH+JIOXdNkb4O/0yURhj3kxUDhQlC1wq7wSp0l1xv/rT7FeSvIeU5G8pWJO5WloLDULq
	ogW15DQmowJXIFCpbqCdzyckmxzynHHfDwbrncEPbtUmvJeuKegzSoIViB9UzmK7L52e9E4Gscs
	tNmhSwE5H69UEsItH+thoF4YEWI1wAWPu6taU1ajLioqwZqvNL+o/Do2BVH2pXhLGXA2SHnFZ37
	VpJCayqtUgVsBfm8VS
X-Google-Smtp-Source: AGHT+IHpqR+b9nmFiD5VjfH6g0TM8Sg/3RCXImNqlBAhdaTBB5kxjSgRISQMrKRjkf7dkKnh9/bQZA==
X-Received: by 2002:a05:600c:3553:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-4711789daf3mr7304675e9.9.1760641387210;
        Thu, 16 Oct 2025 12:03:07 -0700 (PDT)
Received: from fedora ([31.94.20.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711435b06fsm52679605e9.0.2025.10.16.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 12:03:06 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:02:59 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPFBY_OtG0YTAaHv@fedora>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
 <aO9pUS3zLHsap81f@fedora>
 <aPEZdHJlNOofy5tm@milan>
 <aPEubI4kWvzSC5RN@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEubI4kWvzSC5RN@fedora>

On Thu, Oct 16, 2025 at 10:42:04AM -0700, Vishal Moola (Oracle) wrote:
> On Thu, Oct 16, 2025 at 06:12:36PM +0200, Uladzislau Rezki wrote:
> > On Wed, Oct 15, 2025 at 02:28:49AM -0700, Vishal Moola (Oracle) wrote:
> > > On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> > > > On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > > > > Running 1000 iterations of allocations on a small 4GB system finds:
> > > > > 
> > > > > 1000 2mb allocations:
> > > > > 	[Baseline]			[This patch]
> > > > > 	real    46.310s			real    34.380s
> > > > > 	user    0.001s			user    0.008s
> > > > > 	sys     46.058s			sys     34.152s
> > > > > 
> > > > > 10000 200kb allocations:
> > > > > 	[Baseline]			[This patch]
> > > > > 	real    56.104s			real    43.946s
> > > > > 	user    0.001s			user    0.003s
> > > > > 	sys     55.375s			sys     43.259s
> > > > > 
> > > > > 10000 20kb allocations:
> > > > > 	[Baseline]			[This patch]
> > > > > 	real    0m8.438s		real    0m9.160s
> > > > > 	user    0m0.001s		user    0m0.002s
> > > > > 	sys     0m7.936s		sys     0m8.671s
> > > > 
> > > > I'd be more confident in the 20kB numbers if you'd done 10x more
> > > > iterations.
> > > 
> > > I actually ran my a number of times to mitigate the effects of possibly
> > > too small sample sizes, so I do have that number for you too:
> > > 
> > > [Baseline]			[This patch]
> > > real    1m28.119s		real    1m32.630s
> > > user    0m0.012s		user    0m0.011s
> > > sys     1m23.270s		sys     1m28.529s
> > > 
> > I have just had a look at performance figures of this patch. The test
> > case is 16K allocation by one single thread, 1 000 000 loops, 10 run:
> > 
> > sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=4
> 
> The reason I didn't use this test module is the same concern Matthew
> brought up earlier about testing the PCP list rather than buddy
> allocator. The test module allocates, then frees over and over again,
> making it incredibly prone to reuse the pages over and over again.
> 
> > BOX: AMD Milan, 256 CPUs, 512GB of memory
> > 
> > # default 16K alloc
> > [   15.823704] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955334 usec
> > [   17.751685] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1158739 usec
> > [   19.443759] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1016522 usec
> > [   21.035701] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 911381 usec
> > [   22.727688] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 987286 usec
> > [   24.199694] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955112 usec
> > [   25.755675] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 926393 usec
> > [   27.355670] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 937875 usec
> > [   28.979671] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1006985 usec
> > [   30.531674] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 941088 usec
> > 
> > # the patch 16K alloc
> > [   44.343380] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2296849 usec
> > [   47.171290] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2014678 usec
> > [   50.007258] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2094184 usec
> > [   52.651141] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1953046 usec
> > [   55.455089] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2209423 usec
> > [   57.943153] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1941747 usec
> > [   60.799043] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2038504 usec
> > [   63.299007] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1788588 usec
> > [   65.843011] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2137055 usec
> > [   68.647031] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2193022 usec
> > 
> > 2X slower.
> > 
> > perf-cycles, same test but on 64 CPUs:
> > 
> > +   97.02%     0.13%  [test_vmalloc]    [k] fix_size_alloc_test
> > -   82.11%    82.10%  [kernel]          [k] native_queued_spin_lock_slowpath
> >      26.19% ret_from_fork_asm
> >         ret_from_fork
> >       - kthread
> >          - 25.96% test_func
> >             - fix_size_alloc_test
> >                - 23.49% __vmalloc_node_noprof
> >                   - __vmalloc_node_range_noprof
> >                      - 54.70% alloc_pages_noprof
> >                           alloc_pages_mpol
> >                           __alloc_frozen_pages_noprof
> >                           get_page_from_freelist
> >                           __rmqueue_pcplist
> >                      - 5.58% __get_vm_area_node
> >                           alloc_vmap_area
> >                - 20.54% vfree.part.0
> >                   - 20.43% __free_frozen_pages
> >                        free_frozen_page_commit
> >                        free_pcppages_bulk
> >                        _raw_spin_lock_irqsave
> >                        native_queued_spin_lock_slowpath
> >          - 0.77% worker_thread
> >             - process_one_work
> >                - 0.76% vmstat_update
> >                     refresh_cpu_vm_stats
> >                     decay_pcp_high
> >                     free_pcppages_bulk
> >                     _raw_spin_lock_irqsave
> >                     native_queued_spin_lock_slowpath
> > +   76.57%     0.16%  [kernel]          [k] _raw_spin_lock_irqsave
> > +   71.62%     0.00%  [kernel]          [k] __vmalloc_node_noprof
> > +   71.61%     0.58%  [kernel]          [k] __vmalloc_node_range_noprof
> > +   62.35%     0.06%  [kernel]          [k] alloc_pages_mpol
> > +   62.27%     0.17%  [kernel]          [k] __alloc_frozen_pages_noprof
> > +   62.20%     0.02%  [kernel]          [k] alloc_pages_noprof
> > +   62.10%     0.05%  [kernel]          [k] get_page_from_freelist
> > +   55.63%     0.19%  [kernel]          [k] __rmqueue_pcplist
> > +   32.11%     0.00%  [kernel]          [k] ret_from_fork_asm
> > +   32.11%     0.00%  [kernel]          [k] ret_from_fork
> > +   32.11%     0.00%  [kernel]          [k] kthread
> > 
> > I would say the bottle-neck is a page-allocator. It seems high-order
> > allocations are not good for it.

Ah also just took a closer look at this. I realize that you also did 16k
allocations (which is at most order-2), so it may not be a good
representation of high-order allocations either.

Plus that falls into the regression range I found that I detailed in
response to Matthew elsewhere (I've copy pasted it here for reference)

  I ended up finding that allocating sizes <=20k had noticeable
  regressions, while [20k, 90k] was approximately the same, and >= 90k had
  improvements (getting more and more noticeable as size grows in
  magnitude).

> > --
> > Uladzislau Rezki

