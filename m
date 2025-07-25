Return-Path: <linux-kernel+bounces-745281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC801B117D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2081760BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8991242917;
	Fri, 25 Jul 2025 05:13:57 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B824167E;
	Fri, 25 Jul 2025 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420437; cv=none; b=dvKqdlJbTLz7KqWuGBy15MFrHjc4hO4JZqp7Aw7GlHcLyOjK/jn6msAdKSLLNYfo/oFg5VsbHZdIow4utUovp82NHeLsOlmZo3MWXxdh7vRE1tGx1cuvYOSkgnAtjpTt5qEH1IiHZcmCWlF55OcFubfIwhZhh68SSguNT742M40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420437; c=relaxed/simple;
	bh=MTohbHtoS3tPetcP5TamR+xSxsE0DuHzDGHmpEqyA4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=espp0PUSKWuFgAhj35NjitY74NHmmnHMUDfWr2hCABBhnsMHQaABYOaPTfflWVwTLRHaFv92hozoJQQ/AV4w6w4PB8XguZoqKXUaTWuskOr/ukY1ikjseo/0RyAubl9kiiv7fmi3r0sXtfToGU2+JFzsEvpz2iXqWjlFdUVETgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.28])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 655D2B4D0045;
	Fri, 25 Jul 2025 07:13:49 +0200 (CEST)
Message-ID: <43c5908c-c478-4e00-b1e5-955296e4ec24@freeshell.de>
Date: Thu, 24 Jul 2025 22:13:47 -0700
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
 linux-kernel@vger.kernel.org
References: <20250724075600.239522-1-e@freeshell.de>
 <20250724-equal-limb-2922f240961e@spud>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250724-equal-limb-2922f240961e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 7/24/25 09:51, Conor Dooley wrote:
> On Thu, Jul 24, 2025 at 12:55:53AM -0700, E Shattow wrote:
>> Drop no-sdio property avoids a delete-property on variant board dts
>> having an SDIO wireless module connected to mmc1.
> 
> I'm struggling to understand why this change is correct.
> 
> If there are specific boards that have wireless modules connected
> instead of using sdcards, how come the no-sdio property isn't moved to the
> the boards that do have sdcard slots?

Why is 'no-sdio' property there to begin with...

> The property was added for the visionfive 2, and only on mmc1, so should
> it be retained for boards that match the visionfive 2 in terms of how
> they use mmc?

Ref.:
https://lore.kernel.org/lkml/20221207131731.1291517-4-william.qiu@starfivetech.com/

My theory is VisionFive2 board hardware can support connecting up some
SDIO module there with ready-made available adapters, it may be possible
(if unusual) that would work? SDIO is 4-wide and some voltage
requirements, and a couple of GPIO, so I'm aware that's a stretch of a
statement but it could be done without soldering. I wouldn't expect it,
but why restrict this everywhere inheriting from jh7110-common.dtsi with
'no-sdio' and then (needs testing!) if it doesn't matter one way or the
other for VisionFive2 just drop it I think as being inaccurate/unnecessary?

JH7110 CPU supports two interfaces of SDIO3.0/eMMC so it's not clear to
me if there's some reason for 'no-sdio' property to be there. Does
allowing SDIO (?) break eMMC and SD Card devices, is it destructive?

Not knowing what 'no-sdio' does technically I dropped the property and
tested with the hardware I do have. The 'no-sdio' property
present/absent does not appear to do anything user-impactful on Pine64
Star64 that has SD Card slot on mmc1, and as would be expected on Milk-V
Mars CM Lite WiFi when there's an SDIO module at mmc1 it then fails to
initialize if 'no-sdio' property is present.

> 
> Could you add an explanation for why removing this entirely is the right
> thing to do, rather than only removing it for these variant boards?

Yes, I can rephrase a bit like "relax no-sdio restriction on mmc1 for
jh7110 boards", or else reconsider the approach. I was going to approach
with `/delete-property/ no-sdio;` later elsewhere but after testing on
Pine64 Star64 with similar configuration to VisionFive2 mmc interfaces,
and knowing that Milk-V Mars CM Lite WiFi detects AP6256 SDIO peripheral
at mmc1 when this property is dropped (and with a few additional
things)... I prefer to reduce the problems that would need to be avoided.

I have done all the testing I can do with hardware I have. As-is it's
just like I wrote, we'll have to solicit some testing feedback on that
and wait to learn what this does for the other boards.

Aside, anyone want to chime in what is the utility of 'no-sdio'
property, how do you know from a schematic if it is appropriate, can it
be simply dropped as I suggest for JH7110 boards?

> 
> Cheers,
> Conor.

Thank you for reviewing! -E

> 
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> index 2eaf01775ef5..a315113840e5 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> @@ -299,7 +299,6 @@ &mmc1 {
>>  	assigned-clock-rates = <50000000>;
>>  	bus-width = <4>;
>>  	bootph-pre-ram;
>> -	no-sdio;
>>  	no-mmc;
>>  	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>>  	disable-wp;
>>
>> base-commit: 28fa0dcb571ab8f3be4d919f0e20e01d4e44bcb1
>> -- 
>> 2.50.0
>>


