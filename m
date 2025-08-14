Return-Path: <linux-kernel+bounces-768027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18112B25C11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7FE1C84AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6793254AF0;
	Thu, 14 Aug 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MprwRhze"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A3253920
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153819; cv=none; b=naNyfyrKTscaPlo6gBNz49TVshdMwfpc4FTPDxf2YkX3LnGdLmmdxDovt/rUW9Pm4GIKaM7clPFaILDgibPZfvPbmq8rqx91LCyrTIYMAYAHETknCEWQl27wIpCkQBW5oxpZOTwptCl+BfFvmgHR1McejFD5dCr9Hx9oy/9IgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153819; c=relaxed/simple;
	bh=PDv1DgvVBwuT/7/j0EMvztGiFkd3EEDLYKFEXPrlpSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lommkk6//4sAZ0cCdhvU0CUifTgDa/xA6P6Ud/H92j7WCpI3D2LlLpeIH6oqqJ8IesRr7QrpRLEFuW4AxtDV++3ZcrVXsX6Jq2gciYv9+8262FquW4PUWzusr/vOgnUF3xybOolOnWWP77SlYJ70GAHOBe8x3KdKjHlwVfzH8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MprwRhze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755153817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEjs9ZzAMAj7CVLbWgd/27wmUDvqXJmHRSV3AjivC/Q=;
	b=MprwRhze2aoFk2pmcpoCLxANDpmQDq5cpBh9l1WLJyLg50wHyL1xt2pIPxFpHOJMV8HDyX
	BaaYCdqWI5F4Z5x1jUWwdDQd5PqyFAGd6oeOgWt2HCdMwgEigva9I4vSUp5zvqpJEL9Pye
	S80Sb2n5ertQ5SzLfj7GIqgbnjKaHak=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-LIvhdLCeOgaBpu4CKDL6Bw-1; Thu, 14 Aug 2025 02:43:35 -0400
X-MC-Unique: LIvhdLCeOgaBpu4CKDL6Bw-1
X-Mimecast-MFC-AGG-ID: LIvhdLCeOgaBpu4CKDL6Bw_1755153815
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326e6c74eso660052a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755153814; x=1755758614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEjs9ZzAMAj7CVLbWgd/27wmUDvqXJmHRSV3AjivC/Q=;
        b=lEncKg+6OFn6KCMlURWuBKx6u/aNMQPScWzXqy1qEsVIC8bTP0+Aweigha0nHbJcsF
         exLyy8QBJ2ui9zkB/U9xDrg4IypbeSdWY8exSa/oElS7uRwJs28Gb303q8iwMyCtjrJq
         iGfyi+fHwetKD8Xp1dbbnmfw0zOFzRqbIMilnVEMJlofTOVVHcBp8d4IGnr4zuw5GbAY
         x36WaLnLmsE9qsNAUiS0vm7lMtyCA5GVATm5/iQUbMd1nj05ElIOZVjKDAu2CNy524A/
         /+4DBzQAIkJ4K6g6kXt5Bf+5uLtXLgWBwMpLCKK83ursTeQMUGKRaQNzOdpkopuQEy9S
         gW8A==
X-Forwarded-Encrypted: i=1; AJvYcCXS9l7ydPEveZ+R5WsYRyNK7iwMM6CgHnl4uxd6LDxB1pkuIWTrkHD72dwrc8qcY5y6YAoO0dC9tGaKY+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHn2GxMy9tG7A4ekBx0zi60I2oCCc/5ogosWNkLZiRf/Amdy01
	2YJ+wwSBzWZwn2KchgOvlZorA8qajraMzOjkOP1JvloMfS9nhnC3gs8pY1sXsjz7NAtNQpu3yFj
	lEc/b1kIHj28NuEJtd05ZnQXMyx1hHaTbM3QDLW0YLlXgoctrwT15l2ArraZn4dmAlRnK5ONosR
	qeYXrgzJ1yDvkwI2rJKDM05Y87b4eK1ZmRf5jHQyqMayUkaU8E45pFKQ==
X-Gm-Gg: ASbGncs/IiZEZER0Lijr5XGN6kDFP9zTUxsEC7lv+5rOPduuhWaBqZPeXhGq21Tk4Yw
	U4V1YuqqJLa9c/j6j4AjOHmiOczJMxM+la5Lxr13DK2d2j2fjaytiTO7UPld1pqRIFNBNVxT6T8
	lXMCBdOHftxJdHUqoHIL9s
X-Received: by 2002:a17:90b:4fd1:b0:315:6f2b:ce53 with SMTP id 98e67ed59e1d1-32327a8a87dmr3253824a91.25.1755153813863;
        Wed, 13 Aug 2025 23:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUTntTH6AvqgXkPs1qXS93RDrfgPNlyBsuhOwrVhq5QEsTS8GhbP32047wXMBQxnvyDBZs4Lke+hoZjMGVeWw=
