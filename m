Return-Path: <linux-kernel+bounces-770689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C5B27DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CAA1D0395B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116042FD1CD;
	Fri, 15 Aug 2025 10:02:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809D2FC89D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252151; cv=none; b=N/H2GY/1V6sygx02tXYUwur10kjgUVAkXJnuP7Nkjo2qzpbgxTStIXyIB4mvjcGap53LY34p1+f/7d0Da6DGVQZKRjLpVqwCSLfUEpJlVxrB/9uuQmWsZlvuUyDDEEbPLD+DYV+27I3OROAY5v9eYFQ7RHLIgy5kbuRfyRVmxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252151; c=relaxed/simple;
	bh=jqU3SqBG7XPhIgtzSjKPmZ/lJRXF0DpiU6+ltmy6zmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6K5/Opq6pAQ5gxp0+ZfK1991HJJinQCLp8ouCB0D+J+sIPRgw3XWJgXWo8t/sl4LDsUygNYSrIzidnMouSpW2ZHMe8y57fxT571lJHY0RMgzrI68KSJHoqdar6TLdwByeSp+MvvHoK2stD+Qb4DH/sfE0P6DTbpezoNxBralaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48231168F;
	Fri, 15 Aug 2025 03:02:21 -0700 (PDT)
Received: from [10.1.29.14] (e122027.cambridge.arm.com [10.1.29.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70ABA3F738;
	Fri, 15 Aug 2025 03:02:27 -0700 (PDT)
Message-ID: <020f8735-06d0-4df3-b0bb-224692e06527@arm.com>
Date: Fri, 15 Aug 2025 11:02:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] drm/panthor: Make MMU cache maintenance use
 FLUSH_CACHES command
To: Liviu Dudau <liviu.dudau@arm.com>, Daniel Stone <daniel@fooishbar.org>
Cc: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
 nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
References: <20250807162633.3666310-1-karunika.choo@arm.com>
 <20250807162633.3666310-7-karunika.choo@arm.com>
 <CAPj87rP9pETnxr_mVJ4OAwj_Vhh2yS75iQ5LDT7ddC5=a-kXkA@mail.gmail.com>
 <aJ5qGWlbxihLTHkB@e110455-lin.cambridge.arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <aJ5qGWlbxihLTHkB@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2025 23:58, Liviu Dudau wrote:
> On Fri, Aug 08, 2025 at 11:50:27AM +0100, Daniel Stone wrote:
>> Hi Karunika,
>>
>>
>> On Thu, 7 Aug 2025 at 17:27, Karunika Choo <karunika.choo@arm.com> wrote:
>>> @@ -585,6 +615,9 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>>>         if (op != AS_COMMAND_UNLOCK)
>>>                 lock_region(ptdev, as_nr, iova, size);
>>>
>>> +       if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
>>> +               return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
>>
>> Given that FLUSH_MEM and FLUSH_PT are the only ops which are ever
>> used, the below becomes dead code. Could you please just inline these,
>> so it's more clear what's actually going on? The (op !=
>> AS_COMMAND_UNLOCK) branch can also become unconditional, perhaps with
>> a WARN_ON() around unknown ops.
> 
> Hmm, the commit message says that FLUSH_MEM and FLUSH_PT are going to be
> deprecated and replaced with FLUSH_CACHES so the first are clearly not the
> only ones ever used (at least not in the future). I'm not sure why you
> think this code is not correct.

The code is "correct" (it does the right thing), but Daniel is also
correct that as things stand the code below that "return" is all dead.
The only code paths call with op either AS_COMMAND_FLUSH_MEM or
AS_COMMAND_FLUSH_PT.

But I think this patch set has been through enough revisions already,
and we've now got the firmware upstream[1]. So rather than do another
wrong, I'm going to merge this to drm-misc-next and I'll post a separate
patch cleaning up the dead code.

Thanks,
Steve

[1]
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/930ef9046e3848df688d98b7d5e68154b031dc66

> Best regards,
> Liviu
> 
>>
>> Cheers,
>> Daniel
> 


