Return-Path: <linux-kernel+bounces-802399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2CB45202
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA61016F2B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6528031D;
	Fri,  5 Sep 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGzP6Yjh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894A2C9D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062067; cv=none; b=G72d0zcf0d8RG8nFbH7SP+nPXUWGkYzqVMUdeO77XjSfKag7PvkSQbzYKOv2dn1LC7K6DBhZfBbyJsnx1wYSF0TvtiInEDSMMp/0Twbhdzum/tqbDqEAIAaUVZb1GSAkQKTTK89PoT6VyS7X4V+gLSvz7h3Wkq0BLT47RhudTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062067; c=relaxed/simple;
	bh=/74Z3X+uD87EcMsB6yk8ZXYmFiHeoQO6IR7FqqFeIKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSladgorHCu41UX0Lk+rWLkiFu4jCJqLPeMXsV1+qQespmqQVm1kqvA4otJiAx14Nmagdmqg4UDQ/eKyrgAQ05jzTv81dVrPWnXHTwcpxGPuEdHAP+AUu4OZR/rxYJSlwfOBrZQK0p4r95a33/80VIvkMnESpuu/Om7Ppjj24v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGzP6Yjh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757062064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JN32umJtcpXVPeX5VacSIko68Vpte1UknXqFDZxt9dY=;
	b=AGzP6YjhXOLZPHMHG12yWnOrJH9YxzMA2vh0KbG4FyV5nelTegnRaPjPEBR0s8jN94ogDf
	ff8dcXtqnNYa+EhkY95BJIiIoVDUE7OBHNGi8MfjjNYKah63sLVXoKC5YxNQZt01rBTUz4
	ukQVGleMUoZoCqoErtIH+Z228xRqDxM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-aHS2cfOJMXadk28ksrdLOg-1; Fri, 05 Sep 2025 04:47:42 -0400
X-MC-Unique: aHS2cfOJMXadk28ksrdLOg-1
X-Mimecast-MFC-AGG-ID: aHS2cfOJMXadk28ksrdLOg_1757062062
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so1496187a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062062; x=1757666862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN32umJtcpXVPeX5VacSIko68Vpte1UknXqFDZxt9dY=;
        b=IyxC/55vxqvSmdCF54SIg09KeDrN91dREbfSes/gdLlQHkcII9PfPNow6Oey3JvvAL
         YcrxStwePylQVpHCytHMb8+2fkbuus1OvZ/Z6eXQ7ZZrtd3hvWAyehsOVj12L2HjIKy4
         z4kGavTvXJ/YtUhgTtjGDiGZ4sjQdus7Yg1n1F2FlE8chJ5Q4P+UxmqXx7igjYjKfeM4
         jhLDQqhgtWhZZyOyUfQ6kx6bgFDjUMykGl+SnKGv1GxnE8aDH8JEHL7D4HVAMj/khL2S
         Tc148fJRxWB2ZYiv0/AbYAn4/4nd1MC6EF6HQE4uDI2eTH4HtPizzKPuW+uQiwB7sGGy
         3Idg==
X-Forwarded-Encrypted: i=1; AJvYcCUcc+ssH/wF82vQzdzl1fxaBdL00Q2YiFMz3BoID16SYSA4OB4Y47FFJEYUCau5xvaeENdhh9bsepRaefw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMegXdn869kr/fRwOLNNzJ1xNc8sUHg9Dluy+sX95GvSMm0N3k
	ONtxmFly5ywJUHyE40gs/Xe0njhM5NNFxObO22jndftvUk+y/0ccTNPZOjTzgl9toa3V0g4ZyNI
	gBwtxv07URR8cvF2cOjPY62UY3+CCE+aDEoA74T5Rp9JQbG4cZFbm4NKLBJixvJQSacZTvDiotJ
	MOVrdxI7DOqyxI8oLTG64JsdVo7+gdPoOLyH4u8x4v
X-Gm-Gg: ASbGnctmAmfI8kAdJRz58l2xfdg3lEoJw6phjrg+A8N7+C9Qefq73MjQZsaB7GeSXh1
	AbLfx5SJXWZcuhY7nppHIKtvD330oVwzMi9vsewkltLzG+/GyAw8npLgUDdApRmKmlwAAHOWfb4
	bbQWr/lI4efsWDiJ76NkFxktGyol9bB/nEVkpizn+6HdjeKcoxPMjPVwcPKyXnpz6hHZqXi91sJ
	iIGLV2zRw==
X-Received: by 2002:a17:90b:1c07:b0:327:be5f:8014 with SMTP id 98e67ed59e1d1-328156e36b4mr25414074a91.34.1757062061633;
        Fri, 05 Sep 2025 01:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6aJbcJq9tiNYjG67nXqIHQ1wbtbtO3VggZPeVvnvVDR/gz01fzjSq7ziByOvVvnVxqf3O402m1L3hap9pNW0=
X-Received: by 2002:a17:90b:1c07:b0:327:be5f:8014 with SMTP id
 98e67ed59e1d1-328156e36b4mr25414034a91.34.1757062060940; Fri, 05 Sep 2025
 01:47:40 -0700 (PDT)
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
 <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
 <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
 <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com> <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com>
In-Reply-To: <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Sep 2025 10:47:04 +0200
X-Gm-Features: Ac12FXwJo7hdeYjG_Cf-_TIhUxAoxK650HLtuWRJk35-dbiYua0PIBlzad4l8k8
Message-ID: <CAJaqyWcQwkpRZdKJBSHhtfLXfL5gb2_z8j-OsqSy3pPa+ZvYxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Sep 4, 2025 at 11:08=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > This allows sepparate the different virtqueues in groups =
that shares the
> > > > > > > > > same address space.  Asking the VDUSE device for the grou=
ps of the vq at
> > > > > > > > > the beginning as they're needed for the DMA API.
> > > > > > > > >
> > > > > > > > > Allocating 3 vq groups as net is the device that need the=
 most groups:
