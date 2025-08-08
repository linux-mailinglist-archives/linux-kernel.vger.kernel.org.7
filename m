Return-Path: <linux-kernel+bounces-760210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55607B1E7E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE888A02862
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9D1CAB3;
	Fri,  8 Aug 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="W99xGzeE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B81DED4A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654628; cv=none; b=V/Y6Fv7vdu7DzOhu2X0mNELymvzW/KDVnLmAhgh12tS+/PYTG4FTVUUsu1UKCRm2n/XXx1vDEQ5yIkeUWZaqQOECIcgxSA3WdalhYad5vDT1T+U9srIOPYofKllruw85yaNqydncNThBtUzh8pWE4I5JXaxAbGVaNKKvJ1+7Myw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654628; c=relaxed/simple;
	bh=6ao3dnrnKc09/dBLYRX30+g8CZwbFMFnpT7W13BEuj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cshRn5iPV6syKwKXSGUqnWxAomhYtuNC4nuMKwQzbEdnPY87kVxcan49OwGKKVY59UQiM2k8CrTbaJi47+SI3onre4owpQCJnXKsitBWgPuh7uMRAymDLso/GXhEu5oVswTbnbvaU2vmN+xrEOVQDs7g8ZeDZu1O/Vlj4yqlvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=W99xGzeE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso1537074f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754654625; x=1755259425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiPizj4xPQHgrz0IL3+WPEQFuPXWX/y9HlO9/wOe3L4=;
        b=W99xGzeE9a/3ucqsnGmCTj+1740jLYNK3+UeRMV9SHgAWMpU7mi29Zu66uI7NfqQQA
         kVK1y3mycWyyOJPMQ5hvrAefVEEZ4+efhHRR22dd7UbxQ07EABx+Q58tTP1puq/Ipavh
         BSg8McvnFxjW5Ps9eMZgO1FX2VBYfZvKIEMBUdZsVxqHOYkME07UVulUNt5V6wV08v6g
         +GY1FxmX+qJDR/gclkpJe4IdfdVv1AkqPcrljr6QCbEHLnIqlnCXDjqHgacjTvjTginP
         m+N75ki9ahZqUHY/SpJARI0COK7zRHE9oMTe/ddXrIIz7XaybsLsp+KJ6SohocxiEoK2
         +aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654625; x=1755259425;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiPizj4xPQHgrz0IL3+WPEQFuPXWX/y9HlO9/wOe3L4=;
        b=dLZ6JquyZZ5ZWBj47gdILyH1NuEyi+L+JpwOpe+5cYpFHOGW6EQmekfwTgPL7t1Qo/
         p8i4UxZr+XZDdgH+ZCnpIjX9yKIAVNoxEz+f9H+5LE55H99xaY99e0ejOXD1y8EYg/km
         /gd6fVnSkzVc7amUZpwso+ZSHaFlZQgIMqW2JNz56xgrm0EqL/4UqLJAdwXd5495CGv7
         mPvLQ/NHCfjyovl9pJ/SzMLgITJ4C2lULIB+Pot4UQJC+L8ykB65B2ghDqKpVNR+9gXq
         WxUw/SiMJYwzlbxkqh0/jbs6ddTyUp6SDjRUtrFpbG11/g87MQn1RZyvpZqtZQ/Fd4Pg
         eJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCUB26/tyqa2ARwt0ZX0gabfM87QVYUPKd2LaLT4ToAjZHRO8SPInvcjrK0PggfTVeBRKU5SOvVDSQyoGL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pjcvduowuA6XYvNy5sKiKbyYJpK2oosFBayeu4OSHsJQkaEg
	Ax/PCxf0/Bo/D/G5OxyVF9lznuy0Gn/nfnd80v5ifgSl4YvSSyBe4sGEsYNmfiPPncw=
X-Gm-Gg: ASbGncsICly+YjiuWr3ajTBLMzkdVIop//jfCDFaU2GPiTjwp5igHbqOamOhNNofSnE
	SILhS3WkVVGcP5fcVzSGXQWMyFvoqbmcsgyDpVKU48DpKZ7M+7m8r/lABFh0eeR38jtMXP27cr6
	qqR8fM6/t5+bjN6xgA2n4+/+o1Ck1ncuVY6dfmJqeDrM5laEDAVMQdDPA1y7lrbfFnbSho6Rq8T
	zzSauoXexjnPmLOB0KpvgCY7uxqXQ+fY7HQi3NSSTnrwmrcdXidci9SmiImxC/vFQbKQXNGoneP
	0sByZv+/RJdmRr+xnO2WQbDKPoHQQsM7tV+Op4caJKDqH/TKIPoVA82rl5IQA0+c4F9bg39G6wU
	Dx4nmLvZQ4aG4W8rWj6ZZYGkScxfXCiQ=
