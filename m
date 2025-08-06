Return-Path: <linux-kernel+bounces-758143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C3B1CB97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB67A01CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CC1F4CBC;
	Wed,  6 Aug 2025 18:03:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603A386337
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503437; cv=none; b=jFUTOCRQ/BL0CDobYDV6SgmwOBqRDLWSnuJ8V7734SIGDHkKFj+2pr/oZf/8KQmXkSeTeFghbVcnLk1RGw8k1xb+/URKBSEOOWaSywA7IdHk7/a1LYvkVWMLgnwLDvXPu52Ffd5YKD9IC+JYC0P6Z32/IbA3wQwFOXbB3C5F4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503437; c=relaxed/simple;
	bh=ibpUQ1coV6tRyIxNGU5Bd1s4KJas5vEQ2u4Ja9tAZx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adYLLskeu3TwC8alHziZ4VrQzjz4df28YRiMlxdoSptbiAKYt6ysyFxLxnrhQ0xlmd5uVlof9cgvwV6VCkrTSXkJ5arPnIX2Q2gL/qx8Ts3Dtxyv4rgbG/WifBndDfOUlGKxK4iDUhgNVcHcJ7NtMKC4XMYqFb/R9WOCLOcIzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB46F176C;
	Wed,  6 Aug 2025 11:03:46 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A412A3F738;
	Wed,  6 Aug 2025 11:03:43 -0700 (PDT)
Message-ID: <13398823-bcef-4bda-a6ea-c5ccde49ef6a@arm.com>
Date: Wed, 6 Aug 2025 19:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/36] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
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
 <20250711183648.30766-14-james.morse@arm.com>
 <347c93ec-a645-43fa-a648-88a3d9ace733@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <347c93ec-a645-43fa-a648-88a3d9ace733@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 24/07/2025 12:02, Ben Horgan wrote:
> On 11/07/2025 19:36, James Morse wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> new file mode 100644
>> index 000000000000..5b886ba54ba8
>> --- /dev/null
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -0,0 +1,336 @@

>> +static int mpam_dt_count_msc(void)
>> +{
>> +    int count = 0;
>> +    struct device_node *np;
>> +
>> +    for_each_compatible_node(np, NULL, "arm,mpam-msc")

> This will count even 'status = "disabled"' nodes. Add a check for that.
> 
> if (of_device_is_available(np))> +        count++;

Good spot, fixed - thanks.


Thanks,

James


>> +
>> +    return count;
>> +}

