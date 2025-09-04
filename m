Return-Path: <linux-kernel+bounces-799789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DBB4304F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424C62073D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D6E27FD74;
	Thu,  4 Sep 2025 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv8fkCak"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C927FB10
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955676; cv=none; b=qEZ5CMJ3MxIeWGE7z3u6QwSpU4lCzexF5L9rsKB8wVmIjN3FeB1VK8oIohjVH9HMMaRx3zYb23Q/EAnk7IN0wf5/fkLSObGUiUgjZGKOiad/hRwGavfctv4UWCemSWg8qwdeBHRQ1zgDiCwWn8Vd7dFxtkstC2aDl/oeXfHk7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955676; c=relaxed/simple;
	bh=TZhWSoFjQY5w2WWSbxQVGFziVgRuSlXr4SLtpPc7hIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqE4gGMqCAUmtyc3wi0gClhkhB7BvyaontwjrA6hAROL9RdWfj5Zqj1sKraBbUB+6/eLobjLM/z+G/9ak9ZCAZ/EmllYcvwQuAciNO/oVSHsrGyWWPszYPAaNhgfJ4s/BJxeLGsYDpgmZvK2genmFNtnbaMbLyOzBk3SzGGyTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv8fkCak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756955673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCiDn5H04rkZjFCYtNUdEvadwxb+GPvXtkL8Ot360us=;
	b=Tv8fkCakoPXOFEtjaMx2fLK7VUxSQCLD7e7apMOKRt+8kIukIrLDXt1yARggknuUhpCHvm
	cYEOasicVYecrNfaTKDgenHE5VLrF2g4xAEk/TcBMoMdgf9bYUcQ7oZpBLA/k6xojf6WKp
	TtjJHkcS/qw+evswhYoy63KO9tYiTT8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-sUAaVRFnOLSf4blBf60qXg-1; Wed, 03 Sep 2025 23:14:31 -0400
X-MC-Unique: sUAaVRFnOLSf4blBf60qXg-1
X-Mimecast-MFC-AGG-ID: sUAaVRFnOLSf4blBf60qXg_1756955670
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ab0409d3eso11819775ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 20:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756955670; x=1757560470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCiDn5H04rkZjFCYtNUdEvadwxb+GPvXtkL8Ot360us=;
        b=NGucexJwshyAMdJxC8cIPP+OtuBCsjlGr4JMnglB3rkwlqKV09Q702tOSfmS4p2nR5
         ARAbT1rNBU1ip79I6r4t3JAzoR85yyCkI/wNdNT2Sy5yMiol4oa5Ua9JSz3eHe0q+F/p
         23MotaEDZFeYicQsL/ghztIdyJ6g5Ml8eZTSH4BMXIJizP8xEYC4IWft/ERdDwbTWWG2
         e3VFMc0FUlguob1iRWNjVa8P0f/7MgAqMmFR8MC7M6mO976AUPGN1pnnxjonismUgfwl
         SGT9qXWBr2qgKZaLyLbJQJRbstx2hFsNv8V9se5zyvx6M2njC73IN4bSFBQYeXw1z871
         lWHw==
X-Forwarded-Encrypted: i=1; AJvYcCUJBJyKsysqSpHLMdJwpPWZY+IdgA+dRx5r2c1k0WGpAtgOPynQETzCgJuH1h+NzM3a85FNyBE7/PJGkm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4FS5c6ESMGXuul+zRNfwOOmE2PBExcspgROyeAaQKM1K+lDy
	YNnkSvbZnQmUe7IXcqFUiWX2PpEoGNztGyYwryOj9zp8ZVjEUMNctXBBtRz0SiFX33QE+Co2DUI
	Ogm+g9bT6MXWd/g6gjWRjlerfe3aa89Zjw+N3Uo1z3upWCrfTT8rY52XJw9C2bmKBnmutdb56vG
	l2tgEbv8XahCoekHcGhdeWJn1eaaLoK2p/8Cf4eu/J
X-Gm-Gg: ASbGnct+KXtdUp/fCtWMZbvXvhUrLqNajbxDTlVtGRILRA9tTn6uimlQh38SeJ1AI0g
	9pFVN7qLUexsGdGzeccYZJHl0aRXOOmA2KBozpO/fklbjOs5GMXofow/1FaFqSoGL+6snNnq/KE
	AG8bPOz+g2Ghpc1I/sy+Q=
X-Received: by 2002:a17:90a:d2c8:b0:31f:11d6:cea0 with SMTP id 98e67ed59e1d1-328156de009mr22638038a91.27.1756955329902;
        Wed, 03 Sep 2025 20:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhtUhnk2gyKH6P1Jrm7ejAxw8eDAf7V9I9M9HYnNF7GQqVJDL2YIWt2o/utv2qYF1Sj5kxTQGZLIaBtlkLp/I=
