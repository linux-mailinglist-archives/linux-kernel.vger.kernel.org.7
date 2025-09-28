Return-Path: <linux-kernel+bounces-835212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CBBA6832
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5663E7A8313
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB0298CA4;
	Sun, 28 Sep 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="b0jlPIsM"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422482571D8;
	Sun, 28 Sep 2025 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759036246; cv=none; b=ohunnvH3nLs/trDUMCUWQQUWAIEvTorr3MHRidYd+mv03VoZ/AjbY/outRuMSIBVtwyHiawgKayt0HFSamp3d+nKnm8Pjx2nlgdI70A9m28MsMgIpw8Z2RFXCJ5TpjmI9zjw87ZxeUvI2Q9gGC0NUzrN0BtrOFcfCHGpJg/pRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759036246; c=relaxed/simple;
	bh=JVeyduZ9B0WvEndHfkob3D74kgS6vh9oCa6tNKbarFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3UkMqILYUP+/upruQzgJ9yKK40yijYgy6Cmuuhvr6iNVEQQnnJHtfY0VACULPySB499JsRgxfdIH1LdedqNJb2hpEAfveawTC8SCSduIPilDC6GzUaiuvCnKrFEeEalNb+fWgkGFfVsKo9tHs1m3MCLcfervFPvHculISaDVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=b0jlPIsM; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759036213;
	bh=UA1qJURCZwLdvL82SG3SQoBTLla6vgH9fxecp6XUcf0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=b0jlPIsMInmWrOZbVnRVc10Kdp7Mk+6ex3DI0EJ1191bB0LNsZ6FFjFQOthlYaw2f
	 1DlZPRsvCY1xElqW3rd5p2za2AuYznnx86+OGay3hgSMNJ4DZGWjiTAl2JBFBmWLCT
	 W5m/twYoSC4jqzEKGylvhFDq5LCebh4IqCcvTMbM=
X-QQ-mid: esmtpgz16t1759036211te633a7cc
X-QQ-Originating-IP: 5UrDWMN67WjQ6+g3kaNEmQsia4NxmONpMnxQZJnktgo=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 13:10:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15722752708494261181
EX-QQ-RecipientCnt: 16
Date: Sun, 28 Sep 2025 13:10:10 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: E Shattow <e@freeshell.de>, Troy Mitchell <troy.mitchell@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add MusePi Pro board device
 tree
Message-ID: <D0091C3AA4E189AD+aNjDMpVOUJ6SZcAJ@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>
 <beacb546-e4c4-43db-8f4c-97ea3cb55b43@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beacb546-e4c4-43db-8f4c-97ea3cb55b43@freeshell.de>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OE2SNMSfMbmObQuBdKOadN+RE08t5Th4Fv7LetsXZiNKJB4tQkLP7N2S
	gu3zQ0IE0cLy/Okp80cpybdx+JHWD0JN7AVJNEunH3neIFR7Skrpn/Lmhr4nv9bFz9QzW4r
	pwnnvBo8sPajwAK6S++/2KsnW/redxOVgTSqUTvGDSJIbC48OA6vvyxzT6xJZZGdX8fnKvP
	DbsOxqdCiQgyMfTdAc4yMFYr6VlPc+2Froz2bbwGxoo7CoOLTlCmwWcCQNwUHSKCQJ6atIV
	bKcTBIlCby/3DtxHfV17aAl3pvdNbi6ja4qssfD/2HSrlG+pplCyxFlol7OPzqklDZ4wE26
	ZGDTOMifNHhaah3Sk2iUlkItb7qga7B/0wUeCbOJjX8PFwaX0zvuEzd5bGzi5kyeA1ztWpd
	hUT0AFqw5fxMi/kBSoWvG6GJ8EGW05eAl9Yec3aqDwrKZ5mDcTErlSd0Xa1RFI1wrGw+T+s
	mjNYXneIF3pp6s5W4IQmFVI/wdTV/9NxN35fmik+YwlQoLHhk9DjccaQCne857Qljj9WWRt
	N7W7SIZAvEhIfr9lS+4sG5vFsXzSfdLC1X6MThOsehymaFDJw37j8CDFLJKcRDRcUpGPtfF
	eclMuK2MUIswtR0vtAL6LdP7lUGoBju8tZUKdO2/ebmBe27GyB+TwcTHuK45/sBE+sC4NvF
	60f6q863yjlVaNiAE0P34eyxf0n5qw66fKMS00drp+cF9gB3X6D4ZcNt5t5Lcl7Q+ufZdEj
	fBZd03U9FZiSGndarCkxmubzAYWW8mye1O+BSU8FCmgzB4Ex3JaGUhU8lbgKNQi0UJRf2Eo
	3ZTYjDMALb7SEuOFgnkXaUUcno38qXGHDsdDDbb59Q4v54LmaxYiNawOa+e9+qpG0VsoNuZ
	Cc5TFLjvbW2i/Mf0fWJ6LF7mSX2wOcTszV+akRVEd/AYiEhZmP/Rgp2rSJiPtM91jUWHUU/
	j3ehDK85IuzQ0IR24282TzzBYFfPEJL0YP4MGpBo73i3iSM7AAw9bOwbl4oYBBkd3EhtuHl
	5oKxI6aK0fSO2PUbzMa0PrQFEcUO6tjM75z0bKYO7+b15YGfvYCuH4P+NaEbD63jM0QJOP4
	lrGGe3ISsbktcEAvPc7tKY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Sat, Sep 27, 2025 at 10:05:54PM -0700, E Shattow wrote:
> On 9/27/25 21:16, Troy Mitchell wrote:
> > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > 
> > Add initial device tree support for the MusePi Pro board [1].
> > The board is using the SpacemiT K1/M1 SoC.
> > 
> > The device tree is adapted from the SpacemiT vendor tree [2].
> > 
> > This minimal device tree enables booting into a serial console with UART
> > output and a blinking LED.
> > 
> > Link:
> > https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> > https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> > 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/Makefile          |  1 +
> >  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 40 ++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> > index 152832644870624d8fd77684ef33addb42b0baf3..76b98096e2a46c3192651d6d66af7742f740c635 100644
> > --- a/arch/riscv/boot/dts/spacemit/Makefile
> > +++ b/arch/riscv/boot/dts/spacemit/Makefile
> > @@ -2,3 +2,4 @@
> >  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
> >  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
> >  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> > +dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..3791186ce47b88887eab4321dcd7035668e7f02d
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "k1.dtsi"
> > +#include "k1-pinctrl.dtsi"
> > +
> > +/ {
> > +	model = "MusePi Pro";
> > +	compatible = "spacemit,musepi-pro", "spacemit,k1";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> 
> > +		led1 {
> > +			label = "sys-led";
> > +			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +			default-state = "on";
> 
> Can you explain how you decided to sort this?  I think the documentation
> examples needs updating but it is unclear to me.
This snippet comes from the BPI-F3 DTS.
I only verified the pins and polarity against the schematic.

                           - Troy
> 
> > +		};
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_2_cfg>;
> > +	status = "okay";
> > +};
> > 
> 
> Best regards,
> 
> -E Shattow
> 

