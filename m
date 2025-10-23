Return-Path: <linux-kernel+bounces-867010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AFC01563
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1980C502ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BB28E00;
	Thu, 23 Oct 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCLJ65ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDB2D8376
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225669; cv=none; b=bMemtK6h7MVOi+q4LkvN0nPuFgOUUsk1K1xAgP2fPjV2cGh2V52c8aFKuJHz7qMqOSEgAKP2+2UgBWSKQtSGlBhpM4eMmV6PqVrGgXUX7tcMasm5uHt0J1LLQ2S+Zi96RpS4jaQrpg1d59K3C1LvhU63dVLEBfapQ+DrNeEWm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225669; c=relaxed/simple;
	bh=Dl27z3p3NRNn1JZ+UxgPKaTrAMjCktyLObHgoPG3ObI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttyFochhr2boXRlTJo4UfMLGzZxxGb6XmjpL+fmxLk+J0he6+q0f87gmnI0tI9QrcazS6vHSCXH8ves3Qa3d/FnyH1GX64WpL2SSEw9Z/yNKlEcgWvmmt4T6WxoNRFD59rj5X2D3EHdU+CUqww9IWAYvi80nv0DfEMUk/Hq0gHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCLJ65ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5B2C4CEFB;
	Thu, 23 Oct 2025 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761225668;
	bh=Dl27z3p3NRNn1JZ+UxgPKaTrAMjCktyLObHgoPG3ObI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCLJ65ZCY9g5JNNCuSt1sxPrgzdhk/H750je4yr8gWwtpYPc6jTdcBBr4Tly1serB
	 drzpEM00Nu3gU5qMb/4RkOKxHdqwrKxhwhxyM8mKe31iEU9Vc8OXHJeeww3+oVjc1H
	 vKECDfGUorXyqmti+Z4GYV8zwpNqgAqo8VxIAp8Q3VPK9UBq14+3IIMyQ4rjCmxQDn
	 9VZX89l7abr/A7XLXx0yWEb8exmVINKRfntboC4OTXzQjEEyNHhN9MunpWmqge3o2v
	 XpKEdIH9/AmKKZ4ivKsHVMoLAmp6RZkYEyjqD1et8wTgzz/oRZPgOxbLGs1wat8gqJ
	 yEPXExsxD9ZvQ==
Date: Thu, 23 Oct 2025 14:21:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v4 2/2] regmap: warn users about uninitialized flat cache
Message-ID: <55d53394-1f79-4257-a513-32dee1704e65@sirena.org.uk>
References: <20251022200408.63027-1-sander@svanheule.net>
 <20251022200408.63027-3-sander@svanheule.net>
 <9b5eaedd-f068-4209-af4a-215716e279a7@sirena.org.uk>
 <833a6495c2b16e1da90c19826839191eec21e6f2.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tJoBJcSH8M1CwOxe"
Content-Disposition: inline
In-Reply-To: <833a6495c2b16e1da90c19826839191eec21e6f2.camel@svanheule.net>
X-Cookie: I've got a bad feeling about this.


--tJoBJcSH8M1CwOxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 23, 2025 at 03:12:59PM +0200, Sander Vanheule wrote:

> If it's okay for you, I would change it back to a dev_warn_once() with a
> test_bit() check.

That sounds good.

--tJoBJcSH8M1CwOxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj6K78ACgkQJNaLcl1U
h9DWcgf9FjDHOELBqIIKY9xdAYd+y8uP9JNT1dgrsQ91m2IXT//WfRiLcqJn9fGS
USN+Mbz5V5F6TcZnpQJk6Jqy/Kq+SpEz53gaCkYWWBcMAw1O4wtWgB3l9tZV1IcB
Tib0xvryklmev1wfUMsEFd2mz5XX0mykQ6cPjJa2IafHrsP56ICtiiZQTdEeLCUu
OJXSqaFhKhf6u6imODmCCHrbQS4XsTaAEErijXzSuSHqI0mU10EKfGR/BUuJXWD7
xsd+LbEB8OMDTs+sV1ugnkQhz8CX19/mfgDSqzxwLOqNEAdVF8sDHtMNDtEFz7Aw
rKjP9ndgoobfww9gXGtDWDkgkgaK3w==
=WGxZ
-----END PGP SIGNATURE-----

--tJoBJcSH8M1CwOxe--

