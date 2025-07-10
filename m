Return-Path: <linux-kernel+bounces-726051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF4B00788
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFE188B62F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178D13B293;
	Thu, 10 Jul 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="kxAHCmYm"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B762727F2;
	Thu, 10 Jul 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162275; cv=none; b=hBWBOBPxmuZy1KFwHPmnzAXVQAcZ9H+mi01QX8CSbRQg8b/SKZp1e0512X4JVrcoohn9Z/XFIE4YtNtEqDmXS9rri6IQfyFL4rLVLFlvv3N/kW7HDOECVYLxqWsTnanuXgPJgTZQho6uo8hsEL0hl9FqJLpdKD8SRT6uw/10cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162275; c=relaxed/simple;
	bh=dTUSH9OecqW2+ZNipjxSd9VGaZo4EMRNLjBWp67yS6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcm8ukaeJIyTXdswssui/gnFl8X41lKhKTCMmt5+OtVLMeSe7rNudhs5HhH6GZaO0vTKX0lanzMn26lTtzSi7QJMRi51uwH1mtk/imtFscr1S/3VWYM8LEBWJuI/QZGAhC3RdMqUISASydIGBcJhrPKIA28s0mcGrM5rPHiJA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=kxAHCmYm; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1752162260;
	bh=dTUSH9OecqW2+ZNipjxSd9VGaZo4EMRNLjBWp67yS6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxAHCmYmO41A1CPLnsUWIjOeExDrf6Fo60RDVLihjPDwshh3e5txG2UBnilGPY8Ac
	 3iZi4Nb5wgQoPombfyl0klPhTkvkLjJZKFldDfoce3GP+D/jPaJaUTbSB4IOTgogfl
	 qT38W5KqIeIHis+7Iru5mahliVvEc26GVWacZWtPGsDgxUI60tQaUlRhfNXH8gieVf
	 1lztzB+WE4QWFuzozoTvW0INv14fq7S8AnLfivZwuE32mSGTWGN0qSPoJYCau8B6YG
	 FWLNoU4F5V8sfCC2b07Qtsn5IZbcfKnu6AM8gtChs5+8FGFpgwPQ4C04RY7c13VUFO
	 plrdkinKl8ROQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AAE3A8EA;
	Thu, 10 Jul 2025 17:44:20 +0200 (CEST)
Date: Thu, 10 Jul 2025 17:44:20 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: emu10k1: fix "for/take a while" typos
Message-ID: <6fvir6xkdvdu4pfo7hcv7zucaxosxjqb5t7gklovzcglnfkvc7@tarta.nabijaczleweli.xyz>
References: <e4owjda3hf5vjc2237m3ctokey4qglfrciga6ho24bd4os5awk@tarta.nabijaczleweli.xyz>
 <87tt3kw26n.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brslyr4qdp7hsjhb"
Content-Disposition: inline
In-Reply-To: <87tt3kw26n.wl-tiwai@suse.de>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--brslyr4qdp7hsjhb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 04:28:00PM +0200, Takashi Iwai wrote:
> On Thu, 03 Jul 2025 20:21:29 +0200,
> Ahelenia Ziemia=C5=84ska wrote:
> >=20
> > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> > ---
> > v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2=
cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u
> Well, "awhile" is a proper word, AFAIK.
Yes, but these two uses are clearly typos of "a while";
"awhile" is used differently: you could do
-	/* Step 3: Wait for awhile;   XXX We can't get away with this
+	/* Step 3: Wait awhile;   XXX We can't get away with this
for example.

I left the "awhile"s that weren't typos alone.

Best,

--brslyr4qdp7hsjhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhv39QACgkQvP0LAY0m
WPFuEA//XLjIbIZqItbi2Ofqhqbo24PkMbKEjUfzT7iaphA5HloQo0/HVx3x4eIv
jlMlUGoX4Ex9n8zGaWGWUUT3VmmvhF8gGmKgcMnWZuKgKGg/W2SuImk/SvMAx7Q7
vU9UqzbNUU8htrdZIZD6ATTNHevy0pW7Kp6004n8NaQilO1dqIvlKo2mOtxe5GbC
+KqQWnMTE43vv6jU3JlC0wN4iES1gb37KV2o2UGZ96I1F0EATFKY38Gna7V7IS0+
8UyQ8XQ39lzqV1Jenh6Frp3NEsyBteDBduRwWB/oT4l6KgDVHtrKnUeWVGPVro8d
2qKr+/bkEOMp2CvUkp2ukKK2NoT97RdTmKJ2I7UHWqgg+hev1XLOOnsIf0sRPaVx
NPL8jIqHha1PkJTrTYFfDy1EYCNjQMaU/Cyw6PdBofQixndkgLGTN5BdCh9GEz9Z
03DXUwFYCt/fw6piMiqHrbsvPNNbGGA/KNgyY5tYRTyy06kgSuMy0IczJWNc0/lx
4kXIr/PUGEZWZUGGLpZ+lKLg2dToZeZ1Rrq0IJsl8MbiT43RYPIsxMKgTTqQMnOw
7L8qmT/yhDfOlXChQtGhkUrGNsmMQ8nQy25caIobDsjBsbtNRQ9PknatT/yUemSG
2uxL8Ejk7Y6cNHpsa9X6PLqr68ZNFM4q8jQGpxQfB0ODRiLAfKo=
=gnRl
-----END PGP SIGNATURE-----

--brslyr4qdp7hsjhb--

