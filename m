Return-Path: <linux-kernel+bounces-721172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4FAFC5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8321BC388D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928813B5AE;
	Tue,  8 Jul 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBeUqOdQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791879CF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963429; cv=none; b=eNwW8Ocif/nSOlFXftN15/mDTEeKMwBHE41vTOGq0nh7U1gC1baf8FdqWlvE0Pkqc79cdWVd1I4BukNuxiQLyaczelJmIplYDTYzmC624ny2I6RIstzdCNZRvjGBVqrBKT425X9U/DcWt+3H4YTpyl1/j/5CQ7/QmGpdaCoShjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963429; c=relaxed/simple;
	bh=kDl/IltI7Bj1GHVhBl2DoZ2E/3gcDrTx4GGaCsiRmOY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmb25nKtTAFt8wObtL9j9FGjrB9lRdd4q67xNNfMtvG2db4/Osy/1FURrG2j7Y3LrZdFGW7c92bHO0VIVFMToAmm3yq74Ac/uZaC4uDq/JJdVdodpd2Ri/EOskAE4wqkTtYNBloBY+yy3pYqSdkus74QSJpByWPd+nflI9zDB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBeUqOdQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b3316160so4784463e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751963426; x=1752568226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naUU7YPkX1jk3XPkX9Lnf2o6bvi4iB5Jjw8Y2jw+YrE=;
        b=eBeUqOdQLmVjkDWZpbLm1Q/zP7BsntaPSl+Pw/0SgAegoUPFNrNnh3flz8CQv71chp
         958WQ0w62ASLR3G9pJ+YXYlBmgDV3PDR731+4eUky0QxRd7LdYnLrxQw8WRoR3QT+/d7
         r9FErbRMBRcR1m/j4R9XfO6YNq3ScQl/TOXvdER30iuuga09iVKL5/mCGN2PCRkEFdvD
         u8WTEYyEOurh7rqRHXT8Mi48tY5Pf0cLKVo2DIxWMITetrWK1rk7G9NB0+BvbIWF3muM
         YFiFA6ODk2VF658ap4SbWrU4qqD2q4Lq8HYpSbaceg2Kd2vVOVU4aDlsJrG9hsuVYuD2
         lrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963426; x=1752568226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naUU7YPkX1jk3XPkX9Lnf2o6bvi4iB5Jjw8Y2jw+YrE=;
        b=WGaZskaMNpJ3uWtz2/RkT5URFY3wGzEP+mvfu3J+icFT6h/0c/abhl24IYv8GiXwRa
         QtOsjrnmx4sv8ljO93sGTbrje41vAFuUMhYMQM4UfREwWyS+jh1sUd+1vfYsO2Zja1Vh
         bgkc+fNEBNtVAFJOuFF7lAUoTIE/Z+7fNOZ0Gp9LPWOQd7j4kGqi+iEVrb7ABUpqcDxB
         hWb5V3ROkRJbFAE3tXZOODnJDcM6TvJjzMzzeC0gDLy9/kndfkkc3ukCtW/W+Qm+iMmo
         csEkZ91Kum8Ia1YjphLphaTRCyCnV+LNYhQJG5o9uTrYSocebP2rwTCfq+2CkwjekTnP
         aZYA==
X-Forwarded-Encrypted: i=1; AJvYcCVsG9MDY/G0iFaQEcNigFVAi+9ulJ6PxeekjYFde2bIZgAIoZFhGhjI7s9GYoHiJohTYMPc9+0wReKPCQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrctZLQ4uIHOOMk8zMmzIdwYH4yTxqxo9K9T4ZFNFIAggF/I5
	d5eZx3sV8RtpcoedB9Pwpa5MymMlp+Idpw79mYOSwBV8KA51NyTbZGhf
