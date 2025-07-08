Return-Path: <linux-kernel+bounces-720723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F6AFBFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7963B8714
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9D1DB54C;
	Tue,  8 Jul 2025 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CavN9gYr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E600BE6C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937334; cv=none; b=fR1/FFmrpXKVSVbQF6/IckLzKYczVgO7Ftqf78NYMG2uoCU67Y+6A2hff/KcVD96uJqyo9GNl+myUU9lK0nhh9Y9CxjewcF+mCHCRMu1gk7EnY2N54gcHZodHXPLUxKnB2ro7gUHr/vQI7EBTAw2hotpgp51DLmHOt2cqv5HPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937334; c=relaxed/simple;
	bh=nXIPKaJktsk9ipOkzkf7tHPIClsUbhiaFhaLXrP2FU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOHJGzvP3vmMka2gSdQY2gmjZI+QkhWWwKuaiVMa93Cc6fxARQlf5QOOYu2aG3GFu8NxSE3BBkO+8R2yrbb6naiOGcCVa93II+Sn2w3EC/WXsGe8bwWqtSlFEE3fk8kp6wxulc77Z9QJtgh9qpQ5bji9kc1eUZoErfaEkXAt6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CavN9gYr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCq9jLpVcHtozxDNuvvVZy5vUfqexcgcFQQtBYQ6ojA=;
	b=CavN9gYrjKcvox5l0ehgpsgixdzTeHxrIH9drsWWHq5MPkreXD4MRtYTvNAlYIX41J6ISa
	4Uli/RVowqdW3j57NtH660kZjHbWTxJJAEC1xLNQ5xMJ+cpevUi1QMLfKXgj2xoPvGH0Qq
	7p88c1BXcl7Xtf7sfzKwGNiF1IGu9ww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-vA0kA_sQMECKoIEQHtN51Q-1; Mon,
 07 Jul 2025 21:15:27 -0400
X-MC-Unique: vA0kA_sQMECKoIEQHtN51Q-1
X-Mimecast-MFC-AGG-ID: vA0kA_sQMECKoIEQHtN51Q_1751937326
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34E7918DA5C0;
	Tue,  8 Jul 2025 01:15:26 +0000 (UTC)
Received: from localhost (unknown [10.72.112.60])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D805A19560AD;
	Tue,  8 Jul 2025 01:15:24 +0000 (UTC)
Date: Tue, 8 Jul 2025 09:15:19 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [RFC 4/7] mm/kasan, mm/vmalloc: Respect GFP flags in
 kasan_populate_vmalloc()
Message-ID: <aGxxJ+rLipjBToM9@MiWiFi-R3L-srv>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-5-urezki@gmail.com>
 <aGsnOm4ImBjp5kMN@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGsnOm4ImBjp5kMN@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/07/25 at 09:47am, Baoquan He wrote:
> On 07/04/25 at 05:25pm, Uladzislau Rezki (Sony) wrote:
> ......snip.......
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index d2c70cd2afb1..5edfc1f6b53e 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
> >  	}
> >  }
> >  
> > -static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> > +static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
> >  {
> >  	unsigned long nr_populated, nr_total = nr_pages;
> >  	struct page **page_array = pages;
> >  
> >  	while (nr_pages) {
> > -		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> > +		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
> >  		if (!nr_populated) {
> >  			___free_pages_bulk(page_array, nr_total - nr_pages);
> >  			return -ENOMEM;
> > @@ -353,25 +353,33 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> >  	return 0;
> >  }
> >  
> > -static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> > +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
> >  {
> >  	unsigned long nr_pages, nr_total = PFN_UP(end - start);
> > +	bool noblock = !gfpflags_allow_blocking(gfp_mask);
> >  	struct vmalloc_populate_data data;
> > +	unsigned int flags;
> >  	int ret = 0;
> >  
> > -	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > +	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
> >  	if (!data.pages)
> >  		return -ENOMEM;
> >  
> >  	while (nr_total) {
> >  		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> > -		ret = ___alloc_pages_bulk(data.pages, nr_pages);
> > +		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
> >  		if (ret)
> >  			break;
> >  
> >  		data.start = start;
> > +		if (noblock)
> > +			flags = memalloc_noreclaim_save();
> > +
> >  		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> >  					  kasan_populate_vmalloc_pte, &data);
> 
> This series is a great enhancement, thanks.
> 
> When checking code, seems apply_to_page_range() will lead to page table
> allocation which uses GFP_PGTABLE_KERNEL. Not sure if we need to handle
> this either.

I am fool, didn't see the obvious added scope between
memalloc_noreclaim_save/srestore(). Please ignore this noise.

> 
> > +		if (noblock)
> > +			memalloc_noreclaim_restore(flags);
> > +
> >  		___free_pages_bulk(data.pages, nr_pages);
> >  		if (ret)
> >  			break;
> ...snip...
> 


