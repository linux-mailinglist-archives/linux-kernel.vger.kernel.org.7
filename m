Return-Path: <linux-kernel+bounces-732099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCDCB061E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C11C20950
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724071E51EE;
	Tue, 15 Jul 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=caterina.shablia@collabora.com header.b="RXdpNAOs"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D241D63DF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590954; cv=pass; b=jlmGaY74H+UB0I1hNQelqvLU7PqN209e4pmfkp1nHxTqF+lS52kAjgLlh1XRUPPsMN6KygktDoFdIOdR4Q6Sfo+HJ7N5TJeExkxtaxnz2zGAqVOPklnq3DIvgycXoMpDG15COpQ0gCgTmXBdev2Uej2r4xFc4gyNiZNH52Rg/qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590954; c=relaxed/simple;
	bh=5EBGcUiAMGyeolaXvC1wiPMc24LLJhSntmMShjFiH5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjvvlp4n4/gEQwTdtmYLGXnqAwoRWnXYvPQn569ZaauQ3oWKEF0ZFDiQNAwnyCbQ4T+ziG3j+a1zLB757rXOgJSpmKKXJh25qUmplkGP1g/3hFKILrC6i54ONKZDqQcBC+e7oiZ6W/Ugw/jfmARB0ssn6YBEpojzKcRRdjs6CZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=caterina.shablia@collabora.com header.b=RXdpNAOs; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752590929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NLKS4l7nztxW21MIa6vh82w6apF0HOua5Qkdoh9PRNtE93kYvnEgj+wruyJ2hOTsdEdd/Pi4OFHAL5yKf3dTLjxt+Ws43SgaEmkbvBIIDB1csFz/8NmRArN6LT7G7MS3CQsb0sdaMhiFdZVSpsMFR7xv0PhaCOYV/HqHwv1e6bI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752590929; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xFVZ1c6WnKw4ORI58frXJc1W+Rm8JeEJu25qU2qDMtE=; 
	b=QG8/HMyAVQpYVD6I4rKCEOp8v2DJo/57nRsUQf2YWLcnppaetyxBaidDDa8tr53Qs7JyjpHOsGJVMnPwovtxjQCpe/bEWa0ILQXXmDk3t2vV3HgES320Jq8LwVhHh14Op5ILMRk/f8JjGKUUIyo474N0IkzYM8t8tL6z7Dr0TIE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=caterina.shablia@collabora.com;
	dmarc=pass header.from=<caterina.shablia@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752590929;
	s=zohomail; d=collabora.com; i=caterina.shablia@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=xFVZ1c6WnKw4ORI58frXJc1W+Rm8JeEJu25qU2qDMtE=;
	b=RXdpNAOshXyaTWeIuqgynTqFV7bbnyYpgn3AIS4gAb+shAz8CyWp9Al8KnQ3MCxm
	up640mI+WcKTnZFnP0p+Ld7muybq/DuMTTRZ0UfeBPcktFaxzViF/U76+Smdxh8CHQF
	IgT4l8Ek9N/dDC2Lmo3z+tCPaLVTadGjDmNckbj8=
Received: by mx.zohomail.com with SMTPS id 1752590927616603.6004449742125;
	Tue, 15 Jul 2025 07:48:47 -0700 (PDT)
From: Caterina Shablia <caterina.shablia@collabora.com>
To: Adrian Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/7] drm/panthor: Add support for atomic page table updates
Date: Tue, 15 Jul 2025 16:48:43 +0200
Message-ID: <2696295.fDdHjke4Dd@xps>
In-Reply-To: <5wxljw27mc4f2i6ag54upmpjxjj5odnd6d57fiiozpb3hjl4zi@okwx34aj56b6>
References:
 <20250703152908.16702-2-caterina.shablia@collabora.com>
 <20250703152908.16702-3-caterina.shablia@collabora.com>
 <5wxljw27mc4f2i6ag54upmpjxjj5odnd6d57fiiozpb3hjl4zi@okwx34aj56b6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

