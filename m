Return-Path: <linux-kernel+bounces-688075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C18ADAD69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0F0188C18C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7612980DD;
	Mon, 16 Jun 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uddyuec+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82D26D4E8;
	Mon, 16 Jun 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069787; cv=none; b=d+mE9jDT+JMK7MZzqQWCitp1YbVSJ/3U/ON/crpBS/QSJSxZY5Jne9vKxozxcoFWmR2LTElAzX8L9TxASDBYm3oM9W8BulK9d5dQefA+6egjTILBOyUnuF8XpTtUWfB6DifaS0KW9pRi5zwwXXGqPPcccC6t1kWpMFogowqvcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069787; c=relaxed/simple;
	bh=S+LifadTGthAmCCjRwrc0cxTJlh7M1pbwmsA1BOiIlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n1FkHF7lY+gYzXkB1OWzUTufMb/w6auWB/z9sWEiwJ8TsuGAFM754ltiTdtvJgaABrBeryInP2vqVRZnY34GN/B5Jzq+v5K9jianvrmQpsGDxuJ/fCT+hra8cT17Ie5hUCpWZnubVGfwWUeReYgR7i9L4InoSbna9GKcMYSPGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uddyuec+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E9BC4CEEA;
	Mon, 16 Jun 2025 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750069786;
	bh=S+LifadTGthAmCCjRwrc0cxTJlh7M1pbwmsA1BOiIlI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=uddyuec+cranzqbmYGkHlHD7EtAJhyPXnfPNCG5PStUAXj6qO3ta+CxTniEpaJ+/K
	 tLu7ZM1OnqrXmMkfC4dPSnjhcEk4moPsbCjCCKFallqzgBAbx/+RaXpx/JDdgZFSiY
	 KdIt8Ok9pZeLbSvKX/xuaA4/RO59JATDLF501Sm7AdjyT1aRWCDQI7fBPFlV4G7QBF
	 rV3fOH3/paUfPH1VvDFifXqH817CF6zqVZTIOb/Z24w2Rxk8TihV9LVwRkIgRsvRxZ
	 +mFZbguENHhVcauTy+VAW2AJ/7+9t3j8TD8kobg783zGc2Fef2yfRW0ohLAzD9iU0X
	 0c8iyHYhpmyrw==
Message-ID: <ce3044aa-2b62-4516-99ff-88dcb56b128b@kernel.org>
Date: Mon, 16 Jun 2025 12:29:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 Taniya Das <quic_tdas@quicinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Eric Biggers <ebiggers@google.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "soc@lists.linux.dev" <soc@lists.linux.dev>, Mo Elbadry
 <elbadrym@google.com>, Rom Lemarchand <romlem@google.com>,
 William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
 "wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com"
 <leohu@nvidia.com>, "dkodihalli@nvidia.com" <dkodihalli@nvidia.com>,
 "spuranik@nvidia.com" <spuranik@nvidia.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
 <20250612100933.3007673-4-ryan_chen@aspeedtech.com>
 <485749d4-b3c4-4965-9714-ad534d37e8c9@kernel.org>
 <OS8PR06MB7541A100B918AAA84D1ABDCAF277A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <749c581e-cc00-428f-8eb9-222f9d574486@kernel.org>
 <OS8PR06MB7541FFCA9E28E5767791D869F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e39b5259-db92-4269-84c9-d51e8e4f327e@kernel.org>
 <OS8PR06MB7541645F6A0638FC250B1272F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <a2ca2f58-f648-43f9-8d23-4111e4eb1f1d@kernel.org>
 <OS8PR06MB75412D391E7D10958E70C100F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e623aad6-726b-405e-be94-25f188749349@kernel.org>
 <OS8PR06MB754181823BC03DADBF0A9B82F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <OS8PR06MB754181823BC03DADBF0A9B82F270A@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 09:52, Ryan Chen wrote:
