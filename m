Return-Path: <linux-kernel+bounces-843440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11027BBF2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CA13BE75B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A525B67D;
	Mon,  6 Oct 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eyt3CTvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB11DB12E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782389; cv=none; b=i5DdAAj5h17moR0W+wwvIBqt3j6SNfLXKOD2XNFWmdjqeUxAZSbWL5OeVhxXXjRC05WjV6AYqM/AnlejEaP+BgDh2XoJdEoHI078QfFyuvsBag2QNMX0SCK5GUJAzhFUD9lUf5hU7VHDkrH4XlOdfuO645/rCa3Zp20sGyjIXE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782389; c=relaxed/simple;
	bh=5Beem5LhWG2bilk8MDqU+q4h0wG6t2sV5MXJt1kmYfA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DNX3BkzrrA9mX2VQxp613UwK45XV6qrp6eemw9xFZYuyRN14q4g1namijDrNoe6/ki5Tu1PFW2GEmQ2PHhRGC+kaslNz1p4Z1Ah9WUtSr8CFLVcxPfRVB80C7TAJVi/LmZkeTPKS2YtH+CD0R8Q7Ar2/1neGGLh8foDAu4Ef0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eyt3CTvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15FFC4CEF5;
	Mon,  6 Oct 2025 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782389;
	bh=5Beem5LhWG2bilk8MDqU+q4h0wG6t2sV5MXJt1kmYfA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Eyt3CTvzcEGjpLFFsEoJD/B32md9OXuNWdgXu54GR1XZ7kecICvnh4+RxNWZtLjlB
	 CXREOcEWW/0Xei07PB+PS6UZLLJMZajf2EmR35yh6q/bfKMEgr/rgH0Evk6y8gbLYT
	 LH9DP7URVqQEk4GcGnwRhjAr38YEMsg2nOlN8c+WsnBqj8bBhunOzLlXHHkCbzLvus
	 cfty2L0oo6Tqt6PGsy6MDTcXLR3E54jUiXMBEI+mOiOaTNEjFwIpuP7fOpk6WQbs5Q
	 FjGjRePettfoFy9ABXqNtyrN9UOe63UsgJIQ4Uogkj2CTt9KboyPMl4pzvQKM3frky
	 uajfZz3uevGXQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 22:26:24 +0200
Message-Id: <DDBISJ2DUDF6.150HCB14ZRPH3@kernel.org>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, "Mary
 Guillemard" <mary@mary.zone>, "Faith Ekstrand"
 <faith.ekstrand@collabora.com>, "Lyude Paul" <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <nouveau@lists.freedesktop.org>
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
 <20251006191329.277485-3-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20251006191329.277485-3-mohamedahmedegypt2001@gmail.com>

On Mon Oct 6, 2025 at 9:13 PM CEST, Mohamed Ahmed wrote:
> From: Mary Guillemard <mary@mary.zone>
>
> Now that everything in UVMM knows about the variable page shift, we can
> select larger values.
>
> The proposed approach rely on nouveau_bo::page unless it would cause
> alignment issues (in which case we fall back to searching an appropriate
> shift)
>
> Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> Signed-off-by: Mary Guillemard <mary@mary.zone>

NIT: Both of your tags should come after Mary's tag. The same applied to so=
me of
the other patches.

> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 55 +++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index a92c729600d6..c336a121e320 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -454,6 +454,56 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
>  	drm_gpuva_insert(va->vm, va);
>  }
> =20
> +static bool
> +op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_=
shift)
> +{
> +	u64 page_size =3D 1ULL << page_shift;
> +
> +	return op->va.addr % page_size =3D=3D 0 && op->va.range % page_size =3D=
=3D 0 &&
> +		   op->gem.offset % page_size =3D=3D 0;
> +}
> +
> +static u8
> +select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *op=
)
> +{
> +	struct nouveau_bo *nvbo =3D nouveau_gem_object(op->gem.obj);
> +
> +	if (nvbo) {

In nouveau a struct drm_gpuva_op_map always has a valid GEM object set; we =
bail
out if userspace gives us an invalid GEM handle.

> +		/* If the BO preferred page shift already fits, use it. */
> +		if (op_map_aligned_to_page_shift(op, nvbo->page))
> +			return nvbo->page;
> +
> +		struct nouveau_mem *mem =3D nouveau_mem(nvbo->bo.resource);
> +		struct nvif_vmm *vmm =3D &uvmm->vmm.vmm;
> +		int i;
> +
> +		/* Otherwise let's find a granuality that will fit. */

Do we ever run into the "otherwise" case? nouveau_bo_fixup_align() seems to
already ensure that your previous call will never fail?

> +		for (i =3D 0; i < vmm->page_nr; i++) {
> +			/* Ignore anything that is bigger or identical to the BO preference. =
*/
> +			if (vmm->page[i].shift >=3D nvbo->page)
> +				continue;
> +
> +			/* Skip incompatible domains. */
> +			if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
> +				continue;
> +			if ((mem->mem.type & NVIF_MEM_HOST) &&
> +			    (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIFT))
> +				continue;
> +
> +			/* If it fits, return the proposed shift. */
> +			if (op_map_aligned_to_page_shift(op, vmm->page[i].shift))
> +				return vmm->page[i].shift;
> +		}
> +
> +		/* If we get here then nothing can reconcile the requirements. This sh=
ould never
> +		 * happen.
> +		 */
> +		WARN_ON(1);
> +	}
> +
> +	return PAGE_SHIFT;
> +}
> +
>  static void
>  nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
>  			       struct nouveau_uvma_prealloc *new,
> @@ -506,7 +556,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *u=
vmm,
>  			if (vmm_get_range)
>  				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
>  						     vmm_get_range,
> -						     PAGE_SHIFT);
> +						     select_page_shift(uvmm, &op->map));
>  			break;
>  		}
>  		case DRM_GPUVA_OP_REMAP: {
> @@ -636,7 +686,8 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>  		case DRM_GPUVA_OP_MAP: {
>  			u64 vmm_get_range =3D vmm_get_end - vmm_get_start;
> =20
> -			ret =3D op_map_prepare(uvmm, &new->map, &op->map, args, PAGE_SHIFT);
> +			ret =3D op_map_prepare(uvmm, &new->map, &op->map, args,
> +					     select_page_shift(uvmm, &op->map));

Let's move the call to select_page_shift() into op_map_prepare().

>  			if (ret)
>  				goto unwind;
> =20
> --=20
> 2.51.0


