Return-Path: <linux-kernel+bounces-762291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC20B2048B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EA92A1D45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D491F4297;
	Mon, 11 Aug 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK3wHAPU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8C1F1537
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905925; cv=none; b=rTfFpZb68f919ZpQ0kGnBqn54RDTV3Ay7GnJp7stmgpjRmOQo9TBTGNa4BweVqoCbXuU5+SvGwDKcw0zYvse+Z0POBS1HHj1hr2Aubug++z6Kv08cxrheSfeD/WRWjW1PBx01JBKBfiDEGEy+fqrrhkxbUIPmReb6Mh4257OcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905925; c=relaxed/simple;
	bh=axX42gfmuRTzHHY8Rggs7YfjK8wvRrx7qKsMCogre7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCuFH+mHW07uW2lynLabf6bXmz9le5+YuTRlqsVOwrOKrxgs+r+nQeJQoRJoziq5tnSyN1WbPmtNwM7r3DK6ChOEMbN8JD2ZwZwbHBLD6L3YU2tSMOAXC6n3s0mKlmJaYMKBTDCgUuEqdryUmr/qxvf/UBNFpZATS925YM2vwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK3wHAPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754905922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=razzMAqxuDRq/lWoy/+ZlGcAwpJZlfJPFJRW2KQpfjg=;
	b=bK3wHAPUaKFi0/tObPMGhBIqfpsy3Xowl5OesmlQ1osNdYlw4HhfghNzXOvF8Zur05Tncd
	BxRhuEzzpRUZ8A5Gcjr+uQ4wgrnsAVXyiChNYumhv6onmyKX0fLPs3RwOw5w5TXbKsixXp
	h3IoUpFnNkM6aVR+/LzUEULW5u2wIuI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-xmwsBPuSOQuIl6mDCe7vfw-1; Mon, 11 Aug 2025 05:52:01 -0400
X-MC-Unique: xmwsBPuSOQuIl6mDCe7vfw-1
X-Mimecast-MFC-AGG-ID: xmwsBPuSOQuIl6mDCe7vfw_1754905921
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31eec17b5acso4900483a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905920; x=1755510720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=razzMAqxuDRq/lWoy/+ZlGcAwpJZlfJPFJRW2KQpfjg=;
        b=tsfGKcZfaGo6CjylJ9kEtJ6/pDtg/8RlUmmvW4PvjTkuVi62wn2XecTz5+ohJ+4yV+
         J80+7l0zBcS4DSaLw1P1UoPbACfjiPdhI4iREkn8jHcml52eFC1uGK4sNlObWHAb283J
         RPoq97xbyvdG5SHa3F+RWv9GvQ3wyMvVXAcIpTiMOk2vLA2zFZplRqFoBVqqKqGX4Yc9
         jF4I5Q/9Y5TP7kYD+26YbO/sFPORuR5EcseSF/vwFgQBFl3bc0MqglDjw48wq/0SLCYr
         gzD44eJgfbIVDn047y0dPtJrGLrGRpQvFG0+eIMBhQ6iYHk5bL0Nna0U2SEDRSF40imO
         uxFg==
X-Forwarded-Encrypted: i=1; AJvYcCUPNXb3VXiv2Yb/TtSRfgYIyLrsz5l+wf+g9GZAgCEIlUUcq7I+Ieb+hvXUuVdcc6NPbGt+0Y3qsBbFa9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuisdHTZfLs2YGHnpjMIOEGM3pAglriMfnbmmHZ/cXj6tVyPV
	AwV6fb5gjEYT/G3IEwgQC6hzYL3cp55c+NVqNOyUeN5Sah5jMTrpOMsZl1z0iZkOk7ZoI8yKrB5
	1y/vFNt4/868DVqwbDJSiQVNjhyrj3I1XCMV7X22IBOGRZxnltWS+JB7nG3XrTeGjGKG44t73vO
	evkxUU+N23yZvTrIyhsNVoliojdXa6nOd2RjLpZ/TzGtM0Mref6O8=
