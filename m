Return-Path: <linux-kernel+bounces-723747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C287CAFEA9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAB7541357
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD692DE200;
	Wed,  9 Jul 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdVDnCEA"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFFA923
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068726; cv=none; b=nd+111p8Et07vLyUkOiwDqJ3RcgVeGtQsWa/ITfCJOBQ2PYGTWvfy/gGEXOFPc2WJaMJtpUSvlTKLMYkIcxW9rh9yT5c59vStMjrFEzZfDROgG9B1xw8GVc8f7NzwiQgun+FwyZVKW3ucmQOtWjLeTswCPJLYI3kr5FiZM1Qqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068726; c=relaxed/simple;
	bh=YsST3rbFwWen0zqfHvXNxypSFAqggBneeFX6KquS0hM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzC+IIzGQ/I1U5ZXblggLIJcZcy1WzFyV9jE7oBem6QoIL8JYtqJ4rFDDgZn0jyln1aSTxmh51UsN+n1458UoDV2qb2aTs1YOVCbTfTbEwZ8CAFCmLdzUD5Ktbt6mozPhsqxdk8V3Fmgnt2ulpX5KLr+8zxug+DlSGbXsgOfhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdVDnCEA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b4876dfecso9831441fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752068722; x=1752673522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rl2Ay51sErJT4ZpyfX8LEyFp1MHSjMvW15ejxcEW1Sw=;
        b=WdVDnCEA6MqI2kp+01r/Qzsl4yPM2nUF949rEfEyf9NR1yOepeKRGwwNreW8YxDnQ2
         YVgAmk89f9iu6rxyslxdO5WRbVhkFeLQ0u+GKLSCgvoTxkC/SS1ng9PBtAzVG7h4r6VI
         uIguadUNM1JwXqHt0gTBW9siizpeV2eSeSrkXP7sDCMCk1eFCNBTlkNGHDjkqnz+MJl2
         p5vuwUALtYAYo5lDpc2L7njd3OSMKJmgbckMvPIV0zATgK7zTxLZJlMsso81XKeMG3O0
         xONAsLIZnF5TkouI0n5gANPJouHvvpVWu+ikDzPwajbD2TI3Utni8gF4rDMn/o6V1hiu
         X+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068722; x=1752673522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2Ay51sErJT4ZpyfX8LEyFp1MHSjMvW15ejxcEW1Sw=;
        b=qZF9nwTUGPMYHVo45fCz42YxNQ2nuiBNcGCCve4xDputWAJ9jfP4TgcqhS20/GKuIE
         kqVyfB8voVmxiFVu68mpjHwGtCIMMoI9wn/qVnLXmmZJmBnbmEq0+jVqS7U9fRQwHQHN
         sb3lQ/42O/2NIjKhY7S1iKs4ERghLxXymm5vM4WC60FWJGx/leg9ouG8h/KmPiTXk3Oz
         dI+92h+6U8BqIJlmxg7I5KcaX1ixIa4DNSmqpvZ6/u+enu3XLr1WSJWzINOwhGkN8Xqa
         g4QfoO1lFPM9g/14bZkl0Jw59RLEr7BTvNTX/U+Z7hoGFJo8RxWYx7tdKhwHByw2jeY9
         rK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPDOg+tHB24AeE79yJU3Pe4o7QydG0Li0v7qpWf6GhTBfJxAxScgAvuxNcTnbR6YxwSPC+vHonE5YfBTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lB/gFMP0C3FFNTXf5lh8J2FnlCRu8rYwOvYP2hPQtvPhQZ8+
	DaILRaDO+mmgFesI+KeAP26kZUWmdjpDqpcxaB2+KQQ+iUGQbzx5KBNe
X-Gm-Gg: ASbGncvYfTzqR3FUpvSk2fD7K2vwa5Mi62znZ/nWFgB1I9ohFp4OVNCyEEXbp2D8wnF
	MnQ6h81NsNcKF0x8jSeBVjEYANlrApwEe2iy4bq/ArEKU676TfLyyH3INAyI07u4LwT7hm05kSs
	RTPKMdQX2tH80tggx/RZPPSdZlLWtOxll/yOkd/aWEtHcjkWPfIqFsahYantVsYZCfKh6lWYhDT
	//ROjeiBUum+TJB4oQW8n2q0YzDMSeuwam2aZ3fnvJv1+LNwVIksK3sCRBf+U9I2f8vzGsPeWyc
	jTzM9/U9c6D7QBywuKWEqmOD4wZQlWPkDrgwMnwFMQy9r9Xp4oXNZwoPSaBMMSdE6E+XxyYgZIY
	IOTXbzMoj6kfl1ySv
