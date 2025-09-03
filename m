Return-Path: <linux-kernel+bounces-797772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC3B41532
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CACA5613F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D322D77F6;
	Wed,  3 Sep 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1mCi6Rt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352BB2D3A91
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880962; cv=none; b=FmjqbW9U3IiM8HSdvD9nCg5ehIvGNVFi9Vo9eLqQ+OD0mn7HZ3onldIfFFHydQjfp3DMhytzA3KGlUJQoGM+bgi2m6nSch2UFLMdxz/ZAREZcAPbXlEKyiBhz/wbQbMstZyKWDqlW2i1jicq8EiYFy80ZQqu72Ruawu+VGbKhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880962; c=relaxed/simple;
	bh=pGbpg0BmJRUvc6KvG1Ilb26CiHzHZOFqNiXsUxuHNeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USpFeMFokCpaCws9cOX8eIUB2G/HvuLjvSY4VOtAyupP7JHiJlpVHvzvwNvIaXOFY6MeS1URHQSvCtN4GqmRJOuhxoM4KxYvXUAnplN39PaQiPfVa530+FYxQiWnKUKRcRP7DRgZDQyoJroqxJ/6j31jWLV3gQbeGt/CM8MLE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1mCi6Rt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756880958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wk5onf0Lc6eDN5svJ057sVPvmD+2qqP9+k7WVILdVY=;
	b=C1mCi6RtTCsFux9ZJuqLGJnTSbtftctuTGn/6pt0PY/flK8E3zwSJ40cvdJeZM7rbO2VX+
	S70LPk5J8MLGVk0TE0tC93cN8uYpzP31Ei+tlMffu5otjZuH3PBgVSsCLQ0Gc2hwCBSkBo
	llPut8nUumUWrS4YzCj6GNQfLzMuY00=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-4dnWliSkPJaKJdtmB81-jw-1; Wed, 03 Sep 2025 02:29:16 -0400
X-MC-Unique: 4dnWliSkPJaKJdtmB81-jw-1
X-Mimecast-MFC-AGG-ID: 4dnWliSkPJaKJdtmB81-jw_1756880956
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77250c660d3so3132299b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756880955; x=1757485755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wk5onf0Lc6eDN5svJ057sVPvmD+2qqP9+k7WVILdVY=;
        b=vGVBJVyyCEF6xMogV/2px+b9HcScUcX+HD120VYQDPSGD8jGmRXaVc6B8GECBk6P6t
         8ti9QSRkQRrHW8Jk2jrFANzMIpVIDMUghA3vL9OZY3NTIkSKOwu+zp/5tlLDJbKPkn7m
         SVMMybu9kVNopMw/N3fclx7d5ERyd+9nmWxNxK0hvEM1vkScxpWlP/sUDLYmaAeZ0Rs2
         J+mfC08LVESgCdTKrGFPGgzkkZB2Yb++pGP1SIpzKo6UFuYQi2DU3WRE0VQ/cLDt2Bjz
         i8W5D67zwhSxXEogFn/bla7CaojzHnEL8cvVQshMUh4GdNs+i/00lco+hXF5qwEkd/aS
         +Meg==
X-Forwarded-Encrypted: i=1; AJvYcCUnHWPiDoc3iUc83OMNy1ck+UL6yrDYFrhihB7WsMr+5fMWjRpjSiAs5gfHdC4Yljl4GyThqyy/nJBUzr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEI/GMIjnK7s1dRP4rbwyu9FtKrzYkU6BSTaET6dyYBhhxuaj
	5rcRMxFvEalcoXn/xbf6+Zv5CqzxU82iq0UmlJZbT9ez2GK6jOFbHlmwqlKwjIaZGb2XzpSSoS/
	Uiq4q6QXVsf3Gb0wZ+juNbhTKz5THxpFGxVl+g71S03z5DjG49h3HmBfruUev0jlcqdDXL9WktT
	XbARhEX3sYGNCNb9J/IcI2WJ5C+Wxp22CrJnnwi0PN
