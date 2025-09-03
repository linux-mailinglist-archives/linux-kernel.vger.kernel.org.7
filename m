Return-Path: <linux-kernel+bounces-797921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BAB41735
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78DE5631C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5922DE718;
	Wed,  3 Sep 2025 07:50:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C22DF135
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885823; cv=none; b=Hn+ietDZMcEkM8bg42t77s0aeaqRVgesRjcgMiJi2d/FvW77VNF6rMPSL9QYZ3E10iRczCkmu9E146iLIGReMJgWNx3J+IkG08AVermKftZwcGANVBtKHEJpvcH8cQk2gE9xIOQHny1VM0CbkMWrdsnED9C0yOEss7DrXpQ3HyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885823; c=relaxed/simple;
	bh=TuBgFCVN80P4zt0j6ecpb8b24JTC+uS9IYg1hpSa7Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNnQH2TI/jOlTwd587tj/j6sg8DSNWFwAd2RY5Z/ufiXjvsG/7FKD1yGtn+k3te9ZMwe4yjwm2ancM7tBwx8EIq7Zw+KzmGCrKAAC5kB8h6HcrUujA5/guUUNdLQoyHL8fRC9KbHgqiGa6XpX0ywnFFgOk2rUiJxl2TOkkv2s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1utiFt-0008Ru-6M; Wed, 03 Sep 2025 09:50:09 +0200
Message-ID: <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
Date: Wed, 3 Sep 2025 09:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 Csaba Buday <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
 <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 03.09.25 09:43, Csókás Bence wrote:
> Hi,
> 
> On 2025. 09. 03. 9:28, Ahmad Fatoum wrote:
>> Hello,
>>
>> On 15.08.25 17:17, Bence Csókás wrote:
>>> The Ethernet PHY's reset GPIO should be specified in the node of the PHY
>>> itself, instead of the MAC (`fec`). The latter is deprecated, and was an
>>> i.MX-specific extension, incompatible with the new reset controller
>>> subsystem.
>>
>> One reason to do it this way is that the PHY is in reset when the OS starts
>> and the external phy-reset-gpios allows MAC probe to get the PHY out of
>> reset, so it can be probed after reading its vendor/device IDs.
>>
>> Does switching to this new binding address this scenario? If so, it should
>> be noted in the commit message.
> 
> Yes, but after it has been reset, if the platform supports Power Management, the PHY's clock will be turned off, which some PHYs (in our case the LAN8710) don't tolerate. This has been reported many times, just search LKML for "lan8710 reset".
> 
> So we want a more general solution [1] where the PHY subsystem resets them before enumerating. However, if the MAC driver claims the GPIO, then it can't be used by the PHY.

I agree that it makes sense for a PHY reset to be associated with the PHY
device and controlled by the PHY driver. I am wary of regressions though,
which is why I wanted the commit message to clearly spell out the implications.

> I will clarify the commit msg with this in mind.

Thanks.

> [1] https://lore.kernel.org/lkml/20250709133222.48802-4-buday.csaba@prolan.hu/

Is this mainline yet?

Cheers,
Ahmad

> 
>>>
>>> Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
>>> Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>lan8710 reset
>>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
>>> ---
>>>   arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>>> index f053358bc9317f8447d65013a18670cb470106b2..0a5e90704ea481b0716d6ff6bc6d2110914d4f31 100644
>>> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
>>> @@ -246,7 +246,6 @@ &fec1 {
>>>       pinctrl-names = "default";
>>>       pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
>>>       phy-mode = "rmii";
>>> -    phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
>>>       phy-supply = <&reg_3v3_etn>;
>>>       phy-handle = <&etnphy0>;
>>>       status = "okay";
>>> @@ -262,6 +261,13 @@ etnphy0: ethernet-phy@0 {
>>>               pinctrl-0 = <&pinctrl_etnphy0_int>;
>>>               interrupt-parent = <&gpio5>;
>>>               interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>>> +            /* Reset SHOULD be a PHY property */
>>
>> Comment belongs into commit message.
> 
> Agreed.
> 
>>> +            reset-names = "phy";
>>> +            reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
>>> +            reset-assert-us = <100>;
>>> +            reset-deassert-us = <25000>;
>>> +            /* Energy detect sometimes causes link failures */
>>> +            smsc,disable-energy-detect;
>>
>> Unrelated change not described in the commit message.
> 
> Oh, this has accidentally made it into here from our DT. Thanks for spotting it!
> 
>> Cheers,
>> Ahmad
>>
>>>               status = "okay";
>>>           };
>>>  
>>> ---
>>> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
>>> change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907
>>>
>>> Best regards,
>>
>>
> 
> Bence
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

