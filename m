Return-Path: <linux-kernel+bounces-816343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8371B572A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E841897F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F92D5932;
	Mon, 15 Sep 2025 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VNFC/sx3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898762DC790
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924176; cv=none; b=XojW29sjPDpORHCGfwHs7RxWZngLQgtKmZbPRyjGyBWrIUSistDiMmyIz6oFOOyZNwhYjwy0W5DWo56P578ggeAauRoHSSn4j3bHirjYTKmmG/VTGBHqQobCmr/+dJoxKpgAPIizMe6NfSABeFi/saz6MM5PXsl7OXDgD5B/ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924176; c=relaxed/simple;
	bh=6z3Z7C73OIfPX0yWv8b6RagZ5dQiDhHWZ3Vr7RGt6pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nen5w7svqDYETC93yDamzTyulnAI0TG9Mfkfj12uSCs8adYfjyjHCLJOdF+g+SLM5VFXBaHo9BsC3c12Joj9TIUS9hXrUzIPkGkAIu0oBXYpqG6UjFcyH0tqt2ofDvhY/4iz/gXkTORTmPjYosSgge5QW2M5F39A+QL4g9D/fOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VNFC/sx3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so36576425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757924171; x=1758528971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6z3Z7C73OIfPX0yWv8b6RagZ5dQiDhHWZ3Vr7RGt6pA=;
        b=VNFC/sx3wOPf30HWatJXU44uFJOVYqyjW5YVa7U99DcUiyJLnUHpeJFZ6Epq4Icljn
         AVMJA/7kFtHILGmFHSsgASYWlhuTcPnsi1Uru6klDxSycVhhYfW7vg5KFUoIB+B/dWmp
         qZ+h66DQ/jbwYU0sAkTxyaSoPGxDsbEvmTCMvM2w4SWkZGksRqVys0CTrRLf6Az4s+mO
         bDujY44ILbmrtK66WGXKhtvE5cRbWLcPvsgJ2NmRlQAUvWGnuRt6TWlsGAJI90J+wFCU
         lKiki8jPo80i4SNgT+Sbc04IOfCxe1lj3aUq8cD43RSDLk12dZIFdh1nPlIrA9a9Bs2R
         HImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924171; x=1758528971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z3Z7C73OIfPX0yWv8b6RagZ5dQiDhHWZ3Vr7RGt6pA=;
        b=ctov5/2jydctbfNaI4IZoQ+2Jik2YUFW5W9Sf7SWmuG7pe4ScGy61GvY9v5Vf8di1A
         b1e0INXCnr9hVKh9BfUgum/oHB3nSx5CwPKdjDcf4Vzrk/DLaNb9onp3TfK5OjlCA2Jl
         qvkN3X611bENo8Z/tERNiaqSXFiuKd3Ph2dVqlPYWQuzdhMkJQHcTJH879YOqvzxiXpL
         dEfhdcX7kpjqN9nrpQ/uBg4ctfHmlVm71hgZAWwmI4JBRR6fhmFLHnMTaJVcy0UKTeET
         KWGfKLIX4yRPdF1zuFjOP71KTdGocdlfPmIhnwYqlTJ0NgkXWJZGocvzNb9YKM/flKy3
         Opog==
X-Forwarded-Encrypted: i=1; AJvYcCUXcejX/W+A0m6+6QT8Jji1yRs4PcxmbMR2FK/dxSr6szNm01yaBQNk9sIylDONeFjzTI/kEnktI/08dqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLPKBC/e1fYgivKQDfXLDbrtFXj9ZUNY9VQzAoQCgqLPZ8A8lS
	1m0X1MyKN1XJR3lHOe+jva1UeLnyRsfEgOX/9kxcR7Olbvo7fukagVEbXebneKaBIkZTn75n48O
	Fou1Z
X-Gm-Gg: ASbGncv3pw1uTsDrqnEj3D23olNpXSv1MCrsG/g+nQf4bNSabY/hjYwHKPMe4D7b+0c
	m1c09f2SpJZjqA8HFS1OnVrkSfEQYHdkRFi4/QuyZ3S3PL2QNRD4s302vURVSNu8Ol5sRrFxhLM
	eSLYUhzAPAwAS03pE5G1iDAhqdaoiNzUw+BT8nUcFJj0j+Q9Ahf25YjdQ3ZwInabYNmCgTlKGoL
	hU5QrBVLCJ2VakyvFLN77JvCndX6BCASGo1neF89dn3vBPzxpK+af/zqGKC07drviD193S45pdi
	DIoxVJmp2CIaOeZYYcEdbAc4GPFz4BcQGp94rP9qWC8hvX8N99OtzYLi7tW6JI0OfkTxx3i0jNG
	cJ+2VrWB66eJgm5LFgA+96ub/cg+Dq5wsSPkcRqigjWXvxSrGiM9MpeOhNGr1KNvyFvA4uhYfsx
	g=
