Return-Path: <linux-kernel+bounces-783763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C99B33215
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B7E44257C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32E221FCA;
	Sun, 24 Aug 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="B4VU3iGT"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848F1FBC8E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756060891; cv=none; b=VKppAgVvyu1rUChkCkpJsYkeLaRJ/W+o2VeuDIkm1aWzgybeqvzZDzPu2kjKyN45x7f4g1uEHlYDu1v7e01UMez2mbEIVn9TWNfc72eUcK83c64kKQsLa8yki/tvUr3eY2g0GiI9zdvXutit5/gXwhr360GWZP9hjjBs8NUxXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756060891; c=relaxed/simple;
	bh=aldXpSXFZsf1b9WUi1tbuAPhB1ZbzKICQCaFkopUWH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R21Kta13jhXjZjbZQVGDhYRGsBxFk117ImgGSECjQLAnrj4rYBt29XRENQNsmrz3r84Kk4LBT3ppcgcZsWL2qLDB7ALO4yxdYkbgXB3GbTGG6oD+mv5tKvQJerXCOs4puOqu+hOJehidevrS3LoW8gaPV7WTVzHu2OHEBXiuw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=B4VU3iGT; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9666C1C008E; Sun, 24 Aug 2025 20:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1756060451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq1PAeKV1s4YmLBR80pZHsmgpoZjucg9Fy7oCVrjUFc=;
	b=B4VU3iGTH9nM/JqJF4J+vybBadFPzi6y5LR/UqbO4j3SefwKu6bw86OHvi0Hv4THWNA5LM
	Xh+5LbdIoGBkbgLUoj3Xl6l9W81w1Bwq6uM52kYhR5p1QB43MKEksANjoZXZNa9yTeWCWl
	ZoErlrdWU2y/VUduG+HDJh9sCQaBLPM=
Date: Sun, 24 Aug 2025 20:34:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: Arnd Bergmann <arnd@arndb.de>, soc@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Nobuhiro Iwamatsu's email address
Message-ID: <aKtbG1xk/8sbyHmW@duo.ucw.cz>
References: <1755663767-1612-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="moKA/m+8I1Jc/KOW"
Content-Disposition: inline
In-Reply-To: <1755663767-1612-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>


--moKA/m+8I1Jc/KOW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The company's email address has been changed, so update my email
> address in MAINTAINERS and .mailmap files.
>=20
> Signed-off-by: Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>


> index 4bb3a7f253b9b..328b04f82dac7 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -585,6 +585,7 @@ Nikolay Aleksandrov <razor@blackwall.org> <nikolay@re=
dhat.com>
>  Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
>  Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
>  Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
> +Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba> <nobuhiro 1.iwama=
tsu@toshiba.co.jp>
>  Odelu Kukatla <quic_okukatla@quicinc.com> <okukatla@codeaurora.org>

There seems to be typo (extra space) in <nobuhiro 1.iwamatsu@toshiba.co.jp>.

Best regards,
											Pavel

>  ARM/TOSHIBA VISCONTI ARCHITECTURE
> -M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +M:	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visc=
onti.git

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--moKA/m+8I1Jc/KOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKtbGwAKCRAw5/Bqldv6
8j3iAJwJWCnZC/1x6bmybPkhEm68FTqfXgCggl6QXqnEit2A6S8N/QTn8TOCtG0=
=trmY
-----END PGP SIGNATURE-----

--moKA/m+8I1Jc/KOW--

