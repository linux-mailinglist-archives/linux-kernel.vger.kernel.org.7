Return-Path: <linux-kernel+bounces-724111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F2AFEEBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A1A3A5495
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F692E9EDC;
	Wed,  9 Jul 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLPgCOdi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26A2E8E09;
	Wed,  9 Jul 2025 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077560; cv=none; b=jcBqNfSxw6OqJJ2CRRdxDiwvoVlIRDpjiSBlmu4eKnIRzl/5+M5hc5SzwZGPf5DQKehrbwt09RghAFy9OhfmWlfkiQPWZHxEwTQ0zj87ecqtIjxuLZCeeEsT8CzJhlw1udTaR/njnNIxPM9rup5IuX2N7ueCu+Fg8dGu1Z1642Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077560; c=relaxed/simple;
	bh=RQy318+GkhVafNHZ5cXKCP2xo0jeEsfQNsJHtJFqqSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNirwb3/WaRmTRYx514Ybyfs7tSwSwYOUA+dOW4FtM4DU4hjhTisBFVwWKk0p1sCNzFQ26zV1bTlOky0DcjcD9CcIadIKHgrbjmvtE3YIJe7n+EsR1ugcuvugKzhNd4+u6xnBNVmPzyCEtKC+6G5Gcwo8JAT16rv2A8PpiJpbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLPgCOdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69AEC4CEEF;
	Wed,  9 Jul 2025 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752077560;
	bh=RQy318+GkhVafNHZ5cXKCP2xo0jeEsfQNsJHtJFqqSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLPgCOdiC1mkJx3nzdAXPX9Fgp1Xt9kBsYqXxkqqsu1z1u2gld1UtjwQwbAvLx/Ts
	 cD2qGqYuJKvHlCaJ3IJ6YdcHhSSLCYiw3/T19jyeOzb+gQ68uAhGG6wqIMUmO0F5I6
	 qoz6BuqStT1aa59IE+M0fi2PdYiYRQeDSnfCsDaFvCuHMmXJFVs0HEcu1c1+ZoNgwt
	 jjzdP+CoTzjVma1Bb0Otz4Erv3GmlwmwDr8VVWonsEsbyDta+VzFDGCEI9XD/kJLGG
	 aSuiA9eJnMZzGkiqoB8pAPH8R6sMGCyKWmyOCmGTHTiZ1ekxcD/4aDgX4Em8xc3e5B
	 Ep8u77r+A5kmA==
Date: Wed, 9 Jul 2025 17:12:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
Message-ID: <20250709-gem-disparity-185256a670f0@spud>
References: <0886d3eb81bffbc1d48e701cae21c42cad29fefe.1751988704.git.geert+renesas@glider.be>
 <20250708-jubilant-abruptly-8ff77f7986ca@spud>
 <CAMuHMdVwbHoEbjC2y4kpJuhx7CYsRxO9Y+eCUhJkKogk=zDs8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BE3zxSWO0KkYnQpY"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVwbHoEbjC2y4kpJuhx7CYsRxO9Y+eCUhJkKogk=zDs8w@mail.gmail.com>


--BE3zxSWO0KkYnQpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 11:29:24AM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Tue, 8 Jul 2025 at 18:49, Conor Dooley <conor@kernel.org> wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > On Tue, 08 Jul 2025 17:36:48 +0200, Geert Uytterhoeven wrote:
> > > The SND_SOC_STARFIVE Kconfig symbol was removed, but it is still enab=
led
> > > in the RISC-V defconfig.  Just remove it, as it is no longer needed.
> >
> > As I mentioned to Palmer a few mins ago, I'll grab this along with a
> > couple other soc-related defconfig patches I have. (Apologies if this
> > goes out twice, I got a warning last time about a timeout, so ending ag=
ain)
> >
> > [1/1] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=3Dm
> >       https://git.kernel.org/conor/c/493e9b085299
>=20
> Sorry, I forgot to mention that the commit my patch fixes is only in
> the sound tree.  One other patch in the original series did include a
> defconfig update for a  MIPS platform, so it may be more appropriate
> for Mark to include it. Or just wait for v6.17 ;-)

I was going to include it in 6.17 material, with the other soc-related
defconfig bits. I'll drop it if it's problematic of course.

--BE3zxSWO0KkYnQpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaG6U8gAKCRB4tDGHoIJi
0k0pAQCnoUW0gyPpDqXAOul9agDPGo1zmZs9j0vD8cAxkbR1lQD/dbVDHZXfmYol
Ug0NjgL1HfHh9vUa4uvSYpbE4Ay2/Qk=
=4vJ/
-----END PGP SIGNATURE-----

--BE3zxSWO0KkYnQpY--

