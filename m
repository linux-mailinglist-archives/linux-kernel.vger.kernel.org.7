Return-Path: <linux-kernel+bounces-837544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC2BAC88F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1182C188E94A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841132FB08D;
	Tue, 30 Sep 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BcTwBBrW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC92222C0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228662; cv=none; b=VZvYueN3EZ7aXpVewUutwocnpJeSpaJZZkcNWIZrcW1yz+/+rwpnR0XFS038b1n1vXW4bErgbGijwglY+t1UaBzhsoD+wEsO5nNi21pHRKXfggMfDC124eXHgtH/6lvfFNmfl9gow9/i4Qv+HWqznvMFU/1S4aIv2ozqXsdDDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228662; c=relaxed/simple;
	bh=MMIyOgdHnuGM4uEoQQLpGnCP70/OAeedxU02J/5zTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWWhMiy7RO0KFL4MWRzzRQD+rCefhTH0X/t4kZ5EhAUZ5zCZubt5hjg3q15/vPg40mOR89wsbACXq8SUYh4jKmdrhhEkZMHbEmvzhHekC5YSIsBsOaSNp5HYibeqsiKMH8e8WOVYmIx5dogmXJcRUgqyT5Eyao6AK4UBX848O9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BcTwBBrW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759228659;
	bh=MMIyOgdHnuGM4uEoQQLpGnCP70/OAeedxU02J/5zTEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BcTwBBrW+yRD6eriWbZ42c2oQO0j0hHeqx5JV8UhHtjJWUIV9QhoSoxmg2XpIDyms
	 lz4tNqJJXoIRt/bUJ48xHdLS86A1CwPFTFHKkOzuulzseeIHYklcAYoKneep4Rs2A4
	 QamQa5Sp313UMIvSQGLQtKA5d9jkwmlKfKZr57hSEVSrLgNV48osU8VZP+O+RM7XaB
	 VpZrQl1XhODJLADRUsuW7dNaJOugL3bRX7qvCmoSOZhl1wp+cYo7nWgfct6opzmWKu
	 KKDbmEhiIKqKi2PsDE0Weo3zTPGgd38cpmHb3DB1ZeZSel/nuOIhaYysMN3VXUnGzA
	 skvbg3IV8yilA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 19E9417E124A;
	Tue, 30 Sep 2025 12:37:38 +0200 (CEST)
Date: Tue, 30 Sep 2025 12:37:32 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?B?TWlrb8WCYWo=?= Wasiak
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>, Nitin
 Gote <nitin.r.gote@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 7/8] drm/panthor: Improve IOMMU map/unmap debugging logs
Message-ID: <20250930123732.43e6987d@fedora>
In-Reply-To: <20250929200316.18417-8-loic.molinari@collabora.com>
References: <20250929200316.18417-1-loic.molinari@collabora.com>
	<20250929200316.18417-8-loic.molinari@collabora.com>
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

On Mon, 29 Sep 2025 22:03:15 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> Log the number of pages and their sizes actually mapped/unmapped by
> the IOMMU page table driver. Since a map/unmap op is often split in
> several ops depending on the underlying scatter/gather table, add the
> start address and the total size to the debugging logs in order to
> help understand which batch an op is part of.
>=20
> Signed-off-by: Lo=C3=AFc Molinari <loic.molinari@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 6dec4354e378..aefbd83d1a75 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -917,10 +917,9 @@ static int panthor_vm_unmap_pages(struct panthor_vm =
*vm, u64 iova, u64 size)
>  {
>  	struct panthor_device *ptdev =3D vm->ptdev;
>  	struct io_pgtable_ops *ops =3D vm->pgtbl_ops;
> +	u64 start_iova =3D iova;
>  	u64 offset =3D 0;
> =20
> -	drm_dbg(&ptdev->base, "unmap: as=3D%d, iova=3D%llx, len=3D%llx", vm->as=
.id, iova, size);
> -
>  	while (offset < size) {
>  		size_t unmapped_sz =3D 0, pgcount;
>  		size_t pgsize =3D get_pgsize(iova + offset, size - offset, &pgcount);
> @@ -935,6 +934,12 @@ static int panthor_vm_unmap_pages(struct panthor_vm =
*vm, u64 iova, u64 size)
>  			panthor_vm_flush_range(vm, iova, offset + unmapped_sz);
>  			return  -EINVAL;
>  		}
> +
> +		drm_dbg(&ptdev->base,
> +			"unmap: as=3D%d, iova=3D0x%llx, sz=3D%llu, va=3D0x%llx, pgcnt=3D%zu, =
pgsz=3D%zu",
> +			vm->as.id, start_iova, size, iova + offset,
> +			unmapped_sz / pgsize, pgsize);
> +
>  		offset +=3D unmapped_sz;
>  	}
> =20
> @@ -950,6 +955,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova,=
 int prot,
>  	struct scatterlist *sgl;
>  	struct io_pgtable_ops *ops =3D vm->pgtbl_ops;
>  	u64 start_iova =3D iova;
> +	u64 start_size =3D size;
>  	int ret;
> =20
>  	if (!size)
> @@ -969,15 +975,18 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iov=
a, int prot,
>  		len =3D min_t(size_t, len, size);
>  		size -=3D len;
> =20
> -		drm_dbg(&ptdev->base, "map: as=3D%d, iova=3D%llx, paddr=3D%pad, len=3D=
%zx",
> -			vm->as.id, iova, &paddr, len);
> -
>  		while (len) {
>  			size_t pgcount, mapped =3D 0;
>  			size_t pgsize =3D get_pgsize(iova | paddr, len, &pgcount);
> =20
>  			ret =3D ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
>  					     GFP_KERNEL, &mapped);
> +
> +			drm_dbg(&ptdev->base,
> +				"map: as=3D%d, iova=3D0x%llx, sz=3D%llu, va=3D0x%llx, pa=3D%pad, pgc=
nt=3D%zu, pgsz=3D%zu",
> +				vm->as.id, start_iova, start_size, iova, &paddr,
> +				mapped / pgsize, pgsize);
> +
>  			iova +=3D mapped;
>  			paddr +=3D mapped;
>  			len -=3D mapped;


