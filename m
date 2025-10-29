Return-Path: <linux-kernel+bounces-876931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42416C1CCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936DD3AF297
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC43563EA;
	Wed, 29 Oct 2025 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+88yV9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBA2FC890;
	Wed, 29 Oct 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763050; cv=none; b=Wor0hrdLNYam5F7an3w9xL/dagHxEiwY5QWOIl+61DfcvLAHIIFtkh9YPx/6bL6VWj6zaVdFmCPK1zRD+FIxibRfvcTfWj6cZhsUDF0Zw5j3avCyag3WWsD903UQ/L6Q3pTkV3LNC9Qv91LDqI+aLL/KxbwyVkRP7v+dRKH3UD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763050; c=relaxed/simple;
	bh=Ifer44vEweS4PL5N0mQfsd+VeAJ8jyfsQuR4jzwh3MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biR+4M7IKJG4iCwht3h3Qi7FuDEf6DH1Kc23XHC8oQpv/2emqWb/+AljVyDTgwyJ00qWkClsHlt98UYCht89W1ky1m5ODgBSF+irc93UhmY68BR4vpmh5hvscBKfrHWLqZRMobiQnnrSjhZNPCOg5alijNH7xyy14jcpY5Al3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+88yV9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F92C4CEF7;
	Wed, 29 Oct 2025 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761763050;
	bh=Ifer44vEweS4PL5N0mQfsd+VeAJ8jyfsQuR4jzwh3MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+88yV9ZNhK3bIYITLyD6Y/eVTjI61zFxp+V4XoiNMVjeUzwfsVwDreZSBW3yKKB1
	 npjDJTs/eafWSyXfPPjSCYBYstgCvCyM+BNKihpzfh+0qyTdejeVAOViTvvjpv5Goj
	 ffmQY5gv7ygpY4iIofgB6+EEqtdXboMy0B3l3pMfp/NQKx8D9lzOPl81TuQiFqAy3R
	 WEl4So3vvc3pYN1LD0ZFGSQYJAphNd5aXzxNYOpUKCBW6HOeW+25iFwMyRGYinoJcH
	 9IpYOoyKWXlp6vY3uhGBMyD4f/1cxtyLyLJh0MNHd/tzedYfcJSjgdc04ULgk/8wVT
	 ZBA9HVg6eVJLQ==
Date: Wed, 29 Oct 2025 18:37:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <20251029-embroider-plunging-6356f50c7acd@spud>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
 <20251029-ambiance-snooper-43dc00dcee68@spud>
 <aQJR36s0cY34cLrr@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gc7qHFPbCPZADdtV"
Content-Disposition: inline
In-Reply-To: <aQJR36s0cY34cLrr@stanley.mountain>


--Gc7qHFPbCPZADdtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 08:41:51PM +0300, Dan Carpenter wrote:
> On Wed, Oct 29, 2025 at 05:33:48PM +0000, Conor Dooley wrote:
> > On Wed, Oct 29, 2025 at 08:27:05PM +0300, Dan Carpenter wrote:
> > > Generally, syscons are created automatically and accessed direclty via
> > > MMIO however sometimes syscons might only be accessible from the secu=
re
> > > partition or through SCMI etc.  Introduce the no-auto-mmio property to
> > > tell the operating system that the syscon needs to be handled manuall=
y.
> >=20
> > "System controller node represents a register region containing a set
> > of miscellaneous registers."
> >=20
> > If this isn't actually a register region, but is instead an interface
> > provided by SCMI or whatever "secure partition" is (optee?), why is the
> > syscon compatible being used for the device in the first place?
>=20
> In the case that I'm looking at, it really is a syscon.  So right now
> we're upstreaming it and it's an MMIO syscon.  Very straight forward.
> But later, I guess, they want to have a new firmware which will only let
> you access the same registers through SCMI.

When the programming model changes, the compatible should too, no?


--Gc7qHFPbCPZADdtV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJe5gAKCRB4tDGHoIJi
0ugrAQDMcJZJB6TPfRd7u4o07QXulqfEXEZJdAdX2gzLdqowqwD/eG8u2wnnvtzC
lpdwvtl9ZiCaPQcc01ruIc/jaVTU9gs=
=v+ri
-----END PGP SIGNATURE-----

--Gc7qHFPbCPZADdtV--

