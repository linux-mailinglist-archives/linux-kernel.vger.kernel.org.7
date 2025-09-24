Return-Path: <linux-kernel+bounces-829809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC32B97F41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99BC1AE1C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288611E5206;
	Wed, 24 Sep 2025 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrwlGU/5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B54317D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675318; cv=none; b=Z9/ILrvw8eWCtXocJzsgh2BCwUW7A3ZRCZMYChX3zs6JUh4NQqrLlGl+QaVekVIk3Yybo+x5CBziiSuUQCdL64qG7B1mYIHWVshYA7Y9IDuQPPLC+Ed/nXiBFP890FbTAsVqGnqNk8/K9HUj0TAPXfqzpTO3Y8vBkCsYRe5IFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675318; c=relaxed/simple;
	bh=fLwucE4C3jVvvnaf9DEuLpLlebbdl59JQaRgGOSq3gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuleE5zB/UL3SIXh4G0hiuiI/lgjqtdRrQwMe8/nUHF1SI77zaWn466aEuXe0fyZKtnksyMT5WS0PjIVqBg3pN+rQmTco5dxNBU47ltQUQPueto0DakeTKlDvGKy1jG5ealYXyFo2FhDByg9xL6sQvWXNIGKTQKtqfsnYkwes2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrwlGU/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fu275R4CThqge/dvwC6hWm38gMCLIFreU7xhe8KM9u0=;
	b=HrwlGU/5Sv13CQxCfQr+5e9ZNnfyDhLrlazdLlCT+kog7+b6jEfkifGL3snK9Fjs1H6scc
	YBkaS5QbEQBcwVmEzv+2vhQ7vMBFMaeFuu0tsGiLfGouXRyj17tbW8YxJqwovD6BTEGLAW
	WN3vnSmZyPYAxpc46IBTDH/TaTpgjHc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-n4QqItLTPrSG8T9DKerIOA-1; Tue, 23 Sep 2025 20:55:13 -0400
X-MC-Unique: n4QqItLTPrSG8T9DKerIOA-1
X-Mimecast-MFC-AGG-ID: n4QqItLTPrSG8T9DKerIOA_1758675312
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-267fa90a2fbso3661115ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675312; x=1759280112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu275R4CThqge/dvwC6hWm38gMCLIFreU7xhe8KM9u0=;
        b=HAwdE1uByYNprJH83iz3acd6LsbK2pCS4khx64nLgp/f63HuPg0v/knaA6oHD4Jjc2
         e/zaUwgotoA1DG/hRzUq7sgZnLWey2pgq4GPAxB5nTLyO01KjM9dI+7LYxpj2bdrvc4S
         FPDJ/bOj7ErSwLEoSH72Yuc6ttfvwruDxhSxTNid98vjnH97Xl/0jQzxKH9MWUPwjS+C
         LKjxhl3YRnoJ+5j1dHq1Kxi6gsOumX5q7ecnBA5ohcPvWp2uEJ4Z+9iABcLgcgd4qbPH
         iNS7rKyoVL1Apm71dvgClaHGx6F1qlfZvG/lTKyEcNJ9SJ1gUI0zGq6G8ULaDbnhgNxt
         87eg==
X-Forwarded-Encrypted: i=1; AJvYcCVC9ql0r70b9QSE6nj7YbCfR+AP7J6VvZ9GGCLlrV2c9rUyTneNcUFswnNtVx2eq0yV83B1NfP8uCo2cfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjkRITV6OmtQidx4TojkI03FIKlH906DJj13CKcHm4LXSCT1au
	Zxwv82Jqjbz3wqItELAAq2dN8XEBiLVei1+IlaucsvCqC0OTvcsWs4sGX1JhUtEpyupJfm8IUfS
	893ax3DV56obNHKfFRSlwx0OOf1C75PnNgVYKqIrDy2QyvfyIAYje31prKPwmf2ZS0jxwUKCkdZ
	Xn5eMgVzAezY2XZawUF5VVVAeMAcB4XyZgf9D+kO7f
X-Gm-Gg: ASbGnctFZPoRCNy8kF3Zz/gJDSdxb28c7opfV90xarqZ7kWR0C5lxTrhv3CkHq5Oc79
	GSyfhm4OXuQCM0ZgqXzvJG6B+nGYq6uaoq6TT4nhvTxbHq83kPXb6Kr7Wc8n50+UIbZbE4kmo/2
	UTywFagU2db7AdHUo84Q==
X-Received: by 2002:a17:903:2f4b:b0:272:a847:cabb with SMTP id d9443c01a7336-27ec13bc772mr6092975ad.28.1758675311956;
        Tue, 23 Sep 2025 17:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERzcaZPhnTfoODwKbUkGY9/kB4S/XFAUQDfLj44ZCx0AK/fJWvXytQOfAT6xHwoVI8zgQnhVUPDIK0+Cf31xc=
