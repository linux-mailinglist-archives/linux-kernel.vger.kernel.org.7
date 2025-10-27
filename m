Return-Path: <linux-kernel+bounces-872584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DDCC1181E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A93F34E3A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470CB32AAD8;
	Mon, 27 Oct 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="F/x2zxpM"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03E31D753;
	Mon, 27 Oct 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599713; cv=none; b=bM4qNaa35ya7tpvPcvIEgt3F+raYLsSsCtD5cTDGru4J/+LUVTBwAuDNZo3Da2AJFyVRgEMd9pxjvRlfnVnGusRHwsZgGxB69D7N2AWIhULqn8X2yDxytSnKlOV6WZo01Sq9oZRdr1qNSqtWzHlVWOFdJpl5uhlKOS02Aam2VAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599713; c=relaxed/simple;
	bh=aIIISvl+2w9gMkRNXeAD6BlzEj3AzToc1TnYUAr3v0o=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=hV81cxL2Khzt9oFwFmNRT7L3oae4fhOlrtGSgoj4ldGSxY+Hen/m+2r5ec9h/jQeSo2pkfKQXqnEqkIPlCJXoPpJODXFLf2PiN4LL4aFQZKAak9/INUreJAe2Kg/UJItfMc1VJIN2WQrSn/fFHH9cLIP+go+vqA7TVWFQFxEPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=F/x2zxpM; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 6B5AD40DAC;
	Mon, 27 Oct 2025 22:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761599706; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NsJHqtCUOKaeyUZLOt1nWUAZg2XGRpC5R7J3KADVzZQ=;
	b=F/x2zxpML96YLUS6jmMKMg2jetatzUaTlWCQIxO+AIbDXC1LdJWlwXOAK5j/QaZ0g4NlTX
	ixcDHZqgVKJH3G6+DSSqXmFwUI9VDyp9wMOMe3VkzUwwIP13AnMts2noOBvM/fDiEeddIP
	5mMTVYLUuoA/dDA13yCIysFWvsvmOisrpxF1shiyZQe5DzadoQVvUzHo+RT81wfJSCqeh4
	VJc7bU0hJCdYkL7Zc9ggXastvje7yqVMvTD4fy1HeEK1WSIESJXQuIE0kVIFNYGfmOEnTD
	aJ+vDrnKmjC5SOygsbpRLpsuJfTwcIy7hPWuQZM965sNkq5VJd/kB/K0TCFfCA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <CABjd4Yzfx-4xBHVB=W_r6nEdbwNJKdpHYB6bN3Xsk8dZOegJWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <d583ee43-38c4-40fb-b33b-ce3153c9723b@gmail.com> <20251027200213.1821809-1-dsimic@manjaro.org> <CABjd4Yzfx-4xBHVB=W_r6nEdbwNJKdpHYB6bN3Xsk8dZOegJWw@mail.gmail.com>
Date: Mon, 27 Oct 2025 22:15:05 +0100
Cc: sigmaris@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, robh@kernel.org
To: "Alexey Charkov" <alchark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2cfeeb0c-f7e0-b101-62c4-3b6eae40a30b@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= pwm-fan overlay for NanoPC-T6
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Alexey,

On Monday, October 27, 2025 21:56 CET, Alexey Charkov <alchark@gmail.co=
m> wrote:
> On Tue, Oct 28, 2025 at 12:02=E2=80=AFAM Dragan Simic <dsimic@manjaro=
.org> wrote:
> > On Mon, Oct 27, 2025 at 7:08=E2=80=AFPM Hugh Cole-Baker <sigmaris@g=
mail.com> wrote:
> > > On 27/10/2025 09:14, Alexey Charkov wrote:
> > >
> > >> Is there any downside to enabling this unconditionally in the bo=
ard
> > >> .dts?
> > >
> > > Only that it goes against the principle that the DT should descri=
be the
> > > hardware; the board .dts would describe a cooling device that doe=
sn't
> > > actually exist on the base board.
> >
> > Having a separate DT overlay is perfectly fine if we want to
> > describe a board absolutely correctly: if the fan actually isn't
> > present, the operating system shouldn't be made to think it is
> > there, especially if there's no fan RPM feedback, which is the
> > case on almost all Rockchip boards that support a fan.
> >
> > Preventing the kernel from managing a non-existent fan might even
> > save some CPU cycles, ending up producing a bit less heat, which
> > can only help in passively cooled setups.
>=20
> Sounds like an overcomplication without real benefit. It's one thing
> with overlays for functionality that can be software-incompatible
> depending on whether an external attachment is connected or depending
> on the type of attachment connected. Here we are looking at a plain
> 2-pin fan which cannot be software incompatible to anything really
> (it's not like one could repurpose the fan connector for anything
> meaningful if a fan is not in use, and noone gets hurt if a PWM outpu=
t
> is left running without load).
>=20
> The CPU cycles spent parsing a slightly larger DTB at boot are likely
> comparable to those spent activating a PWM output needlessly upon
> hitting the active cooling trip point, and both are negligible for an=
y
> practical purpose.

