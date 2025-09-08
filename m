Return-Path: <linux-kernel+bounces-805021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47CB48314
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE821742CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55D21B9D9;
	Mon,  8 Sep 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="tvyXn3ui"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DD16F0FE;
	Mon,  8 Sep 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304176; cv=none; b=uSPqjGSYVs01kVzaCNHb+IErCniDUb7tyf8LDPRGYZGSKqb9Z745uizTTMFutzREJAY5bV0zge5Rg3m35ABLx7KYgHzS3JPDwyRtPjScX4utGiNnKtont2G/Cbq6grtwU/q/CRUVYUSpTts3JTg61PDg74sSAif1g/tjDE8JzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304176; c=relaxed/simple;
	bh=Mw7y5CKpjj1kCLIHq49+s1B3tHAv6to+LItwIXxncn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTWCUBbVQNWKMVDA+y/UOoeqhg6HuUg8qBBZ4NzbgXABkHVWjecC/33j+tNhJLtIiRyf8ugZB8JSsd2FrqPwGc5Rd+CxIoTko3qGTnzIXLaHEW85Yb+ysssFlMvK/tx+BTMw3JD9lWlzG1xmRWhlEmInLnzY70TwkFASwEs7IJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=tvyXn3ui; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757304169;
	bh=+DVku2GpjSU8Pe98enb9DbHLBpEscK8lb8VBTFVwSS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvyXn3ui3/qGGNbGkyZvGREWFbduw3vm8b1i8Od1Yv+s+WAICJ1GktEsrGf9dbsMB
	 X7+/vwj09HO+4z+LzInVma5oPjiu8DtvSCB5ILhAig8RZolxLCx5gtMh/KZ6x0unUA
	 G1Cvasi/QzDqbSVVSWc5pjrqh5LslcsYDoUC35sO+9rqidXuMuzKWbseVrqwyjqgGn
	 N2mA3MIxwd7UD49VaOnQ/yvVssNldTDLpNA0PZ2F8egist/9jGpXXEqrimveWwfooy
	 rmB7qXXvo7Rt5Gky4dUtrZ0d+S3CD/uEl2CLB1QuU191XGUikg7Fp/JlYM2ReK4jrw
	 +vEn5rlDSxBNw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cKtZx4RStz4w9y; Mon,  8 Sep 2025 14:02:49 +1000 (AEST)
Date: Mon, 8 Sep 2025 14:02:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: linux-doc@vger.kernel.org, devicetree-spec@vger.kernel.org,
	devicetree@vger.kernel.org, ilias.apalodimas@linaro.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: devicetree: overlay-notes: recommend top-level
 compatible in DTSO
Message-ID: <aL5VZfOoy1g2uyAH@zatzit>
References: <20250902174351.2457022-1-raymond.mao@linaro.org>
 <aLkAYitpWxWx131p@zatzit>
 <CAEfUkULwQxJ-EKT7bQ8+hkH+_xO8esThnL2P_Rc-32tHyMdA1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XVQ/eLKMwcuqE7xj"
Content-Disposition: inline
In-Reply-To: <CAEfUkULwQxJ-EKT7bQ8+hkH+_xO8esThnL2P_Rc-32tHyMdA1A@mail.gmail.com>


--XVQ/eLKMwcuqE7xj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 10:40:31AM -0400, Raymond Mao wrote:
> Hi David,
>=20
> On Wed, 3 Sept 2025 at 22:58, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Tue, Sep 02, 2025 at 10:43:50AM -0700, Raymond Mao wrote:
> > > When managing multiple base device trees and overlays in a structured
> > > way (e.g. bundled in firmware or tools), it is helpful to identify the
> > > intended target base DT for each overlay, which can be done via a
> > > top-level compatible string in the overlay.
> > >
> > > This provides a way to identify which overlays should be applied once=
 the
> > > DT is selected for the case when a device have a common firmware bina=
ry
> > > which only differs on the DT and overlays.
> > >
> > > This patch updates the document with a note and example for this
> > > practice.
> > > For more information on this firmware requirement, please see [1].
> > >
> > > [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> >
> > I think this idea is probably useful enough to be a good idea anyway.
> > However, note that it leans in to an existing ugliness of the overlay f=
ormat:
> >
> > Overlay dtbs kind of mix "in band" information - the actual new
> > content for the tree - with "out of band" information - how to apply
> > the overlay itself.  Whether a given property is data or metadata is
> > determined by it's place in the tree in a moderately complex and not
> > super obvious way.
> >
> > About the clearest divide that exists is that generally the root and
> > first-level subnodes are information only for overlay application,
> > everything under that is data to be applied to the tree.  This all
> > tends to have names that would be unlikely (though not strictly
> > impossible) in a fully applied tree.
> >
> > Putting 'compatible' at the root of the overlay is putting something
> > that looks very much like a regular device tree property in a place
> > and with a function that's purely about applying / validating the
> > overlay itself.
> >
>=20
> Since all information at the root of an overlay is considered as
> metadata (out-of-band),
> If you think 'compatible' is confused, I can change it to
> 'overlay-compatible' - which should be 'unlikely' to exist in a full
> tree.

No, as I said, I think the advantages of this proposal still outweigh
the disadvantages.  Just pointing out that this is highlighting some
of the ugliness in the current way overlays are designed, which is
relevant in the context of concurrent discussions about connectors and
the like.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--XVQ/eLKMwcuqE7xj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi+VWQACgkQzQJF27ox
2Gco/g/8C3x3D3BQ8/L44GZMTfbxKC5NPMh/+kDZ6h5bE5MOuTi6mv6VffiQ96qG
xMS4b/H0pLEKy9RtBfV2f1EZio88mUmDpe4Nv6w/LVQdaow6+loanMOdQ1+H26XX
SoCTDUaJfzeAaV4GJ7A4RSup5mCdCkz7uNAdaGa9BQSgnFjfQt0QHtjNywpzltpE
9XVSB+v8t9uSx7U+HqGDSvMx4TQ2iXQ1aiiAQ/+PFFsOk4j/EM/tVJrckxDkddfF
INEK3XPdDoi1EbjYUugCMV8bm0KpzZbVOJgPp8Wlt4U1XWno1dsUNYaY0djTFLK4
/RehLRKXe/E3AdS0wv9CundSw+Ag9/+8k93o3Mf020m5cusDBRwo+9I+HJFo1Hhc
3vSQuhTLZFpXdpBNJsy3xVOqZTc4vGXJbv6jLvxCpqrPRobziksGJDTcRqsQ+Ut8
C79j8vXUOu5oK1fmNihFJu1Mve55+9MiirTVyPl3zmepLRE59BeqJ+JLdjJ20sxy
dm+dTeX5RHHlt+GIZMsqhaKLObC3THmm7CW4sdegHv+b72BOwQdKZ4CcfmiIp60k
YNw89/qbGqS2z3NQ9UXg71n9KWfje8wkG0sXDtFhyuZewBK8MH+S9Y/uHBjvc2Hj
tTaxLI9r5Y7Y2/qFFXgSkmBrRkVfpNtd4QVP8c9WcQjP/AzpWS8=
=LWzd
-----END PGP SIGNATURE-----

--XVQ/eLKMwcuqE7xj--

