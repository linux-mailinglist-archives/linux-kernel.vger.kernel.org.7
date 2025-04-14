Return-Path: <linux-kernel+bounces-602165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B87A8779C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 07:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A833AD5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 05:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81C1A3146;
	Mon, 14 Apr 2025 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPqEGceB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6E25776;
	Mon, 14 Apr 2025 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610291; cv=none; b=fGBm1BpRZWCfhjZMwYBGELp5HxPRQ+niqqop0pquMNLWsLNylllWPqlgtn6budpSulGj7H/8xZIKP5chZpXYLeOIlWHZazKgec6Rtl7r26PtCNBYdiiTudp1WWMjscHTuAljrab0KesuXgBPDJPR3+9Gx56uxsW6JpPiIi0SCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610291; c=relaxed/simple;
	bh=dSAe/V3pdbTWgzxSG+hkc2cBmCm2XsfRx7mmsO8TE6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYZLxplnMdD5TkmLTV+4Cw7Sup6bWlW+0mf+gqfMquWOEDgqKwoQSMiSMVWodMbQWgm5pYtkxY1u8O5J2ytuz1sLc1yQPzbuk92yVSaG6PTSE4eVMWsCctygUP0/i0V7ou1eGizmB+ACDfgCqOWAXgx4As/85fP6bh41wcEomw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPqEGceB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F422C4CEE2;
	Mon, 14 Apr 2025 05:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744610290;
	bh=dSAe/V3pdbTWgzxSG+hkc2cBmCm2XsfRx7mmsO8TE6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPqEGceBXKFqy/A7O9EyIcKSWNTbQsWN4o2hrpcITT2XCA9S4n+1BveHX4p/dCbaI
	 eJY93y8SV3KV4+xcI6I+Anrh+zvTW86amac4rqnlAEe9J07+r4izKcCxBXlBMrwjNn
	 C+X9wIo8anw973b8fX14L/rt2FhfCkwRI/hilH+h1Qm/Ax65JeokC5pcHi3OpCKkxh
	 TcUXGt88etZEKhZWZslNIU5w+aWSrYgZd9Cfl1FfiuH5uEpbKD2gNM7DMg+JnQT4/V
	 08DrGR3b7gAn6MVEI2hsynjHFuPQCsz2NydY1HX2nPp2gqJZO+q+CanDooA7yjHca5
	 0kIGCKDLkTDbQ==
Date: Mon, 14 Apr 2025 07:58:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
Message-ID: <5lfnxricxm2k3fuf6nfvjd6cbkmsjkx7inoi52uy5uwwvld7sq@abn4i62tdics>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-8-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5dhgaf5vtkosusu"
Content-Disposition: inline
In-Reply-To: <20250411131423.3802611-8-guodong@riscstar.com>


--i5dhgaf5vtkosusu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
MIME-Version: 1.0

Hello,

On Fri, Apr 11, 2025 at 09:14:21PM +0800, Guodong Xu wrote:
> +&pwm14 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm14_1_cfg>;
> +	status = "disabled";
> +};

I wonder if the pinctrl properties can better be added to the SoC's
.dtsi file. (Only applies if this is a canonical choice, i.e. there is
no other possible output configuration.)

Best regards
Uwe

--i5dhgaf5vtkosusu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf8o+wACgkQj4D7WH0S
/k54NQf/XNpxz5lJlk/TwLJlajf1AX025zknqO/ixUHqueqlXnbKK/OibTGeNoaX
krZaG9anMBPV6mgaiMCs44DAwcY/w8Tpb+EDikpzpPHY1+HYGNoMyKSM8z5Sjv8F
WJHeqiOm7woGJeixt4iLU5YhDq1eBclttJdOR6/790y0cHzrNoEJiBDzFbge4QtN
tjLEzOZjhVLTTqVXswOKi2fGa3AslElnxL+wnDQip9Utu/dXXU4ZKCeLwhx1b3pb
n3mVy5/h4R0WtG+7Xn4/HNgpPyQn6elS3aezcgupymNZaUzmlpg9SmRoxrHr0RHW
To/FljppSG7iMKjjiCnwjB20ZTuaww==
=9urF
-----END PGP SIGNATURE-----

--i5dhgaf5vtkosusu--

