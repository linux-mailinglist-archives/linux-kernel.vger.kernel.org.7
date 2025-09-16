Return-Path: <linux-kernel+bounces-817930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E0B588EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97111487C03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE21096F;
	Tue, 16 Sep 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/L1rRi7"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A28BEE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981229; cv=none; b=BtJgqTWjPOdyDHwDwqGOaMbHhTVxkriWYAsJDGJRvR1WNJ529zC2BVzQLllQ2dOlpl55yHIwcAC64BJPy55CVJv8scKwVrQ3XWfikfcKDmuNoEMfgovV8RAKJRLDqnKsvBcizkdv201yz2om7iTKtMdl9TUYwFoIBYCtOf6IoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981229; c=relaxed/simple;
	bh=53sKqJOmKCxW070PZ7aJpP8P5eLZ7LstkhhGviUM00E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsHwR1meSXoebX6oFBXDzu4wT6edtVaKirirgo+ENEa9VE3JgpMYfVkx1kfEMtQAXrHl/v610LCNz7n7ekBSRbzzkwC2eJCPhH++2bYTJB/xeZw62J0+WxLbZ4KHCfZt/qAsCPu7AYl9qnP4sjXVi9UYQ6uYsRjwEOkGl4Qcd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/L1rRi7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so3346389a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757981227; x=1758586027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0DdPvJAHN5ISH/pdtLfXa5UzPfO/utNQwjegoSkVR0=;
        b=V/L1rRi71FKhO6xJj9GLzgiAJkO83VSnigZUS7nLwlxeuxiedgbb+U5JjdKt2N9gPE
         D1ik680oVvajhfC0M1wqzsCqb0F6r4AFQNOQKJldKzDWP0KLGCwvh4i0ZXPvcsjXsPAA
         ElRUIefKmCRrr+P36RwyAOvIkT2aAD4G0n7GgowLiXB+WEKHrrRbNFxnn8y4sMypdMX5
         bpqRQm33lKOS4sAEDfNo7PC3LjbDKL9l3sv6NF+AL6/NSoZb5qQIya6AfH6O3KZelcBB
         tvSRWeilB0fOy1ywmMWa5SRawY5HhB5g8XqPo1qaTITWVNzPtMevCgVwmxd16otbs6Ij
         JX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757981227; x=1758586027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0DdPvJAHN5ISH/pdtLfXa5UzPfO/utNQwjegoSkVR0=;
        b=nOw3Zxz222v+twp89/XHNGUn7MCjSv/zVu+Yg9nkqOWdiv80pIcOC3z/SYB7nxeYY3
         5W1713mqR3gVCGmBjsxMaXhYl05bbkmaPDcL6XjnSy/7Z59yKzUAAWZH8Cw7c3BdF/1M
         yCcY8ttIMT+QysqCQ3a+Z63HdQe3JkR6rGWQHbw++OBmxmpO/GGQ1PGpYDyD11KOW9uf
         LjY/8qPGlflGR5jFKDtCY2jIEeCzTASH1rXo2WGvKN2u6HPyZU5wHd7r4YcxRCzfMoMN
         v2a7yQjdb1pxVyPiT3dAp0iPikqcFHQk9bC6EVLNPUdAexthtTv/0jnVsDt28G6mn4rp
         XXJg==
X-Forwarded-Encrypted: i=1; AJvYcCX8H4jDM+GKXxgZqWeMCszrJ6dUuLg4LRDoDeXcHlM29AsU4bs9FXtpnw6lfCmUwlN7I0WJMfhzbZ3/4/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj9zIXczmQd2VIuGB3YEdw6ZXEmQxWhQCCIxBJBfQLeYXG348
	ALlD02o9oQgSJQkh4eBZ6yUBANkA0hvTxIUczVeqONtHqU3TB664VsFGboFv5w==
