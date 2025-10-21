Return-Path: <linux-kernel+bounces-862152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2116BF48B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DADA18A44D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470111F8691;
	Tue, 21 Oct 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZRFPcf4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2E1EB193
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018617; cv=none; b=ae18smYrPxnmiLsPQAmbZaIA1dP3GymZfCm1HF977EpOLkrOaL6ujXA/Ys+ecqCycsXZ7Yj+hpoUrgao/uHou/zJBjH6h77AzLt+JjsbOn4CWMn3o18cEbCaJwFp2wtzdx3bnMsz3WYJ59Bt92P0d/VXyCimvZhalWzMxfa8qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018617; c=relaxed/simple;
	bh=Xfxq/oFV+aTELzv9gVB9dGW1s+QNsPVm9t1CvgjbBkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGFnjruDUXLlSgidm0c5cTAxl/T40jULe9nKwXbfFkF26y+NT28zDErb9jSd1pXr9GMUHjuWC7HJb4sKadjczndUdXujsyyiold6tAoFTsAflLkVG4WTFyb5kKSwmH3hCcdzIDJy3Q4vbyeIi6rjT+ek8Vj03A9Vfc3809czp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZRFPcf4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qw5zwI6nIdmmTVggeM042sXBfaS2xsKHK0fC70nczqM=;
	b=bZRFPcf4shvUBujMgQhNnX0lmCiSyN4iPR2E+0CDkJOXC5tjthJVnUxKaCxofXNKrgWjle
	B8B0cCv1n4qmzuz1k4dcXkEARq1cAZZk1Y7FlUIPIEdXx5pVvYHWqCSksa1a0nS9pN6y+l
	sWG9D40Aa9L1WInNenTxq6LxpbrtC2E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-QEZggCJiMLyc4ocKyOTT8Q-1; Mon, 20 Oct 2025 23:50:13 -0400
X-MC-Unique: QEZggCJiMLyc4ocKyOTT8Q-1
X-Mimecast-MFC-AGG-ID: QEZggCJiMLyc4ocKyOTT8Q_1761018612
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33baef12edaso4684242a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018612; x=1761623412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw5zwI6nIdmmTVggeM042sXBfaS2xsKHK0fC70nczqM=;
        b=SGejIyQtZBH/ZjHi0UKPltYOsMVLSwQfLVUfzKcHEnG9lpT1qCqa9mAM74z1eaons9
         N9OW83D1yJCnfHJYOWj9Cdt+8c7CZyPykpFs3koFfR+7CNPUtvTrkhJKL51GSWn1rM/R
         GIjCR+SFkK+lcpeOQzncIEwtzQqKhxsZijjf1DLeDIjzD6q54ZPMnQS5Z0FD3S/R81P9
         sN/JOnAr0SVnkBlyMbUG6cuIcmkK77dMYo2T/GOitkkFPsHs7ZYiitSShaG5TY/UYZJZ
         hzr4s9bWBFE1clzc0KybzdcEUDtgEIfms76svtZwYxuoYkrJn4tIssLzlk6d67OTRQkB
         PpDw==
X-Forwarded-Encrypted: i=1; AJvYcCXmKggCphVmVzQOBublsQI79oJBnJQpEU2CBwsGD0CaWLa7yEzfIgK0r5yBHnEUVuTVe0lkRTNfYXuOXGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKLHZyWaBFJgQykCv1q2XSljuOHONtiID57TlXAhXBxYR1IVD
	MS1Q5OVKL1Sce3hzaozxBTiMRkptmYyo3hOXK46l91gTL/LyLiTAU6IRj7xnu3/BA9kDi3ChvCU
	toM1rMAbNPwfrSGquSNjll6rKtVkBK0ezBMFiW4U88K5vgIvs1yVDOVyYs8bUzf5nqMh75nfU8z
	IGcRdPre5+2aOeaWgA7tiJMVBMSXT8vm1GmXMPfDEC
X-Gm-Gg: ASbGncvP7E1vlQ6HKiP/v6hbNgQTUf4lyBRXAnqENKrkPH0T/VzPzfKRF5nyR/bCn+0
	z8GORJujwtJfLkwWbeUprPgsraytsF0bvCsoD4b/65ayX0ftWbH12JxNXa3NEuQGjQSsv1WvnSF
	iVlHImln6ttVKnefjqqsDDJotEA+Gu9HOOlp/2/A7favaiETiX8wvaehGf
X-Received: by 2002:a17:90b:3144:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33bcf919094mr22073968a91.35.1761018612508;
        Mon, 20 Oct 2025 20:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiW89JHyRgjBJd+Udk0unIJh6QXaxXTExxg7fwIdXno/4/+Q7xMsTY49eKTY4mDRvsZ7nlfwueJ+hsmtaNq7o=
X-Received: by 2002:a17:90b:3144:b0:335:2b86:f319 with SMTP id
 98e67ed59e1d1-33bcf919094mr22073949a91.35.1761018612014; Mon, 20 Oct 2025
 20:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-15-jasowang@redhat.com>
 <20251020110341-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020110341-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:50:00 +0800
X-Gm-Features: AS18NWAFgiublYtZtymjvvy_TkrPj7X9nHtH0g-39Ijsh0Qn-VjDfUh-f-84E_M
Message-ID: <CACGkMEseL0g8Y2=UfH8Gktgfjazr9L4pM-TqWOj7M1iGNZPh-A@mail.gmail.com>
Subject: Re: [PATCH V8 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:09:58PM +0800, Jason Wang wrote:
> > Let's determine the last descriptor by counting the number of sg. This
> > would be consistent with packed virtqueue implementation and ease the
> > future in-order implementation.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 37b16ef906a4..20bc48b1241e 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -575,7 +575,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, avail, descs_used, prev, err_idx;
> > +     unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> >       int head;
> >       bool indirect;
> >
>
> c is not a great variable name. Maybe sg_count?

Probably, I did the same as what has been done in
virtqueue_add_packed() which uses c. I will change it to sg_count.

>
> same in patch 19 actually.

Fixed.

>
>
> > @@ -639,12 +639,11 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> >                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> >                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT,
> > +                                                  ++c =3D=3D total_sg =
? 0 : VRING_DESC_F_NEXT,
> >                                                    premapped);
> >               }
> >       }
> > @@ -656,21 +655,15 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> >                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> > -                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT |
> > -                                                  VRING_DESC_F_WRITE,
> > -                                                  premapped);
> > +                     i =3D virtqueue_add_desc_split(vq, desc, extra,
> > +                             i, addr, len,
> > +                             (++c =3D=3D total_sg ? 0 : VRING_DESC_F_N=
EXT) |
> > +                             VRING_DESC_F_WRITE, premapped);
>
> this continuation line should be indented more,
> and maybe premapped on a line by itself.
> Alternatively use a variable for flags.

I switch to use flags like:

                        u16 flags =3D VRING_DESC_F_WRITE;

                        if (++sg_count !=3D total_sg)
                                flags |=3D VRING_DESC_F_NEXT;

...

                        i =3D virtqueue_add_desc_split(vq, desc, extra, i, =
addr,
                                                     len, flags, premapped)=
;

Thanks

>
> >               }
> >       }
> > -     /* Last one doesn't continue. */
> > -     desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
> > -     if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> > -             vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
> > -                     ~VRING_DESC_F_NEXT;
> >
> >       if (indirect) {
> >               /* Now that the indirect table is filled in, map it. */
> > --
> > 2.31.1
>


