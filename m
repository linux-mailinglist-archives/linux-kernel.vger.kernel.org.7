Return-Path: <linux-kernel+bounces-798378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D4B41D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD791BA4F50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888B2FB995;
	Wed,  3 Sep 2025 11:29:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489A2FB63A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898985; cv=none; b=Dx1YUKu55FLygWex60xpaMnvCC5rH1Qge37k65rfUP7NyBOcf0cQskeSNWUBhhERzxcdTDsVtp9wwQhb62ic51s4CFZZxiqgx/HZ/LV7uCQCQ1UGNVll0UNrV6tBYNYoghPdujmJvC9RlCm5DHBEZLHjvp6Pzwx9SQp2l6p18ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898985; c=relaxed/simple;
	bh=DFJbc/ggh38h1GOYNTcP/EvPAHYq6UwVOD7F3P6dB9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qW1P2iFzl6Dq1xyVope0ljCHjssyqwhWpTj18kshWdoB3cGbx7UjNt6RPVzVzurnOeilQ9rvS0Ru/2Fs4XLTFmYwGLLu0E9N5zkwAzmUL4GGq1AI9e7KDpoZXmqREtqFCgtViulZuPh3aYucXlije4Sjam8J1cqj10Z5mfGH1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E351688;
	Wed,  3 Sep 2025 04:29:34 -0700 (PDT)
Received: from [10.1.39.32] (e122027.cambridge.arm.com [10.1.39.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 326913F694;
	Wed,  3 Sep 2025 04:29:40 -0700 (PDT)
Message-ID: <87b5f17b-db1f-4acd-a8bd-1ac773c13224@arm.com>
Date: Wed, 3 Sep 2025 12:29:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: check bo offset alignment in vm bind
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250828200116.3532255-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250828200116.3532255-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2025 21:01, Chia-I Wu wrote:
> Fail early from panthor_vm_bind_prepare_op_ctx instead of late from
> ops->map_pages.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-next.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index bad720f23eb70..6dec4354e3789 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1222,7 +1222,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
>  		return -EINVAL;
>  
> -	/* Make sure the VA and size are aligned and in-bounds. */
> +	/* Make sure the VA and size are in-bounds. */
>  	if (size > bo->base.base.size || offset > bo->base.base.size - size)
>  		return -EINVAL;
>  
> @@ -2447,7 +2447,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  	int ret;
>  
>  	/* Aligned on page size. */
> -	if (!IS_ALIGNED(op->va | op->size, vm_pgsz))
> +	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {


