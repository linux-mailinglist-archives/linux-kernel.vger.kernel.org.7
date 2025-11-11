Return-Path: <linux-kernel+bounces-895537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70977C4E3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC043A82FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E232470B;
	Tue, 11 Nov 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEP0BQP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F59358D09;
	Tue, 11 Nov 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869103; cv=none; b=kTuIZp62CA7kxhx3DUORfCpHbOEGLVtTfXGEUlUGqktnyKDQX3FT63l10bMPcOnHKzniqPZNoDN2cfixYZ0QpJfPIoCKVK0wmuYUGL4nggENVYYXflVXHoz0NSGZEhtXZ93sElj2pZqBqOVZAO2ctmjwqKYeU8O5DP1EyyCWVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869103; c=relaxed/simple;
	bh=2Wa5ybgjBxcos3zr/zVTCOr/wVgOToM9GjZLKqEfI7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceVUnOMyrDl1aDY3w6AGslEh/Vw2qeh0jNeUoK/BCCv7lKivw7ufHbihyGYdiN9PvZ9rhwY0Skr1TQ78mq9uG0D9ty5HD/pXHZVUpG9Xm3rahxfDFuSMCuMw1EWzHPl3jzwK4W0/HXSxWsUG2O6T+fdlxJljvzEcZZwX7DcG1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEP0BQP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F08AC19422;
	Tue, 11 Nov 2025 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869102;
	bh=2Wa5ybgjBxcos3zr/zVTCOr/wVgOToM9GjZLKqEfI7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hEP0BQP5GJUJDrpqwdku1eeE3K/y2bFXV9+GvykElP/Nn5fEByANtu8sbUtyQCV3P
	 C8ZCZfU7eyv6C7v+R8G2RNRYt6uGMOyO8UKbAzE3KV4BQpB1CqWJs9jOJOcT92Qsr0
	 BcjRUvcIxB5+YGosgZwIxEfLmIESmCBCkfs53X5mJYayszEdFPKaA+NH5r7eQ/6viK
	 +clYpCz3+4MGf6tqjVnaLvy19mN3GrqQ1IGf3C+ujlBEg23Ux1M+wzEj+PlT+amplI
	 LHc94iSbN2C/vJkitPpCvPbq5bLx/JkKlKZTPS4KS4zfJO6ZM2Cc/KfOV+d0QT1ytd
	 TgPZkOMRMUjDA==
Date: Tue, 11 Nov 2025 13:51:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] ASoC: cs35l56: Allow restoring factory calibration
 through ALSA control
Message-ID: <aRM_a09S-_avzLUR@finisterre.sirena.org.uk>
References: <20251111130850.513969-1-rf@opensource.cirrus.com>
 <20251111130850.513969-3-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q38Ee9YLTqErviPk"
Content-Disposition: inline
In-Reply-To: <20251111130850.513969-3-rf@opensource.cirrus.com>
X-Cookie: You dialed 5483.


--Q38Ee9YLTqErviPk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2025 at 01:08:50PM +0000, Richard Fitzgerald wrote:

> +config SND_SOC_CS35L56_CAL_SET_CTRL
> +	bool "CS35L56 ALSA control to restore factory calibration"
> +	default N
> +	select SND_SOC_CS35L56_CAL_SYSFS_COMMON

Not a big deal (don't bother with a new version) but N is the default
default.

--Q38Ee9YLTqErviPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkTP2oACgkQJNaLcl1U
h9Dmywf/fN7++Vnf6jqswzeJml4zq15PMy2qkue3LJweuPUnGOO5ZJIzzopgTTTu
fIa3oIM7s1vV5W8qNEdm9dvKjl5WK5Iya9C4Vn3dO8dO3ywDpoXozt4tgxv98WKK
1Pp6NX0ZKDgH2UsGtXT6KW2ORGVu05Dh5Tu6MhKaRlIiFJiOfgtBLAFiSZLlX/7H
ME5gwt29kOSYy2kpTwkGFrpciNXYSusdrjYhxOhMKvPx3aoTfwh0J79ct5k+FRUI
EP/5nVX6/2ZXpXyKPLgNxBFpOA38BpBn4gt4RwUPo5q2IleqK0nkjxgBmKed9vfK
2yoykSGoXPLCHj8AnRLKMXbJpEq3mg==
=DBW7
-----END PGP SIGNATURE-----

--Q38Ee9YLTqErviPk--

