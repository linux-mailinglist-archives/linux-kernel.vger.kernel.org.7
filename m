Return-Path: <linux-kernel+bounces-797963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42DB417B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F47A1BA3B37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7692EB5B4;
	Wed,  3 Sep 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ppw939gg"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D52E717C;
	Wed,  3 Sep 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886513; cv=none; b=dGt45mUUi65ZiHm+6xBFBmp6JPg2XTnCtJMtgPC4Lk9vm0gN35oPxTRZ2Hn+eJ3Bdd5kuczWqFxNy3c98yYEFZP7dVUkPGyWreSumv8xvc33zC5jTnie+1oT7ruRj+rtfJ69vHfS4uwSYQzTXhmM1ft0GXmO+/2H59URq8Q9hYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886513; c=relaxed/simple;
	bh=QbDzLws6hKJmfLlfIaHGNKzlgeQgIMEDyC2s/CZmLMQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBOAd0enddQFpqNr9uQoPJ+05f+5kw6OT2KfJMbfG9ke5Lnw4ulu91hd6jpmR8b3q/PifKSMdRn6VLNtya64yl9VK/vweh1GtSeARS+9w3avKXodlnRNfzpeFXnBDWvfTdU/Ht8re2ED8tbt+UghxxYcRRe/RI44B/kvzXk8VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ppw939gg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 25D9BA0D47;
	Wed,  3 Sep 2025 10:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=NxYdDeBt3ISiaJZS8Nj6
	jPsgZ8vTJC3HBOq7SluJ1CE=; b=Ppw939ggPE4xtXbZXt0bWgebMHysSYt/LTGa
	R3WtVxAR9k6Ii8iiPae+0uR+U9jJw5JO8YvI3tS8uJrTBalK/7+jDXCTgJiIgT0O
	OPwTzqMji+oyIimYGsG4Lj9UuqK4eR4L/DL0O+qVpmM5tOBV0qhDY6gL07IUT3Ll
	MHkmjxifEIzTIznuq6SIxfk5TsCMjqFcN3XGjrmQKOMynT37iohH9IwTqrlTXzLM
	j4NTiMrut75iCZAqEQWitN1o9X8gSz/5fykBxTywy9SyKo1h/l4HfsjfKrore/uu
	1/Krs28o9Dpkj1NfdUxSrpYN8Q+qCHB8702S0N0vtScBTukxVoZQ887iZE2RXyPn
	WNA7/+0GtVfTWqz2TjAwxWNhMkBso0cmVRCkiaf5GWO3hUFr8MpMLdgZDJgpf0VK
	hlqH8RyitxcJYw9h8apkazWTRVARmfR+YfpE1vr8fn7M0E0nKk+ios6b+Q6E3wTt
	Ggh9MC6qTHitOuCRfXF6b2Onj2QjLyDJ+iAd3cca3ckwi9/maApevhrWmDk1rH0u
	gV8+grgK4E7DMmqIsS7H4Lnw0cvQAisPtAvdIsfXV/qW7eKwkcoVBh6RSR+b92tZ
	ShUTdEi0rG/ELTpSbd0kebIMkddGH494FQzhvquSjH2IPzCbAfmWEHNCojiCgvac
	PBHFGuI=
Date: Wed, 3 Sep 2025 10:01:47 +0200
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
Message-ID: <aLf162kc8_VB163Z@debianbuilder>
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
 <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
 <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1756886508;VERSION=7998;MC=1461641227;ID=1362923;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E637062

