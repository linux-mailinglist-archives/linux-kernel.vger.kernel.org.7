Return-Path: <linux-kernel+bounces-804175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0516B46BA8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A271B28208
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB482857DE;
	Sat,  6 Sep 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="mi5XoFBz"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1C21858D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158857; cv=none; b=lTK//LTpExUoMs9XsmJOFaxNk9Q2EkZMQhZWjrQvfivEC8MCWG6vRNJxS7hXv8b/mcJeNLUji1jhDLjfzjIQ6DJjDIzQAULkN986TeB07kTCkt2PcmaSb5kGO8MMjoPpldyTOEtTVI2/lHPBAoLne3e9eqPlFGlEmxlu5HwUbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158857; c=relaxed/simple;
	bh=31fVbApUC9vGO4OiH80yqzHQyob7vjR1QebOVx69tjk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LD1NVz1CTUb8HmVbb8f0XDgyoQOZURF42jipfpK4okFwpKSrPBbjsr9qoKhRQYUTLQYbxycwdf6xjlm4yL6a11aHYH90RW4rBu92FygtX/fp/eUN6c+B4NpkhMxBwfVpGdC0nJu+KB1wgajQWfro1zZ9YLA7GNKb4/resbsRpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=mi5XoFBz; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1757158853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfQBX96q75WukPmdamWvcC99q02KYHkltaQomzZiIA0=;
	b=mi5XoFBzicBGnLVlSDcOo95Ouwxq3hQXvFEG/N59/ZuVymYMt3CqV4k89TDrxD7B9u22Sz
	qhkzNWunTvNWqXkQjvdkE+TVv9mjX0pdXArzBVZjL1zuVE4RSthFUKOgmaGe3ILG96npde
	GV2mwYZBhCbzQ0tb90WY9z9Sbc4pBgrU4+Fv9SpcB2w4ujXPKdH0JnAzQxPVpZSm3vuBvO
	p8tTXQ9suDUkspEgJ9GSSv1ZTRc7reyBBWsjzc19+DXGtk2foDoWJ/A0kA0TuFIzsiUiKy
	yqlLwgWgziTPIDeb+5eVEmaWzZmj7VVAgcfc4zSKXLOBnyaBLy3e+PS1TRc80A==
Content-Type: multipart/signed;
 boundary=50bc71c862d7f174e8c42d86cf14d62df090490c913e2b0c228b0aaba3a8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 06 Sep 2025 13:40:48 +0200
Message-Id: <DCLOTR9Y380M.22GZYL11XXZM2@cknow.org>
Cc: <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Make RK3588 GPU OPP table naming
 uniform
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
References: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
In-Reply-To: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--50bc71c862d7f174e8c42d86cf14d62df090490c913e2b0c228b0aaba3a8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat Sep 6, 2025 at 12:01 PM CEST, Dragan Simic wrote:
> Unify the naming of the existing GPU OPP table nodes found in the RK3588
> and RK3588J SoC dtsi files with the other SoC's GPU OPP nodes, following
> the more "modern" node naming scheme.

Like we discussed in private (without an agreement), I think it would be
beneficial if the (gpu) opp naming would be made consistent across SoC
series as right now there are several different naming schemes applied.
They're all valid, but inconsistent. And if consistency is improved,
which I like, then let's go 'all the way'?

Cheers,
  Diederik

> Fixes: a7b2070505a2 ("arm64: dts: rockchip: Split GPU OPPs of RK3588 and =
RK3588j")
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3588j.dtsi    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3588-opp.dtsi
> index 0f1a77697351..b5d630d2c879 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
> @@ -115,7 +115,7 @@ opp-2400000000 {
>  		};
>  	};
> =20
> -	gpu_opp_table: opp-table {
> +	gpu_opp_table: opp-table-gpu {
>  		compatible =3D "operating-points-v2";
> =20
>  		opp-300000000 {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3588j.dtsi
> index 9884a5df47df..e1e0e3fc0ca7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> @@ -66,7 +66,7 @@ opp-1608000000 {
>  		};
>  	};
> =20
> -	gpu_opp_table: opp-table {
> +	gpu_opp_table: opp-table-gpu {
>  		compatible =3D "operating-points-v2";
> =20
>  		opp-300000000 {
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--50bc71c862d7f174e8c42d86cf14d62df090490c913e2b0c228b0aaba3a8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaLwdxQAKCRDXblvOeH7b
bl8uAQCv2yOKmsclZY8nGsdJiOVLqZigZRQbZaQzwRqAc/HnAgD/XLnZRoy4wD3U
MNxjXlh/Uf2Ygv/VZJ0ev9xXDbI2aQo=
=ThN1
-----END PGP SIGNATURE-----

--50bc71c862d7f174e8c42d86cf14d62df090490c913e2b0c228b0aaba3a8--

