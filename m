Return-Path: <linux-kernel+bounces-763885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312FCB21B35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99134619F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC22E11B5;
	Tue, 12 Aug 2025 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBwoXOea"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8872DBF5E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967701; cv=none; b=qcomcP/BltpJ72/wfvmLhuK8se29oCQwucth0yrP3/5ozcu3cATn3jwnnm6UdYIQ35ojZsWnCYxeHA14c/NWDRRA4F06qyZgsG/WZ/FW3/M5+4Wtctj/BCuSpXPmH5cCxywOML0ntQURKeTa3IhsAuJxZTCCO9+pMEA7bimTfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967701; c=relaxed/simple;
	bh=FRNkmyIGRZfkC5SrUwIs8BFVvGk7FLcVut2X8jIKp/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTjokRACxSWSQ0pQ9BHN3FG8KUDcXC/AdR8OEz8NcnQ6Sl6n19T4Ifh77L+DcgpZx4YBfowcbOC4t4/HHofhunOkrd/8PzmaR91hsZ0FFX8KRrdIEVMdtrTJKRCPOJEBo8d/+EqIZmzsmRubHPSImnLvV6+5sBwe65PGCGeDvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBwoXOea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754967697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXcDrKzmleXkZZvSJcFC+popEo/MH2O5hILC0DB+8iE=;
	b=TBwoXOeaS78RlHVXPpcbHZ2HMFxQA5lVDJFQp9EfDBR5p1hDK7UC2PwbB+gdBLoATZ1uJa
	p6MGT2nWUdav069wjo3qUcnM8G9E/if9rZ8QHac2C1cLEVDfYvzMSJheRPfDXDZjHAhq43
	KpN4D0887cD/j8Jde6BGOFSHtWPPufQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-2laq5ijFNmanygkRY36Cdg-1; Mon, 11 Aug 2025 23:01:36 -0400
X-MC-Unique: 2laq5ijFNmanygkRY36Cdg-1
X-Mimecast-MFC-AGG-ID: 2laq5ijFNmanygkRY36Cdg_1754967695
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2425364e0b2so57908785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967695; x=1755572495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXcDrKzmleXkZZvSJcFC+popEo/MH2O5hILC0DB+8iE=;
        b=JY3qpZkwbFttLUED8vQ/mBkkjyvd0GtsfvWzJD1odo/6JYYX2Yle94qBuDOBZUBMg4
         EDZik8YXkzrwUiie5c8HEiDF9mwhVE3vno4TSNDN6t93CNISaStBMDy2RpVrIns82plH
         9S7jtLOM6LBLgyT1Fj4rhHyVBz5s9DawlmmT+8h+ANpGBF0JqAPAvV3G8zjmd9uDRg1Q
         SxTuDuLiRPK0fve/WSWvQin3wF97NZh6iAMeETYNHxcNHWr8M9Oj0f/ki9V3q/M4CdUt
         Wqhv3LcMJ/zB6koGz4VNvl6LlpIt0f3RdxW8Iz5+DV+98N0by2ANBNDZoE1cQ2e2rJ2W
         lFjA==
X-Forwarded-Encrypted: i=1; AJvYcCUU+Kzt56YMqPtvPr21yhwshXAnNo3gES9Qs01xtw8qZ6r0xWa/ABKnG9bRqSYBxle0ExnF8mc+nhxKyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTME/A1Oxte14gpXlRBYiuX32xiQRw2Yjlw5lvhrbpn+tp2p5m
	XwV8KZJbdAQjGiLW7IHOa4GR5R58UlPBVT05pCP60W9otAgRWoqFREJa9eJwBXknchbUTi3SFxX
	yIbBuV3CrYY2x8zGZ9VwuJfGx/3zZYIBbk1eJnYSboZu6/DF/NgMwdhX1q9Do4yC4qxrnZ+BhSr
	rfmQhn1uObHgo1Gy6iOtwSEsqlLkhjvd94dP/HjQfx
X-Gm-Gg: ASbGncttUQ93Tx6dgDzJ2w2J4kQ0RM0HTz/s08s6bNg+TqkT7TZuncWMhfJHvSwhzTB
	73cCDipHoYNWBvBPbjVKKNvCx4TgBl5PGW2pMDpruy7LDt6MyUUg1GaPMw+TqrCfEZqvKq8zvQF
	+dVik4aE50PblnpJ3vo9LqIaI=
