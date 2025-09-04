Return-Path: <linux-kernel+bounces-800771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04206B43BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DA35A3373
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F072FDC3F;
	Thu,  4 Sep 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="moQ2N8/Z"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049282FE579;
	Thu,  4 Sep 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989426; cv=none; b=qS5y/mLOfA7HIdUTTjtPGV6+GVLRuSQwLtzuyELQZoDh6jBI6WeUVrVTMFvPys/M+Dv14XBI/Hm9LuNHuHNuE676ZkfOn8/gIZaa7snF4I30REcvbhxAM1SgcMar+P6UovvnPhgc2TLNn9goWS5/JHD5gDzDG0q8L0ikqqhHbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989426; c=relaxed/simple;
	bh=87SSrBtww/3Pcfse+37WJqauf4idj91HKOfl0CAMHQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iM2odDq4vAs86bavLtiIvGjdI1OSiE1uPbkJu+VPYqC6PZCCDa3zD4NUwAyKxg/0tVPBpwarEaOLqJXAn+0LhtSZswm2E6RUBPQMcHDVG4WvIc6txJ+EUorZpgpCljWUdaJxpeewqwYMZ1d1mY47aVqNCkJLD5GIy0ZFDtfiQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=moQ2N8/Z; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584Cau9e3011381;
	Thu, 4 Sep 2025 07:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756989416;
	bh=gvh/3eEZ++3Ko3LDIH91uXfAa26Cotcf789oGrJXSt4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=moQ2N8/Zf4xkfaLe82on02puG2f9bkEoDei5IEdZeZ9yfpuFopmQrf6QzTBS01Ym4
	 iuWYPS80PgYKgudL/UxAg4dGW4QJagLx147SG8EPIwigriVbdZJm2idzf8eKxaIFyU
	 Vtv5VSgOXnh5lI3SIMsCvHMolIk0sx7vCBjlR5sA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584Cau3e115570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 07:36:56 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 07:36:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 07:36:56 -0500
Received: from [10.250.148.210] ([10.250.148.210])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584CapOh2969517;
	Thu, 4 Sep 2025 07:36:51 -0500
Message-ID: <f2e60ec2-5a1f-4cff-a8ee-c2555d835946@ti.com>
Date: Thu, 4 Sep 2025 18:06:50 +0530
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
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <b0ccb51f-14f4-43c9-9646-296d6e9d559c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/4/2025 5:09 PM, Akashdeep Kaur wrote:
> Hi Udit,
>
> On 04/09/25 14:27, Kumar, Udit wrote:
>> Hello Akashdeep,
>>
>> On 9/2/2025 12:49 PM, Akashdeep Kaur wrote:
>>> Add the drive stregth, schmitt trigger enable macros to pinctrl file.
>>> Add the missing macros for DeepSleep configuration control referenced
>>> from "Table 14-6172. Description Of The Pad Configuration Register 
>>> Bits"
>>> in AM625 TRM[0].
>>> Add some DeepSleep macros to provide combinations that can be used
>>> directly in device tree files example PIN_DS_OUTPUT_LOW that
>>> configures pin to be output and also sets its value to 0.
>>>
>>> [0] https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf
> ...
>>>   #define PULLTYPESEL_SHIFT    (17)
>>>   #define RXACTIVE_SHIFT        (18)
>>> +#define DRV_STR_SHIFT           (19)
>>
>> referring to above TRM mentioned in commit message
>>
>> Bit 20-19 are for DRV_STR, and description says
>>
>> 0 - Default
>> 1 - Reserved
>> 2 - Reserved
>> 3 - Reserved
>>
>> Not sure, is there some additional document to be referred for 
>> PIN_DRIVE_STRENGTH
>
> This information will be updated in TRM in coming cycles.


Sorry ,

can not ack before TRM update



