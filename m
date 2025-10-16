Return-Path: <linux-kernel+bounces-856564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83FBE47E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B87BB56150D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D432D0C2;
	Thu, 16 Oct 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZLb1raP"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451923EA95
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631163; cv=none; b=DOU414coFCUtb30n+GqDiuyR8Z2aSJJRuWTWXf2N+/d7kcv5MltcjInJbUfALaZL3C/5MML5nZsMOXyL65PQemMmclqK4Bv/PI0KO5xQDLyiv0JBXvNQLZq6YAiO3JIY8fa5W6NJT5IXSRfhbpxCAmfXD6TJSivn2QJPn0EIrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631163; c=relaxed/simple;
	bh=tHE+sdECYEezoqbFzIBImDNq7KiAJjx2MDabd8TlJkI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtZIghF/squEUjqap/+B6kpRmGmmt26I7bsemlXELZSuI7Q/io0CGVJUDiEkzeE8GiegSaKLVaePRr/9QWoP/W7fhSIdTT9s+kixeBNDwMRhr0d9hWEg89+IOu3AHy5h58khm/OVIpS3qGSlQ98Uq1cG6eNur4j8ZCcL05923lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZLb1raP; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-362e291924aso7232301fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760631160; x=1761235960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ8TgGiMRhix2au9XQ+hoMB2htnBV/w4RzgVlEvya/w=;
        b=LZLb1raPO6SngK9DimeI6oJxiUoSRo1wHM6KxHygzI8BfpBtsbSmFyOo/wvMEuF6kR
         A9bbfbpNPpW9U9jGRkQjO4RYlUSXWXqqf9p4nxmS+nQtIzSdA+o2YZmWKpdWQcLRlT4f
         ONO2HDIziibD7kJngD83kC4NMRbBqfYjHJPA/QXfC1ECUs3Byl8zm+RbJ9CQEdbR5C1D
         ILyb5Dppz6lW4YxtJF4IE9ajTrwkURRLgvnMu+ncneX3BQc7r5vB5F2CWUTmdSb2nngF
         YatLQqQRAd5aSFCvK6kLrAkZV6s0zh4Fc1vVF+Fpq3ptLFCdp/Lk+0+mB3BFUDJoinbA
         QXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631160; x=1761235960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ8TgGiMRhix2au9XQ+hoMB2htnBV/w4RzgVlEvya/w=;
        b=rjjgSdqPtp+R1ygzOgxQP+mz/f8P8TS4zejxeMzflGEWIPD02txRIS1LDI21IlXEU+
         JE5rdBS2u8vsOK1sp+xuwRwt/9d4WhWopd4rAt+CJxsGYrH/qavDh62mC7joF33kXFOd
         Ep963vmZtEj9ihy8u/bszWxCL0PtBHaH9gPXcgbFWEki5T2khUJC8L2yL/HMwjfNUFst
         L+loVTJ0GIdHqTEPXngCQfkQvHFJP+5h8SCFqKWJtBfhDm2m3t655tFizFpyuGgGVR/Q
         y55oiVQ50ln4PEPeOxq1qHQqIMMPNF+E+2EDhwJQj7f/Pz8la/SannVtwAMWr7g/bFjM
         hzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMgpxDvZSDm1pr+fv79NpKLAMkZBrEYRvHRXJZPuWZp0D14ZaTNr0nOAhD6tnRJaUB00KcURGlaKXy/4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsAiVYwlI8UZMCgzQ1T5xuSNJkmP+6g7+e9jZHYsORi+K7DYY
	uI8ZofsfJ5qn67+mb66JawJCO41wFqsyjyl0MtOvoruVXnfnkGqeJSre7s5VYm6C
X-Gm-Gg: ASbGncvXmzzRG1oA09u18HcagTBNl5NBTImmVph+JfrhpclJOa3gfM+tJeax+dmpDc+
	Qm91kiP+y0ehFOCT/ZghX5+1RRoyxCdF7f6QGE5k9VUU5lRR4tDspcfuQ58AkO7Inm96QY0Tq6R
	vOiQAyIEoTgcd824tEiHnbwLfogzy8zf7Jf9QCLXJpbbB+IdX9AHrm1/xh2i4ERGsf9bEoURwiZ
	78TC/HW7l535zDGnJv40+3QuAGy3gnNGHaVmFJ47kjLzfoFfWVOySnIn8WIWNaEL66mIMCK3rVU
	pYcM+KjwN22+eeswm1FqJeNj5OxAf7vxfmVh85725TtQn9tAyllPwmD7M0c5Ejt0YekNTqzBUxm
	ITMFbqAMTsoOqPwnSaND4DqEsAPltHY5qssT7sCC5eus=
