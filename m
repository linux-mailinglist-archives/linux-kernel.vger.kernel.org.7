Return-Path: <linux-kernel+bounces-775435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F692B2BF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F2C174786
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE0C322C60;
	Tue, 19 Aug 2025 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7pHrA4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462225BEF8;
	Tue, 19 Aug 2025 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599964; cv=none; b=VX7R5aSQTlakfOLQYLpubtQcIM2RSGJ3oHlkytRjQHnKXqmUz44zpFPaRSroYBb6Ey2wEP2U+4R6gaJeOmdW286FcSPb+Y9DufqAeokKT6s6pJwIgCDHHyIO13hTz6FVMlH0Euyk0NAYDWgoEJXzwbu+VrXBD9Pc+YjQUf65TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599964; c=relaxed/simple;
	bh=C3p/9tmSjjIf5jIYjuZ3vrujwfpwDa8Gx8cZIkEqXH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpNkLeV81lNa4DTmEiUnixAHOD6U7p9bRdvV9M44udOECzwuQX1VtiCbyd0PGUZuacBKPzoUIrhOG7L9+EJpcqq32nImePGPWnJoZe8SodW2Qdeg2ROa0Aw0YqIEsb0cOpkXxmmE7AMCOul4sKKaxIaQmrTJobFYEN6/ncu6Zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7pHrA4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B851EC4CEF1;
	Tue, 19 Aug 2025 10:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755599964;
	bh=C3p/9tmSjjIf5jIYjuZ3vrujwfpwDa8Gx8cZIkEqXH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7pHrA4jSdouObZRf5BBF4zPfFQZpkvTr3HvXjroPz2apoCJKu9JXovzqRcsFf2zN
	 RxUoa8NbRRdr+TQxroiXzSSImFDGYRFd3fxbcgibPcZAOQIVuNyg8Qh4uyYi1dxYBz
	 rvH9cUP3sb7qPSGDLzYXl9D42w/VOc/OEXmeItlziBzmo9eXB/mBjs+as+69qT+TvM
	 PZ57tEyT75kHH2htMbXdQEBacH8gEEzvLTZBjZTHxE6rLef9y8O7V+klQjdwQ8j833
	 ar1xQpPVlR9PmVzi5Z05JRXWCQyaAdvGXwOTjOpFCgZ/dZ8+r0XKu2dkuM9/2UWmbv
	 InJbnYCAV2UUA==
Date: Tue, 19 Aug 2025 13:39:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 3/4] mm/mm_init: drop deferred_init_maxorder()
Message-ID: <aKRUUzq48xW5qPOp@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-4-rppt@kernel.org>
 <408d7eaa-5aea-4490-9fd0-978c4eb94d32@redhat.com>
 <20250819092254.cddlg6npwl75fvbn@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819092254.cddlg6npwl75fvbn@master>

On Tue, Aug 19, 2025 at 09:22:54AM +0000, Wei Yang wrote:
> On Tue, Aug 19, 2025 at 09:54:22AM +0200, David Hildenbrand wrote:
> >> -static unsigned long __init
> >> -deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> >> -			   struct zone *zone)
> >> -{
> >> -	unsigned long nr_pages = 0;
> >> -	unsigned long spfn, epfn;
> >> -	u64 i = 0;
> >> +		while (spfn < epfn) {
> >> +			unsigned long mo_pfn = ALIGN(spfn + 1, MAX_ORDER_NR_PAGES);
> >> +			unsigned long chunk_end = min(mo_pfn, epfn);
> >> -	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
> >> +			nr_pages += deferred_init_pages(zone, spfn, chunk_end);
> >> +			deferred_free_pages(spfn, chunk_end - spfn);
> >
> >
> >I assume the expectation is that all PFNs in the start_pfn -> end_pfn range
> >will go to this zone, correct?
> 
> I think so.
> 
> defer_init only apply to the highest zone in one node.

Right, we defer initialization of last zone in every node and there is a
thread per node that does the initialization.

-- 
Sincerely yours,
Mike.

