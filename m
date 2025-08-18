Return-Path: <linux-kernel+bounces-773647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB75B2A3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325CC189B7CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D920320CCC;
	Mon, 18 Aug 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krJ9xleD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F0318126
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522509; cv=none; b=mvSAHg1Bk2jlnKW/rseIDNu5VMe+Fdr7mgeM7dQhXUCPNe7j0W4sTtBY/QdRmm9xEQvh8L6jmxw9akGfn8i6RBwhCWQrhGzT98j3u8gM053CSAxxQAa1Ye39IH2FyfRguXMAfWMp3z8KpdvwQg0KqbLwpL6tyqqaLfd+qm/ikAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522509; c=relaxed/simple;
	bh=36TG3oB78TbqUDAUYcGDT/zekipX9xJbrdl2iHKCEjk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP+NSHtetXntrsizdlifKoLSSayKuTo7UGjz4C9J42TnLK36hErBIOhmqvxP/GaS31N/LjhKALcuY2U910GmSL09SjMJqkaNyEh7rDq7KqO3pPquRfq+JJ3qbEadQArB8/THB3mpNMReJVYpP+R/nXye7MnIm5C3KU23qLTSKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krJ9xleD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so3176591e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755522506; x=1756127306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HyuVXrZJ7tQHSn/WZiZiqfIBmKXwsNldZJSI/ZLU+6s=;
        b=krJ9xleDdtvmeoEqI/I51IxNUZsAv79ItXyiqL6RD/+J7xgAj3XxpIdRzBG6CfdSGD
         NxZoeq9dIyUicra/4z0s6hHE988sGKxewUtJbqlMVQY/cFe8jYBg2hTsHcR8VGSThE57
         /q+zNXkxnHkjb90mUnIIWrbSFseE8A4HPEqhkSp6XqGO9V0fvXK1aVxYKBvMrEWFrUyj
         taWm5kFoLGy+8Z2QqjMgOFndDoTlxJErbqfiHG5enBix0qQrMNxvRLNmrg98oYv9T62B
         pk8f6QTQQypQ2CnZJA759k8C31CepJ9zphbz4Lzx87bYmYw75HZSf2NLAF9kyS/nK3aM
         JlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522506; x=1756127306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyuVXrZJ7tQHSn/WZiZiqfIBmKXwsNldZJSI/ZLU+6s=;
        b=a+gxQHfcCoRKFpVbTvDU5LnXT1u3TWj9B0rY/1om4RX4UCRKu3z/QxG7OMdnhjUACh
         8StR0X1uQFb8UDpaqohs+oYOg3hLOQqWKBL7r0jLyYK+IXSYFzfJkFAQIVCsGLvVKsM/
         9NbufJ/i7IIzUAdGNTr6aD/eVTZUTxXh/FUw1BJMr8okOqkfY1DX22o0LW6dr83/rYw+
         T4KEWGDPThC77rLYIgcf8I/PnJ6A8fUxmFOSgAVkN7BALkBuD3ySypJDoGRyiQfWUfd9
         Tq30y4uxcVUB6LWdkp8HPg6S/qcxPyw8TzXdpDPibyXbLBY317W8kVT87/96eubZXm5c
         zdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT8hDIgOAXxNd0Hl3SiK4v+3yRQevty/gH0ukhVEqNtmHcIZjEPpVYx7UQemoQ7SduJH1wrFZDhF3/Duo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXO5RA9xQQY80cwBwF0bYAOQn3WGIIsCkUq5y9j9YpX99Vwod
	dYrgjfiv7n37mWWRJkgpenobAiHlyGDUf5qJY1eGlDq1ood+0+1kaw1E
