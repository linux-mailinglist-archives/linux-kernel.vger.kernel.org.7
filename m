Return-Path: <linux-kernel+bounces-623948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E1A9FD04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEFB1A87BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFAE21147C;
	Mon, 28 Apr 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aONZ45E1"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F34210F4B;
	Mon, 28 Apr 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878862; cv=none; b=VFRJJd6FCA56o+3jEMh3zZpBfp5vA5mn5/i88LcNVi19ndXn7TeWpJu24WftfDmbxO+x6kvyp41dOeOuIGPRIUFNt5PR+lROUOBByeUFA0NacF+8BN2cy6DALi6GZW4uvTnGQW8pYdEv4Qu5Hbw7xn264Z9j0bHtsSFZQ5A4TC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878862; c=relaxed/simple;
	bh=qnSAkG9hqAC+/p1UOTzSEP0v82VdoVH2Vq1AfQ7JzWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bCBlvGL///elPb9u0ziHQEADHiKEoLyV4cFqOH37So5avWBiVYJyk/gmNn2IuU9B+yDRWNv3zh0+NZ9f+TQPPakh8GkSPODcf8wh0zgJNMHSUdsM7rkUMMBHQwwgHaFkE1OpgUAjwTtM4mjAWD3097n8PuSadSBUx2RbqXBb82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aONZ45E1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1745878848;
	bh=qnSAkG9hqAC+/p1UOTzSEP0v82VdoVH2Vq1AfQ7JzWE=;
	h=Date:From:To:Cc:Subject:From;
	b=aONZ45E1AZMWPvyyFaRrj54CoaRQZhV6hER3kJATwNc6F77JSnp9tNNKlGxNprMCJ
	 bhRJQ0//uLoxDGfCsRoEnOezdLflARSe9m1tZeyZnqVREPTYz95SNmaKra2FvrJbj2
	 pkcuRbkLBISKBvB4Ue7WYdk4SCaXWVBfvfO9dQuVcsUiGSHX3TPoufKKvAYKaZ/pAu
	 qszy4wr+yw/fK5u5DjWlI+Dm8DJGy+WdBZcddb+iKt3gsJhPLSXTxn0xLis/eTa9rh
	 GZeDNFkSl6H8UOiYHN2GcEhMAEiRUjrCAi+njmREemjLNu0VYtxBKEPdlmRIjotvVe
	 VBnNe5I+miocA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZmdFD2b9Mz4wj2;
	Tue, 29 Apr 2025 08:20:48 +1000 (AEST)
Date: Tue, 29 Apr 2025 08:20:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error trying to fetch the clockevents tree
Message-ID: <20250429082047.4af75695@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mNn1+HX42sPOH5zMzRkw94v";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mNn1+HX42sPOH5zMzRkw94v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the clockevents tree produces this error:

fatal: unable to access 'https://git.linaro.org/people/daniel.lezcano/linux=
.git/': The requested URL returned error: 503

--=20
Cheers,
Stephen Rothwell

--Sig_/mNn1+HX42sPOH5zMzRkw94v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgP/z8ACgkQAVBC80lX
0GwEyAgAhQjUa4RN7EfPRQjh987F60/zbLrvpsn/Df5W5TbaHdAzblMVdDDKtbA+
QbCsZJDOox8CggvdkqGnTl0djCGZij+WCwBsZgqg/mjrsXypwVOvBJcrlXyY7O2S
FNglja2giYNfhagwf+etB+JPE+xBvV+KgXGMlhnBSxeF9s8O31JMmAHZ1R0GRp8W
Ka2kPTBl1/SiHFElSLHFRwryjZpcjTLOkgs/tLlPZkstYQl1Us7BdPyVxh+gOyXI
AO67+EJXABf5DB13k0QnESdgc4pIUcQIWQwEZZNynWWsp3PKrcyviCwBVEaxNQAy
nUpttYm/AZ/uZzCRDwyZ3trtZUtAoA==
=Hjs8
-----END PGP SIGNATURE-----

--Sig_/mNn1+HX42sPOH5zMzRkw94v--

