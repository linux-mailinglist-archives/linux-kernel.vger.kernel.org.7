Return-Path: <linux-kernel+bounces-758969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94422B1D667
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A507A7786
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F126FD91;
	Thu,  7 Aug 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm5lNKHg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B19231A55
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565096; cv=none; b=M3hip2sUNvXRp/XtD8Y/+Ua0knaPP82WwZsgoZ7pTvbMXCEhUHhkd95N5K2Fk1pM3ZAnBexru9EwT1owukV2T49HfobFsXKJ1FWZ19Gng7FPpyCj3OLEBkNCHZgw6AeJbfdh7M+FNnBoLdPxzPT418zpNrDkUesWrPi5Y79UhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565096; c=relaxed/simple;
	bh=uPsaQFLFvZN7GK35alRIYGbJAdP0hFcEmO5/1Bp42KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYaH0l3z2gxRiKa2628+xjSuxi5sDUb7weH5E/PLQ9169Lm7MulcmVH7//5JGwNyYspHnge7OMgYx1OeGsFBL1kA0V30HJhEX0TjE+B7RETUQktP3J6ZhxF0jtAiWtbsTnEdKniZp3/Gxa/927vRWKcgWmkOFE5Z2HzyuiBWzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pm5lNKHg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754565092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cS6DQRUrd2VCjqzZCU6Dfw7kNMmYO7D+2IKdnf+op/Y=;
	b=Pm5lNKHg6LRRFlyXfqWQgckwkvP9eY0/s8BSd3ALjMlMMt0VhjyfXEFA2FP7TQ5hi0WRCQ
	AymPdGnyQ240iEb2mMTAcPCt+8n3w5bh+/jwTTYZBI4x8Z4867pAZ6w0WUVHL46eppCMkA
	dBGbG/gGCZzOkyWW5dYQ20GnOd+fFIs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-iwkOxGU6PgqVaD-6f3KOgg-1; Thu, 07 Aug 2025 07:11:30 -0400
X-MC-Unique: iwkOxGU6PgqVaD-6f3KOgg-1
X-Mimecast-MFC-AGG-ID: iwkOxGU6PgqVaD-6f3KOgg_1754565090
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f3b65ce07so1668941a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565090; x=1755169890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS6DQRUrd2VCjqzZCU6Dfw7kNMmYO7D+2IKdnf+op/Y=;
        b=EJu36wZQRXU8PMXr8tZcCLM5JLe+3Aw+YhncOKVOYtGkvPaPH8xaK6oBjHtlWARCg1
         QklyORlLOgYlgxPwkDJxqFjn1BANFfxyh9tNoj/gq5M+DrCxOfZYc0rTCwfeu+zijbaA
         rYTBmCZfz153DhGH51PHPf7A2vKTYjKjKoQ8sc4olwop/XsSv4JaivGMJvcg2wW8v4ab
         m5YF0gIhhzWxdRFGOllYJfVjhxCb/xuVJbB1COXiO5inM/OvjLmgvlF4orM7Z/auBWOd
         ReexujrTQK64ZGpv6BkxHJJhIVUhnDyveZRZms71YC1I/elxTYG7vHdvCGcHs7hRFKXC
         67zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOe9sgyJ/TOwAE+ke44Raf/W34uoROgQY6oRJB6QL4bRRR+un+0OOM98iMhT3+ZOTJ/IeYsJYPNM5/V64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8mrZ73s4PTbOvzLrL6jeqLen9TWBJPWl6+4temkAhsrrIYrC
	bOqmpm4qfP1+ylZc5VvHDgdrHyFzVNM17mbbGBD491JrCGCXv15e4UY7hSk1kDibtbf8J3ZU8jQ
	Yv2OmxV92HfAly+1u+xZi9ziKE9ATHx4OhqDdsTS2fDB1GnyVfQ8HRAFIyEKNeDbWXJqWQuXtBC
	G2vyMckZ+IoGb8/3d/QJZKHaDV/ndnEA+m1k5JNRwZ
X-Gm-Gg: ASbGncv5gLO08FIDfGVbSoWKDSoLYJFCwwpiK+Q5jCHjCrvn8aCIYiVDRzb2cDkoGgJ
	/ijoJf2hJf4W0CE6H6oQXyVCbPOQUcALFtfJu96sFkqxW7aQdX1vmp1sxCwEZShxZe7GQeykab/
	Vpxdlh5v7lQLY0Fjbnhbxt
X-Received: by 2002:a17:90b:3891:b0:311:da03:3437 with SMTP id 98e67ed59e1d1-32166ccc588mr8290830a91.27.1754565088949;
        Thu, 07 Aug 2025 04:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGok6mrEnuB2zFtDnjStJlbXJH5XdnvHnuK+6D9hZbo/P30q1FeVkYp7jQWTXxI3L3F+rcUcUzFGj3qYEOGGxc=
