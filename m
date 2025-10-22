Return-Path: <linux-kernel+bounces-864099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D3BF9E67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 019D7353234
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34A2D6E75;
	Wed, 22 Oct 2025 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLFwVa/H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70402D6407
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105676; cv=none; b=QTYctaQZb0kYQ/xHrYgNADtHtgvKnUX+bBRJFVU/DDOXMowvduuE63SDHZXOd2DYWz7LVBoJwUoH++8lnPP2uW+/RqCHrlF2C0KXyAHYcQawNZSHayxuNNcclYSgGZ1hW/jDh8hq1yfpu5rcnFoMPgmxgPleGUH9isqw0/Vxzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105676; c=relaxed/simple;
	bh=ExxG00WUT1IagntSo4MfFIFNw07rQDoJ9SPCq4MYTFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2JpMV60oSaY/+QuDiHeiKDEM6WeOWtJ7mbNvzJYJKjmJjLrRyR1U1OqFx2gRK/7dqrRNEiQ7+E7aU9x/af/L5yKQaFbkdKfz96OsSi6xMB/nCDvEmNYN8zlFioEpqnr2V4Vtfvliso8autKsAo8TXDcl//izJeFxxxYc2YyKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLFwVa/H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761105672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=px/1PnEGsVzDuAqu7+hFZS0aqZHYwLyi9+i6ljtogjc=;
	b=TLFwVa/HV5zo5rk3CWqoFl8kRuE2+2cDhYJWCmy8RnOzRk1248+eV7UwEm0ZXC7NIwdhs0
	/t1uG47yvERRwDeXl/GRXt2tkBS+hG5eD2kP45vAb89NyFz8WbcrtSWi/kXIg2gi8+N8X3
	q8XUMyClf5gpztxGNQxAAgyqlNGdVAg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-aasCjYTPOn6VfLVZcJp7Rg-1; Wed, 22 Oct 2025 00:01:10 -0400
X-MC-Unique: aasCjYTPOn6VfLVZcJp7Rg-1
X-Mimecast-MFC-AGG-ID: aasCjYTPOn6VfLVZcJp7Rg_1761105669
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290d860acbcso112155725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105669; x=1761710469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px/1PnEGsVzDuAqu7+hFZS0aqZHYwLyi9+i6ljtogjc=;
        b=Y5l3N9xButxkB1fSqaAB9uAb60XhEb7QqmSEVplcjj0pqMTMa6V87ZB1Rw7djab3DA
         IShn6bx/Cc4n5sihbrUEyBGttmLEVCZ/YT1rhYEn2PBCbR7EBvZqE/PU2+lRrohgClDD
         m7oHrSz9Q0Kp8wS/hN+BpkIDKeHH7g7hzGn0PBTAVo+oWdGcLJaIZP3FH1ZE1fA5R0zX
         f4sZzWWSxAz6OkVoJwIGS+g75UlQNqWFWnEnYf0RlqIxKpsH2Lcd9w7/gNRgxgLmvOT9
         ve+uoW3C29K7IMnh3Sp+gaTDbRxuJKJfCgxgB51tcm9+S2VzCRLy8JUG6yjvBpnOrZYV
         YfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxDR2k8awpxLgHRf9s4IyATFGYeDM72DtPFePtgMin2VeEPpXe2T7ACUW2ONKHqNXD5WRC2uH5spNp7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4bxPKjg4mCDWJt1ds+Hu8n0zHQHHO1bMGUpD9g/VVkwoHcUY
	bsarRuyROCCVOqtB7GX3cNEfI0yHOKFkGktHVc4BPGGL71PHkH+mKD5ML7sBeDtMAQVjr0QV9Yz
	FEnmRc0fHTwSyk7xygqcKwxloMreO2Q6pzVfrnfdtWUZeFzqLGsHNBGneFrXmYT0Gesep00I4G6
	V1cpzJLZSijA9hOZIVxdm3Rkcm7kZPNXmhCyNwQXASw6G2qrx95BXfOw==
X-Gm-Gg: ASbGnctslp+EPyD/8S50uUUsZX7JbGYFmOVz58InshHp+wMldOV3bk/ZF7c+s3srDQY
	mrHHqfCXOKW5EjVhQ3QmShnfIRiL0mHN7RRf1l/s2lLRt/e5RhVrnUmocs6vSSPJ3y51+rqA5PX
	Vjv5QiADa7ZpSQxMxmUuXFGiSy8nWbWvNmH4/lOC9VjPasjHNs3E/65y/X
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id d9443c01a7336-290c99a9669mr229217705ad.0.1761105668922;
        Tue, 21 Oct 2025 21:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqPZl8Z6+wXXTq+AZoxPaazi7t261I9kr2FsxhfLSyR2ouuL4vUfGfOoznvt7TcYAfVlLV//O9cAZWtSZQkrg=
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id
 d9443c01a7336-290c99a9669mr229217155ad.0.1761105668421; Tue, 21 Oct 2025
 21:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org> <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
 <20251021042325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021042325-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 12:00:53 +0800
X-Gm-Features: AS18NWAAzAExLbzR1SQ9Q8xgKInIDLRmK2l_SmYnjjQsmzapb0ZU1INU7NpbxDk
Message-ID: <CACGkMEskSf-mLZPaSYxkACu1z_hH_jXTKawzW1yZwZZOnSAFAg@mail.gmail.com>
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 11:36:12AM +0800, Jason Wang wrote:
> > On Mon, Oct 20, 2025 at 11:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > > > This patch factors out the split core detaching logic that could be
> > > > reused by in order feature into a dedicated function.
> > > >
> > > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 0f07a6637acb..96d7f165ec88 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_=
virtqueue *vq,
> > > >       vq->split.desc_state[head].indir_desc =3D NULL;
> > > >  }
> > > >
> > > > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned =
int head,
> > > > -                          void **ctx)
> > > > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *=
vq,
> > > > +                                       unsigned int head,
> > > > +                                       void **ctx)
> > >
> > >
> > > Well not really _inorder, right? This is a common function.
> >
> > Yes, but inorder is a subset for ooo so I use this name.
>
> Can't say it is consistent. I suggest for example:
>         _in_order -> specific to in order
>         _ooo -> specific to ooo
>         no suffix - common
>
> or some other scheme where it's clear which is which.

Will do that.

>
>
>
> > > You want to call it __detach_buf_split or something maybe.
> > >
> > > Additionally the very first line in there is:
> > >
> > >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DE=
SC_F_NEXT);
> > >
> > > and the byte swap is not needed for inorder.
> >
> > I don't see why?
>
> To be more precise we do need a swap we do not need it
> conditional.
>
>
> No, I mean inorder is a modern only feature. So we do not
> need a branch in the inorder path,
> you can use __cpu_to_virtio16 with true flag,
> not cpu_to_virtio16.

The problem is that the core logic will be reused by the ooo as well.
I'm not sure it's worthwhile to introduce a new flag parameter for the
logic like:

detach_buf_split_in_order()
{
        __virtio16 nextflag =3D __cpu_to_virtio16(true, VRING_DESC_F_NEXT);
        detach_buf_split(..., nextflag);
}

?

>
> > > you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)
> >
> > Probably you mean a leftover for hardening? E.g should we check
> > desc_extra.flag instead of desc.flag here?
> >
> > while (vq->split.vring.desc[i].flags & nextflag) {
> >                 vring_unmap_one_split(vq, &extra[i]);
> >         i =3D vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> >         }
> >
> > Thanks
>
> If it is not exploitable we do not care.

It looks like it can be triggered by the device as the descriptor ring
is writable. Will post a fix.

Thanks

>
> --
> MST
>
>


