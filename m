Return-Path: <linux-kernel+bounces-884758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87103C31074
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C30318864CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419302EF664;
	Tue,  4 Nov 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmzUcDrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209D2EC54B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260076; cv=none; b=WSopaKYDF8FlB4BSUf8Pilcu6AFNB9AkMl1n9Xa1FvV3g3ws3rV0okCoZK74N3ZF13GV20tgahQb6VAJt/iIlj23VGGj6i0BrL+By8MBNOuXZqsKC3FxMd/Om0rZq3wQyXPbK5tO8O+xAP7Qs8y3lbMqAY8AfrIYKDfBKEzXgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260076; c=relaxed/simple;
	bh=8ymZxzZATI0ystLlUvVFK/P2C6papBtYAEpeRGinXiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggj4irhakUQS+kUpup+QwqZlUioptL5W01VvPXjuXoALU83m5MwGYPkO7smG4JCzYkC8WeEjGTJhJu67l10AQVJES9RMrhxcYS2wx/VGctk87cOo1CPB+EOytAdzP4ZlUy+2fEAAJNAD0dlaLnG99oYjI/ao0ITtKXXRd7ZbUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmzUcDrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F71C4CEF7;
	Tue,  4 Nov 2025 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762260076;
	bh=8ymZxzZATI0ystLlUvVFK/P2C6papBtYAEpeRGinXiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmzUcDrmIdY5KiWMDwfs92R2YM6cNepuEvZMrrs8BMxPUVX8h7zve3MLDkvWTvQZB
	 s6UfrJZCWdja9bAwSULLEvgR46b0sbn0FI6cq9Hks6j6G4qywl1xCvKZoFqGqmeek+
	 X4E2An3nCUoYp1mzypCPpBZp4W4XhTUUG7q9nK1kJ2pDxcS5wI/hsJnzQNOcK2KDAR
	 ujfOAeSy5U80PWzVDTRBlSibuVNF/+g2HYQPGM2NDB9UqTH/YeNlf9BiDjgr5ukAQ1
	 o6FjAgNyWXNNNu+I2VscTRx4esBXFv6MChFOriOYLCFILrfGl7FaomZnK/QT3oO1pp
	 2e3xNtkGOwt/Q==
Date: Tue, 4 Nov 2025 12:41:10 +0000
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, yang@os.amperecomputing.com, david@redhat.com,
	ardb@kernel.org, dev.jain@arm.com, scott@os.amperecomputing.com,
	cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v1] arm64: mm: Don't sleep in split_kernel_leaf_mapping()
 when in atomic context
Message-ID: <aQn0ZqCPSA61QmDI@willie-the-truck>
References: <20251103125738.3073566-1-ryan.roberts@arm.com>
 <aQjMUhspJrRQn5Ew@willie-the-truck>
 <3611cfeb-53d5-4db5-95a1-1d095edfc3c9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3611cfeb-53d5-4db5-95a1-1d095edfc3c9@arm.com>

Hey Ryan,

On Mon, Nov 03, 2025 at 04:28:44PM +0000, Ryan Roberts wrote:
> On 03/11/2025 15:37, Will Deacon wrote:
> > On Mon, Nov 03, 2025 at 12:57:37PM +0000, Ryan Roberts wrote:
> >> +static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> >> +{
> >> +	int ret;
> >> +
> >> +	arch_enter_lazy_mmu_mode();
> >> +	ret = walk_kernel_page_table_range_lockless(start, end,
> >> +					&split_to_ptes_ops, NULL, &gfp);
> >> +	arch_leave_lazy_mmu_mode();
> > 
> > Why are you entering/leaving lazy mode now? linear_map_split_to_ptes()
> > calls flush_tlb_kernel_range() right after this so now it looks like
> > we have more barriers than we need there.
> 
> Without the lazy mmu block, every write to every pte (or pmd/pud) will cause a
> dsb and isb to be emitted. With the lazy mmu block, we only emit a single
> dsb/isb at the end of the block.
> 
> linear_map_split_to_ptes() didn't previously have a lazy mmu block; that was an
> oversight, I believe. So when refactoring I thought it made sense to make it
> common for both cases.
> 
> Yes, the flush_tlb_kernel_range() also has the barriers, so the lazy mmu mode is
> reducing from a gazillion barriers to 2. We could further optimize from 2 to 1,
> but I doubt the performance improvement will be measurable.
> 
> Perhaps I've misunderstood your point...?

I was just trying to understand whether this was a functional thing (which
I couldn't grok) or an optimisation. Sounds like it's the latter, but I'd
prefer not to mix optimisations with fixes.

Will