X-Received: by 2002:a17:90b:3891:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-32166ccc588mr8290734a91.27.1754565088128; Thu, 07 Aug 2025
 04:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-4-eperezma@redhat.com>
 <CACGkMEvNMc_Ja09=OknFH0obUtW8nGz5aiee9tZVhn+N58w70w@mail.gmail.com>
 <CAJaqyWcjA_9e+4K=KG5uwRuY-5xLkUf9=4P0zjdQ3z8gd4cxNQ@mail.gmail.com> <CACGkMEvT_1ngR9Cs1A6ghNhZtyXiAb7qZq-Xj=7NWOzO9o5C=w@mail.gmail.com>
In-Reply-To: <CACGkMEvT_1ngR9Cs1A6ghNhZtyXiAb7qZq-Xj=7NWOzO9o5C=w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Aug 2025 13:10:51 +0200
X-Gm-Features: Ac12FXzNwHhva3aNRmIOZAxQh65z2gYj_29Uk9JvZDVnH7aHqDcKzJx2vdh75D0
Message-ID: <CAJaqyWf95h_amybhC3eR_LFPweAt_zoO6_rc=Mw=kP9OmujA2g@mail.gmail.com>
Subject: Re: [RFC 3/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 3:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jun 12, 2025 at 3:25=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Jun 12, 2025 at 2:30=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > > >
> > > > Make one IOTLB domain per address space, and allow the driver to as=
sign
> > > > each ASID to a vq group.  Each address space via an dedicated ident=
ifier
> > > > (ASID).
> > > >
> > > > During vDPA device allocation, the VDUSE device needs to report the
> > > > number of address spaces supported.  Then the vdpa driver is able t=
o
> > > > configure them.  At this moment only vhost_vdpa is able to do it.
> > > >
> > > > This helps to isolate the environments for the virtqueue that will =
not
> > > > be assigned directly.  E.g in the case of virtio-net, the control
> > > > virtqueue will not be assigned directly to guest.
> > > >
> > > > TODO: Ideally, umem should not be duplicated.  But it is hard or
> > > > impossible to refactor everything around one single umem.  So shoul=
d we
> > > > continue with device specifying umem per vq group?
> > >
> > > This is a good question.
> > >
> > > I think umem should be bound to address space and umem needs to be is=
olated.
> > >
> > > For the issue of complexity, we can simply extend the vduse_iova_umem
> > > to have an asid field. But it looks like it needs more work as:
> > >
> > > struct vduse_iova_umem {
> > >         __u64 uaddr;
> > >         __u64 iova;
> > >         __u64 size;
> > >         __u64 reserved[3];
> > > };
> > >
> > > Do we have a way to know if reserved is used or not (as we are lackin=
g
> > > a flag field anyhow ....).
> > >
> >
> > I'd say that we should work the same way as the rest of the structs:
> > We add the asid field, and if the API v1 is negotiated we handle it as
> > ASID. If it is not negotiated, it is reserved.
>
> Ok, that makes sense.
>
> >
> > > So we probably need a new uAPI like vduse_iova_umem_v2 that includes =
a
> > > flag field at least.
> > >
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 250 +++++++++++++++++++++----=
----
> > > >  include/uapi/linux/vduse.h         |  38 ++++-
> > > >  2 files changed, 216 insertions(+), 72 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 6fa687bc4912..d51e4f26fe72 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -51,6 +51,11 @@
> > > >   */
> > > >  #define VDUSE_MAX_VQ_GROUPS 2
> > > >
> > > > +/*
> > > > + * Let's make it 2 for simplicity.
> > > > + */
> > > > +#define VDUSE_MAX_ASID 2
> > >
> > > Similar to previous patch, it's better to increase this otherwise we
> > > need new uAPI or it requires the userspace to probe the maximum value
> > > once we decide to change it in the future.
> > >
> >
> > I'm ok with this, but what is a good max value? UINT32_MAX seems excess=
ive?
>
> Maybe 64 or 256.
>
> >
> > This requires us to allocate arrays for both vduse_dev->domain and
> > vduse_dev->umem, so we need to set a reasonable value.
>
> Could we do the allocation based on the userspace privionsing?
>

Oh yes, my point is that we need to set a hard maximum so userland
cannot allocate an array of uint32_t[UINT32_MAX], for example. I guess
64 is reasonable. Is it worth it to dynamically allocate a whole array
with this maximum or is it better to make it just part of the struct?
I'm happy with both solutions :).

> >
> > > > +
> > > >  #define IRQ_UNBOUND -1
> > > >
> > > >  struct vduse_virtqueue {
> > > > @@ -92,7 +97,7 @@ struct vduse_dev {
> > > >         struct vduse_vdpa *vdev;
> > > >         struct device *dev;
> > > >         struct vduse_virtqueue **vqs;
> > > > -       struct vduse_iova_domain *domain;
> > > > +       struct vduse_iova_domain *domain[VDUSE_MAX_ASID];
> > > >         char *name;
> > > >         struct mutex lock;
> > > >         spinlock_t msg_lock;
> > > > @@ -120,7 +125,8 @@ struct vduse_dev {
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > >         u32 ngroups;
> > > > -       struct vduse_umem *umem;
> > > > +       u32 nas;
> > > > +       struct vduse_umem *umem[VDUSE_MAX_ASID];
> > > >         struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > >         struct mutex domain_lock;
> > > > @@ -436,11 +442,14 @@ static __poll_t vduse_dev_poll(struct file *f=
ile, poll_table *wait)
> > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > >  {
> > > >         int i;
> > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > >
> > > >         /* The coherent mappings are handled in vduse_dev_free_cohe=
rent() */
> > > > -       if (domain && domain->bounce_map)
> > > > -               vduse_domain_reset_bounce_map(domain);
> > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D dev->domain[i]=
;
> > > > +
> > > > +               if (domain && domain->bounce_map)
> > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > +       }
> > > >
> > > >         down_write(&dev->rwsem);
> > > >
> > > > @@ -617,6 +626,23 @@ static u32 vduse_get_vq_group(struct vdpa_devi=
ce *vdpa, u16 idx)
> > > >         return msg.resp.vq_group.num;
> > > >  }
> > > >
> > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned=
 int group,
> > > > +                               unsigned int asid)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > +               return -EINVAL;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > +       msg.req.vq_group_asid.group =3D group;
> > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > +
> > > > +       return vduse_dev_msg_sync(dev, &msg);
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -788,13 +814,13 @@ static int vduse_vdpa_set_map(struct vdpa_dev=
ice *vdpa,
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         int ret;
> > > >
> > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > +       ret =3D vduse_domain_set_map(dev->domain[asid], iotlb);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > >         ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > >         if (ret) {
> > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > +               vduse_domain_clear_map(dev->domain[asid], iotlb);
> > > >                 return ret;
> > > >         }
> > > >
> > > > @@ -837,6 +863,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > >         .reset                  =3D vduse_vdpa_reset,
> > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > >
> > > > @@ -845,9 +872,12 @@ static void vduse_dev_sync_single_for_device(s=
truct device *dev,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > >
> > > > -       vduse_domain_sync_single_for_device(domain, dma_addr, size,=
 dir);
> > > > +       for (int i =3D 0; i < vdev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D vdev->domain[i=
];
> > >
> > > Interesting, I thought there could be a way to deduce the iova domain
> > > from the dma device since virtio supports per virtqueue dma device
> > > now. For example, I don't see get_vq_dma_dev() implemented in this
> > > patch.
> >
> > vhost_vdpa does not interact with it so it was not needed for the RFC.
> > For example, the simulator does not implement it either and it works
> > with ASID.
>
> Right, the reason for it is:
>
> 1) in vdpasim_create() we assign vdpa device as the device device:
>
> vdpasim->vdpa.dma_dev =3D dev;
>
> 2) since the vDPA device itself can't do DMA, it tricks the DMA ops to us=
e a PA
> 3) we do 1:1 mapping in vringh IOTLB by default to make the PA trick work=
:
>
>                vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
>                                       VHOST_MAP_RW);
>
> 4) This trick works the case oneday virtio_vdpa may use
> set_group_asid() as well, as all the AS are using PA
>
> Note that it's 2) that is blamed by the DMA maintainer.
>
> It looks different from VDUSE here:
>
> 1) VDUSE has its own dma_ops, each as is backed by different IOVA
> domain as well as IOVA address
> 2) vduse_domain_sync_single_for_device() will trigger unnecessary
> IOTLB synchronizations
>
> >
> > > But anyhow maybe we need to revisit this point as DMA
> > > mainatiner ask to fix the abuse of the dma device so we don't need a
> > > trick for dma dev anymore if we design the new mapping API in virtio
> > > core correctly.
> > >
> > > > +
> > > > +               vduse_domain_sync_single_for_device(domain, dma_add=
r, size, dir);
> > > > +       }
> > > >  }
> > > >
> > > >  static void vduse_dev_sync_single_for_cpu(struct device *dev,
> > > > @@ -855,9 +885,12 @@ static void vduse_dev_sync_single_for_cpu(stru=
ct device *dev,
> > > >                                              enum dma_data_directio=
n dir)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > >
> > > > -       vduse_domain_sync_single_for_cpu(domain, dma_addr, size, di=
r);
> > > > +       for (int i =3D 0; i < vdev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D vdev->domain[i=
];
> > > > +
> > > > +               vduse_domain_sync_single_for_cpu(domain, dma_addr, =
size, dir);
> > > > +       }
> > > >  }
> > > >
> > > >  static dma_addr_t vduse_dev_map_page(struct device *dev, struct pa=
ge *page,
> > > > @@ -866,7 +899,7 @@ static dma_addr_t vduse_dev_map_page(struct dev=
ice *dev, struct page *page,
> > > >                                      unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > >
> > > Any reason that we need to assume asid 0 in this case?
> > >
> >
> > At this moment, virtio_vdpa is the only one using these functions and
> > it is not able to change ASID. So this must be 0 for the moment. But
> > yes, this should be better addressed by knowing what vq group is this
> > referring to.
>
> My plan is to
>
> 1) introduce map_ops() in the virtio_device()
> 2) in PCI, it will be converted to DMA ops
> 3) for vDPA, it will be converted to vDPA specific ops
> 4) get_vq_dma_dev() will be converted to get_vq_map_token(), so each
> vq could provide it's own token
> 5) when the virtio core tries to do mapping, it will pass per vq dma
> token as parameters
> 6) so vduse here can receive a per virtqueue token where it can map it
> to group then ASID
>
> >
> > > >
> > > >         return vduse_domain_map_page(domain, page, offset, size, di=
r, attrs);
> > > >  }
> > > > @@ -876,7 +909,7 @@ static void vduse_dev_unmap_page(struct device =
*dev, dma_addr_t dma_addr,
> > > >                                 unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > > >
> > > >         return vduse_domain_unmap_page(domain, dma_addr, size, dir,=
 attrs);
> > > >  }
> > > > @@ -886,7 +919,7 @@ static void *vduse_dev_alloc_coherent(struct de=
vice *dev, size_t size,
> > > >                                         unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > > >         unsigned long iova;
> > > >         void *addr;
> > > >
> > > > @@ -906,17 +939,25 @@ static void vduse_dev_free_coherent(struct de=
vice *dev, size_t size,
> > > >                                         unsigned long attrs)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > > +       struct vduse_iova_domain *domain =3D vdev->domain[0];
> > > >
> > > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, a=
ttrs);
> > > >  }
> > > >
> > > > +/* TODO check if this is correct */
> > > >  static size_t vduse_dev_max_mapping_size(struct device *dev)
> > > >  {
> > > >         struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > > +       size_t max_mapping_size =3D 0;
> > > > +
> > > > +       for (int i =3D 0; i < vdev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D vdev->domain[i=
];
> > > >
> > > > -       return domain->bounce_size;
> > > > +               if (domain->bounce_size > max_mapping_size)
> > > > +                       max_mapping_size =3D domain->bounce_size;
> > > > +       }
> > > > +
> > > > +       return max_mapping_size;
> > > >  }
> > > >
> > > >  static const struct dma_map_ops vduse_dev_dma_ops =3D {
> > > > @@ -1054,31 +1095,32 @@ static int vduse_dev_queue_irq_work(struct =
vduse_dev *dev,
> > > >         return ret;
> > > >  }
> > > >
> > > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > > >                                 u64 iova, u64 size)
> > > >  {
> > > >         int ret;
> > > >
> > > >         mutex_lock(&dev->mem_lock);
> > > >         ret =3D -ENOENT;
> > > > -       if (!dev->umem)
> > > > +       if (!dev->umem[asid])
> > > >                 goto unlock;
> > > >
> > > >         ret =3D -EINVAL;
> > > > -       if (!dev->domain)
> > > > +       if (!dev->domain[asid])
> > > >                 goto unlock;
> > > >
> > > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bou=
nce_size)
> > > > +       if (dev->umem[asid]->iova !=3D iova ||
> > > > +           size !=3D dev->domain[asid]->bounce_size)
> > > >                 goto unlock;
> > > >
> > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > -                                   dev->umem->npages, true);
> > > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > > > -       mmdrop(dev->umem->mm);
> > > > -       vfree(dev->umem->pages);
> > > > -       kfree(dev->umem);
> > > > -       dev->umem =3D NULL;
> > > > +       vduse_domain_remove_user_bounce_pages(dev->domain[asid]);
> > > > +       unpin_user_pages_dirty_lock(dev->umem[asid]->pages,
> > > > +                                   dev->umem[asid]->npages, true);
> > > > +       atomic64_sub(dev->umem[asid]->npages, &dev->umem[asid]->mm-=
>pinned_vm);
> > > > +       mmdrop(dev->umem[asid]->mm);
> > > > +       vfree(dev->umem[asid]->pages);
> > > > +       kfree(dev->umem[asid]);
> > > > +       dev->umem[asid] =3D NULL;
> > > >         ret =3D 0;
> > > >  unlock:
> > > >         mutex_unlock(&dev->mem_lock);
> > > > @@ -1086,7 +1128,7 @@ static int vduse_dev_dereg_umem(struct vduse_=
dev *dev,
> > > >  }
> > > >
> > > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > > -                             u64 iova, u64 uaddr, u64 size)
> > > > +                             u32 asid, u64 iova, u64 uaddr, u64 si=
ze)
> > > >  {
> > > >         struct page **page_list =3D NULL;
> > > >         struct vduse_umem *umem =3D NULL;
> > > > @@ -1094,14 +1136,14 @@ static int vduse_dev_reg_umem(struct vduse_=
dev *dev,
> > > >         unsigned long npages, lock_limit;
> > > >         int ret;
> > > >
> > > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > > -           size !=3D dev->domain->bounce_size ||
> > > > +       if (!dev->domain[asid] || !dev->domain[asid]->bounce_map ||
> > > > +           size !=3D dev->domain[asid]->bounce_size ||
> > > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > > >                 return -EINVAL;
> > > >
> > > >         mutex_lock(&dev->mem_lock);
> > > >         ret =3D -EEXIST;
> > > > -       if (dev->umem)
> > > > +       if (dev->umem[asid])
> > > >                 goto unlock;
> > > >
> > > >         ret =3D -ENOMEM;
> > > > @@ -1125,7 +1167,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->domain[asid=
],
> > > >                                                  page_list, pinned)=
;
> > > >         if (ret)
> > > >                 goto out;
> > > > @@ -1138,7 +1180,7 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > > >         umem->mm =3D current->mm;
> > > >         mmgrab(current->mm);
> > > >
> > > > -       dev->umem =3D umem;
> > > > +       dev->umem[asid] =3D umem;
> > > >  out:
> > > >         if (ret && pinned > 0)
> > > >                 unpin_user_pages(page_list, pinned);
> > > > @@ -1181,26 +1223,42 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >
> > > >         switch (cmd) {
> > > >         case VDUSE_IOTLB_GET_FD: {
> > > > -               struct vduse_iotlb_entry entry;
> > > > +               struct vduse_iotlb_entry_v2 entry =3D {};
> > > > +               struct vduse_iotlb_entry entry_old;
> > > >                 struct vhost_iotlb_map *map;
> > > >                 struct vdpa_map_file *map_file;
> > > >                 struct file *f =3D NULL;
> > > >
> > > >                 ret =3D -EFAULT;
> > > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > > -                       break;
> > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > > +                       if (copy_from_user(&entry, argp, sizeof(ent=
ry)))
> > > > +                               break;
> > > > +               } else {
> > > > +                       if (copy_from_user(&entry_old, argp,
> > > > +                                          sizeof(entry_old)))
> > > > +                               break;
> > > > +
> > > > +                       entry.offset =3D entry_old.offset;
> > > > +                       entry.start =3D entry_old.start;
> > > > +                       entry.last =3D entry_old.last;
> > > > +                       entry.perm =3D entry_old.perm;
> > >
> > > I wonder if a new ioctl is needed.
> > >
> >
> > The problem is that vduse_iotlb_entry is already used in full, can we
> > extend the argument size without introducing the new ioctl?
>
> Yes, I think it should work if VDUSE_API_VERSION_1 makes sense.
>
> >
> > > > +               }
> > > >
> > > >                 ret =3D -EINVAL;
> > > >                 if (entry.start > entry.last)
> > > >                         break;
> > > >
> > > > +               if (entry.asid >=3D dev->nas)
> > > > +                       break;
> > > > +
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               if (!dev->domain) {
> > > > +               /* TODO accessing an array with idx from userspace,=
 mitigations? */
> > > > +               if (!dev->domain[entry.asid]) {
> > > >                         mutex_unlock(&dev->domain_lock);
> > > >                         break;
> > > >                 }
> > > > -               spin_lock(&dev->domain->iotlb_lock);
> > > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > > +               spin_lock(&dev->domain[entry.asid]->iotlb_lock);
> > > > +               map =3D vhost_iotlb_itree_first(dev->domain[entry.a=
sid]->iotlb,
> > > >                                               entry.start, entry.la=
st);
> > > >                 if (map) {
> > > >                         map_file =3D (struct vdpa_map_file *)map->o=
paque;
> > > > @@ -1210,7 +1268,7 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > > >                         entry.last =3D map->last;
> > > >                         entry.perm =3D map->perm;
> > > >                 }
> > > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > > +               spin_unlock(&dev->domain[entry.asid]->iotlb_lock);
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 ret =3D -EINVAL;
> > > >                 if (!f)
> > > > @@ -1360,12 +1418,18 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                         break;
> > > >
> > > >                 ret =3D -EINVAL;
> > > > +               /* TODO: Using asid from userspace, need to mitigat=
e? */
> > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > -                                sizeof(umem.reserved)))
> > > > +                                sizeof(umem.reserved)) ||
> > > > +                   !is_mem_zero((const char *)umem.reserved2,
> > > > +                                sizeof(umem.reserved2)) ||
> > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > +                    umem.asid !=3D 0) ||
> > > > +                    umem.asid >=3D dev->nas)
> > >
> > > This is probably a hint that we need a new uAPI, see my comment for c=
hangelog.
> > >
> > > >                         break;
> > > >
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > > +               ret =3D vduse_dev_reg_umem(dev, umem.asid, umem.iov=
a,
> > > >                                          umem.uaddr, umem.size);
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 break;
> > > > @@ -1378,15 +1442,23 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                         break;
> > > >
> > > >                 ret =3D -EINVAL;
> > > > +               /* TODO: Using asid from userspace, need to mitigat=
e? */
> > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > -                                sizeof(umem.reserved)))
> > > > +                                sizeof(umem.reserved)) ||
> > > > +                   !is_mem_zero((const char *)umem.reserved2,
> > > > +                                sizeof(umem.reserved2)) ||
> > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > +                    umem.asid !=3D 0) ||
> > > > +                    umem.asid >=3D dev->nas)
> > > >                         break;
> > > > +
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > > +               ret =3D vduse_dev_dereg_umem(dev, umem.asid, umem.i=
ova,
> > > >                                            umem.size);
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 break;
> > > >         }
> > > > +       /* TODO can we merge this with GET_FD? */
> > > >         case VDUSE_IOTLB_GET_INFO: {
> > > >                 struct vduse_iova_info info;
> > > >                 struct vhost_iotlb_map *map;
> > > > @@ -1399,27 +1471,32 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > >                 if (info.start > info.last)
> > > >                         break;
> > > >
> > > > +               if (info.asid >=3D dev->nas)
> > > > +                       break;
> > > > +
> > > >                 if (!is_mem_zero((const char *)info.reserved,
> > > >                                  sizeof(info.reserved)))
> > > >                         break;
> > > >
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               if (!dev->domain) {
> > > > +               /* TODO asid comes from userspace. mitigations? */
> > > > +               if (!dev->domain[info.asid]) {
> > > >                         mutex_unlock(&dev->domain_lock);
> > > >                         break;
> > > >                 }
> > > > -               spin_lock(&dev->domain->iotlb_lock);
> > > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > > +               spin_lock(&dev->domain[info.asid]->iotlb_lock);
> > > > +               map =3D vhost_iotlb_itree_first(dev->domain[info.as=
id]->iotlb,
> > > >                                               info.start, info.last=
);
> > > >                 if (map) {
> > > >                         info.start =3D map->start;
> > > >                         info.last =3D map->last;
> > > >                         info.capability =3D 0;
> > > > -                       if (dev->domain->bounce_map && map->start =
=3D=3D 0 &&
> > > > -                           map->last =3D=3D dev->domain->bounce_si=
ze - 1)
> > > > +                       if (dev->domain[info.asid]->bounce_map &&
> > > > +                           map->start =3D=3D 0 &&
> > > > +                           map->last =3D=3D dev->domain[info.asid]=
->bounce_size - 1)
> > > >                                 info.capability |=3D VDUSE_IOVA_CAP=
_UMEM;
> > > >                 }
> > > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > > +               spin_unlock(&dev->domain[info.asid]->iotlb_lock);
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 if (!map)
> > > >                         break;
> > > > @@ -1444,8 +1521,13 @@ static int vduse_dev_release(struct inode *i=
node, struct file *file)
> > > >         struct vduse_dev *dev =3D file->private_data;
> > > >
> > > >         mutex_lock(&dev->domain_lock);
> > > > -       if (dev->domain)
> > > > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_si=
ze);
> > > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > > +               if (dev->domain[i]) {
> > > > +                       vduse_dev_dereg_umem(dev, i, 0,
> > > > +                                            dev->domain[i]->bounce=
_size);
> > > > +                       dev->domain[i] =3D NULL;
> > > > +               }
> > > > +       }
> > > >         mutex_unlock(&dev->domain_lock);
> > > >         spin_lock(&dev->msg_lock);
> > > >         /* Make sure the inflight messages can processed after reco=
nncection */
> > > > @@ -1715,8 +1797,10 @@ static int vduse_destroy_dev(char *name)
> > > >         idr_remove(&vduse_idr, dev->minor);
> > > >         kvfree(dev->config);
> > > >         vduse_dev_deinit_vqs(dev);
> > > > -       if (dev->domain)
> > > > -               vduse_domain_destroy(dev->domain);
> > > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > > +               if (dev->domain[i])
> > > > +                       vduse_domain_destroy(dev->domain[i]);
> > > > +       }
> > > >         kfree(dev->name);
> > > >         vduse_dev_destroy(dev);
> > > >         module_put(THIS_MODULE);
> > > > @@ -1824,7 +1908,7 @@ static ssize_t bounce_size_store(struct devic=
e *device,
> > > >
> > > >         ret =3D -EPERM;
> > > >         mutex_lock(&dev->domain_lock);
> > > > -       if (dev->domain)
> > > > +       if (dev->domain[0] && dev->domain[1])
> > > >                 goto unlock;
> > > >
> > > >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > > > @@ -1882,9 +1966,18 @@ static int vduse_create_dev(struct vduse_dev=
_config *config,
> > > >                                 config->ngroups, VDUSE_MAX_VQ_GROUP=
S);
> > > >                         goto err_ngroups;
> > > >                 }
> > > > +
> > > > +               if (config->nas > VDUSE_MAX_ASID) {
> > > > +                       pr_err("Not creating a VDUSE device with %u=
 asid. Max: %u",
> > > > +                               config->nas, VDUSE_MAX_ASID);
> > > > +                       goto err_nas;
> > > > +               }
> > > > +
> > > >                 dev->ngroups =3D config->ngroups ?: 1;
> > > > +               dev->nas =3D config->nas ?: 1;
> > > >         } else {
> > > >                 dev->ngroups =3D 1;
> > > > +               dev->nas =3D 1;
> > > >         }
> > > >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> > > >         if (!dev->name)
> > > > @@ -1923,6 +2016,7 @@ static int vduse_create_dev(struct vduse_dev_=
config *config,
> > > >         kfree(dev->name);
> > > >  err_ngroups:
> > > >  err_str:
> > > > +err_nas:
> > > >         vduse_dev_destroy(dev);
> > > >  err:
> > > >         return ret;
> > > > @@ -2015,7 +2109,6 @@ static int vduse_open(struct inode *inode, st=
ruct file *file)
> > > >         if (!control)
> > > >                 return -ENOMEM;
> > > >
> > > > -       control->api_version =3D VDUSE_API_VERSION;
> > > >         file->private_data =3D control;
> > > >
> > > >         return 0;
> > > > @@ -2040,17 +2133,15 @@ static struct vduse_mgmt_dev *vduse_mgmt;
> > > >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *=
name)
> > > >  {
> > > >         struct vduse_vdpa *vdev;
> > > > -       __u32 ngroups =3D 1;
> > > > +       __u32 ngroups =3D dev->ngroups;
> > > >         int ret;
> > > >
> > > >         if (dev->vdev)
> > > >                 return -EEXIST;
> > > >
> > > > -       if (vdev->dev->api_version >=3D VDUSE_API_VERSION_1)
> > > > -               ngroups =3D vdev->dev->ngroups;
> > > > -
> > > > +       /* TODO do we need to store ngroups and nas? vdpa device al=
ready store it for us */
> > > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->de=
v,
> > > > -                                &vduse_vdpa_config_ops, ngroups, 1=
, name,
> > > > +                                &vduse_vdpa_config_ops, ngroups, d=
ev->nas, name,
> > > >                                  true);
> > > >         if (IS_ERR(vdev))
> > > >                 return PTR_ERR(vdev);
> > > > @@ -2088,11 +2179,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_de=
v *mdev, const char *name,
> > > >                 return ret;
> > > >
> > > >         mutex_lock(&dev->domain_lock);
> > > > -       if (!dev->domain)
> > > > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE=
 - 1,