X-Gm-Gg: ASbGncu0/MgX+md5/yxsdQIbQef5IaXrd5UEFVmcT+/glqGQ6g7g1nWE/JmbEjgIs4g
	PRhdZlwaKjdjwm5hjKSL0d01NGakptQG9+N2y3kMknp+3UU43C6fZU9inSW/0X2jFyHVMg7Gi3g
	YoociIuomVU2egu7h2eMgxm6UzV3sLN7PJweiaRRYP+u2QXX+Y0uiNCESKfz33xO2mw1vBHrGBD
	sTEHOltiMEBXHEorxxZ25SVCYXmVgUgawQ7U4NNMQQ4rse8kZ/LO+gmMEmUUucI4nww459ID/9s
	7pdrbmA86XLGR32FL6zBoEyeb2zACFvckhwkLQ//i4e2wipgWS1lSQwx0MrZ1sLn6yTpzjY5yxP
	YVDZmKYC0K21I7oBP3LehNorhFUenPIxU5FsZP9SuOt0rTfQ23A==
X-Google-Smtp-Source: AGHT+IEIBUpvwsmKHbgEdF4HCrjf2IRGG5QGH8UtbpE1PIOQZSfKKpE3aMnzFvwN1+GQhKFI7y2drA==
X-Received: by 2002:a05:6512:2906:b0:55b:827d:e377 with SMTP id 2adb3069b0e04-55cf2c82686mr1712655e87.22.1755522505558;
        Mon, 18 Aug 2025 06:08:25 -0700 (PDT)
Received: from pc636 (host-95-203-21-145.mobileonline.telia.com. [95.203.21.145])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cf4d0d181sm1102471e87.57.2025.08.18.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:08:24 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 18 Aug 2025 15:08:23 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aKMlx_sATwnGsXXp@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-8-urezki@gmail.com>
 <aKKthIZbD4oNywY4@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKKthIZbD4oNywY4@MiWiFi-R3L-srv>

On Mon, Aug 18, 2025 at 12:35:16PM +0800, Baoquan He wrote:
> On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
> > This patch makes __vmalloc_area_node() to correctly handle non-blocking
> > allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> > 
> > - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
> >   if there are no DMA constraints.
> > 
> > - vmap_page_range() is wrapped by memalloc_noreclaim_save/restore()
> >   to avoid memory reclaim related operations that could sleep during
> >   page table setup or mapping pages.
> > 
> > This is particularly important for page table allocations that
> > internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> > scope restrictions are applied. For example:
> > 
> > <snip>
> > __pte_alloc_kernel()
> >     pte_alloc_one_kernel(&init_mm);
> >         pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> > <snip>
> > 
> > Note: in most cases, PTE entries are established only up to the level
> > required by current vmap space usage, meaning the page tables are typically
> > fully populated during the mapping process.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 2424f80d524a..8a7eab810561 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3721,12 +3721,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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
> > +		/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
> > +		nofail = false;
> > +	} else {
> > +		/* Allow highmem allocations if there are no DMA constraints. */
> > +		if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> > +			gfp_mask |= __GFP_HIGHMEM;
> > +	}
> >  
> >  	/* Please note that the recursion is strictly bounded. */
> >  	if (array_size > PAGE_SIZE) {
> > @@ -3790,7 +3798,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	 * page tables allocations ignore external gfp mask, enforce it
> >  	 * by the scope API
> >  	 */
> > -	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> > +	if (noblock)
> > +		flags = memalloc_noreclaim_save();
> > +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> >  		flags = memalloc_nofs_save();
> >  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> >  		flags = memalloc_noio_save();
> > @@ -3802,7 +3812,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  			schedule_timeout_uninterruptible(1);
> >  	} while (nofail && (ret < 0));
> >  
> > -	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> > +	if (noblock)
> > +		memalloc_noreclaim_restore(flags);
> > +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> >  		memalloc_nofs_restore(flags);
> >  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> >  		memalloc_noio_restore(flags);
> 
> Can we use memalloc_flags_restore(flags) directly to replace above if
> else checking? It can reduce LOC, might be not as readable as the change
> in patch surely. Not strong opinion.
> 
> 	memalloc_flags_restore(flags);
> 
I agree, those if/else cases looks ugly. Maybe adding two save/restore
functions are worth doing specifically for vmalloc part.

--
Uladzislau Rezki

