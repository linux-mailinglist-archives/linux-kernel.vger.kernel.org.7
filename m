Return-Path: <linux-kernel+bounces-728008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D999CB02260
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4032316DE07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD632EF9DD;
	Fri, 11 Jul 2025 17:13:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079B1754B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253999; cv=none; b=YIuiJ5fA7Z9h46ntZlu2KZf3AdtM8g0TVUK79yPtGpRFc90g6ZIhsDonHwckg2zgyGKFJpCEJuT/Pk4evtI+PYmVMg7gQQm7eKEfjWvEM8d/WxN0k+IvfMkfja3lWvTb88lg6Md208Q6LhF+rJNGipDOtj0dgzgXZ51DyrFJ8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253999; c=relaxed/simple;
	bh=iIq0lLJhakE200mRT51yu+L10LhWD0r9T8Ad8HguJag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVsKII2G9Aae+27+UP0otNXtCazusJpz+/E0GHkFV++r29CBk273raxL8VittDtcliwNKfz0W8m2R3LVS2WbtMzGVF/fWTYTCdFfSM4xkcJD+QNAUKdhjGSDKsytWh447UQYlCYQUXqlvqTUiZVEgExC1/Dwaw6QiqmfbZRRVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12B516F8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:13:06 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 098BB3F738
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:13:16 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:13:00 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Remove dead VM flushing code
Message-ID: <aHFGHBrZtIcp0SVw@e110455-lin.cambridge.arm.com>
References: <20250711154557.739326-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711154557.739326-1-adrian.larumbe@collabora.com>

On Fri, Jul 11, 2025 at 04:45:53PM +0100, Adrián Larumbe wrote:
> Commit ec62d37d2c0d("drm/panthor: Fix the fast-reset logic") did away
> with the only reference to panthor_vm_flush_all(), so let's get rid
> of the orphaned definition.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 11 -----------
>  drivers/gpu/drm/panthor/panthor_mmu.h |  1 -
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index b39ea6acc6a9..ed3712f8d6a9 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -885,17 +885,6 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
>  	return ret;
>  }
>  
> -/**
> - * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
> - * @vm: VM whose cache to flush
> - *
> - * Return: 0 on success, a negative error code if flush failed.
> - */
> -int panthor_vm_flush_all(struct panthor_vm *vm)
> -{
> -	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
> -}
> -
>  static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
>  {
>  	struct panthor_device *ptdev = vm->ptdev;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index fc274637114e..0e268fdfdb2f 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -33,7 +33,6 @@ int panthor_vm_active(struct panthor_vm *vm);
>  void panthor_vm_idle(struct panthor_vm *vm);
>  u32 panthor_vm_page_size(struct panthor_vm *vm);
>  int panthor_vm_as(struct panthor_vm *vm);
> -int panthor_vm_flush_all(struct panthor_vm *vm);
>  
>  struct panthor_heap_pool *
>  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
> -- 
> 2.50.0
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