On Wed, Sep 03, 2025 at 09:50:08AM +0200, Ahmad Fatoum wrote:
> Hi,
> 
> On 03.09.25 09:43, Csókás Bence wrote:
> > Hi,
> > 
> > On 2025. 09. 03. 9:28, Ahmad Fatoum wrote:
> >> Hello,
> >>
> >> On 15.08.25 17:17, Bence Csókás wrote:
> >>> The Ethernet PHY's reset GPIO should be specified in the node of the PHY
> >>> itself, instead of the MAC (`fec`). The latter is deprecated, and was an
> >>> i.MX-specific extension, incompatible with the new reset controller
> >>> subsystem.
> >>
> >> One reason to do it this way is that the PHY is in reset when the OS starts
> >> and the external phy-reset-gpios allows MAC probe to get the PHY out of
> >> reset, so it can be probed after reading its vendor/device IDs.
> >>
> >> Does switching to this new binding address this scenario? If so, it should
> >> be noted in the commit message.
> > 
> > Yes, but after it has been reset, if the platform supports Power Management, the PHY's clock will be turned off, which some PHYs (in our case the LAN8710) don't tolerate. This has been reported many times, just search LKML for "lan8710 reset".
> > 
> > So we want a more general solution [1] where the PHY subsystem resets them before enumerating. However, if the MAC driver claims the GPIO, then it can't be used by the PHY.
> 
> I agree that it makes sense for a PHY reset to be associated with the PHY
> device and controlled by the PHY driver. I am wary of regressions though,
> which is why I wanted the commit message to clearly spell out the implications.
> 
> > I will clarify the commit msg with this in mind.
> 
> Thanks.
> 
> > [1] https://lore.kernel.org/lkml/20250709133222.48802-4-buday.csaba@prolan.hu/
> 
> Is this mainline yet?
> 

No, it is not. It was never the most beautiful piece of code, so I understand
that.

But if you could give us some guidance, that would help a lot.

Specifically:

1)  If `phy-reset-gpios` is deprecated, than we should start treating it as
    such, and not rely on it in future releases. Perhaps we should also add a
    warning message, when it is found in the device tree.
2)  On the other hand, if it is here to stay for a long time, it should be
    fixed. Now the gpio is claimed during fec_reset_phy(), and never released.
    It can not be used by the driver later, like in fec_init(), because the
    gpio reference is only stored in a local variable of fec_reset_phy().
    Previous patches that would have stored the reference in the driver were
    rejected on the grounds that it is deprecated. But if it is not, then we
    can create a patch that would make it work properly.
3)  Andrew pointed out, that resetting a PHY before probing it may cause
    regressions. That is certainly a valid concern, but for most of the 
    devices resetting it means starting from a known state, and should be the
    default. But we could create a device tree property, that controls this
    behaviour.

Regards,
Csaba

> Cheers,
> Ahmad
> 
> > 
> >>>
> >>> Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
> >>> Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>lan8710 reset
> >>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> >>> ---
> >>>   arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
> >>>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
> >>> index f053358bc9317f8447d65013a18670cb470106b2..0a5e90704ea481b0716d6ff6bc6d2110914d4f31 100644
> >>> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
> >>> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
> >>> @@ -246,7 +246,6 @@ &fec1 {
> >>>       pinctrl-names = "default";
> >>>       pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
> >>>       phy-mode = "rmii";
> >>> -    phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
> >>>       phy-supply = <&reg_3v3_etn>;
> >>>       phy-handle = <&etnphy0>;
> >>>       status = "okay";
> >>> @@ -262,6 +261,13 @@ etnphy0: ethernet-phy@0 {
> >>>               pinctrl-0 = <&pinctrl_etnphy0_int>;
> >>>               interrupt-parent = <&gpio5>;
> >>>               interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> >>> +            /* Reset SHOULD be a PHY property */
> >>
> >> Comment belongs into commit message.
> > 
> > Agreed.
> > 
> >>> +            reset-names = "phy";
> >>> +            reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
> >>> +            reset-assert-us = <100>;
> >>> +            reset-deassert-us = <25000>;
> >>> +            /* Energy detect sometimes causes link failures */
> >>> +            smsc,disable-energy-detect;
> >>
> >> Unrelated change not described in the commit message.
> > 
> > Oh, this has accidentally made it into here from our DT. Thanks for spotting it!
> > 
> >> Cheers,
> >> Ahmad
> >>
> >>>               status = "okay";
> >>>           };
> >>>  
> >>> ---
> >>> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
> >>> change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907
> >>>
> >>> Best regards,
> >>
> >>
> > 
> > Bence
> > 
> > 
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 


