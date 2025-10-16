Return-Path: <linux-kernel+bounces-856089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E0BE30D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330EF586B41
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FA316903;
	Thu, 16 Oct 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2No2LZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB6301482;
	Thu, 16 Oct 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614060; cv=none; b=WsI9g0qH4IOR8ePxc59j2Al6qoxOvp6VgXZD5Dth7LGebp0GvC9IXzuNl5tAvUU7bDX3b5M2d8JbV6XPBXNvu8Nf6QOExnKdQXDY4kAhICcGV+oo0QYxWxzslQG8/qUjPvhCHhcYlGeB8vBo3LY2/Kc+2ghyCGoowXnzLwnbbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614060; c=relaxed/simple;
	bh=ZlNTBywrGZXxSrndN0MgAWRLBIxsZWqmGhAegp7wV3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkatlfHVFnWEa15Wc04Msj21M7Gd9Upg1X47pKwWxAjl80GntAx6ddKXXYBWT+AAVKxmIZrHTY5AW19wYni8DxmcieBxmBOH5rbTQf/n+zIAsL9ueENlUi+GTtcaBFmgz28F/p0zTs4pxLHRMtU2slM8Fjf4jIajF1AShAfNgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2No2LZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42ABC4CEF1;
	Thu, 16 Oct 2025 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760614060;
	bh=ZlNTBywrGZXxSrndN0MgAWRLBIxsZWqmGhAegp7wV3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2No2LZcHDBZpPAPSfToVKv7+kAwSywyjwJZ4HTy/dBeTNUoTlIJAtrfgF7QF/UEz
	 XM4uRf935tHDDvStw5sZiNp0feXRkkTBn5F1T4QbKfkqrEnv3MjPy40GXMUXDS4vUg
	 bh4lDZ8hY0FCmOg1Qef3qy3ZYDLj/Qs2U1mF6QpvF0jfdgCaAQeZLbSfqnpmzfufJr
	 b5tUh/VlXcXxcPUD85yCy7UlPLv9ciKvPawVa2//u8yM3SDXhN8MDjxl9kc/PfcqH7
	 UNQU2wciz/ffvD92riwiriNZo8deXLtt57RU81rZbEPfGTXcgU+qRp6wjX3/IEEJof
	 2QJuQgeXA4iRQ==
Date: Thu, 16 Oct 2025 12:27:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 05/11] ALSA: hda/cs35l56: Create sysfs files for factory
 calibration
Message-ID: <37e0f08b-ce35-450b-9abf-d3be09d2863f@sirena.org.uk>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
 <20251016104242.157325-6-rf@opensource.cirrus.com>
 <871pn3860a.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mQm7NXd1R3mCbGn6"
Content-Disposition: inline
In-Reply-To: <871pn3860a.wl-tiwai@suse.de>
X-Cookie: Whoever dies with the most toys wins.


--mQm7NXd1R3mCbGn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 01:01:41PM +0200, Takashi Iwai wrote:
> Richard Fitzgerald wrote:

> > Create sysfs files that can be used to perform factory calibration.

> What kind of data format should be written to calibrate sysfs entry?
> Since those are no trivial files, we may need to document the
> formats.

This feels like it might be a better fit for debugfs or possibly
configfs?  It's not really within the sysfs rules, and especially
debugfs is a lot more relaxed about everything.

> Also, the scenario isn't clear -- who should write this sysfs at which
> moment?  e.g. is this supposed to be set up at each boot?

AIUI it's some tooling that gets run in the factory only.

--mQm7NXd1R3mCbGn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjw1qcACgkQJNaLcl1U
h9BcJgf/aj4HWzGT7SV1fNKzvdLAiTl0LDNwUG8srBLFFOjBPPjZmdHfdVfbCsBi
kiROkAkT1UKYfTT6WAqdGeRh5+wxSQc5P0Rj+oiqi7yF2bvtvvQoGgxTFzIdYnY9
73tJ9CCETCWHdOb3mxYaiWyYghJ/SUjAyiNSUVZ9gqBklVza03dnM2hndMhJA+RI
YGAAY3Ckda/JFjV6ABDVN/ZE8g5skpHKQdNAJWMRhWvJwA0VEizv+jgmtbdZVmeM
3kifD2moX/JW0QTFyjZHQk8cc3X5mw5FYMo5DnTfKclyvNyHGCmwtlmZZIhjdYUk
C/JKyBEIiWEiZzpObjwjVxfb0+lmjQ==
=SaKz
-----END PGP SIGNATURE-----

--mQm7NXd1R3mCbGn6--