El viernes, 11 de julio de 2025 21:11:15 (hora de verano de Europa central)=
,=20
Adrian Larumbe escribi=C3=B3:
> Hi Caterina,
>=20
> On 03.07.2025 15:28, Caterina Shablia wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >=20
> > Move the lock/flush_mem operations around the gpuvm_sm_map() calls so
> > we can implement true atomic page updates, where any access in the
> > locked range done by the GPU has to wait for the page table updates
> > to land before proceeding.
> >=20
> > This is needed for vkQueueBindSparse(), so we can replace the dummy
> > page mapped over the entire object by actual BO backed pages in an atom=
ic
> > way.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
> > ---
> >=20
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 65 +++++++++++++++++++++++++--
> >  1 file changed, 62 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c
> > b/drivers/gpu/drm/panthor/panthor_mmu.c index b39ea6acc6a9..1e58948587a9
> > 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -387,6 +387,15 @@ struct panthor_vm {
> >=20
> >  	 * flagged as faulty as a result.
> >  	 */
> >  =09
> >  	bool unhandled_fault;
> >=20
> > +
> > +	/** @locked_region: Information about the currently locked region
> > currently. */
> Nit: delete second 'current'
>=20
> > +	struct {
> > +		/** @locked_region.start: Start of the locked region.=20
*/
> > +		u64 start;
> > +
> > +		/** @locked_region.size: Size of the locked region. */
> > +		u64 size;
> > +	} locked_region;
> >=20
> >  };
> > =20
> >  /**
> >=20
> > @@ -775,6 +784,10 @@ int panthor_vm_active(struct panthor_vm *vm)
> >=20
> >  	}
> >  =09
> >  	ret =3D panthor_mmu_as_enable(vm->ptdev, vm->as.id, transtab,=20
transcfg,
> >  	vm->memattr);>=20
> > +	if (!ret && vm->locked_region.size) {
> > +		lock_region(ptdev, vm->as.id, vm->locked_region.start,
> > vm->locked_region.size);
> Why do we need to lock the region after enabling a new AS?
See explanation further below for what happens in panthor_vm_lock_region. I=
n=20
short, we might poke vm_bind on a vm that's not active, locking a region.=20
Because vm is not active, there's nothing for us to do to lock the region,=
=20
beyond just specifying the region itself. If a vm in the meanwhile becomes=
=20
active while some region is locked, we'll need to inform the mmu about the=
=20
region that's supposed to be locked.=20
>=20
> > +		ret =3D wait_ready(ptdev, vm->as.id);
> > +	}
> >=20
> >  out_make_active:
> >  	if (!ret) {
> >=20
> > @@ -902,6 +915,9 @@ static int panthor_vm_unmap_pages(struct panthor_vm
> > *vm, u64 iova, u64 size)>=20
> >  	struct io_pgtable_ops *ops =3D vm->pgtbl_ops;
> >  	u64 offset =3D 0;
> >=20
> > +	drm_WARN_ON(&ptdev->base,
> > +		    (iova < vm->locked_region.start) ||
> > +		    (iova + size > vm->locked_region.start + vm-
>locked_region.size));
> >=20
> >  	drm_dbg(&ptdev->base, "unmap: as=3D%d, iova=3D%llx, len=3D%llx", vm-
>as.id,
> >  	iova, size);
> >  =09
> >  	while (offset < size) {
> >=20
> > @@ -915,13 +931,12 @@ static int panthor_vm_unmap_pages(struct panthor_=
vm
> > *vm, u64 iova, u64 size)>=20
> >  				iova + offset + unmapped_sz,
> >  				iova + offset + pgsize * pgcount,
> >  				iova, iova + size);
> >=20
> > -			panthor_vm_flush_range(vm, iova, offset +=20
unmapped_sz);
>=20
> We've removed all calls to panthor_vm_flush_range(), but I don't see it
> being done in panthor_vm_exec_op() before the region is unlocked. It's
> effectively become dead code.
>=20
> However, even if we did 'panthor_vm_flush_range(vm, op->va.addr,
> op->va.range);' in panthor_vm_exec_op() right before we unlock the region,
> we wouldn't be dealing well with the case in which only a partial unmap
> happens, but maybe this isn't a big deal either.
panthor_vm_unlock_region will do the necessary flushes.
>=20
> >  			return  -EINVAL;
> >  	=09
> >  		}
> >  		offset +=3D unmapped_sz;
> >  =09
> >  	}
> >=20
> > -	return panthor_vm_flush_range(vm, iova, size);
> > +	return 0;
> >=20
> >  }
> > =20
> >  static int
> >=20
> > @@ -938,6 +953,10 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 io=
va,
> > int prot,>=20
> >  	if (!size)
> >  =09
> >  		return 0;
> >=20
> > +	drm_WARN_ON(&ptdev->base,
> > +		    (iova < vm->locked_region.start) ||
> > +		    (iova + size > vm->locked_region.start + vm-
>locked_region.size));
> > +
> >=20
> >  	for_each_sgtable_dma_sg(sgt, sgl, count) {
> >  =09
> >  		dma_addr_t paddr =3D sg_dma_address(sgl);
> >  		size_t len =3D sg_dma_len(sgl);
> >=20
> > @@ -985,7 +1004,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 io=
va,
> > int prot,>=20
> >  		offset =3D 0;
> >  =09
> >  	}
> >=20
> > -	return panthor_vm_flush_range(vm, start_iova, iova - start_iova);
> >=20
> >=20
> > +	return 0;
> >=20
> >  }
> > =20
> >  static int flags_to_prot(u32 flags)
> >=20
> > @@ -1654,6 +1673,38 @@ static const char *access_type_name(struct
> > panthor_device *ptdev,>=20
> >  	}
> > =20
> >  }
> >=20
> > +static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64
> > size) +{
> > +	struct panthor_device *ptdev =3D vm->ptdev;
> > +	int ret;
> > +
> > +	mutex_lock(&ptdev->mmu->as.slots_lock);
> > +	drm_WARN_ON(&ptdev->base, vm->locked_region.start ||
> > vm->locked_region.size); +	vm->locked_region.start =3D start;
> > +	vm->locked_region.size =3D size;
> > +	if (vm->as.id >=3D 0) {
>=20
> I guess VM bind operations don't increase the active_cnt of a VM, so we
> might try to be mapping addresses from UM while no active groups are
> submitting jobs targetting this VM?
vm_bind, beyond locking the region, does not involve the gpu and is perform=
ed=20
entirely on host. If we were to try vm_binding while active_cnt is 0, we wo=
n't=20
poke the mmu to do any locking. Instead, when panthor_vm_active is poked to=
=20
make the vm active, we'll poke the mmu to actually lock the region supposed=
 to=20
be locked.
> > +		lock_region(ptdev, vm->as.id, start, size);
> > +		ret =3D wait_ready(ptdev, vm->as.id);
>=20
> I've noticed in mmu_hw_do_operation_locked() we don't do wait_ready() aft=
er
> locking the region. Is it missing or else maybe waiting for the AS to be
> locked isn't necessary here?
> > +	}
> > +	mutex_unlock(&ptdev->mmu->as.slots_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void panthor_vm_unlock_region(struct panthor_vm *vm)
> > +{
> > +	struct panthor_device *ptdev =3D vm->ptdev;
> > +
> > +	mutex_lock(&ptdev->mmu->as.slots_lock);
> > +	if (vm->as.id >=3D 0) {
> > +		write_cmd(ptdev, vm->as.id, AS_COMMAND_FLUSH_MEM);
>=20
> I guess this is why we no longer need to call panthor_vm_flush_range() ri=
ght
> before this function. Does AS_COMMAND_FLUSH_MEM only flush the locked
> region? Also, why not AS_COMMAND_FLUSH_PT instead?
IIUC FLUSH_MEM is less heavy of the two hammers. The doc says that it only=
=20
invalidates MMU caches when used without a previous LOCK, so I guess it doe=
s=20
something smarter in this case. FLUSH_PT invalidates MMU caches=20
unconditionally.
> > +		drm_WARN_ON(&ptdev->base, wait_ready(ptdev, vm-
>as.id));
> > +	}
> > +	vm->locked_region.start =3D 0;
> > +	vm->locked_region.size =3D 0;
> > +	mutex_unlock(&ptdev->mmu->as.slots_lock);
> > +}
> > +
> >=20
> >  static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32
> >  status) {
> > =20
> >  	bool has_unhandled_faults =3D false;
> >=20
> > @@ -2179,6 +2230,11 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct
> > panthor_vm_op_ctx *op,>=20
> >  	mutex_lock(&vm->op_lock);
> >  	vm->op_ctx =3D op;
> >=20
> > +
> > +	ret =3D panthor_vm_lock_region(vm, op->va.addr, op->va.range);
> > +	if (ret)
> > +		goto out;
> > +
> >=20
> >  	switch (op_type) {
> >  =09
> >  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
> >  		if (vm->unusable) {
> >=20
> > @@ -2199,6 +2255,9 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct
> > panthor_vm_op_ctx *op,>=20
> >  		break;
> >  =09
> >  	}
> >=20
> > +	panthor_vm_unlock_region(vm);
> > +
> >=20
> > +out:
> >  	if (ret && flag_vm_unusable_on_failure)
> >  =09
> >  		vm->unusable =3D true;
> >=20
> > --
> > 2.47.2
>=20
> Adrian Larumbe





