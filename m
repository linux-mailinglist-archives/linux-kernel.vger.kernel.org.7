Return-Path: <linux-kernel+bounces-867182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE5AC01C41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 318794EADFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694C32B9B6;
	Thu, 23 Oct 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MkSVaCD6"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082722FC877;
	Thu, 23 Oct 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229786; cv=none; b=dgcTd/bKuSOlyTiRnx4Da12QD+PznxW58kECwcagMG1hv7eTSoWmHJHFWdBE3WSRyVRIoWdKIHkSrLulIjzTSFY/B6r/BlFXoH1MQloVtgyW2vJgJv0B4Y089uqPCs4mTo7fX/v9MVaaAz7bjs+pakZiAEUwftuIFHyqXYtmRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229786; c=relaxed/simple;
	bh=3vtKVla58guv+kn64MG0kOj6L9Quk9cGtkuU6kJ2bpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=drAYfLUoCrFr71EGiosmlM8ZnOkwmmACZO/yAGtWE6AvRWDPcM1sB1pWj7fjwOmzRt2mX2pPMftco3miU6gKUDMZqjLqZSsI3oM/mDBAj3O/v71uBvrQ4rwI02JLhfna/Yu2yHZ2PJVsLyDtfw2KZZOkG/usZTPEPhi1gC0M1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MkSVaCD6; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NETOKW553075;
	Thu, 23 Oct 2025 09:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761229764;
	bh=RESlMDxT65A7qHuKGnbOMnFeEQhKdlIGLsQaG2/0rsM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MkSVaCD6l4TiiniawAUWAIsVt8TF7JIhHhoNFZXfsRvLPShts9WhPjeEWhUqjBTsI
	 g7E+fwPhqfkPgQ5IDhk6LDin4rjqSr8yz9d6SZyd9s50gka3GfTvGx1Knf4qDdlQ0d
	 mLbOTFpwoomyPRdksdKQorXY2doRobXNXo+glhMk=
Received: from DLEE202.ent.ti.com (dlee202.ent.ti.com [157.170.170.77])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NETOSB2771505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 09:29:24 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 09:29:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 09:29:24 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NETLkf2989198;
	Thu, 23 Oct 2025 09:29:21 -0500
Message-ID: <da7e6f60-1c88-4882-a835-a4d8b46ddbe5@ti.com>
Date: Thu, 23 Oct 2025 19:57:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-j722s-main: fix the audio
 refclk source
To: Michael Walle <mwalle@kernel.org>, "Kumar, Udit" <u-kumar1@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20251017102228.530517-1-mwalle@kernel.org>
 <20251017102228.530517-2-mwalle@kernel.org>
 <554df7d2-1809-42a8-b512-bde3fd284163@ti.com>
 <DDPRM9UCVZNA.HFRGLJW17PIP@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <DDPRM9UCVZNA.HFRGLJW17PIP@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 23/10/25 19:48, Michael Walle wrote:
> On Thu Oct 23, 2025 at 3:50 PM CEST, Udit Kumar wrote:
>> Hi Michael,
>>
>> On 10/17/2025 3:52 PM, Michael Walle wrote:
>>> At the moment the clock parent of the audio extclk output is PLL1_HSDIV6
>>> of the main domain. This very clock output is also used among various IP
>>> cores, for example for the USB1 LPM clock. The audio extclock being an
>>> external clock output with a variable frequency, it is likely that a
>>> user of this clock will try to set it's frequency to a different value,
>>> i.e. an audio codec. Because that clock output is used also for other IP
>>> cores, bad things will happen.
>>>
>>> Instead of using PLL1_HSDIV6 use the PLL2_HSDIV8 as a sane default, as
>>> this output is exclusively used among other audio peripherals.
>>
>>
>> Thanks for this fix,
>>
>> Initial support for audio_refclkx was added in j722s and am62p soc 
>> specific files due
>>
>> to selection of different parent.
>>
>> Since these SOC share many common things, and this patch will make these 
>> nodes same as of am62p device
>>
>> https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi#L46 
>>
>>
>> So I suggest to move in common file 
>> https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi#L42 
>>
>>
>> and remove from SOC specific files.
> 
> Ok, but to keep the information and to not conflate two different
> things, I'd do the following:
>  - keep this patch as is
>  - add a second one, to move the (now) identical nodes into the
>    common-main.dtsi
> 
> Sounds good?

Agree, this is better way to organize the change.

> 
> -michael

-- 
Regards
Vignesh
https://ti.com/opensource


