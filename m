Return-Path: <linux-kernel+bounces-759797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382FB1E2DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B2118C0618
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C121ADB9;
	Fri,  8 Aug 2025 07:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008C217722
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636792; cv=none; b=CyYR/ytty1dqWfaDRrAHIo5SGBOVarLcwm3hp3D7vMYLrJmD0J77ijZ15Rd3pIZ1IYQrTj1NCvh8yItfz5On8fXFEYYpqWC/qwhMPZQLhQDYk/UJ5X1kAWeEQ9ao7+NBmBJyQOZxKeZNkMBEsAk+fAqIcmcgZ7Q/LWiZWQ8eCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636792; c=relaxed/simple;
	bh=rKuS5fkL+DJx1/HdPwfsh9WJQ5lgMci1hhSgE8p+t0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7uQDkUBbJDvWGH/+xuaZUEAQ58ubIuykLWQLnOtWCps3aMHXhEhfsGc0bG3Eyn/EU3rVXf9v+EjICyb+6qEk1t+VO24pmagmPIYi0Uw3DvKA3zTbXqx5L3GOh7bhCX/rA/mIdZLNN3FRK1RjsUmTOSUba1clHCQtgGR7sNlbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961C016F8;
	Fri,  8 Aug 2025 00:06:21 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03FED3F673;
	Fri,  8 Aug 2025 00:05:53 -0700 (PDT)
Message-ID: <0936f322-30a4-4026-8db0-208514cc9742@arm.com>
Date: Fri, 8 Aug 2025 08:05:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/36] arm_mpam: Reset MSC controls from cpu hp
 callbacks
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
 <20250711183648.30766-23-james.morse@arm.com>
 <b69f7207-84b3-424f-b675-b423c56e5dcd@arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <b69f7207-84b3-424f-b675-b423c56e5dcd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/07/2025 10:49, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> When a CPU comes online, it may bring a newly accessible MSC with
>> it. Only the default partid has its value reset by hardware, and
>> even then the MSC might not have been reset since its config was
>> previously dirtyied. e.g. Kexec.
>>
>> Any in-use partid must have its configuration restored, or reset.
>> In-use partids may be held in caches and evicted later.
>>
>> MSC are also reset when CPUs are taken offline to cover cases where
>> firmware doesn't reset the MSC over reboot using UEFI, or kexec
>> where there is no firmware involvement.
>>
>> If the configuration for a RIS has not been touched since it was
>> brought online, it does not need resetting again.
>>
>> To reset, write the maximum values for all discovered controls.
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index 7b042a35405a..d014dbe0ab96 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c

>> @@ -849,8 +850,116 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>       return 0;
>>   }
>>   +static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>> +{
>> +    u32 num_words, msb;
>> +    u32 bm = ~0;
>> +    int i;
>> +
>> +    lockdep_assert_held(&msc->part_sel_lock);
>> +
>> +    if (wd == 0)
>> +        return;
>> +
>> +    /*
>> +     * Write all ~0 to all but the last 32bit-word, which may
>> +     * have fewer bits...
>> +     */
>> +    num_words = DIV_ROUND_UP(wd, 32);
>> +    for (i = 0; i < num_words - 1; i++, reg += sizeof(bm))
>> +        __mpam_write_reg(msc, reg, bm);
>> +
>> +    /*
>> +     * ....and then the last (maybe) partial 32bit word. When wd is a
>> +     * multiple of 32, msb should be 31 to write a full 32bit word.
>> +     */
>> +    msb = (wd - 1) % 32;
>> +    bm = GENMASK(msb, 0);
>> +    if (bm)
>> +        __mpam_write_reg(msc, reg, bm);
> Drop the 'if' as the 0 bit will always be part of the mask.

Yup, this was a harmless leftover of the versions that tried to optionally write the left over bits.


>>   @@ -1419,7 +1541,7 @@ static void mpam_enable_once(void)
>>       mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>>         printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
>> -           mpam_partid_max + 1, mpam_pmg_max + 1);
>> +        READ_ONCE(mpam_partid_max) + 1, mpam_pmg_max + 1);
> 
> Belongs in 'arm_mpam: Probe MSCs to find the supported partid/pmg values'.

That value is now protected by a lock, and can't change at this point, so it no longer needs the READ_ONCE() anyway.


Thanks,

James

