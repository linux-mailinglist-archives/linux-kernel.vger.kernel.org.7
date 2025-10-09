Return-Path: <linux-kernel+bounces-846284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A447BC7783
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AE2D4E0554
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FA26159E;
	Thu,  9 Oct 2025 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMvYdYU5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36757AD4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989371; cv=none; b=dG4Y+lizZonoqS3FE16HRcTZldzV5C+9YHKy5ZzH1e+jJZoEcwpv11PsfgCmcvc4QTIh4OclfWmZtxqmGYvW/h6/buJIunPgk1iPwk0bwZMlcpk7Ewh4qUA7dG+mXYd7ymWLO5N4upJ/E3a0duXQ7fLU7t26P4WdcMVka9RxvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989371; c=relaxed/simple;
	bh=B7rrwZA3P87YDou+AIO5jYQa3aCNJFxAB6yvUqB2E9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl4oroUwNdy63NmUnwiyxJvzZW9LQYo+kil1i9JUYBGbrng/twLJnWx3Dr8o9UdivgzsdZ2wskLSho/gtHZYok6QzI1JTTHoQYqeXQvYepS/bsesGDmlxDyn94dHYUNxDrwbkaAUuHciku+bcOH5yqC4TqxYTj49rl9RKKNZJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMvYdYU5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759989366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkgKUr7nW5eH/tRqRYLI/of3JXuQQWQkB8Qwck9RD7k=;
	b=iMvYdYU5C4rJsrpBQ1xjI4o7UtKR3meUyJ1RdnU9gZwXAWvqIkXcFmD/OsKsdRMjg39tjV
	ryr+v9v/amGWLXQLh1MqDBbeRnYIANbm/3O7hyhlDY2N9R6ZABT27U0QQC6pvM2LuvJbHy
	FY5WY7SdT4CGcqLzt6r2a8ZNdo6C12M=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-ZPoiO5UcOGeTQKpFFiCZgw-1; Thu, 09 Oct 2025 01:56:05 -0400
X-MC-Unique: ZPoiO5UcOGeTQKpFFiCZgw-1
X-Mimecast-MFC-AGG-ID: ZPoiO5UcOGeTQKpFFiCZgw_1759989365
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5a631c279fbso326552137.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989365; x=1760594165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkgKUr7nW5eH/tRqRYLI/of3JXuQQWQkB8Qwck9RD7k=;
        b=LMuK8y+gMlp6eqh4wJUA5Yg/MT3WLlRHhi6opmZvzCUhLSefvjkAcS+5h68zzy/sPc
         rFC3jVKK7ofT7u7JmiyV+ts4DdfOrdWavuikMS4htXWEtCRdhxj8nC2YONJT6kcJtRHO
         762q4SQRSQR7RA/wVloyCcTIqexvKLPBCZj0R4lQ0jhrpkhC6hBGf6aSNd45znP174j3
         /rvIN3clT+W6ICkBfFBsCqzlR5Wjb52yJpuDRiqQSo2qy34Jpx5bH5VxxuvEBv4KBEXq
         d7NyARKBzuEKXJJPRdYmwKBvDZoEfOgF8aIPK9wOztHqJQ50B04AVcDYNiBb7iFiyrxL
         Z82g==
X-Forwarded-Encrypted: i=1; AJvYcCVcHuKkFf4lOKZlnc9ixTiKcvtgSCfyWl+/j2DqrED3Y8U2CttLAzq1pBzIsMcdYLh2FWcuBDOf76lj1X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6W0Z6UEDMy2E4s2nKwOgRi86kQ9JvRPnT58W8eEBFtH8+enti
	CKdflldIXvaPs8qvYhdw3xbdFiLcJK84mhU1dqCI6g2ubrpyYiks3/fKcd7BEP/gCnu18M7BLim
	K2sDYno1Z4i0jrdrRWZ65SWB5brz1ByFsf7rCAa50wEYURwIZXZ8bheKFR9fRm9sd+2XUNF48uy
	wde7GUmqo+x57All+MEP8hv6GaM3JYMDs5NisrHVaJ
X-Gm-Gg: ASbGncs/z5olaOqd9UTMtfPq7va+NlopKpQcQFsxQAkvWKLJV/AdasaoZtNoglXZISv
	hKppCQmISrEXhW3tvPwi3jDLsbfmoXL47Ie4pqskogPZgWCQyYIWb+XPKY/2euoYT0h/X1RQVOA
	yP9PDm2774hQbUke7sgDyWAwY=
X-Received: by 2002:a05:6102:8382:20b0:5d3:fed4:ac2b with SMTP id ada2fe7eead31-5d5e22169bfmr2099143137.1.1759989364945;
        Wed, 08 Oct 2025 22:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEwVhF+06KroYaF8WqxvvYiwVN1v9gL+gRbbNz0RnMP4XrCEdzlCCNjmi+LUJwToQCK8zW8nDJYljKZxmqAsA=
X-Received: by 2002:a05:6102:8382:20b0:5d3:fed4:ac2b with SMTP id
 ada2fe7eead31-5d5e22169bfmr2099142137.1.1759989364581; Wed, 08 Oct 2025
 22:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-13-jasowang@redhat.com>
 <20250928192719.7ea3a825@pumpkin> <20250929041808-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250929041808-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 13:55:51 +0800
X-Gm-Features: AS18NWDSHW-Jk2HDDnAxuppRxg2y4I86CInrH0RysfQYUeKuWAXTaaP2DlRkFrQ
Message-ID: <CACGkMEuSSGNFMiwcD5UBvpQcUxtLmA-2PiT3AD_Sf3YSzndjMQ@mail.gmail.com>
Subject: Re: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 28, 2025 at 07:27:19PM +0100, David Laight wrote:
> > On Thu, 25 Sep 2025 18:37:01 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> > > spec.
> >
> > If you care about performance you should pretty much never use 'u16' fo=
r
> > function parameters, return values or any arithmetic.
> > Just because the domain of the variable is [0..65535] doesn't mean that
> > 'unsigned int' isn't the correct type.
> >
> > >
> > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
>
> I don't like this because it is inconsistent with virtqueue_poll.
>
>
> If you are going to change this, change virtqueue_enable_cb_prepare_split
> too.
>
>
> But really there's no point.
>
>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 58c03a8aab85..4679a027dc53 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> > >  }
> > >
> > >  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> > > -                            unsigned int last_used_idx)
> > > +                            u16 last_used_idx)
> > >  {
> > >     return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,
> >
> > You can't want that (u16) cast now, I doubt it was ever needed.
> > Note that the compiler promotes the value to 'signed int',
> > so the LHS of the comparison is actually (int)(u16)last_used_idx.
> >
> >       David
>
> It is not needed because the value is from
> virtqueue_enable_cb_prepare_split:
>
> static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_=
vq)
> {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used_idx;
>
>         START_USE(vq);
>
>         /* We optimistically turn back on interrupts, then check if there=
 was
>          * more to do. */
>         /* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
>          * either clear the flags bit or point the event index at the nex=
t
>          * entry. Always do both to keep code simple. */
>         if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
>                 vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTER=
RUPT;
>                 if (!vq->event)
>                         vq->split.vring.avail->flags =3D
>                                 cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
>         vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(_vq->vdev,
>                         last_used_idx =3D vq->last_used_idx);
>         END_USE(vq);
>         return last_used_idx;
> }
>
>
>
>
>
>
> > >                     vq->split.vring.used->idx);
>

I will drop this in the next version.

Thanks


