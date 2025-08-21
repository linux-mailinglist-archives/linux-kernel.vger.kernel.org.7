Return-Path: <linux-kernel+bounces-779161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF608B2EFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DC05E7A98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BE2E88A8;
	Thu, 21 Aug 2025 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ifSpiX/c"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A02188906
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761638; cv=none; b=YKzVP2gtc3dcrxpBPbb7vbjFNcL1ZtuS6+NAeuCqw9RwfRMqgu3gKB/pUV2BNSUUgmO5vPalvu/ny8msxEwKdF1CwlGRuhpSzUtuAZ1LO8ExzF1GRP1B3uFPkoqMUtrVt/qfvZ4xIUA/QXESnHWy2NrxKe+9sV7EPGtyfGP1eMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761638; c=relaxed/simple;
	bh=eJjCN7EMFWhnfPQM50VED/b/QKoZDLR+Xl5LUqfGjJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehPjss82Z158ZIfbwoRRgyO47cDeUaZBm3oIrj7+FbtKIjF0KclnTUPwsBfV4Inp3lmVn+7HuRLLR2zWvQO8l6DuPukdcsUFJFFIybMmcCf6Bsdkd2BA2hsTE8pxOoAaBaKvashBiQT5VjOD3dxVi0ApV61kle51ojDj3/btnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ifSpiX/c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755761634;
	bh=eJjCN7EMFWhnfPQM50VED/b/QKoZDLR+Xl5LUqfGjJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ifSpiX/cojVUew0FzK+n4uESqVe4GDkXTKXPTcEN3OZSzH39afnVeFQW2pKjFp8Gy
	 d9mt5lMGy7QGMSqVN5vPUU7wszBcsLTgvCK7tLCqVcb8Sc5hZAi255SLoFnL1G2xQK
	 89owQ9xdgn4crmX/IIu2guVaNfyZEfM0zxQKzit6z0ASb3QyXmlSlRGxIV80EfpJFc
	 w5z94R3d/stvj4Trs6G1BaZYuPvHdcvx5bEz5kCx7b8WVyhz8QkkzoR6FOpF6vfTRB
	 WA3P8H7KdbyZjlnwIDpohr8Z2EnPbNWipk3Ax2rEll7rmyBlUqCXQSBj7Fa2BOh6lz
	 27DEK/szECbdg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FF5417E01F5;
	Thu, 21 Aug 2025 09:33:54 +0200 (CEST)
Date: Thu, 21 Aug 2025 09:33:50 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 8/9] drm/panthor: check bo offset alignment in vm bind
Message-ID: <20250821093350.104c28a0@fedora>
In-Reply-To: <20250720000146.1405060-9-olvaffe@gmail.com>
References: <20250720000146.1405060-1-olvaffe@gmail.com>
	<20250720000146.1405060-9-olvaffe@gmail.com>
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

On Sat, 19 Jul 2025 17:01:45 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> Fail early from panthor_vm_bind_prepare_op_ctx instead of late from
> ops->map_pages.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

We can probably merge this one ahead of the coredump stuff.

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index a857a0dd1099..7862c99984b6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1206,7 +1206,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
>  		return -EINVAL;
>  
> -	/* Make sure the VA and size are aligned and in-bounds. */
> +	/* Make sure the VA and size are in-bounds. */
>  	if (size > bo->base.base.size || offset > bo->base.base.size - size)
>  		return -EINVAL;
>  
> @@ -2423,7 +2423,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  	int ret;
>  
>  	/* Aligned on page size. */
> -	if (!IS_ALIGNED(op->va | op->size, vm_pgsz))
> +	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {


