Return-Path: <linux-kernel+bounces-749350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2FFB14D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9064D544EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0D28F51D;
	Tue, 29 Jul 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="emGrZc00"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26E239E62;
	Tue, 29 Jul 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790118; cv=none; b=C9I1SgXOmxJj0Ep8hxVhqbAyEstQKbjofnAz7Fyy/atTPhigfTbk2HTuubMOtHLzoNNJDbSeAcnrJ4WEnTlTog/OLgUEE41Q2O+Kth067WkJZGu2GsRfcvbCRhtf9NbJN3ZNjWMis22XvgGspYI19OABgIrssqYCMRdC9L42D0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790118; c=relaxed/simple;
	bh=0dGAnNg2UXVYDpvGLnTKAdA/H53faaIz+tELnHOHvOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGnbkjCq/HL+73iGX0ZdpZHF3d234pqKC9DYaVDJxWTfjz/BBcHvlhwKYzQTyr1mUJuyA+e2eV3xjpUQiEuLRTUCNOIv/oc7lEXljw7tHqvB+poREhpPUH7VxRJC2XYH46nykfEdhwV+OEpQVRMI2B3lOWmspqAzg+T1hApKyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=emGrZc00; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 487811C008E; Tue, 29 Jul 2025 13:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753790106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37eDtzrvLLDSDFVXQndXsows899L9rLYzxx5sKRYaq8=;
	b=emGrZc00AWqlPVsCcBuyL0oaNou0bIo63s4od92HeoH2ncTtRWB4nwzvtaep91APEzgfnr
	SARVhrhu90QbeqiDIJICyrt8idXKl0jNU3niiOZ36WDSBObDULtrQjU6hhAhCJKjjbic9B
	9WKrurumaa28k8CIG8oC7I3sbl2jAp4=
Date: Tue, 29 Jul 2025 13:55:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] staging: sound: Adjust mutex unlock order
Message-ID: <aIi2mfHOksrr5RNB@duo.ucw.cz>
References: <20250716062331.375090-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PZUGyl5t52Dd9iQE"
Content-Disposition: inline
In-Reply-To: <20250716062331.375090-1-karanja99erick@gmail.com>


--PZUGyl5t52Dd9iQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2025-07-16 09:23:30, Erick Karanja wrote:
> The mutexes qdev_mutex and chip->mutex are acquired in that order
> throughout the driver. To preserve proper lock hierarchy and avoid
> potential deadlocks, they must be released in the reverse order
> of acquisition.

Please explain how the deadlock would happen.

								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--PZUGyl5t52Dd9iQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIi2mQAKCRAw5/Bqldv6
8rbfAJ0R9dtUL/puuFcny3upcaaUpdYw1QCgnyEc31T76dn0r6CqLmLh9uH25Mg=
=nK0I
-----END PGP SIGNATURE-----

--PZUGyl5t52Dd9iQE--

