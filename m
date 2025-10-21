Return-Path: <linux-kernel+bounces-862474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE531BF563A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E28E18C4BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549832B980;
	Tue, 21 Oct 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="FvyJ3XdP"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45D303A23
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037232; cv=none; b=RGpGNzaDvkR28JS40m09mrEXecIAeN7e//rypGVzYwIzAOyKoNrVrSHAuud74Dptzk72g46XwS80xsXneZWsP1JySR0qEJmFaJOmkhQ0r1cV3krb/PgewCFT9ag1LnhDP5pTXg5IT7lAScKo4TCo74zhzjx+dgy+COEUtwZ9/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037232; c=relaxed/simple;
	bh=/XlW3aS7vAxAi4hLZ7dTkWN9HWfNBsBf/kkXplXaTq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1lmijOMXTdUiTk1sq1QV813SSpeg+sqUqviFgkN0HoGKUdoS/QxrDf78/l4QErMkKP0u0/yZeYcrV01u1Nob6H+5Byi/zGJ9VMwqFuI5yyw3b3WO5XI6JyWB6wPfcttK+WnKXahmaGXLzK7yPGDwUIHN1CBrXDb7Z9RdepN7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=FvyJ3XdP; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 816F81C007C; Tue, 21 Oct 2025 10:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1761036775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dErned3ck4ttHaxx/p3FOt0HvYqgzyJ/HMUXhenkLXY=;
	b=FvyJ3XdPMW4mkfOJPWknVWswHcq1Yokmbns7wRV3Ntnl1i48gIrSuuSp2/Wy9EP97u5ngo
	shvIy9bTDFPOFJCMnjI5Ae7zeIH+Q/jckOMU5UZw0sO53QiVAqVkaAN4enkIAWWa4/9FEz
	BaIjnhyhK8qyo9x3BUR4ax+kEBW/BWw=
Date: Tue, 21 Oct 2025 10:52:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-kernel@vger.kernel.org, rusindanilo@gmail.com
Subject: Re: [PATCH 0/1] x86/power: Enhanced hibernation support with
 integrity checking
Message-ID: <aPdJ5kff1DD0ZSdn@duo.ucw.cz>
References: <aE/gS7r1mrllLSSp@duo.ucw.cz>
 <20251021040311.15214-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmNVwuxeVkagYk9J"
Content-Disposition: inline
In-Reply-To: <20251021040311.15214-1-safinaskar@gmail.com>


--fmNVwuxeVkagYk9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-10-21 07:03:11, Askar Safin wrote:
> Pavel Machek <pavel@ucw.cz>:
> > There's uswsusp support. You can use that to provide robust
> > signatures. You can even use RSA to encrypt the image but only require
> > password during resume.
>=20
> So uswsusp project is still alive? Where is userspace programs for using =
it?

See https://suspend.sourceforge.net/ .
									Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--fmNVwuxeVkagYk9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPdJ5gAKCRAw5/Bqldv6
8iP6AKCj/JzL43JRivJohzSjXUutEJtrBQCffcTx1yu+aJMV+BcIiT/OMgGIOaU=
=erIJ
-----END PGP SIGNATURE-----

--fmNVwuxeVkagYk9J--

