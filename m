Return-Path: <linux-kernel+bounces-800674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE815B43A59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942FA3AF7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1E2D9EE7;
	Thu,  4 Sep 2025 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XVQSIxjc"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335B199FAB;
	Thu,  4 Sep 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985964; cv=none; b=aqKr02kzbQNCmzhxZhxzTdFBexrURirne4Z7AU52EqV4WmQZ88mBfUjWvyM7I99H8ZEzXkVZhzz4tdQKxTGor6t2D4twSXILaKPmpM/2z+yVoPtMJbfA40AflCb5TStSjCrrABwi1SIydu2/D0rnAtccxutg1JpmzVWFe7yh8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985964; c=relaxed/simple;
	bh=2U5CDPjzMznv+UvEAc5er/yLZ1DQhSBNife/xt5jUeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GP5sQFwCSgXcglQ/wVe9TL28iDj7AyFgvpH5dkn6HpB3hWKyLAfxWQTQvpieBr9IM/yhiHgRIAknOIACcqpeEpWM6+emNeQDY9QusyGKfk0jcq9JSW6vCx6j5Lbdr/1j1zPKGW3pHoh4zxrDAi23xNPqw4dkbz0EH1EToc1DmjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XVQSIxjc; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584BdGe03065055;
	Thu, 4 Sep 2025 06:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756985956;
	bh=lZfF/R1zkJ9I0QIH48kfv3UNizAJBc+dQQgfeHqphm0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XVQSIxjcZzBKVfvpPw3T6boKWKnuJ56UGQe0lIyzw+Rxx9Fr3epsBxfpxtUaDaf9J
	 R+snO8+M7jBzLm5obedp3HJWLC5uk90Fq033r/kX2fwBI3GUAbG69TSYyujJNyLWCh
	 P3i1rXnbD3fGqPojIxLD9Yd5urdzIUZR+Fu3U9rA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584BdGiH141119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 06:39:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 06:39:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 06:39:15 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584BdBOA2904556;
	Thu, 4 Sep 2025 06:39:12 -0500
Message-ID: <b0ccb51f-14f4-43c9-9646-296d6e9d559c@ti.com>
Date: Thu, 4 Sep 2025 17:09:11 +0530
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
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <b946af38-abf9-4b34-bf44-3ba9bc64bff7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit,

On 04/09/25 14:27, Kumar, Udit wrote:
> Hello Akashdeep,
> 
> On 9/2/2025 12:49 PM, Akashdeep Kaur wrote:
>> Add the drive stregth, schmitt trigger enable macros to pinctrl file.
>> Add the missing macros for DeepSleep configuration control referenced
>> from "Table 14-6172. Description Of The Pad Configuration Register Bits"
>> in AM625 TRM[0].
>> Add some DeepSleep macros to provide combinations that can be used
>> directly in device tree files example PIN_DS_OUTPUT_LOW that
>> configures pin to be output and also sets its value to 0.
>>
>> [0] https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf
...
>>   #define PULLTYPESEL_SHIFT    (17)
>>   #define RXACTIVE_SHIFT        (18)
>> +#define DRV_STR_SHIFT           (19)
> 
> referring to above TRM mentioned in commit message
> 
> Bit 20-19 are for DRV_STR, and description says
> 
> 0 - Default
> 1 - Reserved
> 2 - Reserved
> 3 - Reserved
> 
> Not sure, is there some additional document to be referred for 
> PIN_DRIVE_STRENGTH

This information will be updated in TRM in coming cycles.
> 
> 
>> +#define DS_ISO_OVERRIDE_SHIFT   (22)
>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
> 
> Please follow same convention as for rest of bit fields

Updated.

