Return-Path: <linux-kernel+bounces-823260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F355AB85F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EC94A4D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B13074AE;
	Thu, 18 Sep 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IzQ3gB5k"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C5220F5C;
	Thu, 18 Sep 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212311; cv=none; b=V1AUTXH29AVRdXH+Kmo20qIUwXiXFrH5VnayXh7YMB0gcE7anIf43EZbq9xTTn54Dqv6sSr8CZxsybnbLcYnduxlKimyu1bv3vKZS/Rf76rJ6Ibwf3mD4fSQaok0i+tnTE4xE7p4thKiyjsrLe5TMUU+2HeqRLpl4REKLc/1NvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212311; c=relaxed/simple;
	bh=ninNeWEmz3Wj53O9s8gF8RXSPwXAfvqBAcR4jaHa4D8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/VmaR0pJCoy9Jb3Isxy6cR/08RaOuve00IVJA2W27HIz3d8Xv2vcgrlLfYfw4YPYVQTeFbKJHvq8w7B+rCLNiXGRUOE3eWF/6iMbkvQIU8kPpg+8Do1G+422B5FRyc0mAYE804BagmYXqMky8qQaddNrmwew63bQ3fdTMs1BAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IzQ3gB5k; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc;
	bh=ninNeWEmz3Wj53O9s8gF8RXSPwXAfvqBAcR4jaHa4D8=; b=IzQ3gB5kMzVaoDZubjbNyvLEeH
	Y8EdbjZaPEGufSFgqArSrQWsXjOqXDcS29gAZ0vIGFDLDkHN+tf/zsQhU0pD36a1MgA+ZpUDJE92u
	TMd9BLoua4CEivJdq133lp8O5VUx88Rm8pLgrCW+KaT2T4U0tv5AceP3RTE96YEw4AX/19Ut89mPq
	QxMBbt6IMKZAo30UAWTzK6I366Wcdo2yrHONbkGAv6g6foGiicswPvLocRMlPKepzB4l0xpe8PtKb
	MGjZV2tx4y3/53XQaQvvjmhvVTIX1EnNlHLeuXy/69Z99/kyJBdLOYuiuRQETLMdTMvvbQS0U55Au
	TKnxHl6Q==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzHKw-0001xW-Pd; Thu, 18 Sep 2025 18:18:22 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: FUKAUMI Naoki <naoki@radxa.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ed W <lists@wildgooses.com>
Subject:
 Re: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa ZERO3
Date: Thu, 18 Sep 2025 18:18:22 +0200
Message-ID: <2325560.3ZeAukHxDK@diego>
In-Reply-To: <adbc2396-d5f0-4dd6-a65e-0dd78a58b9a4@wildgooses.com>
References:
 <20250917114932.25994-1-lists@wildgooses.com>
 <FBB5B30DE8FEABD7+59ee6f48-2ad1-45dd-8cf1-8b58a03513a9@radxa.com>
 <adbc2396-d5f0-4dd6-a65e-0dd78a58b9a4@wildgooses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 18. September 2025, 17:23:04 Mitteleurop=C3=A4ische Sommerze=
it schrieb Ed W:
> On 18/09/2025 05:53, FUKAUMI Naoki wrote:
> > Hi Ed,
> >
> > Thank you very much for your work.
> >
> > On 9/17/25 20:49, Ed Wildgoose wrote:
> >> The rk3566 has multiplexed pins and the uarts can be moved to a choice
> >> of 2 pin groups. The default rk356x-base.dtsi appears to default to mu=
x0
> >> for all uarts, however, specific hardware might choose to implement
> >> alternatives
> >>
> >> The Radxa zero 3 shows that is uses M1 for uarts:
> >> - uart4
> >> - uart5
> >> - uart9
> >>
> >> These aren't normally enabled, but we should at least correct the
> >> default pinctrl definitions. Without these changes there will be
> >> conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.
> >
> > Sorry, but why do we need these definitions for disabled nodes?
> >
> > Or why don't we do similar definitions for nodes other than uart?
> > For example, PWM12, I2S3, and SPI3 also use M1. Are they not related to=
 SD/eMMC and therefore
> > don't need to be defined?
> >
> > If users want to use UARTs on pin headers, they will refer to the corre=
ct documentation[1] to
> > determine which pins are UARTs and will of course write the correct pin=
ctrl definition.
> >
> > [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-inter=
face#gpio-interface
> >
> > Best regards,
> >
>=20
>=20
> Personally, and I'm saying this as a user who is technical enough to fix =
the definitions, it took me
> quite a few days to figure out what was wrong with the definitions and un=
derstand the intricate tree
> of dtsi includes, to finally figure out why I couldn't just do a "status =
=3D "okay";" to enable the
> UARTs... (which is roughly what is shown in several radxa supplied overla=
ys to enable uarts on
> various boards)
>=20
> So my vote would be to correctly define all the hardware for a given boar=
d. Then users can simply do
> a status=3D"okay" to enable and off they go.

And I'd agree with that argument. Setting up the needed pinctrl settings
for the peripherals described in the device documentation
( https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface#g=
pio-interface )

is the sensible thing to do. While keeping the peripherals itself disabled
and for the user to decide which peripheral to enable.

Heiko



