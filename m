Return-Path: <linux-kernel+bounces-759798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8A9B1E2DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040DB18C06BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C72219E8D;
	Fri,  8 Aug 2025 07:07:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7D17AE11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636854; cv=none; b=AdwjY1W8Z4c6ZIlzSh8KvcTvljihmTwZxPQyfifCQ5qblv3nGA+nT4/n2qxwyprzXvkktWmnck1Bo0qyoOG7uvjjyMGoNu18b7n9i/N6yOOgebOE3qWW+4LXV+tJ4M51+GrDA7MsbL1WWT56LQctI6OqDDY9pJQLpfsSg64F9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636854; c=relaxed/simple;
	bh=IMxY/1G7tR6wYViDrH6USRtBgn4zaEiMvjrEd9CKdDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btW0BZP+fF3k5dcQDK99sp3x0XbOHmVzp4RpzWm2H61qtkFHSf09a0+XLKIn8gmemtaOp0roRLiXadytJbN4WvcWwJR/o7J/x1qgp8wbe/ZRY1umHdukkJO0Rg5D8iq14j10tarmflOepPZNDm/90m87EKANkoi1Q+6Frzuv/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBC1916F8;
	Fri,  8 Aug 2025 00:07:23 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F7823F673;
	Fri,  8 Aug 2025 00:07:14 -0700 (PDT)
Message-ID: <321bd04c-9885-4c67-9d39-db4d5919b5b4@arm.com>
Date: Fri, 8 Aug 2025 08:07:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 24/36] arm_mpam: Extend reset logic to allow devices
 to be reset any time
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-25-james.morse@arm.com>
 <fcbe5517-0256-48ce-aa50-8017928737d7@arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <fcbe5517-0256-48ce-aa50-8017928737d7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/07/2025 11:22, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> cpuhp callbacks aren't the only time the MSC configuration may need to
>> be reset. Resctrl has an API call to reset a class.
>> If an MPAM error interrupt arrives it indicates the driver has
>> misprogrammed an MSC. The safest thing to do is reset all the MSCs
>> and disable MPAM.
>>
>> Add a helper to reset RIS via their class. Call this from mpam_disable(),
>> which can be scheduled from the error interrupt handler.
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index 2e32e54cc081..145535cd4732 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c

>> +/*
>> + * Called in response to an error IRQ.
>> + * All of MPAMs errors indicate a software bug, restore any modified
>> + * controls to their reset values.
>> + */
>> +void mpam_disable(void)
>> +{
>> +    int idx;
>> +    struct mpam_class *class;
>> +
>> +    idx = srcu_read_lock(&mpam_srcu);
>> +    list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>> +                 srcu_read_lock_held(&mpam_srcu))
>> +        mpam_reset_class(class);
>> +    srcu_read_unlock(&mpam_srcu, idx);
>> +}
> Consider moving to the next patch where you introduce interrupt support.

I pulled these changes out of that patch to try and make it simpler!
Doing that would leave a bunch of static functions unused.


Thanks,

James

