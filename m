Return-Path: <linux-kernel+bounces-888295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3FC3A6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793483BFD7A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A92EC579;
	Thu,  6 Nov 2025 10:56:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864BF2EC0A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426560; cv=none; b=LHcSFECVcLl0gTGEK3XlxN0FzTYa4dWDE2h/Swku1U9p7xZKqCzHwq4j18WkS33eN43pyhx5ChyfdS+WvBSSf9wwJ9qQT2gX9KPA/+kf54nMef6l+tD8gh6lfUQAvS/894hSq0toiKH+QYVd6ZfNx0Ha32mrDRMbcq4PTLL498I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426560; c=relaxed/simple;
	bh=Bp7hKHhJ196hTLa5aJLM5KF8nAPwtR7PnplF+hIMtas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ifz1YNNj3Ty6cLE0ZQ7AxVl8jB7ti7i0o6JiUfsZODIsPQYAuWjjJgNWkd8Of4un4mSbCEpxX+6OuZ0k5gI0Z72nX9T/p2MUn+h8Y+ZIAhldlpKJkyWY6VpMkqtl10hskfblXaZJk0Jj7Eq5OYLHvRgDOznNTmeunDc7PiPHDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCAF71596;
	Thu,  6 Nov 2025 02:55:50 -0800 (PST)
Received: from [10.57.72.2] (unknown [10.57.72.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B233F63F;
	Thu,  6 Nov 2025 02:55:56 -0800 (PST)
Message-ID: <03800f70-684d-4dfc-82f7-aaf733ca1a19@arm.com>
Date: Thu, 6 Nov 2025 10:55:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panthor: Fix potential memleak of vma structure
To: Akash Goel <akash.goel@arm.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20251021081042.1377406-1-akash.goel@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251021081042.1377406-1-akash.goel@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2025 09:10, Akash Goel wrote:
> This commit addresses a memleak issue of panthor_vma (or drm_gpuva)
> structure in Panthor driver, that can happen if the GPU page table
> update operation to map the pages fail.
> The issue is very unlikely to occur in practice.
> 
> v2: Add panthor_vm_op_ctx_return_vma() helper (Boris)
> 
> v3: Add WARN_ON_ONCE (Boris)
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e378..56a53d70f3b2 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1146,6 +1146,20 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
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
> +
> +	WARN_ON_ONCE(1);
> +}
> +
>  static struct panthor_vma *
>  panthor_vm_op_ctx_get_vma(struct panthor_vm_op_ctx *op_ctx)
>  {
> @@ -2081,8 +2095,10 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
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


