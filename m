Return-Path: <linux-kernel+bounces-867160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D340C01BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DF665087F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E932A3F2;
	Thu, 23 Oct 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NifcWW7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97925A334;
	Thu, 23 Oct 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229129; cv=none; b=WimOZQcoquDcH34y5J5YGY2LpjgkJMxLT77QQKHVD7nrNHdLyD008LkdFMWaep9aPMPgDV+Z7sSQ9dq6xCG0V5D4w3w7CHYzotbJF4qVzH/SSpNes5yCdmC3uyoUZEvoiow33VK6yN6djpscLRiMAv8YSpS925HLrnQ0+ntAwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229129; c=relaxed/simple;
	bh=bJxweCGYFicDN8XJJqtvmSXX/oE1+rQFvpKIjeLyq2c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=WebLg+Ev/c8maGakjADgrGD9FDf/aPTkHXdGIxzn+7bjndE9iqqemAiRJMuNIRfDmpvIHjNPMkXrnJHr9HYpop60sD2N56laSQr7tceUK2oI2BWo/7yUZXvShncdymIQEk9EN2TRgvhDeVHDFyUuSG1NjnTvrpS1mXHdmmHxy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NifcWW7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B047C4CEF7;
	Thu, 23 Oct 2025 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229128;
	bh=bJxweCGYFicDN8XJJqtvmSXX/oE1+rQFvpKIjeLyq2c=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=NifcWW7Qh2v4x/kLGCIpFeNvdnkhS+V9q2j8GvTnzHLKheB40XnFQmGWdNho73/oI
	 oaJu22dbrmDgSIwevJzCLSqUwTJlficK7YpgG6zOcTuE3UMJG9nCfNDpDVevl4rsGO
	 Abo1bSlW+gOYqhrhaqFeVoxWv6xCINmpFr/HO4czKmfsKVX7CXn1FUdm3M7iU4GIev
	 syBdcO9lnUKTixM2TBbO2iwDDxxu1ZNjUxr/sBYdAde34GBq8/MfUoCvbSDOObSmT1
	 MOTxnb4m8zDVFWKEqQDZsTRdL2FMr/wjR+RzeIaX8ff43/gw9N4VmmySy5qKubK2ls
	 a6CpqR45AxyJg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b31e57130b0d78ca537571d43b9c56e4965516d92bed9fa6dfb1c4bc1f0c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 23 Oct 2025 16:18:43 +0200
Message-Id: <DDPRM9UCVZNA.HFRGLJW17PIP@kernel.org>
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-j722s-main: fix the audio
 refclk source
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251017102228.530517-1-mwalle@kernel.org>
 <20251017102228.530517-2-mwalle@kernel.org>
 <554df7d2-1809-42a8-b512-bde3fd284163@ti.com>
In-Reply-To: <554df7d2-1809-42a8-b512-bde3fd284163@ti.com>

--b31e57130b0d78ca537571d43b9c56e4965516d92bed9fa6dfb1c4bc1f0c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 23, 2025 at 3:50 PM CEST, Udit Kumar wrote:
> Hi=C2=A0Michael,
>
> On 10/17/2025 3:52 PM, Michael Walle wrote:
>> At the moment the clock parent of the audio extclk output is PLL1_HSDIV6
>> of the main domain. This very clock output is also used among various IP
>> cores, for example for the USB1 LPM clock. The audio extclock being an
>> external clock output with a variable frequency, it is likely that a
>> user of this clock will try to set it's frequency to a different value,
>> i.e. an audio codec. Because that clock output is used also for other IP
>> cores, bad things will happen.
>>
>> Instead of using PLL1_HSDIV6 use the PLL2_HSDIV8 as a sane default, as
>> this output is exclusively used among other audio peripherals.
>
>
> Thanks for this fix,
>
> Initial support for audio_refclkx was added in j722s and am62p soc=20
> specific files due
>
> to selection of different parent.
>
> Since these SOC share many common things, and this patch will make these=
=20
> nodes same as of am62p device
>
> https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/boot/dts/ti/=
k3-am62p-main.dtsi#L46=20
>
>
> So I suggest to move in common file=20
> https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/boot/dts/ti/=
k3-am62p-j722s-common-main.dtsi#L42=20
>
>
> and remove from SOC specific files.

Ok, but to keep the information and to not conflate two different
things, I'd do the following:
 - keep this patch as is
 - add a second one, to move the (now) identical nodes into the
   common-main.dtsi

Sounds good?

-michael

--b31e57130b0d78ca537571d43b9c56e4965516d92bed9fa6dfb1c4bc1f0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaPo5RBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gCUAGA9Tu3/0BHusm+p7jGMd54B3ImM/u3QJ3r
ZSwBtJZ52mr5+mzokC5OWhhScA4ykLUnAX4i/3RhUGrEc8x3Ozddhl10LCJ5y/5g
p3uM4fOAngaRMIRZc0UFjEcoGpv/Z3wSh9M=
=zxEV
-----END PGP SIGNATURE-----

--b31e57130b0d78ca537571d43b9c56e4965516d92bed9fa6dfb1c4bc1f0c--

