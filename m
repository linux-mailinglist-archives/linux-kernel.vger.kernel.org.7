Return-Path: <linux-kernel+bounces-886530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D2C35D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 884C03471F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D633312810;
	Wed,  5 Nov 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbQm4CWN"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DD3148D5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349450; cv=none; b=l9o52vL1YChQH6P58f2aT0cuGFbo+51uaT1fyZkJ9Xq81aLlRcAT1YdMo1tvNHxxO/LmQf6K6w2mdevVX2K7v7LJJArnbZO50Hw7JTPwJsZSwN2Vm0oEzyZlFAWdm0KvT5RKvdGizD/Nk6aTrGvseYQZKQTmbqlcGrwG+VqmWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349450; c=relaxed/simple;
	bh=+eRmvN7Bax5fwqfCBHkD0HiNJ5fBE+W9qtDJPz5REIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLq8ENgDamS7w9UaFgwWRCWgtZRGoFRvFq0rhQQIbllzTTBQXs/YE4osOfuCnYttej3V1qBKfK2+jq/VYBMNV45M9hjFZUQqjkHVxoytjHOaqQ7vkBzQMJ4k+yPiwh2nqHtQZ/bnPf1MLWUEn+xJMPbfA5VFVf1n2u0lp41GxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbQm4CWN; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-656bc794e97so134609eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349448; x=1762954248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuKkAI8xRPtJ5Fw1eOvcnr1+sgWhXNgrcDdCSnmoslQ=;
        b=TbQm4CWNc79D6lvcMo+dnSrDQcJC3afCiz88Z/Q3EKK90iDw9ZftdfIuhlzwx9wcmM
         Z5d8Hs2ZmDAJ8KO1qDGfZHB5tvpLGs34g3Y+ahtshvg7eSFx7NhQCue4ZpfY+w5Ce6y0
         PtOuUm6rs2/s8J69vGcNZE2EQiF9HawHy8tjjR8vCiDhADGgN3A0jiO6oD2cAu+hBdZw
         0gGH16zg0H9xiEvuud6xTxcRyLZVKvvNuE2N1MUiN1/tNd8kW+76/ZdKZ69O8OZfD+6J
         glKCLNTdfZ88FKyT9DC+GQ58/mvvFztxi6qw+FkTTxqvKOOYEGQxxm/4urrSYlxj7rfh
         aktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349448; x=1762954248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuKkAI8xRPtJ5Fw1eOvcnr1+sgWhXNgrcDdCSnmoslQ=;
        b=wKPWcX4xfKAE47hPumlAb7ZAZOllLTBv3fb+TNHpDJ2ABU/5dCa8pThLQRs3cExo/5
         fhFK5jmYRm1YwrMggDifjsrri96352750l/EdJfgp5Jh4TlmnQVv5dIu21EoToRARmiV
         ad/FcsUE7eOAL1omh3mywxO1Xqqu0WhXgW/Ir+iv5cfX6p5eU0rbC47Gkd5saACfoNVm
         2F8cCfVieEDADXRljwq9+yqwR4OA9QCLoRBkXIW8agdUyEtnY/QQHlI36FsXL+y2EiR3
         J13jeiaFMArohIXi8IijTVExDb4j+gpxqqbzeQSIrje6Qo+i6Rr2wfVzvG8xDILbk3GA
         PgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBRKY4JdNF/mLcLo3kuOu3wgzRv92WPQksoTR1T0CFQx1NMKbS+97/Xx5wVW408yqRHXFBDsv18fQT800=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tlDQAgdWe0jdLNL1fYC8Z4ONJtZ4f0Cgs9eq0hxQvAtC+QrG
	vxybXAyHVdxuCgCLwLNNgz2EeobY97xZtPNtmakHgloyJ1L+GRH+SCly
