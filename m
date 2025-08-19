Return-Path: <linux-kernel+bounces-775253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC19B2BD33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFF65A09F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8697831E0E3;
	Tue, 19 Aug 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+Nd90Jw"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5531A054
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595250; cv=none; b=J746nWC99sWZBvFbUAfh+XMEkbaLWOK0gG4f68COfrYeuqKASnghTUKy7+rOVL9tb/WljH8Su/JRcG81XlQeIJcQZKCgeSeUM3hgSc7lCi+iK4fmkgxerFMWuYYMvlATjrT6l57MELHWzdf7rk9i22V724bYPihtrVXbMruTHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595250; c=relaxed/simple;
	bh=Qc5T7Kw7DigcgycnygWRUIUNL+uDn/3jZfVpheN0BFs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjGoWRiFT9N7ZH/oduKuWRP7dHb1cuXTg+2Rp7WWcSOZRD9+hq1WFdcTow4maUD/mh8CVyZNr18NOnPPUP4KmOaI7J3AmSEcVsvDbEek0JzXs+SG79Y/0FlHnA96SNAQLwAnGrKNwB67Hkory2SFKDonmQRRGHi4n4UTIay9lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+Nd90Jw; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce5243f6dso5516148e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755595247; x=1756200047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEkCJ0gLjfLsaSogQOFyJQAfkvjUuZ4XqQ+SkU//zU0=;
        b=G+Nd90JwqbEuLqwHZF2i9KfzJr6SMyZe4iFgT/Kbf7EPl7oKmj1LfNAT74wnwNTr1w
         ZZxUj5o+I7a2xNnfzYUYTmwAw2+7cacrf19hPKpshZzmHeA4xYRumwyUwOE+q9tcOUC3
         8+fgPQM/AJFRHLKFrE4Lyf61oetpFmMLtCLAqxZI8BMVMC1BiG1BtWSPyxcr0OhMjFU6
         nMpQASTnxcdcNiK1RmlNzEa42pw+SThPsphxnH6PNSWhS7W+GSDSIvh9aUrvBZGC1aMv
         vjTAZTw74Exn4s/YfyUzKHF3pfWf15e6b8HqAiPiKbT1gsd06Lp84NPdkg3UWRQ+TC3P
         uQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595247; x=1756200047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEkCJ0gLjfLsaSogQOFyJQAfkvjUuZ4XqQ+SkU//zU0=;
        b=X/9LwrFmru/dJzclHG05h0waxxTEaPO3H+bcsWHrCTvQ7C++6YkO3w1L5G7vDf6XNg
         E5Ksogp9wOXzGs8UNgyPjrg79gF2r2udR+/JanjKMBDRIapCr9rs0KWEzUjOmQo7YzES
         dFVP7Go9cem2M5ygMkHhFYHzVTgWD6Kk6tZYKsAqg0L3J+p1/h5zH95eTROBNGxbH8Xe
         2iWZhqR10E2HXmnzjL2GTAvlHwnEQSZ1+WpjccnQq/bqM3VIqkY3aTOXbzlJgpQoJzzr
         HWmKZV1GtNqosb9XBt/Nnmb6p5Tj+qBevn/NMTEABVwBU06aMzT2qQBLO4y7r0Qvmb7f
         S8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW5YSHuMI5iISyiN2p14HF5j8Gq6eUUWbc4q9+83RZFArYXqJt7eGhOViLXEFCmUGghgAhKqz54QP7jz/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpKnSZmnVp/r641+NCTYzWUNXpBgPiPuzYVk9m768YlraZ55k
	rfyYneYBQBoXDwSMPNySxiKs2dprWNjlsXxYiaNyF6ssgXVkt2FQ6jms
X-Gm-Gg: ASbGnctZCxANcBmgx/o1hqBZEh5YybY/X3zgmBrNbldnLySe3+ZAgnWIcronSRZAyET
	oDPhcFaYte3PRpA46R9aISC6FsQ2DbtAqoNe4fkAxJMI8l4WZhKL2S+Ap1BxCM/8RrSVsZj/sZb
	EqrpS1xS6Sp29+NgFAdUfvxe7Q3sKllkpdlt8PkeMqMpsrh6GsAZbzwC37ajnlINX9jk83/rVPA
	vPawTSHqqPxcmgMYjvNZ9P07JjVGv2WqTLSNaKtOyIJVxZY+2ZrLyazTDIt1b04Y/hYXNJdlXVq
	ubPK+GAYk6QhKShNEWK8sMC6iQEiPQEh59dvNANeXGLanWBex5MNvhqmFIFqoZ3f7LLMnWST3sV
	Eps9tV6keX4c66AwwdITSdz6P64gEeRS8qZRyyW+Konupi+3l3g==
X-Google-Smtp-Source: AGHT+IGDpm17FTp2jgQoAPGgKW0MpOUHKhiVhhQj6NkOKyY/3ejMthbZqvf940McsZft3+q3S9XyMw==
X-Received: by 2002:a05:6512:3b20:b0:553:2311:e1f6 with SMTP id 2adb3069b0e04-55e00864624mr518355e87.49.1755595246570;
        Tue, 19 Aug 2025 02:20:46 -0700 (PDT)
