Return-Path: <linux-kernel+bounces-821307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9ACB80F21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F1C1886DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4D34BA3D;
	Wed, 17 Sep 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDYMWBw3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB534BA2D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125836; cv=none; b=N9ZBnzkmjoZCBKlWZCfRMmmR4NDnI3OyZ8Y/PeCv3enZIgfpTHs1NUh+Ud3YHJsKHPH9DBrktYKeU+XZB8K4wZYqQUOe3sCdGq+SUUDEcrE3YYWqcPm+uB+O1+ZEAqXRcpenpb2obHEcSXsdM6BLq1uKdcdq1AIYBj/BLsaFMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125836; c=relaxed/simple;
	bh=f5o/FUxe5iNbC4RBGy2qWQid6QD7+9xO0zGKc4rFrQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIbcKSJ3VHe9dwXQ0nqOLFq7RNGTHtqOE3v+kDtM2WR1vvd2voK0BPZn9H11I/Watqb48eEKaJ0qU25Wezgx5Hy3aJcNP8IofbZtCTWxL5lRU+DvRhHVkQBMDaFsaBvSPt9KMXM/xtA0qG3mUiwwYX/bYDNJDppM6cDrJ27ItRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDYMWBw3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758125833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfWZBt2zSfStApfaCH7mmPn5eoFglffKKLGnGyZRxNM=;
	b=JDYMWBw33vYMsKwP5kuA/LqYsggCvCt6uEPp8nxSQ6ItOSquRxhZp1n4YHRhcUGWxpDVR3
	CzY5DSlnq2zvZ5CmGMxqggn4sAxyToHi/71wJnIgOD7pWlcq/X/ujz3Vc3fTB61soRNo10
	x+t6emTVmtuR8xW/7v5M5znVMMqOJnk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-3Gc1lW4AOtCRaK6rdEessQ-1; Wed, 17 Sep 2025 12:17:11 -0400
X-MC-Unique: 3Gc1lW4AOtCRaK6rdEessQ-1
X-Mimecast-MFC-AGG-ID: 3Gc1lW4AOtCRaK6rdEessQ_1758125831
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-733ff1a73dcso668967b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125830; x=1758730630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfWZBt2zSfStApfaCH7mmPn5eoFglffKKLGnGyZRxNM=;
        b=Sp3+f9qD1Ba/Ck4goiQ+/q819G84aY8yVaNI2QVz4y0Xzhpz9D/ULtuJ2WOEJ/v3fs
         pAHI+CJDb+YmHGGJRIhi3VJyGq11O/1dY+Siy8Soe/CrICuHsaQQvPV083Z+Y8wC8GQ0
         K3400abTby5ynOmfAvhjdULdNPc+Dn1Q3Iq3NIS9/b7bT1jxJ+gnd6oAaGshg3TlQKT+
         kpsFAliFEGow2g4x5Fq5V6dVXP0Bpm4yZHsg2XUAQ9bhWCIvjygtgn7D3wCk9duq7TqH
         qrNLl5da2MAc4faABYkZ3Zoccm91Way2owlQmUwQDZQjGun2doejeLJykNdT2X42KyyS
         tNXg==
X-Forwarded-Encrypted: i=1; AJvYcCVH7SBA3/N1sFuuKhBRe1eXVmrd9yKg0FBtRGNv8XPjb4gMupdzrwQywh6/7/BHYvF6TpEjKoDcWqOt110=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+F1anOKhawHLGqpzzEACt2nyM4rkhJhlCtcvuvkc+PeXh2k7
	phH9qzC1Nl57HyeWqCA9r+XVWvkzg4ZmLkQyGeOhPCOHEJbbWRBjIQdbeXGUwyj2leLBxOFtRw+
	XdFMsrn7ykVfPl7U+bXawIVEKeyj0cEXpC9y0brodDWYWO67T/FNG+rnhjoVBAeElbqxcSFyzFt
	nU/OELA3WmNR49sQ0fuU415mgvl5deGjyfhXSZRvByAk+YoIQhL7c2vA==
X-Gm-Gg: ASbGncvENxPvtr+ojCYq52hb0uMaNnWq2oclqMU50GTSPI8kWOn1tVlTDdOcDKudvQv
	PCkOrd4NYUls7FFyxffpeijhwmJ/G6l/PThEBTlSFCScME/L0PD9UDWmEMHwbUQHo8S0Grx7JKk
	5f6KqJFlz+nOYYr68LLOPchbJwxz5CB/IuUWhWoomnj0bTAdTgPkEb4eEevI5ghfaS4/zI6LO2C
	xE+K9x8
X-Received: by 2002:a05:690c:64ca:b0:726:4b7a:1ec1 with SMTP id 00721157ae682-73893249140mr23662917b3.47.1758125830015;
        Wed, 17 Sep 2025 09:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGObF9RKTyIpHyxzWy+Hnw2h3N0ZVh0xAj9VZdVv1dpBLIeYQreBnm0kTVybwmeR5N+VPNZL+4W2cjYeU7Ptbg=
X-Received: by 2002:a05:690c:64ca:b0:726:4b7a:1ec1 with SMTP id
 00721157ae682-73893249140mr23662517b3.47.1758125829439; Wed, 17 Sep 2025
 09:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-5-eperezma@redhat.com>
 <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com>
