Return-Path: <linux-kernel+bounces-775187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E282CB2BC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA97188CB22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE02311591;
	Tue, 19 Aug 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/EBz61F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD34286422
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593799; cv=none; b=RwNeZCmhq3oaq2VWQl07OzzRKiTqDDsOtZY4Gh+sigwOUf6+TeWbDPKuSqLNdyPzOkt/mdC7ItvCUBD/9Vg0hnFBpEPLCpK15vviE/sqZZOj7ZDX02BU37/bKL/Q4pMdDPf3n9M+Lvt7BzhjkuTjvh/z0v40sazZKt0O/K1THuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593799; c=relaxed/simple;
	bh=+9+nYZEEg+Neh/L38A5bN1p9F4RyH1s/bG69HtLDK6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWrsB4X3w+thnm4eQc9rASEla1NjK4SpaTDVMjuGlHgYmRjOGGYqKlObW2TRNukcAbVWhCda/pPV1goF3jh2wpPPg26B0Krs5dxpnog0GSMeyK+7Cvr9HHPtDzneDL6/RO0BTtjPU5a5us1stedEPWnGQOYNdQEo/yb9XzC30VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/EBz61F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755593797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ibUK4q/Rvy3c7fBEbcTRGpKubTCINpqdPqllT/qlSY=;
	b=J/EBz61FtuILNCyjEQcdn+qDf9tj+MJNqPa6XkymZetA4m61FWYTC0OtYsfXJhMIawful5
	29DeiPaOJzThHwm4gTMCLHuSnynzrTDvXHTBZjPazxNGoe2scMN26FxkC5V7YbG9pG+eLT
	Fb6DDwHQVVCz8IYLumZbKMZ+yC/Eejo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-1ws7qeZ_Mk-k-aFR6OJIpA-1; Tue,
 19 Aug 2025 04:56:33 -0400
X-MC-Unique: 1ws7qeZ_Mk-k-aFR6OJIpA-1
X-Mimecast-MFC-AGG-ID: 1ws7qeZ_Mk-k-aFR6OJIpA_1755593791
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB162180048E;
	Tue, 19 Aug 2025 08:56:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.239])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C2291800280;
	Tue, 19 Aug 2025 08:56:29 +0000 (UTC)
Date: Tue, 19 Aug 2025 16:56:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aKQ8OY04a0ACqZ2O@MiWiFi-R3L-srv>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-7-urezki@gmail.com>
 <aKKqOzepmIkOJi3i@MiWiFi-R3L-srv>
 <aKMkgbZqOqyGVF1C@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKMkgbZqOqyGVF1C@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/18/25 at 03:02pm, Uladzislau Rezki wrote:
> On Mon, Aug 18, 2025 at 12:21:15PM +0800, Baoquan He wrote:
> > On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
> > > __vmalloc_area_node() may call free_vmap_area() or vfree() on
> > > error paths, both of which can sleep. This becomes problematic
> > > if the function is invoked from an atomic context, such as when
> > > GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.
> > > 
> > > To fix this, unify error paths and defer the cleanup of partly
> > > initialized vm_struct objects to a workqueue. This ensures that
> > > freeing happens in a process context and avoids invalid sleeps
> > > in atomic regions.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  include/linux/vmalloc.h |  6 +++++-
> > >  mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
> > >  2 files changed, 36 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > index fdc9aeb74a44..b1425fae8cbf 100644
> > > --- a/include/linux/vmalloc.h
> > > +++ b/include/linux/vmalloc.h
> > > @@ -50,7 +50,11 @@ struct iov_iter;		/* in uio.h */
> > >  #endif
> > >  
> > >  struct vm_struct {
> > > -	struct vm_struct	*next;
> > > +	union {
> > > +		struct vm_struct *next;	  /* Early registration of vm_areas. */
> > > +		struct llist_node llnode; /* Asynchronous freeing on error paths. */
> > > +	};
> > > +
> > >  	void			*addr;
> > >  	unsigned long		size;
> > >  	unsigned long		flags;
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 7f48a54ec108..2424f80d524a 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3680,6 +3680,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  	return nr_allocated;
> > >  }
> > >  
> > > +static LLIST_HEAD(pending_vm_area_cleanup);
> > > +static void cleanup_vm_area_work(struct work_struct *work)
> > > +{
> > > +	struct vm_struct *area, *tmp;
> > > +	struct llist_node *head;
> > > +
> > > +	head = llist_del_all(&pending_vm_area_cleanup);
> > > +	if (!head)
> > > +		return;
> > > +
> > > +	llist_for_each_entry_safe(area, tmp, head, llnode) {
> > > +		if (!area->pages)
> > > +			free_vm_area(area);
> > > +		else
> > > +			vfree(area->addr);
> > > +	}
> > > +}
> > > +
> > > +/*
> > > + * Helper for __vmalloc_area_node() to defer cleanup
> > > + * of partially initialized vm_struct in error paths.
> > > + */
> > > +static DECLARE_WORK(cleanup_vm_area, cleanup_vm_area_work);
> > > +static void defer_vm_area_cleanup(struct vm_struct *area)
> > > +{
> > > +	if (llist_add(&area->llnode, &pending_vm_area_cleanup))
> > > +		schedule_work(&cleanup_vm_area);
> > > +}
> > 
> > Wondering why here we need call schudule_work() when
> > pending_vm_area_cleanup was empty before adding new entry. Shouldn't
> > it be as below to schedule the job? Not sure if I miss anything.
> > 
> > 	if (!llist_add(&area->llnode, &pending_vm_area_cleanup))
> > 		schedule_work(&cleanup_vm_area);
> > 
> > =====
> > /**
> >  * llist_add - add a new entry
> >  * @new:        new entry to be added
> >  * @head:       the head for your lock-less list
> >  *
> >  * Returns true if the list was empty prior to adding this entry.
> >  */
> > static inline bool llist_add(struct llist_node *new, struct llist_head *head)
> > {
> >         return llist_add_batch(new, new, head);
> > }
> > =====
> > 
> But then you will not schedule. If the list is empty, we add one element
> llist_add() returns 1, but your condition expects 0.
> 
> How it works:
> 
> If someone keeps adding to the llist and it is not empty we should not
> trigger a new work, because a current work is in flight(it will cover new comers),
> i.e. it has been scheduled but it has not yet completed llist_del_all() on
> the head.
> 
> Once it is done, a new comer will trigger a work again only if it sees NULL,
> i.e. when the list is empty.

Fair enough. I thought it's a deferring work, in fact it's aiming to put the
error handling in a workqueue, but not the current atomic context.
Thanks for the explanation.


