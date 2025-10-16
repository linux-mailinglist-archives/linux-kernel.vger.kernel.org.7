Return-Path: <linux-kernel+bounces-856721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3994BE4E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58AF44E5241
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31963A8F7;
	Thu, 16 Oct 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke080ekA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755D33469A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636531; cv=none; b=WFJyFwYUcLG/rm7jcRfs56P7FhGmJgboBboClL8qyl8Ni1cSHvMQoOFHTj12qGMmkW0g4pijgZO1ezSP5MH1wPuItzpnApIsnZd68+DMJ6bGD36NdaVg199lVk5OEqzM50E+Jt5U/udg8/5YywI/5+DEClhRv9TdjRD5sDbGlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636531; c=relaxed/simple;
	bh=Cu6FRtEvltMPbkvYmk+FO1lsRB33AFmG7lpktdbPJ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRgDFbodlZOCe28DR5dR0anOiRXdAftJ8PNrVNjXoq3Ycg9/FpznYdbEukMpKLw2W2SJCAFtlAJ0PFhqZCIBP9azigXSqSl0alPZBrVj9eC9qW/QTLOs1lNbYNemRSWPbLL130aqoYTvGRh7zDVhBIMegqizZHVFloIYZ6mkis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke080ekA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471131d6121so7882925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760636527; x=1761241327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2Q7pcup/Lsb81kvRC7mU77d52O8r0BSQzF+Rjf52UY=;
        b=Ke080ekABNnAHdsfQu/w1ZdMyqnjWXkxytDIZA+uSGuJ7jWLFbvx436PbbUrI303qX
         r8VgeVf1TY/xfZfEVJrXQfjGKHVgIk9kHw1E3dBOweZ0coipVeVjr3AIYotqvDpHisIz
         RFHD5/0TAdaJph66SHaOsuww9DhUbUqNNs0TUlCnDLrKe7S/1dfjoEAqogSuSNdc4BEw
         PEs9BYR8N9Gq/GGtqao5X+ixh6MTp+ySZMsQLA42SxVvRxUDJ34tdr03Y/VC67z2l3AN
         mnlCIUjcdo5BStzrQiUWE7dO3DbC3nMxSquCOEWcWVZ4OSJ+7kxBFC+xN2/r11BVMSP+
         fAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636527; x=1761241327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2Q7pcup/Lsb81kvRC7mU77d52O8r0BSQzF+Rjf52UY=;
        b=fozGfbWWKjzr3rQgjTxoI9tNx2XimhsOeWhFcW4u+iV7LGacpUmjQ8sp6rXOfECINY
         Fo9R8kdDKq8tjnlTpNoO6a7X5baKFxmCTX8GNhmSZI8Aq47GL0LdyfLzXyfcOsTRDQds
         7zOV4X2Q6YCz2qicYitbMiNkhRMF933xzodB6DA3Vseg9JkluUBjK99agJpEcHWoCTW0
         eFocoQ96fljbzoWYqCagC68DNLeRRIFgXkln+4TK0mFJJcKwdjfmJDibQLtzbcYrvnbn
         149nmBsSrsWpcEu5GIlnkQ+DENT6jLMv9rQFO0KzZK/T0xtfA5Na9ueAATKfxWiwPEGf
         90Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWlpOTurrhGWYjuDtWcS9T8Y8evbjlu1HMGMRfJ9Rix/xHGA9YBNlib3ZwPInB0p7fFDYLCzBC49R5wzDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SMYIbsDW8VpsSCKbY+fN29Ra1fY9Pon3Wq0if+zcvbfTAfmK
	wsYhTXIA78xzadh9zSe5ob99dwOjnNCS5W3LF9YFvmJrAHG2oCwjzTi7+btVNJOiBTk=
