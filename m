Return-Path: <linux-kernel+bounces-858021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BEBE8978
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A274258A2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09BD19DF9A;
	Fri, 17 Oct 2025 12:31:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50241A945
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704261; cv=none; b=YKjF1K0JYK9IN11FAOQ+S3eMwNpy76nXqsuSrkM7EbOn2unPCZ9UcPWc88Y2TWbp8rsY17PY/dFzZFPOj8eEkQTQVURY2Kwj9XoCRPhDL5ErzHujqi1aPvZRSwDcbYqFu9HML8x5wU+AUuQAb7e7eAUZYC+IycY1HEeo/esQkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704261; c=relaxed/simple;
	bh=/MvpjTLYlH+NLtmEfrnY/OzAD5B2fF35yAP/92YVjGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1xGapQo8zNkhezrnGpFYAFGJBc3KofJLLR2QCCwApWOmZmYTeAHCyUMVCYRalv884Wd9If+VjkjabLtjAdCQOfI5YYp4KghQ8Pp0Poaso3j4uXt6C68DOZXlJpCIhl+wk3E1+MmTsfFyBN11Cftj1aWfGwIW06iju1HbYFo8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D503D1595
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:30:50 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82E4A3F59E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:30:58 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:30:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix kernel panic on partial unmap of a GPU
 VA region
Message-ID: <aPI2_bQKC8HxV4Bt@e110455-lin.cambridge.arm.com>
References: <20251017102922.670084-1-akash.goel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017102922.670084-1-akash.goel@arm.com>

On Fri, Oct 17, 2025 at 11:29:22AM +0100, Akash Goel wrote:
> This commit address a kernel panic issue that can happen if Userspace
> tries to partially unmap a GPU virtual region (aka drm_gpuva).
> The VM_BIND interface allows partial unmapping of a BO.
> 
> Panthor driver pre-allocates memory for the new drm_gpuva structures
> that would be needed for the map/unmap operation, done using drm_gpuvm
> layer. It expected that only one new drm_gpuva would be needed on umap
> but a partial unmap can require 2 new drm_gpuva and that's why it
> ended up doing a NULL pointer dereference causing a kernel panic.
> 
> Following dump was seen when partial unmap was exercised.
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000078
>  Mem abort info:
>    ESR = 0x0000000096000046
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
>    CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=000000088a863000
>  [000000000000078] pgd=080000088a842003, p4d=080000088a842003, pud=0800000884bf5003, pmd=0000000000000000
>  Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
>  <snip>
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : panthor_gpuva_sm_step_remap+0xe4/0x330 [panthor]
>  lr : panthor_gpuva_sm_step_remap+0x6c/0x330 [panthor]
>  sp : ffff800085d43970
>  x29: ffff800085d43970 x28: ffff00080363e440 x27: ffff0008090c6000
>  x26: 0000000000000030 x25: ffff800085d439f8 x24: ffff00080d402000
>  x23: ffff800085d43b60 x22: ffff800085d439e0 x21: ffff00080abdb180
>  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000010
>  x17: 6e656c202c303030 x16: 3666666666646466 x15: 393d61766f69202c
>  x14: 312d3d7361203a70 x13: 303030323d6e656c x12: ffff80008324bf58
>  x11: 0000000000000003 x10: 0000000000000002 x9 : ffff8000801a6a9c
>  x8 : ffff00080360b300 x7 : 0000000000000000 x6 : 000000088aa35fc7
>  x5 : fff1000080000000 x4 : ffff8000842ddd30 x3 : 0000000000000001
>  x2 : 0000000100000000 x1 : 0000000000000001 x0 : 0000000000000078
>  Call trace:
>   panthor_gpuva_sm_step_remap+0xe4/0x330 [panthor]
>   op_remap_cb.isra.22+0x50/0x80
>   __drm_gpuvm_sm_unmap+0x10c/0x1c8
>   drm_gpuvm_sm_unmap+0x40/0x60
>   panthor_vm_exec_op+0xb4/0x3d0 [panthor]
>   panthor_vm_bind_exec_sync_op+0x154/0x278 [panthor]
>   panthor_ioctl_vm_bind+0x160/0x4a0 [panthor]
>   drm_ioctl_kernel+0xbc/0x138
>   drm_ioctl+0x240/0x500
>   __arm64_sys_ioctl+0xb0/0xf8
>   invoke_syscall+0x4c/0x110
>   el0_svc_common.constprop.1+0x98/0xf8
>   do_el0_svc+0x24/0x38
>   el0_svc+0x40/0xf8
>   el0t_64_sync_handler+0xa0/0xc8
>   el0t_64_sync+0x174/0x178
> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Do we need a Fixes tag here?

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e378..7870e7dbaa5d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1175,10 +1175,14 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
>  		break;
>  
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
> -		/* Partial unmaps might trigger a remap with either a prev or a next VA,
> -		 * but not both.
> +		/* Two VMAs can be needed for an unmap, as an unmap can happen
> +		 * in the middle of a drm_gpuva, requiring a remap with both
> +		 * prev & next VA. Or an unmap can span more than one drm_gpuva
> +		 * where the first and last ones are covered partially, requring
> +		 * a remap for the first with a prev VA and remap for the last
> +		 * with a next VA.
>  		 */
> -		vma_count = 1;
> +		vma_count = 2;
>  		break;
>  
>  	default:
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

