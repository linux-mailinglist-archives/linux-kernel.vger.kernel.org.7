Return-Path: <linux-kernel+bounces-766285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A322B244A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D7914E12A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5C2ECD1C;
	Wed, 13 Aug 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q28HEGj2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812C1E521D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074845; cv=none; b=Ax9mKI/XVqU5W1lED85n96McR7wQ6ZO21GC/dE87x8O0fTyZ+TWebqHQavkHFUn4ps8X/xXYQnWQShLvky/DwjJiWmnjDakdfxpAwfv8ukWUD4z3OoPMjv+TUMfrBKqv15VvALF+kjJx5DaWCmRrOVeKHrYvVzX9x2TVU/Op3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074845; c=relaxed/simple;
	bh=m4oWCPDMCzCFYFVwAtJKZAo3GHsFEq+EDn3lQQc3Q8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQSqztCfKe+IVb0M8NWUJMP/o2SOiXuTowiJyZg909m9M55+djewUPODhybI0sIEcClD4sKFxgGRsZ+EeVWzHMozYGUcJwSFyv7EmzMKQOwvVWHBWgwNrDiVWFiBdUnAmqLVkMPDL7Ghip+m9a7l4JHY8Lwpdrar+QtSs2zfC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q28HEGj2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755074842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcS8gTZDyjRh9d1AlktTlJbHeFFdERbLCA3U7FzSzdQ=;
	b=Q28HEGj2gTSEZIG+C3sHeDa0mr7ZLNrcr1OMZc2/tm4Ppy9TYQj39EIM7LVv9eU6Ayl8F8
	FbxR+sK7/NlBj2uUTy9tZPK/ycudRCyYIRXajub6WUGtanTqtirAejPjd8RsvB5nqmlcoi
	v1AZnlpiV/HZmdUx90twPXCkgxNjHCw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-KvOsqzt6OBG3Pp8Uq8MQSg-1; Wed, 13 Aug 2025 04:47:19 -0400
X-MC-Unique: KvOsqzt6OBG3Pp8Uq8MQSg-1
X-Mimecast-MFC-AGG-ID: KvOsqzt6OBG3Pp8Uq8MQSg_1755074838
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3214259ce67so7244968a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074838; x=1755679638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcS8gTZDyjRh9d1AlktTlJbHeFFdERbLCA3U7FzSzdQ=;
        b=AtCQfTn2UE1Ih1Wbf9VEjhfoWmM/qgIojcSlWFOY7iDCGYp2LcNkctwfQWCYAAa1T7
         ERvS4gXS9fG/GiUySCV6V+j7Z7IruytHQSiI6bkSblhBk17udoJPD+IVupOnWwV+HIEx
         b/vPjqOebXgBM2Jl2Wzjwutw5DlhwF3YY+qpeX5K0NEFLsK7X2WuuyJf72wGxcKHRsOf
         YVt+h4BF3GVOSIog9gbwh7fRrFjSYpNjBW/ls2zFYNxsbZ7xmeBtgWH1GnvPYpV8azb8
         p1ch73qoGHked7p+duDKie6DR2ApSjMxcP5WGokfKEWnJ9ervr3hu46MSmJKkIYiNOzo
         9mhw==
X-Forwarded-Encrypted: i=1; AJvYcCWrc3vkhcf9m736AqLG7IXWL6Fx9Wb6RITECKU0nqrDgP2zVpgdZoVVBHvo2VrJSk3mxUdzL6u10otGLIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQurEFlSNAW3shjGGLvHs8k7AMYExyXpazXf2DmMhu8QO3cXlX
	PO6q6wq+6i79qTf8/206khHmqdctWc8VTK5dogcAaTwvd44uTANSpkWXz0bDWLAZBZOjGJpsqZN
	8nh3G/cMstNU3AmzPZtNYfP8o282Ty31wIcBwJlcT+FCIR8bgnZLExVo1TTjv/cSzFaiETyyw3I
	pEZduhTlptkyhZy17TqUlsH9F2O8oLLuVmtlyiAnZX