> > > > -                                                 dev->bounce_size)=
;
> > > > +       ret =3D 0;
> > > > +
> > > > +       /* TODO we could delay the creation of the domain */
> > > > +       for (int i =3D 0; i < dev->nas; ++i) {
> > > > +               if (!dev->domain[i])
> > > > +                       dev->domain[i] =3D vduse_domain_create(VDUS=
E_IOVA_SIZE - 1,
> > > > +                                                            dev->b=
ounce_size);
> > > > +               if (!dev->domain[i]) {
> > > > +                       ret =3D -ENOMEM;
> > > > +                       for (int j =3D 0; j < i; ++j)
> > > > +                               vduse_domain_destroy(dev->domain[j]=
);
> > > > +                       goto err_domain;
> > > > +               }
> > > > +       }
> > > > +
> > > >         mutex_unlock(&dev->domain_lock);
> > > > -       if (!dev->domain) {
> > > > +       if (ret =3D=3D -ENOMEM) {
> > > >                 put_device(&dev->vdev->vdpa.dev);
> > > >                 return -ENOMEM;
> > > >         }
> > > > @@ -2101,13 +2204,22 @@ static int vdpa_dev_add(struct vdpa_mgmt_de=
v *mdev, const char *name,
> > > >         if (ret) {
> > > >                 put_device(&dev->vdev->vdpa.dev);
> > > >                 mutex_lock(&dev->domain_lock);
> > > > -               vduse_domain_destroy(dev->domain);
> > > > -               dev->domain =3D NULL;
> > > > +               for (int i =3D 0; i < dev->nas; i++) {
> > > > +                       if (dev->domain[i]) {
> > > > +                               vduse_domain_destroy(dev->domain[i]=
);
> > > > +                               dev->domain[i] =3D NULL;
> > > > +                       }
> > > > +               }
> > > >                 mutex_unlock(&dev->domain_lock);
> > > >                 return ret;
> > > >         }
> > > >
> > > >         return 0;
> > > > +
> > > > +err_domain:
> > > > +       /* TODO do I need to call put_device? */
> > > > +       mutex_unlock(&dev->domain_lock);
> > > > +       return ret;
> > > >  }
> > > >
> > > >  static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_d=
evice *dev)
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index a779bcddac58..3a17a0b4e938 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -46,7 +46,8 @@ struct vduse_dev_config {
> > > >         __u32 vq_num;
> > > >         __u32 vq_align;
> > > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > > -       __u32 reserved[12];
> > > > +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > > +       __u32 reserved[11];
> > > >         __u32 config_size;
> > > >         __u8 config[];
> > > >  };
> > > > @@ -81,6 +82,17 @@ struct vduse_iotlb_entry {
> > > >         __u8 perm;
> > > >  };
> > > >
> > > > +struct vduse_iotlb_entry_v2 {
> > > > +       __u64 offset;
> > > > +       __u64 start;
> > > > +       __u64 last;
> > > > +       __u32 asid;
> > > > +#define VDUSE_ACCESS_RO 0x1
> > > > +#define VDUSE_ACCESS_WO 0x2
> > > > +#define VDUSE_ACCESS_RW 0x3
> > > > +       __u8 perm;
> > > > +};
> > > > +
> > > >  /*
> > > >   * Find the first IOVA region that overlaps with the range [start,=
 last]
> > > >   * and return the corresponding file descriptor. Return -EINVAL me=
ans the
> > > > @@ -171,6 +183,16 @@ struct vduse_vq_group {
> > > >         __u32 num;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct vduse_vq_group - virtqueue group
> > > > + @ @group: Index of the virtqueue group
> > > > + * @asid: Address space ID of the group
> > > > + */
> > > > +struct vduse_vq_group_asid {
> > > > +       __u32 group;
> > > > +       __u32 asid;
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct vduse_vq_info - information of a virtqueue
> > > >   * @index: virtqueue index
> > > > @@ -231,7 +253,9 @@ struct vduse_vq_eventfd {
> > > >   * @uaddr: start address of userspace memory, it must be aligned t=
o page size
> > > >   * @iova: start of the IOVA region
> > > >   * @size: size of the IOVA region
> > > > + * @asid: Address space ID of the IOVA region
> > > >   * @reserved: for future use, needs to be initialized to zero
> > > > + * @reserved2: for future use, needs to be initialized to zero
> > > >   *
> > > >   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UM=
EM
> > > >   * ioctls to register/de-register userspace memory for IOVA region=
s
> > > > @@ -240,7 +264,9 @@ struct vduse_iova_umem {
> > > >         __u64 uaddr;
> > > >         __u64 iova;
> > > >         __u64 size;
> > > > -       __u64 reserved[3];
> > > > +       __u32 asid;
> > > > +       __u32 reserved[1];
> > >
> > > Basically, I'm not sure we can assume reserved to be zero for API_VER=
SION =3D=3D 1.
> > >
> >
> > Why not? The ioctl returns -EINVAL if it is not 0, so either an v0 or
> > v1 ioctl user must set it if it wants the ioctl to return success.
>
> Typo, I mean API_VERSION =3D=3D 0. It is reserved but the kernel doesn't
> mandate it to be zero. But it doesn't matter probably as it will be
> ruled by API_VERSION as you explain above.
>

The kernel ioctl system does not mandate them to be 0, but
vduse_dev_ioctl checks for it to be 0. If returns -EINVAL in case
they're not.

This patch also checks that asid, previously part of "reserved" keeps
being 0 if VDUSE_API < 1.

> >
> > > > +       __u64 reserved2[2];
> > >
> > > Any reasons we can't reuse reserved array?
> > >
> >
> > I don't get this comment, we're reusing it, isn't it? I'm just
> > splitting the u64[3] into u32[1]+u64[2]. Maybe it is more elegant to
> > use an u32[5] or similar?
>
> Yes, I mean reuse the u32 array. (but not a must I guess unless the
> ABI is stable).
>

I'm happy with the u32 array too!

> >
> > > >  };
> > > >
> > > >  /* Register userspace memory for IOVA regions */
> > > > @@ -264,7 +290,8 @@ struct vduse_iova_info {
> > > >         __u64 last;
> > > >  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > >         __u64 capability;
> > > > -       __u64 reserved[3];
> > > > +       __u64 asid; /* Only if device API version >=3D 1 */
> > > > +       __u64 reserved[2];
> > >
> > > Same here.
> > >
> > > >  };
> > > >
> > > >  /*
> > > > @@ -287,6 +314,7 @@ enum vduse_req_type {
> > > >         VDUSE_SET_STATUS,
> > > >         VDUSE_UPDATE_IOTLB,
> > > >         VDUSE_GET_VQ_GROUP,
> > > > +       VDUSE_SET_VQ_GROUP_ASID,
> > > >  };
> > > >
> > > >  /**
> > > > @@ -342,6 +370,8 @@ struct vduse_dev_request {
> > > >                 struct vduse_dev_status s;
> > > >                 struct vduse_iova_range iova;
> > > >                 struct vduse_vq_group vq_group; /* Only if vduse ap=
i version >=3D 1 */
> > > > +               /* Only if vduse api version >=3D 1 */
> > > > +               struct vduse_vq_group_asid vq_group_asid;
> > >
> > > This seems to break the uAPI as sizeof(struct vduse_dev_request) chan=
ges.
> > >
> >
> > It should not change. vduse_vq_group is 64 bits, smaller than padding
> > which is 32bits*32 =3D 1024bits. And they're both in the same union.
>
> You're right.
>
> >
> > > >                 __u32 padding[32];
> > > >         };
> > > >  };
> > > > @@ -365,6 +395,8 @@ struct vduse_dev_response {
> > > >         union {
> > > >                 struct vduse_vq_state vq_state;
> > > >                 struct vduse_vq_group vq_group; /* Only if vduse ap=
i version >=3D 1 */
> > > > +               /* Only if vduse api version >=3D 1 */
> > > > +               struct vduse_vq_group_asid vq_group_asid;
> > >
> > > Same here.
> > >
> >
> > Same reply :).
>
> Yes.
>
> >
> > > >                 __u32 padding[32];
> > > >         };
> > > >  };
> > > > --
> > > > 2.49.0
> > > >
> > >
> > > Thanks
> > >
> >
>
> Thanks
>


