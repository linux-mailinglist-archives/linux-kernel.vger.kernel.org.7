Return-Path: <linux-kernel+bounces-866989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D3C01460
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDDC18C7BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236962F6187;
	Thu, 23 Oct 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="v9aQQmSA"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A02F7461
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225185; cv=none; b=L3WGXeE9c3WI8MIzF8HPdRIGUPirjJw72IQYCmUr/urPi4/1pUp162WZ8ocTX5gcQDH28Zrj9ixTOgVdc+2AL96jIuITunTcqXbZidYqsSXq04q3LAMQZk12PTxEsm3X+XMOxD+NmBT6nsXkJ3Y6DgzGz4kCkEiEtMcN7rHVxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225185; c=relaxed/simple;
	bh=llbnfOMyD81NXw2EcalQre+Lwdfs4auBXB+ClL6MjSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ewTP+G/C7vDAxIJtZpPgrZEwTa2gEjlL1Rg/4mY+T+Xzt6TKzwj2mnabZMaez4gyfP6jLxs2CS+3duXudJ6Iur5Ogd0IxApvbIi2WRXmaPwZ0arHhRIyanBIFJhgHj/Rr057UKnVbZ1BCWsVuWDK5W3TNV5kB4zJTIFruk9OE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=v9aQQmSA; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id AD21668C285;
	Thu, 23 Oct 2025 15:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761225180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSofLSF6r8eXmgKWVTiKlhq6YjPl7KjQf8QXfEfDH9s=;
	b=v9aQQmSA0Crh+4iLonub3vzv1yRPoRHQUfn0YLOVJHcRiuVA6lSHc7QnTyeH80uVsV1oD9
	gR8/KunrqsQ03YWZ6F8XJgNBOGv1SihNqNdq8s0DI0lH9YJPsKwDt2C3GToE2xEyL3VYfK
	vlQwpJKOJ498kdja3qrV9qCHjScPY50HWmGx1G+AWV8T83l+tloQUescdoLwitd3JmhkMO
	DN03gvCa44dDDvNOc1BkSL8v2z6woFvWk4+s6fUs/6XPDEa0cL0ZzO8AutOb2tsLgsK3L3
	MrfuCluoVNV0+uIh25zBYx6Lrz0aAOk/vYJ7bcA+6cJOexx8gUdRbCIffRZSaw==
Message-ID: <833a6495c2b16e1da90c19826839191eec21e6f2.camel@svanheule.net>
Subject: Re: [PATCH v4 2/2] regmap: warn users about uninitialized flat cache
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich
	 <dakr@kernel.org>
Date: Thu, 23 Oct 2025 15:12:59 +0200
In-Reply-To: <9b5eaedd-f068-4209-af4a-215716e279a7@sirena.org.uk>
References: <20251022200408.63027-1-sander@svanheule.net>
	 <20251022200408.63027-3-sander@svanheule.net>
	 <9b5eaedd-f068-4209-af4a-215716e279a7@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 14:00 +0100, Mark Brown wrote:
> On Wed, Oct 22, 2025 at 10:04:08PM +0200, Sander Vanheule wrote:
>=20
> > +	if (unlikely(!__test_and_set_bit(index, cache->valid)))
> > +		dev_warn(map->dev,
> > +			 "using zero-initialized flat cache, "
> > +			 "this may cause unexpected behavior");
>=20
> Please update this to have the error message on one line, it's better to
> break the line length limit and have people easily able to grep for the
> log message.

Okay, I'll turn it into one line.

Regarding this warning, I've noticed it confuses the regmap KUnit tests par=
ser.
The sync tests with offset registers at 0x2000 read a lot of uncached regis=
ters,
so that results in 10's of thousands of log lines. The test itself is repor=
ted
as passing, so I only noticed this now:

[15:07:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cache_sync_m=
arked_dirty  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       =20
[15:07:47] [PASSED] flat-default @0x0                                      =
   =20
[15:07:47] [PASSED] flat-default fast I/O @0x0                             =
   =20
[15:07:47] [PASSED] flat-default @0x2001                                   =
   =20
[15:07:47] [PASSED] flat-default @0x2002                                   =
   =20
[15:07:47] [PASSED] flat-default @0x2003                                   =
   =20
[15:07:47] [PASSED] flat-default @0x2004                                   =
   =20
[15:07:47] [ERROR] Test: flat-sparse-default fast I/O @0x0: Expected test n=
umber
7 but found 8
[15:07:47] [PASSED] flat-sparse-default fast I/O @0x0
[15:07:47] [ERROR] Test: flat-sparse-default @0x2001: Expected test number =
8 but
found 9
...
[15:07:47] [ERROR] Test: maple-default @0x2004: Expected test number 23 but
found 24
[15:07:47] [PASSED] maple-default @0x2004
[15:07:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] cache_sync_mark=
ed_dirty =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If it's okay for you, I would change it back to a dev_warn_once() with a
test_bit() check.

Best,
Sander

