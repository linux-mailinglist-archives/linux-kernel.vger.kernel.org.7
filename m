Return-Path: <linux-kernel+bounces-870645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F356C0B58C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2857C1896622
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78F283FE5;
	Sun, 26 Oct 2025 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2zin1Z7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C7247287;
	Sun, 26 Oct 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517319; cv=none; b=lLvshaLzfU0NfcSH7/8L3zc+uu53aZWUO6QdeWXTgtDENaHHjdeErwrNapcWL9sjl6o85tPIVIu6mBGrJb/aohOz0BLbRAWh7oX2kYmKrons3pHKP7rL4/N5H0JTpZVTIxIQllalAGRCJ0wEEFHpzKFcclpCbYxuK5vhd6leJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517319; c=relaxed/simple;
	bh=shvt/H62MSL/X9zYi3wGfN1JdJm+2GxmIeTsccBYlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWdPlSzdm8JKJVyiRqSbQbu3RCek+DcENb7tETRSVokTONAFxlqPvZuyP9LezhhAohX5vmpTm0ddbFOnoF1D0pbaYx/Gw7jzh5TItdOms9p3sisw0TwWtcv+63V7qwPHVcpjyDWhbMFwjUWFkpRjtB0+pzl7Y05Vzg4CVIT1w38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2zin1Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE71BC4CEE7;
	Sun, 26 Oct 2025 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761517319;
	bh=shvt/H62MSL/X9zYi3wGfN1JdJm+2GxmIeTsccBYlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2zin1Z72la3TT+4nnVV6RnFFNATQhk8uw/M8t+PYAw7o+NSpYyuCpvRuMSRaWKXI
	 XYXbsqFUchbqhrAysO8wKh421BTh1cg4zH1cfn6rSf40wnT6bxwkD9IrC9vyAqnnbM
	 LfXHbx54mgn2dTt3DvKyqTFbpJfOe88eAw9ZSGg3tNkLNMlf7OqJALbtqWA3ZkdBpY
	 ORnbXGTC6W46Vwz6Smk4y3je5R3NAyzggsPT88+H4rGKxdvQLu0CxGRwN7VBzKiuZa
	 jiD03wbYxbRyRU4M3Wu8lE34yHP4FLGYU8lRy8QuJb0FA7YyQ7n4R73N+52+sew5UC
	 Oz549dNSfmSWg==
Date: Sun, 26 Oct 2025 22:21:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v10 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20251026-despise-treadmill-12636f1a476f@spud>
References: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
 <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>
 <20251024-think-handwoven-504634ca620d@spud>
 <aPvETBr5aebElQUS@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dhk4ruQsXIYcg54z"
Content-Disposition: inline
In-Reply-To: <aPvETBr5aebElQUS@finisterre.sirena.org.uk>


--Dhk4ruQsXIYcg54z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 07:24:12PM +0100, Mark Brown wrote:
> On Fri, Oct 24, 2025 at 05:29:31PM +0100, Conor Dooley wrote:
> > On Fri, Oct 24, 2025 at 10:32:13AM +0200, AngeloGioacchino Del Regno wr=
ote:
>=20
> > > +      regulator-allowed-modes:
> > > +        description: |
> > > +          Allowed Buck regulator operating modes allowed. Valid valu=
es below.
>=20
> > > +        minItems: 1
> > > +        maxItems: 3
> > > +        items:
> > > +          enum: [ 0, 1, 2 ]
>=20
> > This property has no default, and the property is not required. Is one
> > of these modes the default, or is there another mode beyond what's here
> > that is used if the property is absent? Or are all modes allowed with no
> > property?
>=20
> The general approach the regulator API takes with everything is that if
> there is no explict configuration then it will simply not touch the
> hardware.  If nothing is configured then the hardware will be left in
> whatever state we found it in which could be anything as far as we know,
> it might vary depending on what was running before and what it was doing.

Okay, thanks for explaining Mark.

--Dhk4ruQsXIYcg54z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP6fAgAKCRB4tDGHoIJi
0n9OAQCobSKgp224TCJ/mWYTt04fs5bxUTVnFJHz1LwZzQH0swEA+rPzYffubTv6
nxvq1BN/kkR//ktv2ykl6VnXkm0CJQ8=
=2u0+
-----END PGP SIGNATURE-----

--Dhk4ruQsXIYcg54z--

