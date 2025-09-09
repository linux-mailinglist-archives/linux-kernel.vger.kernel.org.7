Return-Path: <linux-kernel+bounces-808409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF2B4FF68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51281C23C88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E672345753;
	Tue,  9 Sep 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cglac5SI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114393451D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428162; cv=none; b=cYTB5j6l4zfaquoGK9eQxERYnkXY/pgTQP7ev6qOKD6DrozzQsMI8ndl4HQdKVZmURhDr+9aGgLXxTuGKWlktAKLXAa9hTrviL7tffiZh0r8y9To4+hr8Wt9O8IHpqAYN/EWXgdU8ghH/X8ZPFpZc0NnGjyUgSjZBrw8mr4vUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428162; c=relaxed/simple;
	bh=HSVI0c2MPcfCxfTbX663WL44nUGjRe9XBH0DR/kkG60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ojc9uq1WEX2MPbfYxddG7atk38MRjMFUSj8DCfcp9UMS2Xqwj3XnRJANe3/7XSzv/z6fQxdf0XrqFyzweR4L1xeOJlsYZFAXsoEd1E3VFyD3/1KY5TeeMa3/EuoOVBGWmWwXx7ZQEEjOfLj2Z0NfiTZRo72oBoTzVZzGcJQgr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cglac5SI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HSVI0c2MPcfCxfTbX663WL44nUGjRe9XBH0DR/kkG60=; b=Cglac5SIFR5CjvspnMxpLy1ye8
	tEKEQ8ttpuZpCBFn+6Lmi8GVjaUOM7oDnrcPldtmZ1qaFUqTK5P7obZzYfPD0ykfi7GECexhqSoYU
	sNEZArLKw8OFDwl74/Jd5DmrF2850dKOD8Msv1ksESrOoWsNw84tVsITTWsE+PD9i2wVxF+oJM0Tv
	4iOTlrosfIoPJgrpoiYwMIRdKdb/V563ab4UivgNT1QjAz/2kXipkay2hpXcyR+v6FZDIKXThQwoz
	B4S/bCPhIgFuZDWEJf/H9B+1qmE2N7B5nE7S/nrycOEVvGPH3KnxChx1aFvDDbNsDsnc8954z6sOI
	dnAUBDmw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvzLH-00000009Efg-0Dh6;
	Tue, 09 Sep 2025 14:29:07 +0000
Date: Tue, 9 Sep 2025 15:29:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hu Song <husong@kylinos.cn>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Use folio_nr_pages() in __free_slab()
Message-ID: <aMA5soNyvsEcWvlz@casper.infradead.org>
References: <20250909074812.599030-1-husong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909074812.599030-1-husong@kylinos.cn>

On Tue, Sep 09, 2025 at 03:48:11PM +0800, Hu Song wrote:
> Use folio_nr_pages() helper instead of manual calculation (1 << order)
> for better code readability and maintainability.

https://lore.kernel.org/linux-mm/20250829154728.3397606-10-willy@infradead.org/

