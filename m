Return-Path: <linux-kernel+bounces-844511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA10BC21BF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9175619A4771
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10B2E7F1A;
	Tue,  7 Oct 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="epid0kgt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CE2E764C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854264; cv=none; b=Pce17UJ00HkQaixRflExqp7+mchN/PLJ/62b/jImogcrR9+07PlKeQF0XGZl0WINmyyswqo+W/oSODayDwK6RsyYps7zsdkJIUJ5CCz0CnA+/Ic7J8EogTdCzvUN//usPOj9cDcVTez/4UZ232cJb301V3j329TtlPRYwi+vqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854264; c=relaxed/simple;
	bh=N2jrrUjF9P21IddG6XYQezsINgW8Y6de4YwQGMXwo+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqkBBuFrYL1xBjPnopPGHqDZg+FmcmeMSPmu6xpHMAPRo8Gm3xIk3rBm2LbdeVEk64jbbqBYIg5oU1kAgA7WCzofMl/BjR5vC/NEo8KZWOsldUR5+vN1vWf8dA6+E1iQMNtCkCdW8dVzXt33Ok3dy1VCh9rx5lmdUq0eU8/n7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=epid0kgt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759854257;
	bh=N2jrrUjF9P21IddG6XYQezsINgW8Y6de4YwQGMXwo+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epid0kgt6hFr+gAHRRo029lxP3uuEXAjSOuUTPP7vGDH99V071GaSXRj2saHGIQQk
	 ymK2RGpLdLlLeT8uzOpTmQkessV84Q8LyeD70v++QG5OQnD9q2IkMml5dgzstW/Ejd
	 Vn2xlxIflSFQMW6BVYoMcZCKpCGboR1nUsEWNTnUZBTKqTx3kFhufer375Vgkyguq8
	 89T4LPF7l+oA9lTO3udA4jwrP3qu1JwXSoo5hDCt4MFkJ8HzzczDoo7AIPKIr1iUKN
	 +5eUuguk3+KPV4B5N/0mqggzwB630hVQfiDufO1CZmtphz8wVgkg80OZVuJOepc0tO
	 4B6WN6etQo24A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7F3617E009B;
	Tue,  7 Oct 2025 18:24:16 +0200 (CEST)
Date: Tue, 7 Oct 2025 18:24:09 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v5 06/12] drm/panfrost: Handle page mapping failure
Message-ID: <20251007182409.43dde34d@fedora>
In-Reply-To: <20251007150216.254250-7-adrian.larumbe@collabora.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
	<20251007150216.254250-7-adrian.larumbe@collabora.com>
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

On Tue,  7 Oct 2025 16:01:48 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When mapping the pages of a BO, either a heap type at page fault time or
> else a non-heap BO at object creation time, if the ARM page table mapping
> function fails, we unmap what had been mapped so far and bail out.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 49 ++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 72864d0d478e..7bf386d25453 100644
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
> @@ -642,8 +677,10 @@ static int panfrost_mmu_map_fault_addr(struct panfro=
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
> @@ -657,6 +694,8 @@ static int panfrost_mmu_map_fault_addr(struct panfros=
t_device *pfdev, int as,
> =20
>  	return 0;
> =20
> +err_mmu_map_sg:
> +	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
>  err_map:
>  	sg_free_table(sgt);
>  err_unlock:


