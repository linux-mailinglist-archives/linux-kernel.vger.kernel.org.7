Return-Path: <linux-kernel+bounces-817723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9527B585AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA9D3AA996
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84328D830;
	Mon, 15 Sep 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZk1KD2s"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4728D850
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966429; cv=none; b=HJFwMtAVBpc6t7RPVbJ8CtRqonqJeKN7nkrT/YVWUBgOyXw0kM1Iezg+dcFtN5EkSqr/Q06CRDrX1IalHHFV9zK2i44ebjA55EK9gIsAhyl7dNCaUc+W9d9+JZK9UTeHmWeK8hon6PcqVRPZBCSI+BqzJS6tKoHTAEAX0zy+WmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966429; c=relaxed/simple;
	bh=efGajNXgoK+8+uQac25CZ0SfnEka0rfA5Yzxd2VuGF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgtSIM/8/E6e++qcc+oxWcL1wqxoAoRtuvF2answcvV9kZ0pjK13PPDESHBcwSRXiCZt9Bl40kY/YuLqD6vyXmfYI6XF0LdDdONxFJc+BVWrFkAAPNngtZD+g+GY1IBLOcnGnnKhcyTHLrH4iduThoZQKBTYLH3elArzFjerzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eZk1KD2s; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Sep 2025 13:00:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757966423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFAzIzkGyy83vkY5iLmnI1QK7ML7+RNPnvuPL8o2hhg=;
	b=eZk1KD2s7qbkOKSDSTmkSAP9qY0RlH1GWtoJr5jNgQB+oYXB8AwMWcuKEGGGb1IO62O+e6
	t5LJo9/9fyQ6LrHi9Smyu1Nnk4xHZiGj91g+FFTrAeA8GLX1adPhyfsxmJ+xtSIzPg2W4n
	INbMHMugd21QVTN0doHgllBfgqUWYaQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, willy@infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
Message-ID: <giqlfqh3itraeh5w5aofkrhnae7kglc53f3uzbe357chk22blh@xx2tqnp6dmch>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
 <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 13, 2025 at 11:24:35AM +0800, Baolin Wang wrote:
> 
> 
> On 2025/9/13 00:13, Shakeel Butt wrote:
> > On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
> > > Currently, we no longer attempt to write back filesystem folios in pageout(),
> > > and only tmpfs/shmem folios and anonymous swapcache folios can be written back.
> > > Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
> > > which means no fs-private private data is used. Therefore, we can remove the
> > > redundant folio_test_private() checks and related buffer_head release logic.
> > > 
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > ---
> > >   mm/vmscan.c | 16 +---------------
> > >   1 file changed, 1 insertion(+), 15 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index f1fc36729ddd..8056fccb9cc4 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
> > >   	 * swap_backing_dev_info is bust: it doesn't reflect the
> > >   	 * congestion state of the swapdevs.  Easy to fix, if needed.
> > >   	 */
> > > -	if (!is_page_cache_freeable(folio))
> > > +	if (!is_page_cache_freeable(folio) || !mapping)
> > >   		return PAGE_KEEP;
> > > -	if (!mapping) {
> > > -		/*
> > > -		 * Some data journaling orphaned folios can have
> > > -		 * folio->mapping == NULL while being dirty with clean buffers.
> > > -		 */
> > 
> > Can this case not happen anymore and try_to_free_buffers is not needed?
> 
> For dirty file folios, pageout() will return PAGE_KEEP and put them back on
> the LRU list. So even if mapping = NULL, background workers for writeback
> will continue to handle them, rather than in shrink_folio_list().
> 
> For clean file folios, the !mapping case will be be handled later in
> shrink_folio_list(), please see the following comments:
> 
> /*
>  * If the folio has buffers, try to free the buffer
>  * mappings associated with this folio. If we succeed
>  * we try to free the folio as well.
>  *
>  * We do this even if the folio is dirty.
>  * filemap_release_folio() does not perform I/O, but it
>  * is possible for a folio to have the dirty flag set,
>  * but it is actually clean (all its buffers are clean).
>  * This happens if the buffers were written out directly,
>  * with submit_bh(). ext3 will do this, as well as
>  * the blockdev mapping.  filemap_release_folio() will
>  * discover that cleanness and will drop the buffers
>  * and mark the folio clean - it can be freed.
>  *
>  * Rarely, folios can have buffers and no ->mapping.
>  * These are the folios which were not successfully
>  * invalidated in truncate_cleanup_folio().  We try to
>  * drop those buffers here and if that worked, and the
>  * folio is no longer mapped into process address space
>  * (refcount == 1) it can be freed.  Otherwise, leave
>  * the folio on the LRU so it is swappable.
>  */
> 

Thanks a lot for the explanation, yes this makes sense.

With that, please add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

