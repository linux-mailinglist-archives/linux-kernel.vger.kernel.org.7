Return-Path: <linux-kernel+bounces-800907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6BB43D96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925F11C853D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C9303C8F;
	Thu,  4 Sep 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QOADzU6h"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF1305E1E;
	Thu,  4 Sep 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993577; cv=none; b=p63/sq4ObCBrh8CbjT9Jewx8nemxnONKC5uhzXrZt3vjeDsfG9IFF42G762rJK3iTsTZsQu/kFbxUPBDL/wcRcjm37qpiRzylEkM8bXmxk7+3+4+JgTJOVgtSAcTU+kg1fGj5sgnPKf6CqFYQZ60Daq/zia5VGZk7lDyzigPWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993577; c=relaxed/simple;
	bh=xdJwCsFQ8t8Tm42dw9F0k3GjarbLHIcc5Gh7XTCoyEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cHkxOWzEeCt4x77AZz1dUdIO3wJZnGnJ+zLEVcMCNqsAGJxS2uODBqbBETqDwKq2y8jq0pgjBHs9FV6DOam+eRuWYsPtkhwBNOyJ/QJItppdVOyXgZRNmj4o0FRnwKO+/UFAN86aW9SiXeBbo2+fCzDqmbUg8m1Ack4UuO56jyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QOADzU6h; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584Dk96T3479535;
	Thu, 4 Sep 2025 08:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756993569;
	bh=L11aX+BB+qM1JXGrNxK4IIqPwXoq5+CWXGVYROLmJgs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QOADzU6hJGtS5drCUoNri8iBhZtuPVU7uXlMr5bZNUffj1der76zgwHFprUaLQE8B
	 HRKhuqlMM4k0ORwqSHpD6mpdaszF1WD/LXq9V8YqqA6OyaAdF311LZEliRmjnyeQ7C
	 0U0cYdotWlPbR1QBie/HTQOyzBuIIENZ3CzJYet4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584Dk93h3846174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:46:09 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:46:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:46:09 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584Dk4DQ3342464;
	Thu, 4 Sep 2025 08:46:05 -0500
Message-ID: <1a20e784-d2d7-46d7-b705-67e460b6ae33@ti.com>
Date: Thu, 4 Sep 2025 19:16:04 +0530
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
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <f2e60ec2-5a1f-4cff-a8ee-c2555d835946@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit,

On 04/09/25 18:06, Kumar, Udit wrote:
> 

...

>> ...
>>>>   #define PULLTYPESEL_SHIFT    (17)
>>>>   #define RXACTIVE_SHIFT        (18)
>>>> +#define DRV_STR_SHIFT           (19)
>>>
>>> referring to above TRM mentioned in commit message
>>>
>>> Bit 20-19 are for DRV_STR, and description says
>>>
>>> 0 - Default
>>> 1 - Reserved
>>> 2 - Reserved
>>> 3 - Reserved
>>>
>>> Not sure, is there some additional document to be referred for 
>>> PIN_DRIVE_STRENGTH
>>
>> This information will be updated in TRM in coming cycles.
> 
> 
> Sorry ,
> 
> can not ack before TRM update

The information can be found at 
https://www.ti.com/lit/ug/spruj83b/spruj83b.pdf in Table 14-8769. 
Description Of The Pad Configuration Register Bit

> 
> 
> 
>>>
>>>
>>>> +#define DS_ISO_OVERRIDE_SHIFT   (22)
>>>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
>>>

...

>>>
>>>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)
>>
>> Regards,
>> Akashdeep Kaur

Thanks,
Akashdeep Kaur


