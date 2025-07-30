Return-Path: <linux-kernel+bounces-751386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19831B168FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC461AA11D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22B225A47;
	Wed, 30 Jul 2025 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Fkir7R"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC220297C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914282; cv=none; b=CvMRXL2aSLL+yBylL0YslIt/VZx7AOyFeedYlgSEkZc05Mdwrmk5LtUKzD9qGq7CXrSnU+FNf5SfGy5ARpKlKBOxJuP1pEIg34wrVFghBNIzgmuPhkevhglnwU2lVLJHRYwUT7Mpv2U3s1UXsGn5WnUHU7kSf79ufol8m7ccnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914282; c=relaxed/simple;
	bh=EX1pUNxp1hbod6lA6ki6m6Q9fp/HW28UG7wPzYiWJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e09Hp6TS+4pH6NEb9MpOk2satMJj0vM3ZYhnFuRM3GERCF661lFY/4LSYXx+7ZWIlP/Sg4cQmMk6g30aEgsNkRfPI1sdYJBF8A2+CJVKOIfE9moO/vUqD0+ERcL2kC/HJUYey8hM6PrurBrfoJukhsoOW7hS0pUCq+58U8NR34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2Fkir7R; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so1097955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753914279; x=1754519079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCbT9/cz+rXGQ8ARnOwy7QkIK/KpaHmQmlR+7AOK0Pc=;
        b=B2Fkir7RjMhQY0FbrcB2wyBBGpm9VbJ3AlukZ9uuXl39STWGlTyozc6kOfLHV2D4CY
         xSvTbMJERAZOkcmqbVVWsJmsyLPxd4bO8Xl6Bc+0S9Bune1sINQdkpHG7j2EXtIIHYwx
         UNUtEF3NtBlNWdBtiF2R5pjy2dUVmLaoVQombF0K6ii7clfx365Q2rZxPp1B5Pyl1SoB
         fDTN1XpJggd6BfkzXxciO/xDRx9kCfyqUHbTNdHYCv4hVWa68jg7ujRh1w8vdY0Al5SZ
         YdPpw5vmym7AD/BaUAtSxjCP8yMlAcY1S2Mf+eJxE6ERSMQVtbHA1+VoZ69DsNIR0/G8
         ZGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914279; x=1754519079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCbT9/cz+rXGQ8ARnOwy7QkIK/KpaHmQmlR+7AOK0Pc=;
        b=ojKMhoPilPP/fWwYYpZ4TZOjqvp7kP4uAEwJrX8XTDxshkqycXx4ibq1xFrWXDi29J
         eYo7Zm10KV12duSzfjD5cJYJP3y0j206rmEtNAnQG7Bakz3kFWBQw54RN1PoKlgU5iOa
         zeMgMxZ8hQJymjsOVBTUF0F8GMrOWdCm+cHOXjEprYJompPQLvhRe45x8oMVgKXX4WI6
         PFUHxoIK/ZMG63ykFTPoQFh20oEEOeS1XxlHSHNvGVIvtB7ZKTSu/5Y5AH4CwMd7z7r6
         AUIQWRb744oeINyMzX6SOUO71CGJTcJPLhmeLVCF+3wfySqIRmkPXf1D4EYwS48+B6/6
         i3gw==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ30HXeCDhrG/fTHnUPNOjZ22tI5+vNtwYXDaYGvTJjXaAA1pMAAWI6XH1yY8pFeyOXbmjPFc5iKi2iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7JccpWm8BXfi2Fg/Q07GLMfsTANFPMsvWuZRE44pjBUA9AEX
	2qsEm0XLPHnVZZQ/oyH1nBKLQEpdieBnFHLdFvniAv7Pcf0GPGO1cTzg
X-Gm-Gg: ASbGncuSF8KbxHjEulnzyiuc3QnRaQvw6y+fDkLVU+nsQgSNGrtgqiIq3QlUqEMgtwI
	s/kjXbT1dBlAyhC6XHyw87xlyQnytfyNm+8Em5sP9NRkqzmRBS5RJ3UPuAahAVhQMAZFiMQSTg8
	7WcxJXV/fQzeXeLnE91p1+kIljnG+eTAWbNBAgxzdY5ryy7i5E4PtaFUjpL2fh9Osnw0uU/vbFK
	zpOsb3SrA2quwshvXzeeQAJUgWfGgKDngF+Rm/GWdCSEGVpxlGBxW2OZaK41e3eDl87dubtj/1m
	3zRfjEk42fGAc6OPlp5IgVcJ7r56f5NKmkXox0QJp2+nqpXXckC7F+a210/JSmpNFsh58FPBR5L
	gzVmk9OsM/RQec9O4ofPCJxbU7ep0z62ZNIDjBw==
