Return-Path: <linux-kernel+bounces-893343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B2C471EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED43189383A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0C3128D6;
	Mon, 10 Nov 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="12U+tPHJ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C6238C3B;
	Mon, 10 Nov 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784112; cv=none; b=N2IiqbLEeyoBVTODYFP1g021W4r6/HLmPx2bs47Lf9F9Q7ZN4f+R1l3uUT1n7ePWtYYWb0K1pxuiyWHwIcop9Bp7sllbP5PaediTv39L2wx+10XJYw/VOjG+zpfYVkoVuLcQm57lwzJkb2wTKyEAu4SHfS3jXl3whr2XD/f1epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784112; c=relaxed/simple;
	bh=lCUcxcMpT5U7cRzym3W6q8PWmYJA+8R051GDyQCfm9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jO2ND8siKfi6fzZ4ehHRF9Oia/CYI2d7kLBYMh+lL901zAWd9kQL1lOaX7krObbCFsLXGCMpkSAbRcJIvbyvXt4uUi/gKeLPMqiOqJWX66k57qT/8C0aAEibGqpsESad/Bnufs0p02A6zjXo1VAUDX/zf53OeWv90FUSuswXpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=12U+tPHJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7613B4E41608;
	Mon, 10 Nov 2025 14:15:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CF98606F5;
	Mon, 10 Nov 2025 14:15:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE0C7103718E3;
	Mon, 10 Nov 2025 15:15:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762784106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r0RTs0mLiJP0YQJOpjwgxtc67UqnKyOdkCbLOvFlNsA=;
	b=12U+tPHJOwgSLsSFcsdUd0sMClp8mXzd6YcFS4JdNX3QesCpTtjGA03ZAvPtDPQOgo3sFK
	3MUKa5P/j8g0WG4cuGamytrO40gDSMlT3at4Hhof7kMgd5LvPTTBh1foHQiTOa0pCh+M7P
	z0qfUHul3B9v/7LoaxFn1p+iSs8tDqPJU5xAY5qa1DApfp82VAPmLSlLRDS6SRkazF53T4
	1zCKsRdr7ttupzVzAPJdSX4qqvHqnvpg3YqSNAqG9O+oAkl3BVWInxJwlwoV0KG8Yf4otZ
	V8Q9LODADlr0VPYpYRkOY18K+zc9KDXUPAKIyoQjgJv15otqp/AS/F9HRLp92A==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/arm: dts: marvell: Rename "nand-rb" pinctrl node
 names
In-Reply-To: <20251029153927.1065446-1-robh@kernel.org>
References: <20251029153927.1065446-1-robh@kernel.org>
Date: Mon, 10 Nov 2025 15:15:04 +0100
Message-ID: <87seemrn2v.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

"Rob Herring (Arm)" <robh@kernel.org> writes:

> Update the "nand-rb" pinctrl child node names to use the defined "-pins"
> suffix fixing DT schema warnings.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>


Applied on mvebu/dt64

Thanks,

Gregory


> ---
>  arch/arm/boot/dts/marvell/armada-38x.dtsi         | 2 +-
>  arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi | 2 +-
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi      | 2 +-
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi      | 2 +-
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/marvell/armada-38x.dtsi b/arch/arm/boot/dt=
s/marvell/armada-38x.dtsi
> index 1181b13deabc..1d616edda322 100644
> --- a/arch/arm/boot/dts/marvell/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/marvell/armada-38x.dtsi
> @@ -247,7 +247,7 @@ nand_pins: nand-pins {
>  					marvell,function =3D "dev";
>  				};
>=20=20
> -				nand_rb: nand-rb {
> +				nand_rb: nand-rb-pins {
>  					marvell,pins =3D "mpp41";
>  					marvell,function =3D "nand";
>  				};
> diff --git a/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi b/arch/arm=
/boot/dts/marvell/armada-xp-98dx3236.dtsi
> index 7a7e2066c498..a9a71326aafc 100644
> --- a/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/marvell/armada-xp-98dx3236.dtsi
> @@ -322,7 +322,7 @@ nand_pins: nand-pins {
>  		marvell,function =3D "dev";
>  	};
>=20=20
> -	nand_rb: nand-rb {
> +	nand_rb: nand-rb-pins {
>  		marvell,pins =3D "mpp19";
>  		marvell,function =3D "nand";
>  	};
> diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-70x0.dtsi
> index 293403a1a333..df939426d258 100644
> --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> @@ -56,7 +56,7 @@ nand_pins: nand-pins {
>  			marvell,function =3D "dev";
>  		};
>=20=20
> -		nand_rb: nand-rb {
> +		nand_rb: nand-rb-pins {
>  			marvell,pins =3D "mpp13";
>  			marvell,function =3D "nf";
>  		};
> diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-80x0.dtsi
> index ee67c70bf02e..fb361d657a77 100644
> --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> @@ -89,7 +89,7 @@ nand_pins: nand-pins {
>  			marvell,function =3D "dev";
>  		};
>=20=20
> -		nand_rb: nand-rb {
> +		nand_rb: nand-rb-pins {
>  			marvell,pins =3D "mpp13", "mpp12";
>  			marvell,function =3D "nf";
>  		};
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot=
/dts/marvell/cn9130-db.dtsi
> index 50e9e0724828..3cc320f569ad 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> @@ -379,7 +379,7 @@ nand_pins: nand-pins {
>  				       "mpp27";
>  			marvell,function =3D "dev";
>  		};
> -		nand_rb: nand-rb {
> +		nand_rb: nand-rb-pins {
>  			marvell,pins =3D "mpp13";
>  			marvell,function =3D "nf";
>  		};
> --=20
> 2.51.0
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

