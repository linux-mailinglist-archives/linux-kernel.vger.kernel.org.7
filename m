Return-Path: <linux-kernel+bounces-858399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A7BEAAC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A6CD5A6B33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF4296BC0;
	Fri, 17 Oct 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwW9bIPI"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CD2853E9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717727; cv=none; b=akQXtvQtKp8vShufaHtkAhDzqQc1uUNVEa8zFgYk3/iYSQUtLyjERktXkDVXuUdOsaGQIyYQXZlGeFxyPpWZWd3oP2Uw+7V13beEhIwuIh9CJLuPTRy+LXmMenvJqVIdcAbwPocTKOhzzsGnIyL5tyj/jEjZPj2h1Nq+zawyXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717727; c=relaxed/simple;
	bh=oOo5BhNivO0kKJwKDjNTU2xGZSrSteum5coJjcca4KQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enOqzYtsjaUSK69PuTHDvAGREAfcCijcLddrrFGQNPRjrW08rCFBac8NTAgrL8KPk+kk8TkOD99G4iuHE3L/e35hYqyNGf4TbQkTedYJKZG7Po9Hdwxgk4jXy2SNG1FhqcyYPtPq1ReqcYWqEMiPFneWSfQ0GeQJ5+LgeWUVEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwW9bIPI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso2991238e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717724; x=1761322524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngLRmK1oXthdQUYtmQtbPUF1dhiRRUALxIRLtMvIerU=;
        b=NwW9bIPIrI2NuHJVFGUXIKM2Y9IEnxg4rkAVk8aHgkG9zGgEHTAEXzAaG6d30xvcJs
         r2ZlCLltDCV74DYthawMLbHOtNIU+tzPUZ8y+ehsdesKwuLbs81AIKNV6/YF/D+JiX4F
         w6v5Vu+bUAG/Fq+xptruo3eucmYvDcPQpYwuqzBjYIcNL8PaWfiK/ZgsOnjoyaDakKqR
         yS6Q0aaHvsVnAK4Y0oMn7ECoSNxp1E33rVpiPqSm2UvZcKlgQcQIiXv9oEGfT9z+iP7A
         sUIfBf3D86UxfHH9hGQb8KIw9pDU9rwhpjcyAQBe7QWSYJKOtZQA/ui3qqjZBFMv+GxJ
         s1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717724; x=1761322524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngLRmK1oXthdQUYtmQtbPUF1dhiRRUALxIRLtMvIerU=;
        b=V20kq1/vILxLmyVtPy9q64P1i8RA15Ii49HfSCRYcXuXkoxo2xe/NEnciIAHHvepGp
         TB0vf6TuVsm805S7BXgzWjg2S1l8nOoL0aTmGtPfiqEy7QKfwNiDrZL/NDRpt1ykRZD1
         LUjKVG/lLhrUSvw6csnv3ae1c6np3r8rBwfO79HbIm2gqIvA7JmCHUfvJYeoh5SSkjdD
         022ss8dheI6L84//EO5U1oHBJr4j1aDyZcQ/MNk2koN8ZYYT85iBarXn0u5xQiXRDvJV
         ZWLzOdmY8LMX5544Vs3qJ7J0Fn2jMSrbr7KG2UCuEJ8H/C8PZNIaS7+Zue650lGfCKOB
         UC1A==
X-Forwarded-Encrypted: i=1; AJvYcCVAzks8FAy0nyYxle6vyCkl8jqCZPY+YSBv1a35b3KGBAbflyVk5bMA0GLAlXH2t/zgdBGXHB05uJqsPA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+4XYAygtuKGMaJD2SaqmyY2a/E00RYBAd4U1xtWSXf2Kgr10
	dqSDbhONCQYy3lHtnDQdJ1hEhEnCpgf5A9aMrIIAJy94SFN6Ih1kBCJZfZptPXjGhhg=
X-Gm-Gg: ASbGncvOvWztKQ2pFlu+9rsEf7P562WAhA1wDP2+SdooLKu+VmUrw/17HFjexaPB+5J
	HWmo5qplYi2vvBTdPxncmU+GyFu9k/27g9hUbAyhAi7L7GulE4fhblWCQjmMEfqM3bvdOvDfSYj
	dz06pdlNc/ktBYHNPlCqhinsrLhAbhC9DoZhUuLHgGsqqwhvmuf630Zd3bRiG0hDozjkW3VKx7R
	EbQt5lFp+sUJr42rqvyDOp3gtw6LXIdGovjnDlC9d46ef0+PsXKYSsEiCRrLTMqTeFhWKr9hFS7
	B5WdAcRcs2YMdE5R/ftxGniPPQdJrZTPXmphwaYzrikcbpvhTsBrISmV8QG+v9FMqRsFuGNHewu
	THHsw5zK40hiBY6UEcNYmlyRRXgMDFnMcV/d3MOOIdlveI59rSaisnV3A7kpYx9BG
