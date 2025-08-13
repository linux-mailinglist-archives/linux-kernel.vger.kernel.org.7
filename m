Return-Path: <linux-kernel+bounces-766310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB511B244EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70DF1891C48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A92F0C68;
	Wed, 13 Aug 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAZegAa6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94C2F0688
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075802; cv=none; b=HvoIHd+l2gHrl6ZRVXGmn+GKeAc84xTc2lpCaUdFjC1DZ7csPoDpvTU+wThXlxfdSk5sFVVEu+ey1XxvN7T2MjbmsMIVDiNIrEYKOYwDfr3xnNivb5gNWWtlv5H4N83ciJ+/YMa7LOLaXnguFG06HDITb93/HG0IFmTroJDXfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075802; c=relaxed/simple;
	bh=Aj52hjGpFwDKOEkg+yoVubJt3cZKtQEFLNv5e/Q++kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thhdQU9u6dHjREk7wd/71xNtgEdltfnZ9f8Af31yAvx/2XJpbXBjXbxgQ6PdaGKrdU4VHs2ff5Sy77nK50GKWczJLxWyMIQKfCNvO3R6JVL4VVbP0fKb1NNPxgqLLt8nmQ/NPPs28AVdN4NOUqTJkeUUXXOWcCyHpMKY6MVjvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAZegAa6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755075799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ced2zugqerKUWoRnDLqpVCEfNS36g0dc3X5IsE9iu9w=;
	b=GAZegAa6ygiINJcv56ltU1hj+dz8agDZ6cQoOhWtN2WB77McOL0l/isaDkIXZD4ghMV7qw
	hH9Kb9ggcItcDCQMPSSHjPS5S7W8YRjIXHUNrZyUoEBbWMP0wnh4QBTLbjMVPbEIb6DTXH
	TMzQdeRq0pxpPxsZl5qFEbiWYxassUo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-rcwaZZYENvGtw9f9ZIw_2w-1; Wed, 13 Aug 2025 05:03:18 -0400
X-MC-Unique: rcwaZZYENvGtw9f9ZIw_2w-1
X-Mimecast-MFC-AGG-ID: rcwaZZYENvGtw9f9ZIw_2w_1755075797
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400117dd80so48184175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755075797; x=1755680597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ced2zugqerKUWoRnDLqpVCEfNS36g0dc3X5IsE9iu9w=;
        b=s31+GsZlwLD5Eh0qlQvo8cD8X05i2GoEnAhH9pRLxX5JTpr3kbsSn5gZ975zFjaQI+
         jRyOeR6nQj5GYw6Ez8eoEABPmAef1vQ5ffROfyc/33oahPxoxqJ7TjsEb9fOJCUHDKRV
         gwzu8V1CU0t5QvV+xZxqpjWqXT/HNB994QcyfbX1dps3c7le5zFDnrXBqKNDVjfNz3Hd
         xZbJenM2ZlXcSl9Ez0rJF3pP83Y1nd68+Myeo3p/RFhmdWdawFhFjOUUJ7/+GFVLqjST
         bSwOZPugMqQ3uwU7Y4Qwu5z4hC1sSKo94Z8rxrK8FqrNpSO5hIq4sGV9Sg9CAQ2TeMY+
         6FEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg39Goy6ayuUpsnlBBxNQPegbcU+H5hNN3L33jjpd8jlhX0rneQkbCeo7hkVnuk3D6ByKoOmXecAC/oTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Eem6JosVuodbqpg2bYzhesE/I8C+I02/PonNHc4NiGg9a9hP
	zIciipr6U7RGbdAc1qDP4rJXg7Nvo1I3DROCypiYfreyTizj52QoLJAPhVis6LzmVYIEBC8yXB/
	sbOBzU6c5lIPF4KwfQbX18eHYwbQ4yGY3J5h4vsO0GbihLfcBdNsscehQpza57TJyp8+a460NQB
	5g74tj7jVFPq09ubekqiNJc7JiiJ76ZW6U4kLwGZy7
X-Gm-Gg: ASbGncsXO4xLPZwaCHxd3vSVIDPiVYi7jaY93gIFNibY1bARXCm61q25NwAmDrkTQL+
	enJo5v/nHrRUOUkpP+5PFKmyY6EzuiNvI5VLIRCArIG9iyfhY1Ker+gGuYBItRSHAGy1aR/jiQi
	1iZ0ooxdVTrCY7fhScB2XvnBWomd0nwxWYY26PPyvi/Z3jO7ZMxxwLtmI=