Received: from pc636 (host-95-203-27-238.mobileonline.telia.com. [95.203.27.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3516dfsm2030389e87.8.2025.08.19.02.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:20:45 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 19 Aug 2025 11:20:43 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aKRB6xmFHYp8pnYs@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-7-urezki@gmail.com>
 <aKKqOzepmIkOJi3i@MiWiFi-R3L-srv>
 <aKMkgbZqOqyGVF1C@pc636>
 <aKQ8OY04a0ACqZ2O@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKQ8OY04a0ACqZ2O@MiWiFi-R3L-srv>

On Tue, Aug 19, 2025 at 04:56:25PM +0800, Baoquan He wrote:
> On 08/18/25 at 03:02pm, Uladzislau Rezki wrote:
> > On Mon, Aug 18, 2025 at 12:21:15PM +0800, Baoquan He wrote:
> > > On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
> > > > __vmalloc_area_node() may call free_vmap_area() or vfree() on
> > > > error paths, both of which can sleep. This becomes problematic
> > > > if the function is invoked from an atomic context, such as when
> > > > GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.
> > > > 
> > > > To fix this, unify error paths and defer the cleanup of partly
> > > > initialized vm_struct objects to a workqueue. This ensures that
> > > > freeing happens in a process context and avoids invalid sleeps
> > > > in atomic regions.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  include/linux/vmalloc.h |  6 +++++-
> > > >  mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
> > > >  2 files changed, 36 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > > index fdc9aeb74a44..b1425fae8cbf 100644
> > > > --- a/include/linux/vmalloc.h
> > > > +++ b/include/linux/vmalloc.h
> > > > @@ -50,7 +50,11 @@ struct iov_iter;		/* in uio.h */
> > > >  #endif
> > > >  
> > > >  struct vm_struct {
> > > > -	struct vm_struct	*next;
> > > > +	union {
> > > > +		struct vm_struct *next;	  /* Early registration of vm_areas. */
> > > > +		struct llist_node llnode; /* Asynchronous freeing on error paths. */
> > > > +	};
> > > > +
> > > >  	void			*addr;
> > > >  	unsigned long		size;
> > > >  	unsigned long		flags;
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 7f48a54ec108..2424f80d524a 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3680,6 +3680,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > > >  	return nr_allocated;
> > > >  }
> > > >  
> > > > +static LLIST_HEAD(pending_vm_area_cleanup);
> > > > +static void cleanup_vm_area_work(struct work_struct *work)
> > > > +{
> > > > +	struct vm_struct *area, *tmp;
> > > > +	struct llist_node *head;
> > > > +
> > > > +	head = llist_del_all(&pending_vm_area_cleanup);
> > > > +	if (!head)
> > > > +		return;
> > > > +
> > > > +	llist_for_each_entry_safe(area, tmp, head, llnode) {
> > > > +		if (!area->pages)
> > > > +			free_vm_area(area);
> > > > +		else
> > > > +			vfree(area->addr);
> > > > +	}
> > > > +}
> > > > +
> > > > +/*
> > > > + * Helper for __vmalloc_area_node() to defer cleanup
> > > > + * of partially initialized vm_struct in error paths.
> > > > + */
> > > > +static DECLARE_WORK(cleanup_vm_area, cleanup_vm_area_work);
> > > > +static void defer_vm_area_cleanup(struct vm_struct *area)
> > > > +{
> > > > +	if (llist_add(&area->llnode, &pending_vm_area_cleanup))
> > > > +		schedule_work(&cleanup_vm_area);
> > > > +}
> > > 
> > > Wondering why here we need call schudule_work() when
> > > pending_vm_area_cleanup was empty before adding new entry. Shouldn't
> > > it be as below to schedule the job? Not sure if I miss anything.
> > > 
> > > 	if (!llist_add(&area->llnode, &pending_vm_area_cleanup))
> > > 		schedule_work(&cleanup_vm_area);
> > > 
> > > =====
> > > /**
> > >  * llist_add - add a new entry
> > >  * @new:        new entry to be added
> > >  * @head:       the head for your lock-less list
> > >  *
> > >  * Returns true if the list was empty prior to adding this entry.
> > >  */
> > > static inline bool llist_add(struct llist_node *new, struct llist_head *head)
> > > {
> > >         return llist_add_batch(new, new, head);
> > > }
> > > =====
> > > 
> > But then you will not schedule. If the list is empty, we add one element
> > llist_add() returns 1, but your condition expects 0.
> > 
> > How it works:
> > 
> > If someone keeps adding to the llist and it is not empty we should not
> > trigger a new work, because a current work is in flight(it will cover new comers),
> > i.e. it has been scheduled but it has not yet completed llist_del_all() on
> > the head.
> > 
> > Once it is done, a new comer will trigger a work again only if it sees NULL,
> > i.e. when the list is empty.
> 
> Fair enough. I thought it's a deferring work, in fact it's aiming to put the
> error handling in a workqueue, but not the current atomic context.
> Thanks for the explanation.
> 
You are welcome!

--
Uladzislau Rezki