In-Reply-To: <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 18:16:33 +0200
X-Gm-Features: AS18NWDkg-GLhDiz_uY5XwV9ED8cCpt8XErhSKA-aurbAKWbY2w-ZsgS0WsMdl0
Message-ID: <CAJaqyWfkpxmFXafRnxvP1Wjd3=uBaSr_m05BCpDYB4e7XR9diQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vduse: return internal vq group struct as map token
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Return the internal struct that represents the vq group as virtqueue ma=
p
> > token, instead of the device.  This allows the map functions to access
> > the information per group.
> >
> > At this moment all the virtqueues share the same vq group, that only
> > can point to ASID 0.  This change prepares the infrastructure for actua=
l
> > per-group address space handling
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > RFC v3:
> > * Make the vq groups a dynamic array to support an arbitrary number of
> >   them.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
> >  include/linux/virtio.h             |  6 ++--
> >  2 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 42f8807911d4..9c12ae72abc2 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/nospec.h>
> > +#include <linux/virtio.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched/mm.h>
> >  #include <uapi/linux/vduse.h>
> > @@ -85,6 +86,10 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_vq_group_int {
> > +       struct vduse_dev *dev;
> > +};
>
> I remember we had some discussion over this, and the conclusion is to
> have a better name.
>
> Maybe just vduse_vq_group?
>

Good catch, I also hate the _int suffix :). vduse_vq_group was used in
the vduse uapi in previous series, but now there is no reason for it.
Replacing it, thanks!

> And to be conceptually correct, we need to use iova_domain here
> instead of the vduse_dev. More below.
>
> > +
> >  struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> > @@ -118,6 +123,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         u32 ngroups;
> >         struct vduse_umem *umem;
> > +       struct vduse_vq_group_int *groups;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> >         rwlock_t domain_lock;
> > @@ -602,6 +608,15 @@ static u32 vduse_get_vq_group(struct vdpa_device *=
vdpa, u16 idx)
> >         return dev->vqs[idx]->vq_group;
> >  }
> >
> > +static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16=
 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       u32 vq_group =3D dev->vqs[idx]->vq_group;
> > +       union virtio_map ret =3D { .group =3D &dev->groups[vq_group] };
> > +
> > +       return ret;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -822,6 +837,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> >
> > @@ -829,7 +845,8 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
>
> If we really want to do this, we need to move the iova_domian into the gr=
oup.
>

It's done in patches on top to make each patch smaller. This patch is
focused on just changing the type of the union. Would you prefer me to
reorder the patches so that part is done earlier?

> >
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> >  }
> > @@ -838,7 +855,8 @@ static void vduse_dev_sync_single_for_cpu(union vir=
tio_map token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> > @@ -848,7 +866,8 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
> >                                      enum dma_data_direction dir,
> >                                      unsigned long attrs)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> >  }
> > @@ -857,7 +876,8 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
> >                                  size_t size, enum dma_data_direction d=
ir,
> >                                  unsigned long attrs)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> >  }
> > @@ -865,7 +885,8 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> >                                       dma_addr_t *dma_addr, gfp_t flag)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >         unsigned long iova;
> >         void *addr;
> >
> > @@ -884,14 +905,16 @@ static void vduse_dev_free_coherent(union virtio_=
map token, size_t size,
> >                                     void *vaddr, dma_addr_t dma_addr,
> >                                     unsigned long attrs)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs=
);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return dma_addr < domain->bounce_size;
> >  }
> > @@ -905,7 +928,8 @@ static int vduse_dev_mapping_error(union virtio_map=
 token, dma_addr_t dma_addr)
> >
> >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> >  {
> > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > +       struct vduse_dev *vdev =3D token.group->dev;
> > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> >         return domain->bounce_size;
> >  }
> > @@ -1720,6 +1744,7 @@ static int vduse_destroy_dev(char *name)
> >         if (dev->domain)
> >                 vduse_domain_destroy(dev->domain);
> >         kfree(dev->name);
> > +       kfree(dev->groups);
> >         vduse_dev_destroy(dev);
> >         module_put(THIS_MODULE);
> >
> > @@ -1885,7 +1910,15 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +
> >         dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups =
?: 1);
> > +       dev->groups =3D kcalloc(dev->ngroups, sizeof(dev->groups[0]),
> > +                             GFP_KERNEL);
> > +       if (!dev->groups)
> > +               goto err_vq_groups;
> > +       for (u32 i =3D 0; i < dev->ngroups; ++i)
> > +               dev->groups[i].dev =3D dev;
> > +
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1922,6 +1955,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >  err_idr:
> >         kfree(dev->name);
> >  err_str:
> > +       kfree(dev->groups);
> > +err_vq_groups:
> >         vduse_dev_destroy(dev);
> >  err:
> >         return ret;
> > @@ -2083,7 +2118,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >                 return -ENOMEM;
> >         }
> >
> > -       dev->vdev->vdpa.vmap.iova_domain =3D dev->domain;
> >         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> >         if (ret) {
> >                 put_device(&dev->vdev->vdpa.dev);
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 96c66126c074..5f8db75f7833 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -41,13 +41,13 @@ struct virtqueue {
> >         void *priv;
> >  };
> >
> > -struct vduse_iova_domain;
> > +struct vduse_vq_group_int;
> >
> >  union virtio_map {
> >         /* Device that performs DMA */
> >         struct device *dma_dev;
> > -       /* VDUSE specific mapping data */
> > -       struct vduse_iova_domain *iova_domain;
> > +       /* VDUSE specific virtqueue group for doing map */
> > +       struct vduse_vq_group_int *group;
> >  };
> >
> >  int virtqueue_add_outbuf(struct virtqueue *vq,
> > --
> > 2.51.0
> >
>
> Thanks
>


