Return-Path: <linux-kernel+bounces-824362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2CAB88C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A185567E98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352A2FB969;
	Fri, 19 Sep 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m97Fghak"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A12E8DE9;
	Fri, 19 Sep 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277059; cv=none; b=UmER/R4dTJ0mvOkYpec7kW0IM53k16PsR+0mkt1vZKymfauFMDVgbkJgSovaaBeA/5OkgWLSDp5X5AGUL027ZTShnvN9I3C+E0nB4sF/iNQdxhLaCJT1stRSGyYX75ngyZvBiMyET+hIbLM0NV3S+dMW7smfv6/ukpCjfIE81qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277059; c=relaxed/simple;
	bh=AaMJMX/umNULrcGEgKJlRZR7C4PD7YTrpkq40L4KBHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfi36OW5HUn5X9ZwPysKTBin8Kr2eg64DNEKl523Yqj7f7pzv6pSakXnptkvZmpzOL41rawH7QnlZv2dVBuSMpFRBrutgIzGJJibT6wSUt9Dv/ClYOzEl4J9YaF0eqRXFvISxFKx/PvEP5RnuP5P3thROL+KfAqhhjUbWZmSkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m97Fghak; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc;
	bh=AaMJMX/umNULrcGEgKJlRZR7C4PD7YTrpkq40L4KBHc=; b=m97FghaklI6Mh+XLjeYg/ACj+Y
	59uf6lQkpa4JFaU5j+EH/ZzQjNRhgbdhVreCHInAydmdAgSlJJfW4kKoRNHVYOpbp5FcNigPqgTfA
	pCI/hl18DgxzPsWSlB3JUmD3PbKulXmf3dAMX/xHCUS+RryKRAhoSqjx+QH3ff/m9o8VwvuGUP+YH
	nJUNBn2H0lkhvtS74t31UFhEaC0yV4bX36LO9x9qGeyvZBPNpRXTXYA/9+p22GGdbcQJo6b8nIs+Y
	ADYHuy5ccq4UckYxaBuQCjxDGCm49OzOzGTU6NIqvxIcWEy4AuZYKrI6hjlVkQqsNWSb7hr3JRpd9
	ZeV8SDlw==;
Received: from i53875b0f.versanet.de ([83.135.91.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzYBG-0007nN-9m; Fri, 19 Sep 2025 12:17:30 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ed W <lists@wildgooses.com>,
 FUKAUMI Naoki <naoki@radxa.com>
Subject:
 Re: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa ZERO3
Date: Fri, 19 Sep 2025 12:17:29 +0200
Message-ID: <1971910.g5d078U9FE@diego>
In-Reply-To: <0DB47BC84E90B0E6+694b1274-4826-4ec1-9aa2-ca8aa790f61a@radxa.com>
References:
 <20250917114932.25994-1-lists@wildgooses.com> <2325560.3ZeAukHxDK@diego>
 <0DB47BC84E90B0E6+694b1274-4826-4ec1-9aa2-ca8aa790f61a@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 19. September 2025, 01:57:57 Mitteleurop=C3=A4ische Sommerzeit =
schrieb FUKAUMI Naoki:
> Hi Heiko, Ed,
>=20
> On 9/19/25 01:18, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 18. September 2025, 17:23:04 Mitteleurop=C3=A4ische Somm=
erzeit schrieb Ed W:
> >> On 18/09/2025 05:53, FUKAUMI Naoki wrote:
> >>> Hi Ed,
> >>>
> >>> Thank you very much for your work.
> >>>
> >>> On 9/17/25 20:49, Ed Wildgoose wrote:
> >>>> The rk3566 has multiplexed pins and the uarts can be moved to a choi=
ce
> >>>> of 2 pin groups. The default rk356x-base.dtsi appears to default to =
mux0
> >>>> for all uarts, however, specific hardware might choose to implement
> >>>> alternatives
> >>>>
> >>>> The Radxa zero 3 shows that is uses M1 for uarts:
> >>>> - uart4
> >>>> - uart5
> >>>> - uart9
> >>>>
> >>>> These aren't normally enabled, but we should at least correct the
> >>>> default pinctrl definitions. Without these changes there will be
> >>>> conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.
> >>>
> >>> Sorry, but why do we need these definitions for disabled nodes?
> >>>
> >>> Or why don't we do similar definitions for nodes other than uart?
> >>> For example, PWM12, I2S3, and SPI3 also use M1. Are they not related =
to SD/eMMC and therefore
> >>> don't need to be defined?
> >>>
> >>> If users want to use UARTs on pin headers, they will refer to the cor=
rect documentation[1] to
> >>> determine which pins are UARTs and will of course write the correct p=
inctrl definition.
> >>>
> >>> [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-int=
erface#gpio-interface
> >>>
> >>> Best regards,
> >>>
> >>
> >>
> >> Personally, and I'm saying this as a user who is technical enough to f=
ix the definitions, it took me
> >> quite a few days to figure out what was wrong with the definitions and=
 understand the intricate tree
> >> of dtsi includes, to finally figure out why I couldn't just do a "stat=
us =3D "okay";" to enable the
> >> UARTs... (which is roughly what is shown in several radxa supplied ove=
rlays to enable uarts on
> >> various boards)
> >>
> >> So my vote would be to correctly define all the hardware for a given b=
oard. Then users can simply do
> >> a status=3D"okay" to enable and off they go.
> >=20
> > And I'd agree with that argument. Setting up the needed pinctrl settings
> > for the peripherals described in the device documentation
> > ( https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interfa=
ce#gpio-interface )
> >=20
> > is the sensible thing to do. While keeping the peripherals itself disab=
led
> > and for the user to decide which peripheral to enable.
>=20
> I'm not strongly opposed to this policy, but I thought if you're going=20
> to do this, you should do it for everything, not just UARTs.

yes, exactly
So patches for the other header peripherals welcome :-) .

But still it's nice to do it in steps like this one, as it makes reviewing =
easier.


Heiko



