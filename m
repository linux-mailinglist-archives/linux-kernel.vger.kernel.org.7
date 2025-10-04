Return-Path: <linux-kernel+bounces-841951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E6BB89B2
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 07:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE019C5E56
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 05:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D14B13AD05;
	Sat,  4 Oct 2025 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJ3lcIhW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C21BC3F
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759554137; cv=none; b=Dc5RzlB8S4cyaXGhdzWF2om3uKeq4lV4mmQykv8OqeKkh5nzmy/zJfZchWoZSZ+yttRahDqKoKKYcavCj0XbseAasfj0NQajin7agbi9EF3GfIlAPjwOgnJwharsyKd5WjQQqT71qe5BLRF+ku6acSHeYCoHCdAnl2p8ZiydDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759554137; c=relaxed/simple;
	bh=1t7i744FUBUZ601QPjmYN5M51F89CMiO5K2HbhP2RVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0hN7aplJHbB36bSlmCBmWjys1qNnqcUspxxygfpHDZJxbORrP/Ca124XsDts1VgsMhWCiP8idwYiaIbBisHMN/4aqx9UjM070YDgUvTElJEmjIGBcl2rv6lfeHdj9OMvhDaEosgv+PUsO+kQYQC4NXV3FTpDO4sjkNITY/4alc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJ3lcIhW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759554133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Fi8ohMDCZZaoOzqYB+KAWWzm8L5357GBKGgTQreZfQ=;
	b=DJ3lcIhW17dUclZfl2wCaxFLHoArqiP3Dodf2/4/e9Gv9C1/NxshDK50U2V95JBB41PB9v
	q7I6HovO2lK3fNGr4GPJPfQJ0oQIGQrCD1HxXVw0ABZYezCMrImDARBppS1bDbl29SfMCd
	SAbhzEb9yXw4Ec8tzy2LvFhovUsCZSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-3m9Wgzl7NXe26kQtiArzcQ-1; Sat,
 04 Oct 2025 01:02:10 -0400
X-MC-Unique: 3m9Wgzl7NXe26kQtiArzcQ-1
X-Mimecast-MFC-AGG-ID: 3m9Wgzl7NXe26kQtiArzcQ_1759554128
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AEBF18004D8;
	Sat,  4 Oct 2025 05:02:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDC6B1955F19;
	Sat,  4 Oct 2025 05:02:06 +0000 (UTC)
Date: Sat, 4 Oct 2025 13:02:02 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 09/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aOCqSrnazd2YwGbe@MiWiFi-R3L-srv>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-10-urezki@gmail.com>
 <aOCejd0aghFS8iSO@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOCejd0aghFS8iSO@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/04/25 at 12:11pm, Baoquan He wrote:
> On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> > __vmalloc() function now supports non-blocking flags such as
> > GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d7e7049e01f8..2b45cd4ce119 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >   * @caller:		  caller's return address
> >   *
> >   * Allocate enough pages to cover @size from the page level
> > - * allocator with @gfp_mask flags. Please note that the full set of gfp
> > - * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> > - * supported.
> > - * Zone modifiers are not supported. From the reclaim modifiers
> > - * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> > - * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> > - * __GFP_RETRY_MAYFAIL are not supported).
> > + * allocator with @gfp_mask flags and map them into contiguous
> > + * virtual range with protection @prot.
> >   *
> > - * __GFP_NOWARN can be used to suppress failures messages.
> > + * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
> > + * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
> > + * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
> > + * by __vmalloc().
> > +
> > + * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> > + * and %__GFP_RETRY_MAYFAIL are not supported.
> 
> Do we need to update the documentation of __vmalloc_node_noprof()
> accordingly? I see it has below description about "Retry modifiers"
> where gfp_mask is passed down to __vmalloc_node_range_noprof() directly
> but have different description. Not sure if I missed anything.
> 
> ===
>  * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
>  * and %__GFP_RETRY_MAYFAIL are not supported.
> ===

Sorry, I copied the wrong sentences. Below is copied from documentation
of __vmalloc_node_noprof().
====
 * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
 * and __GFP_NOFAIL are not supported
====


> 
> >   *
> > - * Map them into contiguous kernel virtual space, using a pagetable
> > - * protection of @prot.
> > + * %__GFP_NOWARN can be used to suppress failure messages.
> >   *
> > + * Can not be called from interrupt nor NMI contexts.
> >   * Return: the address of the area or %NULL on failure
> >   */
> >  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > -- 
> > 2.47.3
> > 
> 


