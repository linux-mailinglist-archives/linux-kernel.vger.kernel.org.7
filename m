Return-Path: <linux-kernel+bounces-747408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97351B1337B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1681895FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF320FA9C;
	Mon, 28 Jul 2025 03:53:07 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7899461;
	Mon, 28 Jul 2025 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753674786; cv=none; b=j4FmY1EUf2ecqmwfd8rq8NZxNFvFO7soB/yIwSxZ6nHgfoBLycjjqfgq4V9MBYEDOoXoXaLzY4sMlrk2k1ebalOrFLjabSamTGcsEYg4bluGg1+1P8E9sZFcashsIGwrMmc9LOdHuWRCIYXEcI3OdNDU1hmZ67vaG31QxRFHdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753674786; c=relaxed/simple;
	bh=3EEqrpxyJT+P7AGCzyB1n5QEYpn9isgJLBfImkuvT2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phkQPnvLeLpUZJcwvegX/VJAf9Nsla8gSovxLalYNEN0gESSxFef4Ssnb4I57WH2mrxTech2MfYxN5uWmmp8ecRdZk60VzTOoxTOVJHJO6UvKkbVY2CNO7uhv0Nsj5gqd+oRNIEkhtqKb7g0BcTa1DPlH3ZTIJ6CJ1JAQECU95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.23])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 50E99B4E0003;
	Mon, 28 Jul 2025 05:52:52 +0200 (CEST)
Message-ID: <8841923c-cbb6-4cce-97f4-a851783b6102@freeshell.de>
Date: Sun, 27 Jul 2025 20:52:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
To: Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, William Qiu <william.qiu@starfivetech.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <20250724075600.239522-1-e@freeshell.de>
 <20250724-equal-limb-2922f240961e@spud>
 <43c5908c-c478-4e00-b1e5-955296e4ec24@freeshell.de>
 <20250725-disorder-graceless-23c95454244d@spud>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250725-disorder-graceless-23c95454244d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding CC: Hal Feng, Minda Chen

On 7/25/25 11:10, Conor Dooley wrote:
> On Thu, Jul 24, 2025 at 10:13:47PM -0700, E Shattow wrote:
>> On 7/24/25 09:51, Conor Dooley wrote:
>>> On Thu, Jul 24, 2025 at 12:55:53AM -0700, E Shattow wrote:
>>>> Drop no-sdio property avoids a delete-property on variant board dts
>>>> having an SDIO wireless module connected to mmc1.
>>>
>>> I'm struggling to understand why this change is correct.
>>>
>>> If there are specific boards that have wireless modules connected
>>> instead of using sdcards, how come the no-sdio property isn't moved to the
>>> the boards that do have sdcard slots?
>>
>> Why is 'no-sdio' property there to begin with...
>>
>>> The property was added for the visionfive 2, and only on mmc1, so should
>>> it be retained for boards that match the visionfive 2 in terms of how
>>> they use mmc?
>>
>> Ref.:
>> https://lore.kernel.org/lkml/20221207131731.1291517-4-william.qiu@starfivetech.com/
>>
>> My theory is VisionFive2 board hardware can support connecting up some
>> SDIO module there with ready-made available adapters, it may be possible
>> (if unusual) that would work? SDIO is 4-wide and some voltage
>> requirements, and a couple of GPIO, so I'm aware that's a stretch of a
>> statement but it could be done without soldering. I wouldn't expect it,
>> but why restrict this everywhere inheriting from jh7110-common.dtsi with
>> 'no-sdio' and then (needs testing!) if it doesn't matter one way or the
> 
> In case it was not clear, I am not questioning removing it from the
> common file, just that you're removing it entirely.
> 
>> other for VisionFive2 just drop it I think as being inaccurate/unnecessary?
>>
>> JH7110 CPU supports two interfaces of SDIO3.0/eMMC so it's not clear to
>> me if there's some reason for 'no-sdio' property to be there. Does
>> allowing SDIO (?) break eMMC and SD Card devices, is it destructive?
>>
>> Not knowing what 'no-sdio' does technically I dropped the property and
>> tested with the hardware I do have. The 'no-sdio' property
>> present/absent does not appear to do anything user-impactful on Pine64
>> Star64 that has SD Card slot on mmc1, and as would be expected on Milk-V
>> Mars CM Lite WiFi when there's an SDIO module at mmc1 it then fails to
>> initialize if 'no-sdio' property is present.
> 
> The original addition looks very intentional - however I didn't look at
> the commit message itself last night, just the diff. I wonder if "no-sdio"
> and "no-mmc" were just added because William intended to restrict SD
> cards since sdio1 is the SD card slot, rather than because the use of
> sdio or mmc commands during init would cause problems. The wording of "Set
> sdioo node to emmc and set sdio1 node to sd" is what makes me think
> that.
> 
>>> Could you add an explanation for why removing this entirely is the right
>>> thing to do, rather than only removing it for these variant boards?
>>
>> Yes, I can rephrase a bit like "relax no-sdio restriction on mmc1 for
>> jh7110 boards", or else reconsider the approach. I was going to approach
>> with `/delete-property/ no-sdio;` later elsewhere but after testing on
>> Pine64 Star64 with similar configuration to VisionFive2 mmc interfaces,
>> and knowing that Milk-V Mars CM Lite WiFi detects AP6256 SDIO peripheral
>> at mmc1 when this property is dropped (and with a few additional
>> things)... I prefer to reduce the problems that would need to be avoided.
> 
> I think using /delete-property/ would be unwise, properties shouldn't be
> in the common dtsi if they are not, in fact, common.
> 

Ack, you wanted these moved out into each board dts? That would be okay
with me. I suspected that `no-sdio` `no-mmc` don't belong so I'm still
in favor of dropping them overall. I think nothing will break but I want
more data from users.

>> I have done all the testing I can do with hardware I have. As-is it's
>> just like I wrote, we'll have to solicit some testing feedback on that
>> and wait to learn what this does for the other boards.
> 
> I'd kinda be inclined to apply this diff, with a better commit message,
> shortly after -rc1, unless someone comes forward with a justification
> for it being there on the vf2. I figure it's only in the common dtsi
> because it was not problematic until now cos noone tried to use the sdio
> aspect.
> 

I will revise the commit message v2 and send soon, just for dropping the
`no-sdio`...  and actively seek testing reports from users of all the
JH7110 boards to drop `no-sdio` and then also `no-mmc` properties for a
follow-up.

>> Aside, anyone want to chime in what is the utility of 'no-sdio'
>> property, how do you know from a schematic if it is appropriate, can it
>> be simply dropped as I suggest for JH7110 boards?
> 
> My (limited) understanding, mostly from looking at the caps in
> mmc/host.h because I find the binding description obtuse, is that these
> properties (no-sdio and no-mmc) block the use of commands that would
> cause a device to malfunction. They don't appear to be required at all just
> because the board layout doesn't support these types of devices.
> 
> Conor.

Hal and/or Minda (from StarFive) any comment about this? I would ask
William but they are not involved anymore. Can we drop some of these
suspicious mmc properties, what are the reasons for these?  -E