X-Gm-Gg: ASbGncu3I9LaM5Fn8ey/4fIxnrL+gzm2YtnJf3/kR9qqOPbN3ly4rW2+27wDpENgsQy
	nitT1aBFHo2xCxOj11dWN7YqXXXv0kPuI/7Uznvu6Hkf8HAjYSLPTOy75okadAcpXiwdAbuK0fZ
	ai+mVa1uRyKyHErkzYbCK8hc8UWgCytZeH/b82707PytSAX97EnNZL69o=
X-Received: by 2002:a17:90b:1f8c:b0:321:74d8:b95 with SMTP id 98e67ed59e1d1-321d0e5d438mr3286284a91.19.1755074837672;
        Wed, 13 Aug 2025 01:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbrehTIB+GmQUPNskxdKXnJVfhQ30/aVOc5xSUN8TLxPIR5BBEdHsFk2RIA4g5qAexY3p7imvjj2pXTjGfems=
X-Received: by 2002:a17:90b:1f8c:b0:321:74d8:b95 with SMTP id
 98e67ed59e1d1-321d0e5d438mr3286253a91.19.1755074837045; Wed, 13 Aug 2025
 01:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-9-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-9-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 10:46:40 +0200
X-Gm-Features: Ac12FXwOy8dl_lRl14WKLiILH86k1NtgXsatGnFMM_zXLgf697dmRSGwtplhDR8
Message-ID: <CAJaqyWfAir+0w2JvfBNjSyaJ8yV-2p9a+uU-Bnr2THe0cQ+BMg@mail.gmail.com>
Subject: Re: [PATCH V5 8/9] vdpa: introduce map ops
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Virtio core allows the transport to provide device or transport
> specific mapping functions. This patch adds this support to vDPA. We
> can simply do this by allowing the vDPA parent to register a
> virtio_map_ops.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c          |  3 ++-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |  3 ++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++--
>  drivers/vdpa/pds/vdpa_dev.c              |  3 ++-
>  drivers/vdpa/solidrun/snet_main.c        |  4 ++--
>  drivers/vdpa/vdpa.c                      |  3 +++
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 ++-
>  drivers/vhost/vdpa.c                     | 10 ++++++++++
>  drivers/virtio/virtio_vdpa.c             |  4 +++-
>  include/linux/vdpa.h                     | 10 +++++++---
>  13 files changed, 39 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_v=
dpa.c
> index cbec3fcffaef..a0420da37863 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -478,7 +478,8 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>                 return ret;
>
>         eni_vdpa =3D vdpa_alloc_device(struct eni_vdpa, vdpa,
> -                                    dev, &eni_vdpa_ops, 1, 1, NULL, fals=
e);
> +                                    dev, &eni_vdpa_ops, NULL,
> +                                    1, 1, NULL, false);
>         if (IS_ERR(eni_vdpa)) {
>                 ENI_ERR(pdev, "failed to allocate vDPA structure\n");
>                 return PTR_ERR(eni_vdpa);
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_m=
ain.c
> index 520a7d4db435..2fd8a9b20ac3 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -705,7 +705,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>         vf =3D &ifcvf_mgmt_dev->vf;
>         pdev =3D vf->pdev;
>         adapter =3D vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> -                                   &pdev->dev, &ifc_vdpa_ops, 1, 1, NULL=
, false);
> +                                   &pdev->dev, &ifc_vdpa_ops,
> +                                   NULL, 1, 1, NULL, false);
>         if (IS_ERR(adapter)) {
>                 IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>                 return PTR_ERR(adapter);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 4a1a8b0a0123..8a8cf6942998 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3882,7 +3882,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>
>         ndev =3D vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev=
->device, &mgtdev->vdpa_ops,
> -                                MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS=
, name, false);
> +                                NULL, MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_=
NUM_AS, name, false);
>         if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index e229b421d194..3ef9c2fd8f57 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -508,8 +508,8 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>         u64 device_features;
>         int ret;
>
> -       oct_vdpa =3D vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->de=
v, &octep_vdpa_ops, 1, 1,
> -                                    NULL, false);
> +       oct_vdpa =3D vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->de=
v, &octep_vdpa_ops,
> +                                    NULL, 1, 1, NULL, false);
>         if (IS_ERR(oct_vdpa)) {
>                 dev_err(&pdev->dev, "Failed to allocate vDPA structure fo=
r octep vdpa device");
>                 return PTR_ERR(oct_vdpa);
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index c9da0e519d5c..ed3e015c4668 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -632,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         }
>
>         pdsv =3D vdpa_alloc_device(struct pds_vdpa_device, vdpa_dev,
> -                                dev, &pds_vdpa_ops, 1, 1, name, false);
> +                                dev, &pds_vdpa_ops, NULL,
> +                                1, 1, name, false);
>         if (IS_ERR(pdsv)) {
>                 dev_err(dev, "Failed to allocate vDPA structure: %pe\n", =
pdsv);
>                 return PTR_ERR(pdsv);
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/sn=
et_main.c
> index d7b4eff77c95..849d325cab31 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -1008,8 +1008,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
>         }
>
>         /* Allocate vdpa device */
> -       snet =3D vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_c=
onfig_ops, 1, 1, NULL,
> -                                false);
> +       snet =3D vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_c=
onfig_ops,
> +                                NULL, 1, 1, NULL, false);
>         if (!snet) {
>                 SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
>                 ret =3D -ENOMEM;
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 0115ce04979c..8421c882f4d6 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -142,6 +142,7 @@ static void vdpa_release_dev(struct device *d)
>   * initialized but before registered.
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> + * @map: the map opeartions that is supported by this device

s/opeartions/operations/

Apart from that,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>   * @ngroups: number of groups supported by this device
>   * @nas: number of address spaces supported by this device
>   * @size: size of the parent structure that contains private data
> @@ -156,6 +157,7 @@ static void vdpa_release_dev(struct device *d)
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>                                         const struct vdpa_config_ops *con=
fig,
> +                                       const struct virtio_map_ops *map,
>                                         unsigned int ngroups, unsigned in=
t nas,
>                                         size_t size, const char *name,
>                                         bool use_va)
> @@ -187,6 +189,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device=
 *parent,
