Return-Path: <linux-kernel+bounces-767862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2023B259EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323DE883CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862371AC43A;
	Thu, 14 Aug 2025 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtybrrZI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94014A62B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142945; cv=none; b=H1G6WCYKgzTjPpHO7ez89OJELz/lcKbSYcyZ3mYW+JrshxIijghuKIHwZT9rseznyGtMZa3F5f7fJ3rqQ6tToXOFpOHMy2lfuraYhmJhqgoi8S7tMGeu1IhqBcdyoWKffeK29CCd2WxwBTQHVagP7Bn34otpiXwV+7Y0WFpjHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142945; c=relaxed/simple;
	bh=GDOuQ8e7rvpZZLraol9f9m6nY0aGOhLFU9xUo6o3hB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhTO9DWQTQ1lBXjs2UzQrDoLx1Szi0byaMpgS3KHdfrjVbOHpX638quYeBEEkM+p3Fnn5fqFzfQzVfuirixNq+jXBdla2FuPY5uXQa88FtkltWKglnDxx1xEsHHqNbj8oj4bAZRU5+Di+sg5XaOr+0M/p9PB6iOvEzUlUu6vYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtybrrZI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w97hjv5i+uwmkU+KfwU9kkYWprz91mHI8ezeUK8Eabo=;
	b=HtybrrZItstrp5qsbF0fM3rE2LrApKIWYlGjjUmPrqgPRFYK9++uuZpy01OoHUkkMOjg38
	j69VIoFfaswE96/LZMWra8P8E5KZ0cZcrfwi6pteybOSxgiLdvi7Wyv3cb/CSc2qzdYmBr
	yiU+ytqX/S8Ylgp1VRGpvoztcFlItSI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-pJbYay58MSCxZqSRT9zEbQ-1; Wed, 13 Aug 2025 23:42:21 -0400
X-MC-Unique: pJbYay58MSCxZqSRT9zEbQ-1
X-Mimecast-MFC-AGG-ID: pJbYay58MSCxZqSRT9zEbQ_1755142940
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47175d5a90so331287a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142940; x=1755747740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w97hjv5i+uwmkU+KfwU9kkYWprz91mHI8ezeUK8Eabo=;
        b=W7zkR/AhRolatnA7LWbnJ+QizKnmSacWcWuEq2SxBrr25Idpjda7070cpGolzLjou2
         ZatX6IM8mWsHvnldrBzVwqtFqLt3hLoew975Oy7JfWya+Wj3ZzkA7Z97uq8Us/4L6nz5
         eqVL9htEBTUI7fiq6M2ckcc65S7m4k3m1KOvO+/mfVwMcaaJTDAcTQ1m0nYlK3Ni7s4R
         +zFqGmPgIhmoN8+tP/QkE1IB5S1L1wg+qx6fmjmYtmNQdxXd908EVKbYN+9Kucomm+1L
         A1sAv4OpUq/PH4y1JpT2Kqs4ivZioWA2HM2BVhrIPo9COc+4r3x7UkhHdCJrOWIk8Hj0
         8IOA==
X-Forwarded-Encrypted: i=1; AJvYcCWBp16HgsdZ9UKerTZ9cacRwnB8k4Bzr8KDaD5hrd/2/N1nU8nEu2eNXdoIxBG/ss9RUpNj6WTxQ2FLGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNrVxB5VI4K92b83WwlXbxtc6CvAcOZFAVso3k0GUYCZ268qK
	uq0ocOnCUJx12Y8tTqoLoEM8qpQodiyyBsGAQxxKJcLGBPkmiK5HLLibVQvIgkYQUNkbqLj3N55
	K8MZEMmvr9RFsIL6GxgZC9sg36THStnkyaQS5rqUDNQ/CRinrTzGSHBr/o4911VRYh2TkH76vbA
	C8gMn+5GSBsBsTjbsbIuayhd4wKsdW1m9PXu5xY0fs
X-Gm-Gg: ASbGncsP2dvRuNXxF1lhWi8llD54IM+Vl0mlqq/2nT+tTOQYCrruGI4Rwv8AODJ4Abs
	p6q7eBlLWcau2GQachrvklB0lJgi4Ntr3u4ZPr2Ye6umEhq7soCnG/qdzSWU1cs8jof00WC3ehw
	RzCN2kiUoyDFtyf5dzYWQROA==
