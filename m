Return-Path: <linux-kernel+bounces-844213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75931BC150C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5D8E4F5117
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965762DC32A;
	Tue,  7 Oct 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sry1Hxrx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88E2D97BC;
	Tue,  7 Oct 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839018; cv=none; b=CGvj5yNNsuUhBRQpTFTBPwZRKTUrRkVuT5KjsxDRQlOjpBY1Tx8ZGBGil1KHfqcgkrGL0pww2E6fti00gdiIS1TFk/hMeOcNwaZDJM7H2T77jKff3TWI3EZL/v2ltswbv0CBttxqr7cQhZ/jgj5hrmusGgM+vA8QaZtHV2IXrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839018; c=relaxed/simple;
	bh=Lp6f3mPzFqMmMqKUyj87U0n0iv5HT9EpIX/gIgGIlZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msSc4U26PcP7W1xXVeoXkm/ybQ1xk3JSKGJCl1cCazitCEGBbi0zagF5JQXy+4pDSYNAFWAewStnwc9uhGEbyybs9fg4IAhFWwSiPnX8n7QlkJpm84327bLQru3gi4f0J8N+rETtMDkx6N8Izlxbkwhn227XdwW2XGz1YkIrrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sry1Hxrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C652C4CEFE;
	Tue,  7 Oct 2025 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759839016;
	bh=Lp6f3mPzFqMmMqKUyj87U0n0iv5HT9EpIX/gIgGIlZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sry1Hxrxf1L9yf7PdrdH5rNXg9ClhowagVzlSPkoTn3V1V0jws/RS7v71CK3HaJvg
	 X1SZiTReSQV2KJeIjfV7qfDgOFMkjF719dS0Wn7QECfv2WQUnSftAfRN/MdMBBQ6IX
	 NBz5RHNeY0pv4DSCbD0iFTdqTk3ucyDefsV4nF9MLmffqeE/rRLCjxuSqAONid6Cgd
	 HF0h8FBroCaWxruIu2uwNUwnbcyrcmDzlPwkTWCy2qju7Wxu4hl35NL3Ij0ZZlv7Vq
	 F8t0ou8sQnFcB9d62wtVbFhmSqGc8pV3mpCikau60IJi6OTKjIYSC6lh6RWsVnZA5Q
	 UrsgcJCOyk89Q==
Date: Tue, 7 Oct 2025 13:10:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <6963ab04-d0d2-42ee-9fc3-19f9c298849b@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <20251007113305.1337-1-briansune@gmail.com>
 <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk>
 <CAN7C2SCHirxurUA0n2VZKEEiYCt-NUKgspGFfZLNurHhACZkBQ@mail.gmail.com>
 <3266559a-8403-4a26-bbd9-c54e27fc59f8@sirena.org.uk>
 <CAN7C2SC96jZYYGP=DFrSKgtEfxy+MYpM7=-iW8YKhDG81ufw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FcpwG+ipDnwfIV2+"
Content-Disposition: inline
In-Reply-To: <CAN7C2SC96jZYYGP=DFrSKgtEfxy+MYpM7=-iW8YKhDG81ufw+Q@mail.gmail.com>
X-Cookie: Teachers have class.


--FcpwG+ipDnwfIV2+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 07:56:31PM +0800, Sune Brian wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:52=E5=AF=AB=E9=81=93=EF=BC=9A

> > > > Please don't send new patches in reply to old patches or serieses, =
this
> > > > makes it harder for both people and tools to understand what is goi=
ng
> > > > on - it can bury things in mailboxes and make it difficult to keep =
track
> > > > of what current patches are, both for the new patches and the old o=
nes.

> > The title is fine, the above is about sending the patch as a reply.

> Got it, when title amended version is sent, need no reply with
> previous revision ID.

No.  You sent the new version as a reply to the prior verison which
nearly got it binned.  You should send new versions as new threads, not
as replies to other serieses.

--FcpwG+ipDnwfIV2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjlAyMACgkQJNaLcl1U
h9BXKwf/d7kASIDZeQUmRmCdIeY1vzptA6HCJKKv9h0TKINC1pC23zaKJd3t4WAU
Ye0SZ7HIkoD6EiQu7+FXJQCUbAG+6UB9k14RE7ayl1vDHwhEvkefiQJYNXUqg35q
0pbGQaNElQVn4+fNoqlqm6fssydaTF+qyK73GUZ6HZ3ZL041ekqpv96Cvcv0MM9Z
OFhUPVZtB+gf8jGJzh9yBMUpg7uMZcC/Dy50tDFdtOcayjhhCVCB5XMCy2g4NfO9
RSs/6rbmQzTLBqCB/dizJJ/dlgg5RWuubfp/ydr88/pP1BFHuPASPflEwDD037sL
x0dECH9DiPwAbpCHQeP41+GYafCKng==
=UOdA
-----END PGP SIGNATURE-----

--FcpwG+ipDnwfIV2+--

