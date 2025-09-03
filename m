Return-Path: <linux-kernel+bounces-798102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB39B41983
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481A23A9B58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C42ED85D;
	Wed,  3 Sep 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JVVbtdeQ"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EB1A7264;
	Wed,  3 Sep 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890088; cv=none; b=uIrOwiENqpZr6iRWHrlVTEk5V/PC2aEqv+1yvS/9ikR/M5+NZBdWbN2RilTNqQdjUxLW1VEVDpwKISj2u8Nm0l+/bC75/gaUiPwSAlAn+ROg1YgrhECUJXGkJlQMQ3FQ9k8Th5rdsv5Er6TcIXWEXl3Ye8B1M0KF9anKjHI6ngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890088; c=relaxed/simple;
	bh=RUEmUKNYm6/iJgFZj0dysnF0Rzwitb3AXoVyRx2E8CQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgxpiNPG9tQjXHhHGrf1BZGHqJvA+fGn4Jejqc0CPeMdMjq4wV3uWMMNA/6BJR4nE4Jo3Jp+0pJf5xljaUIuNYm93Np80HBat9j/0BTEIV7PCRtlNB9c69R6RbXUDwfj9PAP00gve43aLRwDQcN23VzVLd6iGfm801N+bIOOjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JVVbtdeQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6151BA079A;
	Wed,  3 Sep 2025 11:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=xI8kR4Vsm264OZYzKPTA
	7zHRqZ4MLO4Aq50kaY8JXe0=; b=JVVbtdeQaUMRFpo8oLiVhxU2KVOGZNKGqec6
	reucawqe031zerfch0qTB/uxnc73NIhehHNTyrOPoocvzIKPNFjIzTCbHkzPAD73
	xeRrC6hoeHBawJBst9kgS6vFTWUmOdVBJuIKdx2iuClwaWtoeU6HHnAvT+oy1S9p
	iwubdydIXaRR6hVtWaBJAepotRXK02k3H8LyAdthSaIwy8wTqGvjyeBnqnJ/ty9S
	34rDLSgbCBHCs2p1gEHtyhnaLHKEYF4HaN7knCd0LQ+nYjw/1VsFZhleugPdUhNr
	TpUP+upCeI8eQI0835R/NaTFUNISyENHuv+vovgtB26qdPOAt7vUQEhwLTeBS9UB
	efgkNqA+DvjL6ymLu6PLkBI5JfesRa66inSU1R2tg5YefN1k+LQIQY3FNPOuLlwO
	4Tw2JhB2VsiSzqQZfKV6OmmHXVXgUg1mMR96FAu93tbCZKrQshft+Wiq7P+VY/vA
	P2Udb+T1aP1FgvLoErYOhpX4LsMq7BdaEgK0ZeyOBHywG5hOXtQLF/NE9XPJA9Go
	Efe5gkMMjCGD+K9LIh/d4EorwsyaUY036+ToGWb9tkosksVCVYW95qJcHbwVBejs
	ec8yBV4ClKrBeIRN6r5e8i4Ko8OgzHcbDoqtS4wVLTW0X8EiMhEdqQSJRy8YnUvW
	7qdS5sY=
Date: Wed, 3 Sep 2025 11:01:20 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
CC: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
Message-ID: <aLgD4Dx828nKXfkC@debianbuilder>
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
 <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
 <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
 <aLf162kc8_VB163Z@debianbuilder>
 <e3966efb-9f81-4c01-86f3-c89864a89173@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3966efb-9f81-4c01-86f3-c89864a89173@pengutronix.de>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1756890080;VERSION=7998;MC=2853248995;ID=1364479;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E637062

On Wed, Sep 03, 2025 at 10:43:46AM +0200, Ahmad Fatoum wrote:
> Hi,
> 
> On 9/3/25 10:01 AM, Buday Csaba wrote:
> > On Wed, Sep 03, 2025 at 09:50:08AM +0200, Ahmad Fatoum wrote:
> >>> [1] https://lore.kernel.org/lkml/20250709133222.48802-4-buday.csaba@prolan.hu/
> >>
> >> Is this mainline yet?
> >>
> > 
> > No, it is not. It was never the most beautiful piece of code, so I understand
> > that.
> > 
> > But if you could give us some guidance, that would help a lot.
> > 
> > Specifically:
> > 
> > 1)  If `phy-reset-gpios` is deprecated, than we should start treating it as
> >     such, and not rely on it in future releases. Perhaps we should also add a
> >     warning message, when it is found in the device tree.
> 
> Disagreed. Deprecated properties should be removed only about clarifying
> the impact of the removal on users. Replacing a deprecated property with
> an expectation that bootloader board code has deasserted reset is not
> acceptable IMO.

