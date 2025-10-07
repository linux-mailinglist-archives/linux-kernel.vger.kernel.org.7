Return-Path: <linux-kernel+bounces-843900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E8BC0860
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF84F3546
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0A62561AE;
	Tue,  7 Oct 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T0Ova/rT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CB3B7A8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823498; cv=none; b=AhEXFdCoXJXos3Bkn3hTHbnShooHaQyyWUEDoZuzonk0bMQFrJfcLQteMBqAUs+dWI0m1cl3JsdQ8/Zw7HGeI3tIuqmTqbDgOXfyw/D92polGfIBQ1FwiuU644ZxSpVdl1JKMEKBnyIvjerSPzByJm/HRqQO4R/Kw3YJc/oOHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823498; c=relaxed/simple;
	bh=jtlAVfGzfku4KQ5w/lZHgUeem7ejLjYVd1EcDRbBCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHbvii/XQksSk+ZxnD2qBP1yu3UgwRLO+OJ2vc9e8dytJmbnOBks+koiUdCsutqFtoOwGDmGqSKps13DPjTx51S/Qn5YYTycTHWVt4BRWP2DiZi7Aq0+kloyDeqbJAn1juSJLWWUdWuT5yvl4nIXEDLS3e2M+h5meCK00zpJkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T0Ova/rT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759823494;
	bh=jtlAVfGzfku4KQ5w/lZHgUeem7ejLjYVd1EcDRbBCvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0Ova/rTvIPqkwbTuBELG4YGvv6W8lA8DaP/bVCkhQiCpT9EPccCxOZvWsBtiH1bP
	 kMpXvAFSQpSwzi6/vdPRuNaMIEwdgcUJ+QOOWR+k5HhqrDv0qFvGch/tf9ukFOPQwA
	 4BSnYcHhRnSIBf2abeCS1dSkYXk2kYDW0SPBigBmCv2YdGPg+ieaoQ8w52VVEMV6CT
	 NI5AsF3tdnmk/1aHNvWmpK53Ne2eTO5rZKIONDB93xnVhf/zb28RWOcg18BatFzm5z
	 ClVJk9KSqzf4/gVfxcrSLqGeCa0882nwzzG+S4oP31rX560sW1UJ855eQBzZo59/3f
	 odIn30a5XFaNA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB5F117E124A;
	Tue,  7 Oct 2025 09:51:33 +0200 (CEST)
Date: Tue, 7 Oct 2025 09:51:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v4 05/10] drm/panfrost: Handle page mapping failure
Message-ID: <20251007095129.4b0e88a8@fedora>
In-Reply-To: <42bsn4ngim6aucg5pzcs4knpvwn6bbvud7lf22tr7kmrdrgphm@vncex4yi2oc6>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
	<20251001022039.1215976-6-adrian.larumbe@collabora.com>
	<20251001125838.10200ff2@fedora>
	<42bsn4ngim6aucg5pzcs4knpvwn6bbvud7lf22tr7kmrdrgphm@vncex4yi2oc6>
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

On Tue, 7 Oct 2025 02:04:00 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Hi Boris,
>=20
> On 01.10.2025 12:58, Boris Brezillon wrote:
> > On Wed,  1 Oct 2025 03:20:26 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > =20
> > > When mapping the pages of a BO, either a heap type at page fault time=
 or