X-Received: by 2002:a17:902:e748:b0:242:3105:1788 with SMTP id d9443c01a7336-2430d26ec8amr37711695ad.45.1755075796760;
        Wed, 13 Aug 2025 02:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcIRJqmQuwKANiz/+p3nsKkxnTguY11utBfiv/zk5L3YGSk5MKsG5FVN18bi13oyLxTZNPbBQf74wdJECdvcw=
X-Received: by 2002:a17:902:e748:b0:242:3105:1788 with SMTP id
 d9443c01a7336-2430d26ec8amr37711305ad.45.1755075796292; Wed, 13 Aug 2025
 02:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-10-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-10-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 11:02:40 +0200
X-Gm-Features: Ac12FXx21ljdLj-EkoI0xvLjH0x-RBhy426HTvbSRhe1Al8_JoP9Uoq32NRk8-4
Message-ID: <CAJaqyWdZv30TMedrdb-iF6qwwis7d_GJpVyk2dCur2J27+ywog@mail.gmail.com>
Subject: Re: [PATCH V5 9/9] vduse: switch to use virtio map API instead of DMA API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Lacking the support of device specific mapping supported in virtio,
> VDUSE must trick the DMA API in order to make virtio-vdpa transport
> work. This is done by advertising vDPA device as dma device with a
> VDUSE specific dma_ops even if it doesn't do DMA at all.
>
> This will be fixed by this patch. Thanks to the new mapping operations
> support by virtio and vDPA. VDUSE can simply switch to advertise its
> specific mappings operations to virtio via virtio-vdpa then DMA API is
> not needed for VDUSE any more and iova domain could be used as the
> mapping token instead.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/Kconfig                 |  8 +--
>  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 75 ++++++++++++++--------------
>  4 files changed, 41 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 559fb9d3271f..857cf288c876 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
>
>  config VDPA_USER
>         tristate "VDUSE (vDPA Device in Userspace) support"
> -       depends on EVENTFD && MMU && HAS_DMA
> -       #
> -       # This driver incorrectly tries to override the dma_ops.  It shou=
ld
> -       # never have done that, but for now keep it working on architectu=
res
> -       # that use dma ops
> -       #
> -       depends on ARCH_HAS_DMA_OPS
> +       depends on EVENTFD && MMU
>         select VHOST_IOTLB
>         select IOMMU_IOVA
>         help
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 58116f89d8da..ccaed24b7ef8 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain=
 *domain,
>
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>                                   size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag, unsigned long attrs)
> +                                 gfp_t flag)
>  {
>         struct iova_domain *iovad =3D &domain->consistent_iovad;
>         unsigned long limit =3D domain->iova_limit;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index 7f3f0928ec78..1f3c30be272a 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *=
domain,
>
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>                                   size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag, unsigned long attrs);
> +                                 gfp_t flag);
>
>  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t=
 size,
