Return-Path: <linux-kernel+bounces-841377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAACCBB7220
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E40419E398C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9C202F71;
	Fri,  3 Oct 2025 14:13:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181371F0E26
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500794; cv=none; b=MGNHY1BqQVftrfqAuYtHhoKLfNFaJyYg8lWQgkfanQrTpgDRomkuRaNJAvQdv9qsezHyumPvlDPdi/RhR98lE5F+3PUNseS4LjJK0og5BuHuWeB/79ewWlPAL3wD1Wn/1v6JNvMIIt7O9OzqtRGJ6WsTITy87Vnde2sSbvDgM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500794; c=relaxed/simple;
	bh=LBOkISrEuvAXYCbIyNUUsPFgFpLRGIs+qffkQ+XNjb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLU6aIrcJVCY0jpqdqJo1LrodWdN1vUbYXdVsoGybjoIBuWzWLedU3ZChh1R931P5mTj9c6nX4hJRu0Ltxp7qkqFO2ealb+Bo/COuwhpv0mFoqk69EYTHjLZKDuOA/lox5PRKOgCKroTQduapZxwhGHVctqUBpERynUTuitRauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3350F1655;
	Fri,  3 Oct 2025 07:13:02 -0700 (PDT)
Received: from [10.1.37.18] (e122027.cambridge.arm.com [10.1.37.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3D83F5A1;
	Fri,  3 Oct 2025 07:13:07 -0700 (PDT)
Message-ID: <2404993b-a96c-4a99-bfba-3f9e3031c90b@arm.com>
Date: Fri, 3 Oct 2025 15:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/panthor: rename and document lock_region
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250916210823.4033529-1-olvaffe@gmail.com>
 <20250916210823.4033529-3-olvaffe@gmail.com>
 <c521f2be-85b2-4f4e-9e5c-6105129b3fc6@arm.com>
 <CAPaKu7TT_Uph+ccNQ4q2+y9Pbmm-nLnPOgsLwEuZGnON26EStg@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <CAPaKu7TT_Uph+ccNQ4q2+y9Pbmm-nLnPOgsLwEuZGnON26EStg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2025 01:46, Chia-I Wu wrote:
> On Thu, Oct 2, 2025 at 3:41 AM Steven Price <steven.price@arm.com> wrote:
>>
>> On 16/09/2025 22:08, Chia-I Wu wrote:
>>> Rename lock_region to mmu_hw_cmd_lock.
>>>
>>> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> index d3af4f79012b4..8600d98842345 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> @@ -545,8 +545,17 @@ static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
>>>       return status;
>>>  }
>>>
>>> -static void lock_region(struct panthor_device *ptdev, u32 as_nr,
>>> -                     u64 region_start, u64 size)
>>> +/**
>>> + * mmu_hw_cmd_lock() - Issue a LOCK command
>>> + * @ptdev: Device.
>>> + * @as_nr: AS to issue command to.
>>> + * @region_start: Start of the region.
>>> + * @size: Size of the region.
>>> + *
>>> + * Issue a LOCK command to invalidate MMU caches and block future transactions
>>> + * for a region.
>>
>> The LOCK command doesn't invalidate the caches - that's the UNLOCK
>> command. LOCK just blocks any memory accesses that target the region.
>>
>> [I guess the hardware implementation might flush TLBs to achieve the
>> block, but that's an implementation detail and shouldn't be relied upon].
> Hm, for LOCK, the doc I have says "MMU caches are invalidated." And
> for UNLOCK, there is actually no invalidation when the region is
> LOCK'ed.

Hmm, interesting. You are correct - I knew that it is possible to do an
UNLOCK without a LOCK and in that case it is the UNLOCK which performs
the invalidation. But looking back through the architecture
documentation it does actually state that the LOCK invalidates MMU
caches. So it appears I'm wrong - sorry about that.

>> I'm also not entirely clear what the benefit of this rename is? It's a
>> static function in a xxx_mmu.c file so it's fairly obvious this going to
>> MMU HW related. I also feel "_region" in the name makes it obvious that
>> there is a memory range that is affected by the lock.
> A big part of this file is for in-memory page tables. "mmu_hw_" prefix
> is used by some functions that write the regs. This (and following)
> renames prefix other such functions by "mmu_hw_" for consistency.

Well before this series there are a total of two functions currently
which have the mmu_hw_ prefix:
 * mmu_hw_do_operation_locked
 * mmu_hw_do_operation

Which I think needed something more than "do_operation", possibly
"do_mmu_operation" or "do_mmu_hw_operation" might have been better, but
I don't think there's a great difference. Generally we don't include a
prefix on static functions because they are local to the file.

> Then there are "mmu_hw_cmd_FOO" for each hw cmd FOO. That's why the
> "_region' part gets dropped.

It's interesting that the documentation says:

> LOCK (2)
> 
> Issues a lock region command to the MMU

So while I can't deny that the command is called "LOCK", informally we
do call it "lock region" more commonly because it describes the purpose
better.

Thanks,
Steve

>>
>> Thanks,
>> Steve
>>
>>> + */
>>> +static void mmu_hw_cmd_lock(struct panthor_device *ptdev, u32 as_nr, u64 region_start, u64 size)
>>>  {
>>>       u8 region_width;
>>>       u64 region;
>>> @@ -609,7 +618,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>>>        * power it up
>>>        */
>>>
>>> -     lock_region(ptdev, as_nr, iova, size);
>>> +     mmu_hw_cmd_lock(ptdev, as_nr, iova, size);
>>>
>>>       ret = mmu_hw_wait_ready(ptdev, as_nr);
>>>       if (ret)
>>


