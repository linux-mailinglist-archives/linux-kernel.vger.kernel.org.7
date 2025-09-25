Return-Path: <linux-kernel+bounces-833311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F72BA1A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D8A742154
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637A324B07;
	Thu, 25 Sep 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iqltjzqy"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CD322765
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836148; cv=none; b=AMZyEyR9P2PGLz6OXzRRGJ245VPY4dh+iWY45ddBFjCWAuwrYUeEsqQc0131jo3Nj7iUNCa2d2OxUKrKEcxRB8Ohq6j5rSqb0cPIbnxmSqhhAXlkPZDG8MpdWeVjBaARmybSZWBV+ravVmzpXWbK28dx4JkfM8uBdkiOZYH0Qe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836148; c=relaxed/simple;
	bh=xr3uAxeGorlH8I23yAnuULdiCsLz2aU1XwDsAyp2ygA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDISUuBqUNptuK7hmBiDUAq0xa57+vHPZRtYOL5TBLtkNIm0kP57B+RNhEAGQtcExvE7ARD+MnqpTHxa/cMIVrJLGuCgCeh37b+ybkPoo+fDCOwuVEYk6u4UVMUuHziGy+5MqP+PUquQ1gxezoKrv6I8oiEh49yJd4VbRu9m//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iqltjzqy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=xr3u
	AxeGorlH8I23yAnuULdiCsLz2aU1XwDsAyp2ygA=; b=iqltjzqyx/oqroztBfRB
	pynGj3QxcRZBAHuA5i2WyQvgRAuZ3vTG13zysInMERxJn2V1/33hGLCf55uBcMKp
	TG5AQuJlD/NKmyNRGh8dyhcnZ1IfHHLzUhcJhPPub/yBNH4WekihegOWehDRceQn
	EQT3i08VKYOSFsdmYS0MOTSSsfjALk7sWs5s0xHIlsCzlg61aHrl8JRN6AYNPPhO
	0rltQDOBTZv0V+DwC5Y7Md/24iRuEBBedJFF3RxAIDQwPLzgqYvxDckgQSpRdPRv
	RoafF1k9bFCu27j3WfNGsnA40oCuY40YIZlJp1h8RXtjaBum/JLvczC3UUagcKBG
	Tw==
Received: (qmail 2021333 invoked from network); 25 Sep 2025 23:35:43 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Sep 2025 23:35:43 +0200
X-UD-Smtp-Session: l3s3148p1@qw2J86Y/INYujntx
Date: Thu, 25 Sep 2025 23:35:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: designware: use dev_err_probe() when probing
 platform device
Message-ID: <aNW1rqamooqW34OF@shikoro>
References: <20250904-i2c-dw-dev-err-probe-v2-0-e59da34815fa@bootlin.com>
 <20250904-i2c-dw-dev-err-probe-v2-2-e59da34815fa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="woLPRwL6WyqnYD53"
Content-Disposition: inline
In-Reply-To: <20250904-i2c-dw-dev-err-probe-v2-2-e59da34815fa@bootlin.com>


--woLPRwL6WyqnYD53
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 04:31:07PM +0200, Beno=C3=AEt Monin wrote:
> Add calls to dev_err_probe() on error paths that can return
> -EPROBE_DEFER when probing platform device. Namely when requesting the
> reset controller, when probing for lock support and when requesting the
> clocks.
>=20
> PCI device probing already use dev_err_probe().
>=20
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--woLPRwL6WyqnYD53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjVta4ACgkQFA3kzBSg
KbbRBw//R5QC4vBOzaefhgZFHmUvyAVXlEEz9c0effsE/yN++yAp3aZbzhGyFJYK
eeiAL9EWav5EevIElfrDMjlm6SigyrwOQSc4EC9TWstW/r1Yyn1zShvIuTIOz7+s
wi0V1quWxBNaP9NJ2vkcOI9fyWtuAHUFauNhHp+obFla8N0iFulc2iOx1+TkEH4g
byFJmAU80HmWt0r5IjBADCRU/VKU6sRE1R4isAIzRNbhYGVEbAKMpTkAvsbv1t4C
Fr7HNpGJnRS8IjcPpmDC48IcZFer0Zy6JCo4a2U4BFU2tkHz5H2uhmsV89dkdMrv
0XjbRgIZ5/N9syAsDZxBShh2ju9Rjvt81jG3tNVqFi5fIC69++YTkQsbU5/3Skk1
66igGOrYCdrtk++icHVb7nKKwG5rCWkTJDwyV8acRvteFKJqpW0+tDSbgCdjiMN9
K+J6aW9vvD42Pi2G6fIKf8UOUVQwvnGD3Q3z5LWo0fqdWNvM2YqYv5p9gP+qaITH
OtK1KEFn/+LR2A5q29j8ADBQxn5vusW6xJLEjt7bRUlpf/HdEb/7sZWh5om++tIw
2JVktxYSSJBuM1pDWyeiueED1G1mB5lNVxUUM3sLHFGHvK0BM8MFRetTvYR572cP
3z1DKUpgQg39CsY6Wr6kvZRhZIwWLIRACgy6cGFnMCDDNxfMHNA=
=BP0o
-----END PGP SIGNATURE-----

--woLPRwL6WyqnYD53--

