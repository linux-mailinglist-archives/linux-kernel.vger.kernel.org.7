Return-Path: <linux-kernel+bounces-886409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC27C357F5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B2CA4F14D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E123101B6;
	Wed,  5 Nov 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMpZj0ST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF130FC04
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343333; cv=none; b=UESKPT4cOal7oU0MXhJIh8FSjzZoGL01tpNN1rNjH1CL5MHBy/XYSFEkFy1uSZ1IwWQFLthte9ILEj/Cu7okKVqdO84WUj2JtQhb4UQbfceMNxRhv5qLSxjPLkoI43CA1J3S7m6+hYvZwkNeX4KitMXjuNVfoPwaLYe8XHkirnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343333; c=relaxed/simple;
	bh=GAb7Rbk3CdXJ/1bDuHOarqUVkzf/BGb5QV21W5hon0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlxP11yvO7TKeQR+kPp5BegIn9GBHOaRO0cf2XuvPJ+2frB3hxnJcm/3pl+3QB/ViOVL2UTy/fUICATaAC1v4wjHmgNRQKQsWTjOOiRdb2guJAlUINoc+ZhN3hl3YAUAen7S0uHgDA+nk/1Kn1lM9PGuz7hdGDPNgxNqP49Dxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMpZj0ST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC47C4CEFB;
	Wed,  5 Nov 2025 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343332;
	bh=GAb7Rbk3CdXJ/1bDuHOarqUVkzf/BGb5QV21W5hon0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMpZj0STywI89P90yQlwJ1u99C1mHpPQNqpCAokJcruhq1LIVf2SEA4wKkFwxiXST
	 tocTLFU2mJ6GMrWUQox6g79K7HJDZPsDA2dn4qQMsKILv/EBuNS88jLzO2jE8xPKhP
	 6Qjj4gtoMLMQlh7J1GhOe7YzJqI+6odytLSh5zS5MxEjbDrNIOt7s12M1wW8gs1DdF
	 yFm02r62c0BpYGj+Sx/mmkTrTTHIm75tMQikCf6Azow8fjzdB8ywC5Zkvmorzvq1Ww
	 1gPT/Pm1w5fbL9X1KsT9IIYoibhPKA7qDkaBPLVDz+DeuQnOcKTznWRUmzL8aWO87o
	 iGdPzgKhfC48Q==
Date: Wed, 5 Nov 2025 11:48:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix constraints handling if current
 state out of range
Message-ID: <aQs5oL_VZkorH8Zh@finisterre.sirena.org.uk>
References: <20251103-regu-fix-v1-1-c8a46581c850@kernel.org>
 <aQoFC3YDNlw4imML@finisterre.sirena.org.uk>
 <20251105100852.2c01dd9f@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zjw5Qyq7qtQAkwYx"
Content-Disposition: inline
In-Reply-To: <20251105100852.2c01dd9f@kemnade.info>
X-Cookie: If in doubt, mumble.


--Zjw5Qyq7qtQAkwYx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2025 at 10:08:52AM +0100, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > There's a valid issue here if we can't represent the exact constraint
> > (the hope was that people wouldn't specify constraints that their
> > hardware wasn't capable of representing but we can't exactly stop
> > them...) however this change is risky in the case where the voltage is

> So basically you do not trust the constrains too much (which is
> understandable) and think that
> a voltage near the boot default is the safest one.

Well, the problem is that the constraints need to be combined with the
current operating state for the hardware and at the point where we're
applying configuration from the constraints for the first time drivers
haven't had a chance to start so we don't really know what state the
hardware is in - we might be running at a high operating point, or have
some device that needs the upper end of the voltage range powered up and
doing something we need.  Ideally the hardware would come to us in a
state matching the constraints so we just don't need to do anything.

> Having to specify odd values with more than 1 ppm precision for
> a regulator with maybe 1 percent precision is also ugly.
> So the only improvement possible is to find the nearest possible
> voltage via list_voltages() still matching the constraints.

Yes, I think that's the only safe thing to do.  For the lower voltage
that's just a normal voltage set, but for the upper it'd be new.

--Zjw5Qyq7qtQAkwYx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLOaAACgkQJNaLcl1U
h9AiGQf/cwT87/ozDN+SyfsXomaucKlHgQiMCJ5YPI83lrAJkczE18Ly5Up4J5I7
XHWYCQKHgqSKPW09Ybu6VZBQ9CgwG58tacSglKd17TdYLu+nhv+t0tnAvgdCpoeg
yohGOoX+JqocT7ppQedTkzxe7ReDUqCJ9C9/uh5yNWiQ/JunN0TzqL1cTwlHSGeE
vNuYgRqpHIsRcw0AwdQaCcWuSu3LZMV6vBwaWtxKrHtM1mIjqgwrRb6V2B4ABKPS
MxeKUuvhG6NpYyR4hAPp/N6twgz8kYGGCfU36niHk6DtIqR2xktIl4tb+PlfhwuP
ktruOsOoIIq0KhWCmzei9qztdBZK5Q==
=UHFS
-----END PGP SIGNATURE-----

--Zjw5Qyq7qtQAkwYx--