Hmm, right, I forgot for a moment that the PWM output is generated
by dedicated hardware, so not many CPU cycles would be wasted.

BTW, with a fan PWM signal generated by a soft-GPIO output, much
more CPU cycles would've been saved by omitting the fan definition
if it isn't present, but that isn't the case here.

> > However, the practice so far has been to describe the fans in the
> > main board dts files, if the board provides fan support, regardless
> > of the fan being present in a particular board setup or not.
> >
> > > I guess then in theory, an OS might allow the SoC to reach undesi=
rably high
> > > temperatures if it's relying on the nonexistent fan to cool it do=
wn. But I
> > > don't think this would be an issue on Linux, at least, in practic=
e.
> >
> > We're safe, a thermal runaway isn't going to happen when the fan is
> > defined in a board DT but actually isn't present.  Thermal CPU and
> > GPU throttling will prevent the overheating from happening.
> >
> > >> Overlays require more user configuration, and not all
> > >> bootloaders support them directly (e.g. systemd-boot users would
> > >> struggle). Compiling with overlays enabled also makes .dtb's a l=
ot
> > >> larger due to added symbols information.
> > >
> > > Nowadays (on Debian at least) using overlays is pretty easy, I'm =
using the
> > > u-boot-menu package in Debian, I just copy the overlay(s) to /boo=
t/dtbo/ and
> > > it detects them automatically and adds them to extlinux.conf for =
u-boot to
> > > apply.
> > >
> > > Couldn't systemd-boot users just use rk3588-nanopc-t6-(lts-)with-=
fan.dtb as
> > > their single DT to load, if it doesn't support applying overlays =
and they
> > > want to use the fan addon?
>=20
> Sure, but it's a manual configuration step, where otherwise the kerne=
l
> would just default to the correct dtb for the board that the firmware
> told it about. The fan is not discoverable, so the firmware won't eve=
r
> offer the "-with-fan" variant, meaning users would need to supply it
> manually in every instance.

FWIW, the most user-friendly SBC family in the world, Raspberry
Pi, :) requires manual enabling of the fan on Raspberry Pi 4.
I haven't researched what's the background for that, perhaps the
need to keep the GPIO expansion header completely unoccupied by
default, because the fan attaches to the GPIO header, instead of
to some dedicated fan connector.

> > Yes, that's an option.  However, that in general doesn't resolve
> > the issues arising from systemd-boot users wanting to apply more
> > than a single DT overlay.
> >
> > > FWIW, I haven't noticed any problems with having a larger .dtb (u=
sing mainline
> > > U-Boot to load it) and several other RK3588 boards are also compi=
led with
> > > symbols enabled already, and I haven't seen any issues reported w=
ith them.
> >
> > After thinking a bit about it, I'd support the extraction of fan
> > definitions into separate DT overlays.  As I wrote above already,
> > not managing the non-existent fan might actually help a bit with
> > passively cooled board setups, which is a good enough reason for
> > me to support separate DT overlays.
>=20
> Practical benefits sound far fetched here, while forcing users to
> manually configure something that would have otherwise just worked.
> Let's see what Heiko thinks.

Yeah, I forgot for a moment that the PWM signal is generated
by hardware, which means that the resulting overheads when no
fan is present are rather small.

> > If we end up agreeing to accept this DT overlay, I'll have some
> > comments on the way cooling maps are defined.  I think there's
> > quite a bit of redundancy there.
>=20
> Agree. Thermal governors can figure out the fan speed ramp-up without
> specifying each and every temperature threshold manually. Two trips
> seem to be enough for everyone (c) - as we've done e.g. on Rock 5B an=
d
> others.

Indeed, and if there are actually measurable/audible benefits
from having those manually defined thresholds/maps, then we
should start thinking about improving the already existing
fan-driving logic instead.