X-Google-Smtp-Source: AGHT+IEwND9M7VO7/WvljXI2LkdyYkBWXrMc78AOnO5Yy2f188cHytXGCJUcSMPofMbbHxEIERaiHQ==
X-Received: by 2002:a2e:9a14:0:b0:372:8d1d:6952 with SMTP id 38308e7fff4ca-37797986b26mr2895401fa.41.1760631158889;
        Thu, 16 Oct 2025 09:12:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d1esm55681011fa.31.2025.10.16.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:12:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 16 Oct 2025 18:12:36 +0200
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPEZdHJlNOofy5tm@milan>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
 <aO9pUS3zLHsap81f@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO9pUS3zLHsap81f@fedora>

On Wed, Oct 15, 2025 at 02:28:49AM -0700, Vishal Moola (Oracle) wrote:
> On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > > Running 1000 iterations of allocations on a small 4GB system finds:
> > > 
> > > 1000 2mb allocations:
> > > 	[Baseline]			[This patch]
> > > 	real    46.310s			real    34.380s
> > > 	user    0.001s			user    0.008s
> > > 	sys     46.058s			sys     34.152s
> > > 
> > > 10000 200kb allocations:
> > > 	[Baseline]			[This patch]
> > > 	real    56.104s			real    43.946s
> > > 	user    0.001s			user    0.003s
> > > 	sys     55.375s			sys     43.259s
> > > 
> > > 10000 20kb allocations:
> > > 	[Baseline]			[This patch]
> > > 	real    0m8.438s		real    0m9.160s
> > > 	user    0m0.001s		user    0m0.002s
> > > 	sys     0m7.936s		sys     0m8.671s
> > 
> > I'd be more confident in the 20kB numbers if you'd done 10x more
> > iterations.
> 
> I actually ran my a number of times to mitigate the effects of possibly
> too small sample sizes, so I do have that number for you too:
> 
> [Baseline]			[This patch]
> real    1m28.119s		real    1m32.630s
> user    0m0.012s		user    0m0.011s
> sys     1m23.270s		sys     1m28.529s
> 
I have just had a look at performance figures of this patch. The test
case is 16K allocation by one single thread, 1 000 000 loops, 10 run:

sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=4

BOX: AMD Milan, 256 CPUs, 512GB of memory

# default 16K alloc
[   15.823704] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955334 usec
[   17.751685] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1158739 usec
[   19.443759] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1016522 usec
[   21.035701] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 911381 usec
[   22.727688] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 987286 usec
[   24.199694] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955112 usec
[   25.755675] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 926393 usec
[   27.355670] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 937875 usec
[   28.979671] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1006985 usec
[   30.531674] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 941088 usec

# the patch 16K alloc
[   44.343380] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2296849 usec
[   47.171290] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2014678 usec
[   50.007258] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2094184 usec
[   52.651141] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1953046 usec
[   55.455089] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2209423 usec
[   57.943153] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1941747 usec
[   60.799043] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2038504 usec
[   63.299007] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1788588 usec
[   65.843011] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2137055 usec
[   68.647031] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2193022 usec

2X slower.

perf-cycles, same test but on 64 CPUs:

+   97.02%     0.13%  [test_vmalloc]    [k] fix_size_alloc_test
-   82.11%    82.10%  [kernel]          [k] native_queued_spin_lock_slowpath
     26.19% ret_from_fork_asm
        ret_from_fork
      - kthread
         - 25.96% test_func
            - fix_size_alloc_test
               - 23.49% __vmalloc_node_noprof
                  - __vmalloc_node_range_noprof
                     - 54.70% alloc_pages_noprof
                          alloc_pages_mpol
                          __alloc_frozen_pages_noprof
                          get_page_from_freelist
                          __rmqueue_pcplist
                     - 5.58% __get_vm_area_node
                          alloc_vmap_area
               - 20.54% vfree.part.0
                  - 20.43% __free_frozen_pages
                       free_frozen_page_commit
                       free_pcppages_bulk
                       _raw_spin_lock_irqsave
                       native_queued_spin_lock_slowpath
         - 0.77% worker_thread
            - process_one_work
               - 0.76% vmstat_update
                    refresh_cpu_vm_stats
                    decay_pcp_high
                    free_pcppages_bulk
                    _raw_spin_lock_irqsave
                    native_queued_spin_lock_slowpath
+   76.57%     0.16%  [kernel]          [k] _raw_spin_lock_irqsave
+   71.62%     0.00%  [kernel]          [k] __vmalloc_node_noprof
+   71.61%     0.58%  [kernel]          [k] __vmalloc_node_range_noprof
+   62.35%     0.06%  [kernel]          [k] alloc_pages_mpol
+   62.27%     0.17%  [kernel]          [k] __alloc_frozen_pages_noprof
+   62.20%     0.02%  [kernel]          [k] alloc_pages_noprof
+   62.10%     0.05%  [kernel]          [k] get_page_from_freelist
+   55.63%     0.19%  [kernel]          [k] __rmqueue_pcplist
+   32.11%     0.00%  [kernel]          [k] ret_from_fork_asm
+   32.11%     0.00%  [kernel]          [k] ret_from_fork
+   32.11%     0.00%  [kernel]          [k] kthread

I would say the bottle-neck is a page-allocator. It seems high-order
allocations are not good for it.

--
Uladzislau Rezki

