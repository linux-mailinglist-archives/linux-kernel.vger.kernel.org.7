Return-Path: <linux-kernel+bounces-826482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB5B8EA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F81A18998C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC60578F43;
	Mon, 22 Sep 2025 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAoQrFWB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB928488
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502479; cv=none; b=BxCiVY6BEgw2MtpuwjJKiW+VDgR7YOZbTo8cgHcDBLUvvyysgUMFVuRMmNYfMiZaQ6RaB1jFIDEdzgDaktoEySanZU3mmNMQsHehUu7Z7V7DXvPO7D1AIYhn518XPjgdWQa3f+eEMiBpDFCfjcik1OGTyLCeTFniXoHFZtIGmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502479; c=relaxed/simple;
	bh=9R3BqWjTxU7P5mzQXg5yxNQRwEU/SY4HjKjtRJ5tfks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJzqUcMtIOA2BHxLgGP5hKUI829kOAbsk0DEFzoj6+hVuo9l6M7DEK/ZbEbhkaqpjIWt4aG0Ad9QZsovec+aimG4xhd4c+LV43cbSBSSUj6eGe9ziVzJHnv6RSSm+U/oaU5kvCs6sH90BTSaElUm5eceDVo2Nqq7d10xBJiT3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAoQrFWB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3jeEML+hm9B2cxS8JSlOpLThcHP3+emn/qAaz+xaZQ=;
	b=FAoQrFWBMurIKNYaMud0t6aKaGJJbtITYJqoSEc0TI8PB+DMzf5nJPgXY5PiyCzybyAxR0
	R46TXrVFCvaqm6cu5t9eyx+IcOVtb7IL7/jMRhMZgP9gZmYOP0GqeDrryypR23vOvdKci0
	aMwiUTTOPecpnUdcygcQOHRxGq28zTc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-NwXXTyYOOGCoJDOEeeui2Q-1; Sun, 21 Sep 2025 20:54:34 -0400
X-MC-Unique: NwXXTyYOOGCoJDOEeeui2Q-1
X-Mimecast-MFC-AGG-ID: NwXXTyYOOGCoJDOEeeui2Q_1758502474
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so5546759a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502473; x=1759107273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3jeEML+hm9B2cxS8JSlOpLThcHP3+emn/qAaz+xaZQ=;
        b=G1rAlQPchIlWnxKTElM0/bOGJu3eq1L/voCaT3qyhowb71FKE1Ic5kPeWnPImgnNFT
         mruLuDqH/sUJS5SesCyjdH3ZM4p4kpUu3TKhA+y+HjoTPLbOajudYyCKNPApqfWcQVBJ
         tLmNky6Q+UePBpS6/RvHpbgQAWk/OcpifKDXD1CnSl8/ffF/ygzSLeOLb5kRrM+7mgtM
         q/wC3D9BesnAcK5JnY4gzE/wvoKCDZyxoFwISBtHs9On750MzOgvfRJ1X5PyPiXueCVn
         WgFqLgvE/Rlh06wz9Rnhgd1UtjsRkbVDGy/Eq713565Qy4D34aOMezgPPvw7Mgf3lHng
         2FbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZY7zw1Fgte+cuCpEZ1+3A/zUIenQ2IYVd80pG4j5uRe3KIyt3e+vdzd/80pwUkQyAMTnDIELfxyTya84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstT6ZUlhW2YrVPzzYVyA7YjuW/CZPSeiGIPRFKHbe4ehKy3ND
	fQdyVgiCDzsXcoJE4Kd0sElYLhOtCh5Sfw6gGa9e1dXpIdNFB5/Fs5xegOkseRdnlLrtWqIb8eg
	2euhN5ENxggMa9CK4yrCAOdzr3ZypIRqGQDMkC7RzlIXodmKZReZ3Q0eVZ+H0st16TrWBJFOH/r
	Ic7O4f2cM4P7qH+uogtu8UizcHkuiGuvyGFRzTRVUvNlJdpkkgsdA=
X-Gm-Gg: ASbGncuMzr7ERdfkRfm8nLAWe5zeSj+HDTSt1fpQha0risd1Udn9sFS9SsHJdjDF6h2
	bmP2X+I222WVSG/54hkFN7kPj6SvaW0b3VqraBaF6SQzrfh+WqcMSWdal3cI+j0YEZFpQ3BVNDu
	8otykDwx77uZYTIE5UeIUCzQ==
X-Received: by 2002:a05:6a21:99aa:b0:243:f86b:3865 with SMTP id adf61e73a8af0-29270319fc8mr16685309637.36.1758502473150;
        Sun, 21 Sep 2025 17:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+e0tK5KOdYYGx1pnJKv9NZWwGOKiRwcrSGCcpLUk78S9iiIRwI8MOfu8Mn1YdymVNKfaWIikoSkmopURdtHo=
X-Received: by 2002:a05:6a21:99aa:b0:243:f86b:3865 with SMTP id
 adf61e73a8af0-29270319fc8mr16685289637.36.1758502472733; Sun, 21 Sep 2025
 17:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-7-jasowang@redhat.com>
 <20250921134601-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134601-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:54:21 +0800