> > > else a non-heap BO at object creation time, if the ARM page table map=
ping
> > > function fails, we unmap what had been mapped so far and bail out.
> > >
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_mmu.c | 49 ++++++++++++++++++++++-=
--
> > >  1 file changed, 44 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/dr=
m/panfrost/panfrost_mmu.c
> > > index cf272b167feb..fb17c32855a5 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > > @@ -393,13 +393,32 @@ static void panfrost_mmu_flush_range(struct pan=
frost_device *pfdev,
> > >  	pm_runtime_put_autosuspend(pfdev->base.dev);
> > >  }
> > >
> > > +static void mmu_unmap_range(struct panfrost_mmu *mmu, u64 iova, size=
_t len)
> > > +{
> > > +	struct io_pgtable_ops *ops =3D mmu->pgtbl_ops;
> > > +	size_t pgsize, unmapped_len =3D 0;
> > > +	size_t unmapped_page, pgcount;
> > > +
> > > +	while (unmapped_len < len) {
> > > +		pgsize =3D get_pgsize(iova, len - unmapped_len, &pgcount);
> > > +
> > > +		unmapped_page =3D ops->unmap_pages(ops, iova, pgsize, pgcount, NUL=
L);
> > > +		WARN_ON(unmapped_page !=3D pgsize * pgcount);
> > > +
> > > +		iova +=3D pgsize * pgcount;
> > > +		unmapped_len +=3D pgsize * pgcount;
> > > +	}
> > > +}
> > > +
> > >  static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost=
_mmu *mmu,
> > >  		      u64 iova, int prot, struct sg_table *sgt)
> > >  {
> > >  	unsigned int count;
> > >  	struct scatterlist *sgl;
> > >  	struct io_pgtable_ops *ops =3D mmu->pgtbl_ops;
> > > +	size_t total_mapped =3D 0;
> > >  	u64 start_iova =3D iova;
> > > +	int ret;
> > >
> > >  	for_each_sgtable_dma_sg(sgt, sgl, count) {
> > >  		unsigned long paddr =3D sg_dma_address(sgl);
> > > @@ -413,10 +432,14 @@ static int mmu_map_sg(struct panfrost_device *p=
fdev, struct panfrost_mmu *mmu,
> > >  			size_t pgcount, mapped =3D 0;
> > >  			size_t pgsize =3D get_pgsize(iova | paddr, len, &pgcount);
> > >
> > > -			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
> > > +			ret =3D ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
> > >  				       GFP_KERNEL, &mapped);
> > > +			if (ret)
> > > +				goto err_unmap_pages;
> > > +
> > >  			/* Don't get stuck if things have gone wrong */
> > >  			mapped =3D max(mapped, pgsize);
> > > +			total_mapped +=3D mapped;
> > >  			iova +=3D mapped;
> > >  			paddr +=3D mapped;
> > >  			len -=3D mapped;
> > > @@ -426,6 +449,10 @@ static int mmu_map_sg(struct panfrost_device *pf=
dev, struct panfrost_mmu *mmu,
> > >  	panfrost_mmu_flush_range(pfdev, mmu, start_iova, iova - start_iova);
> > >
> > >  	return 0;
> > > +
> > > +err_unmap_pages:
> > > +	mmu_unmap_range(mmu, start_iova, total_mapped);
> > > +	return ret;
> > >  }
> > >
> > >  int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
> > > @@ -436,6 +463,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping =
*mapping)
> > >  	struct panfrost_device *pfdev =3D to_panfrost_device(obj->dev);
> > >  	struct sg_table *sgt;
> > >  	int prot =3D IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
> > > +	int ret;
> > >
> > >  	if (WARN_ON(mapping->active))
> > >  		return 0;
> > > @@ -447,11 +475,18 @@ int panfrost_mmu_map(struct panfrost_gem_mappin=
g *mapping)
> > >  	if (WARN_ON(IS_ERR(sgt)))
> > >  		return PTR_ERR(sgt);
> > >
> > > -	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
> > > -		   prot, sgt);
> > > +	ret =3D mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PA=
GE_SHIFT,
> > > +			 prot, sgt);
> > > +	if (ret)
> > > +		goto err_put_pages;
> > > +
> > >  	mapping->active =3D true;
> > >
> > >  	return 0;
> > > +
> > > +err_put_pages:
> > > +	drm_gem_shmem_put_pages_locked(shmem);
> > > +	return ret;
> > >  }
> > >
> > >  void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
> > > @@ -635,8 +670,10 @@ static int panfrost_mmu_map_fault_addr(struct pa=
nfrost_device *pfdev, int as,
> > >  	if (ret)
> > >  		goto err_map;
> > >
> > > -	mmu_map_sg(pfdev, bomapping->mmu, addr,
> > > -		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
> > > +	ret =3D mmu_map_sg(pfdev, bomapping->mmu, addr,
> > > +			 IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
> > > +	if (ret)
> > > +		goto err_mmu_map_sg;
> > >
> > >  	bomapping->active =3D true;
> > >  	bo->heap_rss_size +=3D SZ_2M;
> > > @@ -650,6 +687,8 @@ static int panfrost_mmu_map_fault_addr(struct pan=
frost_device *pfdev, int as,
> > >
> > >  	return 0;
> > >
> > > +err_mmu_map_sg:
> > > +	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0); =20
> >
> > You also need to clear the sgts[]/pages[] entries you added earlier,
> > otherwise the next time you have a fault it will bail-out before
> > attempting an mmu_map_sg().
> >
> > IIRC, Dmitry had a similar fix in his shmem-shrinker series. =20
>=20
> Went over the mailing list and I think the commit you had in mind was 1fc=
9af813b25 ("drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr=
()")
>=20
> I suspect there's a problem with the present code. If shmem_read_mapping_=
page() fails for let's say, page_offset+5, then when the interrupt is trigg=
ered
> again, because the page array had already been allocated and pages[page_o=
ffset] populated in the first try, then it would bail out immediately even =
though
> most pages haven't been retrieved yet.
>=20
> On the other hand, depopulating the array for the IRQ to be triggered aga=
in seems wasteful. Because for any virtual address, a fault will map all the
> pages within its 2MiB boundaries, maybe we could change
>=20
> if (pages[page_offset]) {
> 	/* Pages are already mapped, bail out. */
> 	goto out;
> }
>=20
> to 'pages[page_offset+NUM_FAULT_PAGES-1]'

Or, we simply don't check the
pages[page_offset..page_offset+NUM_FAULT_PAGES-1] range and we let
the following loop walk over all entries and fill the missing ones, if
any.

>=20
> And then, in the event that mmu_map_sg() fails:
>=20
> err_mmu_map_sg:
> 	pages[page_offset+NUM_FAULT_PAGES-1] =3D NULL;
> 	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
>=20
> So that it'll only fetch the very last page instead of all of them in cas=
e of a page fault reattempt.
>=20
> > >  err_map:
> > >  	sg_free_table(sgt);
> > >  err_unlock: =20
>=20
>=20
> Adrian Larumbe