X-Gm-Gg: ASbGncuG0C8H0WmCSCQOpUIE/AjpFl79cu9yUUWZE/vctv+ttJAg4akGxu6685trXPh
	ojhlnxhjBoz4SHiZuKccdy1SrfJ1jylI4FOrgkTnm4sNX9u3WvDdWKXmsORFm6yLMxM7/cSy0EA
	mWlc+ACs2uYoQXbJZwX0nf
X-Received: by 2002:a17:90b:3e4b:b0:316:3972:b9d0 with SMTP id 98e67ed59e1d1-321838a7672mr19437894a91.0.1754905920388;
        Mon, 11 Aug 2025 02:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB/yM/8ypLq6xwy/TruMnl9ahp7f+nmV8xLhik2xEvyabJQhr8Z7KY0fGCQQSaiIhFrrAYRZVophIJxdQK/oA=
X-Received: by 2002:a17:90b:3e4b:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-321838a7672mr19437865a91.0.1754905919952; Mon, 11 Aug 2025
 02:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
In-Reply-To: <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Aug 2025 11:51:23 +0200
X-Gm-Features: Ac12FXwrY-EVjwroQmqKFrxwtn9Y_wEqtBPW6dBCT8tOtZhcmkI7hEVjO2_jb50
Message-ID: <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > This allows sepparate the different virtqueues in groups that shares th=
e
> > same address space.  Asking the VDUSE device for the groups of the vq a=
t
> > the beginning as they're needed for the DMA API.
> >
> > Allocating 3 vq groups as net is the device that need the most groups:
> > * Dataplane (guest passthrough)
> > * CVQ
> > * Shadowed vrings.
> >
> > Future versions of the series can include dynamic allocation of the
> > groups array so VDUSE can declare more groups.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v2:
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h         | 19 +++++++-
> >  2 files changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index d858c4389cc1..d1f6d00a9c71 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -46,6 +46,11 @@
> >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/*
> > + * Let's make it 3 for simplicity.
> > + */
> > +#define VDUSE_MAX_VQ_GROUPS 3
>
> I think we can release this to something like 64. Otherwise we might
> bump the version again just to increase the limitation? Or having a
> sysfs entry like bounce_size?
>

I think it should not be linked to the version, but it is true there
is no way for VDUSE devices to check the maximum VQ groups / ASID that
the kernel supports.

To handle as bounce_size seems the best option, good point. I'll send
a new version with that!

> > +
> >  #define IRQ_UNBOUND -1
> >
> >  struct vduse_virtqueue {
> > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
> > +       u32 vq_desc_group;
> >         spinlock_t kick_lock;
> >         spinlock_t irq_lock;
> >         struct eventfd_ctx *kickfd;
> > @@ -114,6 +121,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >         return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       return dev->vqs[idx]->vq_group;
> > +}
> > +
> > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       return dev->vqs[idx]->vq_desc_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_devic=
e *vdpa)
> >         return dev->status;
> >  }
> >
> > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > +{
> > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > +               return 0;
> > +
> > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > +               struct vduse_dev_msg msg =3D { 0 };
> > +               int ret;
> > +
> > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > +               msg.req.vq_group.index =3D i;
> > +               ret =3D vduse_dev_msg_sync(dev, &msg);
>
> I fail to understand why the default group mapping is not done during
> device creation.
>

Because it changes depending on the features.

If a new device has 5 virtqueues and the device wants to isolate the
CVQ, the CVQ position depends on the features that the guest's acks:
* If MQ is acked the isolated vq is #5
* If MQ is not acked the isolated vq is #3.

> > +               if (ret)
> > +                       return ret;
> > +
> > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > +
> > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.num;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >  {
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       u8 previous_status =3D dev->status;
> >
> >         if (vduse_dev_set_status(dev, status))
> >                 return;
> >
> > +       if ((dev->status ^ previous_status) &
> > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > +               if (vduse_fill_vq_groups(dev))
>
> Can we merge the two messages into a single one? Or can we use a
> shared memory for storing such mapping?
>
> For example, if we have 256 queues it would be very slow.
>

To merge it in the same message is good to me, sure. To make it a
table in shm seems more complicated, unless we accept a void * in the
reply and VDUSE uses copy_from_user. If that is ok here, then sure.


