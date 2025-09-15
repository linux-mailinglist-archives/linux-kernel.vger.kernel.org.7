Return-Path: <linux-kernel+bounces-817868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AABB587C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA0A16F47B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAC62D238A;
	Mon, 15 Sep 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKEajOOi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540A3FBB3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976360; cv=none; b=d4CI5oMErbh6OJZstGtSWPZaQteo0eqZM247yLTTfhRUgxrHFh/G29olUhVLLXdUuujTrqB3jB21VfvQwu/+WrrG0shig8hYnqeoxTGD5jLrKOolml675B+wdjmCtpQZkzGgnwqQ3iNdEF3ypubYs2wXWOK7QMLxsq+EVIuZPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976360; c=relaxed/simple;
	bh=L11pY/CJ6RdF5UkY2ZaMbNvRPq4z4ORUDX+hzUijP3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGl/BM9+yhYO4ia5rMhA8mjmLsEwNlJT9BtHEvGNxhBZu6Nq2s7ysc9ZtAUmevQKEjxu9eW8wjV/V7f79KTPLX9ZVIrDHrS8fTZo3TmaEXJFvDu97TPjJd+++9BdjIwzvJylxteThT5Exb6m3oxMGsHEtAB9kwSAngaE+y3cILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKEajOOi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757976358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uR14VGW0/X0AylQCvnqkHSqGmKvFKN2TXdGehzTWgbM=;
	b=TKEajOOiZtWRpksuhXcoKpQ0nH6KUffwT0kgP/mhWBSbnQ+1m7lEpsvm3DJ4Lde6EKI58S
	TQM6QhmIGKL9hqgggFx08oFJz4cbWZaBC7EWG0p9v1OSNTqpz4oM29HrMDlsxhMOJux3v4
	pm90ChZr7QTpYR2xdNlYS013xS8wef0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-yDnd-uL3MG6xwnZuuZTa2A-1; Mon, 15 Sep 2025 18:45:56 -0400
X-MC-Unique: yDnd-uL3MG6xwnZuuZTa2A-1
X-Mimecast-MFC-AGG-ID: yDnd-uL3MG6xwnZuuZTa2A_1757976355
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6215564bf48so4319222a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976355; x=1758581155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR14VGW0/X0AylQCvnqkHSqGmKvFKN2TXdGehzTWgbM=;
        b=gXyGvoItCgrdKxEvcYTulYt2DftPoM8OYsU1up0UGEZfyxVf4nGh1m/i7vofZ/oH7N
         GrcR4ZtcW3kLe88GLk3NcBBQAzdgG7RumySrSVJa9vEgVHbiKfoqtEKrrnuYVQRyEr6P
         YjBqJ7UPWms4NGCjR1MYnOCrSi7ILMzcY5/ukUbc4+DMM+poeorgJKSOWGCWJ1v+Xgf0
         /X96Tg8G+YVkHGHuZ0ELNpYt9U/ofSIESG40utgb7zFJVUNtcO/CVRETdTRPUHSFUnsY
         V5uPsK3x7lNdiqZYiPYzad4pqNHPJI/C1BPFqQyvG0nfjz1s+6e3va1z1TqY6dryifXb
         gnYg==
X-Forwarded-Encrypted: i=1; AJvYcCUpDZKLxMv4ptEpZQ58sr1Alu8a6tT9lWfPt4C61F0kUAMiGPY3WCk6YAmeVwi7IXEdiffUR/f0cOJbew8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCZqYIRnCnJyfXy5R6IVV6UZF1xikzKfgLLS80asHGLxI19y/
	J8Tx794AOjiS37EtDTgivjYkkmSiIytcYIl1fo1u8zWdzyiiXhuRLhJ4QJJhcG4Pk848ZNYIAu5
	pxZcipvkquGBNdh3yWSS1J+oR9x49qV5sjhkQ7IKAPoqYNHPURhkVTeJeuzj7XvMrKKimmQP+IA
	==
