Return-Path: <linux-kernel+bounces-822314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F957B83842
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD12A4627BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27782F39C1;
	Thu, 18 Sep 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q4rfbp7r"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26C2F3639
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184037; cv=none; b=mjTQWwH/kEWmKQE3u/MhGuAO1UYyIOzkXrTZcFcFJuaA+MyVrHZAeWGE0PxCvh4OxZbWtgi/cheYsKQY+R7rNWjy+JWHruJJCNuSML6eEqw33dpmsrpA1k8wOXZQo5LNofWEyz9m4iyeSl9aaPfKmbBeJiQuJAfSKerFRMB8JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184037; c=relaxed/simple;
	bh=5BWdCUVhgMl54mdDP/xU+5XGP400mdjKqPLvJzTg2ww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T/MV8HTUgRILenxXUt1P5n3uaWl/XcEyORT46wx0N8kFUQJAJqN6Zx9U1qV0GacXXlKqdEV3fQ/2GHdsrliFD8imH/L8+B0v/3k9PN1sMmdX+e4KWLuACcC3yBE5IhWsWFiLXhQXyk9KaZCJYSzXq6S931z9+2WH4rb9Lhj8NnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q4rfbp7r; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04770a25f2so106168166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758184033; x=1758788833; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sa9z20neKjSSRk4U1fV14+UBBimkf5dA7E4Cvonwog=;
        b=Q4rfbp7rure673IKimj//Q7ph3MNqAQ0rfbJMCcQ4fexJdiCW92B2gESic1QTkl3LK
         sUzRBf+b3Maz5TwL68uEX7pJE8yS2cl3TJsmKax+NhN8AMLtmY47AFTP/feg5DKSDYzb
         2BdyHMc7SQnTaxPySOc27wY5lvvfr1qhsGdKv/WSZQGUDOWsc94z1ukRtSrg7n5WBlv2
         I7VXxFjxa3zG7SDC129vFNdwtlN4Fhf49leMUsP25rtHCrKZi7bh7LDQwI1QtMqnl1ge
         b8fqeAwQK9ZJU0l6siYXMSttH5C6PaXEwYMKl/MWoYKuyyexFVV7u2scE6lyTwcUjml4
         HILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758184033; x=1758788833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sa9z20neKjSSRk4U1fV14+UBBimkf5dA7E4Cvonwog=;
        b=pA6788SKB5g3WkyyyprUjSQObr87zjpLMWH1UdRrknS+5mruuP7m5bYn8+B6kGenPl
         3T7i9M2V+DKI8ox5fQZXPHw0l1afeCvTXp53nwGuXK8fYf30/bcacYRyDjl1g0PyK0LN
         dmtu+tx2XbY2oYl3z5fL3FF10JD0TvQh4npMNZDv9re/mGddUcPGIuXLvo/qITg3Z3v+
         wY2t4qacti3gnChaXz3cOhl6sx0/+3ZVqtE1YpkuQUHuO78PjUMEOA7f+K+NAD7ez/wn
         Goj/ufP+tUWX9u4zFI79IKiMN80/cYh6Goz1kyCPKsk5/UYS7dUJ3i0laBfGcaZFLvz1
         KaEA==
X-Forwarded-Encrypted: i=1; AJvYcCWSDSGYnh9VXD5bFqwlacKyEs2t5Yh6iA7FhcV5amZKq7APtusWBqMi5SNh6mISISNIBeJTZ1/W9UD17nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OEYp1YAaG2172kLStAwuObf6eLlZkpov/P8VpBQgDuIFWzRv
	S3m2FLOOr8IjFPBRJ8mmqsOreeZNcomBMRdkLaQMv8GBvMEmNUDzqYS+9VAcrFTOFjo=
