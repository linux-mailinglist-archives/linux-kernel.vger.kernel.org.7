Return-Path: <linux-kernel+bounces-740890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5411B0DAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD8FAA1D95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F842E11BA;
	Tue, 22 Jul 2025 13:25:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D1C2628D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190728; cv=none; b=thw80Z4fypOlwE3OjDTpDtWzLAJkXcvxMweMzeoOYs6Q9mP4njIEKCZwwWrh4uc96Agkv4ZX/n0j+M8EJr8vSPM88PoZs2LqG0sZEUcNpJUoQnkhZC9CqHSU5XToNKdY6DiZWebBiYkyO3c3YyDPpdcS0D2ji4QhD2SWI4lFI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190728; c=relaxed/simple;
	bh=uJEL7e8991x5oJRpkfmEElhWLqxIccY4EE5xOeb221U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFgz4fSnYUTgJ5msoI18bWhGyECUOhsHMDoE+Oa8mZM+wrFT2pA9QlzE8wnzRYCdxDtq+q0dZ1gNPAx9ASjs0UAerf68Y6EepxI5bXf/qabjD0C2jIFUBrEd6bSLgqZSALztJdhmfmXUUX0E/IzcTsJtL5SVj1vzsOb/5TPy7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09304152B;
	Tue, 22 Jul 2025 06:25:20 -0700 (PDT)
Received: from [10.1.36.73] (Suzukis-MBP.cambridge.arm.com [10.1.36.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 570583F6A8;
	Tue, 22 Jul 2025 06:25:24 -0700 (PDT)
Message-ID: <8285b872-ecfa-42a6-9ead-e84ae409f79d@arm.com>
Date: Tue, 22 Jul 2025 14:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] coresight: Appropriately disable programming
 clocks
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-4-0ce0009c38f8@arm.com>
 <5a5f1355-563d-498a-9dec-3479a257b3e6@arm.com>
 <20250721104834.GC3137075@e132581.arm.com>
 <607c03a2-267c-46e6-a7fa-e733c1970e60@arm.com>
 <20250721135958.GE3137075@e132581.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250721135958.GE3137075@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2025 14:59, Leo Yan wrote:
> On Mon, Jul 21, 2025 at 12:40:38PM +0100, Suzuki Kuruppassery Poulose wrote:
>> On 21/07/2025 11:48, Leo Yan wrote:
>>> On Mon, Jul 21, 2025 at 10:15:22AM +0100, Suzuki Kuruppassery Poulose wrote:
>>>
>>> [...]
>>>
>>>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>>>> index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..dd2b4cc7a2b70cf060a3207548fe80e3824c489f 100644
>>>>> --- a/include/linux/coresight.h
>>>>> +++ b/include/linux/coresight.h
>>>>> @@ -480,26 +480,16 @@ static inline bool is_coresight_device(void __iomem *base)
>>>>>      * Returns:
>>>>>      *
>>>>>      * clk   - Clock is found and enabled
>>>>> - * NULL  - clock is not found
>>>>
>>>> This is still valid, right ?
>>>
>>> No. Since this patch uses devm_clk_get_enabled() to get a clock, if the
>>> pclk is not found, it returns -ENOENT (see of_parse_clkspec()).
>>>
>>> Only the optional clock APIs (e.g., devm_clk_get_optional_enabled())
>>> return a NULL pointer instead of -ENOENT when the clock is not found.
>>
>> This will break ACPI based systems, as we may not have a "pclk" described
>> for them. We should be able to tolerate "no pclk"
> 
> Get it. How about change the code like below?
> 
>    static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
>    {
>        struct clk *pclk;
> 
>        pclk = devm_clk_get_enabled(dev, "apb_pclk");
>        if (IS_ERR(pclk))
>            pclk = devm_clk_get_enabled(dev, "apb");
> 
>        /* Tolerate no pclk for ACPI device */
>        if ((pclk == ERR_PTR(-ENOENT)) && has_acpi_companion(dev))

That might be OK, please could you test this out ?




>            return NULL;
> 
>        return pclk;
>    }