X-Gm-Gg: ASbGncsMaAiKgcTdDG0144E6mI1sUz+CD4QBvm71VC7FeCvJhesaRK88yBqJ8UsRLi9
	UHt7ZiI84jZgY1zQjbrEjq9mXAD75RUCgQRHIA94kFEkLi8DvIMTmJdRp9zWXtLM8QCM9G9Hmog
	h+czKVxSe1y2+LnvFF6QK60LG03SDlkwAXC3Fkq2HuvVryh2VkqM7zoEKOt3vZQ3U108WKvjAzJ
	JFACN9w9EOrzMyFyO/oHS4e0IG3tEnePB8jT9vbafQxtIbR0c9iR1zHOcLMDT+82tvsO6Xe0Uho
	uHPZA/80w0TceGkAidFyYfSMclgznqpHkac0Ji0=
X-Google-Smtp-Source: AGHT+IFekh8SPs8INkZmJo/i+0y29wcjMu7aA0FkzX0D6HPVifRgtUPA8S07YMEyqiTxL6Gg5La/LA==
X-Received: by 2002:a05:6512:e98:b0:553:2def:1ae8 with SMTP id 2adb3069b0e04-557aa38ef91mr4694997e87.30.1751963425426;
        Tue, 08 Jul 2025 01:30:25 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384a76ecsm1600937e87.153.2025.07.08.01.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:30:24 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Jul 2025 10:30:23 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [RFC 4/7] mm/kasan, mm/vmalloc: Respect GFP flags in
 kasan_populate_vmalloc()
Message-ID: <aGzXH8Rqk8K-oVip@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-5-urezki@gmail.com>
 <aGsnOm4ImBjp5kMN@MiWiFi-R3L-srv>
 <aGxxJ+rLipjBToM9@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGxxJ+rLipjBToM9@MiWiFi-R3L-srv>

On Tue, Jul 08, 2025 at 09:15:19AM +0800, Baoquan He wrote:
> On 07/07/25 at 09:47am, Baoquan He wrote:
> > On 07/04/25 at 05:25pm, Uladzislau Rezki (Sony) wrote:
> > ......snip.......
> > > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > > index d2c70cd2afb1..5edfc1f6b53e 100644
> > > --- a/mm/kasan/shadow.c
> > > +++ b/mm/kasan/shadow.c
> > > @@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
> > >  	}
> > >  }
> > >  
> > > -static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> > > +static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
> > >  {
> > >  	unsigned long nr_populated, nr_total = nr_pages;
> > >  	struct page **page_array = pages;
> > >  
> > >  	while (nr_pages) {
> > > -		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> > > +		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
> > >  		if (!nr_populated) {
> > >  			___free_pages_bulk(page_array, nr_total - nr_pages);
> > >  			return -ENOMEM;
> > > @@ -353,25 +353,33 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> > >  	return 0;
> > >  }
> > >  
> > > -static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> > > +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
> > >  {
> > >  	unsigned long nr_pages, nr_total = PFN_UP(end - start);
> > > +	bool noblock = !gfpflags_allow_blocking(gfp_mask);
> > >  	struct vmalloc_populate_data data;
> > > +	unsigned int flags;
> > >  	int ret = 0;
> > >  
> > > -	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > > +	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
> > >  	if (!data.pages)
> > >  		return -ENOMEM;
> > >  
> > >  	while (nr_total) {
> > >  		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> > > -		ret = ___alloc_pages_bulk(data.pages, nr_pages);
> > > +		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
> > >  		if (ret)
> > >  			break;
> > >  
> > >  		data.start = start;
> > > +		if (noblock)
> > > +			flags = memalloc_noreclaim_save();
> > > +
> > >  		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> > >  					  kasan_populate_vmalloc_pte, &data);
> > 
> > This series is a great enhancement, thanks.
> > 
> > When checking code, seems apply_to_page_range() will lead to page table
> > allocation which uses GFP_PGTABLE_KERNEL. Not sure if we need to handle
> > this either.
> 
> I am fool, didn't see the obvious added scope between
> memalloc_noreclaim_save/srestore(). Please ignore this noise.
> 
No worries :)

--
Uladzislau Rezki

