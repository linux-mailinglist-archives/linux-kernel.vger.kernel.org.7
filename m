Return-Path: <linux-kernel+bounces-780427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0888B301C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41660AC6498
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402F6343D66;
	Thu, 21 Aug 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrbldMhW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF24C6E;
	Thu, 21 Aug 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799952; cv=none; b=fHOVzr0Z9SbOIGbZk4CCLp275XYscnkgqOEjtcSsIg6Vl8DHiTooB3NCZgQsOKEs8XF7GiUJS3MigTTDM8+9toA+GrkBHEZlQO55ZI5Y6l4prHFEb3uIsMgRXjHkbL2QTILm4wxpqRykIkKpxq/MPISvtXEuj+eSYGSciGm/Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799952; c=relaxed/simple;
	bh=tyZZ+il8BMFYTQkAPqh2zWtcW1YYUU3DlFkhMHgu0cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoCgktHonw5HRkpfIoUalbMcpz74iRUtkqmDxTW08U2xKxU6nevkZRqNnPUqgZYMAlwud64MrbSpp55Wjx6RPH6IzNTCXSIzVq5esNMrG/EuSta139IqMVVmJWyDbcaQaHhCTOlHDHzK991uq/ivbZhtFifgmJoXgcXmT6/tg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrbldMhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B2DC4CEEB;
	Thu, 21 Aug 2025 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799952;
	bh=tyZZ+il8BMFYTQkAPqh2zWtcW1YYUU3DlFkhMHgu0cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrbldMhWX5CiMxOc8iQ+3bFUFDSo2J7QvQoVDX5+d2TS/S4+JogfQay5R7re4KtMX
	 4raE5FpjqgERfbc5DUol18xjsccrX+F4mjJvwJcPcFYo9wLbe25hV++timmdwvbtCc
	 xNCrh6GKumyWk8LSextmRdyKWgyNiFIxOWyKIt5XeyAipeIIzsqAXdcIS77zfYBvrX
	 sLQcrvKhsbtwrvaDl7AQbGn2s+DTlReSPgE9h5S5O6pCNuz4GEruNpq8wmrhoASfUI
	 5lDe9xaOMaCMZcr38WASAKZ83RIBIONE1ppqPBE2OA6tZ+rGoMOvbxfTmU+5KnrJ/i
	 YzWMANvgvwPcg==
Date: Thu, 21 Aug 2025 19:12:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add NVIDIA VR144NVL board
Message-ID: <20250821-baffling-immersion-e86971edb6e0@spud>
References: <20250821051047.3638978-1-donalds@nvidia.com>
 <20250821051047.3638978-3-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I8HKQZSFF8kf2/3M"
Content-Disposition: inline
In-Reply-To: <20250821051047.3638978-3-donalds@nvidia.com>


--I8HKQZSFF8kf2/3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2025 at 10:10:47PM -0700, Donald Shannon wrote:
> +// I2C2
> +// Baseboard 0 Management 1
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		i2c-mux-idle-disconnect;
> +		vdd-supply = <&reg_3v3_stby>;
> +
> +		c0uphy0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		reg = <0>;

Incorrect indent.

> +		};
> +
> +		c0uphy2: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		c0unused2: i2c@2 {

If these are unused, why are they here?

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		c0unused3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +
> +		c0unused4: i2c@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +		};
> +
> +		c0unused5: i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +		};
> +
> +		c0unused6: i2c@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +		};
> +
> +		c0unused7: i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
> +	};

--I8HKQZSFF8kf2/3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdhiwAKCRB4tDGHoIJi
0m2xAP4wGIl/Es2Bp6NAxJ+HV4Tf8VzTJK8IeGd3GjtpjTwM/gD/QRt1hUb5Xf9D
jc00evZQh79KWiMdlVcfo/aTExP+xws=
=y2Po
-----END PGP SIGNATURE-----

--I8HKQZSFF8kf2/3M--