> > > > > > > > > * Dataplane (guest passthrough)
> > > > > > > > > * CVQ
> > > > > > > > > * Shadowed vrings.
> > > > > > > > >
> > > > > > > > > Future versions of the series can include dynamic allocat=
ion of the
> > > > > > > > > groups array so VDUSE can declare more groups.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > ---
> > > > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already th=
e bit (Maxime)
> > > > > > > > >
> > > > > > > > > RFC v3:
> > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was =
set to a lower
> > > > > > > > >   value to reduce memory consumption, but vqs are already=
 limited to
> > > > > > > > >   that value and userspace VDUSE is able to allocate that=
 many vqs.
> > > > > > > > > * Remove the descs vq group capability as it will not be =
used and we can
> > > > > > > > >   add it on top.
> > > > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > > > * Move the valid vq groups range check to vduse_validate_=
config.
> > > > > > > > >
> > > > > > > > > RFC v2:
> > > > > > > > > * Cache group information in kernel, as we need to provid=
e the vq map
> > > > > > > > >   tokens properly.
> > > > > > > > > * Add descs vq group to optimize SVQ forwarding and suppo=
rt indirect
> > > > > > > > >   descriptors out of the box.
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++=
++++++++++++--
> > > > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > > > >         struct vdpa_vq_state state;
> > > > > > > > >         bool ready;
> > > > > > > > >         bool kicked;
> > > > > > > > > +       u32 vq_group;
> > > > > > > > >         spinlock_t kick_lock;
> > > > > > > > >         spinlock_t irq_lock;
> > > > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > > > >         u8 status;
> > > > > > > > >         u32 vq_num;
> > > > > > > > >         u32 vq_align;
> > > > > > > > > +       u32 ngroups;
> > > > > > > > >         struct vduse_umem *umem;
> > > > > > > > >         struct mutex mem_lock;
> > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(s=
truct vdpa_device *vdpa, u16 idx,
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, =
u16 idx)
> > > > > > > > > +{
> > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > +
> > > > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *v=
dpa, u16 idx,
> > > > > > > > >                                 struct vdpa_vq_state *sta=
te)
> > > > > > > > >  {
> > > > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(stru=
ct vdpa_device *vdpa)
> > > > > > > > >         return dev->status;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > > > +{
> > > > > > > > > +       /* All vqs and descs must be in vq group 0 if ngr=
oups < 2 */
> > > > > > > > > +       if (dev->ngroups < 2)
> > > > > > > > > +               return 0;
> > > > > > > > > +
> > > > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) =
{
> > > > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > +               int ret;
> > > > > > > > > +
> > > > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > +               if (ret)
> > > > > > > > > +                       return ret;
> > > > > > > > > +
> > > > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_gro=
up.group;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vd=
pa, u8 status)
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(st=
ruct vdpa_device *vdpa, u8 status)
> > > > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEA=
TURES_OK) &&
> > > > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > > > +                       return;
> > > > > > > >
> > > > > > > > I may lose some context but I think we've agreed that we ne=
ed to
> > > > > > > > extend the status response for this instead of having multi=
ple
> > > > > > > > indepdent response.
> > > > > > > >
> > > > > > >
> > > > > > > My understanding was it is ok to start with this version by [=
1]. We
> > > > > > > can even make it asynchronous on top if we find this is a bot=
tleneck
> > > > > > > and the VDUSE device would need no change, would that work?
> > > > > >
> > > > > > I think I need to understand why we can not defer this to get_g=
roup_asid() call.
> > > > > >
> > > > >
> > > > > Because we need to know the vq_groups->asid mapping in other call=
s
> > > > > like set_group_asid or get_vq_group.
> > > >
> > > > I think we don't need the mapping of those, or anything I miss?
> > > >
> > >
> > > If the kernel module does not ask the userland device for the actual
> > > vq group of a virtqueue, what should it return in vduse_get_vq_group?
> > > 0 for all vqs, even if the CVQ is in vq group 1?
> >
> > Since the topology is fixed I think userspace should provide this when
> > creating a device.
> >

The topology is not fixed: The CVQ may be either the vq #2 or the last
one depending if mq has been negotiated or not.

So it cannot be provided at device creation, but only after feature negotia=
tion.

> > >
> > > That's also valid for vduse_get_vq_map, which return is assumed not t=
o
> > > change in all the life of the device as it is not protected by a
> > > mutex.
> > >
> > > > And the vq to group mappings could be piggy backed by the device
> > > > creation request.
> > > >
> > >
> > > I'm not sure, I think it involves a vduse request per asid or vq grou=
p
> > > operation. Even get_vq_map. But I'm open to explore this possibility
> > > for sure.
> >
> > Something like this?
> >
> > struct vduse_vq_config {
> >         __u32 index;
> >         __u16 max_size;
> >         __u16 reserved[13];
> > };
>
> I meant this actually:
>
> struct vduse_vq_config {
>          __u32 index;
>          __u16 max_size;
>          __u16 group;
>          __u16 reserved[12];
>  };
>

This is very interesting, the device should call VDUSE_VQ_SETUP in the
middle processing the VDUSE_SET_STATUS message, checking for
FEATURES_OK. Ok let's move to that, thanks!


