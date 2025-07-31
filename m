Return-Path: <linux-kernel+bounces-752652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F58B178DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C4818912E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98062550BB;
	Thu, 31 Jul 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1F1wZol"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E122172E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999417; cv=none; b=rBDaeDYaTF81Yemg/Vy/6cti/li0PZBu6U8RaAa4FUOrF0jEvfF/fAPZ8vF/9FyRD3F9M4VuCRKQJlkLg/pMZY3phhQcexkJ0S8HrQmtOo08pjt1YJ27KYcsF1f2KS7HDFctdhGCUNR+pw3fRwlfTmmRpMbyZIOvTsKMDR4NsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999417; c=relaxed/simple;
	bh=E6cJ+zxFj+aT08x4JkTfQc+SP/Jaio58xoKKp7O0wjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHUPZkdoeOcBoQ4+LGtKMdk5zRzzcXGymGQ7F/LesQaM/nDJ8QvAK3jwAfHpqGLzZqrREx/1HW+vL+swmO7Vwpuvw8wtIeWbJ6YLkhOILXDnt74yMmN9RBPI9Q4PmPNbK12stpgl/GSo44uxKS07v/dg3LgP7rD/3uG7TNoig3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1F1wZol; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455b00283a5so5340465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999413; x=1754604213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGu/ALKuNn9LH5k5HOTa1HKwUmJnZbmVQXYYh6YCD4M=;
        b=M1F1wZollY4Ny+3452Rewb2VEpi7LOjRPnc0P86SsQlzykFe2UamjJJGqo8AxvE5Qx
         g4hBvSHOKZzwDzTDP35jjCG0+M+fAddDENSuMmkYU0jcxMqVFG/PEbx8Iq5l9d0Vyk79
         Oa1CRoppSvUfk9+dXx6y2RhcmmtXTAuy6iDcRa5dJKH2PZEqW0Xv9oyyp3m5OEE/iIIB
         EQP2K2x1ILlLYx4u/2tDmOK4QeCBCBdU9BaZYHhl815My4iyQSYDptOI73bTJfV2kKxE
         WYXj8YW6COKp2X6dX024/FV2/rS/6jA+ulnrUyASzK37RDpVJV7Yi38lXVOk7a8sXiBV
         6rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999413; x=1754604213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGu/ALKuNn9LH5k5HOTa1HKwUmJnZbmVQXYYh6YCD4M=;
        b=rcBE4x9B7Lbw750KLHVzC/XWN+mjSu7XoqG/KXMu364R8Mf1FcXXGszh6aEFpRzJJw
         5jd2WeJAEnAKcFJZ48w40joh/BqF/6MUYnCRFe+GWQRPvou8TOWziNvYEo+7m2vRIngF
         3dx4rpVD6qX+IaHSxKs6XVA/hu0M4ukNK4kZG4M3STqu/DC+YG4VMdO4tcbclUEcLyVC
         RpZFVEeGSWvqYMZCljNcwp9d0XoSVE+c/PijFBu4sVnHUevxTWKZJYa9QdeNyd9xmbRP
         bzoEY9cPBsLlgkMZQ9aSgh0P6ODwFw3FgZ9S98IbqlBn/0AQpvV4jUUVMRQxdR4Ov/US
         YjNw==
X-Forwarded-Encrypted: i=1; AJvYcCX5WwVF+EDJ0Wk/EG/iQDxX7H8ZPXW3qTPfdm5pck0oRdSYHnCVq3Y19gXMaonoGJM6fAYAzjtYQLlTfo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcAk+uwrHIJ9sy/zfaY1gr7djtdXlbY3+1AHW5ltpCg6CbRCS
	o5GPP80j0teUdFbHUd3/yL4STe252Nkx5E4cb9bgmCm1Almw7OdIkFxz
X-Gm-Gg: ASbGnctz28wYjJo6Lr1YSqSgpyDafPBiJ+mAmd3B1yJ8BKneXXm1J0nMrNs0sY6UbB5
	Pta9tR083AGuq3f2tleFcqC2uRFNAu8vnEFGircsJfcaVVCBsNhsZwP+B5+JEWjT9kscuIl7PVc
	wr7AnVrNIwOjIbTSfrn0M+GuM05+u2XOWRf0AsUXLHUVTCZO0ECNUKbUhZh+aLQRAceoAJ0I9Ji
	tKhLyjYaL6zE0zC0/RlPNvLrNEoDjRxna7Lbyd9OrGihFQQHosNpG8adK9Gxn+OZ3UKGRe/EJeH
	UVZYKswa6xnNg3wBQDEc25sUS4TFHnntebpogbuYnlUGhOna3GMCSEHBBTYe4dkUSINQ41Lb0cN
	snWL3700k6kwwLhn1wjet1iK1uweFc8HKBDvjHuQWrC7Rvc0VF2zn8CoL3biqfqp6c8ajiKSvHZ
	xUYqKhjqNaiRdc9394aQ==
X-Google-Smtp-Source: AGHT+IEpQU5RUUY6u5gnu7NyPeCEdAAfsGAjn+vhiZE1PCPsLtEeTjEmZhRhMRAnMw5GEfshKbtFxA==
X-Received: by 2002:a05:600c:3483:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-45892b9d8b9mr85100285e9.13.1753999413041;
        Thu, 31 Jul 2025 15:03:33 -0700 (PDT)
