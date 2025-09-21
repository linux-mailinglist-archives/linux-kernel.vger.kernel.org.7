Return-Path: <linux-kernel+bounces-826422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDDB8E7ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D879B7A1D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC71469D;
	Sun, 21 Sep 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0IkmCMH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56C24DD0E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491915; cv=none; b=fxIruf9bCLUDJn1Dd+TKZwbIwPI46dlVLLuoBC7fdZXQa/vwuplxtksLzFRY06Q7rxrJAim0r/WK4kaacqm8oKQtjCnuYoQkB0oVNn6mSVrJZjryyGnfFgjpREJnPL3TwBVYqXm8adeGbBYdHQtAFzIzWYeTXpoOkJ8Y5/r9OpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491915; c=relaxed/simple;
	bh=7gDBK/sxHAPC9g1Qd2iiEtrL0ip72Q0hLpe7VGa8lh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDfTHigR8u3Wc3nRR6L1nzU1xG9PiL9JAvAQLxgviu9UHeOBUf+YnkIKmjXmIVBefYtiJpNsjNEy8i7Z+PBVzc8mXKFHT0t6TKNKIIuiX/lT9rhhCjBJfSzYuYZNuMgzkRcYrysggmsVNiD4OZ8G5Pm7PB9omIIYU9W4TZuqBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0IkmCMH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758491910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcKvA7u1IVRddU6A8Lgq8eQ28KV9wZQaC1W8gdDHFHY=;
	b=M0IkmCMHAbx0eXzAOV3sQxd1Npyy4I+KFj7V+yEyaej+NEaX51czAjrwfDLHjRfJK8Iqw9
	lxL/6tYnwviwejgfcTlea+KV6e6tVEIbs5ZbwoqjS6dfOzuf28Vw7A5TcGg7HSoJ57FTTP
	/NOlAcyiuTHvEOjN2WnuB/7NGDaDPBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-oKn1pmIOMUKx7YIMp41FaQ-1; Sun, 21 Sep 2025 17:58:22 -0400
X-MC-Unique: oKn1pmIOMUKx7YIMp41FaQ-1
X-Mimecast-MFC-AGG-ID: oKn1pmIOMUKx7YIMp41FaQ_1758491901
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so22421535e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491901; x=1759096701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcKvA7u1IVRddU6A8Lgq8eQ28KV9wZQaC1W8gdDHFHY=;
        b=wIll6d/hhUjVTmp5ZtvhD8N3V2ME4lE8HQV+6FUwH9tCl2hzHBP/F+vYu1HycVAdtu
         ZtpihkmsxeyyiQC2yqnjNq5Xzu7qIimgCKo2oPnlKJ0xFtwObo2GjzCvbxCZniiBX6jL
         /CgXh8ZKr0yf6EJvHbcBZZxhYG+08k1kJ1Y3eYz21UXWzsCqMRC+FWiCwdJwhe2O8WXL
         IRrQX+diZUsyrjzyQQzeRsnPySQsBLvO4aXp5wSQLdTjvQhNzI/SFDV9V3Py3z/3iTRV
         drOHozVFWoCpEiKpX5PJVMBUPG1XJ/NE7c8ZRrob72nhIyeqI5tNsqz+7pg8T0myTL8Y
         xoFg==
X-Forwarded-Encrypted: i=1; AJvYcCU3t6pCE+erb0ygKQX9uOJYb+OFrvo2rKh149IAI9RnwvCkfoT401KOHoHgVkFlV6LG/CvQOy5Vmqipv/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQ8R66zgDfwZ/rQHdtM2MOQ91mS5I8qGgQT1lU30Pz7mRPeZf
	DcU6q8dPFd6ypKFWtddZfugy4pEiYaY/wjLen1CVl93VwWgOf7thQ4aZk0RclrZXzRykPapT5Wf
	gznX3MpAuPivU6XDx4uJrV9hrcI+B1hUi2uAITP+/GGyZQ1Ef8B1zdA9yTupZESyxPQ==
