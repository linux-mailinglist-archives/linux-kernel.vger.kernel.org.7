Return-Path: <linux-kernel+bounces-860504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81694BF045D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6434A95D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F92F6171;
	Mon, 20 Oct 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jW7m505x"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2342F5A01;
	Mon, 20 Oct 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953302; cv=none; b=UUYnW6FlpaM/p26p0G0MDAPpnmE3KSGoibQIqLh1ZCpOZ6+4MuOWWy9OtJDII7520ezeAVI2qJxtKIJMEOlsdXn9jcMkr6x5RkXd8mZ1e0yXWiLGf/NrdsGq8tVfbw+k1vVf4VcYt9pi+B/dy5JMcHxM/14OTl7MYdqj/7JZUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953302; c=relaxed/simple;
	bh=YSVUm8OZlfe3TIJF+Pv92RMSSjIY1/in62vWNQJquJw=;
	h=From:Content-Type:Date:Cc:To:MIME-Version:Message-ID:Subject; b=GiHQYx3PXmgbhP3H/3aswzaTEh3BjZ5CF24am1QOH9iCcmPNlqoojxGV4ZLlT979eBSd4UzdKAhla8vLbSycDmIaAPSOZPHodSPtEcPxvrbkc2RWzg0f7GgRNIMfapUNN4RyF7VfULfkh7cX5QIdXI9D/D4dA6BtE/qfQpGvLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jW7m505x; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 08DE540D09;
	Mon, 20 Oct 2025 11:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760953293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QGW0UXPHuAzfUyVJq6SzZa/ZD5eWO7i1MGpbhW7LPcI=;
	b=jW7m505xbww0KhZcVkm/7a/5SkRhUKtxfzlyMz5EZs1RmvsphJ7m5lYLFyNG+c5m156ksA
	/iMsmNQq85AYSsMDegTbO8SFQPO0wTJbiZ2Z2RsWhicfRuh1RfxzHJtikBsxmzRGcuLP0z
	84QlUwkNCQ0xzH+23NnpYd2/yQmUW4JCXB8nru+JEBBgjttN1T+OvIR3R+OMCtDebkYMur
	oEGWpARae1AueVRbftD9Ao9WiCG5y0laFfwqtqMzdu590msFvWzWbBZMO9cETaL8Tm6Ylu
	tmDmByAxQCeQamP4oH5KLR/TAtmmQALfWHxDdb6QxvhENPhCw5NrmkqS+zvo8g==
From: "Dragan Simic" <dsimic@manjaro.org>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 20 Oct 2025 11:41:29 +0200
Cc: "Hugh Cole-Baker" <sigmaris@gmail.com>, "Jimmy Hon" <honyuenkwun@gmail.com>, "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Shawn Lin" <shawn.lin@rock-chips.com>
To: "Anand Moon" <linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <52537005-b8a3-c202-770c-599efc6a4d17@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Anand,

On Monday, October 20, 2025 05:13 CEST, Anand Moon <linux.amoon@gmail.c=
om> wrote:
> On Sun, 19 Oct 2025 at 23:40, Dragan Simic <dsimic@manjaro.org> wrote=
:
> > On Sunday, October 19, 2025 19:25 CEST, Anand Moon <linux.amoon@gma=
il.com> wrote:
> > > Would you consider the following patch?
> > >
> > > As per the Rockchip RK3588S SoC Technical Reference Manual (TRM) =
Part 1,
> > > chapter 21.6, Interface Description, the eMMC signals require car=
eful handling
> > > to ensure signal integrity.
> > >
> > > I2C2=5FSCL=5FM2 I/O EMMC=5FRSTN/I2C2=5FSCL=5FM2/UART5=5FRTSN=5FM1=
/GPIO2=5FA3=5Fd
> > > BUS=5FIOC=5FGPIO2A=5FIOMUX=5FSEL=5FL[15:12]=3D0x9
> > > I2C2=5FSDA=5FM2 I/O EMMC=5FDATA=5FSTROBE/I2C2=5FSDA=5FM2/UART5=5F=
CTSN=5FM1/GPIO2=5FA2=5Fd
> > > BUS=5FIOC=5FGPIO2A=5FIOMUX=5FSEL=5FL[11:8]=3D0x9
> > >
> > > $ git diff .
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dts=
i
> > > b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > > index 6584d73660f6..f60a1d8be0ef 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > > @@ -327,7 +327,7 @@ emmc {
> > >                 emmc=5Frstnout: emmc-rstnout {
> > >                         rockchip,pins =3D
> > >                                 /* emmc=5Frstn */
> > > -                               <2 RK=5FPA3 1 &pcfg=5Fpull=5Fnone=
>;
> > > +                               <2 RK=5FPA3 1 &pcfg=5Fpull=5Fdown=
=5Fdrv=5Flevel=5F2>;
> > >                 };
> > >
> > >                 /omit-if-no-ref/
> > > @@ -369,7 +369,7 @@ emmc=5Fcmd: emmc-cmd {
> > >                 emmc=5Fdata=5Fstrobe: emmc-data-strobe {
> > >                         rockchip,pins =3D
> > >                                 /* emmc=5Fdata=5Fstrobe */
> > > -                               <2 RK=5FPA2 1 &pcfg=5Fpull=5Fdown=
>;
> > > +                               <2 RK=5FPA2 1 &pcfg=5Fpull=5Fdown=
=5Fdrv=5Flevel=5F2>;
> > >                 };
> > >         };
> >
> > Frankly, I'm not really sure how would such changes do something
> > good regarding the eMMC signal integrity?  In general, signal
> > integrity depends mostly on the routing of the PCB traces, which
> > is purely hardware design.  Sure, termination of data lines also
> > plays a significant role, but that surely isn't at play here.
> >
> It is necessary to enhance the signal quality from the controller to
> the eMMC module

Well, yes, but the proposed change almost surely isn't a way
to achieve that.  Maybe I'm missing something, but it looks like
a pretty much random change to me.

> > Moreover, the eMMC RSTn line is already pulled high to VCCIO in
> > the reference RK3588 design, so pulling it down in the SoC itself
> > would be pretty much wrong thing to do.
> >
> It is specified in the TRM that this is only applicable during
> initialization.as per my understanding.

It doesn't matter what the TRM says in this case, because the
board-level pull-up and SoC-level pull-down remain the same at
all times, and having both a pull-up and a pull-down at the same
time is a typical example of what shouldn't be happening on some
line until that's intentional and the pull-ups and pull-downs
deliberately have different strengths.

Anyway, let's see will the patch that Shawn sent [1] fix this
issue (by the way, thanks, Shawn!).  I'll hold the A3A444 quirk
patch(es) off until Tianling's friend and Hugh find the time to
test Shawn's patch.

[1] https://patchwork.kernel.org/project/linux-mmc/patch/1760924981-523=
39-1-git-send-email-shawn.lin@rock-chips.com/