X-Google-Smtp-Source: AGHT+IGi8++TCHA5FSSqpuYGQ5AI5OdHypdoHyXDrOFUg/kqI9oVUxommkDuHDOtIoAgTA2XsB6WcA==
X-Received: by 2002:a05:6512:20d0:b0:553:2438:8d16 with SMTP id 2adb3069b0e04-558fb4442femr680882e87.20.1752068722011;
        Wed, 09 Jul 2025 06:45:22 -0700 (PDT)
Received: from pc636 (host-90-233-203-171.mobileonline.telia.com. [90.233.203.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c4785sm2005046e87.231.2025.07.09.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:45:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 9 Jul 2025 15:45:19 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 6/7] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aG5ybxhmNDR4_kCy@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-7-urezki@gmail.com>
 <aG09iVrHBPYPkp-Y@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG09iVrHBPYPkp-Y@tiehlicka>

On Tue, Jul 08, 2025 at 05:47:21PM +0200, Michal Hocko wrote:
> On Fri 04-07-25 17:25:36, Uladzislau Rezki wrote:
> > This patch makes __vmalloc_area_node() to correctly handle non-blocking
> > allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> > 
> > - nested_gfp flag follows the same non-blocking constraints
> >   as the primary gfp_mask, ensuring consistency and avoiding
> >   sleeping allocations in atomic contexts.
> > 
> > - if blocking is not allowed, __GFP_NOFAIL is forcibly cleared
> >   and warning is issued if it was set, since __GFP_NOFAIL is
> >   incompatible with non-blocking contexts;
> > 
> > - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
> >   if there are no DMA constraints.
> > 
> > - in non-blocking mode we use memalloc_noreclaim_save/restore()
> >   to prevent reclaim related operations that may sleep while
> >   setting up page tables or mapping pages.
> > 
> > This is particularly important for page table allocations that
> > internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> > scope restrictions are applied. For example:
> > 
> > <snip>
> >     #define GFP_PGTABLE_KERNEL (GFP_KERNEL | __GFP_ZERO)
> > 
> >     __pte_alloc_kernel()
> >         pte_alloc_one_kernel(&init_mm);
> >             pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> > <snip>
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 2eaff0575a9e..fe1699e01e02 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3711,7 +3711,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  				 pgprot_t prot, unsigned int page_shift,
> >  				 int node)
> >  {
> > -	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
> > +	gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
> >  	bool nofail = gfp_mask & __GFP_NOFAIL;
> >  	unsigned long addr = (unsigned long)area->addr;
> >  	unsigned long size = get_vm_area_size(area);
> > @@ -3719,12 +3719,28 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	unsigned int nr_small_pages = size >> PAGE_SHIFT;
> >  	unsigned int page_order;
> >  	unsigned int flags;
> > +	bool noblock;
> >  	int ret;
> >  
> >  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> > +	noblock = !gfpflags_allow_blocking(gfp_mask);
> >  
> > -	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> > -		gfp_mask |= __GFP_HIGHMEM;
> > +	if (noblock) {
> > +		/* __GFP_NOFAIL is incompatible with non-blocking contexts. */
> > +		WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL);
> > +		gfp_mask &= ~__GFP_NOFAIL;
> 
> Btw. we already ignore GFP_NOFAIL for atomic allocations and warn about
> that at the page allocator level (__alloc_pages_slowpath)
> 
Thank you. I will comment this!

>
> What we can do though is to add a pr_warn + dump_stack for request with
> size that would require (in the worst case) page tables allocation
> larger than a portion of min_free_kbytes (to scale with different memory
> sizes). That should be plenty for any reasonable non blocking vmalloc.
> We would have means to catch abusers in that way.
> 
OK, i will add it. I assume you mean:

  unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);

  if (request_pages > pages_min)
    dump();

--
Uladzislau Rezki