X-Gm-Gg: ASbGnct7V5fb/syunEpwlG8Blgp9haK5BNTPnAqbC60isdzF9J+NLoFnaGrFahnmWdD
	ACkxziv+XwOpA/b20FjNQVk34xnTNujRIf4pND/jr6eDFG0IogWZwRcsGsT3l798PqFZTi9kckQ
	E/u/c8MeX30/BkG5imtgiXx1kEsHRngbx7FCxTAj+EOj06/ul7FRrYp9Gk83Zfm+DNP+C9+AUia
	mUlayWstwEujyqlTuET1k7vmmqGlAJMD3frOGApLw+a7os+g63Bij481If7UYOgGz1dJimHmcGl
	S7LgDhl2huUSzONSe30WFaWRw2DkAX0yiyFFcSZ6hjrG8XUhSbsn1Jv2xYPDmbkA+XyRmrzUcOV
	sYkhdnmHbx/H1b8oup+0OW+biXxanN8v0gOgkh/SHWwP3ASAUUkO0ksHbmlPYsLdIZxWG406pQ0
	yG+8zDdSo=
X-Google-Smtp-Source: AGHT+IGBnD2D8NLypf0OnsVNbKwGHn+3LRsv5dy4NEtczgezIqLvFSmW8jLC63+HTC6WqjazqvdD0g==
X-Received: by 2002:a17:907:1c1e:b0:b07:e207:152a with SMTP id a640c23a62f3a-b1bb5599653mr545737666b.19.1758184032960;
        Thu, 18 Sep 2025 01:27:12 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f2702csm1016410a12.38.2025.09.18.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:27:12 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:27:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: 1111027@bugs.debian.org, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Sperber <lists+debian@aero2k.de>, linux-kernel@vger.kernel.org
Subject: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
Message-ID: <tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y6foxrfmz5qwgfvx"
Content-Disposition: inline


--y6foxrfmz5qwgfvx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0
MIME-Version: 1.0

Control: forwarded 1111027 https://lore.kernel.org/lkml/tfwuhg7fxlvb3iix2k4qqh74dcmwgcipprlehy7zlaz3btmtym@2x2vsccw5yzs

Hello Rafael,

Thorsten (on Cc:) reported a bug against the 6.12.38 Debian kernel
running on an HP Microserver Gen8 after upgrading from an older Debian
release (which uses a kernel based on 6.1.y).

The problem is that the machine sometimes just hangs, requiring to
unplug the PSU to revive it.

A key hint seems to me a kernel message:

	[Fr Sep  5 21:12:34 2025] NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.

(sometimes also "reason 61") that happens just before the hang. See
https://bugs.debian.org/1111027 for all the details.

I asked Thomas on irc if that rings a bell for him and he forwarded me
to you. Do you have an idea for a reason for this message and the
corresponding(?) machine hang? The bug reporter up to now was very
cooperative for debug measures (e.g. a BIOS update). I would expect him
to be open to support you if questions should arise or a patch should be
tested. A complication however is that the trigger for the problem is
unknown and it takes up to several days to happen.

Thanks in advance for your feedback,
Uwe

--y6foxrfmz5qwgfvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjLwlsACgkQj4D7WH0S
/k57awf/Wmve+7p/h7927XGe072ghLuke+nOHrHDrFC4gg7tkUiuSNdJSsMF3ySy
viQM9p0H9YqvXHNKvr8MpmzMfmD5w822fnodheu5V1iO2tVJFx29xuuaXJIxV4ir
XPaBFrVgxEw3jBjHM8e1bBi1Dn4vp2eVSzJljqyGaa0Sg+aGaDfusqHG9ilFe/2n
t9fI3tbEKES2TMAuOMPv/T1eDYk91NQ6x9uQgpCCWc+QK2QfMrEdS2gC36tR1Qnm
mgngWVSxM8FNvLMjBEexo8ggmCUyOmPHWLVoyubLWj4RdNYCEBOIny17vJlvnKoK
Ww+I9Pqk6Ee/NO9BZfKyM0iGAJHNqQ==
=Uq43
-----END PGP SIGNATURE-----

--y6foxrfmz5qwgfvx--

