Return-Path: <linux-kernel+bounces-846941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86924BC97A4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00291352FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0D2EAB71;
	Thu,  9 Oct 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP7zn+/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5E2EAB6C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019654; cv=none; b=lm2F18WWlqV8i0H4hfLQyn9K+aMTK53HuMSIBzIylwFFYkXa6P+pmIpKMWN3N/gja7LAxNBpPmXlGelAcCK0p03r75zHpdL5bp+DzMXQWN5n0xoPFI0HypjVpUK9c2P7OM4J+53tDzlYCBffs8yC1JhrWMkztGwr1IIf1Y0ANYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019654; c=relaxed/simple;
	bh=dJL93EMW/6mOiIOAkHQ5cIhXyZv+4t1RhloI3PA26tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frUpuN0zmELAb2GztEG7ixIVsLU7Qr6YglSxuKVf9LkCXxLaUOJUiSUKUTLtWn9tEutnTbn49zSzo0D70marWeom2sosu9pjy3835IHPPi8x1phWtMDsq2ZuhUQlXjVAQRTRt0RkjnQA/ko05EQQgiE9puZ6BV01bHvdlMpKa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP7zn+/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A0DC4CEF5;
	Thu,  9 Oct 2025 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760019653;
	bh=dJL93EMW/6mOiIOAkHQ5cIhXyZv+4t1RhloI3PA26tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP7zn+/93k947sK3lmWQYJIhbHmzeWOmBpqH5cOjQvAbkGIRnA+WFc1CMkJNhxi9C
	 o60frQ9hF1NxKOea+n0nLAKyKFU+XiCYhUN8iV0fQb2jJzxikynVrvpnxTFBPKehk5
	 cpkBv7Xq4eQUNy3Ax+YYdGekpQFte/UN5j0XQsjnDXJLwY9/6GcAuKdtCLl6tNHvBV
	 EgvQQrOG+YWruavdvT4hOeyj4svgyXOoL0DdPbCjCrs41Qe5sMBknM8DzaqRWzm0xw
	 eKD7HXMnND3GgVBgWRttzVhNf7IzoRCYW+ANCXUVGHPn1atY9bPMIkxNfTuTP4+jDz
	 LJ3a+DnMoHfIg==
Date: Thu, 9 Oct 2025 16:20:48 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Daniel Xu <dlxu@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: move nmi_watchdog sysctl into .rodata
Message-ID: <lgunjvc6dqr7bofukwckd3435odkntc4trboiiwzg3pc55ebdg@hllo5da2yfkv>
References: <20250929-jag-nmiwd_const-v1-1-92200d503b1f@kernel.org>
 <aOPa8RClyXaeyV6L@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3pa7zr6hc33hj3cn"
Content-Disposition: inline
In-Reply-To: <aOPa8RClyXaeyV6L@pathway.suse.cz>


--3pa7zr6hc33hj3cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 05:06:25PM +0200, Petr Mladek wrote:
> On Mon 2025-09-29 17:55:07, Joel Granados wrote:
> > Move nmi_watchdog into the watchdog_sysctls array to prevent it from
> > unnecessary modification. This move effectively moves it inside the
> > .rodata section.
> >=20
> > Initially moved out into its own non-const array in commit 9ec272c586b0
> > ("watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe
> > fails"), which made it writable only when watchdog_hardlockup_available
> > was true. Moving it back to watchdog_sysctl keeps this behavior as
> > writing to nmi_watchdog still fails when watchdog_hardlockup_available
> > is false.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
>=20
> The patch looks good to me. Updating the access rights was nice to
> have. But it does not look not worth complicating the constification.
> And proc_nmi_watchdog() works correctly even when the access rights
> are always 0644.
>=20
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>=20
> Best Regards,
> Petr
Thx for the review.

I'll push this through the sysctl-next branch unless you want to handle
it somewhere else.

Best

--=20

Joel Granados

--3pa7zr6hc33hj3cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmjnxLEACgkQupfNUreW
QU+Tbwv+OGr6zzoAdq0JyrDqq6OgiD8yejs8NSt7RMeXSwh2WMttVXLkW58WEjN9
0ElqypZHbKIo1sm0uObI1umzl2e0PVy6SNXJKUr5xVZi/6tHZVFvV1GvUdnC/AGF
pbN5DvWCG4RApGkeGbdb2p2lkBxM3MedUmeAiBeqJ3VPKRRI9SXYekBf91vdZrX9
EO8l/58lOurf1ErhsAgIQejd05nuzPmUXJn8H5fX2TWflNy45dcOww+o1dbPhfy9
O0o7hlZRxk/4nMBRjbYEXOkHstjYmuJOfnVNjTenkzQWRRdXGXfKU+1S1fTRz3zl
5EgiwReBX6mJTe/v+jzx1KfrfbjUg2sd9hk2dEtMciFX3MWa3uJWmLOMCVD+6lpr
++iDKJemdqHQGDj4miO/kIDqBEAcSCzG38qYqBYbvUDeQfVRJYYy/r/Xbe5pWqDU
y69GeznBKwU5sevQNmoIK3idNZyfoh48KZiGBXD/t/QZkE860aYao4WvhxDplyXf
BpUTMMym
=lPup
-----END PGP SIGNATURE-----

--3pa7zr6hc33hj3cn--

