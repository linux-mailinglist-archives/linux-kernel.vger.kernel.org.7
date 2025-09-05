Return-Path: <linux-kernel+bounces-802033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37565B44CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C4017E32B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A1B224234;
	Fri,  5 Sep 2025 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mlQVVkhI"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A3524F;
	Fri,  5 Sep 2025 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048264; cv=none; b=NfQhtp0C39Xr49OMI6KMEyZL5HP/Ci36jn0BjK+th58y+opZtMhtlYlpJPLHx4Oa4iMkrnJfVbk226/3ZA9XmrXTPv3VAwA4cAGoH2gLs3m9grSqi0GVNiaAIIiXRlotO578wurZro83uPf4zbYfq8+RcUOLSMV/4OXBnIYeaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048264; c=relaxed/simple;
	bh=n0dNL3oloDSyIunfjHs2n+gwzdud1VN9yBk70QOdNZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p19//F9nDcLs/NAb9wsDw2puiRb8FU6etMEuAfV8FE81skldcGBIYjkfxlMHie1jVuUDFIJCvOxjs14X/jQ/pfTF34JiEnU33iGIy9ezYciieN+yb4XWw2UoUvmbjws+z5M948qJfWvFqre/aiylyZBp8cXfnI3ekqzgD8OUkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mlQVVkhI; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5854vZBA3175159;
	Thu, 4 Sep 2025 23:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757048255;
	bh=6alpJTsdiL+3pTmNUIBFVveDiDnMtePODNHGXEbcrY0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mlQVVkhIUVdgS4R5Yc/CrCNR08h3M2sxZYI4vNXDniUSMK4p+yF+dT+4qmFXfcRov
	 VYjxxdMgL02v0lQeiWO/kRnuxa0H/yG2ln17Zyb2m/eUjkaDuVrAKwOv3XVxgVcdjm
	 veW4J4SLtraYzt6uFQW3OHDCefM0zFsYY5MeVOr8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5854vZo4672405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 23:57:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 23:57:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 23:57:35 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5854vUAT190793;
	Thu, 4 Sep 2025 23:57:31 -0500
Message-ID: <8f0dc883-7bab-4ad8-8db2-6c8f8377fdb3@ti.com>
Date: Fri, 5 Sep 2025 10:27:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-4-a-kaur@ti.com>
 <b946af38-abf9-4b34-bf44-3ba9bc64bff7@ti.com>
 <b0ccb51f-14f4-43c9-9646-296d6e9d559c@ti.com>
 <f2e60ec2-5a1f-4cff-a8ee-c2555d835946@ti.com>
 <1a20e784-d2d7-46d7-b705-67e460b6ae33@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <1a20e784-d2d7-46d7-b705-67e460b6ae33@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/4/2025 7:16 PM, Akashdeep Kaur wrote:
> Hi Udit,
>
> On 04/09/25 18:06, Kumar, Udit wrote:
>>
>
> ...
>
>>> ...
>>>>>   #define PULLTYPESEL_SHIFT    (17)
>>>>>   #define RXACTIVE_SHIFT        (18)
>>>>> +#define DRV_STR_SHIFT           (19)
>>>>
>>>> referring to above TRM mentioned in commit message
>>>>
>>>> Bit 20-19 are for DRV_STR, and description says
>>>>
>>>> 0 - Default
>>>> 1 - Reserved
>>>> 2 - Reserved
>>>> 3 - Reserved
>>>>
>>>> Not sure, is there some additional document to be referred for 
>>>> PIN_DRIVE_STRENGTH
>>>
>>> This information will be updated in TRM in coming cycles.
>>
>>
>> Sorry ,
>>
>> can not ack before TRM update
>
> The information can be found at 
> https://www.ti.com/lit/ug/spruj83b/spruj83b.pdf in Table 14-8769. 
> Description Of The Pad Configuration Register Bit


Then please give correct reference in commit message



>
>>
>>
>>
>>>>
>>>>
>>>>> +#define DS_ISO_OVERRIDE_SHIFT (22)
>>>>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
>>>>
>
> ...
>
>>>>
>>>>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>>>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)
>>>
>>> Regards,
>>> Akashdeep Kaur
>
> Thanks,
> Akashdeep Kaur
>

