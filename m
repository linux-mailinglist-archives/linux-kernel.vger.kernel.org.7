Return-Path: <linux-kernel+bounces-723409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C170AFE66A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8EE189427B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D152BE057;
	Wed,  9 Jul 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/RbCtwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DD29C35C;
	Wed,  9 Jul 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057976; cv=none; b=gq/FjEJSWrlPGE3GcZZ9+hh4jI0diEgSiQrgMCa22silJMLEbmUyJpWTCvka4eyFhwe2C8wyP+9xTyiHNJ9mct7Hx9HzdotCMADMX9Z8wY4oOJCDHV31LOAN19bgx2kiwAFvu55DyaP6HXSat71mQllwVjFnWv47vMWG8uRLu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057976; c=relaxed/simple;
	bh=toOWmA98bVu2FI5BfREr41cRJRfznyEzuTbtF2pq5vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiJbwRlRlswsopqPSG/wFF6TNWw6bPHvDmfNEl5mqdES6ZQviRFjLoNJbtzgPsCF7FogT/UWcA0voHvhr5Z/MOnkBfwXGO2Fu5/i7a86nN2E+iTxvLq4bS2l7DL19EdZ7IPr36QDh7/B/dT1E65lpSJ5tm3s3R9pzvY/ap1YtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/RbCtwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138F7C4CEF4;
	Wed,  9 Jul 2025 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057975;
	bh=toOWmA98bVu2FI5BfREr41cRJRfznyEzuTbtF2pq5vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/RbCtwBEwgrt+D/0Kzo5Wp3epPu7LvoHPe59rrtU2snFbfwYSud6fLp4oKW2kphE
	 jBFPcZZk1tmRbF9gXLp0JXcX9HfcAch5q2aMh441vLX8O8+XZQ7lhFfX2kz20JLbbn
	 r75bP/kEsBiU5QavKp9gochHOUqd6mRG42yY3EYs2lehuuB7G1ghejqrga/ah/Hfds
	 mDcQ9zhJ9Usp3HpOTBV7vQxTLwH1veANqo5RKJj17irzn3g2+yaN1jZLJWUUhOULs1
	 PcQl/4z3xzp3IHdRFoM3htbF38gfV8o+7bsphf799RO7ECrevKMm0woI6MCCaUjzN3
	 KW+gwwPp0QFjQ==
Date: Wed, 9 Jul 2025 11:45:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	dri-devel@lists.freedesktop.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: next-20250702 kernel NULL pointer dereference
 adv7511_cec_register_volatile
Message-ID: <aG5IZBTJSabxpyct@finisterre.sirena.org.uk>
References: <CA+G9fYtvLHtjKbw-zpqGmtmBMgyJ0B8aiVwd8R=vRnj9YOZ3Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LI3MD61bKK9M3qHg"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtvLHtjKbw-zpqGmtmBMgyJ0B8aiVwd8R=vRnj9YOZ3Xw@mail.gmail.com>
X-Cookie: Do not cut switchbacks.


--LI3MD61bKK9M3qHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2025 at 01:26:02AM +0530, Naresh Kamboju wrote:

> I am investigating this issue,
> Planning to revert and re-build and test in a loop.
>   c871c199accb3 regmap: fix potential memory leak of regmap_bus

> [   11.087822] Call trace:
> [   11.094930] adv7511_cec_register_volatile+0xc/0x30 adv7511 (P)
> [   11.097194] regcache_read (drivers/base/regmap/regcache.c:273)
> [   11.103438] _regmap_read (drivers/base/regmap/regmap.c:2805)
> [   11.107084] regmap_read (drivers/base/regmap/regmap.c:2850)

This backtrace seems fishy, the function that's faulting is just doing a
straight lookup of the register number without reference to the supplied
device.  This looks like a preexisting bug in the driver, we create an
I2C bus for the CEC in adv7511_init_cec_regmap() using a non-devm
function but register the interrupt handler using devm_request_threaded_irq()
and devm will free things after the remove function has run.  This means
that on removal or error cleanup we free the I2C bus while the interrupt
is still registered but nothing stops the interrupt handler from
continuing to try to access the freed CEC bus.  This is going to access
freed memory, I'm kind of surprised it wasn't already having trouble -
turning on some of the memory debugging options or sanitisers should
show issues.

Don't use devm_request_threaded_irq() folks...

--LI3MD61bKK9M3qHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhuSGAACgkQJNaLcl1U
h9CZOAf/c99HaLL754qnRVUODTIV7glQ5Q1Sek0UI1/MTsNPm6n7XKskuUiiN7+2
LZnY5V5o8K+cT9SVnq4yWNjRqokYzLelg3y5HwmdjbbIMY3ixk96NZ/KdxnnWtCi
w/Ao85DqtB899+Hl5Lhpgvyp/FEcjT/xPXS2F9lL1Mxs47SaCRwGxA6/e1k4Ol4K
bgG44Nl2UuilfCvM05/Vn4PEHkdJMEdlL8ss3DKNo1wwqCqaiOnxHsMvp767Ryot
D08nmTPMcIvrke96xqshqsqIVJfeaX2XINzFQahMwQWAABC5xyujMI6ic2INpFXY
t0tp8kTIQkEvCi5qgTnK0OPiCb+WuA==
=mbqq
-----END PGP SIGNATURE-----

--LI3MD61bKK9M3qHg--