X-Gm-Features: AS18NWBf8ry-HTUen2C0-8fpN4bE4uOPg9V8nK67FrWVtWwU98ZvA5H7JSxfGUY
Message-ID: <CACGkMEvqOaEnkWd=C88kkBdCz8s3odWCw5D9io0YL-=8AN-tag@mail.gmail.com>
Subject: Re: [PATCH V6 06/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_add variants
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:47=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:41PM +0800, Jason Wang wrote:
> > Those variants are used internally so let's switch to use
> > vring_virtqueue as parameter to be consistent with other internal
> > virtqueue helpers.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index aadeab66e57c..93c36314b5e7 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -476,7 +476,7 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
> >       return extra->next;
> >  }
> >
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue =
*vq,
> >                                              unsigned int total_sg,
> >                                              gfp_t gfp)
> >  {
> > @@ -505,7 +505,7 @@ static struct vring_desc *alloc_indirect_split(stru=
ct virtqueue *_vq,
> >       return desc;
> >  }
> >
> > -static inline unsigned int virtqueue_add_desc_split(struct virtqueue *=
vq,
> > +static inline unsigned int virtqueue_add_desc_split(struct vring_virtq=
ueue *vq,
> >                                                   struct vring_desc *de=
sc,
> >                                                   struct vring_desc_ext=
ra *extra,
> >                                                   unsigned int i,
> > @@ -513,11 +513,12 @@ static inline unsigned int virtqueue_add_desc_spl=
it(struct virtqueue *vq,
> >                                                   unsigned int len,
> >                                                   u16 flags, bool prema=
pped)
> >  {
> > +     struct virtio_device *vdev =3D vq->vq.vdev;
> >       u16 next;
> >
> > -     desc[i].flags =3D cpu_to_virtio16(vq->vdev, flags);
> > -     desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
> > -     desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
> > +     desc[i].flags =3D cpu_to_virtio16(vdev, flags);
> > +     desc[i].addr =3D cpu_to_virtio64(vdev, addr);
> > +     desc[i].len =3D cpu_to_virtio32(vdev, len);
> >
> >       extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
> >       extra[i].len =3D len;
> > @@ -525,12 +526,12 @@ static inline unsigned int virtqueue_add_desc_spl=
it(struct virtqueue *vq,
> >
> >       next =3D extra[i].next;
> >
> > -     desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> > +     desc[i].next =3D cpu_to_virtio16(vdev, next);
> >
> >       return next;
> >  }
> >
> > -static inline int virtqueue_add_split(struct virtqueue *_vq,
> > +static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> >                                     struct scatterlist *sgs[],
> >                                     unsigned int total_sg,
> >                                     unsigned int out_sgs,
> > @@ -540,7 +541,6 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                                     bool premapped,
> >                                     gfp_t gfp)
> >  {
> > -     struct vring_virtqueue *vq =3D to_vvq(_vq);
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > @@ -565,7 +565,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >       head =3D vq->free_head;
> >
> >       if (virtqueue_use_indirect(vq, total_sg))
> > -             desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> > +             desc =3D alloc_indirect_split(vq, total_sg, gfp);
> >       else {
> >               desc =3D NULL;
> >               WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
> > @@ -612,7 +612,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> > -                     i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> > +                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> >                                                    VRING_DESC_F_NEXT,
> >                                                    premapped);
> >               }
> > @@ -629,14 +629,14 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> > -                     i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> > +                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> >                                                    VRING_DESC_F_NEXT |
> >                                                    VRING_DESC_F_WRITE,
> >                                                    premapped);
> >               }
> >       }
> >       /* Last one doesn't continue. */
> > -     desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> > +     desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
> >       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> >               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
> >                       ~VRING_DESC_F_NEXT;
> > @@ -649,7 +649,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >               if (vring_mapping_error(vq, addr))
> >                       goto unmap_release;
> >
> > -             virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> > +             virtqueue_add_desc_split(vq, vq->split.vring.desc,
> >                                        vq->split.desc_extra,
> >                                        head, addr,
> >                                        total_sg * sizeof(struct vring_d=
esc),
> > @@ -675,13 +675,13 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >       /* Put entry in available array (but don't update avail->idx unti=
l they
> >        * do sync). */
> >       avail =3D vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > -     vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(_vq->vdev,=
 head);
> > +     vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(vq->vq.vde=
v, head);
> >
> >       /* Descriptors and available array need to be set before we expos=
e the
> >        * new available array entries. */
> >       virtio_wmb(vq->weak_barriers);
> >       vq->split.avail_idx_shadow++;
> > -     vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> > +     vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vdev,
> >                                               vq->split.avail_idx_shado=
w);
> >       vq->num_added++;
> >
> > @@ -691,7 +691,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >       /* This is very unlikely, but theoretically possible.  Kick
> >        * just in case. */
> >       if (unlikely(vq->num_added =3D=3D (1 << 16) - 1))
> > -             virtqueue_kick(_vq);
> > +             virtqueue_kick(&vq->vq);
> >
> >       return 0;
> >
> > @@ -706,7 +706,6 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >       for (n =3D 0; n < total_sg; n++) {
> >               if (i =3D=3D err_idx)
> >                       break;
> > -
> >               i =3D vring_unmap_one_split(vq, &extra[i]);
> >       }
> >
>
> can't say I like this, error handling is better separated visually from
> good path.

I don't see a connection to this commnet, this patch doesn't touch the
error handling. We can try to optimize the error handling on top.

But I will remove the unnecessary newline change here.

Thanks


