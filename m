Return-Path: <linux-kernel+bounces-712863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1228AF0FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A781C248FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB42459CD;
	Wed,  2 Jul 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyCN716q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF51F463A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448576; cv=none; b=HX1dBzwwqWVeCwCFAUuh2QrIpm/AqumnbdwCHcRvz1Qti51IiXwb6IFgbX/r8TlRYTuM18e780Dewx07M0353+TVY7xbop4aMRrVj60uxFxSIRn0HaVhJIcNmE7pF8QmlsMBPWr0LM6r5elJaK3/oK50bMz8iNUTqYkKSqIgHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448576; c=relaxed/simple;
	bh=3IOT08xYGGOvXZTXp7TKeWO/UH9Cj94SVaKjLaY4KTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCcXJ0+xpby49PqS1MFCOGuF9oX41Ge9VB1A8usWx4xyU9GR3+/p/dIXJPbHv482VyG61vKgXuyVt5OePFKpvA7eQeJ8N2kLP/WRjQofoflJqsPGQOS8xGctJsmTtPs3AL/oWfARBV1o3GIWAahG4GS00s3jSjJac2jkxr8LgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyCN716q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751448573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppRF9PFAqofYSOZMKV6AN5ZHS/0FmpTYSWJ/9tUppWg=;
	b=QyCN716qdk4yu8y1da7kFq7g3tBCHyij7+LxduwU3yBFcIMQIZ19ELo45a6buhyFxzPjq6
	gercPmHggnTUjyRBvSMaKyJ4ii70KZMbZYuEkOqOjijuCrnbsK5d1P8UfdPHrKuJx7k3i1
	pXlR13m/j9rOJIFtqk8NTL8yEajkrmE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-4ZMi5sHBPc2JknxQ1iOiWA-1; Wed, 02 Jul 2025 05:29:32 -0400
X-MC-Unique: 4ZMi5sHBPc2JknxQ1iOiWA-1
X-Mimecast-MFC-AGG-ID: 4ZMi5sHBPc2JknxQ1iOiWA_1751448571
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso4953050a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448571; x=1752053371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppRF9PFAqofYSOZMKV6AN5ZHS/0FmpTYSWJ/9tUppWg=;
        b=lM5Us/iDxBcpErgWJJIfuGypa0JNFJMD6uJAT7PAlUdrl4FXl4YGeGikDCR8f3euH9
         xPav9kl/WjOugs4vH7/VitRU4/Ytx+fXJ4orGtyNQoSgkcUnXh5ayV+FDHfE5S7bV5Ub
         Zwk7pVxd0AEoV2/ZFr91g5+I+iVC5r0ReufNnQhdllOVRyY91YF+9vVQY7Cqq3zK/E4d
         oz5xqtCQboSZJoXjHN26TpdYUYUgHQr+G8zevUvuYpwCe5g6bQhqnkwo/I174LFETsCF
         eI8OJjYFpQmfr3bTNO5uEcJUpCcc5PnWUjhy8VZEiL1q+DK6pUUj8VjYocGjh741wBwK
         moNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/5P5tlAovFtKYZc8LCcGJV19IVNbDbBQcRpYlhA70UuMVmc6ScK04TtUskE34NlNwqhAz1BL11UYgNe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSGEh6/slwx9b/Z4dJ88QztWAiX4AhgTVuF01x2IeTMcWs+xr
	vPWaYyqp1fFguuu/Zry5PyWJklK3ud8ZcgEBWa9LyscD7SqPPVkLMful1XVoTN+qWmAFX2nQ/ME
	QBo2qatK1XRa/tciXHoCfb+aabz0+8TZe1d5Fh4fsF5OuTZamIYDmAiDbV7tVn//qkaX1MqTs6L
	11S7n3YxniRCQVLPXpphgOAvsbp8MduAT8mSPFErld
X-Gm-Gg: ASbGncuINf/6ubrmDa63h5EZ6InYZBADIZHGRURJgk/tAFhpJLQTEHaTC8EqpRrqs/S
	6GiR19xHPOKH/DfQTrSqthzGegw3Il0R1L/p+tSKl+WfJrBUdv8j3vUEli19ePqOyjucp+Q5AqB
	t+
X-Received: by 2002:a17:90b:2703:b0:311:ffe8:20e6 with SMTP id 98e67ed59e1d1-31a90b1a2c3mr3265930a91.3.1751448571097;
        Wed, 02 Jul 2025 02:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdg0tKr6FWtYLrHrlNHOfmvrc4Alber6vRgRHUTpt+P817ZRuH7iGLs8DiPeATIDmYwaU1LJ0w14prxAgjh38=
X-Received: by 2002:a17:90b:2703:b0:311:ffe8:20e6 with SMTP id
 98e67ed59e1d1-31a90b1a2c3mr3265895a91.3.1751448570603; Wed, 02 Jul 2025
 02:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com> <20250616082518.10411-20-jasowang@redhat.com>
 <20250701024602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250701024602-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 2 Jul 2025 17:29:18 +0800
