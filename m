Return-Path: <linux-kernel+bounces-883386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA1C2D4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A7A4638AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FC31A550;
	Mon,  3 Nov 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LwXOJc1f"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB5319877
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188672; cv=none; b=iB4ws75PdbuySVut+ujxk6PjNt0rKVWRzpFauuKkf/Ts5cSULAM0BfVIiqvOK1jRiM5CpYzr0fnMTXYb9ZVx0L1URxnc4itckqVFrq197T7ZaeQvj41l5HO/TXFnnbxSS+7MIfW6xqvC4WPCbCIQMC3cZMlyIDEgTcIVqzo1VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188672; c=relaxed/simple;
	bh=U1CZQvGZlStQTkWZUdO8PikaUYvoR7RVMCWF9NnIGm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPgckkPOFCe9bTx/lFa23K+NWJoTV6i3IbmH2C89CYh759NfGa8tJEIpp8z93UPevzzmlKLbHhTR8xgoii1yBfZssagx6iDRCWuAi6BQ+7YVluHxCHgE+Pydl9ugf6QoRpWt6yZWi0mkX73gJ0nIoyek6A1w1Zmqvn4RhpbWg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LwXOJc1f; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Nov 2025 16:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762188664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K607a5Gs7qbahtSC1e+NSqHSnCO3TxUx9UKukeyvNPg=;
	b=LwXOJc1f/K6nb9wVO4GrLcftfn/ho3nwgJUxumOCpurUvQXx/93i+UNBV5Yq2bbZt7nvAw
	fMmzfMUc1I/3+ppcS733aXLz+px5KKfFl/WleoOFYiWgdyYLV+Z7APCP8bdRcshyLwBq9s
	F69Azfl+0DfAJts9qaYrtJW/yoECpf0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] mm/swap: rename __read_swap_cache_async to
 swap_cache_alloc_folio
Message-ID: <2gzofxcv3vbfd5l22drj6p67huf533nq6g2hnurr74ewbrp2gx@f7i6qabbuxng>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-1-3d43f3b6ec32@tencent.com>
 <ufy26fqfvaxqjywneec3hcuky7ozpa2fm63pxcuuberrvicffv@bkblomeix35w>
 <CAGsJ_4x1P0ypm70De7qDcDxqvY93GEPW6X2sBS_xfSUem5_S2w@mail.gmail.com>
 <CAMgjq7A+OBoH71qo=Vt65BeV7M9uOvkJ+9pQX2eq4-tqcKwVwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7A+OBoH71qo=Vt65BeV7M9uOvkJ+9pQX2eq4-tqcKwVwg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 03, 2025 at 05:02:28PM +0800, Kairui Song wrote:
> On Mon, Nov 3, 2025 at 4:28 PM Barry Song <baohua@kernel.org> wrote:
> > > > +/**
> > > > + * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
> > > > + * @entry: the swapped out swap entry to be binded to the folio.
> > > > + * @gfp_mask: memory allocation flags
> > > > + * @mpol: NUMA memory allocation policy to be applied
> > > > + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> > > > + * @new_page_allocated: sets true if allocation happened, false otherwise
> > > > + * @skip_if_exists: if the slot is a partially cached state, return NULL.
> > > > + *                  This is a workaround that would be removed shortly.
> > > > + *
> > > > + * Allocate a folio in the swap cache for one swap slot, typically before
> > > > + * doing IO (swap in or swap out). The swap slot indicated by @entry must
> > > > + * have a non-zero swap count (swapped out). Currently only supports order 0.
> 
> Hi Yosry and Barry, thanks for the review.
> 
> > >
> > > Is it used for swap in? That's confusing because the next sentence
> > > mention that it needs to be already swapped out.
> 
> Yes, swap in is the typical user, swap_vma_readahead calls this
> function directly, allocate a folio then initiate the swap in IO.
> 
> I'm not sure why it is confusing. A swapped out slot getting swapped
> in seems a very common thing?

I mixed up swapping in and swapping out :) I was complaining about
mentioning "swapping out", not vice versa. Sorry for the confusion.

> 
> > >
> > > I suspect you're referring to the zswap writeback use case, but in this
> > > case we're still "swapping-in" the folio from zswap to swap it out to
> > > disk. I'd avoid mentioning swap in here because it's confusing.
> 
> Oh, I thought the zswap writeback is considered a kind of swap out :),
> since it's technically writing data from ram to swap device.

We do swap the page out, but we use __read_swap_cache_async() to "swap
in" the page from zswap first.

> 
> >
> > I assume you mean avoiding any mention of swap-out? As for swap-out, we’re
> > swapping a folio out from the LRU — we’re not allocating a new folio.
> >
> > BTW, this sentence also feels a bit odd to me. I’d prefer removing
> > “swap out” from
> > “doing IO (swap in or swap out)”.
> 
> How about "doing IO (e.g. swap in or zswap writeback)"? Swap-in is a
> very common user, and zswap writeback can be mentioned explicitly.

Looks good to me. Thanks.

