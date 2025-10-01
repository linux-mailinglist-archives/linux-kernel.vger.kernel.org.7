Return-Path: <linux-kernel+bounces-838754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7BBB0138
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EFB1941D84
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951192C11CF;
	Wed,  1 Oct 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pRaCq5CS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642A2264C0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316327; cv=none; b=Fkq+nk2+mMsP0bKG1fCGSY/YgdS0hSLXtHcHfY/gLvRe5F4FkE4BSjOV7q/Tr0S2kzB5G/h610a49Jcnti1ORNRLGfI6ra0Rnd8m0t8FciRxk6kjOavudCfR7gRn/2QvJmPWu95tcK4LU8djTy7JWggfSi3+WFmgrY450VqSwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316327; c=relaxed/simple;
	bh=0w3Jyk0rJng/IrgFEfWRqEdtug1v7WMnBStu3ORBxWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSyUB9X9Ha6TyoFmDOeFgq6PBz7AG8ISgvOLkmS6ri6WLEPZxxxaaE+7x7/r0PhT7RPHKtH5EuzN0K+14GerF3mnsiv3/i1hkI5dZ6M4XyHkf66hxdSvwiHpuVq3HIFNi4HfanM/1hxwb3TVsdDC65BimC4vZrw7L/nyahRzs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pRaCq5CS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759316323;
	bh=0w3Jyk0rJng/IrgFEfWRqEdtug1v7WMnBStu3ORBxWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pRaCq5CScn+5ZHLaSoijyNq3koeUC6kPqNeM/Pn489elk8ieFTMqkJQqwZfDN3BJl
	 dtE3wOnnMoaqXQp0zRD+brackwQd83ZXNYvgcq6it5P5fPfIf+C6wwzGJGsA3BHlMl
	 Feu32KNld8ct1nWws+Ck8UrD6KgPBcrMeHaLLmwDEWgrA3ASQglH8yd7hSid2r7sU9
	 AaS7zn1M6jZ5k7sdUiOOAUBDwYzTqHqb9JNz3wvZ7FB9gxSD2JK/UM0CN4B0X6+ds4
	 2RUzHeD12EePKoM6iuAPEdasT0GbtCIOo9hYMYg9vyBtvpl0p0mPqA7eLbyuoblBm1
	 iQjdiEo+Xlhkg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6506B17E107D;
	Wed,  1 Oct 2025 12:58:43 +0200 (CEST)
Date: Wed, 1 Oct 2025 12:58:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v4 05/10] drm/panfrost: Handle page mapping failure
Message-ID: <20251001125838.10200ff2@fedora>
In-Reply-To: <20251001022039.1215976-6-adrian.larumbe@collabora.com>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
	<20251001022039.1215976-6-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  1 Oct 2025 03:20:26 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When mapping the pages of a BO, either a heap type at page fault time or
> else a non-heap BO at object creation time, if the ARM page table mapping
> function fails, we unmap what had been mapped so far and bail out.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 49 ++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index cf272b167feb..fb17c32855a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -393,13 +393,32 @@ static void panfrost_mmu_flush_range(struct panfros=
t_device *pfdev,
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
>  }
> =20
> +static void mmu_unmap_range(struct panfrost_mmu *mmu, u64 iova, size_t l=
en)
> +{
> +	struct io_pgtable_ops *ops =3D mmu->pgtbl_ops;
> +	size_t pgsize, unmapped_len =3D 0;
> +	size_t unmapped_page, pgcount;
> +
> +	while (unmapped_len < len) {
> +		pgsize =3D get_pgsize(iova, len - unmapped_len, &pgcount);
> +
> +		unmapped_page =3D ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
> +		WARN_ON(unmapped_page !=3D pgsize * pgcount);
> +
> +		iova +=3D pgsize * pgcount;
> +		unmapped_len +=3D pgsize * pgcount;
> +	}
> +}
> +
>  static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu=
 *mmu,
>  		      u64 iova, int prot, struct sg_table *sgt)
>  {
>  	unsigned int count;
>  	struct scatterlist *sgl;
>  	struct io_pgtable_ops *ops =3D mmu->pgtbl_ops;
> +	size_t total_mapped =3D 0;
>  	u64 start_iova =3D iova;
> +	int ret;
> =20
>  	for_each_sgtable_dma_sg(sgt, sgl, count) {
>  		unsigned long paddr =3D sg_dma_address(sgl);
> @@ -413,10 +432,14 @@ static int mmu_map_sg(struct panfrost_device *pfdev=
, struct panfrost_mmu *mmu,
>  			size_t pgcount, mapped =3D 0;
>  			size_t pgsize =3D get_pgsize(iova | paddr, len, &pgcount);
> =20
> -			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
> +			ret =3D ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
>  				       GFP_KERNEL, &mapped);
> +			if (ret)
> +				goto err_unmap_pages;
> +
>  			/* Don't get stuck if things have gone wrong */
>  			mapped =3D max(mapped, pgsize);
> +			total_mapped +=3D mapped;
>  			iova +=3D mapped;
>  			paddr +=3D mapped;
>  			len -=3D mapped;
> @@ -426,6 +449,10 @@ static int mmu_map_sg(struct panfrost_device *pfdev,=
 struct panfrost_mmu *mmu,
>  	panfrost_mmu_flush_range(pfdev, mmu, start_iova, iova - start_iova);
> =20
>  	return 0;
> +
> +err_unmap_pages:
> +	mmu_unmap_range(mmu, start_iova, total_mapped);
> +	return ret;
>  }
> =20
>  int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
> @@ -436,6 +463,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *map=
ping)
>  	struct panfrost_device *pfdev =3D to_panfrost_device(obj->dev);
>  	struct sg_table *sgt;
>  	int prot =3D IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
> +	int ret;
> =20
>  	if (WARN_ON(mapping->active))
>  		return 0;
> @@ -447,11 +475,18 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *m=
apping)
>  	if (WARN_ON(IS_ERR(sgt)))
>  		return PTR_ERR(sgt);
> =20
> -	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
> -		   prot, sgt);
> +	ret =3D mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_S=
HIFT,
> +			 prot, sgt);
> +	if (ret)
> +		goto err_put_pages;
> +
>  	mapping->active =3D true;
> =20
>  	return 0;
> +
> +err_put_pages:
> +	drm_gem_shmem_put_pages_locked(shmem);
> +	return ret;
>  }
> =20
>  void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
> @@ -635,8 +670,10 @@ static int panfrost_mmu_map_fault_addr(struct panfro=
st_device *pfdev, int as,
>  	if (ret)
>  		goto err_map;
> =20
> -	mmu_map_sg(pfdev, bomapping->mmu, addr,
> -		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
> +	ret =3D mmu_map_sg(pfdev, bomapping->mmu, addr,
> +			 IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
> +	if (ret)
> +		goto err_mmu_map_sg;
> =20
>  	bomapping->active =3D true;
>  	bo->heap_rss_size +=3D SZ_2M;
> @@ -650,6 +687,8 @@ static int panfrost_mmu_map_fault_addr(struct panfros=
t_device *pfdev, int as,
> =20
>  	return 0;
> =20
> +err_mmu_map_sg:
> +	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);

You also need to clear the sgts[]/pages[] entries you added earlier,
otherwise the next time you have a fault it will bail-out before
attempting an mmu_map_sg().

IIRC, Dmitry had a similar fix in his shmem-shrinker series.

>  err_map:
>  	sg_free_table(sgt);
>  err_unlock:


