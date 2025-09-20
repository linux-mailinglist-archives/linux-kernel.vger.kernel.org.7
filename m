Return-Path: <linux-kernel+bounces-825546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F7B8C173
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C4A80B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC650242D91;
	Sat, 20 Sep 2025 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mXWMmdl5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E323C4E3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758353885; cv=none; b=r4GTchhfm4g2efZVCj3sF1pg4TYEoLE8V/thwJ6WM0UoY0/IJbrXxdAI/yq9jTFUNIfKsileksUPM/jIAFU6gOXSs1iCIxsdE864wqoXdRocBY9pvAhLtm21ncQQF345Z4etNhlj7f7kKGpNFTJ1Aq7eoZJc7yUBjSbqJ/o59Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758353885; c=relaxed/simple;
	bh=9lf/40NI8Ue/Jl+urJQK1X6sGdrgKSBBYYhCkQrFN8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuApZNKPCHWSYG/KkiB3mwJUEp4uQK9vomekGrvcLRI+lnwtY8NmJJOXXM3LhXVTrSwq5Hg2/BCcP+hFLiRuXQF12drBIIaAhyc5RHOQ2OpUB4jPbX5h2GoInvpD3usU7RYrUOyXiCXNCJ8KkD1EvV0qONTGAizpamnPZV9Diyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mXWMmdl5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pHaax7Rz00c9vFQT/JhxqHrgqD3fFm2wFC0viZSdl4I=; b=mXWMmdl5kLEm4+UDhOr/AgwpY7
	lRvpWRyETigZpmL7CIaPctuPDiqpNCC88ttDDzEfptvO0DBTMWhGn9+/V9vqVFCSUgsaYLnZoiH5U
	P1wufcF5Lztop0vjDD1VfsfBudfNqBX8DIyeoL8Mg9cbh3joLrnaFn581Ox+Uy6KcFtNGUXNkGEKt
	H23Wctaf5ZibDgMfH66AOBzBaOVnDrAkbG2fDPuOP0GChK7zG0IZBc7c/xco5ykcLqJyGfVV5kF/b
	rG1+a+ebXBSoWfdXv2+/OYp5Este81iuNxsZPQd68sS6qPi5jVdTjt/a3glV9ZYXLsV81xizTaP6Q
	sAadRipA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsA5-00000009RaC-0nLC;
	Sat, 20 Sep 2025 07:37:37 +0000
Date: Sat, 20 Sep 2025 08:37:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 4/5] mm/fault: Try to map the entire file folio in
 finish_fault()
Message-ID: <aM5ZwWiFDOuSl6C5@casper.infradead.org>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-5-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919124036.455709-5-kirill@shutemov.name>

On Fri, Sep 19, 2025 at 01:40:35PM +0100, Kiryl Shutsemau wrote:
> The finish_fault() function uses per-page fault for file folios. This
> only occurs for file folios smaller than PMD_SIZE.
> 
> The comment suggests that this approach prevents RSS inflation.
> However, it only prevents RSS accounting. The folio is still mapped to
> the process, and the fact that it is mapped by a single PTE does not
> affect memory pressure. Additionally, the kernel's ability to map
> large folios as PMD if they are large enough does not support this
> argument.
> 
> When possible, map large folios in one shot. This reduces the number of
> minor page faults and allows for TLB coalescing.
> 
> Mapping large folios at once will allow the rmap code to mlock it on
> add, as it will recognize that it is fully mapped and mlocking is safe.

Does this patch have any measurable effect?  Almost all folios are
mapped through do_fault_around().  I'm not objecting to the patch,
but the commit message maybe makes this sound more important than it is.

