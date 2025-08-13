Return-Path: <linux-kernel+bounces-766466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72BB246F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71690189D3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F082D0C9D;
	Wed, 13 Aug 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5kTGVS6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AF21256E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079954; cv=none; b=c3v802qXBTMor6vouk6xzTCLsl8O+eafvGaTLamZ+qIOZqmkZhDr9aYLCt4J1Q1FgxJ+o9xONnGukkrMNdlp7wlYZR+NR9AiDxRS4dLOquXA+0XkcvXcOAYnJ+gKucpa0Knu+YyRbLYMNIPUJ0URpP1oyvmc6uW9AtZWNIJ2iis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079954; c=relaxed/simple;
	bh=DSepXi7+wgxrvRLcEEpk7COlGGzMzmwUYw+2mA16qJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGxfDTa7/lcrhQIae8jOkE9penRq1CXB5uDuRpovWIbXb23w6aw1v/Zm+UpHpdaCUKFTQwrwsnsKlaTK45JsFNW1vspSWOr4O3y65VglIRT1PV3hbo6Er1cPcLuA9+w9G+eAgA5xG8JgDxCb/Yxy2JAXDc1PdVTIomzePJNeHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5kTGVS6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755079951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHixBqtVWa3TXGCBa7l2LROeCBnEtW1Ef55PxSt8KWM=;
	b=Z5kTGVS6ONwrjWIjGDg69unaSqN/QmVpNAD+s/WTF+xe0Gr0op01cc+aPecuNZ8yJPY1O3
	4FOzGxuRBYohPeRvudUf+eSEWg8/XAXz5/4XTjBj695UEJQ5wV2cb3l4D16nynu9S7vqfa
	Jue5nJN6nGBr6im4u7jSod+Krd/Ejr8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-9fElDqR7PBO1X-3MKllFMQ-1; Wed, 13 Aug 2025 06:12:30 -0400
X-MC-Unique: 9fElDqR7PBO1X-3MKllFMQ-1
X-Mimecast-MFC-AGG-ID: 9fElDqR7PBO1X-3MKllFMQ_1755079949
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400117dd80so48512175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079949; x=1755684749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHixBqtVWa3TXGCBa7l2LROeCBnEtW1Ef55PxSt8KWM=;
        b=r0rZRcDkKAwwirLw7k3tJE2Y7VfjWZaY6gTlrrSYtPOXqV/xPJi2uDc0c+koFrxBc+
         QdnzUcEfxq5qsAMI4TosF1RfDEXvAo9w5KBRJyqIUadzCDU351InJTn6MFMrEYkRDO9m
         S4cnEhuSuzeJ8kfv9NuPh4dYCpkNRzg/8LPQlg9lm2CDpOrtqBbBJpjyLJRXqwr6UveW
         cdbPIOfycX5i6SaMzbEISg55QoKE5qWuYqHbOU/kYCPaU4bju/GG2Sx6snyvBbGU1iF8
         beFQobB4GFulHVGjbEVGR7YoqpQ51fwhWvR2MAPBcArVT4hgjEmaih4cZb6Q8OSh1Gxq
         3LZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf1vvqPAFogWGTIag1znGkr5F3Wro1U8XWbuljQkucTVgk8B7oKSxNW9y2gRV0HjMCOQwWQ25PTnHisEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJloxGoJN8KA5261b41BTfdtqDBIaX5qUDB48b+dbg9Uxb/cUv
	rS0uCgUWCtHXm/C9R8WN5GRehvscwBYuXOq3RKxjw/i59oDVBNYsC6k83yVJ8U/NWlfAoB8+bOk
	Q1JaJZUvYnOg6jzKNBy3rAr+fLgs3WPOx0A92mT/Kc2qy03w3pp5Ft0f3nCvauaWz2fEg2lkzuD
	lyYwlAaE1rvRUuHaRXGBkbU+Irg7KMCkooJWzVEqT7
X-Gm-Gg: ASbGncuMGO4lBpixCRY0bQvUpHcwy/wOtzO78D5UJgS//jFKFytiFYCOinr1VsGbD3B
	y1KOA2X0pUtS1PvtGLeom0BBO7dElUqsTybPys6jiTm1JRCHk25cCzDul+QAnUVYG4iBhXLNpYp
	iO1JgqOlxwA9wWkzdUFJ8NjgNOQlO/7hrEs8o2Yn/W5v0Tk6MUHgVWH0g=
X-Received: by 2002:a17:903:22c3:b0:240:763d:e999 with SMTP id d9443c01a7336-2430d2240fbmr35242695ad.29.1755079948989;
        Wed, 13 Aug 2025 03:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKzaQylKARSlIDWyBCSLUNt17OsJJBw0HSyy1Q001ndr62TtyS4PIe+aETqHAl+HIv9I9mY6Cg7F2MRsnofy4=
X-Received: by 2002:a17:903:22c3:b0:240:763d:e999 with SMTP id
 d9443c01a7336-2430d2240fbmr35242435ad.29.1755079948503; Wed, 13 Aug 2025
 03:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
 <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com> <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com>
