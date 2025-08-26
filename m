Return-Path: <linux-kernel+bounces-787828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C4FB37BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFC37C2281
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB031984C;
	Wed, 27 Aug 2025 07:37:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E995205E2F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280251; cv=none; b=gJdScxMnI/nDjjyV/NijS3l/3RsmcFPI6oP680s/T/MWUcJ6L+dKqVnmlj81E3xGWcSaytWB9EzYztvak6FjX7odhWve5l3TKHfwCJdgIDFnBKd1giwrGtjmmqchCLu1gcaLLaBnU8qxrbJodKm9yZvJ+5kYsYhPtpVKol1Cv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280251; c=relaxed/simple;
	bh=pswIHBZL7/Yj0+tCw0XL6EEuAuOgT4TSIwjz85uTWzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMb2pQ5j33EfkObMZAU1xcfsuxSNybsd8+AO+1iq/JssQYQw8stdW60C1IlTJdeQQ+X9j0fU+8ygGSLedTZ5JHwCCGfidmNVPUeAc8gCHbXvP/NMyyXTtUx49Fq7X2MQLGQWkHWOF9wC0Hdj0umPd3UdNEthxVU4Ok67z8xOd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAii-0007Bw-5x; Wed, 27 Aug 2025 09:37:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1urAig-002MGk-2q;
	Wed, 27 Aug 2025 09:37:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D3F6E45E20B;
	Tue, 26 Aug 2025 08:41:05 +0000 (UTC)
Date: Tue, 26 Aug 2025 10:41:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: rcsekar@samsung.com, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: use us_to_ktime() where appropriate
Message-ID: <20250826-cautious-married-marten-b7bfbe-mkl@pengutronix.de>
References: <20250825090904.248927-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="suvg33rbcecgcgws"
Content-Disposition: inline
In-Reply-To: <20250825090904.248927-1-zhao.xichao@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--suvg33rbcecgcgws
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: use us_to_ktime() where appropriate
MIME-Version: 1.0

On 25.08.2025 17:09:04, Xichao Zhao wrote:
> The tx_coalesce_usecs_irq are more suitable for using the
> us_to_ktime(). This can make the code more concise and
> enhance readability.

Applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--suvg33rbcecgcgws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmitcx4ACgkQDHRl3/mQ
kZzEGwgAjbjcWUHdVnJNioDrCF1psK0ICD6toemt7SW+wNDTVjl4r0kvkvuGs8x6
OFPjCOyCseyiLrM8t1Xmao43g6L43vOYJ4UVyYcq8Pqnw3/adsVtrMr1+DQOoEFN
1SKGtHABZZ1x5CfnexQuYoldij9KWKQ+QdMDywCvUn5ux4nReqTg4if3rwTdvNcu
Dfzjheit8aDuCp+3O+QrdfzYj9TngqXlX9KdhMu9LHCKhjK96qpdmw2t5EF1U8Wr
wMVN1IFM06tuQLV2elGccxD6aGdyOMJUYgKcj/u5xWA3zuFhHlhAG3ypJi3sD1gP
TGteVpscddwtWqMjkFyurlBiCz5f7g==
=G88F
-----END PGP SIGNATURE-----

--suvg33rbcecgcgws--

