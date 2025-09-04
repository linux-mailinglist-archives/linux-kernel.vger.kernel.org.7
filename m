Return-Path: <linux-kernel+bounces-799797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E58B43066
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0804F5464CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FD279784;
	Thu,  4 Sep 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hxcc4e9t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A8227E95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956057; cv=none; b=D9TXbrDJn+ySYIZi1dTFAH0+Z02OiXgij/EgEpRD8mc56aRBSMO3TVE1GlJNd7WREubdWrik/k8AEZYoPxUUOCTSpm52LWQ1GJ7WVYK9kXvH8r7o5Qq5npGQURgLdnAHe3k83AlbINYCO8oQAeLa4BnqB2baPpEyTLgkH5lHGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956057; c=relaxed/simple;
	bh=U8zkNR408R5lC7reYyHNV/sMBsdZEwbHOlZkOZ5wb6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBxmQBZ/4qECmm6vrgrwldRXZ9dZWLV6tR/p4wXzt5mmIzfJZ8HMsc9c3oKnNvnkLlSn4MAsjEWYGD0/WABDVJixyrDWtKjGQzWstQEiuMfK11YG6XX2S9MYf0yLp3MXuihGkZ0Ls82pCSr4/Au4L8rUH0EHfp+iGGHIBvYNojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hxcc4e9t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756956054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYeAiRlrESzVY2rtsnHoo7euyCP7a9OtxpO6pZFgbIQ=;
	b=Hxcc4e9ttW5rIv/5Avvy6MOXutVH2wbBew8S+GiO7WbV7X4gqvtRgd+TEsld1njzd0umqk
	hlIWZaPZQUKipZO/2j6z2c+HVQkuN6R10iGlXulfUpVWZeXY7zTmDoNJoaB9u+lRJIyC96
	reV2aR2l991/mAuc5Pusolz8S40nnvQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-eiCxsA-HPQ2N1pMS8NDzYw-1; Wed, 03 Sep 2025 23:20:52 -0400
X-MC-Unique: eiCxsA-HPQ2N1pMS8NDzYw-1
X-Mimecast-MFC-AGG-ID: eiCxsA-HPQ2N1pMS8NDzYw_1756956051
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724ff1200eso518597b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 20:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756956051; x=1757560851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYeAiRlrESzVY2rtsnHoo7euyCP7a9OtxpO6pZFgbIQ=;
        b=qik6gO515WV1LOe4Zlr0hsL15mW5z0FHy8I2C8moaTfCswkvEDtinNh56RwyeD3+bo
         LoFyCss2x6tSPAbQbaL4GFgoVNa0eJRYgh2ZBJD84DPoLwqKjcXJNyyG6pwCWs8Yrc7g
         9h4pyWVuL8RZiZP5fwcSwIo/J4DnWmB4hdqz9u6G3IfvGUCn5RtU5r/BGlaVqMCOYm5d
         eJiLZ9YAO7lUmsOjans+0xWngPimSmYIJ+F+3kpodesVviVf5/P7elDBIb18qlP4DEUb
         YHdN+8E9/oH00jTH6bHtK1arPCkurrQjxqV25/k0jBPW/vGOqmAs8tvpmvs2odSd2yFl
         u+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2XVNRcq5FZol54mxDpuhHYlP+tVcU6yoxFL8fE+7U0cjlv0+jAB90BlEBDiWqs0KOhTAUQf0svHtONM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdl39/GduKCTToqIGnJaAUIlT0S2iXaTnbWC12+tjBGLLDAze
	tgnZfbV/1x9djWWyFxL4sgTpn/eZP6y7ksXakrIXf4OClzZmg0xSs+0nGe5oBRNyoDaaa2mmp4b
	iQvNJmNycTBpV+xW9UIZgpurUlzGJoP3tgvbZS6TiWjsjq90xhTxQ9umV7J0WayvBUMbNuOlLUc
	bTXgtTVJeKePADkBivqJKbaao6wjRXBb8zy+Pi5LQiqBJxm6nd3YHxqg==
X-Gm-Gg: ASbGncs/JyzqlLF1+vJ/RXHRoRC34UfuimrmQ7gTgPRUBJaVKGX+F3C1yy5p3mhub5h
	9leO6tUGwU3cBFiYJxyp788L6RBP3IqQlmARiO0el89jZC1mwxo5i+ljbQHo7mVwuU84xJrKs67
	QuMA098D7V34MPSprZ1/Q=
X-Received: by 2002:a05:6a20:728f:b0:243:be7c:2d6d with SMTP id adf61e73a8af0-243d6dd4de1mr23578295637.1.1756956050926;
        Wed, 03 Sep 2025 20:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxN2ss2Tu1NnzW2/VPa9xEjG9aoFD7PIdzoU1fhttcBvpzeRguCNiIV9tik0ESRkodbFr1Zw1cWtiO5fxTQ+0=
X-Received: by 2002:a05:6a20:728f:b0:243:be7c:2d6d with SMTP id
 adf61e73a8af0-243d6dd4de1mr23578263637.1.1756956050444; Wed, 03 Sep 2025
 20:20:50 -0700 (PDT)
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
 <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com> <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com>