X-Gm-Features: Ac12FXwObd67L1Pf1WmOzhZvAaUA5FhEvAcHp_e4q4OSxXQCZdJt_PPbR_3zZi8
Message-ID: <CACGkMEuzTYPcDMamptLMQpSZu3gWxYx1Sr2nJef+pyuo2m35XQ@mail.gmail.com>
Subject: Re: [PATCH V3 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 16, 2025 at 04:25:17PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue.
>
> I'd like to see more motivation for this work, documented.
> It's not really performance, not as it stands, see below:
>
> >
> > Benchmark with KVM guest + testpmd on the host shows:
> >
> > For split virtqueue: no obvious differences were noticed
> >
> > For packed virtqueue:
> >
> > 1) RX gets 3.1% PPS improvements from 6.3 Mpps to 6.5 Mpps
> > 2) TX gets 4.6% PPS improvements from 8.6 Mpps to 9.0 Mpps
> >
>
> That's a very modest improvement for a lot of code.
> I also note you put in some batching just for in-order.
> Which could also explain the gains maybe?
> What if you just put in a simple implementation with no
> batching tricks? do you still see a gain?

It is used to implement the batch used updating.

"""
Some devices always use descriptors in the same order in which they
have been made available. These devices can offer the
VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
devices to notify the use of a batch of buffers to the driver by only
writing out a single used ring entry with the id corresponding to the
head entry of the descriptor chain describing the last buffer in the
batch.
"""

DPDK implements this behavior, so it's a must for the virtio driver.

> Does any hardware implement this? Maybe that can demonstrate
> bigger gains.

Maybe but I don't have one in my hand.

For performance, I think it should be sufficient as a starter. I can
say in the next version something like "more optimizations could be
done on top"

Note that the patch that introduces packed virtqueue, there's not even
any numbers:

commit 1ce9e6055fa0a9043405c5604cf19169ec5379ff
Author: Tiwei Bie <tiwei.bie@intel.com>
Date:   Wed Nov 21 18:03:27 2018 +0800

    virtio_ring: introduce packed ring support

    Introduce the packed ring support. Packed ring can only be
    created by vring_create_virtqueue() and each chunk of packed
    ring will be allocated individually. Packed ring can not be
    created on preallocated memory by vring_new_virtqueue() or
    the likes currently.

    Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

>
>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 423 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 402 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 27a9459a0555..21d456392ba0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,11 +70,14 @@
> >  enum vq_layout {
> >       SPLIT =3D 0,
> >       PACKED,
> > +     SPLIT_IN_ORDER,
> > +     PACKED_IN_ORDER,
> >       VQ_TYPE_MAX,
> >  };
> >
> >  struct vring_desc_state_split {
> >       void *data;                     /* Data for callback. */
> > +     u32 total_len;                  /* Buffer Length */
> >
> >       /* Indirect desc table and extra table, if any. These two will be
> >        * allocated together. So we won't stress more to the memory allo=
cator.
> > @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> >
> >  struct vring_desc_state_packed {
> >       void *data;                     /* Data for callback. */
> > +     u32 total_len;                  /* Buffer Length */
> >
> >       /* Indirect desc table and extra table, if any. These two will be
> >        * allocated together. So we won't stress more to the memory allo=
cator.
>
> We are bloating up the cache footprint for everyone,
> so there's a chance of regressions.
> Pls include benchmark for in order off, to make sure we
> are not regressing.

Ok.

> How big was the ring?

256.

> Worth trying with a biggish one, where there is more cache
> pressure.

Ok.

>
>
> Why not have a separate state for in-order?

It can work.

>
>
>
> > @@ -206,6 +210,12 @@ struct vring_virtqueue {
> >
> >       /* Head of free buffer list. */
> >       unsigned int free_head;
> > +
> > +     /* Head of the batched used buffers, vq->num means no batching */
> > +     unsigned int batch_head;
> > +
> > +     unsigned int batch_len;
> > +
>
> Are these two only used for in-order? Please document that.

Yes, I will do that.

> I also want some documentation about the batching trickery
> used please.
> What is batched, when, how is batching flushed, why are we
> only batching in-order ...

I'm not sure I get things like this, what you want seems to be the
behaviour of the device which has been stated by the spec or I may
miss something here.

>
>
>
>
> >       /* Number we've added since last sync. */
> >       unsigned int num_added;
> >
> > @@ -256,10 +266,14 @@ static void vring_free(struct virtqueue *_vq);
> >
> >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq=
)
> >
> > -
> >  static inline bool virtqueue_is_packed(const struct vring_virtqueue *v=
q)
> >  {
> > -     return vq->layout =3D=3D PACKED;
> > +     return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_IN_OR=
DER;
> > +}
> > +
> > +static inline bool virtqueue_is_in_order(const struct vring_virtqueue =
*vq)
> > +{
> > +     return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D PACK=
ED_IN_ORDER;
> >  }
> >
> >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > @@ -570,7 +584,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, c, avail, descs_used, err_idx;
> > +     unsigned int i, n, c, avail, descs_used, err_idx, total_len =3D 0=
;
>
>
> I would add a comment here:
>
> /* Total length for in-order */
> unsigned int total_len =3D 0;

Ok.

Thanks


