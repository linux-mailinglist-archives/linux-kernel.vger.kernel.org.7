Return-Path: <linux-kernel+bounces-826506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB57B8EB19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B528A189DB29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5C684D02;
	Mon, 22 Sep 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmnhc38V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174ADF59
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504652; cv=none; b=UcztC1YynKGilAxxkccAQp9XOUXsSP/uC1xHngCydYprPsPy7aJEMMKIa6I2ynfa9gVz87WMC/jO92XKPSjwzZ30Pcde6zBu4y8qf5bu8Mnb4aWgsfgz0ZGNgWTD365UjV3wEUzqLABtW16VUlpstFCri6iTu/x7N/YTBzetcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504652; c=relaxed/simple;
	bh=AN9/XtZBIKy7ZLwPBK4vgHNjekuKuxLbc8d9zi1SP6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRugL2LoSwc9JMzIZYWz+ec+Y9ziRL9K3a/LfArHQSjT8shVImrSNr7MvEyPyDFIaz/BKo3Dlre3VvXlw/JOr1EFn/NuN1FF62uufpW4btYTlEBPzLmyphoW2cXM1EGoHyEtpeiBWg48AYZI6u6ZDXsi5RTLW0ZFNHt366VYnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmnhc38V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758504649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJ0H0T5/92e2Y6ZZpxdQLPJtyGWJ+HZCeYyMEoKI7QY=;
	b=bmnhc38V9Q2xLgdp5JSKYhm7EdaHXsevhLxkogct8dV3CktiWFMLgFFY70vEfFWD+7qMq7
	sf+gY7GC4kiASzBblHtzubCUMcOJHSQ5iI9b5zN0bAPRnXxvur/QqfHNUlh+LJprdIDOPz
	C2gj329qDEfUVUFAY2c+1fuB564gRVU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-DiUCQKiyP8WlAewxkMVROQ-1; Sun, 21 Sep 2025 21:30:47 -0400
X-MC-Unique: DiUCQKiyP8WlAewxkMVROQ-1
X-Mimecast-MFC-AGG-ID: DiUCQKiyP8WlAewxkMVROQ_1758504647
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2699ed6d43dso35599815ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758504646; x=1759109446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ0H0T5/92e2Y6ZZpxdQLPJtyGWJ+HZCeYyMEoKI7QY=;
        b=A3JwDlVaXZlqEJtrBwpe1T5tLs0TAcmiS+dxLLx0mQZFnhPDRbdtmLLD19tj1vwfoj
         USiFPzcd3eqEriY7Eip2F6nyYYgXgHdYeD8AAQqOB5dWwdsmIxoj5GbqN1bZLbpknaqo
         +uekjNco1oJUMBMY/8HcyNoX6WrleK7wXHtiqC7qNvEm9mxdZllKHcx8YTSgmBiZ+h4+
         CwzdJdnIjObWgIznzJQU2DWUKjKOtSMp0OWv72UbiC70Wxo7XF0+Cj07sGX250c0C6ks
         SgH6slz9IqqUGMI+/n5GzjmTPlZ5K5L5pZUKgsqjw2t07BjDs5MIbW8TCe3m/Ta1KjIx
         S3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/hTm9ExIJR//QIs24nfUxBpEWWAUkoWY7IrXA2mLX46lErPe+3qhsdt8KT8pwn0hXcANC4v5utjuPROw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgF5Y7gDAjx9QdJsTzTiqDZ5ZVlkQ13i+Tu6MYfElQ5HrGJu3G
	d4gLLbiEUHvdNzAOob3TBlTUDRluwOuv+GgWTq+JQG0OVphuOgXPEKA0GQedCgh2yvdhWrWVwa/
	+OEEOX2WYRWM+HcSLQYSVMTJdScEIIgKlpVdbcr2RAaBHZbfkfIyudQMu3NNsX9k/og1Iaqt45x
	AIRUOp3WkSBkJuijvKAmcxa0ptZdvZtn4KUvU6j0M4
X-Gm-Gg: ASbGnctVima/+3WqKUF/OAt8XwOfZxYOdizibA5zU8mCqBisekKydU5OE4Cf4UcW/bg
	t0YRGiocfDEPyjt0HIm+TtVARkeGdhw2lJ/S1hIWuGoHHajiIaoVzwq5kgdpo+VQd0suNGZeM35
	+lID/W0j4pgjWS9+amH3utlQ==
X-Received: by 2002:a17:903:3d52:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-269ba4028c0mr96853645ad.7.1758504645930;
        Sun, 21 Sep 2025 18:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDklXYSMuSbI9pD3NwaUXvPsgy/bvuO/QV5ZjcT+UGolNNkkGyHiLpzo+jYVYwvltFw0CbX+SHwsmlbnd6F8I=
X-Received: by 2002:a17:903:3d52:b0:250:6d0e:1e40 with SMTP id
 d9443c01a7336-269ba4028c0mr96853295ad.7.1758504645349; Sun, 21 Sep 2025
 18:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919093359.961296-1-eperezma@redhat.com> <20250919093359.961296-5-eperezma@redhat.com>