>>
>>
>>> +#define DS_ISO_OVERRIDE_SHIFT   (22)
>>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
>>
>> Please follow same convention as for rest of bit fields
>
> Updated.
>
>>
>> DS_ISO_OVERRIDE_SHIFT  to ISO_OVR_SHIFT and
>> DS_ISO_BYPASS_EN_SHIFT to ISO_BYP_SHIFT
>>
>>
>>
>>>   #define DEBOUNCE_SHIFT        (11)
>>>   #define FORCE_DS_EN_SHIFT    (15)
>>>   #define DS_EN_SHIFT        (24)
>>> @@ -19,6 +24,7 @@
>>>   #define DS_OUT_VAL_SHIFT    (26)
>>>   #define DS_PULLUD_EN_SHIFT    (27)
>>>   #define DS_PULLTYPE_SEL_SHIFT    (28)
>>> +#define WKUP_EN_SHIFT           (29)
>>>   /* Schmitt trigger configuration */
>>>   #define ST_DISABLE        (0 << ST_EN_SHIFT)
>>> @@ -33,6 +39,26 @@
>>>   #define INPUT_EN        (1 << RXACTIVE_SHIFT)
>>>   #define INPUT_DISABLE        (0 << RXACTIVE_SHIFT)
>>> +#define DS_PULL_DISABLE         (1 << DS_PULLUD_EN_SHIFT)
>>> +#define DS_PULL_ENABLE          (0 << DS_PULLUD_EN_SHIFT)
>>
>> what is purpose of shifting zero,
> This is added for consistency across the entire file.
>>
>>
>>> +
>>> +#define DS_PULL_UP              (1 << DS_PULLTYPE_SEL_SHIFT | 
> ...
>>> +#define PIN_DS_OUT_DISABLE DS_INPUT_EN
>>>   #define PIN_DS_OUT_VALUE_ZERO        (0 << DS_OUT_VAL_SHIFT)
>>>   #define PIN_DS_OUT_VALUE_ONE        (1 << DS_OUT_VAL_SHIFT)
>>>   #define PIN_DS_PULLUD_ENABLE        (0 << DS_PULLUD_EN_SHIFT)
>>>   #define PIN_DS_PULLUD_DISABLE        (1 << DS_PULLUD_EN_SHIFT)
>>>   #define PIN_DS_PULL_DOWN        (0 << DS_PULLTYPE_SEL_SHIFT)
>>>   #define PIN_DS_PULL_UP            (1 << DS_PULLTYPE_SEL_SHIFT)
>>> +#define PIN_DS_ISO_BYPASS               (1 << DS_ISO_BYPASS_EN_SHIFT)
>>> +#define PIN_DS_ISO_BYPASS_DISABLE       (0 << DS_ISO_BYPASS_EN_SHIFT)
>>> +
>>> +#define DS_STATE_VAL                    (1 << DS_EN_SHIFT)
>>> +#define ACTIVE_STATE_VAL                (0 << DS_EN_SHIFT)
>>> +
>>
>> Please do not mix PIN_x #define with other internal defines
>
> Moved these to appropriate location.
>
>>
>>> +#define PIN_DS_OUTPUT_LOW (DS_STATE_VAL | DS_INPUT_DISABLE | 
>>> DS_OUT_VALUE_ZERO)
>>> +#define PIN_DS_OUTPUT_HIGH              (DS_STATE_VAL | 
>>> DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
>>> +#define PIN_DS_INPUT                    (DS_STATE_VAL | DS_INPUT_EN 
>>> | DS_PULL_DISABLE)
>>> +#define PIN_DS_INPUT_PULLUP             (DS_STATE_VAL | DS_INPUT_EN 
>>> | DS_PULL_UP)
>>> +#define PIN_DS_INPUT_PULLDOWN           (DS_STATE_VAL | DS_INPUT_EN 
>>> | DS_PULL_DOWN)
>>> +
>>> +#define PIN_WKUP_EN_EDGE                (WKUP_ENABLE | WKUP_ON_EDGE)
>>> +#define PIN_WKUP_EN_LEVEL_LOW           (WKUP_ENABLE | 
>>> WKUP_ON_LEVEL | WKUP_LEVEL_LOW)
>>> +#define PIN_WKUP_EN_LEVEL_HIGH          (WKUP_ENABLE | 
>>> WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
>>> +#define PIN_WKUP_EN                     WKUP_EN_EDGE
>>
>> what is difference between PIN_WKUP_EN_EDGE and PIN_WKUP_EN
> Combined the macros to have default wakeup on edge
>>
>>
>>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)
>
> Regards,
> Akashdeep Kaur

