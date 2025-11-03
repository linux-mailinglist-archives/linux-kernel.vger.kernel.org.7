Return-Path: <linux-kernel+bounces-883738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D7C2E379
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B963B0BB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E852D5408;
	Mon,  3 Nov 2025 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5+s/V+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9834D3A7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207774; cv=none; b=LVBpCNLeMDBxoWU/0wnNOVeNlWbKQuuppNx758I6jVs360iDH8tuydEPjyQ6iZHtQqX8+pYrsz3veBVxOyqAdDv6M/5L+k53qly+Jkwjd6zeRlEUy7lAEBTlJkLXNxYtbL3Z67tc/HP0/u90yKH9x8SlXD7V0pnlx2w1xjiRpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207774; c=relaxed/simple;
	bh=NMKYCm9qt0etYqwSa7et7XxCnx4UJaqgyDUhxEDR7Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFcwoWOb88uBMXqX05NYXonlvXYGQ9E843yLKSp3Z13u9mbQwAdUunKCPQwGU2raN4M3SIitU8JTlQtE1LJtbN9Na3yWeJqzvD9R9yu28h3rPz1xRocftR72seOphHj+op4e3eR6Td+T7RnVMub0tYE37eBWXXmjRgN79uY4p4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5+s/V+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ED8C4CEE7;
	Mon,  3 Nov 2025 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207774;
	bh=NMKYCm9qt0etYqwSa7et7XxCnx4UJaqgyDUhxEDR7Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5+s/V+TI7P/kFcEfMiQgcUY2ByZvoKzuqpsYih4v9wywwgEbuiHVhdFQWVUbBOYS
	 N4Tza7D4JVW2SivsH/MFMhgsJSXazqViDCfynEse2TO+IFGs02o+GkLOiSdfKp41nD
	 CuI0vrbBJlJVm5IEfUIjMc+0ZJZmD++bpfCyJkFfgaxPJM4h+zh0N/LCTg8duQ1PbD
	 cFoNzEsQOmt3pkMIXQI36SsDTIGKwdabhDgvALc8RAdCIeenbjRDX7Nc5Gk4l2RxWv
	 JBp3eidF9esIVdSBQVHr98V7bs3ua9Nw/Uxq+HDeK/ByZLJ9t2rkmIsibEiyy/ti0P
	 dMcYeOK7V8F6A==
Date: Mon, 3 Nov 2025 22:09:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: dw: Add apb reset support
Message-ID: <20251103-deviancy-gurgling-0b37c8637a8c@spud>
References: <20251102100237.9451-1-jszhang@kernel.org>
 <aQjNxCencdfq4bXq@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cce9vBmfo2ERQ16P"
Content-Disposition: inline
In-Reply-To: <aQjNxCencdfq4bXq@lizhi-Precision-Tower-5810>


--Cce9vBmfo2ERQ16P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 10:44:04AM -0500, Frank Li wrote:
> On Sun, Nov 02, 2025 at 06:02:37PM +0800, Jisheng Zhang wrote:
> > Add support of apb reset which is to reset the APB interface.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/i3c/master/dw-i3c-master.c | 9 +++++++++
> >  drivers/i3c/master/dw-i3c-master.h | 1 +
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw=
-i3c-master.c
> > index 9ceedf09c3b6..ca2863d2b2b7 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -1558,7 +1558,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *ma=
ster,
> >  	if (IS_ERR(master->core_rst))
> >  		return PTR_ERR(master->core_rst);
> >
> > +	master->apb_rst =3D devm_reset_control_get_optional_exclusive(&pdev->=
dev,
> > +								    "apb_rst");
>=20
> Does binding already add "app_rst"?  The name "app" should be enough.

The binding defines no resets at all, so there's a missing patch here.

--Cce9vBmfo2ERQ16P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQkoGgAKCRB4tDGHoIJi
0ulLAP4jeY/i7zrDyTLIPeohketjeYMa0TSVdNJErhtQ8AW1pAEArMK31eQAI690
7wT4UKbXl0Cw+XJ9/pBKUj3zX4/q5Qw=
=R59D
-----END PGP SIGNATURE-----

--Cce9vBmfo2ERQ16P--