X-Google-Smtp-Source: AGHT+IG9ADJOGJHiLNHtmyFvsxdkRWhIY8D3P1njgd4vRiYHvm+bJsi1mseG2lcnGCAoPjHV4BmllA==
X-Received: by 2002:a05:600c:4685:b0:45c:b607:ea95 with SMTP id 5b1f17b1804b1-45f211e6054mr118534785e9.18.1757924170623;
        Mon, 15 Sep 2025 01:16:10 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f2abd2c03sm61731665e9.13.2025.09.15.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:16:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:16:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit Links [was: Linux 6.17-rc5]
Message-ID: <4iceeja4kbnb4cir26kme6z6wabnnyu6trc2qo7ye7po65wemr@i2tyg7cfq54x>
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
 <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ieuvb2krvmvozck"
Content-Disposition: inline
In-Reply-To: <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>


--5ieuvb2krvmvozck
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Commit Links [was: Linux 6.17-rc5]
MIME-Version: 1.0

Hello Linus,

On Fri, Sep 12, 2025 at 08:24:06AM +0200, Jiri Slaby wrote:
> On 08. 09. 25, 0:25, Linus Torvalds wrote:
> > So please: don't add useless information to commits in general, but in
> > _particular_ don't add "Link:" tags that only point back to the
> > original submission email. Yes, we have tooling that does it
> > automatically, but tooling should not be used to increase the human
> > burden. Tooling should _help_, not hurt.
>=20
> I disagree. In a bug-reporter role, I use these Links pointing to the
> patches every time. So unless there is a way (I did not find one), they a=
re
> very useful.
>=20
> My use case is (mostly) dig out the thread/patch (grep Link, and b4 or
> https://lore.kernel.org/all -> raw) and reply to it as it causes some iss=
ue.
>=20
> In a backporter role, I use the Links to look at the thread to see the
> _whole_ patchset instead of guess work from the linear commit log.

+1, after a bisection I typically lookup the thread, too, to have my
regression report in the right thread. IMHO this is really useful
because the next person hitting the same problem (maybe?) finds my
report easily. So for me the Link trailer is useful, too.
=20
> > Make the links be something *useful*. Make them point to the report
> > for the bug that was the cause of the commit. Make them point to the
> > discussion that explains the impetus for the commit. But do *not*
> > mindlessly just use tooling to create a link that doesn't add anything
> > that isn't already right there in the commit.
> >=20
> > I realize that people think the link makes the commit look more "real"
> > or whatever. And I've heard people claim that discussion happens later
> > in the thread that the link points to. Neither of those are actually
> > true. When bugs happen, people don't go to the original emailed patch
> > to talk about them. Much of the time the reporter can't even tell
> > which patch caused it - and if they did bisect it, we already have the
> > information - there's no value add in going back to the original
> > emailed patch.

The true fact is probably that *most* people don't go back to the email
thread to reply there (either because the breaking commit isn't known
yet or they just start a new thread). Yes, the few who do can probably
easily lookup the thread on lore, but clicking on a link is easier (and
makes sure you find the version of the patch that was applied and not
an earlier version). (Or a later version that the maintainer failed to
notice before applying an earlier version.)

> > So if a link doesn't have any extra relevant information in it, just
> > don't add it at all in some misguided hope that tomorrow it will be
> > useful.
> >=20
> > Make "Link:" tags be something to celebrate, not something to curse
> > because they are worthless and waste peoples time.

What will you do if a question arises on a commit without a Link:
trailer? I guess you will lookup the shortlog on lore?
If the Link trailer was skipped because there is no relevant discussion
in the thread that resulted in application of the patch, you will still
look at it, just taking more time to eventually find it. So while I
agree this is a dead end with and without Link: most of the time, not
adding the Link: doesn't prevent you exploring that dead end, but only
results in more effort to find it.

Best regards
Uwe

--5ieuvb2krvmvozck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjHy0YACgkQj4D7WH0S
/k5N0gf+J0xIkKyOMo83XBpgrND+XA1T0PnlsRJphfc7lnHDPQV2HVZochoTkgwP
8JgbyhmXa0JsXFshed2SNGs+j/nm9MAE2yMgbhfX1EngWBw1Lqr4ULmnWi59KNvl
OuPmkd8GX1BbU7HicPAB4aeD3673J5v4bOITad+FMmgYlRdOn7juXcUsOmmIH2BI
tBe5wPRAfMqkCOkVyR2UeXYp4j2V5+j2WoRaa6COQDW+/8wuMFJ25e0dNA2tk1YR
F4bo6I7uZVeD/AIrYIV3UFhFYXyyFH6Bqs/L/Rel2AtsvTLcSg6sNHTxVVjfbIRI
qxP6ybeBCe0DMXb3NYXIpKlqkZfrBA==
=dO9I
-----END PGP SIGNATURE-----

--5ieuvb2krvmvozck--