X-Gm-Gg: ASbGncvPANETr3I3lUVyJ8ECJZ8xk6xl1zy5N5AUYPoOmcGcoMTOp1W6Wq1qeoZcsoH
	7cFMrPo4vDPuQ7zZ3bZQahT9TEChXYY+oZjscxr8n/lTFkHysW9p4Q2sgfYCZQxPXEFUDXBhhkI
	5wYSqbyIEz8Iy929Nu/i/slRhIYgjFErnuo2VStjS5tJV6TUG54NEcYITaFfMPvkSIY+zjdzWQ6
	oYUQTGr/370VJJhMmKsr4bTGpWaiWtBFZRcdkt8dFZhOt9nsaJDxc0GlTA5mwT7pa8qD+tIfklF
	tnEe4DQU2lvHsdNK9d1lcxgjzQ1ZPNF8Qo5TwpITRJTDHq9BSA6p7SCWJ1W27kmogb3XhXxbjK5
	UjK0iAmA3YlxMouwoz7v7ECh4eR70YMBfDKbjGWVOzTcHpTSd+pBkT2ekZUwaJXHzotwH9ASAan
	WB+Z0QyA==
X-Google-Smtp-Source: AGHT+IFMjQaDJpjCZS2noIhc81rQXZOk7Twbvcm9hhW+VNbrmylgy3Qpo3DO9zp4G74w1uQ0e6XBiQ==
X-Received: by 2002:a05:6000:400a:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42704d1460fmr594857f8f.9.1760636527217;
        Thu, 16 Oct 2025 10:42:07 -0700 (PDT)