In-Reply-To: <20250919093359.961296-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 09:30:33 +0800
X-Gm-Features: AS18NWAVFphiW-uLh5GIAVCujhE-umyEHnsGHxQzRQg8Js5f8yxysZ_F63nxoZw
Message-ID: <CACGkMEsVE83Y5j8-aUBEBRqVc0xG=ChtqojR0B-c9oWuOut9HA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:34=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.  This allows the map functions to access
> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v3:
> * Adapt all virtio_map_ops callbacks to handle empty tokens in case of
>   invalid groups.
> * Make setting status DRIVER_OK fail if vq group is not valid.
> * Remove the _int name suffix from struct vduse_vq_group.
>
> RFC v3:
> * Make the vq groups a dynamic array to support an arbitrary number of
>   them.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 111 ++++++++++++++++++++++++++---
>  include/linux/virtio.h             |   6 +-
>  2 files changed, 105 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 7ddd81456f7b..6fdabc3c910e 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -23,6 +23,7 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/virtio.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
> @@ -88,6 +89,10 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_vq_group {
> +       struct vduse_dev *dev;
> +};
> +
>  struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
> @@ -121,6 +126,7 @@ struct vduse_dev {
>         u32 vq_align;
>         u32 ngroups;
>         struct vduse_umem *umem;
> +       struct vduse_vq_group *groups;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
>         rwlock_t domain_lock;
> @@ -308,6 +314,13 @@ static int vduse_dev_set_status(struct vduse_dev *de=
v, u8 status)
>         msg.req.type =3D VDUSE_SET_STATUS;
>         msg.req.s.status =3D status;
>
> +       if (dev->api_version >=3D VDUSE_API_VERSION_1 &&
> +           !(dev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +           status & VIRTIO_CONFIG_S_DRIVER_OK)

I don't understand why the INVALID check is only valid in the 0->1
transition here.


> +               for (u32 i =3D 0; i < dev->vq_num; ++i)
> +                       if (dev->vqs[i]->vq_group =3D=3D VQ_GROUP_INVALID=
)
> +                               return -EIO;
> +
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> @@ -612,6 +625,20 @@ static s64 vduse_get_vq_group(struct vdpa_device *vd=
pa, u16 idx)
>         return dev->vqs[idx]->vq_group;
>  }
>
> +static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 i=
dx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       u32 vq_group =3D vduse_get_vq_group(vdpa, idx);
> +       union virtio_map ret;
> +
> +       if (vq_group < 0)
> +               ret.group =3D NULL;
> +       else
> +               ret.group =3D &dev->groups[vq_group];
> +
> +       return ret;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -832,6 +859,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
>
> @@ -839,7 +867,14 @@ static void vduse_dev_sync_single_for_device(union v=
irtio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
> @@ -848,7 +883,14 @@ static void vduse_dev_sync_single_for_cpu(union virt=
io_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
> @@ -858,7 +900,14 @@ static dma_addr_t vduse_dev_map_page(union virtio_ma=
p token, struct page *page,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return DMA_MAPPING_ERROR;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
> @@ -867,7 +916,14 @@ static void vduse_dev_unmap_page(union virtio_map to=
ken, dma_addr_t dma_addr,
>                                  size_t size, enum dma_data_direction dir=
,
>                                  unsigned long attrs)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
>  }
> @@ -875,11 +931,17 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
>  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t siz=
e,
>                                       dma_addr_t *dma_addr, gfp_t flag)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
>         unsigned long iova;
>         void *addr;
>
>         *dma_addr =3D DMA_MAPPING_ERROR;
> +       if (!token.group)
> +               return NULL;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>         addr =3D vduse_domain_alloc_coherent(domain, size,
>                                            (dma_addr_t *)&iova, flag);
>         if (!addr)
> @@ -894,14 +956,28 @@ static void vduse_dev_free_coherent(union virtio_ma=
p token, size_t size,
>                                     void *vaddr, dma_addr_t dma_addr,
>                                     unsigned long attrs)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
>
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return false;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         return dma_addr < domain->bounce_size;
>  }
> @@ -915,7 +991,14 @@ static int vduse_dev_mapping_error(union virtio_map =
token, dma_addr_t dma_addr)
>
>  static size_t vduse_dev_max_mapping_size(union virtio_map token)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev;
> +       struct vduse_iova_domain *domain;
> +
> +       if (!token.group)
> +               return 0;
> +
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
>
>         return domain->bounce_size;
>  }
> @@ -1733,6 +1816,7 @@ static int vduse_destroy_dev(char *name)
>         if (dev->domain)
>                 vduse_domain_destroy(dev->domain);
>         kfree(dev->name);
> +       kfree(dev->groups);
>         vduse_dev_destroy(dev);
>         module_put(THIS_MODULE);
>
> @@ -1899,7 +1983,15 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +

Unnecessary change?

>         dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups ?:=
 1);
> +       dev->groups =3D kcalloc(dev->ngroups, sizeof(dev->groups[0]),
> +                             GFP_KERNEL);
> +       if (!dev->groups)
> +               goto err_vq_groups;
> +       for (u32 i =3D 0; i < dev->ngroups; ++i)
> +               dev->groups[i].dev =3D dev;
> +
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
>                 goto err_str;
> @@ -1936,6 +2028,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>  err_idr:
>         kfree(dev->name);
>  err_str:
> +       kfree(dev->groups);
> +err_vq_groups:
>         vduse_dev_destroy(dev);
>  err:
>         return ret;
> @@ -2097,7 +2191,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>                 return -ENOMEM;
>         }
>
> -       dev->vdev->vdpa.vmap.iova_domain =3D dev->domain;
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 96c66126c074..302109029700 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -41,13 +41,13 @@ struct virtqueue {
>         void *priv;
>  };
>
> -struct vduse_iova_domain;
> +struct vduse_vq_group;
>
>  union virtio_map {
>         /* Device that performs DMA */
>         struct device *dma_dev;
> -       /* VDUSE specific mapping data */
> -       struct vduse_iova_domain *iova_domain;
> +       /* VDUSE specific virtqueue group for doing map */
> +       struct vduse_vq_group *group;
>  };
>
>  int virtqueue_add_outbuf(struct virtqueue *vq,
> --
> 2.51.0
>

Thanks


