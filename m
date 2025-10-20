Return-Path: <linux-kernel+bounces-861846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EBBF3CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952394EF462
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA021C16E;
	Mon, 20 Oct 2025 22:00:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBE28BA95
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997613; cv=none; b=Obss2U+LOZMQLU3pwebYsZUfjnXsiX6yCo30A8150/q9bnXEACm5IejYJtQ/a2mGtXok/w+KmRdrVWuGGeK4Z0jqMCVAyIyoCy6DJeXSYFk1NjrBKiL/nTA99reazGi37L9Y7f94vGerBpdkMIA8+bvEAYwqckgxmJR7Ur2s2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997613; c=relaxed/simple;
	bh=L679A6msYvHUkm/JwWRb7m0hy/SGgv6lgw6Wc6utwDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eatJ1F9xvU+iNkOq4xRoBICPRjAD+6V0blAm7W5i581qkhbiZIPB2NrNj8+I5zKUKYpKHulruu3DtDOe/nCiXFbTnQ355p/U3znhSNhNQq5srLXiucCnrvrOUKmpJ2sHfw2Ojwc0f1tstgjfjfBfhTe9UEPBrXROkEVT7l9obro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902AC1007
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:00:01 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 372563F63F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:00:09 -0700 (PDT)
Date: Mon, 20 Oct 2025 22:59:55 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH v2] drm/panthor: Fix potential memleak of vma structure
Message-ID: <aPaw236x57tWohC6@e110455-lin.cambridge.arm.com>
References: <20251020200243.1324045-1-akash.goel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020200243.1324045-1-akash.goel@arm.com>

On Mon, Oct 20, 2025 at 09:02:43PM +0100, Akash Goel wrote:
> This commit addresses a memleak issue of panthor_vma (or drm_gpuva)
> structure in Panthor driver, that can happen if the GPU page table
> update operation to map the pages fail.
> The issue is very unlikely to occur in practice.
> 
> v2: Add panthor_vm_op_ctx_return_vma() helper (Boris)
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e378..63af8ee89b08 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1146,6 +1146,18 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	}
>  }
>  
> +static void
> +panthor_vm_op_ctx_return_vma(struct panthor_vm_op_ctx *op_ctx,
> +			     struct panthor_vma *vma)
> +{
> +	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++) {
> +		if (!op_ctx->preallocated_vmas[i]) {
> +			op_ctx->preallocated_vmas[i] = vma;
> +			return;
> +		}
> +	}
> +}
> +
>  static struct panthor_vma *
>  panthor_vm_op_ctx_get_vma(struct panthor_vm_op_ctx *op_ctx)
>  {
> @@ -2081,8 +2093,10 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
>  				   op_ctx->map.sgt, op->map.gem.offset,
>  				   op->map.va.range);
> -	if (ret)
> +	if (ret) {
> +		panthor_vm_op_ctx_return_vma(op_ctx, vma);
>  		return ret;
> +	}
>  
>  	/* Ref owned by the mapping now, clear the obj field so we don't release the
>  	 * pinning/obj ref behind GPUVA's back.
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

