Return-Path: <linux-kernel+bounces-891582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12068C42FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2898F4E6194
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E828228CB0;
	Sat,  8 Nov 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0w+fyRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846F78F4F;
	Sat,  8 Nov 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762619041; cv=none; b=cHPlQRKYh4w0uTTRrWZR46Jg41tLXPuiG+yJ31NHRsasDYK2GtQeEmqFcBySF3R4Ut8LqnroS2TI0N4T1XGhbZxUGD6cTNFdEk8GublLIsrYq8Z27S1mlf3wp7Dgbqb1MqnRnjKelNmyU//7AH9oXVb90Q22IvEMiXBd6/nEWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762619041; c=relaxed/simple;
	bh=8xqsPy/8pD1oeGp2VPuCIqEvJBg7qqACdyqs52xqN6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KavWRZg8o15X2uv0PklqkXTwbFffSGJtJeHSkNNTKcHZDUGrhgKwWl3wi7zAaPY3nIl/UDKE0vjMu5vJ51w2YNcuuVsO+5fmMIsh+tdt1VtOTce1EjJzn3kVK4nxNjFAEywLvyUIUSPQ/QcybZJHBHItqHtQecs5//ck1HEgFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0w+fyRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3B3C4CEFB;
	Sat,  8 Nov 2025 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762619041;
	bh=8xqsPy/8pD1oeGp2VPuCIqEvJBg7qqACdyqs52xqN6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0w+fyRXmNsZ8ePbH/yGTTzgTjPNUbhxtUeFJ++0E7FJCnAMxC7ry9r6Gs7j9F3SJ
	 y5gStanuy804lxMfhMnpMV6aKJQk/M/JEzbC3SR0arexAXsELjpb42+xkDUFY6oncf
	 LcEtfTs520zxEJ4zYty6e/HphgJ0RurYMWAfTJoGGHeJ9JtswdgDcfifJUhxroMfak
	 apT4Z9g9V3u3cpfrtp6bGCDbeakyKwaJXkx6Ycij4DR9MB1eLba7+103VM0A1eJo5h
	 7SDotm1e+kUqBZYfD8axcmds/B3mn6HPX5/5nlEd1tV4Dq2DPB6Id8b8Dho/vq8oLY
	 HPh1bYIoyST3w==
Date: Sat, 8 Nov 2025 16:23:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: revy <gaohan@iscas.ac.cn>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>, krzk+dt@kernel.org,
	conor+dt@kernel.org, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Yixun Lan <dlan@gentoo.org>,
	Drew Fustini <fustini@kernel.org>, geert+renesas@glider.be,
	Guodong Xu <guodong@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Joel Stanley <joel@jms.id.au>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 1/3] riscv: soc: re-organized allwinner menu
Message-ID: <20251108-hurler-clammy-0df5e778c04c@spud>
References: <cover.1762588494.git.gaohan@iscas.ac.cn>
 <d17a3a01e2b1297538c419b51953f9613426ba42.1762588494.git.gaohan@iscas.ac.cn>
 <e98a1e59-f3ff-4e9f-a180-79aea9943236@kernel.org>
 <43109A90-8447-4006-8E29-2D2C0866758F@iscas.ac.cn>
 <287444fa-120c-42b4-9919-2f05ab1a2ab7@kernel.org>
 <8ae5d81d-4869-4c39-9561-cb0f87da70fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zDi7HsMP+xaYfO8R"
Content-Disposition: inline
In-Reply-To: <8ae5d81d-4869-4c39-9561-cb0f87da70fd@kernel.org>


--zDi7HsMP+xaYfO8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 03:48:18PM +0100, Krzysztof Kozlowski wrote:
> On 08/11/2025 15:47, Krzysztof Kozlowski wrote:
> > On 08/11/2025 14:59, revy wrote:
> >>
> >>
> >>
> >>> -----Original Messages-----
> >>> From: "Krzysztof Kozlowski" <krzk@kernel.org>
> >>> Sent Time: 2025-11-08 19:29:07 (Saturday)
> >>> To: gaohan@iscas.ac.cn, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dab=
belt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre=
 Ghiti" <alex@ghiti.fr>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlow=
ski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Chen-Yu T=
sai" <wens@csie.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Samuel =
Holland" <samuel@sholland.org>, "Yixun Lan" <dlan@gentoo.org>, "Drew Fustin=
i" <fustini@kernel.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>, "G=
uodong Xu" <guodong@riscstar.com>, "Haylen Chu" <heylenay@4d2.org>, "Joel S=
tanley" <joel@jms.id.au>
> >>> Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, de=
vicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi=
@lists.linux.dev, "Han Gao" <rabenda.cn@gmail.com>
> >>> Subject: Re: [PATCH 1/3] riscv: soc: re-organized allwinner menu
> >>>
> >>> On 08/11/2025 09:20, gaohan@iscas.ac.cn wrote:
> >>>> From: Han Gao <gaohan@iscas.ac.cn>
> >>>>
> >>>> Allwinner currently offers d1(s)/v821/v861/v881 on RISC-V,
> >>>> using different IPs.
> >>>>
> >>>> d1(s): Xuantie C906
> >>>> v821: Andes A27 + XuanTie E907
> >>>> v861/v881: XuanTie C907
> >>>>
> >>>> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> >>>> ---
> >>>> arch/riscv/Kconfig.socs | 22 +++++++++++++++++-----
> >>>> 1 file changed, 17 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> >>>> index 848e7149e443..7cba5d6ec4c3 100644
> >>>> --- a/arch/riscv/Kconfig.socs
> >>>> +++ b/arch/riscv/Kconfig.socs
> >>>> @@ -54,14 +54,26 @@ config SOC_STARFIVE
> >>>> 	help
> >>>> 	  This enables support for StarFive SoC platform hardware.
> >>>>
> >>>> -config ARCH_SUNXI
> >>>> -	bool "Allwinner sun20i SoCs"
> >>>> +menuconfig ARCH_SUNXI
> >>>> +	bool "Allwinner RISC-V SoCs"
> >>>> +
> >>>> +if ARCH_SUNXI
> >>>> +
> >>>> +config ARCH_SUNXI_XUANTIE
> >>>
> >>>
> >>> You should not get multiple ARCHs. ARCH is only one. There is also not
> >>> much rationale in commit msg for that.
> >>
> >> The main goal is to avoid choosing multiple IP addresses for erreta.=
=20
> >> If using Andes IPs, I don't want to choose XuanTIe (T-Head) ERRETA.
> >=20
> > Not explained in commit msg but anyway not a good argument. It is some
> > sort of micro optimization and you completely miss the point we target
> > multiarch kernels.
>=20
> Heh, and I actually did not forbid or discourage choosing erratas per
> your soc. I said you only get one top level ARCH. Look at all arm64
> platforms. How many ARCHs are there per one vendor?


Yeah, it only allows you to enable the errata, it doesn't force any of
them to "y". Some will get enabled by default when ARCH_SUNXI is
enabled, but if someone is only targeting on device they can just turn
them off... I'm pretty inclined to just NAK this unless there's some
actual value.

--zDi7HsMP+xaYfO8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ9ukwAKCRB4tDGHoIJi
0qJsAP9PB5Qfwou9FktzjX1XPDGtvQx5CGiUMGnYmlQQvt7gAwD/YQjrczBDtE6G
yftMBPxa/2JWp4I00u3RUCiy5yPmrwc=
=Vu6g
-----END PGP SIGNATURE-----

--zDi7HsMP+xaYfO8R--