>         vdev->dev.release =3D vdpa_release_dev;
>         vdev->index =3D err;
>         vdev->config =3D config;
> +       vdev->map =3D map;
>         vdev->features_valid =3D false;
>         vdev->use_va =3D use_va;
>         vdev->ngroups =3D ngroups;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 9a07063aaff7..fa288960d53f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -215,7 +215,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_att=
r *dev_attr,
>         else
>                 ops =3D &vdpasim_config_ops;
>
> -       vdpa =3D __vdpa_alloc_device(NULL, ops,
> +       vdpa =3D __vdpa_alloc_device(NULL, ops, NULL,
>                                    dev_attr->ngroups, dev_attr->nas,
>                                    dev_attr->alloc_size,
>                                    dev_attr->name, use_va);
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 8e32b3db8608..f161059d543e 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2009,7 +2009,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>                 return -EEXIST;
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -                                &vduse_vdpa_config_ops, 1, 1, name, true=
);
> +                                &vduse_vdpa_config_ops, NULL,
> +                                1, 1, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 2cb0dbf1740e..e908b2a37c92 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -511,7 +511,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_md=
ev, const char *name,
>         int ret, i;
>
>         vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> -                                   dev, &vp_vdpa_ops, 1, 1, name, false)=
;
> +                                   dev, &vp_vdpa_ops, NULL,
> +                                   1, 1, name, false);
>
>         if (IS_ERR(vp_vdpa)) {
>                 dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\=
n");
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3d4c44b3f2b7..147fdef02f06 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1322,13 +1322,23 @@ static int vhost_vdpa_alloc_domain(struct vhost_v=
dpa *v)
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         union vring_mapping_token *mapping_token =3D
>               vdpa_get_mapping_token(vdpa);
> +       const struct virtio_map_ops *map =3D vdpa->map;
>         struct device *dma_dev =3D mapping_token->dma_dev;
>         int ret;
>
> +       /* IOMMU domain only works for DMA device */
> +       if (vdpa->map)
> +               return -EINVAL;
> +
>         /* Device want to do DMA by itself */
>         if (ops->set_map || ops->dma_map)
>                 return 0;
>
> +       if (map) {
> +               dev_warn(&v->dev, "Can't allocate a domian, device use ve=
ndor specific mappings\n");
> +               return -EINVAL;
> +       }
> +
>         if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
>                 dev_warn_once(&v->dev,
>                               "Failed to allocate domain, device is not I=
OMMU cache coherent capable\n");
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 1a10024a8e4f..fddfcfabf28e 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -462,9 +462,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdp=
a)
>         if (!vd_dev)
>                 return -ENOMEM;
>
> -       vd_dev->vdev.dev.parent =3D vdpa_get_mapping_token(vdpa)->dma_dev=
;
> +       vd_dev->vdev.dev.parent =3D vdpa->map ? &vdpa->dev :
> +                      vdpa_get_mapping_token(vdpa)->dma_dev;
>         vd_dev->vdev.dev.release =3D virtio_vdpa_release_dev;
>         vd_dev->vdev.config =3D &virtio_vdpa_config_ops;
> +       vd_dev->vdev.map =3D vdpa->map;
>         vd_dev->vdpa =3D vdpa;
>
>         vd_dev->vdev.id.device =3D ops->get_device_id(vdpa);
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index f806f13ca260..d328ec1ab5ea 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -76,6 +76,7 @@ struct vdpa_mgmt_dev;
>   *                   because core frees it; use driver_set_override() to
>   *                   set or clear it.
>   * @config: the configuration ops for this device.
> + * @map: the map ops for this device
>   * @cf_lock: Protects get and set access to configuration layout.
>   * @index: device index
>   * @features_valid: were features initialized? for legacy guests
> @@ -91,6 +92,7 @@ struct vdpa_device {
>         union vring_mapping_token mapping_token;
>         const char *driver_override;
>         const struct vdpa_config_ops *config;
> +       const struct virtio_map_ops *map;
>         struct rw_semaphore cf_lock; /* Protects get/set config */
>         unsigned int index;
>         bool features_valid;
> @@ -447,6 +449,7 @@ struct vdpa_config_ops {
>
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>                                         const struct vdpa_config_ops *con=
fig,
> +                                       const struct virtio_map_ops *map,
>                                         unsigned int ngroups, unsigned in=
t nas,
>                                         size_t size, const char *name,
>                                         bool use_va);
> @@ -458,6 +461,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device=
 *parent,
>   * @member: the name of struct vdpa_device within the @dev_struct
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> + * @map: the map operations that is supported by this device
>   * @ngroups: the number of virtqueue groups supported by this device
>   * @nas: the number of address spaces
>   * @name: name of the vdpa device
> @@ -465,10 +469,10 @@ struct vdpa_device *__vdpa_alloc_device(struct devi=
ce *parent,
>   *
>   * Return allocated data structure or ERR_PTR upon error
>   */
> -#define vdpa_alloc_device(dev_struct, member, parent, config, ngroups, n=
as, \
> -                         name, use_va) \
> +#define vdpa_alloc_device(dev_struct, member, parent, config, map, \
> +                         ngroups, nas, name, use_va)              \
>                           container_of((__vdpa_alloc_device( \
> -                                      parent, config, ngroups, nas, \
> +                                      parent, config, map, ngroups, nas,=
 \
>                                        (sizeof(dev_struct) + \
>                                        BUILD_BUG_ON_ZERO(offsetof( \
>                                        dev_struct, member))), name, use_v=
a)), \
> --
> 2.31.1
>


