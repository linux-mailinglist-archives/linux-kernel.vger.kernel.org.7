Return-Path: <linux-kernel+bounces-830229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D4B991EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7B31B21382
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875E2D9ECB;
	Wed, 24 Sep 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BsH8sE9o"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA982D77FA;
	Wed, 24 Sep 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705967; cv=none; b=F0kNJPdNeW6r6EZBOb2X+pRfqyNe6d1zrOzIhhAxpKI/zcMN6pJBAAs4r5g8rjngESjBAeEmBJWPBaXEo3JFU6n0Pa1FiHumwQoWjc7TPJbTKtxPu0tHS+u4rFdO/R20SSMN0ikruIbLFwrsijt5JugkVOsVbg6xvN9L8aaAQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705967; c=relaxed/simple;
	bh=O1420aHBknukQsKxuj5XgurLeBAQtflzePdc5jeCqUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r36YSVszm/wFzKzEgV9PMMFT4qnBTCoAdudPyRagxi+UNcyfW3pHIpbNyfbPTvHvxDXLTDAGzXMgN/WdfNESkXvXK6RTCDl10FtfJnL1FUxve8+Hnn0npaPPGSCH37mJISirdmHxG2ORvuFS0qGxRmLJPGpHAB8ZFu4v1uxDgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BsH8sE9o; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58O9PXRa1670036;
	Wed, 24 Sep 2025 04:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758705933;
	bh=iSdDHuNTbBGSV0Dxkyi9JWjhRYgamGr39a/WPf5G4Ms=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BsH8sE9oRTYt0VY8L6tl0yYe7pp3QSlwbFtl+TGPOcosWaqHsYbIJW3HCMYZHkHTu
	 7lMqkGrN1g6k9BFbjZLj6NoJQlxUerf/deYgqAyEGswaptTc5UEjeyOV7wkRbyYMO0
	 KplMgOrJ6oEGOUgyLGoTfYQ4kgRgwBLpxyLVGFyU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58O9PWva2336456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 24 Sep 2025 04:25:32 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 04:25:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 04:25:32 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58O9PRpR1784191;
	Wed, 24 Sep 2025 04:25:28 -0500
Message-ID: <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
Date: Wed, 24 Sep 2025 14:55:26 +0530
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
	<bmasney@redhat.com>
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
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Peng,

On 23/09/25 17:27, Peng Fan wrote:
> Hi Sebin,
> 
>> Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
>> NXP i.MX95
>>
>>> --- a/include/linux/scmi_protocol.h
>>> +++ b/include/linux/scmi_protocol.h
>>> @@ -80,9 +80,14 @@ enum scmi_clock_oem_config {
>>>        SCMI_CLOCK_CFG_DUTY_CYCLE = 0x1,
>>>        SCMI_CLOCK_CFG_PHASE,
>>>        SCMI_CLOCK_CFG_OEM_START = 0x80,
>>> +     SCMI_CLOCK_CFG_IMX_SSC = 0x80,
>>
>> TI is also planning to implement the same in our upcoming platform. so
>> can we use a generic ID instead of vender specfic message ID?
> 
> I tried to push to new generic ID [1] in half a year ago, but in the end ARM
> decided not to add generic ID for spread spectrum support.
> 
> To i.MX, it is too late to use a generic ID and waiting spec, i.MX firmware
> has been public for quite some time and passed several external releases.
> So I need to use what our firmware adds and spec allows: vendor
> extension.

Thanks for the quick response,
Since this implementation is specific to i.MX, can you move this to a 
vendor specific file, so that it will not break i.MX's firmware and TI 
can implement SSC in TI specific file.

> 
> [1] https://lore.kernel.org/arm-scmi/Z8iKErarE0lHWxEy@pluto/
> 
> Regards,
> Peng.

Thanks
Sebin

