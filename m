Return-Path: <linux-kernel+bounces-835297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B8BA6A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3187D17CFFB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF52BD037;
	Sun, 28 Sep 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="zAJe62i6"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B114B08A;
	Sun, 28 Sep 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046758; cv=none; b=gQcp3igCmyZ0aShjH1CTbk4ifsWOgOI67ofWy41cCG1AxLTEzFMsqfSfp1pxwdCa47V4U5Qap1cAGP92l66uS5RSY5cprnnM4SAZkKH3WiS9W1Na2z0hwYV/UlifKsH3Ci/UOipWZ6Ah4duYGSvYk0oGVZIoTxTkj5kgBTGITUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046758; c=relaxed/simple;
	bh=+hPwyKvXo5cIFisxD0X+VGQkAAJQ9LlZh1ATQ6RWhk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ+BZ6JJqDUejXcmTuqTV+yGRWheg3OBZjgVBWsPrvA4vDdfZpaT43YFmg1FsP/Aog1eLDqzV8sqERrBhbr7y9jkDjh5xhiYfPMIp27RgOedZnd/MSJ5guWr4j0AcQcTP57eIxQWQfbkOC+9fM5sPlneWOMZw4BamDepfEf90aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=zAJe62i6; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759046733;
	bh=XydPf2hr5/LRillZoWelSgipJxHnxGk3kjMNGJt/nPE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=zAJe62i66neIscKAMAFNC62viSwONrq9JVNUIDEeXatHfPfuusRclOfWc+LY2Ny3b
	 d07TK6EIDa7ozzoOX+EUOBjt3ImaQwYXEdCVsja/x1ckRzxwiDEOKBx8DtK9mhgtLK
	 cpuhNKTYhNYHK76QR6AycxlTz6eSNzFv7fC1W03U=
X-QQ-mid: esmtpgz12t1759046731te1cd0686
X-QQ-Originating-IP: XgNb6m+8gRGQNrsjYykMtwnmjmXfp6Q8mOdpagPnEDI=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 16:05:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15804236060269286392
EX-QQ-RecipientCnt: 15
Date: Sun, 28 Sep 2025 16:05:29 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>, Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add MusePi Pro board device
 tree
Message-ID: <3074FC8521909735+aNjsSWwkd1aH-moh@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>
 <20250928080003-GYB1344940@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928080003-GYB1344940@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OZib3KF0u0PSFjQ+SEilOrivyJyHp3vgPJwyWPijs4lM1W6VnLouy/nd
	+X0v5DmXKdjfti5/2hsG8HV50/nMGPz+FGP/8sL3Lu3ip17Rs3r6Ca2Qi5IwTOBguMrb4YZ
	6chKtf02w4daoMD1Im0c2awAuCWz03mupqSWRkkLGImPMac8YwgL4huD7qHKVOx8l10AhOb
	8z8LRQjn0GjzdPFhWpfR0Nt6nCGV05CS9iCCc9ccjXwK9n+Az/G7Ct8vKu+nSzLdZDFT+oa
	BGL+amq+gQOgkEsv1CLvFR2lYczmDfzHHOL/6lNWSLsmefUA7DhFv855YDQ4L9XBQOLMVsZ
	w2A7oQIJBzob9vVul/nHlkqDTNL72QKJ95dePX8LbaC/jG8zr5iok3fnwz4tOYkjTI7A+lr
	hpS1E8VFaEBFJ+XFUY77FDX7ZxZWoqa/zh3j82d780jdRUqHty2DfUhUoUjsHjFdSVNaNyP
	Hvuzm74QYCRiHsiPN0ytC/VNopL7bK5hf/JZO5p/Kl9v0XjLzvtGB8DSfvhNyXgX983PPL8
	Px+xp+Pipd/b2vLhu74UGPYibx+c4zyy+7Vpo97oXiIlnLXvjQnPyvro3HpNuMRqjnsYj1R
	zE8T6ORAH/5ctUsfjHUoZ9qqG8lNP7ui76XsWK7aDxuInN8fDOXkW0lY/p65tb+vmysD6rt
	3RhPeFq5/p7nwqlcP5+AY+iZxN10DbSlhyzLfx1QIAtzTld1w6x1pfsvNaC8pwMT3L17h2R
	nROE0J/ga8L+LKUwjR2WdGuVKRnWswMKcyhX8AZih2QWRwL5EoX4kRJKhmEdysjoEfpZ/fq
	6aNRrNX6wRvtjXrXHAcXTTk15J3nC11a3Lomm6ZsHWxyFJq+dCfwJcTLlAeghbFGJTb1/yu
	KabXgaUR6p/Y606InSXN+BV/qk2DPsckP9WSu8k+Pm1bglwKrtVroAXOcb88qxUSoY9NNrn
	8hMSUtZO+3rL/JGudWXwRkqlEnYkVut5UEebUvUw98hXTkLC8PPSwwJ5Ys8Pc8Gaviblabt
	zeYdjUMPf+bQFDYBbo420uS6Jaynk/sRXVvWbH2iKrnAVJRUmBTAyhPnKbcLXKFJi9LTAOb
	t6/tfrP0YbObDmyPx88d8YMXzu0lywvKjiZQn8AwbVL+0X3oXb7KN55bYawaRxT2tSUkcR2
	Sb2z
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Sun, Sep 28, 2025 at 04:00:03PM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
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
> same as patch 1
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
> please sort
Oh my gosh..
That's my mistake. I will fix it in the next version.

> 
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
> this is a little bit short, how about make it "SpacemiT MusePi Pro"?
Sounds good to me.

> 
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
> > +		led1 {
> > +			label = "sys-led";
> > +			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +			default-state = "on";
> > +		};
> > +	};
> > +};
> > +
> > +&uart0 {
> ..
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_2_cfg>;
> swap these two lines, for similar reason, see my comment here
> https://lore.kernel.org/all/20250918133209-GYB1273705@gentoo.org/
Thanks for this link.
> 
> > +	status = "okay";
> > +};
> > 
> > -- 
> > 2.51.0
> > 
> 
> while you are here, I'd suggest to push as many features as possible
> instead of this minimal DT, which say - PMU, emmc, ethernet should be ready..
> (ethernet is in next, should show up at v6.18-rc1)
Good idea.
I think I should split these into multiple commits, right?
Like, PDMA and EMAC should definitely be two separate commits.

                                  - Troy
> 
> -- 
> Yixun Lan (dlan)
> 

