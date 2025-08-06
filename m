Return-Path: <linux-kernel+bounces-758142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F6B1CB96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F74626C92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E41F0E26;
	Wed,  6 Aug 2025 18:03:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC21B960
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503425; cv=none; b=PEXpUlJNvU87va3SVsUvSfVidg9Ceu9CnDAz0OOv2AsRLGJNMHUxXHi2A3ojABEEHg+uAdMTL6X9os5eDIfv9k50KT1pA2zcJ2TNcPZlabDufDLTeSa11zwFWSahIzzB1Ujq+rnGwH4id0ono8LGYLR9z3APuaRSAnsFpvjYL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503425; c=relaxed/simple;
	bh=Mdcvac7VH7DabwhIJiKRdtx4O2I+pmngUy7vxhDrgCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7TPBvX8OyjTfPaOy1OoXsmF2xGHPJrylVLZ770m8+OYzmoSslNCf/MZJUIM1OAs6NFRbcyo/VvxiVOJgeBmKQRj7ClI0mHXLe5ApuIjWo521QJ8HuMxEQdxtvgwiIU/ZSSKSnukpiKgmCILh2FBrtfpxesnULRnFYq0cmyLWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B27B6176C;
	Wed,  6 Aug 2025 11:03:34 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2DBF3F738;
	Wed,  6 Aug 2025 11:03:32 -0700 (PDT)
Message-ID: <bd30c235-a403-4d81-9bfa-3f6a15450f23@arm.com>
Date: Wed, 6 Aug 2025 19:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/36] platform: arm64: Move ec devices to an ec
 subdirectory
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
 <20250711183648.30766-13-james.morse@arm.com>
 <d91f3a83-16d5-47c0-b227-941df5c25991@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <d91f3a83-16d5-47c0-b227-941df5c25991@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 24/07/2025 11:56, Ben Horgan wrote:
> On 11/07/2025 19:36, James Morse wrote:
>> commit 363c8aea257 "platform: Add ARM64 platform directory" added a
>> subdirectory for arm64 platform devices, but claims that all such
>> devices must be 'EC like'.
>>
>> The arm64 MPAM driver manages an MMIO interface that appears in memory
>> controllers, caches, IOMMU and connection points on the interconnect.
>> It doesn't fit into any existing subsystem.
>>
>> It would be convenient to use this subdirectory for drivers for other
>> arm64 platform devices which aren't closely coupled to the architecture
>> code and don't fit into any existing subsystem.
>>
>> Move the existing code and maintainer entries to be under
>> drivers/platform/arm64/ec. The MPAM driver will be added under
>> drivers/platform/arm64/mpam.


>> diff --git a/drivers/platform/arm64/ec/Kconfig b/drivers/platform/arm64/ec/Kconfig
>> new file mode 100644
>> index 000000000000..06288aebc559
>> --- /dev/null
>> +++ b/drivers/platform/arm64/ec/Kconfig
>> @@ -0,0 +1,73 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# EC-like Drivers for aarch64 based devices.
>> +#
>> +
>> +menuconfig ARM64_PLATFORM_DEVICES
>> +    bool "ARM64 Platform-Specific Device Drivers"
>> +    depends on ARM64 || COMPILE_TEST
>> +    default ARM64
>> +    help
>> +      Say Y here to get to see options for platform-specific device drivers
>> +      for arm64 based devices, primarily EC-like device drivers.
>> +      This option alone does not add any kernel code.
>> +
>> +      If you say N, all options in this submenu will be skipped and disabled.
>> +
>> +if ARM64_PLATFORM_DEVICES

> Shouldn't this be kept in the directory above? By the description this would be expected
> to apply to all drivers in drivers/platfrom/arm64.

Doing that makes any MPAM options appear under 'Platform-Specific Device Drivers' too. I
didn't to that as MPAM isn't specific to one platform, but doesn't fit under any of the
bus or high level groups under drivers. (I briefly toyed with drivers/perf - as there
isn't a drivers/qos).


Thanks,

James

