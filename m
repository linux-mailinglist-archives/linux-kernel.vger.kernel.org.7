Return-Path: <linux-kernel+bounces-841379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0612BB7229
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE64E414F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DB620A5DD;
	Fri,  3 Oct 2025 14:13:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14C2066F7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500806; cv=none; b=scH9ejPbPtWfcU7UYw1dgg1iaRiNzjyFC9OHnN1D0qhI1AIiLl+p+68kzG+byaZIa8Qb3wCZf1kvXrSpVjy3fB+QS8ZwyBwoss4DBLEINH/rzhJiA/PI7AXBO8b2D4FDkt9+osov/9PQAvsBSexBiKxxDYWEsw4ZmWvDM5fQsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500806; c=relaxed/simple;
	bh=1hJlwvsIOfh/kezfxUeX+2RuA7sUORXqkvbFigua4EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8cGQ4wqGUvRwb4NtsFZ4TYHFEg13fteqEa9FrIK+1iuJNDrGkoY51Czod4YMh7lCSJVk0thpc58/TxdF8ryBr7GgEgjGxzq/5qbDcyJSKmemMx78Tf9hO4cLY7rUFk9SPlhA+KDVlAJGjRiENYabRwBLRtXbGUGb+i9pKjkpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A1051688;
	Fri,  3 Oct 2025 07:13:16 -0700 (PDT)
Received: from [10.1.37.18] (e122027.cambridge.arm.com [10.1.37.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C839D3F5A1;
	Fri,  3 Oct 2025 07:13:21 -0700 (PDT)
Message-ID: <9022445f-3cf7-46a8-85ac-e1f226e0bd9b@arm.com>
Date: Fri, 3 Oct 2025 15:13:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/panthor: remove unnecessary mmu_hw_wait_ready
 calls
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250916210823.4033529-1-olvaffe@gmail.com>
 <20250916210823.4033529-8-olvaffe@gmail.com>
 <74e2f1a8-0410-4a5e-bbf3-29d5d5d55308@arm.com>
 <CAPaKu7QEAbR8a_+qmyU=obyf2N-UZemfw23U_Dw2DZLqPd7tGQ@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <CAPaKu7QEAbR8a_+qmyU=obyf2N-UZemfw23U_Dw2DZLqPd7tGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2025 01:23, Chia-I Wu wrote:
> On Thu, Oct 2, 2025 at 3:41 AM Steven Price <steven.price@arm.com> wrote:
>>
>> On 16/09/2025 22:08, Chia-I Wu wrote:
>>> No need to call mmu_hw_wait_ready after panthor_gpu_flush_caches or
>>> before returning from mmu_hw_flush_caches.
>>
>> Why is there no need? If we attempt to send a command when the hardware
>> is busy then the command will be dropped (so the cache flush won't
>> happen), and if we don't wait for the unlock command to complete then
>> then we don't know that the flush is complete.
> We have this sequence of calls
> 
>   mmu_hw_wait_ready
>   panthor_gpu_flush_caches
>   mmu_hw_wait_ready
>   mmu_hw_cmd_unlock
>   mmu_hw_wait_ready
> 
> I could be utterly wrong, but my assumption was that
> panthor_gpu_flush_caches does not cause AS_STATUS_AS_ACTIVE, at least
> by the time it returns. That's why I removed the second wait.

Hmm, so this was a recent change, moving away from FLUSH_MEM/FLUSH_PT. I
have to admit the spec implies that it a FLUSH_CACHES command wouldn't
set the AS_ACTIVE bit.

Indeed we now actually split the active bit between AS_ACTIVE_EXT and
AS_ACTIVE_INT - where _INT is from an "internal source" and therefore
doesn't prevent writing to the COMMAND register.

We do, however, need the LOCK command to have completed before we flush
the caches. So the operations should be:

 * wait_ready()
 * LOCK
 * wait_ready() // To check that the LOCK has completed
 * FLUSH_CACHES
 * UNLOCK
 * wait_ready() // Optional

The final wait_ready() is optional in some cases (because the LOCK
ensures that we can't have any translations using the old TLB entries -
note that I believe older Midgard GPUs couldn't rely on this). However
in the case where we want to disable a MMU we're going to have to wait.

> We also always wait before issuing a cmd. Removing the last wait here
> avoids double waits for panthor_mmu_as_{enable,disable}. It does leave
> the cmd in flight when panthor_vm_flush_range returns, but whoever
> issues a new cmd will wait on the flush.

Note that wait_ready() is really cheap - it's a single GPU register read
if there's nothing active. So the "double wait" isn't really a problem.
I'd much rather have the occasional double wait (i.e. one extra register
read) than the situation where we miss a wait_ready() and end up with an
MMU command being dropped by the hardware.

Thanks,
Steve

> 
> 
>>
>> Thanks,
>> Steve
>>
>>> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_mmu.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> index 373871aeea9f4..c223e3fadf92e 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> @@ -669,12 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
>>>        * at the end of the GPU_CONTROL cache flush command, unlike
>>>        * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
>>>        */
>>> -     ret = mmu_hw_wait_ready(ptdev, as_nr);
>>> -     if (!ret)
>>> -             mmu_hw_cmd_unlock(ptdev, as_nr);
>>> +     mmu_hw_cmd_unlock(ptdev, as_nr);
>>>
>>> -     /* Wait for the unlock command to complete */
>>> -     return mmu_hw_wait_ready(ptdev, as_nr);
>>> +     return 0;
>>>  }
>>>
>>>  static int mmu_hw_do_operation(struct panthor_vm *vm,
>>