X-Google-Smtp-Source: AGHT+IF4+HUifUUlo17HSCgYnNGk3aG8u5kLir6yEURWDm6jFdmspJdCdomosbkBnIZiFQb1BeuOoQ==
X-Received: by 2002:a05:6512:118f:b0:591:c745:3024 with SMTP id 2adb3069b0e04-591d85665d6mr1544436e87.43.1760717723485;
        Fri, 17 Oct 2025 09:15:23 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf49bsm24526e87.28.2025.10.17.09.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:15:22 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 17 Oct 2025 18:15:21 +0200
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPJrmdeQY1QvbVdc@milan>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
 <aO9pUS3zLHsap81f@fedora>
 <aPEZdHJlNOofy5tm@milan>
 <aPEubI4kWvzSC5RN@fedora>
 <aPFBY_OtG0YTAaHv@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPFBY_OtG0YTAaHv@fedora>

On Thu, Oct 16, 2025 at 12:02:59PM -0700, Vishal Moola (Oracle) wrote:
> On Thu, Oct 16, 2025 at 10:42:04AM -0700, Vishal Moola (Oracle) wrote:
> > On Thu, Oct 16, 2025 at 06:12:36PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Oct 15, 2025 at 02:28:49AM -0700, Vishal Moola (Oracle) wrote:
> > > > On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > > > > > Running 1000 iterations of allocations on a small 4GB system finds:
> > > > > > 
> > > > > > 1000 2mb allocations:
> > > > > > 	[Baseline]			[This patch]
> > > > > > 	real    46.310s			real    34.380s
> > > > > > 	user    0.001s			user    0.008s
> > > > > > 	sys     46.058s			sys     34.152s
> > > > > > 
> > > > > > 10000 200kb allocations:
> > > > > > 	[Baseline]			[This patch]
> > > > > > 	real    56.104s			real    43.946s
> > > > > > 	user    0.001s			user    0.003s
> > > > > > 	sys     55.375s			sys     43.259s
> > > > > > 
> > > > > > 10000 20kb allocations:
> > > > > > 	[Baseline]			[This patch]
> > > > > > 	real    0m8.438s		real    0m9.160s
> > > > > > 	user    0m0.001s		user    0m0.002s
> > > > > > 	sys     0m7.936s		sys     0m8.671s
> > > > > 
> > > > > I'd be more confident in the 20kB numbers if you'd done 10x more
> > > > > iterations.
> > > > 
> > > > I actually ran my a number of times to mitigate the effects of possibly
> > > > too small sample sizes, so I do have that number for you too:
> > > > 
> > > > [Baseline]			[This patch]
> > > > real    1m28.119s		real    1m32.630s
> > > > user    0m0.012s		user    0m0.011s
> > > > sys     1m23.270s		sys     1m28.529s
> > > > 
> > > I have just had a look at performance figures of this patch. The test
> > > case is 16K allocation by one single thread, 1 000 000 loops, 10 run:
> > > 
> > > sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=4
> > 
> > The reason I didn't use this test module is the same concern Matthew
> > brought up earlier about testing the PCP list rather than buddy
> > allocator. The test module allocates, then frees over and over again,
> > making it incredibly prone to reuse the pages over and over again.
> > 
> > > BOX: AMD Milan, 256 CPUs, 512GB of memory
> > > 
> > > # default 16K alloc
> > > [   15.823704] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955334 usec
> > > [   17.751685] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1158739 usec
> > > [   19.443759] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1016522 usec
> > > [   21.035701] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 911381 usec
> > > [   22.727688] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 987286 usec
> > > [   24.199694] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955112 usec
> > > [   25.755675] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 926393 usec
> > > [   27.355670] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 937875 usec
> > > [   28.979671] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1006985 usec
> > > [   30.531674] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 941088 usec
> > > 
> > > # the patch 16K alloc
> > > [   44.343380] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2296849 usec
> > > [   47.171290] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2014678 usec
> > > [   50.007258] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2094184 usec
> > > [   52.651141] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1953046 usec
> > > [   55.455089] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2209423 usec
> > > [   57.943153] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1941747 usec
> > > [   60.799043] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2038504 usec
> > > [   63.299007] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1788588 usec
> > > [   65.843011] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2137055 usec
> > > [   68.647031] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2193022 usec
> > > 
> > > 2X slower.
> > > 
> > > perf-cycles, same test but on 64 CPUs:
> > > 
> > > +   97.02%     0.13%  [test_vmalloc]    [k] fix_size_alloc_test
> > > -   82.11%    82.10%  [kernel]          [k] native_queued_spin_lock_slowpath
> > >      26.19% ret_from_fork_asm
> > >         ret_from_fork
> > >       - kthread
> > >          - 25.96% test_func
> > >             - fix_size_alloc_test
> > >                - 23.49% __vmalloc_node_noprof
> > >                   - __vmalloc_node_range_noprof
> > >                      - 54.70% alloc_pages_noprof
> > >                           alloc_pages_mpol
> > >                           __alloc_frozen_pages_noprof
> > >                           get_page_from_freelist
> > >                           __rmqueue_pcplist
> > >                      - 5.58% __get_vm_area_node
> > >                           alloc_vmap_area
> > >                - 20.54% vfree.part.0
> > >                   - 20.43% __free_frozen_pages
> > >                        free_frozen_page_commit
> > >                        free_pcppages_bulk
> > >                        _raw_spin_lock_irqsave
> > >                        native_queued_spin_lock_slowpath
> > >          - 0.77% worker_thread
> > >             - process_one_work
> > >                - 0.76% vmstat_update
> > >                     refresh_cpu_vm_stats
> > >                     decay_pcp_high
> > >                     free_pcppages_bulk
> > >                     _raw_spin_lock_irqsave
> > >                     native_queued_spin_lock_slowpath
> > > +   76.57%     0.16%  [kernel]          [k] _raw_spin_lock_irqsave
> > > +   71.62%     0.00%  [kernel]          [k] __vmalloc_node_noprof
> > > +   71.61%     0.58%  [kernel]          [k] __vmalloc_node_range_noprof
> > > +   62.35%     0.06%  [kernel]          [k] alloc_pages_mpol
> > > +   62.27%     0.17%  [kernel]          [k] __alloc_frozen_pages_noprof
> > > +   62.20%     0.02%  [kernel]          [k] alloc_pages_noprof
> > > +   62.10%     0.05%  [kernel]          [k] get_page_from_freelist
> > > +   55.63%     0.19%  [kernel]          [k] __rmqueue_pcplist
> > > +   32.11%     0.00%  [kernel]          [k] ret_from_fork_asm
> > > +   32.11%     0.00%  [kernel]          [k] ret_from_fork
> > > +   32.11%     0.00%  [kernel]          [k] kthread
> > > 
> > > I would say the bottle-neck is a page-allocator. It seems high-order
> > > allocations are not good for it.
> 
> Ah also just took a closer look at this. I realize that you also did 16k
> allocations (which is at most order-2), so it may not be a good
> representation of high-order allocations either.
> 
I agree. But then we should not optimize "small" orders and focus on
highest ones. Because of double degrade. I assume stress-ng fork test
would alos notice this.

