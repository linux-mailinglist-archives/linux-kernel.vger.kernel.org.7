Return-Path: <linux-kernel+bounces-828675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AA1B9528D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD722E59B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943B320A0E;
	Tue, 23 Sep 2025 09:10:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588731E89D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618607; cv=none; b=AcS4b2RtBlx087gAurm6TYN0BGxnKdIoayAYTMVzmlf/UUjKJ3kHCDcZL4jIHZwqQhEXLuRhq/O3jJ5Yjug+bNVJaAjikAXinJbguGzGfRYty0MKkBRDsfwjexqzIWdJ1xtvH85e2FKxAKFhZ5mlEXKJUr/XGK7RDZD9bmQXwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618607; c=relaxed/simple;
	bh=3uiVWDC+K1mTEDs7IYhQ7LD4JR2CO/i8/RxDhuTB2/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLyNntsfj0A39C8tHSuGTfp7inlbQW0DxNEw7C72LUz2uJI1SvDC2/kTsQBUy9HC4YaCHnkpj4HhrpbM1YCimqjasoyVUWA7Ogz3dRxngHxsfxLNo5kYM46NzsDvWDpkRrIdCquAxzzZGEYlQUG3tStxKBibocgUBDyeXEcP4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z29-0005jd-32; Tue, 23 Sep 2025 11:10:01 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z28-00049Y-2m;
	Tue, 23 Sep 2025 11:10:00 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9691F477BEE;
	Tue, 23 Sep 2025 09:10:00 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:10:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] can: rework the CAN MTU logic (CAN XL preparation
 step 2/3)
Message-ID: <20250923-saffron-caribou-from-hyperborea-e6994c-mkl@pengutronix.de>
References: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcknaa4a7zbqxy6n"
Content-Disposition: inline
In-Reply-To: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pcknaa4a7zbqxy6n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/4] can: rework the CAN MTU logic (CAN XL preparation
 step 2/3)
MIME-Version: 1.0

On 23.09.2025 15:37:07, Vincent Mailhol wrote:
> The CAN MTU logic is currently broken. can_change_mtu() will update
> both the MTU and the CAN_CTRLMODE_FD flag.

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pcknaa4a7zbqxy6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjSY+UACgkQDHRl3/mQ
kZzTNAf/Rt16Dt0GIebbaiwq8iVBNGbSmvGVjlXAUqTNvEHCZpVFWT43NMqWZsGq
MfLFm9V5y1tb+oR8xnzexS0tnmGt4Sc8SRY9lFIvKuCbV+ZqGud9OpUYAUSvzIS2
FyNnh+lXpXoNlCjLHFJ/lmS3FBYucx8QnF7VBW6TDyCd8EVHOh7FP0ZoBIpRwAXT
ffLY+uPpequCFKDb89c48Gj/LoOIEOHfapPJPPaMHgV2TkQ7ipOF8GRNauf9GSDC
rKfYoMXnr2tRf9YJORpruN/UN1P0ES2gqsTy/2W2XywxcuRCOtvALFdhjWQaDVWq
j59A15G3y9pSLJDuVhvB0pNR01ofNQ==
=PIAv
-----END PGP SIGNATURE-----

--pcknaa4a7zbqxy6n--

