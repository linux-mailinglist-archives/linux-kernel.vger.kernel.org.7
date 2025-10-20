Return-Path: <linux-kernel+bounces-861115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BEEBF1D09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910DE4267DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40EE3148B5;
	Mon, 20 Oct 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOEYPKlV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059242F25E0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970137; cv=none; b=UtJ/9QpPk9tg3Zp6PODYnV1Sg/VrUDmOoFWtka9N5qUJGLtn12EU5v4QvXLLRVUyHIfcvDeJ6nVPD30Fz9vDYb/4sDmTZ1ptDxF04R9/EuwRbQPWAsjhiT9bxEAnOt4vC0DKjaXAmio5/Ir4kfo4iwums7PNOIQQr/W9hpQltJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970137; c=relaxed/simple;
	bh=qOGvrUyWMkbXW0aor7OjBhhMhyhG7u6zXAhr6PWEmxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1g3+Vy5CSp0QMN9sJh7N8mTECfImf8WP6N2lvJsbDOGM/yv+dwGN5LuwqDRrkCkuZbBtcCuMZrjoHRwCnPxVgebxw8TqALGE5wjX0DvQnCfr7EYZg3gKT5wxxeeLyQyLZCPpYtVlZkqpuCMrZMKuvek/a8arOIv5AH5guNj1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOEYPKlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75648C4CEFB;
	Mon, 20 Oct 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760970136;
	bh=qOGvrUyWMkbXW0aor7OjBhhMhyhG7u6zXAhr6PWEmxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOEYPKlVD5b7dQS9Cd5Trxa17EZFodO847m+AxPxJKxANdROjH5zHfY5C99rf18Ki
	 7WA+SgU1bPaP7uutTLwkYyMFsYs9IZOoCLpfvcy1HhKjHUtNDzwUMOrlxF8OWqrodG
	 t1w93pRnhvXM1pcIk+6fZoOZAm5OB3qjwZwm/TN2X4dCOKaxilutRcU4u8tShTKQh+
	 ayllpWcmmZ/0FRaZDM4JfFjqRoD657Qj+Qfm3TtAn5zVBebRMdmGmW8Wgw+BLmYB90
	 ONYxlGJSfXtHZzWCfKlGhOIqRSfZBW3cUjt9DAu7VJpP3mkrtPCt9Pn5JUO6Wtp4Jw
	 sTromTdhvGnDA==
Date: Mon, 20 Oct 2025 17:22:08 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
Message-ID: <aPZFkFOvJ-hKfC3J@kernel.org>
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org>
 <aPT0zNMZqt89cIXH@kernel.org>
 <3301af1f-c24a-4e43-ad59-402e244d5552@suse.cz>
 <700c5a5f-3128-4671-99aa-827ca73f5cdf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700c5a5f-3128-4671-99aa-827ca73f5cdf@kernel.org>

On Mon, Oct 20, 2025 at 11:04:26AM +0200, Jiri Slaby wrote:
> On 20. 10. 25, 10:54, Vlastimil Babka wrote:
> > > > Most of them shouldn't be using get_free_pages() at all, they should be
> > > > using kmalloc().
> > 
> > Changing to kmalloc() would have to be careful, what if the callers rely on
> > doing e.g. get_page() later. It would however be useful to dintinguish "I
> > want a page-sized buffer" (note that it's guaranteed to be aligned by
> > kmalloc() these days, which it wasn't in 2015) from "I really want a page".
> > But many of the latter cases maybe want a struct page then and are using
> > alloc_pages()?
> 
> FTR, tty appears NOT to need any of the specialties, so k*alloc() conversion
> looks sensible to me... OK, I can re-revisit that and do the work, but give
> me some time :). (Which means 1/3 from this series won't be needed.)

I'll just send 1/3 as standalone patch, having DEFINE_FREE(free_page) is
useful regardless of the conversion.
 
> thanks,
> -- 
> js
> suse labs

-- 
Sincerely yours,
Mike.