Received: from fedora ([31.94.20.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427013f9b58sm4284463f8f.51.2025.10.16.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:42:06 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:42:04 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm/vmalloc: request large order pages from buddy
 allocator
Message-ID: <aPEubI4kWvzSC5RN@fedora>
References: <20251014182754.4329-1-vishal.moola@gmail.com>
 <aO8behuGn5jVo28K@casper.infradead.org>
 <aO9pUS3zLHsap81f@fedora>
 <aPEZdHJlNOofy5tm@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEZdHJlNOofy5tm@milan>

On Thu, Oct 16, 2025 at 06:12:36PM +0200, Uladzislau Rezki wrote:
> On Wed, Oct 15, 2025 at 02:28:49AM -0700, Vishal Moola (Oracle) wrote:
> > On Wed, Oct 15, 2025 at 04:56:42AM +0100, Matthew Wilcox wrote:
> > > On Tue, Oct 14, 2025 at 11:27:54AM -0700, Vishal Moola (Oracle) wrote:
> > > > Running 1000 iterations of allocations on a small 4GB system finds:
> > > > 
> > > > 1000 2mb allocations:
> > > > 	[Baseline]			[This patch]
> > > > 	real    46.310s			real    34.380s
> > > > 	user    0.001s			user    0.008s
> > > > 	sys     46.058s			sys     34.152s
> > > > 
> > > > 10000 200kb allocations:
> > > > 	[Baseline]			[This patch]
> > > > 	real    56.104s			real    43.946s
> > > > 	user    0.001s			user    0.003s
> > > > 	sys     55.375s			sys     43.259s
> > > > 
> > > > 10000 20kb allocations:
> > > > 	[Baseline]			[This patch]
> > > > 	real    0m8.438s		real    0m9.160s
> > > > 	user    0m0.001s		user    0m0.002s
> > > > 	sys     0m7.936s		sys     0m8.671s
> > > 
> > > I'd be more confident in the 20kB numbers if you'd done 10x more
> > > iterations.
> > 
> > I actually ran my a number of times to mitigate the effects of possibly
> > too small sample sizes, so I do have that number for you too:
> > 
> > [Baseline]			[This patch]
> > real    1m28.119s		real    1m32.630s
> > user    0m0.012s		user    0m0.011s
> > sys     1m23.270s		sys     1m28.529s
> > 
> I have just had a look at performance figures of this patch. The test
> case is 16K allocation by one single thread, 1 000 000 loops, 10 run:
> 
> sudo ./test_vmalloc.sh run_test_mask=1 nr_threads=1 nr_pages=4

The reason I didn't use this test module is the same concern Matthew
brought up earlier about testing the PCP list rather than buddy
allocator. The test module allocates, then frees over and over again,
making it incredibly prone to reuse the pages over and over again.

> BOX: AMD Milan, 256 CPUs, 512GB of memory
> 
> # default 16K alloc
> [   15.823704] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955334 usec
> [   17.751685] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1158739 usec
> [   19.443759] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1016522 usec
> [   21.035701] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 911381 usec
> [   22.727688] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 987286 usec
> [   24.199694] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 955112 usec
> [   25.755675] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 926393 usec
> [   27.355670] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 937875 usec
> [   28.979671] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1006985 usec
> [   30.531674] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 941088 usec
> 
> # the patch 16K alloc
> [   44.343380] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2296849 usec
> [   47.171290] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2014678 usec
> [   50.007258] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2094184 usec
> [   52.651141] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1953046 usec
> [   55.455089] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2209423 usec
> [   57.943153] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1941747 usec
> [   60.799043] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2038504 usec
> [   63.299007] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 1788588 usec
> [   65.843011] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2137055 usec
> [   68.647031] Summary: fix_size_alloc_test passed: 1 failed: 0 xfailed: 0 repeat: 1 loops: 1000000 avg: 2193022 usec
> 
> 2X slower.
> 
> perf-cycles, same test but on 64 CPUs:
> 
> +   97.02%     0.13%  [test_vmalloc]    [k] fix_size_alloc_test
> -   82.11%    82.10%  [kernel]          [k] native_queued_spin_lock_slowpath
>      26.19% ret_from_fork_asm
>         ret_from_fork
>       - kthread
>          - 25.96% test_func
>             - fix_size_alloc_test
>                - 23.49% __vmalloc_node_noprof
>                   - __vmalloc_node_range_noprof
>                      - 54.70% alloc_pages_noprof
>                           alloc_pages_mpol
>                           __alloc_frozen_pages_noprof
>                           get_page_from_freelist
>                           __rmqueue_pcplist
>                      - 5.58% __get_vm_area_node
>                           alloc_vmap_area
>                - 20.54% vfree.part.0
>                   - 20.43% __free_frozen_pages
>                        free_frozen_page_commit
>                        free_pcppages_bulk
>                        _raw_spin_lock_irqsave
>                        native_queued_spin_lock_slowpath
>          - 0.77% worker_thread
>             - process_one_work
>                - 0.76% vmstat_update
>                     refresh_cpu_vm_stats
>                     decay_pcp_high
>                     free_pcppages_bulk
>                     _raw_spin_lock_irqsave
>                     native_queued_spin_lock_slowpath
> +   76.57%     0.16%  [kernel]          [k] _raw_spin_lock_irqsave
> +   71.62%     0.00%  [kernel]          [k] __vmalloc_node_noprof
> +   71.61%     0.58%  [kernel]          [k] __vmalloc_node_range_noprof
> +   62.35%     0.06%  [kernel]          [k] alloc_pages_mpol
> +   62.27%     0.17%  [kernel]          [k] __alloc_frozen_pages_noprof
> +   62.20%     0.02%  [kernel]          [k] alloc_pages_noprof
> +   62.10%     0.05%  [kernel]          [k] get_page_from_freelist
> +   55.63%     0.19%  [kernel]          [k] __rmqueue_pcplist
> +   32.11%     0.00%  [kernel]          [k] ret_from_fork_asm
> +   32.11%     0.00%  [kernel]          [k] ret_from_fork
> +   32.11%     0.00%  [kernel]          [k] kthread
> 
> I would say the bottle-neck is a page-allocator. It seems high-order
> allocations are not good for it.
> 
> --
> Uladzislau Rezki

