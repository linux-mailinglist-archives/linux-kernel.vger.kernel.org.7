Return-Path: <linux-kernel+bounces-858522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A23BEB0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD861AE2C05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE32FFF88;
	Fri, 17 Oct 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9tKkjPr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4C2FFDC8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721563; cv=none; b=BecTcc3K7P1mdiC5qJuxJvRA1Ypq0dTxpDkF6LXBS5QOs6SaSEXCqlyxNinw6p13vsNncOaBHezqwohYZ753/vY2FkpY/NqQ5EBQF/v0SO8qX+8BjeWsp+D1R38UkbHPDKUWDT9sPVeEQVEXRe9D5+CF9TYRO5y6oyK+lWsVFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721563; c=relaxed/simple;
	bh=qicDVyeNt92wuALdVRPwGGTRoCBfAuIytTgnqL/VZqI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocsGGEIGEvZUpM8ZASkaiixBdfk7B29iprHjTNA/h25mVEKkLALLdrBiGfmJ/QWClBsvamzuRvAMTF222eCZwV2ebWPrc4bapif27Tq2briWtHxNN1Bzq1aHVoPusCWqJNZQ7ULWySc88ISznYcJEfhsOx9Ziqs1q9l2Gn06Wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9tKkjPr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso2490858e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760721559; x=1761326359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XL9gAVclE3lngHX2cLTVrJb1oTHIHA33oNB16rrMnlk=;
        b=U9tKkjPrefk3Yup/CuvysY2DjxZrMvaaux85Fh1Id/QO6QZ3y9i8jDGNg3+Ghr3QTE
         DI5Maz+RRVi5oO7nRUv/Aa42tyjzdJN720WIvXaPlDt54YJVwnZbh2dppgSk6MFQBGfY
         xjsZF/Kf4VYCAg1AmEhCKPV/cwQxbcVHIznGxHc4g22HQPWa8J1NNZCVpoNs+falKDWn
         tg2NeO/Ewq71LkZW/nOy0pxTYGcWBdNdO+BaF4quIyTk7YeYQuAS+ECwCuOyR9WUFSNF
         fZluGmy+E8tgNKgg8Yv+35weNOVwte01UjIy2k3sihoI8rh/XUAa5+Dt9ByKdRr5ntvg
         DENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721559; x=1761326359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL9gAVclE3lngHX2cLTVrJb1oTHIHA33oNB16rrMnlk=;
        b=p2bg3kZn6sHOZutKx/ZWlwwXm4F/DmYS2Nlkr68CS6GxGqgg5cIyjUPpatPrXXpUJV
         hUVQiuGi3vVdTBrc22JW0XITWkYsvZqBsT4mFXn2OzPpc1Pf8aZ3SQE1IzfRUxb7dQIq
         QgGhuz1+/f0r7f6dqNknzv/qCpzKeTxBmHUjbh3ooS9GTi3Jc19BvuL4i7bQO/l0YbXP
         zBC1N+KWT2zBQ26KxOEpL+0a0SthAX3LVRbitd0QaRxAj+Jv0s0GsNdvOGgywCackAmw
         Wc9kfQzczRDRhCK63/Ubap8Dd0/7/AsIeNvHWZuLtoveD6Zlycw2MU44PRLFPdU9jUui
         WOGg==
X-Forwarded-Encrypted: i=1; AJvYcCXC1gceI3jbnuRSmLIDPR7AuvkqBICxM0B3uZ016x+Wku8dGFqyqZ4xI7k3VDZpdAJ+s0tSGrnBv46cosE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1mcn6r1Ug1XA1GouAUHgo1jaZNZmSJ7DgDGUVyoar/M7OITi
	LkARqRIf7VWx1ofwYObRG9bc1Kzp5KQNSPLSgrRcY/frmvg3r8EgIt3FjPznD8OB
