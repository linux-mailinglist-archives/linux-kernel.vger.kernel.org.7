Return-Path: <linux-kernel+bounces-747019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB1B12EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007ED17A065
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F21F1315;
	Sun, 27 Jul 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="TqBK/tWZ"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AD8BEC
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753607278; cv=none; b=nuIWjlyfEvYfSF1Uqv1ox7/GarWSblX0s4e9LeogYve1BWqocY8+YWq3w0DOzoQNrYXvRwanA7P4xmDHBtDHacxwDwi/pWXCnRfxzdtyMqY5/K4UFpAec5x+6k9pCg6BeznjaSRaEZGLs9YSDeRVXa7sjWZLYy7dm48U0q3gVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753607278; c=relaxed/simple;
	bh=GnwMsDKTf34flnXrCg0wNVdd44JAIEy5jC+eYRn/BkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqHCC8q9MJN2YdmKpMrstNg7TkZ5p3v/r1Wz8Wu6F8R44o56a0nDvhlMoYICSEH8rEttJrlOccPWqg/QuqD0RugazoFlpzhepp4A+8bfOtBWAfVVgfF/o9LMP0NXEM10HE8ixmShBZlqoKYZzhalzK01kbC44PC27jyT4dvzxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=TqBK/tWZ; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AB78F1C00BE; Sun, 27 Jul 2025 11:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753607266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGqlMLBpbziDNh7D8SEBoRYXtK4P2+gUllzDqRHjkL0=;
	b=TqBK/tWZZGZH6A/pio+slzDujY6qJrUpuAdgmAlvLqWCe0cehXcXbk8BNVJm9Qqx0tZzMm
	hG1bVOSFncNasTUPRZvw2Q5DSuq9SO8S0BAFYNu+haJ8r+LRigsVgH+Vm0XtVIwlhBHFZT
	ggVrRqtMoG4779AqYBN6XD6pZC1L/yI=
Date: Sun, 27 Jul 2025 11:07:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "conduct@kernel.org" <conduct@kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct violation complaint
Message-ID: <aIXsYh9afmTxiqXF@duo.ucw.cz>
References: <13a6b8e3-a35a-425d-bafc-006e0a52599f@linuxfoundation.org>
 <aHanGu9nOGOegUg2@duo.ucw.cz>
 <878ca180-c54b-44cf-aa14-cf6028723167@linuxfoundation.org>
 <ed6f49c8-d47c-4cf9-889a-76f6886e1a86@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a3mZm8D+kLTkV05e"
Content-Disposition: inline
In-Reply-To: <ed6f49c8-d47c-4cf9-889a-76f6886e1a86@linuxfoundation.org>


--a3mZm8D+kLTkV05e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2025-07-24 13:18:16, Shuah Khan wrote:
> On 7/17/25 10:32, Shuah Khan wrote:
> > Hi Pavel,
> >=20
> > The Code of Conduct Committee holds these conversation privately
> > with the people involved. Looks like you cc'ed the mailing list.
> > Respecting your choice, we can continue this conversation publicly.
> >=20
> > Chose one or all of these threads to apologize to the developer
> > directly.
>=20
> If you haven't already done so, chose one or all of these
> threads to apologize to the developer and cc code of conduct list.
>=20
> >=20
> > https://lore.kernel.org/all/aG2B6UDvk2WB7RWx@duo.ucw.cz/
> > https://lore.kernel.org/all/aG2ClcspT5ESNPGk@duo.ucw.cz/
> > https://lore.kernel.org/all/aG2BjYoCUYUaLGsJ@duo.ucw.cz/
> >=20

Please clearly state what committee believes I did wrong and what
should I apologize about.

There are clearly multiple actors behind Sasha Levin email address,
and one of them is clearly LLM, sending hallucinations to the list.

Unfortunately, LLM and the human identify them in the same way, as
"Sasha Levin". I am willing to apologize for the confusion, clearly
human is human and has ethics, but I'm not the one who caused the
confusion.

Please explain how to refer to the human being between "Sasha Levin"
email address.

								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--a3mZm8D+kLTkV05e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIXsYgAKCRAw5/Bqldv6
8hccAKCwvuuNJjvG0ueOlgf7iJXIO4ptTgCdH23Ef1XKD36yzUZ4W96GntT4zwA=
=4GHx
-----END PGP SIGNATURE-----

--a3mZm8D+kLTkV05e--

