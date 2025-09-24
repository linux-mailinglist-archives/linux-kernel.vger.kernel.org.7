Return-Path: <linux-kernel+bounces-830480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16794B99C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591E77A9AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE6301039;
	Wed, 24 Sep 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BMQL5iYf"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592184C6C;
	Wed, 24 Sep 2025 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716179; cv=none; b=Z2E/kb4nK7smh/oCY2L3QBJ88EbnpBlirWsvS8tbNATOO+o52fdq9uLiEeCNVlGLbC6m1LEMZ5vvCzOmIZbZwimwkXBi6T1vzywH3ZJ07bag3GeHr9ELt4NPj0F2dbUpc7oo8K56nksiNyJlANZ0HSI7st3yrPdKjDLLfqBqZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716179; c=relaxed/simple;
	bh=kZUDdG9J8RBpVrjq4SwMxhV1iWoS9bku5Qbgg10KyWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QFToFbQSXXxKSmSWeV1LbuQLtsr9sFDwq9+KVB5dTwasm9L8ThMOmRZPFmZiHSG3qQQEXOStye2xFlSeu4QR9ep0qfPp9gmnCIpZfy7JjQ9HOdBHZel1vmtfruIX8Fdo5quYtfewfnYvH3QFfjgRHpupF0SYqOnciKx2dpxwXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BMQL5iYf; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OCFd4B1694403;
	Wed, 24 Sep 2025 07:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758716139;
	bh=GAcYijQUw8JH6Gkhzh4E9b+3rGXrtBQWE/aPaFL/C5k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BMQL5iYff0pDWxgw/etrsl5Bm22SIRImKSxHGIc+UEoIAgYx58P0FgozpQveQJns+
	 WZeRyMa2FFd+73mw2gV4/3nEo2NP9k4fCQaap7HIKD3U+0v95vEwXLXvfLepzfhwkK
	 AtClVyqAfQdZStyEVVPNpL6dDlchvd0vBT4t/GPs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OCFc7H2420511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 24 Sep 2025 07:15:38 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 07:15:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 07:15:38 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OCFW1H1982020;
	Wed, 24 Sep 2025 07:15:33 -0500
Message-ID: <c34157c5-cd13-4e85-a9ee-22446111f633@ti.com>
Date: Wed, 24 Sep 2025 17:45:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
To: Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Marco Felsch
	<m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Brian Masney
	<bmasney@redhat.com>,
        Dhruva Gole <d-gole@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
 <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Peng,

On 24/09/25 17:13, Peng Fan wrote:
>> Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
>> NXP i.MX95
> ...
>>>>>         SCMI_CLOCK_CFG_OEM_START = 0x80,
>>>>> +     SCMI_CLOCK_CFG_IMX_SSC = 0x80,
>>>>
>>>> TI is also planning to implement the same in our upcoming platform.
>>>> so can we use a generic ID instead of vender specfic message ID?
>>>
>>> I tried to push to new generic ID [1] in half a year ago, but in the
>>> end ARM decided not to add generic ID for spread spectrum support.
>>>
>>> To i.MX, it is too late to use a generic ID and waiting spec, i.MX
>>> firmware has been public for quite some time and passed several
>> external releases.
>>> So I need to use what our firmware adds and spec allows: vendor
>>> extension.
>>
>> Thanks for the quick response,
>> Since this implementation is specific to i.MX, can you move this to a
>> vendor specific file, so that it will not break i.MX's firmware and TI can
>> implement SSC in TI specific file.
> 
> i.MX has encountered issue with pinctrl-scmi.c and pinctrl-imx-scmi.c
> both supports SCMI PINCTRL. Current linux scmi does not support
> both drivers built in kernel image, because scmi devlink issue.
> 
> Sudeep said he would address the devlink issue in 6.19 cycle.
> 
> Given the current situation, I'm hesitant to introduce a new driver
> saying clk-imx-scmi.c.
> 
> What I'm unclear about is whether moving to a vendor-specific file
> implies creating a new driver (i.e., clk-imx-scmi.c), or if it could be
> handled via a callback or another mechanism. Could you help
> clarify the intended direction?

My intended was to handle it via callback or something similar, so that 
TI can its own callback for the TI's SSC implementation.

> 
> Sudeep, Cristian
> 
> Would you please jump in and say something?
> 
> Thanks,
> Peng.
> 
>>
>>>
>>> [1]
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> lore
>>> .kernel.org%2Farm-
>> scmi%2FZ8iKErarE0lHWxEy%40pluto%2F&data=05%7C02%7Cpe
>>>
>> ng.fan%40nxp.com%7C4bd4c6b93ff146fbfc4c08ddfb4c5ab5%7C686ea
>> 1d3bc2b4c6f
>>>
>> a92cd99c5c301635%7C0%7C0%7C638943027585856649%7CUnknow
>> n%7CTWFpbGZsb3d8
>>>
>> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiI
>> sIkFOIjoiTW
>>>
>> FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zEREeXuiaC5wWS
>> C%2FUAIe6wfiTf
>>> MG5AEY5vZ7D4OEIGI%3D&reserved=0
>>>
>>> Regards,
>>> Peng.
>>
>> Thanks
>> Sebin

