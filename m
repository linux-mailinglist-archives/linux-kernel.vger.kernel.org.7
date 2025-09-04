Return-Path: <linux-kernel+bounces-800660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66050B43A43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B473A2D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C62FC024;
	Thu,  4 Sep 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a9vi+594"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D92D47EA;
	Thu,  4 Sep 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985515; cv=none; b=Y9n6JP1hNPlUwpESrnWA7T+0ufmwvo5vOjHpepAcunCojCKTsZCX8iyzPQhB+Zlq/8XonTTgAsaUrC/cvVdFxlIZi9SqMDAjwC6FejpsruQvAqIb8WAGFOCRN+c3XUY9gs/Tgm7VXAsGlzHPtMdnGULQ65eZaLnrr+aKosW6UAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985515; c=relaxed/simple;
	bh=LmhANGAvdkx8I37zhk+I6LOaY8kFbQK/qmlH3pw93VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X2ETNq0QbCIqqVy70IugLZlaFnRIpdURfwiHApejERbCXhb6h200nPmLk1M5ZrVsCWz3TExrDla58PjJE6/yweLZllsAGqQlH5Q0I167x6od/PkKW2WC/ZAv2joI90d/srtsHFi+2DUXhnw0vfGgGXmi4jqZS0IUd0Po+BaFq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a9vi+594; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584BVmlt3001597;
	Thu, 4 Sep 2025 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756985508;
	bh=NvegV1zH8Pm8zagK+KRhg5cfI8kiWJq/medlBOhtErU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=a9vi+5949lMcJ6oo6WuLcXO9OrgPQaRY56bFvPalciMZ5rk9bbw4dxAfho4y4EXv4
	 OIzkqtCDU4rZ6j40OOqCwL0StcUBI9rVLhdJEU5TvPpxePQcx/si8hsS+Lts4e+0x4
	 Sa9kUL27PFf1YWV4kGkbcbyCCGlfrr6WcF7mYVOI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584BVmch138335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 06:31:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 06:31:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 06:31:47 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584BVhNb3188138;
	Thu, 4 Sep 2025 06:31:44 -0500
Message-ID: <61954361-6aad-4761-967e-629cd288e33d@ti.com>
Date: Thu, 4 Sep 2025 17:01:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
To: Sebin Francis <sebin.francis@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-4-a-kaur@ti.com>
 <c5dd1c02-8538-4b9f-a453-d18e7a30ae30@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <c5dd1c02-8538-4b9f-a453-d18e7a30ae30@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Sebin,

On 04/09/25 11:32, Sebin Francis wrote:
> Hi Akash,
> 
> On 02/09/25 12:49, Akashdeep Kaur wrote:
>> Add the drive stregth, schmitt trigger enable macros to pinctrl file.
>> Add the missing macros for DeepSleep configuration control referenced
>> from "Table 14-6172. Description Of The Pad Configuration Register Bits"
>> in AM625 TRM[0].
>> Add some DeepSleep macros to provide combinations that can be used
>> directly in device tree files example PIN_DS_OUTPUT_LOW that
>> configures pin to be output and also sets its value to 0.
>>
>> [0] https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
...

>> +#define WKUP_ON_EDGE            (0 << WKUP_LVL_EN_SHIFT)
>> +#define WKUP_LEVEL_LOW          (0 << WKUP_LVL_POL_SHIFT)
>> +#define WKUP_LEVEL_HIGH         (1 << WKUP_LVL_POL_SHIFT)
>> +
>> +#define WKUP_DISABLE            (0 << WKUP_EN_SHIFT)
> 
> This can be moved below WKUP_ENABLE macro to be consistent
Moved. Thanks
> 
>> +
>>   /* Only these macros are expected be used directly in device tree 
>> files */
>>   #define PIN_OUTPUT        (INPUT_DISABLE | PULL_DISABLE)
>>   #define PIN_OUTPUT_PULLUP    (INPUT_DISABLE | PULL_UP)
...
> ...
>> +#define DS_STATE_VAL                    (1 << DS_EN_SHIFT)
>> +#define ACTIVE_STATE_VAL                (0 << DS_EN_SHIFT)
> 
> These can be moved to the top before PIN_* and can be renamed to 
> DS_STATE_EN and DS_STATE_DIS
Moved and renamed.>> +
>> +#define PIN_DS_OUTPUT_LOW               (DS_STATE_VAL | 
>> DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
...
>> +#define PIN_WKUP_EN_LEVEL_HIGH          (WKUP_ENABLE | WKUP_ON_LEVEL 
>> | WKUP_LEVEL_HIGH)
>> +#define PIN_WKUP_EN                     WKUP_EN_EDGE
> 
> As EDGE wake is used commonly we can use the PIN_WKUP_EN_EDGE in this case
That's a good idea. Changed.
> 
>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>   #define PIN_GPIO_RANGE_IOPAD    (PIN_INPUT | 7)
> 
> Thanks
> Sebin

Regards,
Akashdeep Kaur

