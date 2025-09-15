Return-Path: <linux-kernel+bounces-817536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33599B5835F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16B13BE6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70652EF665;
	Mon, 15 Sep 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgIfl12k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B42E8E1C;
	Mon, 15 Sep 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956736; cv=none; b=Am45rwXArP5lXeOWeYHq6xgrVqtfPU1KhCTJNkWUJtHlOFRGdrjh4DTcQMVA4lxGIrR7XY7zjRadevt15wTaHtKgPBD7/BmZCpH5MIpbJ6M29QQ3Spc0x0axQG4eYuNTd/XXouMzfbRdILKVRQSZ2K+KFGn7Jw048wRW0cMEpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956736; c=relaxed/simple;
	bh=gSJY1FWYfr+n+3wRKmlvxIfxbwGgSPGmGTC0SKRRAZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0lBwAPHaxCyJxaDrhIQYGVc77xHgofH36Vsf9qUI+udM+KJ0+KVZeKPHnHwkl9o8jPK3XKXCfwuWiAkNs/0k/Ml8hDJ9CZF1yvhelrrgyfevlXPimvFjXJDljPzlM406iUJD4dpdFaWWVVVcQD1iBsul6u3cOS31cjOQF407CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgIfl12k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE115C4CEFC;
	Mon, 15 Sep 2025 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956735;
	bh=gSJY1FWYfr+n+3wRKmlvxIfxbwGgSPGmGTC0SKRRAZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgIfl12kR7C2hIsA/MteF3VIgtA2K7tAmb1CTNo6gOHCKNvwNxCrnJkiLGn76koNd
	 1VCFrT6TBdbPSluVQ6S3N5RmByJhOl4mSflk6Vfw7w1hybmpyNBI4o3fJJxee7vpM9
	 9axawq16LDzxBg9KGSVQqwZzbO4swAZz2B7ot6m+4wD4U1ob0Ss4qnxrd9eQcjWxla
	 rfszSbq6dHwmrIb9m39A4CrJcrJUMrQ3lWDPb0V3Sl1vCg4oXH+wy+vJBPJ77uwoM8
	 LrNRkszOUXGB6lQrlrQ0yQsUmz1yEeLhkODJvADa33/faBCDI7RkWH1QvYaTKAOfxf
	 RX4bPls6cucng==
Date: Mon, 15 Sep 2025 18:18:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113
 devices
Message-ID: <20250915-undefined-woozy-15e27ca89a36@spud>
References: <20250915170819.126668-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lfv4wKgWuiyb2Y3"
Content-Disposition: inline
In-Reply-To: <20250915170819.126668-1-flaviu.nistor@gmail.com>


--4lfv4wKgWuiyb2Y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 08:08:18PM +0300, Flaviu Nistor wrote:
> Add a compatible string for TMP110 and TMP113 devices.
>=20
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> index 96b2e4969f78..840b5306a8cf 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> @@ -13,6 +13,8 @@ properties:
>    compatible:
>      enum:
>        - ti,tmp102
> +      - ti,tmp110
> +      - ti,tmp113

The driver has no match data and no compatible based decisions added in
your patch. Why is a fallback to tmp102 not suitable?

> =20
>    interrupts:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--4lfv4wKgWuiyb2Y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhKewAKCRB4tDGHoIJi
0u32APoDoF/gGJ2EOqe9o5dYb7Ni4+mN6txngX/8KwA2O0n85AD/SmBMZr8Ws419
uouv+W++ZyPLUVQ4cnmTc379sYKt3wU=
=/+Lo
-----END PGP SIGNATURE-----

--4lfv4wKgWuiyb2Y3--