Received: from Yueyangs-MacBook-Pro.local (vpn-254-003.epfl.ch. [128.179.254.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c80sm3623933f8f.43.2025.07.31.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:03:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:03:29 +0100
From: YUEYANG PAN <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon: Add damos_stat support for vaddr
Message-ID: <aIvoMbici26ekErC@Yueyangs-MacBook-Pro.local>
References: <c05b1b4f66758c0154e4d037adcb15c43917f38b.1753895066.git.pyyjason@gmail.com>
 <20250730175652.60173-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730175652.60173-1-sj@kernel.org>

On Wed, Jul 30, 2025 at 10:56:52AM -0700, SeongJae Park wrote:
> On Wed, 30 Jul 2025 10:19:56 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > This patch adds support for damos_stat in virtual address space.
> > It leverages the walk_page_range to walk the page table and gets
> > the folio from page table. The last folio scanned is stored in
> > damos->last_applied to prevent double counting.
> > 
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/damon/vaddr.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 104 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 87e825349bdf..6ed919e817e2 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -890,6 +890,109 @@ static unsigned long damos_va_migrate(struct damon_target *target,
> >  	return applied * PAGE_SIZE;
> >  }
> >  
> > +struct damos_va_stat_private {
> > +	struct damos *scheme;
> > +	unsigned long *sz_filter_passed;
> > +};
> > +
> > +static inline bool damon_va_invalid_damos_folio(struct folio *folio, struct damos *s)
> 
> Weirdly DAMON code usually keeps the 80 columns limit.  Could you please break
> down this line?
> 
> Also, the name feels long to me.  What about damos_va_invalid_folio()?
> 

Thanks. I will fix it in the next version.

> > +{
> > +	return !folio || folio == s->last_applied;
> > +}
> > +
> > +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> > +{
> > +	struct damos_va_stat_private *priv = walk->private;
> > +	struct damos *s = priv->scheme;
> > +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> > +	struct vm_area_struct *vma = walk->vma;
> > +	struct folio *folio;
> > +	spinlock_t *ptl;
> > +	pte_t *start_pte, *pte, ptent;
> > +	int nr;
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	if (pmd_trans_huge(*pmd)) {
> > +		pmd_t pmde;
> > +
> > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > +		if (!ptl)
> > +			return 0;
> > +		pmde = pmdp_get(pmd);
> > +		if (!pmd_present(pmde))
> > +			goto huge_unlock;
> > +
> > +		folio = vm_normal_folio_pmd(vma, addr, pmde);
> > +
> > +		if (damon_va_invalid_damos_folio(folio, s))
> > +			goto huge_unlock;
> > +
> > +		if (!damos_va_filter_out(s, folio, vma, addr, NULL, pmd))
> > +			*sz_filter_passed += folio_size(folio);
> > +		s->last_applied = folio;
> > +
> > +huge_unlock:
> > +		spin_unlock(ptl);
> > +		return 0;
> > +	}
> > +#endif
> > +	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	if (!start_pte)
> > +		return 0;
> > +
> > +	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
> > +		nr = 1;
> > +		ptent = ptep_get(pte);
> > +
> > +		if (pte_none(ptent) || !pte_present(ptent))
> > +			continue;
> > +
> > +		folio = vm_normal_folio(vma, addr, ptent);
> > +
> > +		if (damon_va_invalid_damos_folio(folio, s))
> > +			continue;
> > +
> > +		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
> > +			*sz_filter_passed += folio_size(folio);
> > +		nr = folio_nr_pages(folio);
> > +		s->last_applied = folio;
> > +	}
> > +
> > +	pte_unmap_unlock(start_pte, ptl);
> > +
> 
> No strong opinion, but I'd like to drop above two blank lines (one after the
> for loop, and one after pte_unmap_unlock() if you don't mind.
> 

Will remove it in the next version.

> > +	return 0;
> > +}
> > +
> > +static unsigned long damos_va_stat(struct damon_target *target,
> > +		struct damon_region *r, struct damos *s,
> > +		unsigned long *sz_filter_passed)
> > +{
> > +
> 
> Seems this is unnecessary blank line.  Let's remove it.

Will remove it in the next version.

> 
> > +	struct damos_va_stat_private priv;
> > +	struct mm_struct *mm;
> > +	struct mm_walk_ops walk_ops = {
> > +		.pmd_entry = damos_va_stat_pmd_entry,
> > +		.walk_lock = PGWALK_RDLOCK,
> > +	};
> > +
> > +	priv.scheme = s;
> > +	priv.sz_filter_passed = sz_filter_passed;
> > +
> > +	if (!damon_scheme_has_filter(s))
> > +		return 0;
> > +
> > +	mm = damon_get_mm(target);
> > +	if (!mm)
> > +		return 0;
> > +
> > +	mmap_read_lock(mm);
> > +	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
> > +	mmap_read_unlock(mm);
> > +	mmput(mm);
> > +	return 0;
> > +}
> > +
> >  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >  		struct damon_target *t, struct damon_region *r,
> >  		struct damos *scheme, unsigned long *sz_filter_passed)
> > @@ -916,7 +1019,7 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >  	case DAMOS_MIGRATE_COLD:
> >  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
> >  	case DAMOS_STAT:
> > -		return 0;
> > +		return damos_va_stat(t, r, scheme, sz_filter_passed);
> >  	default:
> >  		/*
> >  		 * DAMOS actions that are not yet supported by 'vaddr'.
> > -- 
> > 2.47.3
> 
> 
> Thanks,
> SJ

Best Wishes
Pan

