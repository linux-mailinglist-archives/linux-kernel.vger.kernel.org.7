Return-Path: <linux-kernel+bounces-759802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D27FB1E2E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486C418C1E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AA22172C;
	Fri,  8 Aug 2025 07:12:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29F17AE11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637127; cv=none; b=gU3xjoWi+g8sKVqgMiOR3W6ntpBx6u6jqfDmsDrM6wcWGnd4LtHXxiE15jTnb/2bubYNNdLqrOUiSbFTb8yX4PjKEV7kdR0dWwL/rZ11LmzldhpCruQhzFiuu+FMIYRKWSXiDorX5Fch5J9RtN/YCauQT2QmEL6MHmZaf94qbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637127; c=relaxed/simple;
	bh=LXPrHcNG7KlWsHeoL1Cg1zKZCKZbrueHrYOom5thM3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CY407aBHrTAW05Td21vsLpUiJSwxMqLn5F3ob8WGo/TqqKw7G6V0EXHltss0N5eWGoBAd00QGYCxW9iCAvObW6Jo3zdKhk8gPW4TQclr7IAXx0y7ga9YxMkEUg1m0/f1d0HTgdyorooMUJCdj6r8S00ClVDSb4u527Lx9PLLefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FB822EA;
	Fri,  8 Aug 2025 00:11:57 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 358A53F673;
	Fri,  8 Aug 2025 00:12:00 -0700 (PDT)
Message-ID: <c526e084-dcd3-4117-873e-67c6d9869b8f@arm.com>
Date: Fri, 8 Aug 2025 08:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
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
 <20250711183648.30766-26-james.morse@arm.com>
 <a8dd0921-9d25-4f57-97ee-9b44b8ff5057@arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <a8dd0921-9d25-4f57-97ee-9b44b8ff5057@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/07/2025 11:49, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> Register and enable error IRQs. All the MPAM error interrupts indicate a
>> software bug, e.g. out of range partid. If the error interrupt is ever
>> signalled, attempt to disable MPAM.
>>
>> Only the irq handler accesses the ESR register, so no locking is needed.
>> The work to disable MPAM after an error needs to happen at process
>> context, use a threaded interrupt.
>>
>> There is no support for percpu threaded interrupts, for now schedule
>> the work to be done from the irq handler.
>>
>> Enabling the IRQs in the MSC may involve cross calling to a CPU that
>> can access the MSC.
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index 145535cd4732..af19cc25d16e 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -1548,11 +1638,193 @@ static void mpam_enable_merge_features(struct list_head

>> +static int mpam_enable_msc_ecr(void *_msc)
>> +{
>> +    struct mpam_msc *msc = _msc;
>> +
>> +    __mpam_write_reg(msc, MPAMF_ECR, 1);
> You can use MPAMF_ECR_INTEN.

Sure,


>> +
>> +    return 0;
>> +}

>> @@ -1644,7 +1939,6 @@ void mpam_enable(struct work_struct *work)
>>       struct mpam_msc *msc;
>>       bool all_devices_probed = true;
>>   -    /* Have we probed all the hw devices? */
> Stray change. Keep the comment or remove it in the patch that introduced it.

Fixed.


Thanks,

James



