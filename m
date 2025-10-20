Return-Path: <linux-kernel+bounces-861109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C892BBF1CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C38614F5F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07523320A1D;
	Mon, 20 Oct 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J33kZ7Up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71430595A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970062; cv=none; b=g19YtpeO0f1ttjf93d8ptas/A8/Jc0yEVy6jF3+338dJk7oWQ8LmUMv8DbPyGiJR7ygj+CfNMNXq4zEY1da9yPF/yhzUjmRxp8jjzwRB//3psO1ikRLZ2zSkfforQQbz6SpoYLeRad4gzGg/xTTlPHhnTW2kHQRRUZHgq++s7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970062; c=relaxed/simple;
	bh=MWtJ+mpol8+yVnzZuaWPr0ilzSGNIoshaV8ATYd24wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3j/CpfHE1P2TyG+UpeL6Jie69V/JzKIjwd7CJxFbRg6N4B1D2OtmnpCucgVm2QXFpn0mQoNscHARGd47rpPb3Z+cL1lE2eemchrNgJgUAmryCMVtA4H5nfYPaXE60JxByyEHx5D7fhXVh/3SUXIUxW6EvJ5W/RPPiVE67KZ7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J33kZ7Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C3DC4CEF9;
	Mon, 20 Oct 2025 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760970061;
	bh=MWtJ+mpol8+yVnzZuaWPr0ilzSGNIoshaV8ATYd24wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J33kZ7UpK1kYx53YvkuMnchUUU2VJ+k/E9KevIEcuOA4bxT6fp2jPJtrhZecGPERn
	 FJKvDzUWqM1vuz3JX47N9ZRM1e97PQ/zem/dxC5PD+sERJjdVbXigkWYjzEb8IltGl
	 9cXi0UtO9dC0tpVF3yaFhX1y1ojvaBfb1JmdTyphLkkplys7hwy8D2JXqKPpaixn1t
	 5IN6lo+TbDiTVVmsEQMY++GO9lUfM7nEKW0NHpyPola5hSVPUtU2Tz5TFOEsSwj6g5
	 ZUicraVH06nuF0Wy5uVOpucM0rJ5cRaHHT2ZRQAYjXUX2Rbj6t4DJV1sWOjGTjXWNk
	 MWaCY6a8Y6QCg==
Date: Mon, 20 Oct 2025 17:20:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
Message-ID: <aPZFRJVEhSFlPDuE@kernel.org>
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org>
 <aPT0zNMZqt89cIXH@kernel.org>
 <3301af1f-c24a-4e43-ad59-402e244d5552@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3301af1f-c24a-4e43-ad59-402e244d5552@suse.cz>

On Mon, Oct 20, 2025 at 10:54:27AM +0200, Vlastimil Babka wrote:
> On 10/19/25 16:25, Mike Rapoport wrote:
> > On Sun, Oct 19, 2025 at 01:30:47AM +0100, Matthew Wilcox wrote:
> >> On Sat, Oct 18, 2025 at 12:29:59PM +0300, Mike Rapoport wrote:
> >> > Vast majority of allocations that use get_free_pages() and its derivatives
> >> > cast the returned unsigned long to a pointer and then cast it back to
> >> > unsigned long when freeing the memory.
> >> > 
> >> > These castings are useless and only obfuscate the code.
> >> > 
> >> > Make get_free_pages() and friends return 'void *' and free_pages() accept
> >> > 'void *' as its address parameter.
> >> 
> >> No.  Linus has rejected this change before.  I can't find it now, it was
> >> a long time ago. 
> 
> Here's a lore link
> https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 
> > If it was a long time ago, he might not object it now.
> 
> Did the circumstances change in a positive way? Using a semantic patch might
> make it less painfull to apply in a flag day manner, although depends on how
> much is that "a bit of manual tweaking" you mention.

Semantic patch missed a handful of places, other than that tweaking was for
formatting, e.g

diff --git spatch/arch/s390/mm/cmm.c manual/arch/s390/mm/cmm.c
index 980d2b302937..7212ab4f0eaa 100644
--- spatch/arch/s390/mm/cmm.c
+++ manual/arch/s390/mm/cmm.c
@@ -74,7 +74,8 @@ static long cmm_alloc_pages(long nr, long *counter,
 		if (!pa || pa->index >= CMM_NR_PAGES) {
 			/* Need a new page for the page list. */
 			spin_unlock(&cmm_lock);
-			npa =__get_free_page(GFP_NOIO);
+			npa =
+				__get_free_page(GFP_NOIO);
 			if (!npa) {
 				free_page(addr);
 				break;
 
> >> Most of them shouldn't be using get_free_pages() at all, they should be
> >> using kmalloc().
> 
> Changing to kmalloc() would have to be careful, what if the callers rely on
> doing e.g. get_page() later. It would however be useful to dintinguish "I
> want a page-sized buffer" (note that it's guaranteed to be aligned by
> kmalloc() these days, which it wasn't in 2015) from "I really want a page".
> But many of the latter cases maybe want a struct page then and are using
> alloc_pages()? 

alloc_pages() users also not necessarily want a page, there are quite a few
places where we have 

	struct page *page = alloc_pages();
	some_type *ptr = page_address(page);

So ideally those also should use an API that returns void *. But again, as
converting get_free_pages to kmalloc, it's a case-by-case audit.

> > Don't know if most but some of them could. Still, we'd have a bunch of
> > get_free_pages() users with needless castings.
> > And converting callers that should use kmalloc() is a long and tedious
> > process, while here we get an API improvement in a single automated change.

> Maybe a more feasible way would be to rename to something more coherent,
> while keeping the old interfaces alive for a while for easier backporting.
> because __get_free_pages() / free_pages() is not really great naming.
> If possible it would be nice to also make __GFP_COMP implicit in the new API.

If we shorten "page-sized-buffer" to "p" we can do something like:

void *__palloc(gfp_t flags, unsigned int order);
void *palloc(gfp_t flags);
void *pzalloc(gfp_t flags);
void __pfree(void *ptr, unsigned int order);
void pfree(void *ptr);

I'd keep the order in __whatever_free() for the first step, because I'm not
100% sure we can use __GFP_COMP for every existing caller of
get_free_pages.
 
Do we also want to rename gfp flags to something page-sized-buffer based? :)

-- 
Sincerely yours,
Mike.

