Return-Path: <linux-kernel+bounces-773995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26095B2AD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155B41B2493A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2E322762;
	Mon, 18 Aug 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcwR3C+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39732254D;
	Mon, 18 Aug 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532125; cv=none; b=aELVieXgd9qy9nGS9/XPIGb0s968eEKg7Jjl3wnGo6gWUvubkoF0g75nSrs9rGG8WMlSmSjFyqJFwq0u+Wjm/4PQZxOFI0UEPMaMvIQZRF7jyLOQ6bVOHJgbkFcw3PmxP2L9A0RpsZbbCIqww8c8R4OMGirGH9CVsw0ZHO6tzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532125; c=relaxed/simple;
	bh=Gsf4hYz1t1PPwQY5cCeTDhK3xws8M2fmBosGFpRURDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuqpgdlWiHg89BID68sCR7uyOt7HHwdh8C0bDgJaI9Nw6SIbk/GSCrDv7xnjcg6QUB+tNeQ+r7Cg76QDQsYuYkTQr/ciiaftcoez8pad1zBizoWWCn0JL/bGkmx0vM4MllqUwpQ/3GSygiqs5RnH37VmHD0dzGG3PsvZnU/VBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcwR3C+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8938DC4CEEB;
	Mon, 18 Aug 2025 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532124;
	bh=Gsf4hYz1t1PPwQY5cCeTDhK3xws8M2fmBosGFpRURDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcwR3C+IgjQvfxVNJtB6HcwKS4D6Fuhu6vjNWn23hP9N5zmJezFKSRjMFrL97+vyt
	 1uNHwfeJVzacR5oXUVA0rd89/RK0hV5jtymHWWT6x6JCerFmhUxb8hkVBSrg7EdEQL
	 QjAE+rwGRUAh8bNR19g9FEon6HfQLAnZp2SZ+nd63AATvfeSEKDwiGtY/F8fyQaMd3
	 tOylhsrkijU24jEK4QamQxFA9eGKGKi2Tj43Rsi/jkcRmPqaUEwLCmI24ISXmduzse
	 eK4SavulmBrZRAYToPWhCjC5xsoSQPk1tjAORBf7qKMyPgx9RGZT3E/4+Whx7WJbTV
	 Hlmk/sx2HivEA==
Date: Mon, 18 Aug 2025 16:48:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ASoC: cs35l56: Fixes for CS35L63 for production
 silicon
Message-ID: <dea2b581-b984-4232-bd65-b0e6357e78a0@sirena.org.uk>
References: <20250818145952.124199-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I1gmiPG33CiQ9Utz"
Content-Disposition: inline
In-Reply-To: <20250818145952.124199-1-sbinding@opensource.cirrus.com>
X-Cookie: No guts, no glory.


--I1gmiPG33CiQ9Utz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2025 at 03:59:40PM +0100, Stefan Binding wrote:
> Production silicon for CS36L63 has some small differences compared to
> pre-production silicon. This requires small fixes in driver.
> Update firmware addresses and remove soundwire clock workaround as no
> longer necessary. In addition, different calibration and tuning
> algorithm IDs are required for CS35L63.

There are multiple changes in here, this should be a patch series not a
single patch.

> -static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
> -				  struct sdw_bus_params *params)
> -{
> -	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
> -
> -	if ((cs35l56->base.type == 0x63) && (cs35l56->base.rev < 0xa1))
> -		return cs35l63_sdw_kick_divider(cs35l56, peripheral);
> -
> -	return 0;
> -}

Are you *positive* there's no preproduction silicon floating about out
there?

--I1gmiPG33CiQ9Utz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmijS1gACgkQJNaLcl1U
h9BfFQf/SmzbMuyTTwJDKte6b7UYif3niHRgAJyzoxoGqI/OEpaXgiK/y7qbViie
hmi0XtOgh2mLmHE2y+Oh1/DxtkPmcdPBcHMTX4p541YnctCxVNarB6H5sAc1pRK1
mo/Qixcebu5wfH2rFa123FFaQYznDo83r784pJO1WVr147mpTyVLxW6jOUg85amu
1DSCuXev/zNVgnQ2+ZT/1kIdIfdzz529aikn8prgjkV44dfB+FLw46BnLEJ8e3FC
9AmtHWOkh7XHNCIgsZbbOApyRlgJZogR4p9dFOGGlMIpwntEWksLlgk+7mW5MOAk
xfIt9XW2Npo7Yil4/YPVb6KTxvzvuQ==
=Hbol
-----END PGP SIGNATURE-----

--I1gmiPG33CiQ9Utz--

