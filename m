Return-Path: <linux-kernel+bounces-730786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC3B049CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9394317CEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F226D4C9;
	Mon, 14 Jul 2025 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r4KKJk2o"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943E54262;
	Mon, 14 Jul 2025 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530257; cv=none; b=Z20NSA5qXsIRh/fZE0v77YH9mt9q8HeOLHsYVcc8RCtfWeU1/N32n4XxCNz3Z24wLbIhfPUsZsvNy4PbbF9XQG3F87sC8aSswKoFVcXNMLPudZAW1DkWaYJUBm+xIg9vY1oyF+w6mKIal0grbpS0cAZSyJorwstL1RyRfUMuCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530257; c=relaxed/simple;
	bh=W6zBCmDuIz2CRHmPRDcCAvOCcLRMIEazdEguk3ViPew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qf2H/F6r2XJB4d1zMO2TTtjBH5BDmjx6Fj/HpKPtmOhkyJXKgD8IdmLo/mxQx4QS6nKjq1CuAyvq9VxwBPbqe7JH34EUDIk57C10A63E4PTgzmeJ/cMpzjFeQrBBCUXodSiVU9WzOC2Ykqs7Y3ez+pQ8PcMTkr1V/xUkU7Qov84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=r4KKJk2o; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1752530147;
	bh=pQhzG7sD3/06xgWnVCRBKKmK3jJDXBFWgZzZDnup7lk=;
	h=Date:From:To:Cc:Subject:From;
	b=r4KKJk2oNEOvvIDCw+MKkpdIy1xoBH56lvKwaRgU3CwKASob61jLxgqIxqjHDxdNX
	 rOq8PXg9KsQByeV8hWHkQmG2os9WB7/uIDe1DElefGD+xGfbX+I8D88u2ChjnxsRAJ
	 9lmtJZZxxZF8NA+kX2KYAciuDDJO6dpS9xzJhyyX2wVqkPLaUR8hPw0ULRYrUt5XTK
	 ydVmsSi9jEhpVLTD8uYyKpiTmVaug4cSVSyxpETp5tmirGW1BESWaE2lmmxNawUtBa
	 KxUt+Sj4Yj05omm2krRJzFUw2V+jBZZnbrxaSKILk8CUP/Pr5bDOamj98Uh1SqR6zS
	 wEy2HKz0SwaYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bgx2p4tyzz4wcd;
	Tue, 15 Jul 2025 07:55:46 +1000 (AEST)
Date: Tue, 15 Jul 2025 07:57:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trondmy@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the nfs tree
Message-ID: <20250715075731.52b7485e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZhmyNszuv0IxdizGlheqwS.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZhmyNszuv0IxdizGlheqwS.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  dad2fe3c563d ("NFS: drop __exit from nfs_exit_keyring")

Fixes tag

  Fixes: 2c285621176c ("nfs: create a kernel keyring")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 6a247819238d ("nfs: create a kernel keyring")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZhmyNszuv0IxdizGlheqwS.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmh1fUsACgkQAVBC80lX
0GxApQgAg2ES03GhYVDDdZAh6DMelznhLYVXzNl3VFplRZ64gGukuwH1tq9b8zwT
4PwMfqgp+hI8hkHJ8azUA52MEYwsm8mdqsJo4FlPX+omGow0OWaWIJYJeXltid/r
c3XdteDt54TmbAJ8ScP6IgR05jX3SX1QyZ8CKSWVf1D2eETI7ZWOM0/RvngAWqQ5
6vxJUvrz+w7M5OAlWKsa4NNuDtUT3+VV9NXuo74/CCE4x1Ps0i6pI7fUqvxeRMk5
+qLfqagSiQ80SSwRoRy/0nPa+XzXbsgGw5gmkiIZhhcYu5aYzs+V24FjqNNmkjgA
EsRwrUzm8omEtMe+lPndeRN+JcMdZg==
=DO4P
-----END PGP SIGNATURE-----

--Sig_/ZhmyNszuv0IxdizGlheqwS.--

