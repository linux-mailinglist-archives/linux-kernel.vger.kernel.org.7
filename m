Return-Path: <linux-kernel+bounces-864174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 996E8BFA190
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57936501B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0AF2ED165;
	Wed, 22 Oct 2025 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuMxb/kb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A122ECD2E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111871; cv=none; b=fPHlZA7DrshTo12/xVFQ+HSkou029ucx9SGI1Ixt9ZVHgqHNbIXomvqTw+xstApv8bcq9FuE6YxH1TBlNwZFdFcjhQztZyBFO3cGTebTqjooNgLTOjERv53RQQ5dAIz4mCcuVmNSySEcF5E/pQScpnN8+5XkiGJ9Lh2FvyiZVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111871; c=relaxed/simple;
	bh=jmByzIvyAMZeLV+wtG8rPMReTA4JZzhcWHtX39WBB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBZ242uIaZvv9O6N3SRB7AXanp+QagF3wWydhd6CN4FzjMz9H6Kp8Yyzi9bxZ/MWoLIq+DXbcYkyLN8OciWNPsibBwx3p00aKQvl0KuFgS6F9c0Lrvuj0pyPl8z35q4ThafwnLp3TSnBW/EdOKv/vCW2UYNNyDm+Ez3QASQFUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuMxb/kb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cdA2aJ7ieWhAWAgXBTiUs2hf+dl3MLq/XdzHHs4TM=;
	b=BuMxb/kbrYIUdSubONZH8XdWixOEvXpFhaRvC4tI41/+t0GfpoQFpxU5671KiB6Ox8TsqK
	2WqjGEbParkhrHCGJPglGZI4FBkQrJ5TeegIFsmHCzBjLoAX2NrKV+XOOiH03x5JVvclPG
	Mkw/4ttY4pohaYHSqpOerD4rPG+dVlc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-UOOPXe1GMPKT4KrbN3beOQ-1; Wed, 22 Oct 2025 01:44:27 -0400
X-MC-Unique: UOOPXe1GMPKT4KrbN3beOQ-1
X-Mimecast-MFC-AGG-ID: UOOPXe1GMPKT4KrbN3beOQ_1761111866
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-470fd59d325so31826495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111866; x=1761716666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6cdA2aJ7ieWhAWAgXBTiUs2hf+dl3MLq/XdzHHs4TM=;
        b=UQJu5VLIJQzsYIF2Dk0BQo368SFfAp7uKlsnz4f0MXDUleaW1hoRTJOIT8fldyVCLJ
         nTkIOW+7pUWZ+/L5Hi8PKTgrnFCGvbwcxTpIAZkKGfdwBoQiMaXKewIjSmFKMV8fPjvp
         a4V5nOoEfpjbJohYhZv7iAsoC42f8dfbDRFPCnneg3vNGiNc78+qquDgTG3ORxEWkeox
         t5a2m4D0Fe1rZOf8UWADVVa0pLLWGtT9dZZqasPX51F73MfgwQBZYmTUersj9WhfPu6S
         mehlXnYxdPZy9wJXQPveUIVVjxIq+XEvqVGDMq0/5qWuAP0+Z7HH847U28rFUlgVMQCh
         taEg==
X-Forwarded-Encrypted: i=1; AJvYcCVKvQRjOEYLcxW7CmirJlsGJz1fKxl64fULnLOvPps34AWpzWQE3ttyPQHhmI/EtUM4xHZskMf6RSBrnjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaLOLB4GO6+L1/bYwcOpiSFI6B2C4+kZ1ficn4hY+ccndBMxb
	d33pACHjPDRxWcZ3QTr/QQS207Diz9Lvsq3iTvpHS2mN3T0FopQ12E+ZHvsSI/dYsuPRluzQXme
	3Os/A3C2cyZzdO+Ezn4RKeIiGjqZ4+nmqIkzJOY97OM/Y4F6ErbMSWq/ckyio5Xsyaw==
