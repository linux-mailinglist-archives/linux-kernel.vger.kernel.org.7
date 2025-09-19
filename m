Return-Path: <linux-kernel+bounces-825230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A06B8B54D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62B81B278A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B542D2385;
	Fri, 19 Sep 2025 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v6SrtbjR"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911423FC54
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317322; cv=none; b=CrFd4LsEpgxoIdjRknOeBuTllPzZTupzlwCBWnm5XAHTYFSoyJ9gOCfFiudu7zholGoZbhxLNVzXuGEWHPSkN0r7lLx2w6Rsh6T6eZMBe+6jMXg62PaXqT+FE8k/jkL400PeYcODmdt6evk9BXchvvkxotBNIvq/E3R06oLMxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317322; c=relaxed/simple;
	bh=gsEszyYFWZNVl+pxcObGDAm2X+CCQYDplrEpTmJ/taw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJWZL4ppLcTvLKDdknhGuTdIXU4Qz9pNV5KTEKuLXNZZEUIY2X4/g7/SoEWxZNjAOui+t0F0v46xlw2KSE++8+oeNm57DpAZo2A7dDlov1QLfI59U3baAJLRS13V0YgYudcEMPCm7tPXI63lY+n5zp2Poh98aN0nsYsq6pWrpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v6SrtbjR; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 14:28:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758317317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpUrXb0nSEj/cPg3wNxEbYpjYYIRlz3XIOQouIGdvFc=;
	b=v6SrtbjRqCDfXhiQdSAabk1SPGZUZSK4EkiadV7EtS8WZGtcorlmLWDFlQfn76YqlG8V8Z
	BEuj2IY2AG2n4i++cj2ijfp9JLEsbwFEIAMKwD1yxss9d8aoOccCtNiyhdsZ2SylL7nEW9
	+fISEIZneAT4IRWLrxdPDOEREDqwqtY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 4/5] mm/fault: Try to map the entire file folio in
 finish_fault()
Message-ID: <hbse7gypxkaphzhdwkfw5nzu7oufcbd5iteyqw2nc7j4xptydh@rfympsitxagc>
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
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 01:40:35PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
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
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

