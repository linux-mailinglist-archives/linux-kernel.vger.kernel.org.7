Return-Path: <linux-kernel+bounces-807053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4919B49F54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83F71BC24BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289532550AD;
	Tue,  9 Sep 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yS3MXcXI"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799525485F;
	Tue,  9 Sep 2025 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385656; cv=none; b=eVXMNuX/JEVeEnpShRhkXU0bvs+lr2rcoDpozLExYjUxaESZpsHSy3eU5EZjcMIarvSMeQgQDx7UC5SGsv8qShkfETCXk+sv+o3J75X7umaJosB0K+xt5L4KxB4SEkTDJW6gaDxK14cwza13jPGTUjKtIENTXmD+wmaK7rTrr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385656; c=relaxed/simple;
	bh=gCl9SVS2HpXGwCDosjXmt0N4y6WvCp6gsVXWLl/9Ohk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kOSu7OC1HLP+aXzzuVyX1IlYahCDPKiS++whplOJV8cZUGszPgTCp2zHVyo03k9LAWitlBXGJrK3QtybA+sQbiAb/g041UP9b5aMN3k76MbLkoFXHwvR6CTl/qdFF3HNoOZE3XztZenjroialpp6OpQokv+aLNsvbABDldt4mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yS3MXcXI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5892eoSU189023;
	Mon, 8 Sep 2025 21:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757385650;
	bh=oEuN3cjM/BEkZI5UyL8A+WNuDqsqCfNuIENBSMw2Vh4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yS3MXcXI4ouRo+FFvCPNxlLPTdJoyH/ekj8RpIj8XKbxdMJ6oIkKxeWhoHftm56kp
	 2u1qAK4pZ3nOZOBu8CN1ADhVeLm5kU+rqd32K2q2CP9jDoIuTPMeu47IYIBTZuGXns
	 x4NYcC1IQkfo/8nnHBaWlprvQzVtvFYCWIRmstx8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5892eojt3450612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 21:40:50 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 21:40:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 21:40:49 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5892eicK1581243;
	Mon, 8 Sep 2025 21:40:45 -0500
Message-ID: <836f7b6a-87ba-435a-9c5b-5be1f05114e8@ti.com>
Date: Tue, 9 Sep 2025 08:10:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: ti: k3-pinctrl: Fix the bug in
 existing macros
To: Vignesh Raghavendra <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <d-gole@ti.com>, <u-kumar1@ti.com>,
        <sebin.francis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250904112538.529857-1-a-kaur@ti.com>
 <20250904112538.529857-5-a-kaur@ti.com>
 <63c958a2-3973-4171-8a74-80381218723b@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <63c958a2-3973-4171-8a74-80381218723b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 08/09/25 12:26, Vignesh Raghavendra wrote:
> 
> 
> On 04/09/25 16:55, Akashdeep Kaur wrote:
>> Currently, DS_IO_OVERRIDE_EN_SHIFT macro is not defined anywhere but
>> used for defining other macro.
>> Replace this undefined macro with valid macro. Rename the existing macro
>> to reflect the actual behavior.
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>> ---
> 
> Fixes: 325aa0f6b36e ("arm64: dts: ti: k3-pinctrl: Introduce deep sleep macros")

Updated. Thanks!
> 
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> 
>>   arch/arm64/boot/dts/ti/k3-pinctrl.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> index 7c5b5783769c..36bb403d718e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> @@ -88,8 +88,8 @@
>>   
>>   #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
>>   #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
>> -#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
>> -#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
>> +#define PIN_DS_ISO_OVERRIDE_DISABLE     (0 << ISO_OVERRIDE_EN_SHIFT)
>> +#define PIN_DS_ISO_OVERRIDE_ENABLE      (1 << ISO_OVERRIDE_EN_SHIFT)
>>   #define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
>>   #define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
>>   #define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
> 


