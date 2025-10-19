Return-Path: <linux-kernel+bounces-859730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E257BEE707
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08FC1889864
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194FE2EAB7A;
	Sun, 19 Oct 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKpuBT2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6C1373
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883925; cv=none; b=VCJzVDeRXYrUqqmt1FnxoSKoiFdi29HOtYbrpc8Wkf19nwgK944czdw41FRUYyXrXFucXtSK3fY5dt9L9vxAF3CkL2sdOI/hbWi/CNVObI0KZFpyoN9/8/yvsZ9Ky39BN+sZx1e1NogQunfbMFV/N/T5q7PmHfjpmkMjf79ZAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883925; c=relaxed/simple;
	bh=oHOlqf0ywPUIIQS7WIZUje1x82l1+22hMmrNrvGvwGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPJxBvahCxodpnOf3JP+gGBI0R/Udo9hLzQAZcJnJ7IDe6zcyMBTWtcHrYo6wt3x9sGIaLFcfaEHhW6TTRoino/IyKfnTSuc/8Epuy8k90Bfi2fzpZzj4+hSmCgRK6p+0bw8PFir1oy2ggg8jh0ALjthWkDx30aCjbeJPKhd5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKpuBT2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D1C4CEE7;
	Sun, 19 Oct 2025 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760883925;
	bh=oHOlqf0ywPUIIQS7WIZUje1x82l1+22hMmrNrvGvwGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKpuBT2f9kk33TvypeW9ldST7Hx+ke6eyMKL7CXXKkBNYCFVsMsYMIlidiWX0yD+1
	 fURdxuvGxYJBAN2NpLvaJr3Rbf4WCCjghI3WS9xfmbhr7/csh2qannr6Vg8g8TbFnq
	 o+p6Dx+xUgKLMik70ES3zq57BBhVOhBg/KcCrIaYubdEkSk8o/ulb8ZxOcBrNge6R3
	 5feDRZ0+u/Iu8j+Fp7FtaXtH2YBD6u1EfdtTTTqRCRGv9huCTAyV4mOfor++d06TtO
	 fUy2SaejLi7EVR1NgTRBQYhld3G3WZYHARe5OVXFrvuOCC1+gtz4zvL8KCV3VArjas
	 BzYecLrFNq3rQ==
Date: Sun, 19 Oct 2025 17:25:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
Message-ID: <aPT0zNMZqt89cIXH@kernel.org>
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPQxN7-FeFB6vTuv@casper.infradead.org>

On Sun, Oct 19, 2025 at 01:30:47AM +0100, Matthew Wilcox wrote:
> On Sat, Oct 18, 2025 at 12:29:59PM +0300, Mike Rapoport wrote:
> > Vast majority of allocations that use get_free_pages() and its derivatives
> > cast the returned unsigned long to a pointer and then cast it back to
> > unsigned long when freeing the memory.
> > 
> > These castings are useless and only obfuscate the code.
> > 
> > Make get_free_pages() and friends return 'void *' and free_pages() accept
> > 'void *' as its address parameter.
> 
> No.  Linus has rejected this change before.  I can't find it now, it was
> a long time ago. 

If it was a long time ago, he might not object it now.

> Most of them shouldn't be using get_free_pages() at all, they should be
> using kmalloc().

Don't know if most but some of them could. Still, we'd have a bunch of
get_free_pages() users with needless castings.
And converting callers that should use kmalloc() is a long and tedious
process, while here we get an API improvement in a single automated change.

-- 
Sincerely yours,
Mike.

