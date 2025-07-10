Return-Path: <linux-kernel+bounces-725870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CFB004D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0764E1888FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5E2727F3;
	Thu, 10 Jul 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rXXLgFMh"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5232E406;
	Thu, 10 Jul 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156758; cv=none; b=GoA6m2JnBU9/9QIXzdmO5znH9wYl26jjaUWlv/uKZeQegL50b/UiA/GbSlU0uFFp3DqzRz+fvosA7+FeCk2QbS1Jxds4Fyar9Gjo0iTSz1IG1nVb0hV8gil4mUw8ULZwOx9G6kVEf+jZGL7YUJXoW4SNYM8a1q2hGJh3f6k7lRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156758; c=relaxed/simple;
	bh=iKozaiL9sh8jKt5+uvD5I1rVybToAX8gjy95DkqtyAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q181hJ/sBOH3tEEfjLa9UCw3V1uR4Df0Fan6UuGTILF76XhChZKlQ9pNSQ4wgTVzbwKW8M1RIGkHWoYWZW3Q+mffNyL/U5ZjibEKTf4PrxpGPS5xJBL8EVJ2tC3trKb9HmjU+gtiYMQrktOs1dXFX3wFxwPGURMfwt4un4bARD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rXXLgFMh; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADjDNM019300;
	Thu, 10 Jul 2025 16:12:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	O5ZjyQ7fcMZjAROkYAzONVq5nvoucDwT2TJdOec8s3E=; b=rXXLgFMhk1ov1Kfb
	dTBEe6tPUeWMEyTgfS0G7zFjUM+QL0yg7etBY8ITbyxiDqeehrPFEFIabVnH/yx1
	qr8I2upEpkvHxqa6vgQenFp9tWWNaI0MwXGXi8QRPW3UoqzL6q52qYIHSlKpKc4F
	wUrfUNfw2SvnhcsY3LfChAtmNXnWJ5O+8jGGfjfmjwhdhedmiZdRmDzkpdS6m/UL
	zfdirhiA/S0NKY+G8uzZPOumn34Mnw6PwL76qDPyM8YSscSBTdQNCKLmqj4uWFLY
	031H+JPTMFXfD12CC0hDHTzVOeHA4hIa3G6QVyqnQfDg9w+TlB45QTaN7I1KpeKN
	JBH+cg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47qf0pxty6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:12:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA7F440044;
	Thu, 10 Jul 2025 16:11:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 002DFAF9A59;
	Thu, 10 Jul 2025 16:10:46 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:10:46 +0200
Message-ID: <6e44163a-eae3-49bb-8c05-32437d517451@foss.st.com>
Date: Thu, 10 Jul 2025 16:10:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: st: fix timer used for ticks
To: Marc Zyngier <maz@kernel.org>
CC: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250515151238.1.I85271ddb811a7cf73532fec90de7281cb24ce260@changeid>
 <86ikm2f0y2.wl-maz@kernel.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <86ikm2f0y2.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01

Hi Mark,

On 5/15/25 15:39, Marc Zyngier wrote:
> On Thu, 15 May 2025 14:12:39 +0100,
> Patrick Delaunay <patrick.delaunay@foss.st.com> wrote:
>> Remove always-on on generic ARM timer as the clock source provided by
>> STGEN is deactivated in low power mode, STOP1 by example.
>>
>> Fixes: 5d30d03aaf78 ("arm64: dts: st: introduce stm32mp25 SoCs family")
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
>> index 8d87865850a7..74c5f85b800f 100644
>> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
>> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
>> @@ -150,7 +150,7 @@ timer {
>>   			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>>   			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>>   			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
>> -		always-on;
>> +		arm,no-tick-in-suspend;
> That's amusing, because these two properties literally describe
> opposite behaviours (from an optimisation to a HW bug).
>
> I'm also pretty sure 99% of the DTs in the tree that have the
> always-on property are wrong.

yes it was a bug in the initial device tree, detected when we implement

the low power support in STMicroelectronics downtream.


STGEN, the root source of ARM generic timer in STM32MP25 is stopped in

low power states.


>
>>   	};
>>   
>>   	soc@0 {
> I don't want to sound rude or anything, but the guy you Cc'd on an
> @arm.com will not reply (and hasn't been replying for almost 6 years).

your not rude and It is my error, sorry

I search email for "Marc Zyngier " in Linux source tree....

and I use a bad address.


For information, I upstream this patch after the remark on patch by 
Christian Bruel:

[PATCH 3/3] arm64: dts: st: add st,stm32mp2-cortex-a7-gic in intc node in stm32mp251.dtsi
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250403122805.1574086-4-christian.bruel@foss.st.com/

 >   While reviewing a DT patch of mine related to the 
interrupt-controller, I had the following

  >  comment from Marc Zyngier (GIC Maintainer) " Then while you're at 
it, you may want to

  >  consider removing the "always-on" property in the timer, because 
I'm pretty sure the

   > comparator goes down in low power mode on A53 and A35, and loses 
its value.

 >   In general, only VMs can make use of this property. "



>
> Thanks,
>
> 	M.
>

Thanks


