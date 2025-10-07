Return-Path: <linux-kernel+bounces-844504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69000BC2192
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B303B17A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC22E7F07;
	Tue,  7 Oct 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oy6JPO8y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD71DE2CC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854053; cv=none; b=OvhCH5cv04vkEfMhpMRIBFO/PlHkS+N7cF/JWalhbJdtEKdMeoArX5CsA0eLwoKGME+lIpAaSIfl3oTIw+nJpb3UqaZ5THhYfiYVdEZM8cycnqJtV9C5AeXXJsVPeRaBX2LgjvK0c3ys1THa1JYzTvI+ivoF4hLObDzboFWKnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854053; c=relaxed/simple;
	bh=2fEwLuPhzM8A+jG8Jh4BEEDphvVP+ZSL+92/amnexyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXtCDSFpXV6siQbdzvIbsljRw9k74dUiB4WmD8AhaUIkzc+mmG4FkAMO4o8wpvKSaesoXq/TC9rE3036rzHyaVtrpJi8qH4juGoJ+ggM3uQCEVh4I5hfFdHfQPSZAR3hPFp/ukhujib8FL/NAI/wnPYR+MCQ6cNn8cBWIQux1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oy6JPO8y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759854049;
	bh=2fEwLuPhzM8A+jG8Jh4BEEDphvVP+ZSL+92/amnexyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oy6JPO8y9XnNaLP4Sk2bewDlY3H1B6YQ3oKcRxbx4JLUnU03ACzvM1j0ougQicbFr
	 Fye+ajTW7ViIfU+jW3u43ZaU96Xvf61i1NECvmX/TH5jzk03SHgvM8jYUFgJ+y1fwn
	 Un1N3Q+3J0lIw/Xx+G2ALvYGS1qscIt1zIFCYNDzJ6esyIh6OvvpNCmz/MHGwCTBc4
	 AlGW0Ss2XAu0TR+u6W8Coa3w5FWLbOu+gi4MS02SJpenOA53UREIc9ipWhpQO9xRJs
	 jBYJYTEmX96Dc7Hns7CzdT/wcytmw6iPOYFeCDVWgOc2JwKzRH1R5C5q0Nqeh+UXHC
	 qBCyKDGtFZFVg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A5DE17E1310;
	Tue,  7 Oct 2025 18:20:48 +0200 (CEST)
Date: Tue, 7 Oct 2025 18:20:45 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v5 05/12] drm/panfrost: Check sgt to know whether pages
 are already mapped
Message-ID: <20251007182045.6a239bb8@fedora>
In-Reply-To: <20251007150216.254250-6-adrian.larumbe@collabora.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
	<20251007150216.254250-6-adrian.larumbe@collabora.com>
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

On Tue,  7 Oct 2025 16:01:47 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> In the MMU's page fault ISR for a heap object, determine whether the
> faulting address belongs to a 2MiB block that was already mapped by
> checking its corresponding sgt in the Panfrost BO.
>=20
> Also avoid retrieving pages from the shmem file if last one in the block
> was already present, as this means all of them had already been fetched.
>=20
> This is done in preparation for a future commit in which the MMU mapping
> helper might fail, but the page array is left populated, so this cannot
> be used as a check for an early bail-out.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 41 +++++++++++++++----------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index cf272b167feb..72864d0d478e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -600,32 +600,39 @@ static int panfrost_mmu_map_fault_addr(struct panfr=
ost_device *pfdev, int as,
>  		refcount_set(&bo->base.pages_use_count, 1);
>  	} else {
>  		pages =3D bo->base.pages;
> -		if (pages[page_offset]) {
> -			/* Pages are already mapped, bail out. */
> -			goto out;
> -		}
> +	}
> +
> +	sgt =3D &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
> +	if (sgt->sgl) {
> +		/* Pages are already mapped, bail out. */
> +		goto out;
>  	}
> =20
>  	mapping =3D bo->base.base.filp->f_mapping;
>  	mapping_set_unevictable(mapping);
> =20
> -	for (i =3D page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
> -		/* Can happen if the last fault only partially filled this
> -		 * section of the pages array before failing. In that case
> -		 * we skip already filled pages.
> +	if (!pages[page_offset + NUM_FAULT_PAGES - 1]) {
> +		/* Pages are retrieved sequentially, so if the very last
> +		 * one in the subset we want to map is already assigned, then
> +		 * there's no need to further iterate.
>  		 */

I don't think we care about optimizing the page range walk in the
unlikely case of a double fault on the same section, so I'd just keep
the existing loop unchanged.

> -		if (pages[i])
> -			continue;
> -
> -		pages[i] =3D shmem_read_mapping_page(mapping, i);
> -		if (IS_ERR(pages[i])) {
> -			ret =3D PTR_ERR(pages[i]);
> -			pages[i] =3D NULL;
> -			goto err_unlock;
> +		for (i =3D page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
> +			/* Can happen if the last fault only partially filled this
> +			 * section of the pages array before failing. In that case
> +			 * we skip already filled pages.
> +			 */
> +			if (pages[i])
> +				continue;
> +
> +			pages[i] =3D shmem_read_mapping_page(mapping, i);
> +			if (IS_ERR(pages[i])) {
> +				ret =3D PTR_ERR(pages[i]);
> +				pages[i] =3D NULL;
> +				goto err_unlock;
> +			}
>  		}
>  	}
> =20
> -	sgt =3D &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
>  	ret =3D sg_alloc_table_from_pages(sgt, pages + page_offset,
>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
>  	if (ret)