X-Gm-Gg: ASbGncvgO5GlRZdirEn5Aq0gXjbPkyvXuN2OfVaxg5KHXoG0FvrLTmQKdc/GcU++6DM
	ND85dpWWoZ3ygIPcRkyVsl9oVsUSwUi9jAwCzvBkEs1fH6rk0dClDLwInz7R8XkDL1XyOJwuDIq
	rzhttjxyRcgaQLUukm8rOxHA6xemxX3bK2vZxZqegvj02+yix0blLI9/Q5I6qBGZ6v7yLuyt6Zr
	ewWZeVOrV4gqjxuzGakNdM08vgkF3iZ4TtHftUD4RjpXX4jQMnBsDLrQBAIOBNf6AVySe8g6rue
	IzS2PClNTa9dIj2n3lp2mygz44sSOwIIa0PNcg4Pq2sB7TUHr9DKz7DIYQuw32hoPysc
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr149599185e9.36.1761111866091;
        Tue, 21 Oct 2025 22:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBq1miswWQ2JCO8xHuPt/netB6Eb5sGpcEeZAGKbvglwUn+sN/OhElR3T7xQtx3Z99OyygIA==
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr149599085e9.36.1761111865601;
        Tue, 21 Oct 2025 22:44:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm25481835e9.6.2025.10.21.22.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:44:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:44:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20251022014109-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org>
 <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
 <20251021042325-mutt-send-email-mst@kernel.org>
 <CACGkMEskSf-mLZPaSYxkACu1z_hH_jXTKawzW1yZwZZOnSAFAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEskSf-mLZPaSYxkACu1z_hH_jXTKawzW1yZwZZOnSAFAg@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:00:53PM +0800, Jason Wang wrote:
> On Tue, Oct 21, 2025 at 4:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 11:36:12AM +0800, Jason Wang wrote:
> > > On Mon, Oct 20, 2025 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > > > > This patch factors out the split core detaching logic that could be
> > > > > reused by in order feature into a dedicated function.
> > > > >
> > > > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 0f07a6637acb..96d7f165ec88 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
> > > > >       vq->split.desc_state[head].indir_desc = NULL;
> > > > >  }
> > > > >
> > > > > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > > > -                          void **ctx)
> > > > > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> > > > > +                                       unsigned int head,
> > > > > +                                       void **ctx)
> > > >
> > > >
> > > > Well not really _inorder, right? This is a common function.
> > >
> > > Yes, but inorder is a subset for ooo so I use this name.
> >
> > Can't say it is consistent. I suggest for example:
> >         _in_order -> specific to in order
> >         _ooo -> specific to ooo
> >         no suffix - common
> >
> > or some other scheme where it's clear which is which.
> 
> Will do that.
> 
> >
> >
> >
> > > > You want to call it __detach_buf_split or something maybe.
> > > >
> > > > Additionally the very first line in there is:
> > > >
> > > >         __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> > > >
> > > > and the byte swap is not needed for inorder.
> > >
> > > I don't see why?
> >
> > To be more precise we do need a swap we do not need it
> > conditional.
> >
> >
> > No, I mean inorder is a modern only feature. So we do not
> > need a branch in the inorder path,
> > you can use __cpu_to_virtio16 with true flag,
> > not cpu_to_virtio16.
> 
> The problem is that the core logic will be reused by the ooo as well.
> I'm not sure it's worthwhile to introduce a new flag parameter for the
> logic like:
> 
> detach_buf_split_in_order()
> {
>         __virtio16 nextflag = __cpu_to_virtio16(true, VRING_DESC_F_NEXT);
>         detach_buf_split(..., nextflag);
> }
> 
> ?

If it's common code then no.


> >
> > > > you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)
> > >
> > > Probably you mean a leftover for hardening? E.g should we check
> > > desc_extra.flag instead of desc.flag here?
> > >
> > > while (vq->split.vring.desc[i].flags & nextflag) {
> > >                 vring_unmap_one_split(vq, &extra[i]);
> > >         i = vq->split.desc_extra[i].next;
> > >                 vq->vq.num_free++;
> > >         }
> > >
> > > Thanks
> >
> > If it is not exploitable we do not care.
> 
> It looks like it can be triggered by the device as the descriptor ring
> is writable. Will post a fix.
> 
> Thanks

question is if the guest is exploitable as a result.

> >
> > --
> > MST
> >
> >