X-Received: by 2002:a17:90b:390f:b0:31e:ff94:3fba with SMTP id 98e67ed59e1d1-32327b58070mr2569934a91.24.1755142940029;
        Wed, 13 Aug 2025 20:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSvA6j4t0b5QEgBDxuYCwcd5Oei9P0Low20mXXvsuHEvsnzUysQd5NWOj+uF+Cn9ZIvD6ke761fuj+QMqLtN0=
X-Received: by 2002:a17:90b:390f:b0:31e:ff94:3fba with SMTP id
 98e67ed59e1d1-32327b58070mr2569889a91.24.1755142939498; Wed, 13 Aug 2025
 20:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
 <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
 <CAJaqyWfDVioqnprsER2r3yCpgdK4cTO8cxEMndf+-HLUxQtSOA@mail.gmail.com>
 <CACGkMEuZq2NaS9icynhrgZtXQ26fDFFpFrP3bUwDXLCR6uN4qw@mail.gmail.com> <CAJaqyWfB-nxpdtv+HRPB=7oc-MmquZ=7-mDqdVi42Mwf28CX7A@mail.gmail.com>
In-Reply-To: <CAJaqyWfB-nxpdtv+HRPB=7oc-MmquZ=7-mDqdVi42Mwf28CX7A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:42:07 +0800
X-Gm-Features: Ac12FXy1uiD6tKU5aMf7QAGhLniCOlqEn8-Wqgzk-g3rBHK3mItWz4VQoUaEPmY
Message-ID: <CACGkMEuVngGjgPZXnajiPC+pcbt+dr6jqKRQr8OcX7HK1W3WNQ@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:12=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Aug 12, 2025 at 5:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Aug 11, 2025 at 5:52=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Aug 11, 2025 at 5:10=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma=
@redhat.com> wrote:
> > > > >
> > > > > This allows sepparate the different virtqueues in groups that sha=
res the
> > > > > same address space.  Asking the VDUSE device for the groups of th=
e vq at
> > > > > the beginning as they're needed for the DMA API.
> > > > >
> > > > > Allocating 3 vq groups as net is the device that need the most gr=
oups:
> > > > > * Dataplane (guest passthrough)
> > > > > * CVQ
> > > > > * Shadowed vrings.
> > > > >
> > > > > Future versions of the series can include dynamic allocation of t=
he
> > > > > groups array so VDUSE can declare more groups.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v2:
> > > > > * Cache group information in kernel, as we need to provide the vq=
 map
> > > > >   tokens properly.
> > > > > * Add descs vq group to optimize SVQ forwarding and support indir=
ect
> > > > >   descriptors out of the box.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 71 ++++++++++++++++++++++++=
+++++-
> > > > >  include/uapi/linux/vduse.h         | 19 +++++++-
> > > > >  2 files changed, 88 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index d858c4389cc1..d1f6d00a9c71 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -46,6 +46,11 @@
> > > > >  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 10=
24)
> > > > >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> > > > >
> > > > > +/*
> > > > > + * Let's make it 3 for simplicity.
> > > > > + */
> > > > > +#define VDUSE_MAX_VQ_GROUPS 3
> > > >
> > > > I think we can release this to something like 64. Otherwise we migh=
t
> > > > bump the version again just to increase the limitation? Or having a
> > > > sysfs entry like bounce_size?
> > > >
> > >
> > > I think it should not be linked to the version, but it is true there
> > > is no way for VDUSE devices to check the maximum VQ groups / ASID tha=
t
> > > the kernel supports.
> > >
> > > To handle as bounce_size seems the best option, good point. I'll send
> > > a new version with that!
> > >
> > > > > +
> > > > >  #define IRQ_UNBOUND -1
> > > > >
> > > > >  struct vduse_virtqueue {
> > > > > @@ -58,6 +63,8 @@ struct vduse_virtqueue {
> > > > >         struct vdpa_vq_state state;
> > > > >         bool ready;
> > > > >         bool kicked;
> > > > > +       u32 vq_group;
> > > > > +       u32 vq_desc_group;
> > > > >         spinlock_t kick_lock;
> > > > >         spinlock_t irq_lock;
> > > > >         struct eventfd_ctx *kickfd;
> > > > > @@ -114,6 +121,7 @@ struct vduse_dev {
> > > > >         u8 status;
> > > > >         u32 vq_num;
> > > > >         u32 vq_align;
> > > > > +       u32 ngroups;
> > > > >         struct vduse_umem *umem;
> > > > >         struct mutex mem_lock;
> > > > >         unsigned int bounce_size;
> > > > > @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vd=
pa_device *vdpa, u16 idx,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +
> > > > > +       return dev->vqs[idx]->vq_group;
> > > > > +}
> > > > > +
> > > > > +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16=
 idx)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +
> > > > > +       return dev->vqs[idx]->vq_desc_group;
> > > > > +}
> > > > > +
> > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16=
 idx,