>                                 void *vaddr, dma_addr_t dma_addr,
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index f161059d543e..3260edefdf0d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -88,6 +88,7 @@ struct vduse_dev {
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
>         struct vduse_iova_domain *domain;
> +       struct vduse_iova_domain *dom;

*dom is not used

>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -814,59 +815,53 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
>         .free                   =3D vduse_vdpa_free,
>  };
>
> -static void vduse_dev_sync_single_for_device(struct device *dev,
> +static void vduse_dev_sync_single_for_device(void *token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;

If I add ASID support to VDUSE I'll need to replace the token by a vq
group representor. Is that ok?

I think it is as I like how using *domain here makes this patch
clearer, and adding something else will make this patch harder to
review.

>
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>
> -static void vduse_dev_sync_single_for_cpu(struct device *dev,
> +static void vduse_dev_sync_single_for_cpu(void *token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> -static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *pa=
ge,
> +static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
>                                      unsigned long offset, size_t size,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
>
> -static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr=
,
> +static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
>                                 size_t size, enum dma_data_direction dir,
>                                 unsigned long attrs)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
>  }
>
> -static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
> -                                       dma_addr_t *dma_addr, gfp_t flag,
> -                                       unsigned long attrs)
> +static void *vduse_dev_alloc_coherent(void *token, size_t size,
> +                                     dma_addr_t *dma_addr, gfp_t flag)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>         unsigned long iova;
>         void *addr;
>
>         *dma_addr =3D DMA_MAPPING_ERROR;
>         addr =3D vduse_domain_alloc_coherent(domain, size,
> -                               (dma_addr_t *)&iova, flag, attrs);
> +                                          (dma_addr_t *)&iova, flag);
>         if (!addr)
>                 return NULL;
>
> @@ -875,31 +870,45 @@ static void *vduse_dev_alloc_coherent(struct device=
 *dev, size_t size,
>         return addr;
>  }
>
> -static void vduse_dev_free_coherent(struct device *dev, size_t size,
> -                                       void *vaddr, dma_addr_t dma_addr,
> -                                       unsigned long attrs)
> +static void vduse_dev_free_coherent(void *token, size_t size,
> +                                   void *vaddr, dma_addr_t dma_addr,
> +                                   unsigned long attrs)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
>
> -static size_t vduse_dev_max_mapping_size(struct device *dev)
> +static bool vduse_dev_need_sync(void *token, dma_addr_t dma_addr)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
> +
> +       return dma_addr < domain->bounce_size;
> +}
> +
> +static int vduse_dev_mapping_error(void *token, dma_addr_t dma_addr)
> +{
> +       if (unlikely(dma_addr =3D=3D DMA_MAPPING_ERROR))
> +               return -ENOMEM;
> +       return 0;
> +}
> +
> +static size_t vduse_dev_max_mapping_size(void *token)
> +{
> +       struct vduse_iova_domain *domain =3D token;
>
>         return domain->bounce_size;
>  }
>
> -static const struct dma_map_ops vduse_dev_dma_ops =3D {
> +static const struct virtio_map_ops vduse_map_ops =3D {
>         .sync_single_for_device =3D vduse_dev_sync_single_for_device,
>         .sync_single_for_cpu =3D vduse_dev_sync_single_for_cpu,
>         .map_page =3D vduse_dev_map_page,
>         .unmap_page =3D vduse_dev_unmap_page,
>         .alloc =3D vduse_dev_alloc_coherent,
>         .free =3D vduse_dev_free_coherent,
> +       .need_sync =3D vduse_dev_need_sync,
> +       .mapping_error =3D vduse_dev_mapping_error,

I think that adding these functions here is problematic,

In the case of mapping error vring_mapping_error only checks for
vdev->map, not for vdev->map->mapping_error:

static int vring_mapping_error(const struct vring_virtqueue *vq,
                              dma_addr_t addr)
{
       struct virtio_device *vdev =3D vq->vq.vdev;

       if (!vq->use_map_api)
               return 0;

       if (vdev->map)
               return vdev->map->mapping_error(vring_mapping_token(vq), add=
r);
       else
               return dma_mapping_error(vring_dma_dev(vq), addr);
}

So we either add the check for the member or we define them from the beginn=
ing.

>         .max_mapping_size =3D vduse_dev_max_mapping_size,
>  };
>
> @@ -2003,27 +2012,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
>  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  {
>         struct vduse_vdpa *vdev;
> -       int ret;
>
>         if (dev->vdev)
>                 return -EEXIST;
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -                                &vduse_vdpa_config_ops, NULL,
> +                                &vduse_vdpa_config_ops, &vduse_map_ops,
>                                  1, 1, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
>         dev->vdev =3D vdev;
>         vdev->dev =3D dev;
> -       vdev->vdpa.dev.dma_mask =3D &vdev->vdpa.dev.coherent_dma_mask;
> -       ret =3D dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(6=
4));
> -       if (ret) {
> -               put_device(&vdev->vdpa.dev);
> -               return ret;
> -       }
> -       set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> -       vdev->vdpa.mapping_token.dma_dev =3D &vdev->vdpa.dev;
>         vdev->vdpa.mdev =3D &vduse_mgmt->mgmt_dev;
>
>         return 0;
> @@ -2056,6 +2056,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>                 return -ENOMEM;
>         }
>
> +       dev->vdev->vdpa.mapping_token.token =3D dev->domain;
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> --
> 2.31.1
>


