Return-Path: <linux-kernel+bounces-742786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628AB0F68E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C0B7BC884
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D092F546C;
	Wed, 23 Jul 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="HfMlW5fh"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07792F2C5E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283172; cv=none; b=Tfu3d3MQKQ1ieGhU/I+FNqx+0vQ2I9qjBvadna6ERfTo6Su0XSUz1oGF9/ql6MqOD5nesctfAq6oDHiU6iG+VleJhtf5itTINczNdzmGa3jtLJslXMfSdNw372+ews24eIVivU+PzHd/8ZvqInIuJmA8spwcit+qsUEi9Lzlq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283172; c=relaxed/simple;
	bh=dRWZdtAK6w39sv19LxwgbfwbwlfAwdYRs3fDVwV+UzA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD1M15q/JmBALTmaoHwzHo41guWz/6qILJSFHolyG8aV2xh8LFph03WAzEhrEMnIx0BUfnaNQQDQrrsJZQJ+Zqbvr2FBh26EVzUsWLCWtWtoXJPYTftj/ykLgOPcM8Lh7kc+QM21H5hbSaa+a+otyRJygm2AumTQyxB9owfWxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=HfMlW5fh; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C0C5F1C00C8; Wed, 23 Jul 2025 17:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753283164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ydhu4VXeK30HD2uypekWNP0LKvU4XTcAXNkCbKflms=;
	b=HfMlW5fhPqWu/Yh+ymtSDmAHlyWZX/5RlTD66uj3MBlzeql5yaZyaouHjIUHbTgCYn6Uqm
	Sx7cuWZU8w6pyFZZeSETk1fE7iwbS1HNdRA21NcIXembfNT5BKoLXd2EPaW4PMk/87Jd0Z
	OHkWDEq7+Hrr44LXK+0NkLuYSM2uZIU=
Date: Wed, 23 Jul 2025 17:06:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com
Subject: Re: 6.16-rcX: crashing way too often on thinkpad X220
Message-ID: <aID6XPLXuGo+ViTm@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//1BzA5bNvKrpKfL"
Content-Disposition: inline
In-Reply-To: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>


--//1BzA5bNvKrpKfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have had 4th or so crash with 6.16. That's not usual.

Two more crashes today. Last one was with 6.16-rc7+.

Ideas welcome,
								Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--//1BzA5bNvKrpKfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaID6XAAKCRAw5/Bqldv6
8vWnAKCG3cpxlsMfFy/D0oIiMlXwbmzSBgCgvjaFmLP99HPXArPYgI0x84M7Vgs=
=/Tcy
-----END PGP SIGNATURE-----

--//1BzA5bNvKrpKfL--