X-Gm-Gg: ASbGncuiil4KOG2MBWcgZXiz1Ls0M5Rj9hgBEY6vkVTYJ1vbZJLDefjAnToyr+PNrYn
	IiJK7RoLEM+Rp7UYs3hptuAaUTrykKBB7+iZj0kfdhfg8LP2H9QCDIDWHh85YJBPolUFKfQWbqp
	T5Kvf7AUeMlJI/j+b+OckFdZIq6/f2iMhCU0mvlG8mpZLKJfrPEiR657nEB9uSI4EAy77Vbtse8
	6mkqj0I5bZpTei0x+YV3pIe/sJTbmVg1nvbVAQjWsUi5SLls/0nD+dPAGiJ+OypaeNgPKOgdKaF
	i5V+PtSoN2nEoIbhKyuf9lmFJnDEpZOmdhlIULBAUPPnMGns1JbqV2fp2ocqBbhHQcBtC4uEAI+
	Wp4Zb4gX36J/wBq+ssdLTRoFa2yrnJun624UYH8KLmAbXXfhCiPhWnw==
X-Google-Smtp-Source: AGHT+IEJh1k63FP41WgVNhCjLX6axNuwSzkm8YuK2vtNhdoknX19jYuXL0p34J/QM8svaETz5NjFyw==
X-Received: by 2002:a05:6512:2397:b0:58b:27b:ed30 with SMTP id 2adb3069b0e04-591d84fae4cmr1760705e87.22.1760721558398;
        Fri, 17 Oct 2025 10:19:18 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def25a1csm58096e87.105.2025.10.17.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:19:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 17 Oct 2025 19:19:16 +0200
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPJ6lLf24TfW_1n7@milan>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
 <aO9pUS3zLHsap81f@fedora>
 <aPEZdHJlNOofy5tm@milan>
 <aPEubI4kWvzSC5RN@fedora>
 <aPFBY_OtG0YTAaHv@fedora>
 <aPJrmdeQY1QvbVdc@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPJrmdeQY1QvbVdc@milan>

