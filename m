Return-Path: <linux-kernel+bounces-794572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13310B3E37D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F6170604
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE03115B1;
	Mon,  1 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ErltRGBl"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973112727E0;
	Mon,  1 Sep 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730452; cv=none; b=B0L2Lao8Ms6mjY7D5BH8txzVsa0TKJE/5eVTkvTYETuE39JPTRRFc7RvFojiqtya8LkmfrneQoIlA0vqy6Tyl+kCka/slmXxeOo59tZKNsw5GNHUY3n8Gku6LHezC5Q9L8fGwgFTMoBa8RlnW5mTwno1HIreYiv19i5KNobg/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730452; c=relaxed/simple;
	bh=2FDnfrFiLbTm49VKnjy9DfM2HwLowa/ASGrSzPO+Yw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NaGOS5Md2BV72/AxaThaymBsFR7YNOhvm6K/Q7FXaZt2tw5CGW/fO5jpxTa2K6m4EtjPxVWqc4bODNyw+G10999+pEadAAQbxJi4OECB44Dshg6YlmZrGmPw6+naFYAoHe+vhxNKG3BJweLk+TDMswDgK5YGKtNcGDnos8TncwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ErltRGBl; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581Ceiq22313308;
	Mon, 1 Sep 2025 07:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756730445;
	bh=2f0pF4cOVRp5vftRAMP0k7Ja9Wy98twL5qtX3adsjD8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ErltRGBlZn4R/Qp0YST6wzboF1YcJNhSSsKAcidGkJ4SyhIyykt+CEmrnoiHWGprA
	 Ak3AoMjMdXaNnv5b0JagdddV7Qf/dQC98obYDIa/6zxh1BwNNyoAsNGVSW0nW5uMvi
	 JHIBTDbmdlGWlUAv5RGFEvaEnQmR+bRo3pzHTnFc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581Cei8K2728081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:40:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:40:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:40:44 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581CeeOl2237214;
	Mon, 1 Sep 2025 07:40:40 -0500
Message-ID: <9b3cd9d9-c163-47ba-b979-e1ba8ad5ccbc@ti.com>
Date: Mon, 1 Sep 2025 18:10:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62x-sk-common: Remove the unused
 config from USB1_DRVVBUS
To: Dhruva Gole <d-gole@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>
References: <20250731115631.3263798-1-a-kaur@ti.com>
 <20250731115631.3263798-3-a-kaur@ti.com>
 <20250813131530.apibc4p6t2uo5bkr@lcpd911>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20250813131530.apibc4p6t2uo5bkr@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dhruva,

On 13/08/25 18:45, Dhruva Gole wrote:
> On Jul 31, 2025 at 17:26:30 +0530, Akashdeep Kaur wrote:
>> After the SoC has entered the Deep Sleep mode, USB1 can be used to wakeup
> 
> Just leaving my comments on the commit message here since 1st patch
> seems to be pretty much the same commit message.
> 
> Let's reword this as --> Deep Sleep low power mode.
> Makes it a bit more clear.

> 
>> the SoC based on USB events triggered by USB devices. This requires that
>> the pin corresponding to the Type-A connector remains pulled up even after
>> the SoC has entered the Deep Sleep mode.
>> For that, either deep Sleep pullup can be selected or the pin can have the
> 
> Nit: Be consistent with either deep sleep, or Deep Sleep, don't mix case.
> Also, please can we talk here in terms of exactly which macros we're
> talking about? For eg. if deep sleep pullup == PIN_DS_PULLUD_ENABLE, then
> please mention that in a bracket or something for people who may not
> necessarily be aware of all these terms.
Reworded at all instances to TRM mentioned DeepSleep>
>> same configuration that it had when SoC was in active mode.
>> In order for deep sleep configuration to take effect, the deep sleep
>> control bit has to be enabled.
> 
> Please talk with some references, because not everyone will be able to
> follow what we mean by deep sleep control bit/ deep sleep configuration.
> 
>> Remove the deep sleep state configuration from USB1_DRVBUS pin as it is
>> anyways not taking effect (deep sleep control bit is not set).
>>
>> This reverts commit 527f884d2d94981016e181dcbd4c4b5bf597c0ad.
> 
> And so are you in conclusion saying that this patch is just unnecessary/
> useless? The bracket message feels to me that you are saying that if we set
> the deep sleep control bit this patch will start working as expected?
> Please can you clarify a bit on that end?
The intent was that there is no need to set the DeepSleep control bit. 
Also, if that bit is not set, then the current setting is ignored by 
hardware.
> 
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 13e1d36123d5..d3bed23134ca 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -249,7 +249,7 @@ AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19/V15) RGMII1_TX_CTL */
>>   
>>   	main_usb1_pins_default: main-usb1-default-pins {
>>   		pinctrl-single,pins = <
>> -			AM62X_IOPAD(0x0258, PIN_OUTPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (F18/E16) USB1_DRVVBUS */
>> +			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
>>   		>;
>>   	};
>>   
> 
> Sorry for the long review on the commit message, but context feels like
> everything when it comes to small patches. Hence trying to make sure
> everyone understands what's being done here... :)
> 

Regards,
Akashdeep Kaur