X-Gm-Gg: ASbGnctu7bb42wEZ74dbnz8Wi/07FtcPXQ2MrNvS1izhA3EV0IXk21VnqaehBEGZypu
	8a/L0CS07cWwdD/pAfuatotQYPHCF416FEYf8bQCscipWgGsWUKqYKDQa9xtjY0P7/xV+nB3NLT
	LADAh9c5RNLvey64nJfxMtkuf0okcfbZSb5MdpZaO/RvL5ANUdNokdu2rW4qDhDkrez64u/PuBz
	Pa4illhtavA/CWodrok/RcE+m3JE6qF5hGKGcxc9U/Ac7mGI9VGc6dIv0cN/y6ob5ad+GzFhp6W
	dMa+xEn+UqIPX8bjJbJoT2+BEkNV
X-Received: by 2002:a17:907:3f07:b0:b04:7ad5:b567 with SMTP id a640c23a62f3a-b07c35be704mr1472539766b.16.1757976355140;
        Mon, 15 Sep 2025 15:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmaBx18ld1j9lPfAcqGZ9Y3KUZHbyO0pMr88z4kWYAY7x6NvXEEp1rRueqlASrcg16xLKuCQ==
X-Received: by 2002:a17:907:3f07:b0:b04:7ad5:b567 with SMTP id a640c23a62f3a-b07c35be704mr1472538266b.16.1757976354746;
        Mon, 15 Sep 2025 15:45:54 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0cf2112639sm440073566b.104.2025.09.15.15.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:45:54 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:45:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250915184514-mutt-send-email-mst@kernel.org>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
 <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
 <aK9Ogjn71JoOM3w3@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9Ogjn71JoOM3w3@fedora>

On Wed, Aug 27, 2025 at 11:29:22AM -0700, Vishal Moola (Oracle) wrote:
> On Wed, Aug 27, 2025 at 02:01:01PM +0200, David Hildenbrand wrote:
> > On 26.08.25 22:56, Vishal Moola (Oracle) wrote:
> > > free_pages() should be used when we only have a virtual address. We
> > > should call __free_pages() directly on our page instead.
> > > 
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > ---
> > >   drivers/virtio/virtio_balloon.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > index eae65136cdfb..d4e6865ce355 100644
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
> > >   		page = balloon_page_pop(&vb->free_page_list);
> > >   		if (!page)
> > >   			break;
> > > -		free_pages((unsigned long)page_address(page),
> > > -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > > +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> > >   	}
> > >   	vb->num_free_page_blocks -= num_returned;
> > >   	spin_unlock_irq(&vb->free_page_list_lock);
> > 
> > I think you missed another nastiness of similar kind in
> > get_free_page_and_send() where we do
> > 
> > 	p = page_address(page);
> > 
> > Just to call
> > 
> > 	free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> 
> Thanks for catching that. Andrew can you fold the attached patch into
> this one please? It looks like the page_address() call is needed for other
> things, but since we're changing the file we might as well clean these
> up as well.
> 
> I imagine theres more of these lingering in the kernel, but theres so
> many callers and I only looked for the ones that were calling
> page_address() inline :(.

Confused what is folded where.
If you want me to apply these things please just fold whatever
you want folded and post.
Thanks!


> >From a7d439154c7990418da976e5864b91fce9d49d58 Mon Sep 17 00:00:00 2001
> From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
> Date: Wed, 27 Aug 2025 11:10:22 -0700
> Subject: [PATCH] virtio_ballon: Call __free_pages() in
>  get_free_page_and_send()
> 
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  drivers/virtio/virtio_balloon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index d4e6865ce355..7f3fd72678eb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -718,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  	if (vq->num_free > 1) {
>  		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>  		if (unlikely(err)) {
> -			free_pages((unsigned long)p,
> -				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  			return err;
>  		}
>  		virtqueue_kick(vq);
> @@ -732,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  		 * The vq has no available entry to add this page block, so
>  		 * just free it.
>  		 */
> -		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  
>  	return 0;
> -- 
> 2.51.0
> 