X-Gm-Gg: ASbGncunRR8ASN/4/rBcNIKnaK6ifFCa1OkteLpKN0Ah6ZcIUkjNDje1p+Mh+EbzFBA
	sxCik8dpNP8UA3oE9kpGhJQ15K3Gh5sizj14tcHuFFNyzSGTQjD+myYIrww0iO2r+U+rI3M8L9x
	82mUtskT5d47orvG1vi9o=
X-Received: by 2002:a05:6a20:6d86:b0:245:fb85:ef58 with SMTP id adf61e73a8af0-245fb85f249mr5550444637.40.1756880955575;
        Tue, 02 Sep 2025 23:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFefGuHLsv/EWzPpQf8BSjk6/+l2dG9MzdaGkYP/Y+xWaIQ7lJ4mDu7Y+42nT8uVrPK7luUivN3EMQ6Le5veUI=
X-Received: by 2002:a05:6a20:6d86:b0:245:fb85:ef58 with SMTP id
 adf61e73a8af0-245fb85f249mr5550419637.40.1756880955151; Tue, 02 Sep 2025
 23:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
 <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com> <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com>
In-Reply-To: <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Sep 2025 08:28:38 +0200
X-Gm-Features: Ac12FXxnnZiJmIiOC2xmB9jwOMlwBOIg9tY4JYpVGfceMoCdCMGFuruFuGdWpGk
Message-ID: <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
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
> > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Max=
ime)
> > > >
> > > > RFC v3:
> > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a l=
ower
> > > >   value to reduce memory consumption, but vqs are already limited t=
o
> > > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > > * Remove the descs vq group capability as it will not be used and w=
e can
> > > >   add it on top.
> > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > * Move the valid vq groups range check to vduse_validate_config.
> > > >
> > > > RFC v2:
> > > > * Cache group information in kernel, as we need to provide the vq m=
ap
> > > >   tokens properly.
> > > > * Add descs vq group to optimize SVQ forwarding and support indirec=
t
> > > >   descriptors out of the box.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++=
++--
> > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > >         struct vdpa_vq_state state;
> > > >         bool ready;
> > > >         bool kicked;
> > > > +       u32 vq_group;
> > > >         spinlock_t kick_lock;
> > > >         spinlock_t irq_lock;
> > > >         struct eventfd_ctx *kickfd;
> > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > >         u8 status;
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > > +       u32 ngroups;
> > > >         struct vduse_umem *umem;
> > > >         struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa=
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
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_de=
vice *vdpa)
> > > >         return dev->status;
> > > >  }
> > > >
> > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > +{
> > > > +       /* All vqs and descs must be in vq group 0 if ngroups < 2 *=
/
> > > > +       if (dev->ngroups < 2)
> > > > +               return 0;
> > > > +
> > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > +               int ret;
> > > > +
> > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > +               msg.req.vq_group.index =3D i;
> > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +
> > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 sta=
tus)
> > > >  {
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_=
device *vdpa, u8 status)
> > > >         if (vduse_dev_set_status(dev, status))
> > > >                 return;
> > > >
> > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) =
&&
> > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > +               if (vduse_fill_vq_groups(dev))
> > > > +                       return;
> > >
> > > I may lose some context but I think we've agreed that we need to
> > > extend the status response for this instead of having multiple
> > > indepdent response.
> > >
> >
> > My understanding was it is ok to start with this version by [1]. We
> > can even make it asynchronous on top if we find this is a bottleneck
> > and the VDUSE device would need no change, would that work?
>
> I think I need to understand why we can not defer this to get_group_asid(=
) call.
>

Because we need to know the vq_groups->asid mapping in other calls
like set_group_asid or get_vq_group.

We could add a boolean on each virtqueue to track if we know its
virtqueue group and then only ask VDUSE device it if needed, would
that work?


