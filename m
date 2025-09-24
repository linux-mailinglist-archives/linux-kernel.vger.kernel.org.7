Return-Path: <linux-kernel+bounces-830170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D8B98F67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35016188C178
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654622BD5A7;
	Wed, 24 Sep 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2eKIOnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72729E117;
	Wed, 24 Sep 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703480; cv=none; b=nY5p7C1kRe7tgFJ7wLwzH9oiAvtKDlWZYPSbSe68WKfypWja5/fU3ZI33L88ZizC/3Hzvu9jkDvrQ+6qgO4vZx+qcGWVlkqUa5IpYtzkBNzCCHYDs81cA3daMgAT8zCyVE+Zq2IEsSQNT3CF6Z+TA0PvRd5VrNSdniAZ0SNIQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703480; c=relaxed/simple;
	bh=/IYUKHDSnRaRLZ6hlg7KH0TJdWwVnj1XFp0OLs7MsLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBjWH2O9t9qbUkVR4DEcwUjT3LLwpyCv6zKhY80CsPUE/DRhfGP+V8ByjOlVRDof5Ug2iMGj6+pgmR7ocvoBvnvEfSskXwK4sFunTSemhIgzPAPuRNDxfxbQgN3sqIxM6ANUwPnn0OwTeICtsP0eiuzf0175EhvbaCv9NyrdRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2eKIOnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2FEC4AF0B;
	Wed, 24 Sep 2025 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758703480;
	bh=/IYUKHDSnRaRLZ6hlg7KH0TJdWwVnj1XFp0OLs7MsLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2eKIOnZDiSjRF5hCEhZ44t2eneNf+70um6wWf5AtMNAUgA86TtxSWLC7im7CMeGF
	 FN9xUGapLb11Lpq2JH+hmkx105snF/nvKfowI+s6qZ5TDG6E1VkU2i8KDCtsPeLoL/
	 yumxYXTj1iEEuosZgFkZdM9StujqckeNtlIaczSW6bTiUZFnzQMaHpF4lsGVoiaBYf
	 qFUaUgkDSYDgLOKlIE8B6Gqe3QiKefODU0cmui9Y95NoBTzTNXoxKc9iDXoOJ0SFcD
	 bUkdSlyUmKdOYliSZcwHkJUWVz670PCLoylffa1Jrk8WPR1PL0lTso5sozhKKxS7KK
	 oAO961BMRO+lw==
Date: Wed, 24 Sep 2025 10:44:37 +0200
From: Mark Brown <broonie@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <aNOvddby_hpegvDR@finisterre.sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
 <20250920114311.291450-2-andreas@kemnade.info>
 <79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
 <20250920233307.0c425863@kemnade.info>
 <473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
 <20250924090023.282ae450@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfoNTn1qNVGNGSEU"
Content-Disposition: inline
In-Reply-To: <20250924090023.282ae450@kemnade.info>
X-Cookie: Filmed before a live audience.


--sfoNTn1qNVGNGSEU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2025 at 09:00:23AM +0200, Andreas Kemnade wrote:

> max5970-regulator.c has hwmon integrated and no extra device. That would
> simplify things. Although it does not report temperature. Some

If that's the only reason why it's a MFD I'm fine with doing that.

--sfoNTn1qNVGNGSEU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjTr3QACgkQJNaLcl1U
h9D8Ywf/VGLJ8shWU0lrY2AFMdqiJgo+CY9vQTI9F65PVeWuxMq++AfflE4G60zw
Uf88JiYfcB/a4lpA17LQo5XviHDQ7Ntb4lIrSPWt4+ebSN6RFrFHNFvsYOlQtU27
qE2aQrLapX9OKv/A7fBIZ+NxB0Mn5wOgL/90cebQWpJ/bGNV4yatbaFGzvD8iWv9
5/j1JRpt+GpEDjJgXDCHG2/kVeNbmsn8iH324emzWmLUCVYVEreulH36GAZU2Lme
vtseGWHOF6n0BZMCng4XwcSod96prknHdwDN7DTwrRJHmeKPZXR64I7xnyMMp7oL
PcqnG4vlEQ8VoH8n3wDC5mY6dobvNw==
=X7Xu
-----END PGP SIGNATURE-----

--sfoNTn1qNVGNGSEU--

