Return-Path: <linux-kernel+bounces-784043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5DDB335E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6C3189AC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666FB27A92B;
	Mon, 25 Aug 2025 05:43:56 +0000 (UTC)
Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E020322
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756100636; cv=none; b=If9CSNPyxIabp7yb3x+lcasV6F+aK62QbSDuexoAP4sWth10MbH4OaRDP7vKeQyJd+MyN2SytbtUc9L8+PRWV2GAjGDmb2ZB0tcqiuYVXJHUqBnWVm+JnkThaj2dIU212mMszeeoAQIHIUwlvlGbHCbQdsBm84Y/RMiYnQkOYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756100636; c=relaxed/simple;
	bh=Ws6kvbFtbbWctZQrZP2eFTvBGzGf65aRDpp1X6SvSnU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=N0lO+MOw+JjCqVW/EqMRKndddFyfyuS1IhO01rLUUC5x27D+29IwzltLgaQSJB4ZAAFXGIfm8yVgjHd11Ys7hEeAUdFozrscj0h+EjRHoDtAf8Eqem9lff6xnv6jLfW7+sWd7jxaVSnhfLnvoFULJHinXM+PChBnvVLnotpPgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [10.2.22.152] (4F7A3008.dsl.pool.telekom.hu [79.122.48.8])
	by c64.rulez.org (Postfix) with ESMTPSA id D824B1020F;
	Mon, 25 Aug 2025 07:43:38 +0200 (CEST)
Message-ID: <ce7512a9-434a-9769-a2cf-af291fa9fc64@c64.rulez.org>
Date: Mon, 25 Aug 2025 07:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-GB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20250821035533.8206-1-soci@c64.rulez.org>
 <2025082128-appraisal-wince-844f@gregkh>
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
Subject: Re: [PATCH] vt: monochrome mode with 512 glyphs
In-Reply-To: <2025082128-appraisal-wince-844f@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2uQRGLs0nM4FacAIzI7JUj0E"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2uQRGLs0nM4FacAIzI7JUj0E
Content-Type: multipart/mixed; boundary="------------qWdNGiBAKHj3pxkyehDj4nHt";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <ce7512a9-434a-9769-a2cf-af291fa9fc64@c64.rulez.org>
Subject: Re: [PATCH] vt: monochrome mode with 512 glyphs
References: <20250821035533.8206-1-soci@c64.rulez.org>
 <2025082128-appraisal-wince-844f@gregkh>
In-Reply-To: <2025082128-appraisal-wince-844f@gregkh>

--------------qWdNGiBAKHj3pxkyehDj4nHt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> For some reason you didn't cc: all of the maintainers and the subsystem=

> mailing list for this code :(

Sorry, will do next time. Checked the linux-serial archive and now I see
that it's also related to VT.

> Anyway, this is anything but obvious as to what is happening, can this
> somehow be documented in the change to make it more clear?

Thanks!

Meanwhile I've thought about the problem and this patch was not the
right approach. Lets just forget about it.

Instead the 512 glyph handling in fbcon needs to be done differently. As
far as I see there are already fbcon specific hacks in the vt code
related to this and it'd be better to remove them instead of adding a
few more.

--=20
						    -soci-

--------------qWdNGiBAKHj3pxkyehDj4nHt--

--------------2uQRGLs0nM4FacAIzI7JUj0E
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmir9/0FAwAAAAAACgkQWOeEu4KftGtW
pQf/TypA6CZId7uJNtQ2S+Pj/bShxQuya+7wu1Wcd3jKk2Qhd86AdTltsqSMrqm/3l53qSvHgjBH
Mjnp4w4M008YnN2LMz763RCUvH77Rtrm34H6RvBpXo/5P7TvHoWJKwBy4uEPI///NJ13BEq7wKBi
VOlX6w1XNBxeX0Mrk/wi08Z2fBk+LB2DVF6oWN0p4UKFXlZF8ML6Y51QPj4yfaoJYTg6Pd6CW8Ad
ShkvEFifD6QgzWTDXHNGruDNxYNYUaAnJCELTJU2M8Ty4fLr+bpMu6AwW1Dfh31AOHKZwcwRRf8V
lHxJsh9LUC/aQ5Uq5iACw7Gvdw05Hp5ZKCEZGTSH/g==
=sMMg
-----END PGP SIGNATURE-----

--------------2uQRGLs0nM4FacAIzI7JUj0E--

