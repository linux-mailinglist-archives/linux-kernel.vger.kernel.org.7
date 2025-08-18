Return-Path: <linux-kernel+bounces-773633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF98B2A359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1963BBBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0AD31B13B;
	Mon, 18 Aug 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5/NRvoV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AC31B13A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522184; cv=none; b=XU0HYaP7+R0v9Oya3+Puah/J4m6dVIPR2L0jHPLCSdGw+3Ch7XQ8M4KTEl97nAJhHyBld6wIDbOEt2QHUMYHCOyl6bMA+7d5s9Oaf9JIAsiP0NxHwN5SEEi1jguMM0ljJyfWBDuOVmqmRHf7ySIMoC+qCAfj6sS85LpiWbrLUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522184; c=relaxed/simple;
	bh=JTs0W6lHAVyuzN8xnxnUT3kvdfwe12IJyOvr6W+SMdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9aA/6+fkaoeVZnwGapZX/cFBj6PWV8hWpIZEPlfCrHFgp464jzwz+oTOmIrOgY3Qf0yIeNe+sQZe0LtBkmIrYIByZ0VSyfPdiCZ5MgbpehzpXv7vLhWKLprPDAv6xWbzFu1oMYYj/JpL+ILyKXLWt1fQX+FSbX7AzcejigH9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5/NRvoV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce521e3f4so4329966e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755522181; x=1756126981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3320BK4UjE6OyHLCSJqllLZxnZ3YLJ0DY3DQ48ebuA=;
        b=k5/NRvoVuvca6quCMfpcpnq0VAzkVfP5LV4YdvnIOSKwEQ1KNYnFFRouOypNjodekM
         7SL3tZS0IdDQBQKst/W9ir0/1fK6YCd0rTOsUMmN3GhUrHGs2GNVDVMIbXbj1yKDrYCK
         bjwTiP3tugrh6D3oU+B1aPYlWcKE0dxB4XCSq0iABgdH1rqtkoZYglmekjX4m5Z9NFAl
         rkn9JfQrcjYAiZymd7K8zHhJJgvcAqwDT5J4T3HE6gH5YClyirnKXXNK0n76WZb0MJZu
         n0sT3nQ3oxALKXWYfEcKKGaWUHl9bjlpUCK8A/b25eRIl19KaJnZckGzWiu0lmDnHKCm
         zDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522181; x=1756126981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3320BK4UjE6OyHLCSJqllLZxnZ3YLJ0DY3DQ48ebuA=;
        b=wHoglxx0wpybSRAhA0PpylOE3Oirfv1PxGVSQOglSlZRzRrmVnSmFORYut+ziLvPuO
         D3MddiQPcOW3tO3G3QK7zfgyr8hPvr1sMZTHAzfsTd0U3u1khxh2fEtwHZdLSW4l55Sw
         n4BHW7QWUHzruWZk0B9+o1MPDlEb8+fd8hPj/5/VageQER/AdQiEAIiYT3RStkIcL30p
         A5aSdpQiX6Pmc481Ohg9+S1XLoYQT901oM+8fkXAfkRMpvWD3zMYf9CtCw15hHDS2EJI
         qGrOcYLHRA3L6FVPgmCILUEW20uQikJTk3LVYqoP+JY2Frv3D2/hKZT662xgxr93HvAL
         we8A==
X-Forwarded-Encrypted: i=1; AJvYcCUU3KoKi6x1sYTW0OB5JDKY9AKxm1cmzeNO500ZPGztlxVmuK5sgmmtilcWmkFrSyAEkcxk1wNLIrAtPnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwGYNPh3bRL8X6awhcdFbqafLBYUv0ttvVeYxxUMssaTAumJ7
	fxzO+Dy5unMZLJrHE8FyJ2+rpy9jpw2AC8rngdPSNrdYp3JBIEPh8fsT
X-Gm-Gg: ASbGncspleMaGVVwaxctaQ0ljxWDFMM0yMicjzxFBntDZLh59pTG5HxgKwO+xtZV5kb
	80lSVcrFF4h52TuSNnOTLunbZEvLqOWIiHX+sfEQvij0z2/wnhUvuLd9qcfWd3zBLF3YcDR5EGb
	hsLIP8ohrPvglkN71fkvNkOxZOHpLfKjsqmxomHbu+3uIPpg+++V+hsI/wvd0HAJtjrch2tPcdi
	ppf4sOY1udNKisN/+rYF7k2K1MUJ+mfVU8BplfKrjyUy8NkzwXM+BTjUpM+Lff2+5RsRlR4bOhR
	SxTp6A8rdbWSNIixF6l6XE9fhgO/shwnuk9AKXzI8BsrE9BvJLDmVIQBF7Xb243A+7COROaFi2M
	tdSmey3I+lOHHoSQPgSYRlgEYZgHKRV2tC3ZIakMLr9nuGbeWBw==