X-Received: by 2002:a17:90a:d2c8:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-328156de009mr22637997a91.27.1756955328664; Wed, 03 Sep 2025
 20:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
 <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
 <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com>
 <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
 <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com> <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Sep 2025 11:08:37 +0800
X-Gm-Features: Ac12FXw8ic7ZwoLUEnZNWeifQxpZmliXNdhzIdygh1SO4VzbUs1hcqr5FGbeVik
Message-ID: <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > This allows sepparate the different virtqueues in groups that=
 shares the
> > > > > > > same address space.  Asking the VDUSE device for the groups o=
f the vq at
> > > > > > > the beginning as they're needed for the DMA API.
> > > > > > >
> > > > > > > Allocating 3 vq groups as net is the device that need the mos=
t groups:
> > > > > > > * Dataplane (guest passthrough)
> > > > > > > * CVQ
> > > > > > > * Shadowed vrings.
> > > > > > >
> > > > > > > Future versions of the series can include dynamic allocation =
of the
> > > > > > > groups array so VDUSE can declare more groups.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bi=
t (Maxime)
> > > > > > >
> > > > > > > RFC v3:
> > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set =
to a lower
> > > > > > >   value to reduce memory consumption, but vqs are already lim=
ited to
> > > > > > >   that value and userspace VDUSE is able to allocate that man=
y vqs.
> > > > > > > * Remove the descs vq group capability as it will not be used=
 and we can
> > > > > > >   add it on top.
> > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > * Move the valid vq groups range check to vduse_validate_conf=
ig.
> > > > > > >
> > > > > > > RFC v2:
> > > > > > > * Cache group information in kernel, as we need to provide th=
e vq map
> > > > > > >   tokens properly.
> > > > > > > * Add descs vq group to optimize SVQ forwarding and support i=
ndirect
> > > > > > >   descriptors out of the box.
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++=
++++++++--
> > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > >         struct vdpa_vq_state state;
> > > > > > >         bool ready;
> > > > > > >         bool kicked;
> > > > > > > +       u32 vq_group;
> > > > > > >         spinlock_t kick_lock;
> > > > > > >         spinlock_t irq_lock;
> > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > >         u8 status;
> > > > > > >         u32 vq_num;
> > > > > > >         u32 vq_align;
> > > > > > > +       u32 ngroups;
> > > > > > >         struct vduse_umem *umem;
> > > > > > >         struct mutex mem_lock;
> > > > > > >         unsigned int bounce_size;
> > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struc=
t vdpa_device *vdpa, u16 idx,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 =
idx)
> > > > > > > +{
> > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > +
> > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa,=
 u16 idx,
> > > > > > >                                 struct vdpa_vq_state *state)
> > > > > > >  {
> > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct v=
dpa_device *vdpa)
> > > > > > >         return dev->status;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > +{
> > > > > > > +       /* All vqs and descs must be in vq group 0 if ngroups=
 < 2 */
> > > > > > > +       if (dev->ngroups < 2)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +               int ret;
> > > > > > > +
> > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > +               if (ret)
> > > > > > > +                       return ret;
> > > > > > > +
> > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.g=
roup;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, =
u8 status)
> > > > > > >  {
> > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct=
 vdpa_device *vdpa, u8 status)
> > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > >                 return;
> > > > > > >
> > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURE=
S_OK) &&
> > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > +                       return;
> > > > > >
> > > > > > I may lose some context but I think we've agreed that we need t=
o
> > > > > > extend the status response for this instead of having multiple
> > > > > > indepdent response.
> > > > > >
> > > > >
> > > > > My understanding was it is ok to start with this version by [1]. =
We
> > > > > can even make it asynchronous on top if we find this is a bottlen=
eck
> > > > > and the VDUSE device would need no change, would that work?
> > > >
> > > > I think I need to understand why we can not defer this to get_group=
_asid() call.
> > > >
> > >
> > > Because we need to know the vq_groups->asid mapping in other calls
> > > like set_group_asid or get_vq_group.
> >
> > I think we don't need the mapping of those, or anything I miss?
> >
>
> If the kernel module does not ask the userland device for the actual
> vq group of a virtqueue, what should it return in vduse_get_vq_group?
> 0 for all vqs, even if the CVQ is in vq group 1?

Since the topology is fixed I think userspace should provide this when
creating a device.

>
> That's also valid for vduse_get_vq_map, which return is assumed not to
> change in all the life of the device as it is not protected by a
> mutex.
>
> > And the vq to group mappings could be piggy backed by the device
> > creation request.
> >
>
> I'm not sure, I think it involves a vduse request per asid or vq group
> operation. Even get_vq_map. But I'm open to explore this possibility
> for sure.

Something like this?

struct vduse_vq_config {
        __u32 index;
        __u16 max_size;
        __u16 reserved[13];
};

?

Thanks

>
> > >
> > > We could add a boolean on each virtqueue to track if we know its
> > > virtqueue group and then only ask VDUSE device it if needed, would
> > > that work?
> >
> > Thanks
> >
> > >
> >
>


