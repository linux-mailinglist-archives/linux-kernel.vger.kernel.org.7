Return-Path: <linux-kernel+bounces-802050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C841AB44D29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136497AA040
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8926F2B3;
	Fri,  5 Sep 2025 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="acMGw2xd"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37832AD00;
	Fri,  5 Sep 2025 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049543; cv=none; b=Lr9Qp6I59UVo6m/WNVrzcH8yUs9xKlbbEgpa5GQOxDZ2L5wsyyslJezcaNTcOEE1AUzZot7pvAyLCwi+TAkBOfzn2+G8/iB1ldoj0TdwvFMOJmFBDTMjmI3SZaFEuAuWkT5EONV+ERb0tLm+oYkIToQnc2LVj4rrcLga+Xu80bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049543; c=relaxed/simple;
	bh=0YbkTawyBInt9pUJ4jTW71f6Pk62hnb+ysAfsC1fzN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u9UHli8bNJjb5ZJ3fp8zMpRv8ONf++C/sfJtHXoyM17LHxeaolYTFAcFbMfZQPziIaaLMPvW8Ew1BUveJwNpROGqJfZdJp9XdN9wGzr5G9akNt00Zuxgfy81SiukXAO0+ABE6A2ACJP0o01kzqmCaF9B6jL2vP5Qs7Q9w5v+hE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=acMGw2xd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855IuWq3246080;
	Fri, 5 Sep 2025 00:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049536;
	bh=g/CjdO2oLUs6Kl6KrkstjG0mM0TAx6J8bSMY2vPc0j8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=acMGw2xddVqQt7//RKIZrvQ6Lu9HqXwl3RonGQ1UWoivS39hj/O9pO6gKzXmLR4zE
	 G6YWaKA72SxroV0q2K7SvM0cl9Q5WMaPFaE+q6uGgUrjMM1/44/qkrTSwUWeEfGuNE
	 mumn1EULm8kavxfXEPK9ZYHCh9OHKdyUAdKLrRbc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855IuvW688344
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:18:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:18:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:18:55 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855IpZV4124087;
	Fri, 5 Sep 2025 00:18:52 -0500
Message-ID: <9e0c355c-8b19-438e-98d9-d6290a562863@ti.com>
Date: Fri, 5 Sep 2025 10:48:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
To: "Kumar, Udit" <u-kumar1@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-4-a-kaur@ti.com>
 <b946af38-abf9-4b34-bf44-3ba9bc64bff7@ti.com>
 <b0ccb51f-14f4-43c9-9646-296d6e9d559c@ti.com>
 <f2e60ec2-5a1f-4cff-a8ee-c2555d835946@ti.com>
 <1a20e784-d2d7-46d7-b705-67e460b6ae33@ti.com>
 <8f0dc883-7bab-4ad8-8db2-6c8f8377fdb3@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <8f0dc883-7bab-4ad8-8db2-6c8f8377fdb3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 05/09/25 10:27, Kumar, Udit wrote:
> 
> On 9/4/2025 7:16 PM, Akashdeep Kaur wrote:
>> Hi Udit,
>>
>> On 04/09/25 18:06, Kumar, Udit wrote:
>>>
>>
>> ...
>>
>>>> ...
>>>>>>   #define PULLTYPESEL_SHIFT    (17)
>>>>>>   #define RXACTIVE_SHIFT        (18)
>>>>>> +#define DRV_STR_SHIFT           (19)
>>>>>
>>>>> referring to above TRM mentioned in commit message
>>>>>
>>>>> Bit 20-19 are for DRV_STR, and description says
>>>>>
>>>>> 0 - Default
>>>>> 1 - Reserved
>>>>> 2 - Reserved
>>>>> 3 - Reserved
>>>>>
>>>>> Not sure, is there some additional document to be referred for 
>>>>> PIN_DRIVE_STRENGTH
>>>>
>>>> This information will be updated in TRM in coming cycles.
>>>
>>>
>>> Sorry ,
>>>
>>> can not ack before TRM update
>>
>> The information can be found at https://www.ti.com/lit/ug/spruj83b/ 
>> spruj83b.pdf in Table 14-8769. Description Of The Pad Configuration 
>> Register Bit
> 
> 
> Then please give correct reference in commit message

Updated the commit message!

> 
> 
> 
>>
>>>
>>>
>>>
>>>>>
>>>>>
>>>>>> +#define DS_ISO_OVERRIDE_SHIFT (22)
>>>>>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
>>>>>
>>
>> ...
>>
>>>>>
>>>>>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>>>>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)
>>>>
>>>> Regards,
>>>> Akashdeep Kaur
>>
>> Thanks,
>> Akashdeep Kaur
>>


