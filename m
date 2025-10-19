Return-Path: <linux-kernel+bounces-859494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD8BEDD54
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 02:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373E5427B53
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1D1531C8;
	Sun, 19 Oct 2025 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YxoWqhT3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41B35950
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760833881; cv=none; b=H4VWCMQ4R2tIRajRmQb7Bs1NPLxHLO5eo1xfkB6y7E1eBAo9JOlzrJLi2fVaUeI9Q+ipY5s42L1nEeBWcqHL1ntVhnx9e2VhKeSMhNR5uqIR3NxQH1N2Yfg1thUzpQjGH86bVHXwiy0kQv2d3mOCf7KXr2u/vFmrSFN8JhY0REU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760833881; c=relaxed/simple;
	bh=ZUHu/6nkYMCAyefoakmbIcQvq0Btb/DZkVvHIZrhEv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQymOU5GoRo+iDkMh7Urd4FTKD2Dwyk66QrwyqG0yyMaouFC+15RZIbE+Olx+CcnNC5aGLwQMpjEiHMs7MPdzS1VUDq0VVS6jCU3xfLiGyjsOQzixXjSGlKn42HGaPf6tVafc4ReaCdGVPAhyvTTERPyGgAme4GKuC4gfqzWilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YxoWqhT3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=obiIiWXrbpLkc3mvTBdVrdtNhB5OOJsd4njuEApkCqg=; b=YxoWqhT3EO3YgwuL82eCnE6ZM6
	cmRuUXUabSlX5GEZ6Ul79GcjPqjua02/dLakywJXS2RPOzu+usjGcDAwngL2UUanrCou1X3wlNzWJ
	9A0UDIvNQU7LtoFNtOg9b1cqw7OUOGGmQSdgNxRtip/BaJifbpHtWaivgxPsGgxeCVDxIWKoV3mws
	e3xh7T7BoX1lQPGuYACttufPUjtUM9om7ExPkJp/9LHH3oTzJFpjWEYy8zxiG41YMO9QTiV0iXwVX
	CVdz31ZHOqAdmsD4elReFtav5/3a13M12aISa3WSpm/hgffczsMBPdvBxAkiLWrG2lyKQ4DksNWct
	fmN+Rzaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAHJv-00000000YBi-1hlF;
	Sun, 19 Oct 2025 00:30:47 +0000
Date: Sun, 19 Oct 2025 01:30:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <aPQxN7-FeFB6vTuv@casper.infradead.org>
References: <20251018093002.3660549-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018093002.3660549-1-rppt@kernel.org>

On Sat, Oct 18, 2025 at 12:29:59PM +0300, Mike Rapoport wrote:
> Vast majority of allocations that use get_free_pages() and its derivatives
> cast the returned unsigned long to a pointer and then cast it back to
> unsigned long when freeing the memory.
> 
> These castings are useless and only obfuscate the code.
> 
> Make get_free_pages() and friends return 'void *' and free_pages() accept
> 'void *' as its address parameter.

No.  Linus has rejected this change before.  I can't find it now, it was
a long time ago.  Most of them shouldn't be using get_free_pages() at
all, they should be using kmalloc().