X-Gm-Gg: ASbGncuMxD5nkMhQ4uVq1k8kF2x/ulhEXaneY+AXhCYrKqALNS4tvh2AQhIj6uRwd4u
	9YMb/yGl518QoGVR5qvyOwO9wF5ScMzZwRtGXvbS8+bAmUqjNRNOkvCEtOhi4x3OJs4ss55LfoL
	EvKrk1GYYQXtPuZgu4aCUa3pxJRAlssS/uN1XdOux99sp1kSjVuApSPRlCpH5XqEz2z0NxXySiq
	bbPbnZBSVKq+4SUQI4CKjUiXu/2axgcvyt/iiZr1KWgQcQUVrvbxHJivMUFhR4bCfK0aBkou9cq
	frZS5UF/BiA1TudaNjoU3qAZbDBRsyEBj98h2ucdlLINyy2hS7tSqYLnJE/COXgyHGE8Ipy/Sdg
	Ggc1kIYAtqWAelt7aPhgViQirJTZyxmTKFgLpqjMA7KHzHVLkNh1NTupOp+VLeTiQ
X-Google-Smtp-Source: AGHT+IFqBn3aPuuGIwsNUKiW5043CHGfJxBjK7/JYETlzi1z3QlkzRgLa+sscFn02uU8Sj4jKSkSIw==
X-Received: by 2002:a17:902:f64f:b0:250:999f:31c6 with SMTP id d9443c01a7336-25d26d4d96emr158911255ad.32.1757981226722;
        Mon, 15 Sep 2025 17:07:06 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26124cb9460sm83251345ad.106.2025.09.15.17.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:07:06 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:07:03 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <aMiqJ4UcAfU3W107@fedora>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
 <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
 <aK9Ogjn71JoOM3w3@fedora>
 <20250915184514-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915184514-mutt-send-email-mst@kernel.org>

On Mon, Sep 15, 2025 at 06:45:51PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 27, 2025 at 11:29:22AM -0700, Vishal Moola (Oracle) wrote:
> > On Wed, Aug 27, 2025 at 02:01:01PM +0200, David Hildenbrand wrote:
> > > On 26.08.25 22:56, Vishal Moola (Oracle) wrote:
> > > > free_pages() should be used when we only have a virtual address. We
> > > > should call __free_pages() directly on our page instead.
> > > > 
> > > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > > ---
> > > >   drivers/virtio/virtio_balloon.c | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > index eae65136cdfb..d4e6865ce355 100644
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
> > > >   		page = balloon_page_pop(&vb->free_page_list);
> > > >   		if (!page)
> > > >   			break;
> > > > -		free_pages((unsigned long)page_address(page),
> > > > -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > > > +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > > >   	}
> > > >   	vb->num_free_page_blocks -= num_returned;
> > > >   	spin_unlock_irq(&vb->free_page_list_lock);
> > > 
> > > I think you missed another nastiness of similar kind in
> > > get_free_page_and_send() where we do
> > > 
> > > 	p = page_address(page);
> > > 
> > > Just to call
> > > 
> > > 	free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > 
> > Thanks for catching that. Andrew can you fold the attached patch into
> > this one please? It looks like the page_address() call is needed for other
> > things, but since we're changing the file we might as well clean these
> > up as well.
> > 
> > I imagine theres more of these lingering in the kernel, but theres so
> > many callers and I only looked for the ones that were calling
> > page_address() inline :(.
> 
> Confused what is folded where.
> If you want me to apply these things please just fold whatever
> you want folded and post.
> Thanks!

Hi Michael, you shouldn't need to worry about this as Andrew will take
all patches in the patchset through the mm tree. See v3 for the updated
version that will be merged:
https://lore.kernel.org/linux-mm/20250903185921.1785167-8-vishal.moola@gmail.com/

I get why you might've gotten confused. The 'fold' patch I was referencing
was included as an attachment rather than inline (but I've figured out a
way to inline things for the future).

> 
> > >From a7d439154c7990418da976e5864b91fce9d49d58 Mon Sep 17 00:00:00 2001
> > From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
> > Date: Wed, 27 Aug 2025 11:10:22 -0700
> > Subject: [PATCH] virtio_ballon: Call __free_pages() in
> >  get_free_page_and_send()
> > 
> > free_pages() should be used when we only have a virtual address. We
> > should call __free_pages() directly on our page instead.
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  drivers/virtio/virtio_balloon.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index d4e6865ce355..7f3fd72678eb 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -718,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
> >  	if (vq->num_free > 1) {
> >  		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
> >  		if (unlikely(err)) {
> > -			free_pages((unsigned long)p,
> > -				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > +			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> >  			return err;
> >  		}
> >  		virtqueue_kick(vq);
> > @@ -732,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
> >  		 * The vq has no available entry to add this page block, so
> >  		 * just free it.
> >  		 */
> > -		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.51.0
> > 
> 