X-Gm-Gg: ASbGncsIZhPFgvWins9hNmTMmCKIM+ymmB1WSfc9sbN7Tl1kkRiNZPUEScZLWfiFjtj
	fqETVTyZjn7eA0iZO4eLDKi148BjOZiw5l4C4z/VUuwu7khP9lZE1MAUfvo4Emr6HPMUyy8D8p4
	hf9/hY2QVg/shgnRm2ee7HhtADyYSl6M8+Fn1n0zoxn7p4h1Xtn99p/fwBJmj4zdhg4djk8Kl6u
	RG1lqpTMHih2x3D3LVx/6yu4XqupYe0UkJEQu6mML2CZZBIG9egOoI7PHKXoM3i0P3yba8cYbbI
	F2HAWidrqygtI48nqmTh8xeGAr+p9JSGwU0=
X-Received: by 2002:a05:600c:190e:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-467f110c6a3mr74432885e9.34.1758491900623;
        Sun, 21 Sep 2025 14:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZhnClwPAwR5xViljaEF+jBOtb9636LrOTIvaX9QGvNcDRrDYALPuXSdkd+RDVbBCGffKBhQ==
X-Received: by 2002:a05:600c:190e:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-467f110c6a3mr74432765e9.34.1758491900048;
        Sun, 21 Sep 2025 14:58:20 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d7a566a27sm8184295e9.20.2025.09.21.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:58:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:58:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 8/9] vdpa: introduce map ops
Message-ID: <20250921175704-mutt-send-email-mst@kernel.org>
References: <20250821064641.5025-1-jasowang@redhat.com>
 <20250821064641.5025-9-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821064641.5025-9-jasowang@redhat.com>

