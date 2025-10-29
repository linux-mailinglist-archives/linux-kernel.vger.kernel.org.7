Return-Path: <linux-kernel+bounces-876818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1226C1C6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A4AA4E2C63
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A4F34EEEC;
	Wed, 29 Oct 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaCvJ3fi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED834DB44;
	Wed, 29 Oct 2025 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758700; cv=none; b=fO+OKncC6SdJiKIQEB450bh3rlsTNkORTzoQ3CDZtzwo/eRPNLsKw3HWSniuVv3ApwQok8fWXt6BrL1996SosApH6BE/qy5ExliYbMdfLMclOWQgIBmUx1tTtiofYFYV4xS3Uor7P7P3hWJoYH4mjvmJWqNY7Wera6Vbxym9BPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758700; c=relaxed/simple;
	bh=Y9eg+bqtuiBvhj27qPsEMgI3sW1YPbmbNenD0mtafaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvaDjIitzZ3T00JIxbypcLbByQ0W2VVPRzPktVc5/k3HIlvHp9oke8YcHlM/Ex0B3mUzzd53GT12QfWIr0xBdRW1qc6rmasnCFD165suUDl4ejAm4jjGrxchx8d82WxrkvuXYdqNB7AQUvaN3nML7O427RGEKjYhBNpvlEnLhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaCvJ3fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560EFC4CEF7;
	Wed, 29 Oct 2025 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761758699;
	bh=Y9eg+bqtuiBvhj27qPsEMgI3sW1YPbmbNenD0mtafaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaCvJ3fiHxDt543+sjeDB8LsZ82ttPD7FQK0tI8+cvxbDcPE7liNpVCjbI6Bd3T5Y
	 x+w4+dvepmDJXwiWd50kB95RLAM9dQRLbW3k60fPkivDBZVeYqxun0qWyark9akkKn
	 MhL7NBjfLVhfH1d0eQY9xoeY68/dNDYU95kQuI9PURJVhVHno8mZ4PSGbBHoyAz4b6
	 wQ3yxMXqOcUO/G7tU740cLgruD5pAF4FAaN+v+nqe/9gO7LDQaXab1TKVs8NJWeAZx
	 qb3CCXhg5Fm7q365p30Cx5ETU4bXovasTXW64WcHN4Y0X5sqnBhh15ZCxj3k5vVek3
	 vSWVve+SE470Q==
Date: Wed, 29 Oct 2025 17:24:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Message-ID: <20251029-reseller-unsavory-5461fe7f6cce@spud>
References: <20251028-semicolon-audacity-dd5bdd418207@spud>
 <CALj3r0hWzH+pmkbJe7DdqEzwqcpSQdkfPFtv3S7m-H8gZp0A6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqqsbG4ObdDSRjQO"
Content-Disposition: inline
In-Reply-To: <CALj3r0hWzH+pmkbJe7DdqEzwqcpSQdkfPFtv3S7m-H8gZp0A6w@mail.gmail.com>


--bqqsbG4ObdDSRjQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 01:04:32PM -0700, Coia Prant wrote:
> There won't be any problems at the moment.

Please stop top posting.

> Just out of habit (because when writing code, variable names cannot
> begin with a number)
> There may be some misimplemented parsers that cannot do this.
>=20
> As a practical matter, the branch of openwrt has added support for
> this board in advance, and openwrt uses the DTS name to initialize
> some default settings such as LEDs and bridge

That sounds like a problem with the WRT development process. This is a
trivial change, there could be more disruptive things required to
satisfy reviewers. Why was it submitted there in advance anyway?

> I'm not sure if he will affect the version that has been released.
> But maybe it's not a big problem.
>=20
> If you feel that there is no problem, I can send a new set of patches
> to fix this problem.

Please do.

> 2025-10-28 19:46 (GMT+00:00), Conor Dooley <conor@kernel.org> said:
> > On Tue, Oct 28, 2025 at 12:38:10PM -0700, Coia Prant wrote:
> > At first, it was to avoid problems with the beginning of numbers.
> > What problems does starting with a number produce?
> > Given that it is already used by downstream projects, we have retained
> > this to ensure that users can seamlessly migrate to the mainline
> > version.
> > What's the actual impact of changing it from "nine" to "9" for
> > downstream users? This is a board vendor, probably nothing is even
> > interacting with the board-level compatible at all programmatically?
> > Please don't top post.
> > Thanks.
> >
> > 2025-10-28 19:35 (GMT+00:00), Conor Dooley  said:
> > On Sun, Oct 26, 2025 at 10:36:44PM +0800, Coia Prant wrote:
> > Add NineTripod to the vendor prefixes.
> >
> > Signed-off-by: Coia Prant
> > ---
> > Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index f1d188200..37687737e 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1124,6 +1124,8 @@ patternProperties:
> > description: National Instruments
> > "^nicera,.*":
> > description: Nippon Ceramic Co., Ltd.
> > +  "^ninetripod,.*":
> > Why ninetripod instead of 9tripod? That's what the company uses and in
> > the marketing fluff for the boards.
> > +    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
> > "^nintendo,.*":
> > description: Nintendo
> > "^nlt,.*":
> > --
> > 2.47.3
> >

--bqqsbG4ObdDSRjQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJN5gAKCRB4tDGHoIJi
0jDdAPoClQkD6kyF0W8zdSBg6g+HBjeLj8bAkhQPXRv5HmS7DAD7B0sWK1QT34S4
iTErDKBUfPq7GGimNUNj0cY2Mjo7tgI=
=2YvP
-----END PGP SIGNATURE-----

--bqqsbG4ObdDSRjQO--