In-Reply-To: <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 12:11:52 +0200
X-Gm-Features: Ac12FXycNx9KHVG8siXjBVSykHaY3kyogXA38fKEKaMS0Ey8sg-AajQbZJtJYh8
Message-ID: <CAJaqyWfB-nxpdtv+HRPB=7oc-MmquZ=7-mDqdVi42Mwf28CX7A@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 11, 2025 at 5:52=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > > >
> > > > This allows sepparate the different virtqueues in groups that share=
s the
> > > > same address space.  Asking the VDUSE device for the groups of the =
vq at
> > > > the beginning as they're needed for the DMA API.
> > > >
> > > > Allocating 3 vq groups as net is the device that need the most grou=
ps:
> > > > * Dataplane (guest passthrough)
> > > > * CVQ
> > > > * Shadowed vrings.
> > > >
> > > > Future versions of the series can include dynamic allocation of the
> > > > groups array so VDUSE can declare more groups.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v2:
> > > > * Cache group information in kernel, as we need to provide the vq m=
ap
> > > >   tokens properly.
> > > > * Add descs vq group to optimize SVQ forwarding and support indirec=
t
> > > >   descriptors out of the box.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 ++++++++++++++++++++++++++=
+++-
> > > >  include/uapi/linux/vduse.h         | 19 +++++++-
> > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index d858c4389cc1..d1f6d00a9c71 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -46,6 +46,11 @@
> > > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024=
)
> > > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > > >
> > > > +/*
> > > > + * Let's make it 3 for simplicity.
> > > > + */
> > > > +#define VDUSE_MAX_VQ_GROUPS 3
> > >
> > > I think we can release this to something like 64. Otherwise we might
> > > bump the version again just to increase the limitation? Or having a
> > > sysfs entry like bounce_size?
> > >
> >
> > I think it should not be linked to the version, but it is true there
> > is no way for VDUSE devices to check the maximum VQ groups / ASID that
> > the kernel supports.
> >
> > To handle as bounce_size seems the best option, good point. I'll send
> > a new version with that!
> >
> > > > +
> > > >  #define IRQ_UNBOUND -1
> > > >
> > > >  struct vduse_virtqueue {
> > > > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> > > >         struct vdpa_vq_state state;
> > > >         bool ready;
> > > >         bool kicked;
> > > > +       u32 vq_group;
> > > > +       u32 vq_desc_group;
> > > >         spinlock_t kick_lock;
> > > >         spinlock_t irq_lock;
> > > >         struct eventfd_ctx *kickfd;
> > > > @@ -114,6 +121,7 @@ struct vduse_dev {
> > > >         u8 status;
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > > +       u32 ngroups;
> > > >         struct vduse_umem *umem;
> > > >         struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa=
_device *vdpa, u16 idx,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +
> > > > +       return dev->vqs[idx]->vq_group;
> > > > +}
> > > > +
> > > > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 i=
dx)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +
> > > > +       return dev->vqs[idx]->vq_desc_group;
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_d=
evice *vdpa)
> > > >         return dev->status;
> > > >  }
> > > >
> > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > +{
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > > +               return 0;
> > > > +
> > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > +               int ret;
> > > > +
> > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > +               msg.req.vq_group.index =3D i;
> > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > >
> > > I fail to understand why the default group mapping is not done during
> > > device creation.
> > >
> >
> > Because it changes depending on the features.
> >
> > If a new device has 5 virtqueues and the device wants to isolate the
> > CVQ, the CVQ position depends on the features that the guest's acks:
> > * If MQ is acked the isolated vq is #5
> > * If MQ is not acked the isolated vq is #3.
>
> I see we are still damaged by the design of the cvq index. But this is
> just a static branch not a dynamic one. If we can find ways to make it
> static it would be better.
>
> >
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +
> > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > > > +
> > > > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +
> > > > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.nu=
m;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 sta=
tus)
> > > >  {
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       u8 previous_status =3D dev->status;
> > > >
> > > >         if (vduse_dev_set_status(dev, status))
> > > >                 return;
> > > >
> > > > +       if ((dev->status ^ previous_status) &
> > > > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > > > +               if (vduse_fill_vq_groups(dev))
> > >
> > > Can we merge the two messages into a single one? Or can we use a
> > > shared memory for storing such mapping?
> > >
> > > For example, if we have 256 queues it would be very slow.
> > >
> >
> > To merge it in the same message is good to me, sure.
>
> We can start from this if we can't find a way to provision vq to group
> mapping during device creation.
>

Note that I don't think it is worth implementing these in this series,
but to add them on top in another one. Because I don't think we will
find devices with a lot of virtqueues for now. But here are some ideas
to mitigate the startup time cost:

1) Support more than one virtqueue in the same vduse request / reply
Something like:
vduse_dev_response{
  u32 req_id;
  u32 result;
  union {
    ...
    struct vduse_vq_group {
      u32 num_vqs_requested;
      struct {
        u32 vq_idx;
        u32 vq_group;
      } vqs[15];
    }
    u32 padding[32];
  }
}

Choosing 15 to fill the current size of vduse_dev_response struct.

2) Pointer chasing in the struct written

Same as previous, but the vqs struct is actually a pointer in
userspace. This way it can be arbitrarily big.

vduse_dev_response{
  u32 req_id;
  u32 result;
  union {
    ...
    struct vduse_vq_group {
      u32 num_vqs_requested;
      struct {
        u32 vq_idx;
        u32 vq_group;
      } *vqs;
    }
    u32 padding[32];
  }
}

I cannot locate any use of this in write() data, but it is more or
less common in ioctl.

3) Allow VQ_GROUP_BATCH_BEGIN and _END, similar to how memory map
works in vhost_vdpa. As many vq_group response as needed in between.

+) Assume that any vq not mentioned in the reply is vq group 0.


> > To make it a
> > table in shm seems more complicated, unless we accept a void * in the
> > reply and VDUSE uses copy_from_user. If that is ok here, then sure.
> >
>
> This looks tricky indeed.
>
> Thanks
>


