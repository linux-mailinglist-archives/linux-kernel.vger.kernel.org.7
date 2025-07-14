Return-Path: <linux-kernel+bounces-730461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14EB044DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583D617AB67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9125BF1B;
	Mon, 14 Jul 2025 15:59:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9B1339A4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508740; cv=none; b=AQMj8B4RhgteEZgcODhH2SbEzAKWJrCTDg6qb1AoEBrHtSCPnt/eAJGky92ww0+3jfgq/21y+jAI5V2rzuqZgdBBF5tb+mHvrXJurHVu9de00WIfwQWd54YAWaXtI+gf05f9Xf0Rw4S2XxDMdGmTsdydHWb7LRJ7ebdJSA4GQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508740; c=relaxed/simple;
	bh=Dxo2/3MunnCIqq+o91fswanZiwjM0yvGwNXW726nC6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWsai1TA7u80dQIWFs5WbmrKKBlHWl/m9Qjn2GVp2Vu8l+jfja+py7KmHkhDVR+t2hvUYKfhuQ8BAZdbV/kmZuNwtvRZzehB1UEGVI1BT3rMsM6q/h5qb0BfUtGaoa8ni9jYzWONW+uKMRW1hGEMKww1dUYMGxRvGyZ7h2kf81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C081BC0;
	Mon, 14 Jul 2025 08:58:48 -0700 (PDT)
Received: from [10.57.83.29] (unknown [10.57.83.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99AC23F694;
	Mon, 14 Jul 2025 08:58:55 -0700 (PDT)
Message-ID: <9bcdf08d-eede-4bad-9445-fe0724eb7356@arm.com>
Date: Mon, 14 Jul 2025 16:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Remove dead VM flushing code
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250711154557.739326-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250711154557.739326-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2025 16:45, Adrián Larumbe wrote:
> Commit ec62d37d2c0d("drm/panthor: Fix the fast-reset logic") did away
> with the only reference to panthor_vm_flush_all(), so let's get rid
> of the orphaned definition.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-next.

Thanks,
Steve

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


