Return-Path: <linux-kernel+bounces-878159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F69C1FE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1542734DDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F412F1FC5;
	Thu, 30 Oct 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCAtMkz9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAD248898
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825692; cv=none; b=YdJ0zdV+dct6psye76elVoc0QqMkWCl7A1o5u8hR+sds8nv57BdA3Bdz8tUiULqQDN6ICAIyI11hil1FxD7PLQx/kg51NJWfhwjL1rRlvWWS7TwnSK3zrpPddL2pA08rNbUZsu2E3OVMz8tMRb2C9ZNUD9JDtyuTyIVaHRkOJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825692; c=relaxed/simple;
	bh=a0Vb08GsJsiZX8VXASxn6F/tULBS2QnSkG6NcZz0f7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYMFPvAEWTc0UOUJ5la9kXesv6dr6ct7cIYUFg1npQ82T2GZWfKhrO0GxD53+/VFMk34ibHIFcLnEQGkb//taVAR9KNvhuFMSyzQYHlr0nzrjwgTCKYkx8tfhpbCMIYx01s7nlpXQwo4PFWVcwGWQjWkzGyhuphbte2X+ke7IlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCAtMkz9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so1882738a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825690; x=1762430490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCqsTP6WO8xa6bcu1HyLOprfOOc/QQz4vxykmNqr+x4=;
        b=gCAtMkz959EnoCs7GvsVLEUPl0wMsKZe4+RpVDMok1HN7O8DgoagRvsYcRyyFHLoni
         2WU7lDG9J/d4BgysQjb62dGY8Hn+mef1M7FrRJJyybAxRlvC5w66Ow1razQ4/ftAJ67K
         Ty5u8SJbH9uwYLwOtlXyvGCLPO0zOBhNUOYetQv9l/qsd4rP7nDpvXO3bJ0/BgI8eKLE
         IosFYOXuV5D52gNxQk+nIeH1ZDzOIWqDFGJVMVB53mA+WKAj6km5Tu5+LUil3ScxT9Wb
         0JlvWXdJTEiFDFLe7Pw0coxEYak3LFOud+zjzFYNu1MyWzpuDf+GCGGcNQwVmWXrfZEQ
         bn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825690; x=1762430490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCqsTP6WO8xa6bcu1HyLOprfOOc/QQz4vxykmNqr+x4=;
        b=IFuR5bCdZ1a5jTMSLUKarOUqhdfolrAna3wGkJPiyGrvc+LTqnzK6yQSfRpVYWZShR
         WJyEaP3iT/DpuSFt264Dr38RgZkgiEyUpA1n5+JrQv/m/mQCD2g/CZRJA4cn6rYqm8eS
         6lWhXmLE+nUbvc9uJLYdlV4llY2rknzbWneUHamNGCnPWjLfLDM5gqIGi/jcgHC35i/x
         Dc/A4OqgiLNb20PuAHO0K4hvdvXtuQWVlZwOR0T/iHzp2ApEcD423tmqH0TIWgqjFS7d
         qgRsu6Kx/ijCoulT0MbAJmaQn2PC7Xjvrzyju6SytW4Io9sab0UbIQJAC15m8f4WtZtn
         /4bw==
X-Forwarded-Encrypted: i=1; AJvYcCVzjGsYTRLusf348g/02XXy9MdztfH4JJ2KvKGxH9LQYl2hOCASBcfp8ViMZYZqwWcCvX9pQbHPuKAI2OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBtkHa3pFichXTOVMKwAPDloq0b8TD23d8IviJ+Yl9KSPTiCa
	81hd+1WnLl7kRUYUr1E5IwQHSGpIV7qFtZ7wDGdovT4TfNM6jEr1T/HD
X-Gm-Gg: ASbGncuGDcBZC5v8BF1xOO0+39lYEzgeW457EN7UnJiLunNTDAZi6kRn7GirZmxlDyA
	PUshD+GHbAdWst/2OADcZw3CVxhss8DAb3fV8nYM0zlWoMgMAtNHAlHC81dh1M2yvWG7NWsaOFb
	1rOUu/6LdZP7SLKMKZ4G+AiBw9PYL9D/6bJwdQsMR4WQeUJXLmt08Xg3Mw6XY6x5csvwRiJuxaj
	ESiD9rl/3yhZcDvAnBiGLq7gB1jrfIK4R7QrXPz17MW3YK2Sq0qirHvN8Bln1ZKwR1JfMpdnV8U
	j7fX/LA7lcXRoICCxE+Swb2L/OVjSVcAhWu/3jx9OiJvb80C613KGifel+RkbGBJezABCVswMMp
	5iZBowY8+xVg6bPFkAf+3amnyFNUm8ckiVu02dQl0RKrFuaS3tD5/sb71UUs9mOl1UokE97SYGb
	qROYHBxKO+oYP6klktePY33UmMylCtK3O7
X-Google-Smtp-Source: AGHT+IFQonX24JTyLfZWsxFGjgrZZNRr20CiGs3KUyL71nd3BmA5oWK9NNDrPOive4p1cvJyGQN5mw==
X-Received: by 2002:a17:90a:ec83:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-34068eeb00fmr1335110a91.4.1761825689493;
        Thu, 30 Oct 2025 05:01:29 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2 ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509e940bsm2419685a91.17.2025.10.30.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:01:28 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:59:37 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "mm/ksm: convert break_ksm() from
 walk_page_range_vma() to folio_walk"
Message-ID: <4ft4r4sh7gercwpmurgjpovzv6komoknbwvenzbxugx37ozrdp@x3i4vnacabyh>
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
 <20251028131945.26445-2-pedrodemargomes@gmail.com>
 <57b83fd3-8a6c-4d98-bd6d-1c97c71b91a3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b83fd3-8a6c-4d98-bd6d-1c97c71b91a3@redhat.com>

On Wed, Oct 29, 2025 at 03:34:23PM +0100, David Hildenbrand wrote:
> On 28.10.25 14:19, Pedro Demarchi Gomes wrote:
> > This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
> > PageKsm(page) to folio_test_ksm(page_folio(page)).
> > 
> > This reverts break_ksm() to use walk_page_range_vma() instead of
> > folio_walk_start().
> > This will make it easier to later modify break_ksm() to perform a proper
> > range walk.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> >   mm/ksm.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------------
> >   1 file changed, 47 insertions(+), 16 deletions(-)
> > 
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 4f672f4f2140..2a9a7fd4c777 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
> >   	return atomic_read(&mm->mm_users) == 0;
> >   }
> > +static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> > +			struct mm_walk *walk)
> > +{
> > +	struct page *page = NULL;
> > +	spinlock_t *ptl;
> > +	pte_t *pte;
> > +	pte_t ptent;
> > +	int ret;
> > +
> > +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> > +	if (!pte)
> > +		return 0;
> > +	ptent = ptep_get(pte);
> > +	if (pte_present(ptent)) {
> > +		page = vm_normal_page(walk->vma, addr, ptent);
> 
> folio = vm_normal_folio()
> 
> > +	} else if (!pte_none(ptent)) {
> > +		swp_entry_t entry = pte_to_swp_entry(ptent);
> > +
> > +		/*
> > +		 * As KSM pages remain KSM pages until freed, no need to wait
> > +		 * here for migration to end.
> > +		 */
> > +		if (is_migration_entry(entry))
> > +			page = pfn_swap_entry_to_page(entry);
> 
> folio = pfn_swap_entry_folio()
> 
> > +	}
> > +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> > +	ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(ptent);
> 
> 
> The you can directly work with folios here.
> 

Ack, will do.

> -- 
> Cheers
> 
> David / dhildenb
> 
> 

