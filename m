Return-Path: <linux-kernel+bounces-839839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59243BB289F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6113C6B49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F63285079;
	Thu,  2 Oct 2025 05:27:42 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6123185E;
	Thu,  2 Oct 2025 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382862; cv=none; b=N+R8Vj8yaul0fNEJS+lcqUjFfOQP69daClSg+qnKS1LJJUWIf7BTjTvxgrTU7lxY9uyaEai13AP91oMQ8P+ECr0pqE6oRBjvVK1n2FpOqRUkDEyYyp/fckT/GAk9qjL4A0LUl0QPnbCrfCEF0AAjjneH0lofEVbWmMzlj63yvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382862; c=relaxed/simple;
	bh=UVL0h2gpfbpisGJGWv9nM9Yclg14uvlw0HsAA7aPh8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQERF+AqKtN8triYvwkoqg2ErOVgVgVT17yC+/MInQWMTFIuYJUcNOc3ML8JI+/a4RQEqaSkZ+u3jfQTZ56/PKS7PNFF+d7A0Gcv0L8CXMGoDE/e0+P1fTe+dXcFXIniWnNsNGtWmq1e6h5LpOGy9V62+BsX8DcxVBZbwWWEJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.149])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 67423B22008E;
	Thu,  2 Oct 2025 07:27:28 +0200 (CEST)
Message-ID: <694a3d9e-4096-4782-a918-42d033737fbd@freeshell.de>
Date: Wed, 1 Oct 2025 22:27:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
To: Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut@mailbox.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
 <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
 <20250904093442.GA13411@nxa18884-linux.ap.freescale.net>
 <afe58aa6-0c3e-4508-8133-8e7621a0484a@mailbox.org>
 <PAXPR04MB845970863A16718967270D1A880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <PAXPR04MB845970863A16718967270D1A880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/25 00:07, Peng Fan wrote:
> Hi Marek,
> 
>> Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
>> imx9*-power.h into dt-bindings
>>
>> On 9/4/25 11:34 AM, Peng Fan wrote:
>>
>> Hi,
>>
>> sorry for my late reply.
>>
>>>> Instead of playing this "I found this code somewhere, so I can do
>>>>> whatever the same" answer the first implied question - why these
>> are
>>>>> bindings? Provide arguments what do they bind.
>>>>
>>>> I am not sure how to answer this, but what I can write is, that if I
>>>> scramble these IDs in either the DT or the firmware (which provides
>>>> the SCMI clock service), then the system cannot work. I am not sure
>>>> if this is the answer you are looking for.
>>>
>>> Marek,
>>>    Some U-Boot code indeed directly use the IDs to configure the clock
>> without
>>>    relying on any drivers. Since the SCMI IDs could not be moved to
>>> dt-bindings,
>>
>> Why can they not be moved to DT bindings ?
> 
> DT maintainers suggested to keep the files under
> arch/arm64/boot/dts/freescale/
> 
> https://lore.kernel.org/all/75ab9162-ed02-479d-92a1-7cfabff6b32e@linaro.org/
> 
> Regards
> Peng

Follow up FYI to all this is resolved from U-Boot [1] as not using the
header and duplicating the information.

1:
https://lore.kernel.org/u-boot/20250923-imx94-v1-5-cb3b65169048@oss.nxp.com/

There was yet some IRC discussion about what justification can be for
avoiding this maintenance and duplication.

I am dropping this suggestion to move imx9*-clock.h imx9*-power.h into
dt-bindings. There is some better way of doing this, maybe a future
dt-firmware includes? That is not at all my area of interest or
expertise, however. I just noticed something out-of-place and bring it
to our attention.

My great appreciation is due for the reviews and discussion about this.
Thanks, everyone!

-E

