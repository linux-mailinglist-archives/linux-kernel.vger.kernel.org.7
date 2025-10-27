Return-Path: <linux-kernel+bounces-870864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A4C0BDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCDC4E9AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D72D6608;
	Mon, 27 Oct 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="k4bsVn2J"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76F20E023;
	Mon, 27 Oct 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544373; cv=none; b=nLIsRVQ4CjPhB8/LUPIj+Z8+QYtFUHZ2/3toudlxaICt2TsBMBVrwthAMwbBSB8reMHu9ulq6XwFd6PIR+llMWNxCAzVy7bI3tiba9ByT2Y8zr2eRPGZM3VrLCvQfHf4ZmYlBiR7CM05PWQxVB3NeIwdUOyNUxedAcIgaPkTFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544373; c=relaxed/simple;
	bh=h59bfUpi3F/foXC+GJQSnUSRcJxLeG09Eo83EaH2HW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhuRiXcaCT3DNjTD4C9IBPnECFPQGSBGWDv6D9f9HJBKvaoqye20JiVEcStcXm3BsilpXAnPsgf66v9TKwlbDCYFh6DzymMD0HFFQMojb+PDmi+1SATC6NReK8sogsSJcBkMG4XJ74+PRRUxU5/dXkWcYdUvCGa6304Rjxuqg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=k4bsVn2J; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761544355;
	bh=my9vZLPkRTNna12+/X3EKMPdDIeK1zdSSznwx53EkfE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=k4bsVn2JZEis/6UYupSwHGcGt1cSABcnRyVciGiOWULZdGKYdTR/u+xbXjcI1TpNc
	 T1Fhg+oarsBNJJ04f7/Vl1YsQZQabHKBArt4JsEtdOZmLMgoBVNUj4TjOrasEe7zqm
	 iHQVyzoC4LToO+Ur/O7QkTXXMek5HV7zHD/wfqTA=
X-QQ-mid: zesmtpsz2t1761544348te0ab8de3
X-QQ-Originating-IP: ccE7sEh+LMZjq4NCR3/oB/2RTSHJnA8eoYZaq7fSt4k=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 13:52:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11375060587838489606
EX-QQ-RecipientCnt: 16
Date: Mon, 27 Oct 2025 13:52:27 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: E Shattow <e@freeshell.de>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, Paul Walmsley <pjw@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Message-ID: <2305038FDFBECB6F+aP8Im8SEJK6mSRUw@kernel.org>
References: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
 <20251023-k1-musepi-pro-dts-v4-2-01836303e10f@linux.spacemit.com>
 <eaa5347b-af52-4de3-be58-f7b932c8fe01@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaa5347b-af52-4de3-be58-f7b932c8fe01@freeshell.de>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NIW6D/aGPwNbZ6u1Bu5EvDTuegQOXaXcKrzOlwbjx+t7VGUZhb+Fy7D6
	ewN9F4rGgA9fmg1yyFQbqlNhZi5k1I6xyhXbrDNmzIXsB7vVuZ4x8pxd5/dGPpUTkXu5mq3
	2KlPUuxeu/Ep7d2LBykLPEuBumsOx5t6a2B1lWajgwp9lMZ/7OGsy4GHlZ8oybmCohjCxkG
	oUziT/pgxBFaVXg4A+nmp5npeZj1bQqPpHiRAgosUjFLu2pP8jAddz7UEgPgpgheV1T2ttb
	cAt2czB2QBXD4RUDb5hCjs0ohXY/hsR/MnmG/7orG9bqp9K7wF/ysCkxtRiQQIDsA83eDN/
	jJ3YBR957JWbW5wHSrpeuAxRY5Wb1U1sTry5UePxP5xK5sXb6lQu1BOgjarUBJDhbnA8D+9
	twXde2eC2fYxaAEelhMYTGQmdfQO/+mcpOxG9VOygRRP1BIz5UNxA2QeBh4jgdj9ZKhaTn0
	ZrqEfM8PJO9dsjI9BENTMz8NjtfDIMDaQJ6Q0gZgtOwrEJ9H65FalegrA8F14Nh11XDB0TV
	ZQ8cY+YiVUz19CTxilBsgXVGJVFsxF8sno7I6IR7xNoJJkRhWiMWlMEvjpuVTe+QQFqgJxL
	eUbSWU0sfBMRKWED7xlY2t47iiH9EvM4RAImGzSI9OVXOp5zX2treiBva7srJvEMM2q+NZy
	oyY05Xa87PYWK5XoSGDL1a5vMwgosHfvIQ3a9sfY4LtMgvu+8jhOskbKsGLAL9RJWjUyM9I
	ra+RTf6MKXN3sotdw+L3dykCnp3gjrXOtv9+o6gEiR7M7Iv4lUnPI5j+UERzlk61Jz3KqHL
	Uy4kcGYSH0eCDtPE2M89v7SGW5X/mlTvWT0PGh8cYAM+EkXSqR6veczm/LoTfRpXMBSYkro
	ypKoccZoqWhea9cU/I8dF9o5n4Ui1zoi8Ct0f64FSTrfa4Lcr7yAKslper1+e0K4gLJWeo4
	H7D2UWrYV7aZMCWWrg3SY8he1gQc9kTll/sohHOxmcjzHnu7RzW9/rXPxn3x5SES35fEYin
	A1agFUIOZx2tkmwpfJvYFLhC6L4Tk3W/lE1XG8rD0H95mC7tfwxk7x0LZCJ4b8+9OmyXwSg
	AUCSScB/7WKH1S3xYDWEjW3Loe5Tawmsw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, Oct 23, 2025 at 04:53:53AM -0700, E Shattow wrote:
> On 10/23/25 00:28, Troy Mitchell wrote:
> > Add initial device tree support for the MusePi Pro board [1].
> > The board is using the SpacemiT K1/M1 SoC.
> > 
> > This device tree is adapted from the SpacemiT vendor tree [2] and
> > enables basic board functionality, including UART console, LED, eMMC,
> > Ethernet, and PDMA.
> > 
> > Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> > Link: https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> > Changelog in v4:
> > - modify commit message
> > - add SpacemiT copyright
> > - Link to v3: https://lore.kernel.org/all/20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com/
> > 
> > Changelog in v3:
> > - sort dts node
> > - add ethernet alias
> > - add emmc, pdma, and eth0 node (a squash of patches 3–5 from v2)
> > - Link to v2: https://lore.kernel.org/all/20251010-k1-musepi-pro-dts-v2-2-6e1b491f6f3e@linux.spacemit.com/
> > 
> > Changelog in v2:
> > - modify commit message
> > - swap pinctrl-names and pinctrl-0 properties in uart0 node
> > - rename model: "MusePi Pro" -> "SpacemiT MusePi Pro"
> > - keep the dtb-$(CONFIG_ARCH_SPACEMIT) entries in alphabetical order
> > - Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com/
> > ---
> >  arch/riscv/boot/dts/spacemit/Makefile          |  1 +
> >  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 79 ++++++++++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> > index 152832644870624d8fd77684ef33addb42b0baf3..942ecb38bea034ef5fbf2cef74e682ee0b6ad8f4 100644
> > --- a/arch/riscv/boot/dts/spacemit/Makefile
> > +++ b/arch/riscv/boot/dts/spacemit/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
> >  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
> > +dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
> >  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..29e333b670cf0a5c4ed852668460db475b9c44cb
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > + * Copyright (C) 2025 SpacemiT, Inc
> > + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "k1.dtsi"
> > +#include "k1-pinctrl.dtsi"
> > +
> > +/ {
> > +	model = "SpacemiT MusePi Pro";
> > +	compatible = "spacemit,musepi-pro", "spacemit,k1";
> > +
> > +	aliases {
> > +		ethernet0 = &eth0;
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
> > +		led1 {
> > +			label = "sys-led";
> > +			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +			default-state = "on";
> > +		};
> > +	};
> > +};
> > +
> > +&emmc {
> > +	bus-width = <8>;
> > +	mmc-hs400-1_8v;
> > +	mmc-hs400-enhanced-strobe;
> > +	non-removable;
> > +	no-sd;
> > +	no-sdio;
> 
> I doubt very much that 'no-sd' or 'no-sdio' are appropriate here. These
> are not general properties, they are useful only for specific
> workarounds of hardware that reacts badly to commands. Is the hardware
> broken that it needs these properties?
Thanks for the review. The three slots actually have distinct hardware
capabilities:
  - Slot 1 supports SD/SDIO (1/4 bit) and dual I/O voltage domains (1.8 V and 3.3 V).
  - Slot 2 supports SDIO/eMMC (1/4 bit) but does not support dual voltage domains.
  - Slot 3 supports only eMMC (1/4/8 bit) and is the only slot with a PHY.

Because of these differences, we need to explicitly specify no-sd and no-sdio
for slot 3 to prevent the MMC core from probing unsupported functions.

These are not general workarounds --—they reflect the actual hardware
limitations of the slots.

