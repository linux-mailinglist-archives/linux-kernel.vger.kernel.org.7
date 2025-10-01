Return-Path: <linux-kernel+bounces-839401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D913CBB18EC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B5F3A86E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400852D739D;
	Wed,  1 Oct 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVNXi5Um"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966342D24B5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345378; cv=none; b=rz6LBJdgbhT9goMSRNZjgx6ruGAY8hMDqaZ6QsgXsGAWG+ueH/EA+KbYWJwdj6z07hY0XSqoztcX0Xq4uJZjMdAhqbdhh70JS0ikaVf6TNaNi0YJfKJLTLqW4ozT3tbOSocU9Uf008lB9ytvCXmjvSL4DpPYFm+O/FKlvzX7cqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345378; c=relaxed/simple;
	bh=k87qZHehp4tClwKFpwYrLChW5r/zrrDN5eXK5bp9rtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdXD4ffAbtlkPCQem/Eei2d/3rQiv6HZfgsV6UOIeR/dqm4tft2980toLnj39DbwTm9bMyQChe8qPefOL8dfX16oV/r0BGe46sTFq7ooqbgVcHsHiZPMbo9FOYNtxx150KK23SppWQkhE8c9W2sHun18cTJTyOdvSCxsLt4GFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVNXi5Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E15C4CEF1;
	Wed,  1 Oct 2025 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759345378;
	bh=k87qZHehp4tClwKFpwYrLChW5r/zrrDN5eXK5bp9rtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVNXi5Umas9pSwqwrw5o/3bxet6QfZ+0ay6dmVD7hKa9MI288Uz2iDYtcvVvHsC1s
	 ZvFPDXOkDsboNtJLHcLAzL+VWrUaycVkEgAMm3QrmMSpeabJeVQy9AV5Um9cRsUpDf
	 qsxD3hhGJeY8WExzHYdoutO03MKo+GG4BS9fvpgxU16rYHeGefJlSElg5ngFC5r6wB
	 1MGsqs3wfE3rX4yrEzdd2psLDR1E+5AD7Jf/0WXhNIWJ2og8LBpMOz62caUaZW1IXV
	 WPyZbHwCsDq4UTxEOLL5Anx0eblwvk0MYPOUaIGdXMKKkiWQARZwz1WGEmv8R5EC4n
	 hmpSnvxVpdx0A==
Date: Wed, 1 Oct 2025 20:02:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <20251001-patrol-recapture-4bdd58ad7582@spud>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B7ycgXsqnWtwnYaB"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>


--B7ycgXsqnWtwnYaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 04:53:24PM -0700, Linus Torvalds wrote:
> On Tue, 30 Sept 2025 at 09:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Oh Christ. Is somebody seriously working on BE support in 2025?
>=20
> Ok, I just googled this, and I am putting my foot down:
>=20
>  WE ARE NOT PREEMPTIVELY SUPPORTING BIG-ENDIAN ON RISC-V
>=20
> The documented "reasoning" for that craziness is too stupid for words,
> but since riscv.org did put it in words, I'll just quote those words
> here:
>=20
>  "There are still applications where the way data is stored matters,
> such as the protocols that move data across the Internet, which are
> defined as big-endian. So when a little-endian system needs to inspect
> or modify a network packet, it has to swap the big-endian values to
> little-endian and back, a process that can take as many as 10-20
> instructions on a RISC-V target which doesn=E2=80=99t implement the Zbb
> extension"
>=20
> In other words, it is suggesting that RISC-V add a big-endian mode due to
>=20
>  (a) internet protocols - where byte swapping is not an issue
>=20
>  (b) using "some RISC-V implementations don't do the existing Zbb
> extension" as an excuse
>=20
> This is plain insanity. First off, even if byte swapping was a real
> cost for networking - it's not, the real costs tend to be all in
> memory subsystems - just implement the damn Zbb extension.
>=20
> Don't go "we're too incompetent to implement Zbb, so we're now asking
> that EVERYBODY ELSE feel the pain of a much *worse* extension and
> fragmenting RISC-V further".
>=20
> I'm hoping this is some April fools joke, but that page is dated
> "March 10, 2025". Close, but not close enough.
>=20
> This is the kind of silly stuff that just makes RISC-V look bad.
>=20
> Ben - I'm afraid that that page has "further reading" pointing to codethi=
nk.
>=20

> I see some CONFIG_CPU_BIG_ENDIAN has already made it in, but this
> needs to stop.

Perhaps somewhat ironically, most of the instances of CONFIG_CPU_BIG_ENDIAN
that are already in the kernel are the Zbb specific implementations of
string manipulation functions. IIRC they got added to match the Zbb spec
appendices from which the implementations are sourced and speculatively
in case BE ever did get added. The kexec users are just a straight copy
=66rom the arm64 kexec support. None of that was really done as a
deliberate attempt to add support for BE, in case that assuages concerns
you might have about the taste of the arch maintainers..

--B7ycgXsqnWtwnYaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN163gAKCRB4tDGHoIJi
0idFAQDbK54rzDaSznr/vqyLz1il3aWmsH8QbAcv6TNKxLpUdAD+O0v2U1QA5nG4
InvDLiEz+2MTlGCJT2lQ+Hr9zRVPGQg=
=fAoe
-----END PGP SIGNATURE-----

--B7ycgXsqnWtwnYaB--