X-Received: by 2002:a17:90b:4fd1:b0:315:6f2b:ce53 with SMTP id
 98e67ed59e1d1-32327a8a87dmr3253796a91.25.1755153813372; Wed, 13 Aug 2025
 23:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-10-jasowang@redhat.com>
 <CAJaqyWdZv30TMedrdb-iF6qwwis7d_GJpVyk2dCur2J27+ywog@mail.gmail.com> <CACGkMEtYq9XnhNzdmD+=d1k8RStMcMP-Ljo_j1qfz6Us2wOXdQ@mail.gmail.com>
In-Reply-To: <CACGkMEtYq9XnhNzdmD+=d1k8RStMcMP-Ljo_j1qfz6Us2wOXdQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Aug 2025 08:42:57 +0200
X-Gm-Features: Ac12FXx9D1yHFsGvTIiEm0Lvf4k8g6qZL3UjYdbmMbKI8dKv_b6IfRDHX5Hn9sU
Message-ID: <CAJaqyWcZpX6XeXqTgBxyGnZWmnoR39juaOM=_owcNAGuDhBTCQ@mail.gmail.com>
Subject: Re: [PATCH V5 9/9] vduse: switch to use virtio map API instead of DMA API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Aug 13, 2025 at 5:03=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > Lacking the support of device specific mapping supported in virtio,
> > > VDUSE must trick the DMA API in order to make virtio-vdpa transport
> > > work. This is done by advertising vDPA device as dma device with a
> > > VDUSE specific dma_ops even if it doesn't do DMA at all.
> > >
> > > This will be fixed by this patch. Thanks to the new mapping operation=
s
> > > support by virtio and vDPA. VDUSE can simply switch to advertise its
> > > specific mappings operations to virtio via virtio-vdpa then DMA API i=
s
> > > not needed for VDUSE any more and iova domain could be used as the
> > > mapping token instead.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vdpa/Kconfig                 |  8 +--
> > >  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
> > >  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
> > >  drivers/vdpa/vdpa_user/vduse_dev.c   | 75 ++++++++++++++------------=
--
> > >  4 files changed, 41 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > > index 559fb9d3271f..857cf288c876 100644
> > > --- a/drivers/vdpa/Kconfig
> > > +++ b/drivers/vdpa/Kconfig
> > > @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
> > >
> > >  config VDPA_USER
> > >         tristate "VDUSE (vDPA Device in Userspace) support"
> > > -       depends on EVENTFD && MMU && HAS_DMA
> > > -       #
> > > -       # This driver incorrectly tries to override the dma_ops.  It =
should
> > > -       # never have done that, but for now keep it working on archit=
ectures
> > > -       # that use dma ops
> > > -       #
> > > -       depends on ARCH_HAS_DMA_OPS
> > > +       depends on EVENTFD && MMU
> > >         select VHOST_IOTLB
> > >         select IOMMU_IOVA
> > >         help
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa=
_user/iova_domain.c
> > > index 58116f89d8da..ccaed24b7ef8 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_do=
main *domain,
> > >
> > >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > >                                   size_t size, dma_addr_t *dma_addr,
> > > -                                 gfp_t flag, unsigned long attrs)
> > > +                                 gfp_t flag)
> > >  {
> > >         struct iova_domain *iovad =3D &domain->consistent_iovad;
> > >         unsigned long limit =3D domain->iova_limit;
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa=
_user/iova_domain.h
> > > index 7f3f0928ec78..1f3c30be272a 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > > @@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_doma=
in *domain,
> > >
> > >  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > >                                   size_t size, dma_addr_t *dma_addr,
> > > -                                 gfp_t flag, unsigned long attrs);
> > > +                                 gfp_t flag);
> > >
> > >  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, si=
ze_t size,
> > >                                 void *vaddr, dma_addr_t dma_addr,
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index f161059d543e..3260edefdf0d 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -88,6 +88,7 @@ struct vduse_dev {
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > >         struct vduse_iova_domain *domain;
> > > +       struct vduse_iova_domain *dom;
> >
> > *dom is not used
> >
>
> Let me fix that.
>
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -814,59 +815,53 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > >
> > > -static void vduse_dev_sync_single_for_device(struct device *dev,
> > > +static void vduse_dev_sync_single_for_device(void *token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> >
> > If I add ASID support to VDUSE I'll need to replace the token by a vq
> > group representor. Is that ok?
>
> It should be ok.
>
> >
> > I think it is as I like how using *domain here makes this patch
> > clearer, and adding something else will make this patch harder to
> > review.
>
> Yes.
>
> >
> > >
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > >  }
> > >
> > > -static void vduse_dev_sync_single_for_cpu(struct device *dev,
> > > +static void vduse_dev_sync_single_for_cpu(void *token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> > >
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > >  }
> > >
> > > -static dma_addr_t vduse_dev_map_page(struct device *dev, struct page=
 *page,
> > > +static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
> > >                                      unsigned long offset, size_t siz=
e,
> > >                                      enum dma_data_direction dir,
> > >                                      unsigned long attrs)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> > >
> > >         return vduse_domain_map_page(domain, page, offset, size, dir,=
 attrs);
> > >  }
> > >
> > > -static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_=
addr,
> > > +static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
> > >                                 size_t size, enum dma_data_direction =
dir,
> > >                                 unsigned long attrs)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> > >
> > >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, a=
ttrs);
> > >  }
> > >
> > > -static void *vduse_dev_alloc_coherent(struct device *dev, size_t siz=
e,
> > > -                                       dma_addr_t *dma_addr, gfp_t f=
lag,
> > > -                                       unsigned long attrs)
> > > +static void *vduse_dev_alloc_coherent(void *token, size_t size,
> > > +                                     dma_addr_t *dma_addr, gfp_t fla=
g)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> > >         unsigned long iova;
> > >         void *addr;
> > >
> > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > > -                               (dma_addr_t *)&iova, flag, attrs);
> > > +                                          (dma_addr_t *)&iova, flag)=
;
> > >         if (!addr)
> > >                 return NULL;
> > >
> > > @@ -875,31 +870,45 @@ static void *vduse_dev_alloc_coherent(struct de=
vice *dev, size_t size,
> > >         return addr;
> > >  }
> > >
> > > -static void vduse_dev_free_coherent(struct device *dev, size_t size,
> > > -                                       void *vaddr, dma_addr_t dma_a=
ddr,
> > > -                                       unsigned long attrs)
> > > +static void vduse_dev_free_coherent(void *token, size_t size,
> > > +                                   void *vaddr, dma_addr_t dma_addr,
> > > +                                   unsigned long attrs)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> > >
> > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, att=
rs);
> > >  }
> > >
> > > -static size_t vduse_dev_max_mapping_size(struct device *dev)
> > > +static bool vduse_dev_need_sync(void *token, dma_addr_t dma_addr)
> > >  {
> > > -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> > > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > > +       struct vduse_iova_domain *domain =3D token;
> > > +
> > > +       return dma_addr < domain->bounce_size;
> > > +}
> > > +
> > > +static int vduse_dev_mapping_error(void *token, dma_addr_t dma_addr)
> > > +{
> > > +       if (unlikely(dma_addr =3D=3D DMA_MAPPING_ERROR))
> > > +               return -ENOMEM;
> > > +       return 0;
> > > +}
> > > +
> > > +static size_t vduse_dev_max_mapping_size(void *token)
> > > +{
> > > +       struct vduse_iova_domain *domain =3D token;
> > >
> > >         return domain->bounce_size;
> > >  }
> > >
> > > -static const struct dma_map_ops vduse_dev_dma_ops =3D {
> > > +static const struct virtio_map_ops vduse_map_ops =3D {
> > >         .sync_single_for_device =3D vduse_dev_sync_single_for_device,
> > >         .sync_single_for_cpu =3D vduse_dev_sync_single_for_cpu,
> > >         .map_page =3D vduse_dev_map_page,
> > >         .unmap_page =3D vduse_dev_unmap_page,
> > >         .alloc =3D vduse_dev_alloc_coherent,
> > >         .free =3D vduse_dev_free_coherent,
> > > +       .need_sync =3D vduse_dev_need_sync,
> > > +       .mapping_error =3D vduse_dev_mapping_error,
> >
> > I think that adding these functions here is problematic,
> >
> > In the case of mapping error vring_mapping_error only checks for
> > vdev->map, not for vdev->map->mapping_error:
> >
> > static int vring_mapping_error(const struct vring_virtqueue *vq,
> >                               dma_addr_t addr)
> > {
> >        struct virtio_device *vdev =3D vq->vq.vdev;
> >
> >        if (!vq->use_map_api)
> >                return 0;
> >
> >        if (vdev->map)
> >                return vdev->map->mapping_error(vring_mapping_token(vq),=
 addr);
> >        else
> >                return dma_mapping_error(vring_dma_dev(vq), addr);
> > }
> >
> > So we either add the check for the member or we define them from the be=
ginning.
>
> I'm not sure I will get here. I can add a comment to explain that all
> map ops are mandated not optional.
>

Ok I thought there was a possibility for virtio core to try calling
vdev->map->mapping_error in previous patches. Now I see that
vduse_map_ops is actually created in this patch, so that's not
possible. My bad!


