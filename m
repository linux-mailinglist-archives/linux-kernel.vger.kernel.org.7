Return-Path: <linux-kernel+bounces-748818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AECB14645
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEAB3A57B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1894207E1D;
	Tue, 29 Jul 2025 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeBk9PJw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D679EA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756446; cv=none; b=YWlTLJcUGsibZwwQHvoIz4EVlnQreW5Eb9njyE3+Um3NOalbITdiQrbNrRrH23mUhftdSzs4DaKaMIcQ1BYYyIJl4s/ZlInHD7k1sZEvsdOn8g9A0LiZs/FSDTWACLn80xpyV/WBpOCGexXWZyLBnPJzNVHpdI51Kg+SRzhgwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756446; c=relaxed/simple;
	bh=k5U5VmbuGzYR74UVukpio0gv9VhzkjaKJEuIUXMfpxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alQqRnl5IjJUjxhRnevdy0qidQEXjPGd3b0qnsXMih/5dDykhoPZ2aD8eoiirmwUPb/wQ0Ed321X/THtkeUJUppSre7QmFJfIDnq6JTexNvOi7orSodwo6gWD7+NqPsrbc5a3djmp5wo0MiklycML3/Z29/OpHeA/fUDg3M2dtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeBk9PJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW4aZUOhIexvSWl8+uNp7V0TRuoHBCBJYexWHVg0orU=;
	b=XeBk9PJw8rBDkG1jyX/MRzWTvM5L/KlnCZqi8b4Jye5o7bwZdhXChjes2W/xwohDNit/QH
	F8IfaoQCvUsnlUXs1ddwMpAxkMU6xRCbe/Ra28R3olhy1T+Sx0my+lAMk9BmnjZycmVSJ7
	9hy8KFbJaR20Gw6Oo5i2biZTVrHyGnk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-BX8XpIKjOka3rKubKHL6Wg-1; Mon, 28 Jul 2025 22:34:01 -0400
X-MC-Unique: BX8XpIKjOka3rKubKHL6Wg-1
X-Mimecast-MFC-AGG-ID: BX8XpIKjOka3rKubKHL6Wg_1753756441
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31ea430d543so2489465a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756440; x=1754361240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW4aZUOhIexvSWl8+uNp7V0TRuoHBCBJYexWHVg0orU=;
        b=HXJRjcGgSP+e1yJb6PcO6Yua4EMAhWk1XX3N+EyWrHOrjT3eNS+h9Q1kbj+Tbbh32h
         I4y+pFtqc/YAnH6wamoh5eaMtHnWS52HD/UqSKbCOPgAIc9crj63DAousgYNArz7abi/
         FGh5/TVsFMGzKiyPQAXWLDg4VURXT7+cf6OrYWjdUch8dBiZaFgQLOGuVuLb75jZjaMB
         RUQwuMYEeMYkcqrweMEL7MFW8kB6XZtqWQ3CVcScN6mcqb99hajmFsxznCuF+cpATFCF
         AXLODQs8/P8E64FVlFT1SB5WlrvIIzS2UKmYpjaLcuoDrjmbBvgI4oPtHzDVI6UEVmVw
         NfLg==
X-Forwarded-Encrypted: i=1; AJvYcCU9n62Jee44vA2A5v9cHPfX2qGeLcsIijGw2+TP3KwD1/8WF6xLUNQ5qnTpO0FyZgV+VGLnEsk0UwIK0HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNVCYJo52BdOkG27cgwMiy4j8wxQT8EaQA1Dihk2B4c2eniDF
	g2Wm7s3NlOUL6NSnE9jq2MktqhbAXKtc0ApTCgdwR+Gpt1tM6U2hGarKCJ7v2zYMEz8l2q2lEF6
	tFH2Sm+8OmDPBc9Ih+bc2aIsiRYYa6SkKMVtf6da9hYIWejPYcyq4HfO2nlobKAF9rEl7gcTZhW
	b/SrPZ3PzHLJf/Ki+KrtbVO3Bd0Y/oRf/nSR6QuyRV
X-Gm-Gg: ASbGncthuULFnxY50gKhgpsXDZSEyS15SE+ss4xtVB8MZE3sSUVetkxqwRoBe1kHxwg
	DuJnvCNEWjmZFl/iOrX1T1A+OrwkTpqG+cPg71/4xw7ckGiG5zNflGi6lwo6gWUHuvj0LEUzyee
	Ywd7u0BKEKW4YrKDDtZFY=
X-Received: by 2002:a17:90b:55ce:b0:31f:2ef4:bc22 with SMTP id 98e67ed59e1d1-31f2ef4bd3cmr1457372a91.27.1753756440477;
        Mon, 28 Jul 2025 19:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8/Fduu/xXUr5+Bmt1whH0ZCQThYGyCL7nZ4J4nWhDYbZdR62iA3aAlOA2tWURjzzQBbvItNJhU5LR6Afh+5A=
X-Received: by 2002:a17:90b:55ce:b0:31f:2ef4:bc22 with SMTP id
 98e67ed59e1d1-31f2ef4bd3cmr1457349a91.27.1753756439979; Mon, 28 Jul 2025
 19:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728064129.32382-1-jasowang@redhat.com> <20250728060823-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250728060823-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:33:48 +0800
X-Gm-Features: Ac12FXyO-5aY1nzF0VIfrZ-HUDqqbfQfNDQkv0NFgyHvypnE0_tK5xFbEwqjiOU
Message-ID: <CACGkMEsX9=MAT=pg+MG-5_0PN7DYGNv8G9E2ZLgtZ1TmCLV-0g@mail.gmail.com>
Subject: Re: [PATCH V5] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 6:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 28, 2025 at 02:41:29PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Perfomance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since V4:
> > - Fix build error when DEBUG is enabled
> > - Fix function duplications
> > - Remove unnecessary new lines
> > ---
> > drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 401 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index e675d8305dbf..c6558e271f97 100644
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
>
>
> how about specifying the #s here?
>         SPLIT =3D 0,
>         PACKED =3D 1,
>         IN_ORDER =3D 2,
>         SPLIT_IN_ORDER =3D 2,
>         PACKED_IN_ORDER =3D 3,
>         VQ_TYPE_MAX,
>
> and then
>
>   static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq=
)
>   {
>         return vq->layout & PACKED;
>  }
>
>  static inline bool virtqueue_is_in_order(const struct vring_virtqueue *v=
q)
>  {
>         return vq->layout & IN_ORDER;
>   }
>
> which is a tiny bit less code.
>
> worth doing?

Probably not, for example it would introduce branches. As we
discussed, once we have sufficient optimizations, most of the branches
could be saved.

>
> >
> >  struct vring_desc_state_split {
> >       void *data;                     /* Data for callback. */
> > +     u32 total_len;                  /* Buffer Length */
> >
> >       /* Indirect desc table and extra table, if any. These two will be
> >        * allocated together. So we won't stress more to the memory allo=
cator.
>
>
> this is only used for in_order, and it increases the struct size
> by half due to padding. why not a separate struct?
> Or if you like, reuse vring_desc_state_packed - it is same
> size with this addition.
>
>
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
> there's empty space at the end of this struct.
> struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
>         u32 total_len;                  /* Buffer Length */
>
>         /* Indirect desc table and extra table, if any. These two will be
>          * allocated together. So we won't stress more to the memory allo=
cator.
>          */
>         struct vring_packed_desc *indir_desc;
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
> };
>
> why not put it there?
>

Fine.

Thanks


