Return-Path: <linux-kernel+bounces-883234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDCFC2CC00
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA034A55C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D72E32038B;
	Mon,  3 Nov 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YUP9g97j"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E831E102
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183511; cv=none; b=SAP62sqVwFtSrVNzfdueTBvEhitc4CoJ/nVqCeXM6KWieHB7Ew1b3FHdLEwMz7+MrrtVGYbrjZsuchNRx/ELnoIyRliPsLACPWDUCi5jbh9Nl4MIKz0r6O4/EQQmaR4KJMZDlLWbcX3BUm3fOhrRQrDB6zr+6QJYVN4oYjB7bfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183511; c=relaxed/simple;
	bh=VScXbwST13Gy6Me/pbj4QADqwe26d8VtIuQwHOVhdqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tolnqsMuHDhN8DZvvTilLX3jvyA1qn4X2KStnTTq7AR+zz2z8hUBohbs/ikD1QpDsoOt0nxI7EJPhS8x42mpGxHN6zkr0CWnPdWYPSkW5NEFGIrW/iFUAnK9/jYX6htulhUkYhB+VmsDRFKiCHY2hWlkYwp14WrUnjBtDeHt22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YUP9g97j; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VScX
	bwST13Gy6Me/pbj4QADqwe26d8VtIuQwHOVhdqA=; b=YUP9g97jYjDdg9jXPMSc
	7pDv7U/RZxQW5f5b+y27IYvjfIqPwoITIgi5FJ6KLG1rJ+6Jp32PkNEX0fUwNJnn
	WgVYCoYi5sYf79gaiu9dhx8PTxJIFRbxnklq7Rp+HGnIUK9SJmRjZHd2F5LocJFk
	3IvVbwBfDAuEy8gJknPo+L1nEPBs4z9hvCr6fAmSuZKal4p9OfU1mmc2Hcn6paNB
	AFHZqEn5cy0cDyYdvCCFMYx31HSP0ztav4XMeINNx5Udt+MXWoA3S1io/k00hc0j
	sX+HWJoqQGPhLKLxvcVpzSvhuFaE0bik84Caj1RzXWPLcwspm1bAJEC7zbX9T1RE
	4g==
Received: (qmail 2269149 invoked from network); 3 Nov 2025 16:25:02 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2025 16:25:02 +0100
X-UD-Smtp-Session: l3s3148p1@gqmkUbJCnmRtKPNt
Date: Mon, 3 Nov 2025 16:25:01 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] reset: handle RESET_GPIO better to provide the
 fallback
Message-ID: <aQjJTQK6Dgsx63YT@shikoro>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <874irz3e8m.wl-kuninori.morimoto.gx@renesas.com>
 <61c8e3fc-af35-432f-9bb9-300c953819e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q9IOxOlIgSZsa2eE"
Content-Disposition: inline
In-Reply-To: <61c8e3fc-af35-432f-9bb9-300c953819e4@linaro.org>


--Q9IOxOlIgSZsa2eE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Started to work? So was it broken? By what?

I explained all this in the RFC version of the patch which was linked in
the cover letter of this series.


--Q9IOxOlIgSZsa2eE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmkIyU0ACgkQFA3kzBSg
KbZbnBAAp98s2BogWDTtqUued+Xq7mqqwj72B2AktxVidZdw+t3FGZfbMPfbYU9d
zglRgAWwZY0X7gyJPVLlMMZzxQYAt5F/BcxSBcO4GYvNzP3hHJLk07JzOVERJDp7
TAACQusW5h2/6sRYbCWWoWTi0ka9E+XPlMtB4tUiLK0v6ALoKzb9M4NGeL2LevzQ
BAsn8paziZZx3Zj5aM47SPVUpaC92pQTQbK8vAU7+BA7tOskHq0KKG88oucvX68u
HPwrOe8a+CtUWQ7VlGv/HytOIsTzgZIIw1QV0Z4B/Ap0Bln0udN8edCm9VuyA/Fu
/KzPY4oVjpposApg2sB+HXuXtO95w8HcWm/V5CnzujicS+P8joiM3F3SyiMe4io0
CxBV/IBOEBOvV4VHt1HERmkF5ZpR68NLlMIquTppR+zXnFAI+OA6rCauCgOofQM7
suUgZjcToJ3MJ7HZBbTEn9LBJGoJhrOL4DGvYs/Vpo1qtsAWm0TlQ5BMYyp+McHN
gtS5J9tZWSkdGGNCRltF10fwOs2kbNuoln3Z/XZ/eiOqmQagGlcPsEOojkr6c0yu
B96NR8Zm4/cvcXdnOY8MzTUHHsUiopRpM5tToyXudS/fSMAb7KhWyYXWmqsmTNDv
kNAcLxb5uhqPszCNmgS5jW9Th9n3/nx9XYIZA5B3xC4HFZtvPZk=
=ZpjM
-----END PGP SIGNATURE-----

--Q9IOxOlIgSZsa2eE--