> > > > >                                 struct vdpa_vq_state *state)
> > > > >  {
> > > > > @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa=
_device *vdpa)
> > > > >         return dev->status;
> > > > >  }
> > > > >
> > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > +{
> > > > > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > > > > +               return 0;
> > > > > +
> > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > +               int ret;
> > > > > +
> > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > +               msg.req.vq_group.index =3D i;
> > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > >
> > > > I fail to understand why the default group mapping is not done duri=
ng
> > > > device creation.
> > > >
> > >
> > > Because it changes depending on the features.
> > >
> > > If a new device has 5 virtqueues and the device wants to isolate the
> > > CVQ, the CVQ position depends on the features that the guest's acks:
> > > * If MQ is acked the isolated vq is #5
> > > * If MQ is not acked the isolated vq is #3.
> >
> > I see we are still damaged by the design of the cvq index. But this is
> > just a static branch not a dynamic one. If we can find ways to make it
> > static it would be better.
> >
> > >
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> > > > > +
> > > > > +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.=
num;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 s=
tatus)
> > > > >  {
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +       u8 previous_status =3D dev->status;
> > > > >
> > > > >         if (vduse_dev_set_status(dev, status))
> > > > >                 return;
> > > > >
> > > > > +       if ((dev->status ^ previous_status) &
> > > > > +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > > > +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > +               if (vduse_fill_vq_groups(dev))
> > > >
> > > > Can we merge the two messages into a single one? Or can we use a
> > > > shared memory for storing such mapping?
> > > >
> > > > For example, if we have 256 queues it would be very slow.
> > > >
> > >
> > > To merge it in the same message is good to me, sure.
> >
> > We can start from this if we can't find a way to provision vq to group
> > mapping during device creation.
> >
>
> Note that I don't think it is worth implementing these in this series,
> but to add them on top in another one. Because I don't think we will
> find devices with a lot of virtqueues for now. But here are some ideas
> to mitigate the startup time cost:
>
> 1) Support more than one virtqueue in the same vduse request / reply
> Something like:
> vduse_dev_response{
>   u32 req_id;
>   u32 result;
>   union {
>     ...
>     struct vduse_vq_group {
>       u32 num_vqs_requested;
>       struct {
>         u32 vq_idx;
>         u32 vq_group;
>       } vqs[15];
>     }
>     u32 padding[32];
>   }
> }
>
> Choosing 15 to fill the current size of vduse_dev_response struct.
>
> 2) Pointer chasing in the struct written
>
> Same as previous, but the vqs struct is actually a pointer in
> userspace. This way it can be arbitrarily big.
>
> vduse_dev_response{
>   u32 req_id;
>   u32 result;
>   union {
>     ...
>     struct vduse_vq_group {
>       u32 num_vqs_requested;
>       struct {
>         u32 vq_idx;
>         u32 vq_group;
>       } *vqs;
>     }
>     u32 padding[32];
>   }
> }
>
> I cannot locate any use of this in write() data, but it is more or
> less common in ioctl.
>
> 3) Allow VQ_GROUP_BATCH_BEGIN and _END, similar to how memory map
> works in vhost_vdpa. As many vq_group response as needed in between.
>
> +) Assume that any vq not mentioned in the reply is vq group 0.

Or make VDUSE io_uring compatible.  (Anyhow it looks like another topic).

I'm fine if Michael and others are fine with starting with merging the
message. It's worth trying to reduce the userspace/kernel interaction
as much as possible.

Thanks

>
>
> > > To make it a
> > > table in shm seems more complicated, unless we accept a void * in the
> > > reply and VDUSE uses copy_from_user. If that is ok here, then sure.
> > >
> >
> > This looks tricky indeed.
> >
> > Thanks
> >
>


