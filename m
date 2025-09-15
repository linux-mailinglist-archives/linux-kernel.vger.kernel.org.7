Return-Path: <linux-kernel+bounces-817759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5AB5862C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815A42A04EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8884F274FD3;
	Mon, 15 Sep 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mnvfexft"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B8EAC7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969240; cv=none; b=YkwS5rfSx3bC70TUfM8S+DAXqexXoSmJeGb2WAfwS8awTvnAsawzJuG51F5HsNdsqJGUbW/cQmfIsY12ZH91VykzxJAWBPnXYGfzktebsp44qAdwSXieGAJicPtVomyvCc26cTzTOluheMkzNw8YwwbbvEGO1Fr60ylbGfL+xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969240; c=relaxed/simple;
	bh=19Lt5UTvmFUNAK1WOTfD6mqn0xNznePgJBE+Oif+Gew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN4tmJ+K+oyxWTpmpWevNtNL+xrXY6r0h1pfP0Gq+3QLkqNL1uL9Za1H7gnqqqvhjywNGWPLwNlUHxravSLkepvX9lMTHyxTOxgJCWsWCRMN0BOWNWbKt8S3OESGRD+MS1VENqj+eB/HEtsiAeznEm7KVTtXLgXrDjD3p9rzW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mnvfexft; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MwTJRT4h1O6UaYWP0BlK79M2H5OP55Nu3v4YH0QgOj0=; b=Mnvfexft4nqDCE4G082SbkCDUa
	+01vaHcfEL7uMGPvqylZliQzmXDiVZZ7rYo/RBQnvPK/7ONXg6B7jg/gj+UAIc/Dp3Jr5Q3nhmN0x
	KHBx5ZiXwBar+6JtrHX952/k93KamnuGw/3vQIJ49rYZvJb+ZyfAXlSQOiykDsQOe5M+gHOzXPcJq
	gYkAYP8q/bkI9vVI65O4tFsWmRdS3Z6tLXzfeYkvuuLZOJEL5nFWZa1XmPfoPPip7Z4UNCk0D220v
	BTuJd1A+wqHjR9IYE7qzOU13T7Ajhf0i8gt7yuZzN7OkLkW3+O88FOr57QscjReGgJdZRIVld8a8X
	jN8liUaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyG6K-00000006bmk-1w1p;
	Mon, 15 Sep 2025 20:47:04 +0000
Date: Mon, 15 Sep 2025 21:47:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	mhocko@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
Message-ID: <aMh7SAlitp5FqR-M@casper.infradead.org>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <aMQ6bW-OoMWMVEFF@casper.infradead.org>
 <11629632-c652-460e-b617-3ec0c27969f5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11629632-c652-460e-b617-3ec0c27969f5@linux.alibaba.com>

On Sat, Sep 13, 2025 at 11:04:48AM +0800, Baolin Wang wrote:
> On 2025/9/12 23:21, Matthew Wilcox wrote:
> > On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
> > > @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
> > >   	 * swap_backing_dev_info is bust: it doesn't reflect the
> > >   	 * congestion state of the swapdevs.  Easy to fix, if needed.
> > >   	 */
> > > -	if (!is_page_cache_freeable(folio))
> > > +	if (!is_page_cache_freeable(folio) || !mapping)
> > >   		return PAGE_KEEP;
> > 
> > I feel like we need to keep the comment (assuming it's still true ...
> > which it probably is, although there's nobody who would think to update
> > this comment if it became no longer true).  I would certainly wonder why
> > we can have this !mapping test.
> 
> I think the !mapping check is still needed here because the tmpfs/shmem
> folios truncation might race with folio reclamation, see shmem_undo_range().

I agree that we still need the !mapping check.  But it needs this comment
that you're deleting, because it's not obvious why we'd have a dirty
folio with a NULL mapping on the LRU list.

> > > -		/*
> > > -		 * Some data journaling orphaned folios can have
> > > -		 * folio->mapping == NULL while being dirty with clean buffers.
> > > -		 */

