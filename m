Return-Path: <linux-kernel+bounces-786222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE74B356BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EE41B66358
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3E52F8BF1;
	Tue, 26 Aug 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f8ZYK8FS"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9F129E6E;
	Tue, 26 Aug 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196715; cv=none; b=SSS1tHWnSt7ypFOJ1SH3gP7Upg258NSUjWU0CtnfNvk02pynyI2ql7pY5ehYyTzNfEh1in4ZCEIe7f3mL3JmfUMOskwBY4OnsyAU0HjsMP0+xJ2sFN5N1sl0uNH9vYfgSHjrXhakVwhpAyuDwjgZ4YIViDpK2oQgz7MWB1nlQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196715; c=relaxed/simple;
	bh=M3lwJYmTuFciCOkfBfpRk1F/UtJ1CMI+s6RqEBtEKls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXjeRXMmo8CqrxezR9Tf7aWuIW4rkxNgKnLxmCU6PKSzHuNEkKwT10qM78hZDNnm8G7iM8AnsL/v2uW9r+jKx2S4ZFvlKEBjTZIovCdhnjpT92VvBxknfQXXOcIQ6Oq4Mcb8/yfuhaeQq3VsNjSzDXyLtuXCZuk3HZYPESANyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=f8ZYK8FS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1756196706;
	bh=StN559UZpfgPKLYEDGOhWh4BuXWyw9zkeGi3ACermV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f8ZYK8FSVBjxxh2z6c0+vAqSC98YVxAgNC6xFPBNSyRTAoOllM2/B+v3kOWESx/zN
	 02zalRR0pl9nASJtCXut/5I1oiZhmxk4J/JTPkD+CnGFznzyxnTkH1fMccGtl/jzmh
	 ueJTy7mSA0Hevlnjl5ukqQ8U2ldTEqu5jy0Pu8p15UDDF4893qHuvgvF4Xh0o62ljO
	 EPHaM1NY83xQIM3Ie/7TTF0EorJcEvDFFtvJY+bzph2XWZ3r4EBunxdJfzVqsD6rHY
	 CPCWD6zmLlrkB5SRA8SHDytr8UV56AQuYC6VOO9SW+ri/GHzA4f93sGgbXg0Q8FI29
	 Tm6i715BMsgtA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cB11W41G9z4x3N;
	Tue, 26 Aug 2025 18:25:03 +1000 (AEST)
Date: Tue, 26 Aug 2025 18:25:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>, Fox Foster <fox@tardis.ed.ac.uk>, Federico
 Vaga <federico.vaga@vaga.pv.it>, Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?=
 <j.neuschaefer@gmx.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
Message-ID: <20250826182502.701a3031@canb.auug.org.au>
In-Reply-To: <2a66319f-63f1-408b-8815-89254d68b90b@gmail.com>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
	<87349ed6zj.fsf@trenco.lwn.net>
	<2a66319f-63f1-408b-8815-89254d68b90b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RWNzJ=iQHs.zG2UWsz4wr+g";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/RWNzJ=iQHs.zG2UWsz4wr+g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bagas,

On Tue, 26 Aug 2025 14:40:08 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
>
> On 8/26/25 11:47, Jonathan Corbet wrote:
> >> diff --git a/Documentation/process/management-style.rst b/Documentatio=
n/process/management-style.rst
> >> index dfbc69bf49d435..1381b253b19ef4 100644
> >> --- a/Documentation/process/management-style.rst
> >> +++ b/Documentation/process/management-style.rst
> >> @@ -42,7 +42,7 @@ actually true.
> >>   The name of the game is to **avoid** having to make a decision.  In
> >>   particular, if somebody tells you "choose (a) or (b), we really need=
 you
> >>   to decide on this", you're in trouble as a manager.  The people you
> >> -manage had better know the details better than you, so if they come to
> >> +manage had better known the details than you, so if they come to
> >>   you for a technical decision, you're screwed.  You're clearly not =20
> >=20
> > This seems actively wrong ... ?
> >  =20
>=20
> What I thought on the original wording was that the people (i.e. develope=
rs) know the (technical) details better than their manager.
> And yeah, "better" was duplicated.

One way to make this clearer would be:

 ... The people you
manage should know the details better than you ...

--=20
Cheers,
Stephen Rothwell

--Sig_/RWNzJ=iQHs.zG2UWsz4wr+g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmitb14ACgkQAVBC80lX
0GzQlAgAk4fasyu9S5xB1rat10mRqQ7EFFwaPdwnQPxRamdj3H+rcFv2vbqzyomx
Mh58WeF51VYyEooFX+HSOjPfq4qkryXj36CLrCPj1wW8v6tK53Se62UOs1oXOgvZ
9FmyTZQblnzMBHH3e1H9RS4wbVMpTH+HUF0IHWtL0CD9ehkCK0h1oan4KAWnUMXE
g/k6k4wMUR1Zx4ISX9RipZQWl+qZGP43hsCxWtp4FP3Z2c8kPWzelcIl26C8+o6f
EJMN1aVI2Eyo7Fq/HNAvjxQeGrn1c6WMOHF1zsjHOtOmBgTIxw9nHO8PqKOE67tV
9vJUbsXr7ms3kik9FY0YqHlm9HHF8w==
=M0UH
-----END PGP SIGNATURE-----

--Sig_/RWNzJ=iQHs.zG2UWsz4wr+g--