X-Google-Smtp-Source: AGHT+IEhH09YKqZt2qdtQad23ji4V+O1nbR0nqNA6VFV5zpI+IyNp61P/t7lTEC8XtYM0WJsfb+osw==
X-Received: by 2002:a05:6000:4028:b0:3b7:8842:8a0c with SMTP id ffacd0b85a97d-3b8f97ec49emr6554498f8f.19.1754654625233;
        Fri, 08 Aug 2025 05:03:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm21298841f8f.43.2025.08.08.05.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:03:44 -0700 (PDT)
Message-ID: <6638d8cb-5770-416f-84f7-670de71ec63d@tuxon.dev>
Date: Fri, 8 Aug 2025 15:03:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "lizhi.hou@amd.com" <lizhi.hou@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 wsa+renesas <wsa+renesas@sang-engineering.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464920ECAC2C3CB89DE2D5864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7c8c7a25-c373-452a-9fe8-8b2d92ddd885@tuxon.dev>
 <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fa0da331-273a-414b-b0d8-229c6772692d@tuxon.dev>
 <TY3PR01MB11346340ACB78394E131503B3862FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB11346340ACB78394E131503B3862FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08.08.2025 14:44, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Sent: 08 August 2025 12:28
> .org; Claudiu Beznea
>> <claudiu.beznea.uj@bp.renesas.com>; wsa+renesas <wsa+renesas@sang-engineering.com>
>> Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
>>
>> Hi, Biju,
>>
>> On 09.07.2025 08:05, Biju Das wrote:
>>> Hi Claudiu Beznea,
>>>
>>>> -----Original Message-----
>>>> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: 08 July 2025 11:10
>>>> Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som:
>>>> Update dma-ranges for PCIe
>>>>
>>>> Hi, Biju,
>>>>
>>>> On 07.07.2025 11:18, Biju Das wrote:
>>>>> Hi Claudiu,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>>>> Sent: 04 July 2025 17:14
>>>>>> Subject: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som:
>>>>>> Update dma-ranges for PCIe
>>>>>>
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The first 128MB of memory is reserved on this board for secure area.
>>>>>> Update the PCIe dma-ranges property to reflect this.
>>>>>
>>>>> I see R-Car PCIe dma-ranges[1] and [2] maps all possible DDR area supported by the SoC?
>>>>> Do we need to make board specific as well there?
>>>>
>>>> I'm not familiar with R-Car, but if there are ranges reserved for
>>>> other purposes, I think we should reflect it in board specific device trees.
>>>
>>>
>>> Already Linux has this DDR info[1]. Linux provides DMA memory only from this region.
>>
>> What we provide though dma-ranges DT property is setup in the PCI controller register corresponding to
>> the AXI windows. It is the same in case of R-Car (as of my investigation on driver).
>>
>>>
>>> In your testing, have you faced any issue like system allocated DMA
>>> region other than [1] and you don't want to use it, then the changes are ok??
>>
>> I haven't currently encounter any issues.
>>
>> As the values passed though the dma-ranges DT property are setup in the controller register for AXI
>> windows, and the DMA endpoints can act as bus masters, to avoid any issue where the DMA endpoints may
>> corrupt memory specific to the secure area, I chose to update the "dma-ranges" though board specific
>> bindings (to reflect the presence of the secure area and tell the PCIe controller to not use it).
>>
>>>
>>> Not sure, PCIe can work on internal memory such as SRAM?
>>
>> Inbound window is RAM, outbound window is a PCIe specific memory described though "ranges" DT property.
> 
> You mean SRAM cannot work on PCIe subsystem and work only for DRAM

This PCIe driver uses the PCIe specific memory (named "PCIe area" in Figure
5.2 Overall Address Space or RZ/G3S HW manual) and DRAM.

> that is the reason you are not defining SRAM region in "dma-ranges". Am I correct?

The DRAM region is described though dma-ranges, the PCIe memory is
described through ranges property. The above is from this series:

dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;

Thank you,
Claudiu

> 
> Cheers,
> Biju


