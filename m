Return-Path: <linux-kernel+bounces-769474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA41B26F29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AAA1C248BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25067234973;
	Thu, 14 Aug 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+OwVj2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D92309B0;
	Thu, 14 Aug 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197012; cv=none; b=jjUh/hzwePT48Yhv/Cadk/UKgKhX6KE6MKtR/wGzcAPZoIoNiEKQn6wlZuxhYU93GbqVeUntgW1Gq/LGvCNxtUETHO64ZjIXoaT8K4+tcGdQC2tpIGgNRro88VeJNYA+1zUU+8WnmJWxU5F2rw/5/OmbZOWpUC2sGPGkycEIoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197012; c=relaxed/simple;
	bh=+edEx8wP5sj6lIPPo4+9dTecgBzL9N0lb1TKODlviEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5o8m+bcEJ1M3+UdfvihLRdamgHnKblel5Dfpn0vzKAUrgkKPBePKPssP/XPCuWKWlbrES9ggX/bP4eF3iolsMNQyI2f5WoPsiq5rhzb4AehTNJSwfPZLvwo+7OOpvp0o4Ghwe5wGdGeIsje++F7+4JwpAUwXAR16sT6ZW156uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+OwVj2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC47DC4CEED;
	Thu, 14 Aug 2025 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755197011;
	bh=+edEx8wP5sj6lIPPo4+9dTecgBzL9N0lb1TKODlviEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+OwVj2OLlRjK6XZS/8srDIRauWKxHcA5a0JJhaqDHoM751EWi35LMp2Qe71x0vJI
	 F3EJ42mzPbM5HV+kbrIw+hh1YmI3ExfnBXTCfklBDrnUbATkYqavQRwnzlA8+5Es4P
	 0+ej6Zk10WhURXK1AJDCbBBAXRx0GmNAAYusuOELHieRqq67QzKPoAdJiF1E9AAV82
	 axYbo7gzJ/2k223McejgeoQ1CdcFwGND6LcXLewKrTSJqwkWLyxwizNuzO3cAJYp3l
	 /DuPYD3q9QH5fFlOheUTni3cZbMk0KIUxvxBoLChPc+8KhPSF8Pv+R2INB3sXR0lN8
	 RYjoZvJjyUDsA==
Date: Thu, 14 Aug 2025 19:43:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com
Subject: Re: Re: [PATCH 1/2] ASoC: es8323: enable right-hand DAC-mixer
 connection on ES8323
Message-ID: <7d2529cb-7ecb-4616-af04-f65b1f309d89@sirena.org.uk>
References: <b5a64166-c55f-4ca4-af92-52c954847af6@sirena.org.uk>
 <20250814183344.59453-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V6wTkxydwkAjWbTz"
Content-Disposition: inline
In-Reply-To: <20250814183344.59453-1-shimrrashai@gmail.com>
X-Cookie: This sentence no verb.


--V6wTkxydwkAjWbTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 01:33:44PM -0500, Shimrra Shai wrote:
> On Thu, Aug 14, 2025 at 01:11:59 PM +0100, Mark Brown wrote:
> > On Wed, Aug 13, 2025 at 08:47:31PM -0500, Shimrra Shai wrote:

> > >  	snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);
> > > +	snd_soc_component_write(component, ES8323_DACCONTROL20, 0xB8);

> > Neither of these should be unconditional writes, these should be user
> > visible controls.  We don't encode specific system's use cases into the
> > driver.

> I was just following the precedent from the driver's prior
> author(s), in the manner of the line above it. Presumably, enabling
> the left-hand DAC-mixer connection only was a solution that worked

Yes, as I say this is very bad practice on the part of the original
authors which only escaped review due to the magic numbers.

> instead of using a blanket for all devices as I thought. In that
> case, that means the original author was also wrong, and so I need
> to know exactly where it should be placed.

Like I say these should be userspace controls, not just blind writes.
Probably wired up in DAPM, SOC_DAPM_SINGLE().

> which suggest it is in fact controllable already, but I wonder why it
> is in the "bypass" switch only and not the "playback" switch, which
> seems to do nothing (SND_SOC_NOPM). Would it perhaps be correct to
> move these to the "playback" switch, or to have both switches
> collapsed into a single switch?

Those will be different audio paths, it's almost certainly a bug due to
the hard coding of the enables.  Both DAC and bypass paths should be
normal user controllable things, from the sound of it what's needed is
to define the register for the DAC path.

> In any case, if these are the correct places to enable this control
> and it is already supported there, then it seems neither write command
> in the setup is needed, viz. we should _delete_

> snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);

> too. What do you say?

Yes, ideally that shouldn't be there.  There's some risk that there
might be some userspace relying on having the mono channel enabled by
default though so perhaps it's safer to just leave that as is - the path
can still be configured by userspace, even if we end up with a weird
asymmetric default.  I guess there's also some other things in that
register which most likely should also be controllable.

--V6wTkxydwkAjWbTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmieLk4ACgkQJNaLcl1U
h9Aujwf9H4/FrH0RsNY7gMqAmRWMuc3EYNLFbcnfpLD+rFs2X4sX3XiQCaPzY/S0
XgDhpQP1+6+oLIJx8m9+mm5Tpcbr237cNLkYkktWT16vTC0Kb9mVmjMR5i1plscZ
NbsFHXCZmmxYv6TFYYgjIq1vuYCssxzU7QBFJJSdXBzehOi4deYinNcN9lRti0jX
TYcfWOxYT9xKhzaJuXWAoQLt1XFMNnzS1LBD5QfWUKgnmEV7RQ0o7io2flZVnqVA
ZD4wQwRqGVlB7R9pQRuupNhoKJyruO5Cd7NmwmQFtuUSwXS8ca4UO9pU/52dJueh
jrSJ+kSDmrF7fheV6q3yHrpBoYPuhQ==
=x+Gy
-----END PGP SIGNATURE-----

--V6wTkxydwkAjWbTz--

