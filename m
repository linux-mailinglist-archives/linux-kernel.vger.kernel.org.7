Return-Path: <linux-kernel+bounces-827892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10677B935E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C85219C0BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF22F7ABE;
	Mon, 22 Sep 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ua5mBLSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF02F6561
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576189; cv=none; b=BCFfUv+SCIlvSTbeSFyZnC511SghHC2F1lF9WkdgDB0akUJDYk6hgbdHoSpcF0uK0HpwORA3B4ok8zX+hyClLJ9bdyHeABwfPqbAV65KWRlF3XdGW/jhLzcjIFeLEij3MTpyGGcuCCvyBnz0fM9OwRIkFhTfvz/VbjLOBt7NXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576189; c=relaxed/simple;
	bh=YIJZv7/h0GsyGJwWQh9Ro75daSezB/fib8mlDVLM5SY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YxGxkNaJvKQNKY8aXVFlWdWJXhxHnfD7GqmP0CXq2tlVv56fm9MOwMxITTW+LLuCUxm8eSLE/wDsQA9gc5T6xpaOSMcauwiyY7oNRoOt/ZfVHYxgDEZhPflCmFxS8KuQrvQO8obSCtDQa94s/har3jwT3fIhIdwr0jzmISclBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ua5mBLSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CE3C4CEF5;
	Mon, 22 Sep 2025 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758576189;
	bh=YIJZv7/h0GsyGJwWQh9Ro75daSezB/fib8mlDVLM5SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ua5mBLSK2YXIEzSHlfOiL2ItM6FhaYpUTjODNC6xqEN+/kHfZMXMNfTrT4x9TXaZG
	 sJoR09urv+5Xy+T7xdnecDXvmczqPRKIYIJ77DgTz05TKWSSgIduHFMkfFu3wvgtcL
	 79YTB5bYcJ0ezc1l8FuqQe8Y9kGlPPShW0rwlPdU=
Date: Mon, 22 Sep 2025 14:23:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris
 Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav
 <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250922142308.144ac7bd7bbcb9f5a68ac3a1@linux-foundation.org>
In-Reply-To: <CA+CK2bDFScwAwyKA2NNkQhvhrj5OsmHm4eTshw2B9e2muqBcvg@mail.gmail.com>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<CA+CK2bDFScwAwyKA2NNkQhvhrj5OsmHm4eTshw2B9e2muqBcvg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 10:17:56 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> > +struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
> > +{
> > +       const unsigned long start_pfn = PHYS_PFN(phys);
> > +       const unsigned long end_pfn = start_pfn + nr_pages;
> > +       unsigned long pfn = start_pfn;
> > +
> > +       while (pfn < end_pfn) {
> > +               const unsigned int order =
> > +                       min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> > +               struct page *page = kho_restore_page(PFN_PHYS(pfn));
> 
> This line breaks linux-next build because, kho_restore_page has a prototype:
> void kho_restore_page(struct page *page, unsigned int order).

Thanks.  I think that's all fixed up in mm.git's current mm-nonmm-unstable branch.

