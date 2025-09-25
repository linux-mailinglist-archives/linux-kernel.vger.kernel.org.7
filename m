Return-Path: <linux-kernel+bounces-833456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0FBA2001
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD001C04C78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF02ED15A;
	Thu, 25 Sep 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUznzpKd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01214747F;
	Thu, 25 Sep 2025 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844363; cv=none; b=Fn0QMK5T/qaz/zlgcAXrgwEZlLsVdj4vfeSbyTFY4Wwboehc+VtpJInHd51X3cDnvdtZAQ3LYJ3SwZkqzEw7do+9ot+eMbHPin3XhML3/2MbQN6kNJ/G07HJl3oFbERdwcDXLgs6r15LyqKlzMAwRMRqdPNdqm2QbjBZatfuO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844363; c=relaxed/simple;
	bh=erOnXljr1CF5krssC9cl4XOhPI/hrAqcFARq/3Ceb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aubb7uM73CqSFUfJwk/gQYvDVCZbWknVSdOVSsMpfN5k7w6SHr7s+EcvBJJOvjRuGiLvrJFTpog9FcHjw0ZeZvptextFSi9a4XrUESl58r9lV7d0ZaZLE1pX4q0hxaRXTRu0PRjIUeECMWnYsEZox02jztXsZSYJaEd0I4aOZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUznzpKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0FBC4CEF0;
	Thu, 25 Sep 2025 23:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758844362;
	bh=erOnXljr1CF5krssC9cl4XOhPI/hrAqcFARq/3Ceb7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUznzpKdr7a6cKKMlWesJiEcfIMdUPFM7TIL1WD5pNwjVNbQB+8ZwYqHt6UtIZXud
	 y0ep0uOPcq10h9cxruVL7uhCAfkOtih7CPlHWmRqQdmnvozTw3VGkYoHjMBMuFkIz1
	 PGr9Y1E8b+RX/OC0YZtMdk0ZP1r2H2th7vJMT1dy0PrHKA9gX/2WanjhVy+ZCJeUh7
	 EdpGwSh/3bBXQK5CiFC9JY5/YTGNp9FVzb9PEi2Oc7BvRnu3svbf6s80LlMlfREvim
	 DGanULl5337mJCtw1UeKQd/53bHbP5dsrwUQh+XBotEwzhtfuniHaIf6bFwHGl80aB
	 WcrOJN8gvlyVQ==
Date: Fri, 26 Sep 2025 00:52:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com,
	henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v1 1/2] ASoC: tas2781: Add tas5828 support
Message-ID: <fe5cd279-0b28-470b-88c2-49ad9428b125@sirena.org.uk>
References: <20250925051302.6805-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqEEULI/76E+hpBZ"
Content-Disposition: inline
In-Reply-To: <20250925051302.6805-1-baojun.xu@ti.com>
X-Cookie: So this is it.  We're going to die.


--wqEEULI/76E+hpBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 01:13:01PM +0800, Baojun Xu wrote:
> TAS5828 have on-chip DSP but have no calibration required stereo
> smart amplifier.

This doesn't apply against current code, please check and resend.

--wqEEULI/76E+hpBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjV1bkACgkQJNaLcl1U
h9DHcAf9EuS3d8oup+XlJUpvsOnB0mljoa4P/F5jv4tdKvmjIQbsNgesKDJBthz8
uyUzb8DkJLufBS2rDJxufCCm5AbNTB3zTJwOhng+fm4j3bpjJTuU9Z1umB144NX/
UwhdJXM96wqQkgGwLgBWaDtRfiCidOYT5bYNJ6sx3MhpfX7VEzML4bPXiT2HWqNz
mmAh3IucXSacEQ6UvaD0B3iQohx39/Tghmv6AEM0FA2BmYWOovvGe59ifqLyyxvQ
bf45NWBkz74dYArErMj3+P34FR2zqrlOib5AAmZPtzjvkEEM+w+4pRKw4uIBogeC
/NxJYFj37vwlSgvNgAEOPbkazh0mOg==
=nh23
-----END PGP SIGNATURE-----

--wqEEULI/76E+hpBZ--