In-Reply-To: <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Sep 2025 11:20:38 +0800
X-Gm-Features: Ac12FXwM58z3suw1t6TTJi3qI-zRs_7fxJEWdHRLkkZCmnaPOL9e8em_gAVvj8w
Message-ID: <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:08=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <e=
perezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > This allows sepparate the different virtqueues in groups th=
at shares the
> > > > > > > > same address space.  Asking the VDUSE device for the groups=
 of the vq at
> > > > > > > > the beginning as they're needed for the DMA API.
> > > > > > > >
> > > > > > > > Allocating 3 vq groups as net is the device that need the m=
ost groups:
> > > > > > > > * Dataplane (guest passthrough)
> > > > > > > > * CVQ
> > > > > > > > * Shadowed vrings.
> > > > > > > >
> > > > > > > > Future versions of the series can include dynamic allocatio=
n of the
> > > > > > > > groups array so VDUSE can declare more groups.
> > > > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > ---
> > > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the =
bit (Maxime)
> > > > > > > >
> > > > > > > > RFC v3:
> > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was se=
t to a lower
> > > > > > > >   value to reduce memory consumption, but vqs are already l=
imited to
> > > > > > > >   that value and userspace VDUSE is able to allocate that m=
any vqs.
> > > > > > > > * Remove the descs vq group capability as it will not be us=
ed and we can
> > > > > > > >   add it on top.
> > > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > > * Move the valid vq groups range check to vduse_validate_co=
nfig.
> > > > > > > >
> > > > > > > > RFC v2:
> > > > > > > > * Cache group information in kernel, as we need to provide =
the vq map
> > > > > > > >   tokens properly.
> > > > > > > > * Add descs vq group to optimize SVQ forwarding and support=
 indirect
> > > > > > > >   descriptors out of the box.
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++=
++++++++++--
> > > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > > >         struct vdpa_vq_state state;
> > > > > > > >         bool ready;
> > > > > > > >         bool kicked;
> > > > > > > > +       u32 vq_group;
> > > > > > > >         spinlock_t kick_lock;
> > > > > > > >         spinlock_t irq_lock;
> > > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > > >         u8 status;
> > > > > > > >         u32 vq_num;
> > > > > > > >         u32 vq_align;
> > > > > > > > +       u32 ngroups;
> > > > > > > >         struct vduse_umem *umem;
> > > > > > > >         struct mutex mem_lock;
> > > > > > > >         unsigned int bounce_size;
> > > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(str=
uct vdpa_device *vdpa, u16 idx,
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u1=
6 idx)
> > > > > > > > +{
> > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > +
> > > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdp=
a, u16 idx,
> > > > > > > >                                 struct vdpa_vq_state *state=
)
> > > > > > > >  {
> > > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct=
 vdpa_device *vdpa)
> > > > > > > >         return dev->status;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > > +{
> > > > > > > > +       /* All vqs and descs must be in vq group 0 if ngrou=
ps < 2 */
> > > > > > > > +       if (dev->ngroups < 2)
> > > > > > > > +               return 0;
> > > > > > > > +
> > > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > +               int ret;
> > > > > > > > +
> > > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > +               if (ret)
> > > > > > > > +                       return ret;
> > > > > > > > +
> > > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group=
.group;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa=
, u8 status)
> > > > > > > >  {
> > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(stru=
ct vdpa_device *vdpa, u8 status)
> > > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > > >                 return;
> > > > > > > >
> > > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATU=
RES_OK) &&
> > > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > > +                       return;
> > > > > > >
> > > > > > > I may lose some context but I think we've agreed that we need=
 to
> > > > > > > extend the status response for this instead of having multipl=
e
> > > > > > > indepdent response.
> > > > > > >
> > > > > >
> > > > > > My understanding was it is ok to start with this version by [1]=
. We
> > > > > > can even make it asynchronous on top if we find this is a bottl=
eneck
> > > > > > and the VDUSE device would need no change, would that work?
> > > > >
> > > > > I think I need to understand why we can not defer this to get_gro=
up_asid() call.
> > > > >
> > > >
> > > > Because we need to know the vq_groups->asid mapping in other calls
> > > > like set_group_asid or get_vq_group.
> > >
> > > I think we don't need the mapping of those, or anything I miss?
> > >
> >
> > If the kernel module does not ask the userland device for the actual
> > vq group of a virtqueue, what should it return in vduse_get_vq_group?
> > 0 for all vqs, even if the CVQ is in vq group 1?
>
> Since the topology is fixed I think userspace should provide this when
> creating a device.
>
> >
> > That's also valid for vduse_get_vq_map, which return is assumed not to
> > change in all the life of the device as it is not protected by a
> > mutex.
> >
> > > And the vq to group mappings could be piggy backed by the device
> > > creation request.
> > >
> >
> > I'm not sure, I think it involves a vduse request per asid or vq group
> > operation. Even get_vq_map. But I'm open to explore this possibility
> > for sure.
>
> Something like this?
>
> struct vduse_vq_config {
>         __u32 index;
>         __u16 max_size;
>         __u16 reserved[13];
> };

I meant this actually:

struct vduse_vq_config {
         __u32 index;
         __u16 max_size;
         __u16 group;
         __u16 reserved[12];
 };

Thanks

>
> ?
>
> Thanks
>
> >
> > > >
> > > > We could add a boolean on each virtqueue to track if we know its
> > > > virtqueue group and then only ask VDUSE device it if needed, would
> > > > that work?
> > >
> > > Thanks
> > >
> > > >
> > >
> >