X-Gm-Gg: ASbGnctOOfJ/EJ5gpaBRVSmThGpkAabP3nQ73v6IZLTlEcCbyth4QRDtazi4hGVWbvg
	d5s3fhkyG+ehwwZSAu5nKdHh8nrKUcjj6jJyvH48917GshX4dlPi/7JvZL6YtZe/B6tiRZrLJ0v
	WtnSJtMp3qQZrnFLy6O7HWKuZds6tDgR1NKKOKUxx6yih6yi7R4NwG676xGNxp5TiB6SiN3dM67
	oTbGGSy2abrmLp0ouBgSQvUbZhGGPDDJnWbDuRyCXk40qvXOdebGoI53kr4V/bDWWGTObrpsmf4
	MeqvYaf0tWxv/32v+hpFqVkTj8ugxjcJrNVHUgUY9Pl0TmmynQ3saom5G8y6QltlsVUYhVO0Qh9
	TKXV5Hb95fpKGgz2Kab87ybNa+2kvupnLJNljfqduYvlsvEl3VF49s5Mc+YmGJrb3nQRBWyDdx1
	j3d70JC0qe5kogoDs2TKRj6zyP7iJcB03D4njJa36PMs4C8qPaR1briIg0CjRgOP5I
X-Google-Smtp-Source: AGHT+IFt/l5lO1NOARC/MCGJCb3cYRXCFTcjwE7BDBHrYUQg6rEEKsVOfAXgEudyx1baeVZLQvxmVw==
X-Received: by 2002:a05:6808:158c:b0:43f:6bd2:3a57 with SMTP id 5614622812f47-44fed1f22b0mr1431631b6e.20.1762349448293;
        Wed, 05 Nov 2025 05:30:48 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2 ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44fd84b33ffsm1601874b6e.8.2025.11.05.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:30:47 -0800 (PST)
Date: Wed, 5 Nov 2025 10:28:51 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Revert "mm/ksm: convert break_ksm() from
 walk_page_range_vma() to folio_walk"
Message-ID: <42byvvz55omaszu6ep3g7n2dj5z7mfxy5h3zbc3xjdnslemkpp@kvdzrjz423mb>
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
 <20251031174625.127417-2-pedrodemargomes@gmail.com>
 <a6574561-02bc-4ba6-9fb4-418dcb07cd5f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6574561-02bc-4ba6-9fb4-418dcb07cd5f@kernel.org>

On Mon, Nov 03, 2025 at 06:00:08PM +0100, David Hildenbrand (Red Hat) wrote:
> On 31.10.25 18:46, Pedro Demarchi Gomes wrote:
> > This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
> > function break_ksm_pmd_entry() to use folios.
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
> > index 4f672f4f2140..922d2936e206 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
> >   	return atomic_read(&mm->mm_users) == 0;
> >   }
> > +static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> > +			struct mm_walk *walk)
> > +{
> > +	struct folio *folio = NULL;
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
> > +		folio = vm_normal_folio(walk->vma, addr, ptent);
> > +	} else if (!pte_none(ptent)) {
> > +		swp_entry_t entry = pte_to_swp_entry(ptent);
> > +
> > +		/*
> > +		 * As KSM pages remain KSM pages until freed, no need to wait
> > +		 * here for migration to end.
> > +		 */
> > +		if (is_migration_entry(entry))
> > +			folio = pfn_swap_entry_folio(entry);
> > +	}
> > +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> > +	ret = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(ptent);
> 
> Staring again, we should really call is_ksm_zero_pte() only if we know the
> folio is present.
> 
> It's not super dangerous in the old code (because we would only look at
> present an migration entries), but now you are making it possible to call it
> on even more non-present ptes.
> 

IIUC vm_normal_folio will return NULL in the case of a ksm zero pte, so
we can not do
	found = folio && (folio_test_ksm(folio) || is_ksm_zero_pte(pte))
because it will always be false for a ksm zero pte.
So we should do 
	found = (folio && folio_test_ksm(folio)) || (pte_present(ptent) 
		&& is_ksm_zero_pte(ptent));
since if the pte is present and is a zero pte we can guarantee that
the folio is present.

Sorry if I am missing something.


> -- 
> Cheers
> 
> David
> 