X-Received: by 2002:a17:903:2f4b:b0:272:a847:cabb with SMTP id
 d9443c01a7336-27ec13bc772mr6092785ad.28.1758675311457; Tue, 23 Sep 2025
 17:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919093359.961296-1-eperezma@redhat.com> <20250919093359.961296-6-eperezma@redhat.com>
 <CACGkMEuodLC2M=ePytKWa=FQeTZs+uFzofN-EYOdx3u=HuwkGg@mail.gmail.com> <CAJaqyWeTmRp5JkQ11fmjfzoAeOJWJfpA4OM6jVU8pCNia1Y7Qg@mail.gmail.com>
In-Reply-To: <CAJaqyWeTmRp5JkQ11fmjfzoAeOJWJfpA4OM6jVU8pCNia1Y7Qg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:55:00 +0800
X-Gm-Features: AS18NWCBYckOizZdpOT2PlnXq6RXtn5rjck2eLiKR8IW78TiAZsIdezqJm-THHs
Message-ID: <CACGkMEvWBrtBtT2bnPcdOMFy0mOROvd-c9vqkJVDSHnbhmyzYw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:26=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Sep 22, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Sep 19, 2025 at 5:34=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v3:
> > > * Get the vduse domain through the vduse_as in the map functions
> > >   (Jason).
> > > * Squash with the patch creating the vduse_as struct (Jason).
> > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> > >   (Jason)
> > >
> > > v2:
> > > * Convert the use of mutex to rwlock.
> > >
> > > RFC v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a low=
er
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > >   VDUSE_IOTLB_GET_INFO.
> > > * Use of array_index_nospec in VDUSE device ioctls.
> > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > * Move the umem mutex to asid struct so there is no contention betwee=
n
> > >   ASIDs.
> > >
> > > RFC v2:
> > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> > >   part of the struct is the same.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 327 ++++++++++++++++++++-------=
--
> > >  include/uapi/linux/vduse.h         |  51 ++++-
> > >  2 files changed, 281 insertions(+), 97 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 6fdabc3c910e..c6c70cfd4887 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -42,6 +42,7 @@
> > >
> > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > +#define VDUSE_DEV_MAX_AS 0xffff
> > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > @@ -89,7 +90,14 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> > > +};
> > > +
> > >  struct vduse_vq_group {
> > > +       struct vduse_as *as;
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -97,7 +105,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -125,9 +133,8 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > > +       u32 nas;
> > >         struct vduse_vq_group *groups;
> > > -       struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         rwlock_t domain_lock;
> > >  };
> > > @@ -324,7 +331,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -333,8 +340,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
ev *dev,
> > >                 return -EINVAL;
> > >
> > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > -       msg.req.iova.start =3D start;
> > > -       msg.req.iova.last =3D last;
> > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > +               msg.req.iova.start =3D start;
> > > +               msg.req.iova.last =3D last;
> > > +       } else {
> > > +               msg.req.iova_v2.start =3D start;
> > > +               msg.req.iova_v2.last =3D last;
> > > +               msg.req.iova_v2.asid =3D asid;
> > > +       }
> > >
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > > @@ -446,14 +459,29 @@ static __poll_t vduse_dev_poll(struct file *fil=
e, poll_table *wait)
> > >         return mask;
> > >  }
> > >
> > > +/* Force set the asid to a vq group without a message to the VDUSE d=
evice */
> > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > +                                      unsigned int group, unsigned i=
nt asid)
> > > +{
> > > +       write_lock(&dev->domain_lock);
> > > +       dev->groups[group].as =3D &dev->as[asid];
> > > +       write_unlock(&dev->domain_lock);
> > > +}
> > > +
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > >
> > >         /* The coherent mappings are handled in vduse_dev_free_cohere=
nt() */
> > > -       if (domain && domain->bounce_map)
> > > -               vduse_domain_reset_bounce_map(domain);
> > > +       for (i =3D 0; i < dev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D dev->as[i].domai=
n;
> > > +
> > > +               if (domain && domain->bounce_map)
> > > +                       vduse_domain_reset_bounce_map(domain);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -639,6 +667,29 @@ static union virtio_map vduse_get_vq_map(struct =
vdpa_device *vdpa, u16 idx)
> > >         return ret;
> > >  }
> > >
> > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned i=
nt group,
> > > +                               unsigned int asid)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > +               return -EINVAL;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > +       msg.req.vq_group_asid.group =3D group;
> > > +       msg.req.vq_group_asid.asid =3D asid;
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > +       if (r < 0)
> > > +               return r;
> > > +
> > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > +       return 0;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -810,13 +861,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -859,6 +910,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -874,9 +926,10 @@ static void vduse_dev_sync_single_for_device(uni=
on virtio_map token,
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       read_lock(&vdev->domain_lock);
> >
> > This introduce atomic operation in the datapath, I wonder if we can
> > switch to use RCU instead.
> >
>
> I think it is a path that is worth exploring. The reason I chose
> rwlock (and just plain mutex before) is that
> vduse_domain_sync_single_for_device and
> vduse_domain_sync_single_for_cpu already take a read lock, so it seems
> the overhead was ok.
>
> Can we do it on top of this series? I think both using RCU can improve
> the performance for sure, but just taking out one of them would not
> buy us a lot.

That's fine.

Thanks


