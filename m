Return-Path: <linux-kernel+bounces-798054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD4B418F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008851BA496E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A52EC081;
	Wed,  3 Sep 2025 08:44:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACA26CE03
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889043; cv=none; b=ePkiJ8CwK0RVEnnattzXjRPVMGW4k5HF+iOAdHkxITSX2TIup8PD5VdcZsIBCNZeLl+vsRhdi/c+nbMjJqplFvbATdVAc6d5va5V+2RMR/IPjwMHP9LjfWi72Gg0ZDuWDllaF8DjpsiSQMFqKJ0zECnKj2Up4t1WZ1Ioyjp6hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889043; c=relaxed/simple;
	bh=hV80WKl/9UyJkVR2XuCyrywdEymnMo0ILh9DWhfk+Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vbl/903MGDFIRt2g2dKKASj1O969i0KjpkIAUG1mTQX7rNE8XVV+UaYMQsUaOoMVhDdur1gEYmVvJJIEuYpqv28pjQNpp7x+3SwN9XKiW/ODynXa1cwRbXLUQB/fpp/eU+GyanDaUYe0BK38q7fyhblaXb7+mRRhlD57Ck3jVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1utj5n-00047A-Ka; Wed, 03 Sep 2025 10:43:47 +0200
Message-ID: <e3966efb-9f81-4c01-86f3-c89864a89173@pengutronix.de>
Date: Wed, 3 Sep 2025 10:43:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
 <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
 <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
 <aLf162kc8_VB163Z@debianbuilder>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <aLf162kc8_VB163Z@debianbuilder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 9/3/25 10:01 AM, Buday Csaba wrote:
> On Wed, Sep 03, 2025 at 09:50:08AM +0200, Ahmad Fatoum wrote:
>>> [1] https://lore.kernel.org/lkml/20250709133222.48802-4-buday.csaba@prolan.hu/
>>
>> Is this mainline yet?
>>
> 
> No, it is not. It was never the most beautiful piece of code, so I understand
> that.
> 
> But if you could give us some guidance, that would help a lot.
> 
> Specifically:
> 
> 1)  If `phy-reset-gpios` is deprecated, than we should start treating it as
>     such, and not rely on it in future releases. Perhaps we should also add a
>     warning message, when it is found in the device tree.

Disagreed. Deprecated properties should be removed only about clarifying
the impact of the removal on users. Replacing a deprecated property with
an expectation that bootloader board code has deasserted reset is not
acceptable IMO.

> 2)  On the other hand, if it is here to stay for a long time, it should be
>     fixed. Now the gpio is claimed during fec_reset_phy(), and never released.
>     It can not be used by the driver later, like in fec_init(), because the
>     gpio reference is only stored in a local variable of fec_reset_phy().
>     Previous patches that would have stored the reference in the driver were
>     rejected on the grounds that it is deprecated. But if it is not, then we
>     can create a patch that would make it work properly.

Ye, this needs to be solved differently.

> 3)  Andrew pointed out, that resetting a PHY before probing it may cause
>     regressions. That is certainly a valid concern, but for most of the 
>     devices resetting it means starting from a known state, and should be the
>     default. But we could create a device tree property, that controls this
>     behaviour.

Marco had a more involved series to address this:
https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/

But it went no where. I don't recall the details.

I think the best you can do with existing bindings is to give your PHY a
compatible that spells out vendor/device ID, e.g. ethernet-phy-id0141.0dd4.

Then Linux can probe the device even while it's in reset.

The downside is that it hardcodes a specific PHY ID, but this may be
acceptable here.

Cheers,
Ahmad

> 
> Regards,
> Csaba
> 
>> Cheers,
>> Ahmad
>>
>>>
>>>>>
>>>>> Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
>>>>> Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>lan8710 reset
>>>>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
>>>>> ---
>>>>>   arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
>>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>>>>> index f053358bc9317f8447d65013a18670cb470106b2..0a5e90704ea481b0716d6ff6bc6d2110914d4f31 100644
>>>>> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>>>>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>>>>> @@ -246,7 +246,6 @@ &fec1 {
>>>>>       pinctrl-names = "default";
>>>>>       pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
>>>>>       phy-mode = "rmii";
>>>>> -    phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
>>>>>       phy-supply = <&reg_3v3_etn>;
>>>>>       phy-handle = <&etnphy0>;
>>>>>       status = "okay";
>>>>> @@ -262,6 +261,13 @@ etnphy0: ethernet-phy@0 {
>>>>>               pinctrl-0 = <&pinctrl_etnphy0_int>;
>>>>>               interrupt-parent = <&gpio5>;
>>>>>               interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>>>>> +            /* Reset SHOULD be a PHY property */
>>>>
>>>> Comment belongs into commit message.
>>>
>>> Agreed.
>>>
>>>>> +            reset-names = "phy";
>>>>> +            reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
>>>>> +            reset-assert-us = <100>;
>>>>> +            reset-deassert-us = <25000>;
>>>>> +            /* Energy detect sometimes causes link failures */
>>>>> +            smsc,disable-energy-detect;
>>>>
>>>> Unrelated change not described in the commit message.
>>>
>>> Oh, this has accidentally made it into here from our DT. Thanks for spotting it!
>>>
>>>> Cheers,
>>>> Ahmad
>>>>
>>>>>               status = "okay";
>>>>>           };
>>>>>  
>>>>> ---
>>>>> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
>>>>> change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907
>>>>>
>>>>> Best regards,
>>>>
>>>>
>>>
>>> Bence
>>>
>>>
>>
>>
>> -- 
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>
> 
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


