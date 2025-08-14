Return-Path: <linux-kernel+bounces-767935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA15B25AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D065A7ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0C21CC59;
	Thu, 14 Aug 2025 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FCjjvweP"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65971D5151
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148398; cv=none; b=UokdxAk0GjS6wgyzCZrE9/k2BVlW199+8piwD8L6qUrW0IzHYUhCHtXTGo87jsPq3tUWV5JxpyJ0LKVG0SERfyPV39LdtCvEwLx2VD/uv5K4NCAAq0Q5MS4TBZMlAKxl3r2EHWQt0UKDW9KYfB2k2a6aF47oAtYzhfryMqbgkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148398; c=relaxed/simple;
	bh=k7BQOJKsWTRVbsTyj8wE27+ReeJC9Y/WsWlZgzIGoO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l26wM/VDEDSPdujupho56VFZcWEdakyD0uhUZllZqg083I054htyQAOOqMBa3CU0G7ldx3jEWyrJBX4+j1iBAVXxKXDq1i/4LNXdE8WY/05PNBQFqcXUG0UTuLEznBWW6aFo3P1min4HaOVB98uIfBALK3pC7YAjRxBsf82SUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FCjjvweP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7322da8so95972166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755148395; x=1755753195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOs+Ja2LywqReJC9686EhsUnOQ6QzXRLXHcqfrYvThc=;
        b=FCjjvwePwZ2mhuucScjnjn68NRhkzBNKMlIdyRf5y6AxrjHQUi07I1Or7rMDz+zQHl
         jtVNBrD4S+gB74F5wnu2qtSXOPExGCbb+JTxot53WZTiSMl0aS0WTISMK/737/1s4344
         xMJAtGWsBw/vBV4QjVmMShPS0soDQ/7rKSWug8TIliJ0cMj7vDiLWxqq2mkoOIQhd/YX
         wqdTBzMA7LIrUJJu5+7JHw+BJTjHlKzDBhM7LX/KgcqEOnbkDPvzzm1E7T51W2+1+klq
         4p5v4M6q/mPGhfGMHjiu1XCHNkaOMpfZecn63KrJpGzcEyHFs57aE4uINI4xt33IfwZG
         ZwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148395; x=1755753195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOs+Ja2LywqReJC9686EhsUnOQ6QzXRLXHcqfrYvThc=;
        b=V+HtBk8b8nPw6dtwWlPStregvBPZn1vhd+5AA1Hlt60mEPelcPAN3t/ID2hpVAcO3E
         vab1CKRjspVP+ZNz6U9z+br/zWxV3C4pI3YvrHLxnYVPNV0CWqbOfeWo281oehsd4Fo4
         f6RuHalaQKRNgMialvR+wdQ1ivv78RfCPwBrYZU7MQ2K77jnzstMy9nIjNnvpGB8uj4U
         I8R3kbvI2U5ffS4Y6ZnEgWai7NbDvvc8gWO8lsEaUYynQqR5Jv/lAi6cXAyRTuPse/bI
         qiTIGYSP6BHMKh6GToTmAhst2A64pokF4YB1sSlT8Cu6hfkRuKSAHc11h+l8LByDqhO7
         JPTg==
X-Forwarded-Encrypted: i=1; AJvYcCW4h1/B3PW9bHNtcuKp/ohlnRYyI84S8qSC8oABl4S1A84zEL9HwCel7RJ+aq6dPfVHwzE2BU6wFeZ92Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbBhcnhhaCCR+wlnjQkxzSNKK08SgX1b88m973qv0fjsGPeps
	7GhCowRyd9vpQ3RuhhMuA6iFQPWZqY+1VCo4l+7zr4sPaMLCczguZ1oImG1rc7h2s5/E/sOWZQX
	ljfpD
X-Gm-Gg: ASbGncsa9CtF5b0As8mesFpHv66Ahv5WLiE9pVlh5kHTBcgFo+Urretxd3mBuDFCGRR
	1+jdHtrl+xV54Qvme5AP3lk9ErL20Z3u373PX5hh6hhxFzgOb8i4ELV1nF8KqcmfDk8Hb8P9otR
	eiMX+3hfSZpTzjyRy2TFR+OLFPhKW9JP8ggwDYn9ZsOno/MF05p6I9tKtUFtngW6j4+5y43WrmQ
	F/AAtforoFA5yyzuQGA7mnDrK9lL9vrzJz92vHOw83m6kuowvzyQBujf39fhtcvDm3hVqo4j3P9
	nwYu6Ym4NCtoNTF2mw82iLuu7cN4uKcFvY7OHsqm2DVvXRmBDuGaIhIMq/l6KcOtlbMIAU0Vt/d
	jK+VXdVQ2kiJjQbwB8J8ceURDqO0=
X-Google-Smtp-Source: AGHT+IE21Fscsduu8A2gVWCDMuP+3BFd0qyr2OthVuaxd9+6x6FL4+ivV3/eWrrrt5/okGohfJQ1Gg==
X-Received: by 2002:a17:907:7243:b0:afa:97:55e9 with SMTP id a640c23a62f3a-afcb98c0441mr149870466b.36.1755148394806;
        Wed, 13 Aug 2025 22:13:14 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a078a28sm2533359966b.3.2025.08.13.22.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 22:13:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 07:13:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 resend] pcmcia: omap_cf: Mark driver struct with
 __refdata to prevent section mismatch
Message-ID: <c5agcvxca6z7fb6eqwlrqq4232toncpfuu5frds3ebsbht7tyz@7lpkvzl4lyxi>
References: <4937807c9d70644fae705459f36574bd24846d31.1755099931.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xpccwvq7aahfhfvt"
Content-Disposition: inline
In-Reply-To: <4937807c9d70644fae705459f36574bd24846d31.1755099931.git.geert+renesas@glider.be>


--xpccwvq7aahfhfvt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 resend] pcmcia: omap_cf: Mark driver struct with
 __refdata to prevent section mismatch
MIME-Version: 1.0

Hello Geert,

On Wed, Aug 13, 2025 at 05:50:14PM +0200, Geert Uytterhoeven wrote:
> As described in the added code comment, a reference to .exit.text is ok
> for drivers registered via platform_driver_probe().  Make this explicit
> to prevent the following section mismatch warning
>=20
>     WARNING: modpost: drivers/pcmcia/omap_cf: section mismatch in referen=
ce: omap_cf_driver+0x4 (section: .data) -> omap_cf_remove (section: .exit.t=
ext)
>=20
> that triggers on an omap1_defconfig + CONFIG_OMAP_CF=3Dm build.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

--xpccwvq7aahfhfvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmidcGUACgkQj4D7WH0S
/k4qSQf+N2OQhVnGMcoElMAvBwKbRCYoXFuMOt9VpW03suQ+ZcmFQ0WmQou3haZQ
IN7houqborh6Ue1EGpUzlzDurVsTzGE+yD4buFiPzbUpJmjg9Cr6OUeC/GXqLQOg
Gs00rX2Xe1norafY8hDLFSbZHW3qENC7bRrRFkTCN2Gc0FaBiGNWNllE989SBoqT
cwn8PzptDWqd7o8clOUBxZkTQG4j94H8WMgHHNDVbtWVra5Da4i57HyqWSCRbDZ2
EBIwnC9shX0y8FwwQGwVQYteqIzn8ThU+C7vuoZ5+mV/L+E4o0Amc0xSzCs8fIZB
S4Ho9JpdVDD8G2HV/ezYADHoQIBWfw==
=su2q
-----END PGP SIGNATURE-----

--xpccwvq7aahfhfvt--