> 
> DS_ISO_OVERRIDE_SHIFT  to ISO_OVR_SHIFT and
> DS_ISO_BYPASS_EN_SHIFT to ISO_BYP_SHIFT
> 
> 
> 
>>   #define DEBOUNCE_SHIFT        (11)
>>   #define FORCE_DS_EN_SHIFT    (15)
>>   #define DS_EN_SHIFT        (24)
>> @@ -19,6 +24,7 @@
>>   #define DS_OUT_VAL_SHIFT    (26)
>>   #define DS_PULLUD_EN_SHIFT    (27)
>>   #define DS_PULLTYPE_SEL_SHIFT    (28)
>> +#define WKUP_EN_SHIFT           (29)
>>   /* Schmitt trigger configuration */
>>   #define ST_DISABLE        (0 << ST_EN_SHIFT)
>> @@ -33,6 +39,26 @@
>>   #define INPUT_EN        (1 << RXACTIVE_SHIFT)
>>   #define INPUT_DISABLE        (0 << RXACTIVE_SHIFT)
>> +#define DS_PULL_DISABLE         (1 << DS_PULLUD_EN_SHIFT)
>> +#define DS_PULL_ENABLE          (0 << DS_PULLUD_EN_SHIFT)
> 
> what is purpose of shifting zero,
This is added for consistency across the entire file.
> 
> 
>> +
>> +#define DS_PULL_UP              (1 << DS_PULLTYPE_SEL_SHIFT | 
...
>> +#define PIN_DS_OUT_DISABLE        DS_INPUT_EN
>>   #define PIN_DS_OUT_VALUE_ZERO        (0 << DS_OUT_VAL_SHIFT)
>>   #define PIN_DS_OUT_VALUE_ONE        (1 << DS_OUT_VAL_SHIFT)
>>   #define PIN_DS_PULLUD_ENABLE        (0 << DS_PULLUD_EN_SHIFT)
>>   #define PIN_DS_PULLUD_DISABLE        (1 << DS_PULLUD_EN_SHIFT)
>>   #define PIN_DS_PULL_DOWN        (0 << DS_PULLTYPE_SEL_SHIFT)
>>   #define PIN_DS_PULL_UP            (1 << DS_PULLTYPE_SEL_SHIFT)
>> +#define PIN_DS_ISO_BYPASS               (1 << DS_ISO_BYPASS_EN_SHIFT)
>> +#define PIN_DS_ISO_BYPASS_DISABLE       (0 << DS_ISO_BYPASS_EN_SHIFT)
>> +
>> +#define DS_STATE_VAL                    (1 << DS_EN_SHIFT)
>> +#define ACTIVE_STATE_VAL                (0 << DS_EN_SHIFT)
>> +
> 
> Please do not mix PIN_x #define with other internal defines

Moved these to appropriate location.

> 
>> +#define PIN_DS_OUTPUT_LOW               (DS_STATE_VAL | 
>> DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
>> +#define PIN_DS_OUTPUT_HIGH              (DS_STATE_VAL | 
>> DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
>> +#define PIN_DS_INPUT                    (DS_STATE_VAL | DS_INPUT_EN | 
>> DS_PULL_DISABLE)
>> +#define PIN_DS_INPUT_PULLUP             (DS_STATE_VAL | DS_INPUT_EN | 
>> DS_PULL_UP)
>> +#define PIN_DS_INPUT_PULLDOWN           (DS_STATE_VAL | DS_INPUT_EN | 
>> DS_PULL_DOWN)
>> +
>> +#define PIN_WKUP_EN_EDGE                (WKUP_ENABLE | WKUP_ON_EDGE)
>> +#define PIN_WKUP_EN_LEVEL_LOW           (WKUP_ENABLE | WKUP_ON_LEVEL 
>> | WKUP_LEVEL_LOW)
>> +#define PIN_WKUP_EN_LEVEL_HIGH          (WKUP_ENABLE | WKUP_ON_LEVEL 
>> | WKUP_LEVEL_HIGH)
>> +#define PIN_WKUP_EN                     WKUP_EN_EDGE
> 
> what is difference between PIN_WKUP_EN_EDGE and PIN_WKUP_EN
Combined the macros to have default wakeup on edge
> 
> 
>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)

Regards,
Akashdeep Kaur

