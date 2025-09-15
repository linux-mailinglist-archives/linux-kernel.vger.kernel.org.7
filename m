Return-Path: <linux-kernel+bounces-817148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B5B57E76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FDD17F3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355F31AF1B;
	Mon, 15 Sep 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu/aNln+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623421EA7C9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945555; cv=none; b=Jo/frwCnC9jIIE5BvT/vrQRqq2lE1+pLisnY9xdBGvagJnWxqPCTWd4n5qHdCH87kzLseALVlCOkR4UL+N/b7PldRaVCDxj4qT/X7MYMJmshAjFMFIWugqf4aTslXO3HClqqL6B4/wUXmPbkTwLZly4gjFNWZxw2zU2o2XtrYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945555; c=relaxed/simple;
	bh=7vkrO2WxsSWGdp6lM9Hcz4HCTPOoXFcwzPiEHHmzBQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvujoYJC06GJPjAt8T2pWVzqR9+s0ZvNVpYuy5Pjf+JhfVq0k/MH43+D0RtJkLdzCmy5Tt96NmFu63kPir6AY0Ntv6aJpdFDpZXYJBQ5B+k+vbwYv5mM9FMt+Y5Ow6Oa7JcraZ4mQoUoOriW86Da+bqKPBbdVQul3sc5oAPMw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu/aNln+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C51C4CEF7;
	Mon, 15 Sep 2025 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945555;
	bh=7vkrO2WxsSWGdp6lM9Hcz4HCTPOoXFcwzPiEHHmzBQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xu/aNln+imqUsri9j70nV1KvIF4p98dag6M1lNrYGxFUCD6+B9Q9QdE+IbvcpraDj
	 +tvp2RSzHST/mVvGyQn8g8yRaufswSezFjAc4r0HllLrMgfd/7TBLoajKncb+rOgnx
	 yf07xYdO5umarJHmhwO/k1CpW/xc7Regd+H6FDUHfeGUpyQiv7VCYgn3gZfQSlySgg
	 jo9tLBPVco4L9uJ32BP50/ILm8XYr79T7+QRJ+dL7fplFJsRWgRZAlnTz+9afjJrA5
	 3xlojUa5SVh4qtR6CZGxV/bxvIjXFPfqfcTczB+NwgfPFp4F4u0eDokpq/HrcukpXn
	 ggk/7yST2yjAQ==
Date: Mon, 15 Sep 2025 17:12:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMgey9qEC_XUejXm@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ldmnlmq0.fsf@yadavpratyush.com>

On Tue, Sep 09, 2025 at 04:33:27PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> Couple more thoughts.
> 
> On Mon, Sep 08 2025, Pratyush Yadav wrote:
> > On Mon, Sep 08 2025, Mike Rapoport wrote:
> >> +
> >> +	while (chunk) {
> >> +		struct page *page;
> >> +
> >> +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
> >> +			phys_addr_t phys = chunk->phys[i];
> >> +
> >> +			for (int j = 0; j < (1 << order); j++) {
> >> +				page = phys_to_page(phys);
> >> +				kho_restore_page(page, 0);
> >> +				pages[idx++] = page;
> >
> > This can buffer-overflow if the previous kernel was buggy and added too
> > many pages. Perhaps keep check for this?
> 
> Thinking about this a bit more, I think this should check that we found
> _exactly_ chunk->hdr.total_pages pages, and should error out otherwise.
> If too few are found, pages array will contain bogus data, if too many,
> buffer overflow.

Sure, I can add the checks, but it feels superfluous to me.
 
> Also, I am not a fan of using kho_restore_page() directly. I think the
> vmalloc preservation is a layer above core KHO, and it should use the
> public KHO APIs. It really doesn't need to poke into internal APIs. If
> any of the public APIs are insufficient, we should add new ones.
> 
> I don't suppose I'd insist on it, but something to consider since you
> are likely going to do another revision anyway.

I think vmalloc is as basic as folio. At some point we probably converge to 
kho_preserve(void *) that will choose the right internal handler. like
folio, vmalloc, kmalloc etc.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

