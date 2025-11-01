Return-Path: <linux-kernel+bounces-881242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F8C27CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D182349CB5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CC2F5473;
	Sat,  1 Nov 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="F9EcTBAS"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA142472BD;
	Sat,  1 Nov 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997501; cv=none; b=Q6xMR8iomgGQUaAl49zB2+eZSugSMpokTb7VDsoDxUJ+/elNR7Vf6lRTtWfNhRl4JA2B1iXuHvM8w/fTj7JeHxO2rKzU8t9HzwFxe096P5E9SCsAVrvg+8yVgAraxu58e5vdHcvss1BDy3yOrv/ZDRBOJjPaLJA8y6Na3HjDxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997501; c=relaxed/simple;
	bh=apFdAps6/VdDFE87AKGNyPIt5h79EDoCGG67amcKpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqZtIbD4AcqRDnlASLzYYZjp8KMFbH56LVEzkCVJ63wcYxAsuKpizaBMM/8fKICnxpfXY7hXzcKDian5PGeVD316FyJy20SeKlN6SHUEViguv0/3/7GZAhLnojwrQsPxIX8wP65heMtjoG0Ld7XJNrAaAitgJe4BPwKvOvV7cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=F9EcTBAS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=PHVYSvdDYI0ifXKzRw7b8rWjTZ1yx6Imu7EM6kr3mrU=; b=F9EcTBASWM5qh/zDz2Za0DKHJv
	O86Tv5obC46pwjRdwxGXFTKR4PRNCzkPOkXPSnqWov/3dIxsIxD3Ne0RjmQzOn0YG5aAkU3hFoL4g
	+s+WRlofAnWqd/jtEX59Us1aepVBVm2xn/WwE+qLd5oUHbVJjWXwdXWvVmywqjAXM7DJGN55ERaWK
	ek3ieHeDNY1kQSmWmFNZZTLr6kiWLGzqpxVmOjvJjL/CWDZDHP1owMZ6CwrvOLr8Nxh+wdd0rAeyu
	yCkTa1xbnBENaEsSEpr7zWK1X5Tn51bI3PZMKji1nQ1FpOIhiRfPgPeFX3BGaw9AcTUdIwyK3/A3G
	FK1eTZ3g==;