> Plus that falls into the regression range I found that I detailed in
> response to Matthew elsewhere (I've copy pasted it here for reference)
> 
>   I ended up finding that allocating sizes <=20k had noticeable
>   regressions, while [20k, 90k] was approximately the same, and >= 90k had
>   improvements (getting more and more noticeable as size grows in
>   magnitude).
> 
Yes, i did 2-order allocations 

# default
+   35.87%     4.24%  [kernel]            [k] alloc_pages_bulk_noprof
+   31.94%     0.88%  [kernel]            [k] vfree.part.0
-   27.38%    27.36%  [kernel]            [k] clear_page_rep
     27.36% ret_from_fork_asm
        ret_from_fork
        kthread
        test_func
        fix_size_alloc_test
        __vmalloc_node_noprof
        __vmalloc_node_range_noprof
        alloc_pages_bulk_noprof
        clear_page_rep

# patch
+   53.32%     1.12%  [kernel]        [k] get_page_from_freelist
+   49.41%     0.71%  [kernel]        [k] prep_new_page
-   48.70%    48.64%  [kernel]        [k] clear_page_rep
     48.64% ret_from_fork_asm
        ret_from_fork
        kthread
        test_func
        fix_size_alloc_test
        __vmalloc_node_noprof
        __vmalloc_node_range_noprof
        alloc_pages_noprof
        alloc_pages_mpol
        __alloc_frozen_pages_noprof
        get_page_from_freelist
        prep_new_page
        clear_page_rep

i noticed it is because of clear_page_rep() which with patch consumes
double in cycles. 

Both versions should mostly go over pcp-cache, as far as i remember
order-2 is allowed to be cached.

I wounder why the patch gives x2 of cycles to clear_page_rep()...

--
Uladzislau Rezki

