Return-Path: <linux-kernel+bounces-841751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6634BB822C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEDD3A8D54
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7D24DD0E;
	Fri,  3 Oct 2025 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6y11QK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A83987D;
	Fri,  3 Oct 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524465; cv=none; b=MNnQYAVEXZqOVXLyYipwdV4cvYe2wBqYxJdK80+S0sQZkPdeWo3EnCTKMxsysBwfMJSyZkgsOXwmH/wzR4eJuZLixhpIhf50pr+OoL0ZdcHmgC25DgE7xOf1gG5JEEsv5sbDnjlQmeTj6erbpGqrBmofIEXjSJ4XdrgPPd/Rw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524465; c=relaxed/simple;
	bh=s9KdYwHxtmjq+rq4sojwwWTmmqYjg09bj3FGC5XSE/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4LdM15ePpBHRKYN/dxw2hK4OoozEa0c/fTNX25AZu/TkNm9vlPREs6SllqOLcxy6+hz6ng9c2iI/IlsMmmz03xklMCHgaM6BqwhqJx1SGnDjq3+nUeRufIP5U+FRIBkdexQ0Y21RcSlHzdCnEHCdtdBhvTr7/UYyxgPt7Ktewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6y11QK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7302C4CEF5;
	Fri,  3 Oct 2025 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524464;
	bh=s9KdYwHxtmjq+rq4sojwwWTmmqYjg09bj3FGC5XSE/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6y11QK15ZptdWlP41qvreKP+B3iFmWUFkf3nCrbM4xwYUYyG9tVcIfnLscTKs9PW
	 RwKJdiQ+tHjDH6b4QYRIPTDqNM1yRC1FmVnI7xpckDbCDby6fRJDNSGLwyLmrCsMuJ
	 +EnsN/amGGUjz9mlYR90GLkIe8Xf6BfRBM29dgfEz7TqOURUVnmmusBn7haFd57Ot2
	 pRVOlOH8XaUsiBM7yX3x0MEUQ2jBX1e1ybH0Ls+ivJbWVIQPu2cA3CTiSCe+rGIG1t
	 6J2cK6X8+UjoK3QC7jNlBcjsU77FGfp8OKFRtwyDzKZpBWDFcBKhusG2TosjL+rhPj
	 A7mRq8QKyoYMw==
Date: Fri, 3 Oct 2025 21:47:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Message-ID: <20251003-gestate-roast-37ef1b1c2e07@spud>
References: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
 <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
 <TYZPR06MB65687E6795F9C899B3F067CEF1E4A@TYZPR06MB6568.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1VWs/xU7QyzcZvNl"
Content-Disposition: inline
In-Reply-To: <TYZPR06MB65687E6795F9C899B3F067CEF1E4A@TYZPR06MB6568.apcprd06.prod.outlook.com>


--1VWs/xU7QyzcZvNl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 01:50:46AM +0000, Jammy Huang wrote:
>=20
> > On Thu, Oct 02, 2025 at 05:56:51PM +0800, Jammy Huang wrote:
> > > Add VIDEO reset bit definition for AST2500/AST2600.
> > >
> > > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > > ---
> > >  include/dt-bindings/clock/aspeed-clock.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/dt-bindings/clock/aspeed-clock.h
> > b/include/dt-bindings/clock/aspeed-clock.h
> > > index 06d568382c77..421ca577c1b2 100644
> > > --- a/include/dt-bindings/clock/aspeed-clock.h
> > > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > > @@ -53,5 +53,6 @@
> > >  #define ASPEED_RESET_AHB		8
> > >  #define ASPEED_RESET_CRT1		9
> > >  #define ASPEED_RESET_HACE		10
> > > +#define ASPEED_RESET_VIDEO		21
> >=20
> > What's up with the gap here? Are there another 10 resets missing?
> Thanks for your review. I find this is just an index of reset map. I will=
 update
> new patch later.

I don't know what this has to do with the question I asked. What's going
to be in the update?


Cheers,
Conor.

--1VWs/xU7QyzcZvNl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA2awAKCRB4tDGHoIJi
0jDmAQC9H6FC4Z5rZxCYUvmj2W55k+/oKnx/O91NA9fjEXpn4wEA1EUm7O+71S3h
KO0JSohz5byNmEAy5MoQILoMqD6k2Aw=
=MtpR
-----END PGP SIGNATURE-----

--1VWs/xU7QyzcZvNl--

