Return-Path: <linux-kernel+bounces-856166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F0BE348C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B424502DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F056324B16;
	Thu, 16 Oct 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV95y6Mw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E22FD1CC;
	Thu, 16 Oct 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616802; cv=none; b=C+sZ+X0UgMrFAJT9Tx1p0UzmDbcgjU5h0GQFiuSlHjd5m0XVj38oZNgS3qV/AWLK5SUUaQtmayLEz7DBI6RYCFiLABeUcQX0LoEl5Rw0jZXXkQvJ8KnYtbSPcb+0EsTnBCcjU6zFtBIfjgXNIfApCLuraTWCnI+g49UszD1X7Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616802; c=relaxed/simple;
	bh=s9LjxPAebn33cLNi1oNeKaoMwXWOOe3q8lk+/+DLrek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGwLh+GkgNvGbJP9mMfZmKLszcUfHC5Ew+WdSK1WCHnqbledFY1N3y7FqkD8Mn0uhkDt0AaDBbpKjnBdY8r+wCBGJfg0HindY6C+UqffRc2HHDaQARbXNBu21a3NKkzc8C6YvFwidBsF734O7eZH9D/sD5uTCITxuyEmfHNHrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV95y6Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C0C113D0;
	Thu, 16 Oct 2025 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760616802;
	bh=s9LjxPAebn33cLNi1oNeKaoMwXWOOe3q8lk+/+DLrek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV95y6MwSFBbHcm9RdZ9+q+5xCdL2eftk5/mfYFU2ob/nJzYmxzOQfrriOFqPjIpF
	 mxXQBdc4Vwcf1u+KuG61Acxpb/KV6RaQUDiOm39+RFNfsfgIY9jk8XAA3Z3Tjd7DL6
	 bkLMP9i56JfTfaMP5CIE/dpLIKNnu874T7K7n28WnCex+v+HZkI8jYV7ysdjCveOo1
	 jt7K50HnucWxD94XwpW/N3zOARhmXXmCNYmdz4KinakEjueVOgoLW3jW/lzPHsgAXB
	 M6Ep+27XCgd19Ai4kdTkAHB//aiZFwt5dW/Em8A9tiyhwhcwPAbQRhVEkB4VBf0EUo
	 mcxZMIF8GLe3w==
Date: Thu, 16 Oct 2025 13:13:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 05/11] ALSA: hda/cs35l56: Create sysfs files for factory
 calibration
Message-ID: <d4e94837-6e0b-4b47-896d-d0dd3a59a39b@sirena.org.uk>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
 <20251016104242.157325-6-rf@opensource.cirrus.com>
 <871pn3860a.wl-tiwai@suse.de>
 <37e0f08b-ce35-450b-9abf-d3be09d2863f@sirena.org.uk>
 <14617d69-7312-418f-abd9-3c65a84f8421@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UJFub6DXM0e0JKXW"
Content-Disposition: inline
In-Reply-To: <14617d69-7312-418f-abd9-3c65a84f8421@opensource.cirrus.com>
X-Cookie: Whoever dies with the most toys wins.


--UJFub6DXM0e0JKXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 12:58:15PM +0100, Richard Fitzgerald wrote:
> On 16/10/2025 12:27 pm, Mark Brown wrote:

> > This feels like it might be a better fit for debugfs or possibly
> > configfs?  It's not really within the sysfs rules, and especially
> > debugfs is a lot more relaxed about everything.

> debugfs is an easy change in the driver but more complex for the
> tooling. Unlike sysfs there's no standard layout or naming convention
> for the ASoC debugfs tree, so it's more troublesome to locate the amp
> entries.

> ASoC creates a debugfs root by default if DEBUGFS is enabled. But HDA
> doesn't have its own debugfs. There is an ALSA debugfs enabled by
> CONFIG_SND_DEBUG, which is normally disabled. But enabling
> CONFIG_SND_DEBUG has other side-effects, it enables more than debugfs.

> Or we could create a new debugfs node specifically for Cirrus Logic
> directly in /sys/kernel/debug.

Dunno about Takashi but for this application I'd be happy for you to
just put something in the root of debugfs.

--UJFub6DXM0e0JKXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjw4VwACgkQJNaLcl1U
h9Bxmgf/YVcEu7vWQoRhnKscIrN8UWYWrbHG/1znMaJ7ZzLbQHbHgUu2gdkihoFm
JTUW1QNoEZcqyKfjhHd6zX5wHnynmtvwRT2Ek19HROIyT0O7ZICYfxyLqq7/sb2O
cMcLNsAf0WPqwFBmEn6IcpaZCsqm9u0t5dDcG9QGCRJIkXp8Gr4B5rUgFwZWTkhc
6tAeZpzQiky8LDskMQrjnbyRDY3yqtFyFK/D+plE02Tpa0sU2aZqgnGASrP1hGp9
75ZlJWZosc7irI009nMajf2uGnGogPD3EfecaUmiQd1zMOWnaB6YM3/BgsM0o0Mi
9vGyHPikvKRg5rNgp96qRgrElHRZYw==
=P2GX
-----END PGP SIGNATURE-----

--UJFub6DXM0e0JKXW--