Received: from i53875b80.versanet.de ([83.135.91.128] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vFA2Q-0008ME-Vd; Sat, 01 Nov 2025 12:44:55 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Cc: sigmaris@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: pwm-fan overlay for NanoPC-T6
Date: Sat, 01 Nov 2025 12:44:54 +0100
Message-ID: <2246326.irdbgypaU6@phil>
In-Reply-To: <2cfeeb0c-f7e0-b101-62c4-3b6eae40a30b@manjaro.org>
References:
 <d583ee43-38c4-40fb-b33b-ce3153c9723b@gmail.com>
 <CABjd4Yzfx-4xBHVB=W_r6nEdbwNJKdpHYB6bN3Xsk8dZOegJWw@mail.gmail.com>
 <2cfeeb0c-f7e0-b101-62c4-3b6eae40a30b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 27. Oktober 2025, 22:15:05 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Dragan Simic:
> Hello Alexey,
>=20
> On Monday, October 27, 2025 21:56 CET, Alexey Charkov <alchark@gmail.com>=
 wrote:
> > On Tue, Oct 28, 2025 at 12:02=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg> wrote:
> > > On Mon, Oct 27, 2025 at 7:08=E2=80=AFPM Hugh Cole-Baker <sigmaris@gma=
il.com> wrote:
> > > > On 27/10/2025 09:14, Alexey Charkov wrote:
> > > >
> > > >> Is there any downside to enabling this unconditionally in the board
> > > >> .dts?
> > > >
> > > > Only that it goes against the principle that the DT should describe=
 the
> > > > hardware; the board .dts would describe a cooling device that doesn=
't
> > > > actually exist on the base board.
> > >
> > > Having a separate DT overlay is perfectly fine if we want to
> > > describe a board absolutely correctly: if the fan actually isn't
> > > present, the operating system shouldn't be made to think it is
> > > there, especially if there's no fan RPM feedback, which is the
> > > case on almost all Rockchip boards that support a fan.
> > >
> > > Preventing the kernel from managing a non-existent fan might even
> > > save some CPU cycles, ending up producing a bit less heat, which
> > > can only help in passively cooled setups.
> >=20
> > Sounds like an overcomplication without real benefit. It's one thing
> > with overlays for functionality that can be software-incompatible
> > depending on whether an external attachment is connected or depending
> > on the type of attachment connected. Here we are looking at a plain
> > 2-pin fan which cannot be software incompatible to anything really
> > (it's not like one could repurpose the fan connector for anything
> > meaningful if a fan is not in use, and noone gets hurt if a PWM output
> > is left running without load).
> >=20
> > The CPU cycles spent parsing a slightly larger DTB at boot are likely
> > comparable to those spent activating a PWM output needlessly upon
> > hitting the active cooling trip point, and both are negligible for any
> > practical purpose.
>=20
> Hmm, right, I forgot for a moment that the PWM output is generated
> by dedicated hardware, so not many CPU cycles would be wasted.
>=20
> BTW, with a fan PWM signal generated by a soft-GPIO output, much
> more CPU cycles would've been saved by omitting the fan definition
> if it isn't present, but that isn't the case here.
>=20
> > > However, the practice so far has been to describe the fans in the
> > > main board dts files, if the board provides fan support, regardless
> > > of the fan being present in a particular board setup or not.
> > >
> > > > I guess then in theory, an OS might allow the SoC to reach undesira=
bly high
> > > > temperatures if it's relying on the nonexistent fan to cool it down=
=2E But I
> > > > don't think this would be an issue on Linux, at least, in practice.
> > >
> > > We're safe, a thermal runaway isn't going to happen when the fan is
> > > defined in a board DT but actually isn't present.  Thermal CPU and
> > > GPU throttling will prevent the overheating from happening.
> > >
> > > >> Overlays require more user configuration, and not all
> > > >> bootloaders support them directly (e.g. systemd-boot users would
> > > >> struggle). Compiling with overlays enabled also makes .dtb's a lot
> > > >> larger due to added symbols information.
> > > >
> > > > Nowadays (on Debian at least) using overlays is pretty easy, I'm us=
ing the
> > > > u-boot-menu package in Debian, I just copy the overlay(s) to /boot/=
dtbo/ and
> > > > it detects them automatically and adds them to extlinux.conf for u-=
boot to
> > > > apply.
> > > >
> > > > Couldn't systemd-boot users just use rk3588-nanopc-t6-(lts-)with-fa=
n.dtb as
> > > > their single DT to load, if it doesn't support applying overlays an=
d they
> > > > want to use the fan addon?
> >=20
> > Sure, but it's a manual configuration step, where otherwise the kernel
> > would just default to the correct dtb for the board that the firmware
> > told it about. The fan is not discoverable, so the firmware won't ever
> > offer the "-with-fan" variant, meaning users would need to supply it
> > manually in every instance.
>=20
> FWIW, the most user-friendly SBC family in the world, Raspberry
> Pi, :) requires manual enabling of the fan on Raspberry Pi 4.
> I haven't researched what's the background for that, perhaps the
> need to keep the GPIO expansion header completely unoccupied by
> default, because the fan attaches to the GPIO header, instead of
> to some dedicated fan connector.
>=20
> > > Yes, that's an option.  However, that in general doesn't resolve
> > > the issues arising from systemd-boot users wanting to apply more
> > > than a single DT overlay.
> > >
> > > > FWIW, I haven't noticed any problems with having a larger .dtb (usi=
ng mainline
> > > > U-Boot to load it) and several other RK3588 boards are also compile=
d with
> > > > symbols enabled already, and I haven't seen any issues reported wit=
h them.
> > >
> > > After thinking a bit about it, I'd support the extraction of fan
> > > definitions into separate DT overlays.  As I wrote above already,
> > > not managing the non-existent fan might actually help a bit with
> > > passively cooled board setups, which is a good enough reason for
> > > me to support separate DT overlays.
> >=20
> > Practical benefits sound far fetched here, while forcing users to
> > manually configure something that would have otherwise just worked.
> > Let's see what Heiko thinks.

Personally, I'm more on the less complication side.

I.e. if there is an actual fan-connector on the board we should describe
it as such.

Overlays I see for things where you attach hats to generic pin headers
to create specific functionality on top of a generic interface.

But if the board itself has an actual fan header, it should be described
as such. Because that then _is_ the standard use of that.


Heiko



