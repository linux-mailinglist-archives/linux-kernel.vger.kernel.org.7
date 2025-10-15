Return-Path: <linux-kernel+bounces-853521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A4BDBE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A531E4E8D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132731F5838;
	Wed, 15 Oct 2025 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkqF8iZj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F071F4634
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487077; cv=none; b=A+/mtB4EqBiL/S0l29fxo4pJMHYMHSD9D1qPMROlUXGpJoD9aObOnSdvQZADnwQlsKGhbN5Q+DA4akABglr+/0zwf/JzQL72rM9OviZJd3tGOY6UxTd3yjem9eszW0y/9/uE0C419Pf0bwF294Sbv0nweFEQdga00xZo063fB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487077; c=relaxed/simple;
	bh=s2RVCHRe5alWy5CclbuFKLZZf2xDKsC4eYF7VFxE3Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0VxjoeiGpqBXrN4PpyE4iB+kgh9i3xyY5aVY+W84GkMwMmmM63XLMyv6Jsb0VR/1kFHyJ2G+XUOvtr8MqDfIJePzh2Vf8XQL1LlT6YW+MxXqyu2voMik0GUEdw1X26IQD81I3SELkIbV3Boa/JXX9Iv/sZhJKuxkumwYx17uzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkqF8iZj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-793021f348fso5492658b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760487075; x=1761091875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4xPFj8ssp6jJtUcJ1VmKpw8CRVucsov0suJ55BpsNU=;
        b=jkqF8iZjLOFxKMPsOVMibyqjD9eAxsjKMrianXOqnqC6dTAZMUbY/ukWL78JuRc2CH
         51ZxtDOTC7IVbbCD9Gys1uYDyMROGngoTWCgqxXMKpTRm5SxfQG4FuwitunJivcNPHYl
         nCS0c144Ifbl4YzuXoTF/zxKqIx2+Q7y6d+6WkwuN+MbuRSKyzkH7Ac3nXz9SaZJKE6B
         uep/iGLjkMomgTBPn0Nn3CUQPlKyRxVVOXea7ao0KmeQ4JDbHm0rexTHkBg7O7hs+ExZ
         ahIg4lqR1VXz1ErM6q8t33Z2ZbCqyzDx2KTstwVgeIZ+G0eanKK5O/AFY04u7iKH9Zx2
         xcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760487075; x=1761091875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4xPFj8ssp6jJtUcJ1VmKpw8CRVucsov0suJ55BpsNU=;
        b=Xsr1upTFxrVtk7cK96t3BUpkFic19CZ7QkDm/TqMUfX3QmWr/8NTgf/29ki8AeRR06
         27Vzc5zwEJs+PpONrXO9HickO8thUcBm0kQHEQgqXiiG1sYCydMmzK9DHftFIPql7MHj
         Dv6WodFQgwkBvHhcLl3so3UeFAx3HOcJuJEFWX8sOSnCyuy+/0jpftecMT4r8Sq7uAu+
         qzUbOj7RZByoEYINYaM2h8JRVoIAfjthZKSrBteGVjhn3u3KHy7YovcoP1PBEyNawfTZ
         r7i4xNBzyKyJ7qLZgSLpcfLXwGx6lZAbtv7OneAzVeC/zFNQSrou/jRl1tWw8oMv8LlG
         RB1w==
X-Forwarded-Encrypted: i=1; AJvYcCUNkarwLtS31idJu7p5jBSPPeCh3tXmctQFoIbsG4JGCb5qDoGDCi9/Jo1/lRymL1iieV7t0yOD3bokZ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWDvo3NjLh/3Bv15rAG0oLYwhj0PdT3o6CtGvtfiZzsVfUIOD
	XOs48p9/3z1wYaylz3hEbeYO5B+6KWHXMz7ePcv2EBolB/W64JSX2bvX
X-Gm-Gg: ASbGncu3bAu6Q53L5z8fhFSch8vdVyH155fKSpqjxndDRv+ygNrSIEHzDziL6uNO6ZW
	CNExoaNEERguIvqORhd1UvkhTejVeQbCPsgyIE8YW+IhEPTXQX52eZcWIY/jOUCWesWD/8rE/fI
	Kv5odgtP/sksfgYISk7uKRbvmCIcg8LZ6ZuSLu4pOmh2G8pGhjJDWW/lWwPX7B8j7VXjKl043Fk
	CTR3tLnS5coBJLx8hHXB05cTgmcsd9bLIK/z221+ocRry8b/BlL2hp7IREr+CVuZCxexAhK2WhF
	ijPagEGgko48XElOVYswlBgXuBtUHVvRdCKhC4i6tSsZTdoAwfX5DHCXfPhu3ez2DJI1IUdst0u
	/6xhckwc7kLQ6V6CvRAr6PoJsa7OiQf+MZzA3/2nMHXNTw6maDtauNY8=
X-Google-Smtp-Source: AGHT+IFTkZqU6W0i9x4o7gHHf855IUQXK60dpfIB19LKQCkLF97EE2hReMjwVrJQ/kLGoXvNC2k8xw==
X-Received: by 2002:a05:6a20:a106:b0:249:3006:7567 with SMTP id adf61e73a8af0-32da83e39cemr36265067637.35.1760487074508;
        Tue, 14 Oct 2025 17:11:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67d7fbadf2sm4244123a12.16.2025.10.14.17.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 17:11:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 657784235ADC; Wed, 15 Oct 2025 07:11:10 +0700 (WIB)
Date: Wed, 15 Oct 2025 07:11:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
Message-ID: <aO7mnXCajeIdUYON@archie.me>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
 <87wm4xbkim.fsf@trenco.lwn.net>
 <d6cd375c-dad6-4047-9574-bac7dfc24315@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LIbl/zC8wYYsbIAH"
Content-Disposition: inline
In-Reply-To: <d6cd375c-dad6-4047-9574-bac7dfc24315@infradead.org>


--LIbl/zC8wYYsbIAH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:57:45AM -0700, Randy Dunlap wrote:
>=20
>=20
> On 10/14/25 7:55 AM, Jonathan Corbet wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >=20
> >> /proc/sysrq-trigger documentation states that only first character is
> >> processed and the rest is ignored, yet it is not recommended to write
> >> any extra characters to it. The latter statement is contradictive as
> >> these characters are also ignored as implied by preceding sentence.
> >>
> >> Remove it.
> >>
> >> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d30=
7@anselmschueler.com/
> >> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> >> ---
> >>  Documentation/admin-guide/sysrq.rst | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin=
-guide/sysrq.rst
> >> index 9c7aa817adc72d..63ff415ce85d66 100644
> >> --- a/Documentation/admin-guide/sysrq.rst
> >> +++ b/Documentation/admin-guide/sysrq.rst
> >> @@ -77,9 +77,7 @@ On other
> >>  On all
> >>  	Write a single character to /proc/sysrq-trigger.
> >>  	Only the first character is processed, the rest of the string is
> >> -	ignored. However, it is not recommended to write any extra characters
> >> -	as the behavior is undefined and might change in the future versions.
> >> -	E.g.::
> >> +	ignored. E.g.::
> >=20
> > I'm not sure this is right - there is a warning here that additional
> > characters may acquire a meaning in the future, so one should not
> > develop the habit of writing them now.  After all these years, I think
> > the chances of fundamental sysrq changes are pretty small, but I still
> > don't see why we would take the warning out?
>=20
> but the following paragraph says:
>=20
> 	Alternatively, write multiple characters prepended by underscore.
> 	This way, all characters will be processed. E.g.::
>=20
> 		echo _reisub > /proc/sysrq-trigger
>=20
> so it is confuzing.

I guess the whole "On all" description can be rewritten like:

Write a single character to /proc/sysrq-trigger, e.g.::

<snipped>...

If a string (multiple characters) is written instead, only the first charac=
ter
is processed unless the string is prepended by an underscore, like::

<snipped>...

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--LIbl/zC8wYYsbIAH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaO7mmQAKCRD2uYlJVVFO
o6ZYAQCwhB3aB0i96VC/SB/7tmP2XGyPcKpB3u3fe4lIlhflcwEA8e0cuJK+EduV
PcWc2iPDLvugWW7GlPMI0DUffFJ8bwE=
=saSJ
-----END PGP SIGNATURE-----

--LIbl/zC8wYYsbIAH--