I was only trying to reason, that since `phy-reset-gpios` has been marked as 
deprecated in 5.3 (which was 6 years ago), perhaps a inserting a warning note
now would be appropriate.
But that is related to the driver, not the DT.
I completely agree with the rest.

> 
> > 2)  On the other hand, if it is here to stay for a long time, it should be
> >     fixed. Now the gpio is claimed during fec_reset_phy(), and never released.
> >     It can not be used by the driver later, like in fec_init(), because the
> >     gpio reference is only stored in a local variable of fec_reset_phy().
> >     Previous patches that would have stored the reference in the driver were
> >     rejected on the grounds that it is deprecated. But if it is not, then we
> >     can create a patch that would make it work properly.
> 
> Ye, this needs to be solved differently.
> 
> > 3)  Andrew pointed out, that resetting a PHY before probing it may cause
> >     regressions. That is certainly a valid concern, but for most of the 
> >     devices resetting it means starting from a known state, and should be the
> >     default. But we could create a device tree property, that controls this
> >     behaviour.
> 
> Marco had a more involved series to address this:
> https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
> 
> But it went no where. I don't recall the details.
>

Interesting. So Andrew is not against resetting before probe, it just has to
be done properly. ;)
 
> I think the best you can do with existing bindings is to give your PHY a
> compatible that spells out vendor/device ID, e.g. ethernet-phy-id0141.0dd4.
> 
> Then Linux can probe the device even while it's in reset.
> 
> The downside is that it hardcodes a specific PHY ID, but this may be
> acceptable here.

Yes, for now that would be acceptable for us, with some loss of generality.

Regards,
Csaba

> 
> Cheers,
> Ahmad
> 
> > 
> > Regards,
> > Csaba
> > 
> >> Cheers,
> >> Ahmad
> >>
> >>>
> >>>>>
> >>>>> Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
> >>>>> Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>lan8710 reset
> >>>>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> >>>>> ---
> >>>>>   arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
> >>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
> >>>>> index f053358bc9317f8447d65013a18670cb470106b2..0a5e90704ea481b0716d6ff6bc6d2110914d4f31 100644
> >>>>> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
> >>>>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
> >>>>> @@ -246,7 +246,6 @@ &fec1 {
> >>>>>       pinctrl-names = "default";
> >>>>>       pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
> >>>>>       phy-mode = "rmii";
> >>>>> -    phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
> >>>>>       phy-supply = <&reg_3v3_etn>;
> >>>>>       phy-handle = <&etnphy0>;
> >>>>>       status = "okay";
> >>>>> @@ -262,6 +261,13 @@ etnphy0: ethernet-phy@0 {
> >>>>>               pinctrl-0 = <&pinctrl_etnphy0_int>;
> >>>>>               interrupt-parent = <&gpio5>;
> >>>>>               interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> >>>>> +            /* Reset SHOULD be a PHY property */
> >>>>
> >>>> Comment belongs into commit message.
> >>>
> >>> Agreed.
> >>>
> >>>>> +            reset-names = "phy";
> >>>>> +            reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
> >>>>> +            reset-assert-us = <100>;
> >>>>> +            reset-deassert-us = <25000>;
> >>>>> +            /* Energy detect sometimes causes link failures */
> >>>>> +            smsc,disable-energy-detect;
> >>>>
> >>>> Unrelated change not described in the commit message.
> >>>
> >>> Oh, this has accidentally made it into here from our DT. Thanks for spotting it!
> >>>
> >>>> Cheers,
> >>>> Ahmad
> >>>>
> >>>>>               status = "okay";
> >>>>>           };
> >>>>>  
> >>>>> ---
> >>>>> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
> >>>>> change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907
> >>>>>
> >>>>> Best regards,
> >>>>
> >>>>
> >>>
> >>> Bence
> >>>
> >>>
> >>
> >>
> >> -- 
> >> Pengutronix e.K.                           |                             |
> >> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> >>
> > 
> > 
> 
> -- 
> Pengutronix e.K.                  |                             |
> Steuerwalder Str. 21              | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |
> 
> 


