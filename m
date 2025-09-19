Return-Path: <linux-kernel+bounces-825222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC02B8B508
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57697561B06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D168F2C0F7D;
	Fri, 19 Sep 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nGJg7hTy"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF435942
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316749; cv=none; b=b+KAfERN3KsDmVeaNWw90b2wnAxOvjbchbhXR+6YWaphsCsBL8b2M6/5d46iunbJZm2Def28zjGVsDKw6IUF5d7/6BFUInAaGshVcaFbzSmBuPBbSZRrVpOqU31kVGMBwfLKB2qBNp56BBko/i7I8JT9CruRZi+qQHU3oUMEEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316749; c=relaxed/simple;
	bh=nFIdNXUQ0J4yPbhWlGr9aHfFmOfSLhqbDPBZKmNFhJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqcQv+qmTcCEngiVVvJt7Q2JvEYlozWrM8n+nTV65rP/HE7BVDAQdiV2AZO3s5CgfRYVJ3vUVLqNjsWwcNwFRILVp0JRtre4u47vqLXkwu1ksnE+GitxQ28uzeBWUvwWoaPr5zEUv/1XkwuKw9rZaiw6Rd9226NbPhOb9PRxU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nGJg7hTy; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 14:18:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758316743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p12cTL26ZHFVM4Qm9V+H+3b/qs9Q3cDSdyY4Ygtksps=;
	b=nGJg7hTyy/6oFsvUnre0j5HvVRBGA2A/LqgWlsORgFlczoEBROH9HQMg62fACPXS1A7Nwh
	Gy1z3upufBIMiWNXB5t7yz4zdT7NdHcSq/AOuE9C0xGupOFO7BYLin6X2tiCp/zeiOEfL5
	YccEWsq/XtqO8eeMHeYqFnY/GoJr8f4=
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
Subject: Re: [PATCHv2 2/5] mm/rmap: Fix a mlock race condition in
 folio_referenced_one()
Message-ID: <vc7lycvsvehisjr5drbng2lupytme3grubxbtgavvvjknkgzd6@axgctxng4424>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919124036.455709-3-kirill@shutemov.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 01:40:33PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The mlock_vma_folio() function requires the page table lock to be held
> in order to safely mlock the folio. However, folio_referenced_one()
> mlocks a large folios outside of the page_vma_mapped_walk() loop where
> the page table lock has already been dropped.
> 
> Rework the mlock logic to use the same code path inside the loop for
> both large and small folios.
> 
> Use PVMW_PGTABLE_CROSSED to detect when the folio is mapped across a
> page table boundary.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

Nice, this simplifies the code.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