On Fri, Oct 17, 2025 at 06:15:21PM +0200, Uladzislau Rezki wrote:
> On Thu, Oct 16, 2025 at 12:02:59PM -0700, Vishal Moola (Oracle) wrote:
> > On Thu, Oct 16, 2025 at 10:42:04AM -0700, Vishal Moola (Oracle) wrote:
> > > On Thu, Oct 16, 2025 at 06:12:36PM +0200, Uladzislau Rezki wrote:
> > > > On Wed, Oct 15, 2025 at 02:28:49AM -0700, Vishal Moola (Oracle) wrote:
> > > > > On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > > > > > > Running 1000 iterations of allocations on a small 4GB system finds:
> > > > > > > 
> > > > > > > 1000 2mb allocations:
> > > > > > > 	[Baseline]			[This patch]
> > > > > > > 	real    46.310s			real    34.380s
> > > > > > > 	user    0.001s			user    0.008s
> > > > > > > 	sys     46.058s			sys     34.152s
> > > > > > > 
> > > > > > > 10000 200kb allocations:
> > > > > > > 	[Baseline]			[This patch]
> > > > > > > 	real    56.104s			real    43.946s
> > > > > > > 	user    0.001s			user    0.003s
> > > > > > > 	sys     55.375s			sys     43.259s
> > > > > > > 
> > > > > > > 10000 20kb allocations:
> > > > > > > 	[Baseline]			[This patch]
> > > > > > > 	real    0m8.438s		real    0m9.160s
> > > > > > > 	user    0m0.001s		user    0m0.002s
> > > > > > > 	sys     0m7.936s		sys     0m8.671s
> > > > > > 
> > > > > > I'd be more confident in the 20kB numbers if you'd done 10x more
> > > > > > iterations.
> > > > > 
> > > > > I actually ran my a number of times to mitigate the effects of possibly
> > > > > too small sample sizes, so I do have that number for you too:
> > > > > 
> > > > > [Baseline]			[This patch]
> > > > > real    1m28.119s		real    1m32.630s
> > > > > user    0m0.012s		user    0m0.011s
> > > > > sys     1m23.270s		sys     1m28.529s
> > > > > 
> > > > I have just had a look at performance figures of this patch. The test
> > > > case is 16K allocation by one single thread, 1 000 000 loops, 10 run:
> > > > 
> > > > sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=4
> > > 
> > > The reason I didn't use this test module is the same concern Matthew
> > > brought up earlier about testing the PCP list rather than buddy
> > > allocator. The test module allocates, then frees over and over again,
> > > making it incredibly prone to reuse the pages over and over again.
> > > 
> > > > BOX: AMD Milan, 256 CPUs, 512GB of memory
> > > > 
> > > > # default 16K alloc
> > > > [   15.823704] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955334 usec
> > > > [   17.751685] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1158739 usec
> > > > [   19.443759] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1016522 usec
> > > > [   21.035701] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 911381 usec
> > > > [   22.727688] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 987286 usec
> > > > [   24.199694] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955112 usec
> > > > [   25.755675] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 926393 usec
> > > > [   27.355670] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 937875 usec
> > > > [   28.979671] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1006985 usec
> > > > [   30.531674] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 941088 usec
> > > > 
> > > > # the patch 16K alloc
> > > > [   44.343380] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2296849 usec
> > > > [   47.171290] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2014678 usec
> > > > [   50.007258] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2094184 usec
> > > > [   52.651141] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1953046 usec
> > > > [   55.455089] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2209423 usec
> > > > [   57.943153] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1941747 usec
> > > > [   60.799043] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2038504 usec
> > > > [   63.299007] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1788588 usec
> > > > [   65.843011] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2137055 usec
> > > > [   68.647031] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2193022 usec
> > > > 
> > > > 2X slower.
> > > > 
> > > > perf-cycles, same test but on 64 CPUs:
> > > > 
> > > > +   97.02%     0.13%  [test_vmalloc]    [k] fix_size_alloc_test
> > > > -   82.11%    82.10%  [kernel]          [k] native_queued_spin_lock_slowpath
> > > >      26.19% ret_from_fork_asm
> > > >         ret_from_fork
> > > >       - kthread
> > > >          - 25.96% test_func
> > > >             - fix_size_alloc_test
> > > >                - 23.49% __vmalloc_node_noprof
> > > >                   - __vmalloc_node_range_noprof
> > > >                      - 54.70% alloc_pages_noprof
> > > >                           alloc_pages_mpol
> > > >                           __alloc_frozen_pages_noprof
> > > >                           get_page_from_freelist
> > > >                           __rmqueue_pcplist
> > > >                      - 5.58% __get_vm_area_node
> > > >                           alloc_vmap_area
> > > >                - 20.54% vfree.part.0
> > > >                   - 20.43% __free_frozen_pages
> > > >                        free_frozen_page_commit
> > > >                        free_pcppages_bulk
> > > >                        _raw_spin_lock_irqsave
> > > >                        native_queued_spin_lock_slowpath
> > > >          - 0.77% worker_thread
> > > >             - process_one_work
> > > >                - 0.76% vmstat_update
> > > >                     refresh_cpu_vm_stats
> > > >                     decay_pcp_high
> > > >                     free_pcppages_bulk
> > > >                     _raw_spin_lock_irqsave
> > > >                     native_queued_spin_lock_slowpath
> > > > +   76.57%     0.16%  [kernel]          [k] _raw_spin_lock_irqsave
> > > > +   71.62%     0.00%  [kernel]          [k] __vmalloc_node_noprof
> > > > +   71.61%     0.58%  [kernel]          [k] __vmalloc_node_range_noprof
> > > > +   62.35%     0.06%  [kernel]          [k] alloc_pages_mpol
> > > > +   62.27%     0.17%  [kernel]          [k] __alloc_frozen_pages_noprof
> > > > +   62.20%     0.02%  [kernel]          [k] alloc_pages_noprof
> > > > +   62.10%     0.05%  [kernel]          [k] get_page_from_freelist
> > > > +   55.63%     0.19%  [kernel]          [k] __rmqueue_pcplist
> > > > +   32.11%     0.00%  [kernel]          [k] ret_from_fork_asm
> > > > +   32.11%     0.00%  [kernel]          [k] ret_from_fork
> > > > +   32.11%     0.00%  [kernel]          [k] kthread
> > > > 
> > > > I would say the bottle-neck is a page-allocator. It seems high-order
> > > > allocations are not good for it.
> > 
> > Ah also just took a closer look at this. I realize that you also did 16k
> > allocations (which is at most order-2), so it may not be a good
> > representation of high-order allocations either.
> > 
> I agree. But then we should not optimize "small" orders and focus on
> highest ones. Because of double degrade. I assume stress-ng fork test
> would alos notice this.
> 
> > Plus that falls into the regression range I found that I detailed in
> > response to Matthew elsewhere (I've copy pasted it here for reference)
> > 
> >   I ended up finding that allocating sizes <=20k had noticeable
> >   regressions, while [20k, 90k] was approximately the same, and >= 90k had
> >   improvements (getting more and more noticeable as size grows in
> >   magnitude).
> > 
> Yes, i did 2-order allocations 
> 
> # default
> +   35.87%     4.24%  [kernel]            [k] alloc_pages_bulk_noprof
> +   31.94%     0.88%  [kernel]            [k] vfree.part.0
> -   27.38%    27.36%  [kernel]            [k] clear_page_rep
>      27.36% ret_from_fork_asm
>         ret_from_fork
>         kthread
>         test_func
>         fix_size_alloc_test
>         __vmalloc_node_noprof
>         __vmalloc_node_range_noprof
>         alloc_pages_bulk_noprof
>         clear_page_rep
> 
> # patch
> +   53.32%     1.12%  [kernel]        [k] get_page_from_freelist
> +   49.41%     0.71%  [kernel]        [k] prep_new_page
> -   48.70%    48.64%  [kernel]        [k] clear_page_rep
>      48.64% ret_from_fork_asm
>         ret_from_fork
>         kthread
>         test_func
>         fix_size_alloc_test
>         __vmalloc_node_noprof
>         __vmalloc_node_range_noprof
>         alloc_pages_noprof
>         alloc_pages_mpol
>         __alloc_frozen_pages_noprof
>         get_page_from_freelist
>         prep_new_page
>         clear_page_rep
> 
> i noticed it is because of clear_page_rep() which with patch consumes
> double in cycles. 
> 
> Both versions should mostly go over pcp-cache, as far as i remember
> order-2 is allowed to be cached.
> 
> I wounder why the patch gives x2 of cycles to clear_page_rep()...
> 
And here we go with some results "without" pcp exxecise:

static int fix_size_alloc_test(void)
{
	void **ptr;
	int i;

	if (set_cpus_allowed_ptr(current, cpumask_of(1)) < 0)
		pr_err("Failed to set affinity to %d CPU\n", 1);

	ptr = vmalloc(sizeof(void *) * test_loop_count);
	if (!ptr)
		return -1;

	for (i = 0; i < test_loop_count; i++)
		ptr[i] = vmalloc((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE);

	for (i = 0; i < test_loop_count; i++) {
		if (ptr[i])
			vfree(ptr[i]);
	}

	return 0;
}

time sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=nr-pages-in-order

# default order-1
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1423862 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1453518 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1451734 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1455142 usec

# patch order-1
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1431082 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1454855 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1476372 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1433379 usec

# default order-2
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2198130 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2208504 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2219533 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2214151 usec

# patch order-2
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2110344 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2044186 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2083308 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2073572 usec

# default order-3
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3718592 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3740495 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3737213 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3740765 usec

# patch order-3
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3350391 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3374568 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3286374 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 3261335 usec

# default order-6(64 pages)
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 23847773 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 24015706 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 24226268 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 24078102 usec

# patch order-6
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 20128225 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 19968964 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 20067469 usec
Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 19928870 usec

Now i see that results align with my initial thoughts when i first time
saw your patch.

The question which is not clear for me still, why pcp case is doing better
even for cached orders.

Do you have any thoughts?

--
Uladzislau Rezki

