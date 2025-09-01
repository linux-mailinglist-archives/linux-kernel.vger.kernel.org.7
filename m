Return-Path: <linux-kernel+bounces-794392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B15B3E10E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35D71A81871
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6E311C35;
	Mon,  1 Sep 2025 11:07:40 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80630EF9D;
	Mon,  1 Sep 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724859; cv=none; b=eGt0T0GcK2SsM/Ik3vBR03vqM65UTwBlfbKDeBcAAubsL306o1Y/8ooLYoq2O2NrWYzA7mV9OJDz/7W7jIz4tc3g0tPLV0y8waUQ/bDvcC+Svi9tdWZ6LIXib5md3Vi33/Wxx6KiSAMOdrOQobiw9bvetADjVRjqPl9Zcxb4lMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724859; c=relaxed/simple;
	bh=JK7rLeY8FRK0Hyge6EiISVYQmSlKYuTMhKkZ8B6nZJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzx8DknACUqOFJ0k6EciutDFosX8r/hSH6V/SDE/jGPUg2IkU4agaVjCkLP7lJkE4TUYKC4fbpFpOUv0ntOk7Rj1QHTrQMckcOOrnrcpQ5y1lLZFw/bPmFESPu1FwpMaWVsZ2SAP5izDMoBhvWrwx/VPcq5aL4EU4XML4/lmfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 7297BB2202BC;
	Mon,  1 Sep 2025 13:07:31 +0200 (CEST)
Message-ID: <ef9dab99-f14a-4b1e-883f-d2086435b8d5@freeshell.de>
Date: Mon, 1 Sep 2025 04:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/25 03:54, Krzysztof Kozlowski wrote:
> On 01/09/2025 12:30, Marek Vasut wrote:
>> On 9/1/25 5:33 AM, Krzysztof Kozlowski wrote:
>>> On 01/09/2025 04:22, Marek Vasut wrote:
>>>> On 9/1/25 5:22 AM, Peng Fan wrote:
>>>>> On Sun, Aug 31, 2025 at 01:04:45PM -0700, E Shattow wrote:
>>>>>> Move imx9*-{clock,power}.h headers into
>>>>>> include/dt-bindings/{clock,power}/ and fix up the DTs
>>>>>
>>>>> No. The files should be under arch/arm64/boot/dts/freescale/
>>>> Why ? Linux already has include/dt-bindings/clock/ and
>>>> include/dt-bindings/power directories for exactly those headers , why
>>>> did iMX9 suddenly start conflating them into arch/arm64/boot/dts/freescale ?
>>>
>>>
>>> Because maybe these are not bindings?
>>
>> Please compare arch/arm64/boot/dts/freescale/imx95-clock.h and 
>> include/dt-bindings/clock/imx8mp-clock.h and clarify to me, why the 
>> imx95-clock.h is not bindings and the imx8mp-clock.h is bindings.
> 
> That's uno reverse card. I do not have to prove why these are different.
> You need to prove why imx95 are bindings.
> 
>>
>> Both files list clock IDs for the clock nodes, one clock one is SCMI 
>> clock (iMX95), the other clock node is CCM clock (iMX8MP), and they are 
> 
> Yeah, entirely different things. Like comparing apples and oranges.
> 
>> both (SCMI and CCM) clock nodes in DT. Both header files may have to be 
>> included in drivers, the iMX8MP headers already are, the iMX95 headers 
> 
> No, the SCMI cannot be used in the drivers, because these are not
> abstract IDs mapping between driver and DTS.
> 
>> currently are included only in U-Boot drivers.
>>
>> I really don't see the difference here, sorry.
> 
> You just pointed out difference - no usage in drivers, no ABI!
> 
> Instead of playing this "I found this code somewhere, so I can do
> whatever the same" answer the first implied question - why these are
> bindings? Provide arguments what do they bind.
> 
>>
>>> Regardless whether you agree or
>>> not, the commit should clearly explain the reason behind.
>> Which commit ?
> 
> This patch.
> 
> 
> Best regards,
> Krzysztof

Providing some clarification, the user of this (in U-Boot) via
devicetree-rebasing leads to some path gymnastics:

(U-Boot code base) arch/arm/mach-imx/imx9/scmi/clock.c:9:#include
"../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"

Compared to the patterns of what else is going on I would guess this
should instead be:

#include <dt-bindings/clock/imx95-clock.h>

which agrees with how it is done for all the other closely similar build
targets and is less fragile in that build context (although you may not
be interested in this since it's not Linux kernel code base). Ideally
I'm trying to make U-Boot flexible to build against different locations
of devicetree-rebasing or perhaps Linux kernel source tree. This is a
"one thing is not like the others" moment and it was suggested I send a
patch.

Whatever is best I'm open to improve the commit message, or take what
you think ought to be fixed in U-Boot there to improve.

What do we expect users of devicetree-rebasing to do, then?

Thanks,

E Shattow

