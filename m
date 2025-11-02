Return-Path: <linux-kernel+bounces-881998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B9C296BF
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B1384E64E2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A56238C2A;
	Sun,  2 Nov 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="POaK8z3Z"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31742220F5C;
	Sun,  2 Nov 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116734; cv=none; b=c52Bl7cixv4yhbqwXZK/GMbnlBOPz6oNTjw4b1nDbDblrLpe3Eg1uFLvNRxbRSlzPjyTO/log6B/dyUeaKGWmGIvH+mScbkDzmMd9f/w9XX+801LPLcGLZ+r/Z0OgevZU2zGI+vZuCEJn14N3A1ZjsujEOgUWG8GJFAIPJv1ih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116734; c=relaxed/simple;
	bh=AYbaMUup+hhbPO9ihL2r95ijCIkJnRn2AKRIPV5YsRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XXGjVXy8rravHHmI1vXyak4ZLIQTRCKi1ySg13kfLVRoGHwtTyppTKP1xh6KS3rjByHVWohUVStjyuRyIkn2EI5aaJg9/X6fb41fCN/zAW3aeRZepyIpEoJN4VJDfcrLZgezIQ9tRaQc4u9T2GuwCJ5Odi/zl+YRZOTHpumpC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=POaK8z3Z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1762116722;
	bh=cvpykRTBeM12OrQtwjQzkcdyCZR5QmB8mJlYSQcMamM=;
	h=Date:From:To:Cc:Subject:From;
	b=POaK8z3ZJdF1sYxjPtrlatT3m6amFXAqETS2+lURYweQUJ7s+lDLSaboo6M1gtGJY
	 2QRdYGWQ1YWcJRxtDc8bXUusZviS/hGuT41jmmtXSFyK4h59/FnC/TWEvwSleN2m/x
	 ENqeq3jj4aBHxv+6mRDugnIZWeOiiL4I/4wq/HeUPh93SSLO7eI0ptNSTncGYh+eAS
	 Ps817iGqz3vsfTl46v6bmpX3xjOpxO+5RXIEjyAqGM0axq3udd3U41fy0PvKdLRQAI
	 XCw8iO1SATfOkLu1Y7wNQTn9Z9v39wWI3Wcjd/BBAxvLMtF64alOsufZ2O7PGZoaxD
	 Nu3XNlWxqVjzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4d06N11bnmz4wC8;
	Mon, 03 Nov 2025 07:52:00 +1100 (AEDT)
Date: Mon, 3 Nov 2025 07:52:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nolibc tree
Message-ID: <20251103075200.7961a782@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MaZX=jXQmFdW=vyL0f848Mo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MaZX=jXQmFdW=vyL0f848Mo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  926b414bee07 ("tools/nolibc: clean up outdated comments in generic arch.h=
")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/MaZX=jXQmFdW=vyL0f848Mo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkHxHAACgkQAVBC80lX
0GwaKAf9HmbZRbmqONwBzPmIo/mSry7RjQlaL0smSAPdjmcxPmKYBw+Y6uhqUzd9
vue2XH7CabvXsteB5pYE1Ln1nWOUUGZQQE1iqF7j3RzAP7BnCnd5WoP/DDrrFF+U
NGRNDbktKP8yGzvflp/v6oecGc7hLTcBLi+Oth/7hoffTRKQt1PUv4PZkIKMVg8d
9ArpdApjRSvBkiqTsPoWIRsrQprTwtwMdnM0wx0y7zshdLJoX2rtXF1DPnRE4DG+
G+PKG82gAlml+JuYdCnJAOgim3WXRE95sE/WXs6aLu2r0F+X4myhS3OGQjFVlnqw
+DMPi4+tWyzYlSfu4yHgDQnxMAQJ3Q==
=u+07
-----END PGP SIGNATURE-----

--Sig_/MaZX=jXQmFdW=vyL0f848Mo--