> 
>> Subject: Re: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700 SoC device
>> tree
>>
>> On 16/06/2025 08:54, Ryan Chen wrote:
>>>> Subject: Re: [PATCH v0 3/5] arm64: dts: aspeed: Add initial AST2700
>>>> SoC device tree
>>>>
>>>> On 16/06/2025 08:32, Ryan Chen wrote:
>>>>>>>
>>>>>>> But I don't know your previous "NAK, never tested" mean.
>>>>>>> I did make CHECK_DTBS=y arch/arm64/boot/dts/aspeed/ don't see the
>>>>>>> fail with
>>>>>>> intc0: interrupt-controller@12100000 {
>>>>>>> 	compatible = "simple-mfd";
>>>>>>>
>>>>>>> So, could you point me more test instruction for this?
>>>>>> See syscon.yaml. And writing bindings or talks on conferences:
>>>>>> simple-mfd cannot be alone.
>>>>>>
>>>>>
>>>>>         intc0: interrupt-controller@12100000 { Sorry, do you mean
>>>>> add by following?
>>>>> 				 compatible = "aspeed,intc-controller", "simple-mfd";
>>>>>  					.....
>>>>>                  intc0_11: interrupt-controller@1b00 {
>>>>> 					compatible = "aspeed,ast2700-intc-ic";
>>>>>  					......
>>>>>                  };
>>>>>          };
>>>>
>>>> Maybe, but you said this is base address, so how can it be some
>>>> separate device?
>>>>
>>>> I mean really, don't add fake nodes just to satisfy some device instantiation.
>>>> Describe what this really is. That is the job of DTS. Not some fake nodes.
>>>
>>>
>>> Understood. Let me explain more about the hardware layout.
>>> The interrupt controller space is decoded starting from 0x12100000,
>>> which includes both a set of global configuration registers and
>>> individual interrupt controller instances.
>>>
>>> The region at 0x12100000 contains global interrupt control registers
>>> (e.g., protect config, interrupt routing etc.).
>>
>> This does not explain me why global controller registers are a BUS or MFD as
>> you claimed here.
>>>
>>> The actual interrupt controller logic starts at 0x12101b00, where each
>>> sub-controller instance (e.g., intc0_11, intc0_12, etc.) has its own set of
>> registers.
>>
>> I don't know what is a "global controller register" and "own set of registers". If
>> you have device spanning over multiple memory blocks, device takes multiple
>> 'reg' entries for example. There are many other configurations, depending on
>> real hardware and relationships. Just look at other DTS.
> 
> 
> Here are two possible representations of the interrupt controller layout for the AST2700 platform:
> Please advise which approach would be more appropriate or preferred? 
> 
> Option 1: Hierarchical representation with a parent node
> This models the entire interrupt controller registers space (start from 0x12100000), 
> where the parent node includes the global register area and acts as a container for per-instance sub-controllers:
> 
>     intc0: interrupt-controller@12100000 {
>         compatible = "aspeed,intc-controller";
>         reg = <0 0x12100000 0x4000>;
> 		...................
>         intc0_11: interrupt-controller@1b00 {
>             compatible = "aspeed,ast2700-intc-ic";
>             reg = <0x1b00 0x100>;
> 			...................        };
>     };
> And I find the others dtsi have global register use syscon ex.
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/sprd/ums512.dtsi#L177-L192
> 
> Option 2: Flat representation with only the per-domain node
> This focuses on just the interrupt controller logic at 0x12101b00, skipping the global register modeling:
> 
>     intc0_11: interrupt-controller@12101b00 {
>         compatible = "aspeed,ast2700-intc-ic";
>         reg = <0 0x12101b00 0x100>;
> 		...................
>     };
> 


I don't understand this: you already have a binding for this, you
already described the device, so why now this is being changed?

You are supposed to send complete bindings for your device (see writing
bindings). Not some half-baked parts and then half year later different
DTS which points that your bindings were just incomplete.

Look how a completely new SoC is supposed to be upstreamed, on the day
of public announcement of the hardware:

https://lore.kernel.org/all/20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org/

Are all or most bindings posted? Yes
Is DTS for all devices from above bindings posted? Yes
Do we see complete picture? Yes

I still have no clue what is global interrupt registers. I already said
it, but you keep repeating the same. I have no clue.

Why this would be a parent?

Why this would not be a parent?

Best regards,
Krzysztof

