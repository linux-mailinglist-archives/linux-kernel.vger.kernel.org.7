Return-Path: <linux-kernel+bounces-793539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D90FB3D4EA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF04D189B313
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196A2750E3;
	Sun, 31 Aug 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HXaM8cag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC919D89E;
	Sun, 31 Aug 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668253; cv=none; b=nxcZus0St4yV+fPWGsfyUYDJ/GzOTOSbNuNEDRP7eM1rT08jJUoJ58sNGND2cBxqJ0rTH5WwXElHj2bznm2823ZkAyTo44ZjxnGDXhEH2un07Zs04PzE4RIGcqEljFAbShsA/xYlp5Gnw8xs1flEV/Jij4oICcB04vCvfzemtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668253; c=relaxed/simple;
	bh=M5hUqZj2bhXJOyicZDtMiFAzUXOvG+Rj16wszrq7TwI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D/MngxXfHWwF0H/5bn+R4Q0S+aK4E2uXb29VuTelAg0qnLdCYn3f2EeyHUYC81k9JgYdzplWvf3l1PW5UFtEi1+Mtn2aHcvT0i5RW6n39zvSGe0tvbboO+umOtU1aLQLLGiAdjHlt2x7otNhsgqmBnTNqDU7e74M0hY8yPoDNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HXaM8cag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2492C4CEED;
	Sun, 31 Aug 2025 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756668252;
	bh=M5hUqZj2bhXJOyicZDtMiFAzUXOvG+Rj16wszrq7TwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HXaM8cagIxYY57R5t0q+9xGVfy0aW/w8p/iSWjJMDBfD8kAoXNhsbz5p19zz4xbU5
	 4uhwBe1MLxF06pISTb8uzTcHG71ogjs4TD+aVBheZzVHyl/IMB5Fhf3m6Ch7jRddSo
	 MiuvQuAtpWC/0O2/mI0Vkweu5pyYqG3ksdXkR9n0=
Date: Sun, 31 Aug 2025 12:24:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, Baoquan He
 <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-Id: <20250831122410.fa3dcddb4a11757ebb16b376@linux-foundation.org>
In-Reply-To: <20250831121058.92971-1-urezki@gmail.com>
References: <20250831121058.92971-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 14:10:58 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> and always allocate memory using the hardcoded GFP_KERNEL flag. This
> makes them inconsistent with vmalloc(), which was recently extended to
> support GFP_NOFS and GFP_NOIO allocations.
> 
> Page table allocations performed during shadow population also ignore
> the external gfp_mask. To preserve the intended semantics of GFP_NOFS
> and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
> memalloc scope.
> 
> This patch:
>  - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
>  - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
>  - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
>    around apply_to_page_range();
>  - Updates vmalloc.c and percpu allocator call sites accordingly.
> 
> To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Why cc:stable?

To justify this we'll need a description of the userspace visible
effects of the bug please.  We should always provide this information
when fixing something.  Or when adding something.  Basically, all the
time ;)

Thanks.