X-Received: by 2002:a17:902:fc47:b0:242:d8df:f825 with SMTP id d9443c01a7336-242fc367f3amr20963155ad.27.1754967694953;
        Mon, 11 Aug 2025 20:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoPjpmdiT5XkbDR7sZg80IBGgYIt3Zm3upy7dVJWT730qe7UD8OfkIsBZsMHYybaQR6Pc3E5yWW93/A2lkZa0=
X-Received: by 2002:a17:902:fc47:b0:242:d8df:f825 with SMTP id
 d9443c01a7336-242fc367f3amr20962725ad.27.1754967694446; Mon, 11 Aug 2025
 20:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com> <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
In-Reply-To: <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 11:01:23 +0800
X-Gm-Features: Ac12FXy6buDk7v1XeKBtiDS7OwYpGm54-0cAvQTN7fCpc1VH-iW_THBu3PGqyzM
Message-ID: <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:52=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > This allows sepparate the different virtqueues in groups that shares =
the
> > > same address space.  Asking the VDUSE device for the groups of the vq=
 at
> > > the beginning as they're needed for the DMA API.
> > >
> > > Allocating 3 vq groups as net is the device that need the most groups=
:
> > > * Dataplane (guest passthrough)
> > > * CVQ
> > > * Shadowed vrings.
> > >
> > > Future versions of the series can include dynamic allocation of the
> > > groups array so VDUSE can declare more groups.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v2:
> > > * Cache group information in kernel, as we need to provide the vq map
> > >   tokens properly.
> > > * Add descs vq group to optimize SVQ forwarding and support indirect
> > >   descriptors out of the box.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 ++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/vduse.h         | 19 +++++++-
> > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index d858c4389cc1..d1f6d00a9c71 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -46,6 +46,11 @@
> > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
> > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > >
> > > +/*
> > > + * Let's make it 3 for simplicity.
> > > + */
> > > +#define VDUSE_MAX_VQ_GROUPS 3
> >
> > I think we can release this to something like 64. Otherwise we might
> > bump the version again just to increase the limitation? Or having a
> > sysfs entry like bounce_size?
> >
>
> I think it should not be linked to the version, but it is true there
> is no way for VDUSE devices to check the maximum VQ groups / ASID that
> the kernel supports.
>
> To handle as bounce_size seems the best option, good point. I'll send
> a new version with that!
>
> > > +
> > >  #define IRQ_UNBOUND -1
> > >
> > >  struct vduse_virtqueue {
> > > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> > >         struct vdpa_vq_state state;
> > >         bool ready;
> > >         bool kicked;
> > > +       u32 vq_group;
> > > +       u32 vq_desc_group;
> > >         spinlock_t kick_lock;
> > >         spinlock_t irq_lock;
> > >         struct eventfd_ctx *kickfd;
> > > @@ -114,6 +121,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       return dev->vqs[idx]->vq_group;
> > > +}
> > > +
> > > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx=
)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       return dev->vqs[idx]->vq_desc_group;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_dev=
ice *vdpa)
> > >         return dev->status;
> > >  }
> > >
> > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > +{
> > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > +               return 0;
> > > +
> > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > +               struct vduse_dev_msg msg =3D { 0 };
> > > +               int ret;
> > > +
> > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > +               msg.req.vq_group.index =3D i;
> > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> >
> > I fail to understand why the default group mapping is not done during
> > device creation.
> >
>
> Because it changes depending on the features.
>
> If a new device has 5 virtqueues and the device wants to isolate the
> CVQ, the CVQ position depends on the features that the guest's acks:
> * If MQ is acked the isolated vq is #5
> * If MQ is not acked the isolated vq is #3.

I see we are still damaged by the design of the cvq index. But this is
just a static branch not a dynamic one. If we can find ways to make it
static it would be better.

>
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > > +
> > > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.num;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 statu=
s)
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       u8 previous_status =3D dev->status;
> > >
> > >         if (vduse_dev_set_status(dev, status))
> > >                 return;
> > >
> > > +       if ((dev->status ^ previous_status) &
> > > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > > +               if (vduse_fill_vq_groups(dev))
> >
> > Can we merge the two messages into a single one? Or can we use a
> > shared memory for storing such mapping?
> >
> > For example, if we have 256 queues it would be very slow.
> >
>
> To merge it in the same message is good to me, sure.

We can start from this if we can't find a way to provision vq to group
mapping during device creation.

> To make it a
> table in shm seems more complicated, unless we accept a void * in the
> reply and VDUSE uses copy_from_user. If that is ok here, then sure.
>

This looks tricky indeed.

Thanks


