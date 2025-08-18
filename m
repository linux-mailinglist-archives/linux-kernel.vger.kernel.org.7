Return-Path: <linux-kernel+bounces-773792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81921B2A9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC6B683644
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725E345750;
	Mon, 18 Aug 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LSkl7hrw"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27494345728;
	Mon, 18 Aug 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525872; cv=none; b=ICbLQd2a+kZFDOFUxIzZLYltAdF0o9wGdyGbmaEB2PZbJ1ahDpuENHi0rvuUuXe898xIxwS/xwjtSGWrui2FIiYqgXLM8nDEky+jF5aJiUeVcK35EkElnEuvdptNo+Psxl+W7k+oc8zluFLM+0D71+XzsceXDvO/IGt/NEryC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525872; c=relaxed/simple;
	bh=OfjWWNW0FYxKl7Mc46vXvdZYAz7olG2xgHrBehp2UIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rF5Mjv3C3LVCIcdsy2RGbLf6VfenYkJFFfYSuHNx4OkGsK3/OEhUhpPTpDMj7G3cSYDvuBZVAfjuIcQdWZkFYzLvZfvsci6EyJUrutx/PoD50jHLZkFntIdr4qy9R6ptZKd7lNebOBqD7UQ+zdLmk9tEdunkKU1B2ccl1Hwjxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LSkl7hrw; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDFlnc021385;
	Mon, 18 Aug 2025 16:04:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	SrMH3SB1Lk0TWtcGskbizL8CHJwognrV8tAWHyAvW4Q=; b=LSkl7hrwGpJl1uPA
	IrjZ+Qwc1jbo+MVCSaB5vRbb8wdQQR77lPH5ESudCq+I5qggaWEX24lNvAmNtaDx
	QoOdOU+pCtS2hYv4yDwundMwZUCtCGYc1lHhfzTaMOe+K+TXOy4NnrrtmOncAIIL
	DOsyrNL0ULZBcmgsOwyjgwK50zAKV6XuW3yU/c4sN0smn1tMfdR/CFstFmN0NpaW
	0vgEHiMbdByKcEeT+zYJH4ph6LeQTV3tdHYAI9IEKwHH03h1zYCtdMoOw4Mkr9lj
	jp6kU5ewO+U1dGUbCiLYiVkz5CLvSImFslxncyKpX0s5Y27kW1le8ab7S++KQ3PK
	oysCLA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48k4xmmefk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:04:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6D7E640048;
	Mon, 18 Aug 2025 16:03:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AFDFA7383ED;
	Mon, 18 Aug 2025 16:02:48 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 16:02:47 +0200
Message-ID: <c390d61f-7f07-43d5-b212-92a5936dc16a@foss.st.com>
Date: Mon, 18 Aug 2025 16:02:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: sti: removal of stih415/stih416 related
 entries
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Alain Volmat <avolmat@me.com>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
 <20250714-sti-rework-v2-2-f4274920858b@gmail.com>
 <b80cc04f-aa80-4124-97de-846bebc271a2@foss.st.com>
Content-Language: en-US
In-Reply-To: <b80cc04f-aa80-4124-97de-846bebc271a2@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01



On 7/28/25 11:25, Patrice CHOTARD wrote:
> 
> 
> On 7/14/25 15:49, Raphael Gallais-Pou wrote:
>> From: Alain Volmat <avolmat@me.com>
>>
>> ST's STiH415 and STiH416 platforms have already been removed since
>> a while.  Remove some remaining bits within the mach-sti.
>>
>> Signed-off-by: Alain Volmat <avolmat@me.com>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>  arch/arm/mach-sti/Kconfig    | 20 +-------------------
>>  arch/arm/mach-sti/board-dt.c |  2 --
>>  2 files changed, 1 insertion(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
>> index b3842c971d31b80edaf88ab907f4377bea0a2af5..e58699e13e1a55ce46e68908c7ef51e18b040dc9 100644
>> --- a/arch/arm/mach-sti/Kconfig
>> +++ b/arch/arm/mach-sti/Kconfig
>> @@ -19,31 +19,13 @@ menuconfig ARCH_STI
>>  	select PL310_ERRATA_769419 if CACHE_L2X0
>>  	select RESET_CONTROLLER
>>  	help
>> -	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
>> +	  Include support for STMicroelectronics' STiH407/10 and
>>  	  STiH418 family SoCs using the Device Tree for discovery.  More
>>  	  information can be found in Documentation/arch/arm/sti/ and
>>  	  Documentation/devicetree.
>>  
>>  if ARCH_STI
>>  
>> -config SOC_STIH415
>> -	bool "STiH415 STMicroelectronics Consumer Electronics family"
>> -	default y
>> -	help
>> -	  This enables support for STMicroelectronics Digital Consumer
>> -	  Electronics family StiH415 parts, primarily targeted at set-top-box
>> -	  and other digital audio/video applications using Flattned Device
>> -	  Trees.
>> -
>> -config SOC_STIH416
>> -	bool "STiH416 STMicroelectronics Consumer Electronics family"
>> -	default y
>> -	help
>> -	  This enables support for STMicroelectronics Digital Consumer
>> -	  Electronics family StiH416 parts, primarily targeted at set-top-box
>> -	  and other digital audio/video applications using Flattened Device
>> -	  Trees.
>> -
>>  config SOC_STIH407
>>  	bool "STiH407 STMicroelectronics Consumer Electronics family"
>>  	default y
>> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
>> index 488084b61b4acafb569ee9c51f5769393d55a9ce..1aaf61184685d754de57b487aef9a6b45a759b23 100644
>> --- a/arch/arm/mach-sti/board-dt.c
>> +++ b/arch/arm/mach-sti/board-dt.c
>> @@ -10,8 +10,6 @@
>>  #include "smp.h"
>>  
>>  static const char *const stih41x_dt_match[] __initconst = {
>> -	"st,stih415",
>> -	"st,stih416",
>>  	"st,stih407",
>>  	"st,stih410",
>>  	"st,stih418",
>>
> 
> 
> Hi Raphael
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
Applied to sti-next

Thanks
Patrice

