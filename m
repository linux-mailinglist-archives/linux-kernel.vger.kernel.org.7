Return-Path: <linux-kernel+bounces-832689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67C2BA01B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E8384669
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74322E3B18;
	Thu, 25 Sep 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjNhqR/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F82E6116;
	Thu, 25 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812575; cv=none; b=i8B2ki/I+bwQLyZ7hWjwUB+G1DwIx3ZKOH26dGxhr8WeV/uRZRb5FY2wmgI9kBCiIrUml8MMMQ7e+OEjFX+wmv5rk0fMKN/vfsiDF3AaCoWKyKRs6jsLmThG7HPvSPA23nXBQp8WzGShM7jhzlhD5IRFyR3cPr82p3vfBX+IrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812575; c=relaxed/simple;
	bh=YxK95fh32bmvs3eUOHU609gQaq6SCA9IhpuHiYw2yMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCyg1HpQG2cgY/jSi/zqI+a5rTNtnb+s8mGSKoD9UZoQzBXExkbGUq1DA9YZhslPziMI8kL4p9up7kqON+5Fnl+0D9IE1UV/gBI7LEG6MWmVdIT+YATSLBdG8WM11Z65ahlrUY7b+WMz4Eq7YcpNwniLKv+b/LE2Nu4a9lWNuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjNhqR/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E1EC4CEF0;
	Thu, 25 Sep 2025 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758812574;
	bh=YxK95fh32bmvs3eUOHU609gQaq6SCA9IhpuHiYw2yMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjNhqR/zzn/S/ZVhwIN9MDllGlsfDj31D8pywRVM2dLJ61TbNhYV0Ipp/47yT/K8V
	 +EeNMQrPGA3Y1YvS9pEwQlpqUKofGbRYdyQoFmohqW8CJPDRht+9bgY/qI8lr+JKhY
	 adWcnSdTmZTQe79STkhuY4T+z7c5Zz3in6VcCFYurRXeHhEzlnfTgmIvHuAhPDJTvh
	 +IfzoynuWUtduAiApEGquaiuMZgddUYcG2/nzqaxRTQv1zaH/DAse1uAYVB3CE1O+7
	 qQagTF/E2Z06COnpG6TE1OvVNdLbyjjiSx+tRAMAKiRqVTSm7xo3KXtn0VZe87unF8
	 /tCuV5J6O+HrQ==
Date: Thu, 25 Sep 2025 16:02:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Add
 polyphased property
Message-ID: <e1e31e6c-59e9-422c-af72-718fcb7051aa@sirena.org.uk>
References: <20250919000020.16969-1-andre.przywara@arm.com>
 <20250919000020.16969-2-andre.przywara@arm.com>
 <20250922181611.GA567602-robh@kernel.org>
 <CAGb2v64KvnvSy0-MYd7FBLVKeJQk=-=VWxRLsHXMP1+MFOPPfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jx2zlekHxWXeOT9r"
Content-Disposition: inline
In-Reply-To: <CAGb2v64KvnvSy0-MYd7FBLVKeJQk=-=VWxRLsHXMP1+MFOPPfg@mail.gmail.com>
X-Cookie: Shipping not included.


--Jx2zlekHxWXeOT9r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:52:45PM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 23, 2025 at 2:16=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> > On Fri, Sep 19, 2025 at 01:00:16AM +0100, Andre Przywara wrote:

> > > Add the "x-powers,polyphased" property to the binding, to describe th=
ose
> > > pairs or tuples of regulators that should work together. In the lead
> > > regulator node, the property lists the phandles of the connected
> > > regulators. Just an empty property means no poly-phasing.

> > Don't we have a coupled regulator binding already?

> That was my first thought as well.

That's something separate, that's two separate regulators that need to
be kept within a range of each other manually.

> Unlike separate regulators that are ganged together, in the AXP PMICs it
> seems that when buck outputs are ganged, only the controls for the first
> output have any actual effect. In such cases I don't know if we should
> just ignore / leave out the secondary outputs from both the description
> and the runtime state.

This is very common, I would expect any regulators that are ganged
together into a single regulator like this to simply not appear in the
DT.

--Jx2zlekHxWXeOT9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVWZgACgkQJNaLcl1U
h9DZDQf/YukKJO9QFk1kcg54NRNKNybvOqiTJfwZP4IhbmC5UEJESH1PbN7zcdH4
gmAKpJKDxrVMVLUfEUy1xOe8Kp+x1/ijJ4MHqZ8N5wnTba1KVnx+Ga+HP0lMwzh/
jGi/p8yAsZABxkpicJDMeo9tO7HcE54w3h9bahmHVqq/xLF9NbZhSIrkuak9WfgC
zbbwPBTxLbHA2WFdT6gE5BB/H2ZDs59gGEpc9t096dMZ1lA/s/EAie0xL22jWvjR
g/HvfTCXxLIq9Pmxf7nrUsaYadrmQPOl5OkLjKKlOpS9w0pt66SMvGl7NHu6ZMBK
+L4DakUqm1K0vlA6KvcmIl72yDcslg==
=lQZb
-----END PGP SIGNATURE-----

--Jx2zlekHxWXeOT9r--

