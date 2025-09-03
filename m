Return-Path: <linux-kernel+bounces-799117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753A8B42740
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B82B483EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA752D0C98;
	Wed,  3 Sep 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NouMMXaJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E56284890
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918012; cv=none; b=jyM57JnhX2o0w807OtjKSw92mzx0q2Nk8xQhhfFq3qq/9PgLrhaNcLF0atVTLCxm6aEbRQ06oENBBD0ZOzr0Zg5Px3bUpvS1774PNakHpIdBlDaeYIYtg7j4wCc2vX7faj8YmnkVassqTJ4dcKx7ZNdVyAzI/kh4Ku+myfs/29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918012; c=relaxed/simple;
	bh=CgFF97qUmIIM4QQUSZ1m8s2Y2qHyO5S2SV0vSEqfck8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnV95etTEVjtwb02Px0FS1nas+74fWHY5+UaEg5ghobVS1B7Ynb+YV5JZbJq8czqbyRJXVreB0epY82oZtatRXvbIhFkCKceNGiwNCydicAEZJQzuMBBoTCxDjfXImrcZcTscLcUu9ExrwjWlFe1JxdPWQ1cZ7iOa9w/RwvtyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NouMMXaJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756918008;
	bh=CgFF97qUmIIM4QQUSZ1m8s2Y2qHyO5S2SV0vSEqfck8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NouMMXaJeRchlBIyaaEHNxjadOSAOmDUXxXWRiiG6pUoTpoweCwINtvRjBppRGYQ4
	 jNm72dVQ7Isob4wWVilEjqyAIwW9zophiDouR6qLCazriJqxZpnXIshGGAxR3V22zC
	 E9KwEL128tO+8KNoNuFQqiMfMhtWSI75TO77mjDBNixYxeli0Y/nS9XQ0zt6CGYXLe
	 IQ9NiJ47vF3jjQks0Lhu4bmbLOiiCdZaSm2xXe6GdzShLERFVFBkdZt19/b78aevIk
	 dBoB1gjxoeM8S+vBzqv/fVz3NliznwHT5VIayB/stwCwuzNDXY0ScTd2zHmencpx+x
	 KbkmvHk/kcAsw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4308A17E0579;
	Wed,  3 Sep 2025 18:46:48 +0200 (CEST)
Date: Wed, 3 Sep 2025 18:46:42 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: check bo offset alignment in vm bind
Message-ID: <20250903184642.62183125@fedora>
In-Reply-To: <20250828200116.3532255-1-olvaffe@gmail.com>
References: <20250828200116.3532255-1-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 13:01:16 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> Fail early from panthor_vm_bind_prepare_op_ctx instead of late from
> ops->map_pages.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
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

Now that I look at this, I think we'd be better moving this alignment
check to panthor_vm_prepare_[un]map_op_ctx() to cover the in-kernel
users.

>  
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {


