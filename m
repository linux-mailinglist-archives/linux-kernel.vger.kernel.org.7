Return-Path: <linux-kernel+bounces-747251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E2B13184
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE9D1895B2A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08571221F1F;
	Sun, 27 Jul 2025 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BU8LBQyI"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0F1339A4
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753643972; cv=none; b=rol9n4cS0VojyIv/OWXRdYfCyc1dGG22yzB2J2gw+zNExFZ9DL/mp3cHGQsiKbCJranHOoUl66BQFxU1XQT39iaOTHM57DovFZcS1l64lhLgHcPL+s9uHIMBcqso11FVfRrDVpe4NZPupMSeEPeE0F9Co9qwT2f1Lh7jICTmswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753643972; c=relaxed/simple;
	bh=ztYiGy3+7mgr3Fd+CwaCHa0nYPTY1bXxoj2f8/g72Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVu5vsCnTAIFvBeoXoZ0WOfBfgMGW2BicU64a0MxqKKwrfK4r9rqUAOJlmdcYi3XJUrXOoP88/x5SPcN5WwmJ/sUYZ5oAZUHrHqgeBe7Wm1Ogi0QbsQrhvjHjk/BeceLBMqV5tqKrooP4xmaH03ZEQJVkVmQyiJbgY0l5zeQjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BU8LBQyI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Jul 2025 21:19:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753643958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9GWF8rNG8akPtDbJ/lNUv4QDo76jPiyUFexMIYmx0LU=;
	b=BU8LBQyIhp+WhPfELrOlLabJ2pN71iEie8mzsZZx3WPzw7y/ZpUY2O6fCxFo0pab/ma9Ev
	iJYU/CqYq2Hi7oVe2WHyP3BtgD6vJ99+XWj5fBVy8jwGDaWQXs8oq2WvhwOI/u1Sa5vCJN
	EYtvc6wAVxgNp016Dzy7KJDJMxT0Jpc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kconfig/lxdialog: replace strcpy() with strncpy() in
 inputbox.c
Message-ID: <aIZ7sDZdHAOg2cf_@fjasle.eu>
References: <20250727164433.203775-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YAOLI7BQYiKPOH73"
Content-Disposition: inline
In-Reply-To: <20250727164433.203775-1-suchitkarunakaran@gmail.com>
X-Migadu-Flow: FLOW_OUT


--YAOLI7BQYiKPOH73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 10:14:33PM +0530 Suchit Karunakaran wrote:
> strcpy() performs no bounds checking and can lead to buffer overflows if
> the input string exceeds the destination buffer size. This patch replaces
> it with strncpy(), and null terminates the input string.
>=20
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  scripts/kconfig/lxdialog/inputbox.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Nicolas Schier <nicolas.schier@linux.dev>

thanks for your contribution!

If you want to continue contributing, you might want to check-out tools
like b4 which simplifies sending and tracking patch-sets.

Kind regards,
Nicolas

--YAOLI7BQYiKPOH73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmiGe6QACgkQB1IKcBYm
EmliRg/+MkySkX4RVY0MXvI9OP3bqK7rbDXXv/RMGdO32+QMg2zrfWK5K/Hb16yZ
7u8fgI+zwBZqUd6cy+t8MIkavuhKMotKddMA9msgqvwLpCrNpZTc/Q69te/9wEYP
97LHWNwz8TceKpHx2ECYOMc0qHE8eAE/p9H5ikl5hXJ9fDIckAnumZOBxM20grka
ugx+ZHND23txayBmVFhuTb1O9vWjRmB2bujQjvlGckpP7ZaIJFXfFLl3k5/Cpybt
qHflLMRN2jTq4ephO/1zklMbtF1CugyQFlUr4BDhRAKZEDoHyLOu1KM/+pWH1qXF
dpXLwDGBlsy1GrF6Iu3U0CrrM1WCeqaybuHreWOkJQcv2jMcUp+JJXZgNKXq4ign
LRCWt9D0uNKpfoxweZO+37qLDHfNM1b5Gx6FX6TMoP0RSrsn6lAdVOjbEafN5aaX
+Eqp2borPKWLV0r8+RDOeMLMX77XZ2Y/xHgZw/h/ILfpri0vK9sJ3EJe1Hz4w1gD
MTbkI+QyGwUCosKmDxSELzq6hOJhllXzwVkXaz+aXaWUw/vivppfRM5VXlif/KJ0
He6t2GCR+eyNOHA61SuJlmYiJ/pesJvq6jOr+fGzVpi21VSZxYLYVxOTDAKEF1ed
NOd8YwI/dDcI9AZZpxL99I69e/s6g9WLIiruX6BO1unXIvY97hE=
=a1hJ
-----END PGP SIGNATURE-----

--YAOLI7BQYiKPOH73--

