Return-Path: <linux-kernel+bounces-732871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92478B06D10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9DE189B563
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A1273807;
	Wed, 16 Jul 2025 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="gKt7KU8w"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265415A85A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642867; cv=none; b=g5Gl7W/hTu4KKAgOXiA62Okp7RBRvwTMEgGCCj/EWWJAL+VXjoJZ0GV2eaLOY9zmeJOQERgsMqVSQkbhMksrxT4poahxWg6lNXzJMDaNnPYT91XjYq/Xgur669f0g9QFJbYXXRHYhtBtQnY5g0imXRA8hBgA66GcB29nggmvzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642867; c=relaxed/simple;
	bh=VURr06Pbv09Wy8Ezi3pN19cHBhNZ5DqK3UF4UBcANjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRaTScSsqr68b+ybKkOjcYtWuikYYFKjEZm3Ce7TWUK7HydlHdvr+H9vMZ0FaRpOAyzaRbPZSxcLQAPwoFH42LLkjrVGPDCVBsY0nEoFcNaCiR0vMwbImUIO/961uQQN3uiyL0gcQauxtf8lfXWe9J/EWfgB4qzQt6rIO9c6c+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=gKt7KU8w; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4E2A31C008E; Wed, 16 Jul 2025 07:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752642836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tD3ytvT4byQdBjJAKjFVmfx82og5NRvAZdemf4OF+zY=;
	b=gKt7KU8wDUCVFZwE4LEmmEGwbVYmjTREj5DDQ+RXfO2hqIJXpTJDlzMYhnm6AX8QryOBd/
	0u37pLa/xPawUoLvKyQGpD2NYyQgAWXSzTsUu7pQLJPu4tLUcGH3hlMuSLcZnM6qM7ev4b
	gQiTIfYTyE8CsM1KXUhNZUUkKpmqslI=
Date: Wed, 16 Jul 2025 07:13:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: E Shattow <e@freeshell.de>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Are LED functions strings or uint32 in
 Documentation/devicetree/bindings/leds/common.yaml
Message-ID: <aHc1E2xPMfvKYcYx@duo.ucw.cz>
References: <91d71a35-bb22-4482-8b49-398899ee37ae@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F35NCqBD2fbLx0zU"
Content-Disposition: inline
In-Reply-To: <91d71a35-bb22-4482-8b49-398899ee37ae@freeshell.de>


--F35NCqBD2fbLx0zU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Documentation/devicetree/bindings/leds/common.yaml [1] describes a
> uint32 but the $ref is for a string, for "function". What's going on
> there? Also what is the reasoning for that sort ordering [2] in the
> examples, are we saying that gpios is like a register and function or
> default-state is a kind of status?
>=20
> 1:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/leds/common.yaml
>

You may want to cc devicetree people and linux-leds mailing list.

Take a look at include/dt-bindings/leds/common.h, LED_FUNCTION_PANIC
(for example) is a string, so documentation looks consistent to me.

BR,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--F35NCqBD2fbLx0zU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHc1EwAKCRAw5/Bqldv6
8hqeAJ0QgUOzI6h+3+SDCXqMbqmRTLClEgCglnd7H+8z2wBuL+PVxX5h6qAz1wU=
=H4Zy
-----END PGP SIGNATURE-----

--F35NCqBD2fbLx0zU--

