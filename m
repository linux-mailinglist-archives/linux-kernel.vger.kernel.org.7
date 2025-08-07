Return-Path: <linux-kernel+bounces-759399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FCFB1DD05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7146A3B8F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF527380E;
	Thu,  7 Aug 2025 18:27:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA760271453
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591235; cv=none; b=LGOfc0a6V6AovT6JVMI+T5CbHXzaTTDGVn32ybPBZWoGRJ8GL0ZFIWW1KF1D8IC4AOT/28v0QIgpYHXtJLdSsw8/XDilli7uqfera7XlFfSKxyuGVqhWnJp+pWx1QpMC3dynHBZdRI/KVYVXdIhbSA1fxtAWG7iMw195j0e3UHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591235; c=relaxed/simple;
	bh=r1tB9aNjTLZ/EWhxtigsydBYEwQj0aorRKIY+uQcnWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDbu2gD4ZtsHdwRaeGqnOKBQpnYThyj8rBwoxMy69oBGIdchlEipOzT6r76aGhMbldlFx8u98N6FfJ+MFn3Ifb6YZPopAXwbF3sL0hj43qFhzNoC6SAgwnAFqmnmrlwslutFmfvMzwV8MD6GCwSECOOYFskrbztv+UvFaDlV0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D51561756;
	Thu,  7 Aug 2025 11:27:04 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF743F5A1;
	Thu,  7 Aug 2025 11:27:04 -0700 (PDT)
Message-ID: <48556d36-947b-4e07-aa7e-602bb9fe052d@arm.com>
Date: Thu, 7 Aug 2025 19:26:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/36] arm_mpam: Probe the hardware features resctrl
 supports
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
 <20250711183648.30766-21-james.morse@arm.com>
 <eb8a395c-ca21-43d2-a1f9-739dbdc26dc4@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <eb8a395c-ca21-43d2-a1f9-739dbdc26dc4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 24/07/2025 16:08, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> Expand the probing support with the control and monitor types
>> we can use with resctrl.

>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index 8646fb85ad09..61911831ab39 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c

>> @@ -645,6 +659,137 @@ static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc
>> *msc,
>>       return found;
>>   }
>>   +/*
>> + * IHI009A.a has this nugget: "If a monitor does not support automatic behaviour
>> + * of NRDY, software can use this bit for any purpose" - so hardware might not
>> + * implement this - but it isn't RES0.
>> + *
>> + * Try and see what values stick in this bit. If we can write either value,
>> + * its probably not implemented by hardware.
>> + */
>> +#define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg, _result)            \
>> +do {                                        \
>> +    u32 now;                                \
>> +    u64 mon_sel;                                \
>> +    bool can_set, can_clear;                        \
>> +    struct mpam_msc *_msc = _ris->vmsc->msc;                \
>> +                                        \
>> +    if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(_msc))) {            \
>> +        _result = false;                        \
>> +        break;                                \
>> +    }                                    \
>> +    mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |            \
>> +          FIELD_PREP(MSMON_CFG_MON_SEL_RIS, _ris->ris_idx);        \
>> +    mpam_write_monsel_reg(_msc, CFG_MON_SEL, mon_sel);            \
>> +                                        \
>> +    mpam_write_monsel_reg(_msc, _mon_reg, MSMON___NRDY);            \
>> +    now = mpam_read_monsel_reg(_msc, _mon_reg);                \
>> +    can_set = now & MSMON___NRDY;                        \
>> +                                        \
>> +    mpam_write_monsel_reg(_msc, _mon_reg, 0);                \
>> +    now = mpam_read_monsel_reg(_msc, _mon_reg);                \
>> +    can_clear = !(now & MSMON___NRDY);                    \
>> +    mpam_mon_sel_inner_unlock(_msc);                    \
>> +                                        \
>> +    _result = (!can_set || !can_clear);                    \
>> +} while (0)

> It is a bit surprising that something that looks like a function modifies a boolean passed
> by value.

> Consider continuing the pattern you have above:
> #define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg, _result)
> _mpam_ris_hw_probe_hw_nrdy(_ris, MSMON##_mon_reg, _result)
> 
> with signature:
> void _mpam_ris_hw_probe_hw_nrdy(struct mpam_msc *msc, u16 reg, bool *hw_managed);
> 
> and using the _mpam functions from the new _mpam_ris_hw_probe_hw_nrdy().

With that, it may as well return the result.
Done.


Thanks,

James