X-Google-Smtp-Source: AGHT+IHPt8BW77Sasv2GQ2o82GG6OIRFMes+gxViL8svV3Q8tU1FS/eEHwj1S0vl3tUszMV3QbJImw==
X-Received: by 2002:a05:6512:31d4:b0:55c:ad2a:aa7c with SMTP id 2adb3069b0e04-55ceeadaa9dmr3146938e87.22.1755522180344;
        Mon, 18 Aug 2025 06:03:00 -0700 (PDT)
Received: from pc636 (host-95-203-21-145.mobileonline.telia.com. [95.203.21.145])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef459facsm1671958e87.157.2025.08.18.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:02:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 18 Aug 2025 15:02:57 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aKMkgbZqOqyGVF1C@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-7-urezki@gmail.com>
 <aKKqOzepmIkOJi3i@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKKqOzepmIkOJi3i@MiWiFi-R3L-srv>

On Mon, Aug 18, 2025 at 12:21:15PM +0800, Baoquan He wrote:
> On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
> > __vmalloc_area_node() may call free_vmap_area() or vfree() on
> > error paths, both of which can sleep. This becomes problematic
> > if the function is invoked from an atomic context, such as when
> > GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.
> > 
> > To fix this, unify error paths and defer the cleanup of partly
> > initialized vm_struct objects to a workqueue. This ensures that
> > freeing happens in a process context and avoids invalid sleeps
> > in atomic regions.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/vmalloc.h |  6 +++++-
> >  mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
> >  2 files changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index fdc9aeb74a44..b1425fae8cbf 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -50,7 +50,11 @@ struct iov_iter;		/* in uio.h */
> >  #endif
> >  
> >  struct vm_struct {
> > -	struct vm_struct	*next;
> > +	union {
> > +		struct vm_struct *next;	  /* Early registration of vm_areas. */
> > +		struct llist_node llnode; /* Asynchronous freeing on error paths. */
> > +	};
> > +
> >  	void			*addr;
> >  	unsigned long		size;
> >  	unsigned long		flags;
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 7f48a54ec108..2424f80d524a 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3680,6 +3680,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  	return nr_allocated;
> >  }
> >  
> > +static LLIST_HEAD(pending_vm_area_cleanup);
> > +static void cleanup_vm_area_work(struct work_struct *work)
> > +{
> > +	struct vm_struct *area, *tmp;
> > +	struct llist_node *head;
> > +
> > +	head = llist_del_all(&pending_vm_area_cleanup);
> > +	if (!head)
> > +		return;
> > +
> > +	llist_for_each_entry_safe(area, tmp, head, llnode) {
> > +		if (!area->pages)
> > +			free_vm_area(area);
> > +		else
> > +			vfree(area->addr);
> > +	}
> > +}
> > +
> > +/*
> > + * Helper for __vmalloc_area_node() to defer cleanup
> > + * of partially initialized vm_struct in error paths.
> > + */
> > +static DECLARE_WORK(cleanup_vm_area, cleanup_vm_area_work);
> > +static void defer_vm_area_cleanup(struct vm_struct *area)
> > +{
> > +	if (llist_add(&area->llnode, &pending_vm_area_cleanup))
> > +		schedule_work(&cleanup_vm_area);
> > +}
> 
> Wondering why here we need call schudule_work() when
> pending_vm_area_cleanup was empty before adding new entry. Shouldn't
> it be as below to schedule the job? Not sure if I miss anything.
> 
> 	if (!llist_add(&area->llnode, &pending_vm_area_cleanup))
> 		schedule_work(&cleanup_vm_area);
> 
> =====
> /**
>  * llist_add - add a new entry
>  * @new:        new entry to be added
>  * @head:       the head for your lock-less list
>  *
>  * Returns true if the list was empty prior to adding this entry.
>  */
> static inline bool llist_add(struct llist_node *new, struct llist_head *head)
> {
>         return llist_add_batch(new, new, head);
> }
> =====
> 
But then you will not schedule. If the list is empty, we add one element
llist_add() returns 1, but your condition expects 0.

How it works:

If someone keeps adding to the llist and it is not empty we should not
trigger a new work, because a current work is in flight(it will cover new comers),
i.e. it has been scheduled but it has not yet completed llist_del_all() on
the head.

Once it is done, a new comer will trigger a work again only if it sees NULL,
i.e. when the list is empty.

--
Uladzislau Rezki