X-Google-Smtp-Source: AGHT+IEHwJ0OF/CEB1lfb4+OzjypEm8jkKSqIIDGkUMeRFWaULpe2YCUA7fNQcqZpUUGznElVR0FJg==
X-Received: by 2002:a05:600c:4fd3:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-45892bd1a95mr42393275e9.26.1753914278856;
        Wed, 30 Jul 2025 15:24:38 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e0dsm41450315e9.31.2025.07.30.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:24:38 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:24:36 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
Message-ID: <aIqbpFsoqbt77j8f@devbig569.cln6.facebook.com>
References: <cover.1753794408.git.pyyjason@gmail.com>
 <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
 <0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com>

On Tue, Jul 29, 2025 at 04:11:32PM +0200, David Hildenbrand wrote:
> On 29.07.25 15:53, Yueyang Pan wrote:
> > From: PanJason <pyyjason@gmail.com>
> > 
> > This patch adds support for damos_stat in virtual address space.
> > It leverages the walk_page_range to walk the page table and gets
> > the folio from page table. The last folio scanned is stored in
> > damos->last_applied to prevent double counting.
> > ---
> >   mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 112 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 87e825349bdf..3e319b51cfd4 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
> >   	return applied * PAGE_SIZE;
> >   }
> > +struct damos_va_stat_private {
> > +	struct damos *scheme;
> > +	unsigned long *sz_filter_passed;
> > +};
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct folio *folio;
> > +	spinlock_t *ptl;
> > +	pmd_t pmde;
> > +
> > +	ptl = pmd_lock(walk->mm, pmd);
> > +	pmde = pmdp_get(pmd);
> > +
> > +	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
> > +		goto unlock;
> > +
> > +	/* Tell page walk code to not split the PMD */
> > +	walk->action = ACTION_CONTINUE;
> > +
> > +	folio = damon_get_folio(pmd_pfn(pmde));
> > +	if (!folio)
> > +		goto unlock;
> > +
> > +	if (damon_invalid_damos_folio(folio, s))
> > +		goto update_last_applied;
> > +
> > +	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
> > +		*sz_filter_passed += folio_size(folio);
> 
> See my comment below regarding vm_normal_page and folio references.
> 
> But this split into two handlers is fairly odd. Usually we only have a
> pmd_entry callback (see madvise_cold_or_pageout_pte_range as an example),
> and handle !CONFIG_TRANSPARENT_HUGEPAGE in there.
> 
> Then, there is also no need to mess with ACTION_CONTINUE
> 

Hi David. Thanks for your comment. I was not aware of the convention so I
followed the existing code. I had a discussion with SJ today and in the
next version I will change this by combining *pmd_entry() and *pte_entry().
We will also format the existing code in future patches.

> > +	}
> > +
> > +	folio_put(folio);
> > +update_last_applied:
> > +	s->last_applied = folio;
> > +unlock:
> > +	spin_unlock(ptl);
> > +	return 0;
> > +}
> > +#else
> > +#define damon_va_stat_pmd_entry NULL
> > +#endif
> > +
> > +static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct folio *folio;
> > +	pte_t ptent;
> > +
> > +	ptent = ptep_get(pte);
> > +	if (pte_none(ptent) || !pte_present(ptent))
> > +		return 0;
> > +
> > +	folio = damon_get_folio(pte_pfn(ptent));
> > +	if (!folio)
> > +		return 0;
> 
> We have vm_normal_folio() and friends for a reason -- so you don't have to
> do pte_pfn() manually.
> 
> ... and now I am confused. We are holding the PTL, so why would you have to
> grab+put a folio reference here *at all*.
> 

Thanks for pointing out. I thought someone could still change the folio and
realized it could not happen with PTL. I will use vm_normal_folio* in the
next version.

> -- 
> Cheers,
> 
> David / dhildenb
> 

