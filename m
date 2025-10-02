Return-Path: <linux-kernel+bounces-840142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02480BB3ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6593326E94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590A30C611;
	Thu,  2 Oct 2025 10:41:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BE30C0FC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401707; cv=none; b=dAOqDF6Fm7e2v0iccpg191v+MFdX0DaAMpR6CRZLDaApNqhOIYfZCrXtUpeT3kADMX/sUL/FiJ9VxmHKBOwAYZpaKpF6V/wIchDQA0a51phLWuhEY7KS4GOMFfCVal7X4tPQvqZttjehfj8zG0ZfF6X21oKbMPCEI+QBSUGJztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401707; c=relaxed/simple;
	bh=Tc2tlrvnzN8WD+XBjsOC5s/ZOeCjDjtgz4a7rGm1tck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X7qwiuNiry497qryMbW447r5YBDQ3UyQ4caydD1wkTpBcQ6ByTOpivUx9OmsqdvqcLWEQUepy2kyME8EW9wed8RFLA7ZP7EBEVTivFG4V17OXDIGdonzTrvdY42HYJ8TAFPHDS/O7LwZaRG57c+1L4UyCwdqnWq5iNusE1Hn7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04AAA1692;
	Thu,  2 Oct 2025 03:41:37 -0700 (PDT)
Received: from [10.57.2.240] (unknown [10.57.2.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2493F3F66E;
	Thu,  2 Oct 2025 03:41:42 -0700 (PDT)
Message-ID: <74e2f1a8-0410-4a5e-bbf3-29d5d5d55308@arm.com>
Date: Thu, 2 Oct 2025 11:41:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/panthor: remove unnecessary mmu_hw_wait_ready
 calls
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250916210823.4033529-1-olvaffe@gmail.com>
 <20250916210823.4033529-8-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250916210823.4033529-8-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2025 22:08, Chia-I Wu wrote:
> No need to call mmu_hw_wait_ready after panthor_gpu_flush_caches or
> before returning from mmu_hw_flush_caches.

Why is there no need? If we attempt to send a command when the hardware
is busy then the command will be dropped (so the cache flush won't
happen), and if we don't wait for the unlock command to complete then
then we don't know that the flush is complete.

Thanks,
Steve

> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 373871aeea9f4..c223e3fadf92e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -669,12 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
>  	 * at the end of the GPU_CONTROL cache flush command, unlike
>  	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
>  	 */
> -	ret = mmu_hw_wait_ready(ptdev, as_nr);
> -	if (!ret)
> -		mmu_hw_cmd_unlock(ptdev, as_nr);
> +	mmu_hw_cmd_unlock(ptdev, as_nr);
>  
> -	/* Wait for the unlock command to complete */
> -	return mmu_hw_wait_ready(ptdev, as_nr);
> +	return 0;
>  }
>  
>  static int mmu_hw_do_operation(struct panthor_vm *vm,


