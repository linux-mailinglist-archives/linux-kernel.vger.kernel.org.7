Return-Path: <linux-kernel+bounces-842997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3DBBE29B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4595E4ECAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9B2C2348;
	Mon,  6 Oct 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1pvyMU2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1829B795
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756680; cv=none; b=Aikw6OxMw50OSkoBYNilQkObouB0UhQxMylsbFELkTT5tbUFEIHx9fPiEvC72eitlDMqzzK4XqoCebFGaKfYgxyYZbOdsAvOzloOrmO/LZcLxvc0c7eQi0kGUvXdO9Ma++Q4aOU6JGSno30NY9BDIzBh3ukz8mRCXkauunWgGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756680; c=relaxed/simple;
	bh=vsSiQVrh3nzcSlfZWwB6HcISIunXtsgk8HCL7lkE0zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbA2kQ4VFuUf2kI3/jo6IqGES+KYAdyFV7BcY1ZrCvCGVM+85qolwDtt4s4q0FZmm1I0Fa26ySo+4c9/mf3xpK0isBykFkLZubVSASThkT+tnq/jLaVosD/y+rfzw4a3LfXqJKY5EKtJAZRqRj9UiXBDgrpP/mcFHeGbLV0w3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1pvyMU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759756677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri2DELPIwhaBKWXFIOC1/rmQDv00iRt2WIKKCb24pLE=;
	b=M1pvyMU27Bg4j/bZCVCt3TC3GAm6K8iM28Qra+Z6zplMC5OpAfVgx5EFz92whvMryQv5uC
	3kHQrAgZCMaBDIuOav3o1cDcqbrUkp35ITgmtKQp8RlAyZaQNVaDsev1uZ74uOdl3Q0+eK
	ZOiHIepjmLpSz1sJx4peyDaFaM7azjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-d1HY6wbQNOOKqh6vD3C4TA-1; Mon,
 06 Oct 2025 09:17:52 -0400
X-MC-Unique: d1HY6wbQNOOKqh6vD3C4TA-1
X-Mimecast-MFC-AGG-ID: d1HY6wbQNOOKqh6vD3C4TA_1759756671
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C07F8180057A;
	Mon,  6 Oct 2025 13:17:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 872961800446;
	Mon,  6 Oct 2025 13:17:49 +0000 (UTC)
Date: Mon, 6 Oct 2025 21:17:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 09/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aOPBePFxNk5FP/ru@MiWiFi-R3L-srv>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-10-urezki@gmail.com>
 <aOCejd0aghFS8iSO@MiWiFi-R3L-srv>
 <aOCqSrnazd2YwGbe@MiWiFi-R3L-srv>
 <aOOUlW0SbBcPM6Mq@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOOUlW0SbBcPM6Mq@milan>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/06/25 at 12:06pm, Uladzislau Rezki wrote:
> On Sat, Oct 04, 2025 at 01:02:02PM +0800, Baoquan He wrote:
> > On 10/04/25 at 12:11pm, Baoquan He wrote:
> > > On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> > > > __vmalloc() function now supports non-blocking flags such as
> > > > GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> > > > 
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 21 +++++++++++----------
> > > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index d7e7049e01f8..2b45cd4ce119 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >   * @caller:		  caller's return address
> > > >   *
> > > >   * Allocate enough pages to cover @size from the page level
> > > > - * allocator with @gfp_mask flags. Please note that the full set of gfp
> > > > - * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> > > > - * supported.
> > > > - * Zone modifiers are not supported. From the reclaim modifiers
> > > > - * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> > > > - * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> > > > - * __GFP_RETRY_MAYFAIL are not supported).
> > > > + * allocator with @gfp_mask flags and map them into contiguous
> > > > + * virtual range with protection @prot.
> > > >   *
> > > > - * __GFP_NOWARN can be used to suppress failures messages.
> > > > + * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
> > > > + * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
> > > > + * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
> > > > + * by __vmalloc().
> > > > +
> > > > + * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> > > > + * and %__GFP_RETRY_MAYFAIL are not supported.
> > > 
> > > Do we need to update the documentation of __vmalloc_node_noprof()
> > > accordingly? I see it has below description about "Retry modifiers"
> > > where gfp_mask is passed down to __vmalloc_node_range_noprof() directly
> > > but have different description. Not sure if I missed anything.
> > > 
> > > ===
> > >  * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> > >  * and %__GFP_RETRY_MAYFAIL are not supported.
> > > ===
> > 
> > Sorry, I copied the wrong sentences. Below is copied from documentation
> > of __vmalloc_node_noprof().
> > ====
> >  * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
> >  * and __GFP_NOFAIL are not supported
> > ====
> > 
> > 
> > > 
> > > >   *
> > > > - * Map them into contiguous kernel virtual space, using a pagetable
> > > > - * protection of @prot.
> > > > + * %__GFP_NOWARN can be used to suppress failure messages.
> > > >   *
> > > > + * Can not be called from interrupt nor NMI contexts.
> > > >   * Return: the address of the area or %NULL on failure
> > > >   */
> > > >  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > > > -- 
> > > > 2.47.3
> > > > 
> > > 
> > 
> We need. But i am not sure it should be fully copy-pasted from the
> __vmalloc_node_range_noprof(). At least __GFP_NOFAIL is supported
> and thus stating that it is not - is wrong.
> 
> It has to be fixed but not by this series because when __GFP_NOFAIL
> support was introduced the doc. should have to be updated accordingly.

Maybe just remove the documentation for __vmalloc_node_noprof() since
it's only a wrapper of __vmalloc_node_range_noprof()? Surely this should
be done in another standalone patch later.


