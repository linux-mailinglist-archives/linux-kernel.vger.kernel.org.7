Return-Path: <linux-kernel+bounces-759819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D1B1E335
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D156A583515
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5424167B;
	Fri,  8 Aug 2025 07:19:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD7226D18
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637561; cv=none; b=GWWALbuUtsLENka83CH5sgOA1zBuNxjvzbNBc+2Njt08RDoLYYPhpTxUPhtrUY+FLtQZbtcR56y0LUnZxNQeagYsnOkefYXUzTAo5LKuYI8SHO7mB/EH1nx6WMZN7Mc7yYN7SZbPqbjkdT/H1BDT/cOYedqDrFrSvid3664zasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637561; c=relaxed/simple;
	bh=FSDO31C2YNAGynBE9R1VnUY7SmDxu9rI7I31Pgw8apQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcB46KzGNu/Lgv3umUi2lthf0Qt22ZAYrwOthdyJ49/lrw/vIn5y/VO4/suzCFwA8L1yn+W8eu3wTJ4XndfWKO6g2/iRJG6C0L/Czp0gXjuixVXB05CHE84xMTSlT1Jo80BP4HzFXYyoVdvfuwzQtbPCtim/oo8V7zuTTcY3D28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D96316F8;
	Fri,  8 Aug 2025 00:19:11 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29FC33F673;
	Fri,  8 Aug 2025 00:19:12 -0700 (PDT)
Message-ID: <ac2cea6e-db7e-4783-9d97-45ad16811f50@arm.com>
Date: Fri, 8 Aug 2025 08:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 33/36] arm_mpam: Use long MBWU counters if supported
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
 <20250711183648.30766-34-james.morse@arm.com>
 <b0e5db1b-e4cc-4f11-a81d-40f942eff78d@arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <b0e5db1b-e4cc-4f11-a81d-40f942eff78d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/07/2025 14:46, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> From: Rohit Mathew <rohit.mathew@arm.com>
>>
>> If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
>> the RIS, use long/LWD counter instead of the regular 31 bit mbwu
>> counter.
>>
>> Only 32bit accesses to the MSC are required to be supported by the
>> spec, but these registers are 64bits. The lower half may overflow
>> into the higher half between two 32bit reads. To avoid this, use
>> a helper that reads the top half twice to check for overflow.

> Slightly misleading as it may be read up to 4 times.

Meh - its referring to the high/low/high pattern. Sure if it fails you go round the whole
thing again. I'll change it 'read multiple times to check for overflow'.


>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index 774137a124f8..ace69ac2d0ee 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -1125,10 +1177,24 @@ static void __ris_msmon_read(void *arg)
>>           now = FIELD_GET(MSMON___VALUE, now);
>>           break;
>>       case mpam_feat_msmon_mbwu:
>> -        now = mpam_read_monsel_reg(msc, MBWU);
>> -        if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
>> -            nrdy = now & MSMON___NRDY;
>> -        now = FIELD_GET(MSMON___VALUE, now);
>> +        /*
>> +         * If long or lwd counters are supported, use them, else revert
>> +         * to the 32 bit counter.
>> +         */
> 32 bit counter -> 31 bit counter

Sure,


>> +        if (mpam_ris_has_mbwu_long_counter(ris)) {
>> +            now = mpam_msc_read_mbwu_l(msc);
>> +            if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
>> +                nrdy = now & MSMON___NRDY_L;
>> +            if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, rprops))
>> +                now = FIELD_GET(MSMON___LWD_VALUE, now);
>> +            else
>> +                now = FIELD_GET(MSMON___L_VALUE, now);
>> +        } else {
>> +            now = mpam_read_monsel_reg(msc, MBWU);
>> +            if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
>> +                nrdy = now & MSMON___NRDY;
>> +            now = FIELD_GET(MSMON___VALUE, now);
>> +        }
>>             if (nrdy)
>>               break;

>> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/
>> mpam_internal.h
>> index fc705801c1b6..4553616f2f67 100644
>> --- a/drivers/platform/arm64/mpam/mpam_internal.h
>> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
>> @@ -674,7 +675,10 @@ int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
>> cache_level,
>>    */
>>   #define MSMON___VALUE          GENMASK(30, 0)
>>   #define MSMON___NRDY           BIT(31)
>> -#define MSMON_MBWU_L_VALUE     GENMASK(62, 0)
>> +#define MSMON___NRDY_L        BIT(63)
>> +#define MSMON___L_VALUE        GENMASK(43, 0)
>> +#define MSMON___LWD_VALUE    GENMASK(62, 0)
>> +
> As mentioned on an earlier patch. These could be added with all the other register
> definition.

Yup,


Thanks,

James