On Thu, Aug 21, 2025 at 02:46:40PM +0800, Jason Wang wrote:
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
>  drivers/virtio/virtio_vdpa.c             |  4 +++-
>  include/linux/vdpa.h                     | 10 +++++++---
>  12 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 54aea086d08c..e476504db0c8 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -478,7 +478,8 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  
>  	eni_vdpa = vdpa_alloc_device(struct eni_vdpa, vdpa,
> -				     dev, &eni_vdpa_ops, 1, 1, NULL, false);
> +				     dev, &eni_vdpa_ops, NULL,
> +				     1, 1, NULL, false);
>  	if (IS_ERR(eni_vdpa)) {
>  		ENI_ERR(pdev, "failed to allocate vDPA structure\n");
>  		return PTR_ERR(eni_vdpa);
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 979d188d74ee..6658dc74d915 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -705,7 +705,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	vf = &ifcvf_mgmt_dev->vf;
>  	pdev = vf->pdev;
>  	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> -				    &pdev->dev, &ifc_vdpa_ops, 1, 1, NULL, false);
> +				    &pdev->dev, &ifc_vdpa_ops,
> +				    NULL, 1, 1, NULL, false);
>  	if (IS_ERR(adapter)) {
>  		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>  		return PTR_ERR(adapter);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index a7e76f175914..82034efb74fc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3882,7 +3882,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	}
>  
>  	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
> -				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
> +				 NULL, MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
>  	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index 5818dae133a3..9e8d07078606 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -508,8 +508,8 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	u64 device_features;
>  	int ret;
>  
> -	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops, 1, 1,
> -				     NULL, false);
> +	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops,
> +				     NULL, 1, 1, NULL, false);
>  	if (IS_ERR(oct_vdpa)) {
>  		dev_err(&pdev->dev, "Failed to allocate vDPA structure for octep vdpa device");
>  		return PTR_ERR(oct_vdpa);
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 63d82263fb52..36f61cc96e21 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -632,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	}
>  
>  	pdsv = vdpa_alloc_device(struct pds_vdpa_device, vdpa_dev,
> -				 dev, &pds_vdpa_ops, 1, 1, name, false);
> +				 dev, &pds_vdpa_ops, NULL,
> +				 1, 1, name, false);
>  	if (IS_ERR(pdsv)) {
>  		dev_err(dev, "Failed to allocate vDPA structure: %pe\n", pdsv);
>  		return PTR_ERR(pdsv);
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 39050aab147f..4588211d57eb 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -1008,8 +1008,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
>  	}
>  
>  	/* Allocate vdpa device */
> -	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops, 1, 1, NULL,
> -				 false);
> +	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops,
> +				 NULL, 1, 1, NULL, false);
>  	if (!snet) {
>  		SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c71debeb8471..ec4cb0162849 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -142,6 +142,7 @@ static void vdpa_release_dev(struct device *d)
>   * initialized but before registered.
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> + * @map: the map opeartions that is supported by this device

operations

>   * @ngroups: number of groups supported by this device
>   * @nas: number of address spaces supported by this device
>   * @size: size of the parent structure that contains private data
> @@ -156,6 +157,7 @@ static void vdpa_release_dev(struct device *d)
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> +					const struct virtio_map_ops *map,
>  					unsigned int ngroups, unsigned int nas,
>  					size_t size, const char *name,
>  					bool use_va)
> @@ -187,6 +189,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  	vdev->dev.release = vdpa_release_dev;
>  	vdev->index = err;
>  	vdev->config = config;
> +	vdev->map = map;
>  	vdev->features_valid = false;
>  	vdev->use_va = use_va;
>  	vdev->ngroups = ngroups;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 22ee53538444..c1c6431950e1 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -215,7 +215,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>  	else
>  		ops = &vdpasim_config_ops;
>  
> -	vdpa = __vdpa_alloc_device(NULL, ops,
> +	vdpa = __vdpa_alloc_device(NULL, ops, NULL,
>  				   dev_attr->ngroups, dev_attr->nas,
>  				   dev_attr->alloc_size,
>  				   dev_attr->name, use_va);
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f68ed569394c..ad782d20a8ed 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2009,7 +2009,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  		return -EEXIST;
>  
>  	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -				 &vduse_vdpa_config_ops, 1, 1, name, true);
> +				 &vduse_vdpa_config_ops, NULL,
> +				 1, 1, name, true);
>  	if (IS_ERR(vdev))
>  		return PTR_ERR(vdev);
>  
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 242641c0f2bd..17a19a728c9c 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -511,7 +511,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	int ret, i;
>  
>  	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> -				    dev, &vp_vdpa_ops, 1, 1, name, false);
> +				    dev, &vp_vdpa_ops, NULL,
> +				    1, 1, name, false);
>  
>  	if (IS_ERR(vp_vdpa)) {
>  		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 8b27c6e8eebb..2464fa655f09 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -466,9 +466,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
>  	if (!vd_dev)
>  		return -ENOMEM;
>  
> -	vd_dev->vdev.dev.parent = vdpa_get_map(vdpa).dma_dev;
> +	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
> +				  vdpa_get_map(vdpa).dma_dev;
>  	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
>  	vd_dev->vdev.config = &virtio_vdpa_config_ops;
> +	vd_dev->vdev.map = vdpa->map;
>  	vd_dev->vdpa = vdpa;
>  
>  	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index ae0451945851..4cf21d6e9cfd 100644
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
>  	union virtio_map vmap;
>  	const char *driver_override;
>  	const struct vdpa_config_ops *config;
> +	const struct virtio_map_ops *map;
>  	struct rw_semaphore cf_lock; /* Protects get/set config */
>  	unsigned int index;
>  	bool features_valid;
> @@ -447,6 +449,7 @@ struct vdpa_config_ops {
>  
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> +					const struct virtio_map_ops *map,
>  					unsigned int ngroups, unsigned int nas,
>  					size_t size, const char *name,
>  					bool use_va);
> @@ -458,6 +461,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   * @member: the name of struct vdpa_device within the @dev_struct
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> + * @map: the map operations that is supported by this device
>   * @ngroups: the number of virtqueue groups supported by this device
>   * @nas: the number of address spaces
>   * @name: name of the vdpa device
> @@ -465,10 +469,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   *
>   * Return allocated data structure or ERR_PTR upon error
>   */
> -#define vdpa_alloc_device(dev_struct, member, parent, config, ngroups, nas, \
> -			  name, use_va) \
> +#define vdpa_alloc_device(dev_struct, member, parent, config, map, \
> +			  ngroups, nas, name, use_va)		   \
>  			  container_of((__vdpa_alloc_device( \
> -				       parent, config, ngroups, nas, \
> +				       parent, config, map, ngroups, nas, \
>  				       (sizeof(dev_struct) + \
>  				       BUILD_BUG_ON_ZERO(offsetof( \
>  				       dev_struct, member))), name, use_va)), \
> -- 
> 2.31.1


