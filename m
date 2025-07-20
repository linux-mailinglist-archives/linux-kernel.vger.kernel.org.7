Return-Path: <linux-kernel+bounces-738479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E6B0B8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0BE3ADAB3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693E22A7E6;
	Sun, 20 Jul 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Fq04CDds"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7F1A3150;
	Sun, 20 Jul 2025 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051221; cv=none; b=U7to7pisO1CbPxHeNj/5sGlaNJZQQWDzzVY0uX77Hh1g4rCL1nx8AonQDzQsw2jU1mp9bwFlG14n4jp7/PN5FnqbFBP5y9t8dwjzeAfvrx7AteXfSrJMVS606b5rSwgNR9yAq2YQsfEXxNaFtthQFKuBHu6gbPjpzG37HjB/w6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051221; c=relaxed/simple;
	bh=L7N7kSpO+fLKTjGmJYRDtgjiUzXRfeAG+ngzvsIOxOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OU1BuN27+OvDufDGxkB7PpzNF7b0L+nM55oqmGE71ITtlC4SXEefbctafoywIofqEN+fjfv2v8eYd2hPe/gM2f09TXOgdFxhk+p4BxxkCVwzAi+Rb/yzv4gm0XeIOOx2YjpHc5mInoCmD9fnEeRkGLiI2EKyFrdRGuCBrSC4o7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Fq04CDds; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1753051060;
	bh=Fi4m+hfkSR1OGRF/OgCazkQdnpiOrAABvCi9AIjgj/A=;
	h=Date:From:To:Cc:Subject:From;
	b=Fq04CDdsvkx22EJGJ7Kl/qRvMh1VOayHlx3zxC/C3CWhp7XCHL7tv9ottwaOHb85o
	 GI6GZsKvMHD3KVDbNjnXJwuR8AVN8HDp/Y6Ywpz5bjKh9YO55kQ4yZ6uV9Mk+B9rlO
	 hUCk6fBnxMqoxgsT5+NMp3aEvbxPcRRkZ9gFX2HUnMGR7lLmZWxkiQbXEjreVLuepC
	 84BvwtAWCCFPR97+if58oKT0gfYKN7IndiKuDD8GFraefnnCdlhu3JU6unAJ2JRXsU
	 HC16YLJdOPEaxIX616jdytZr1u48cP3g/1UQDXEexdQYk7W16V7I3IASX90uF6Up78
	 Jimp48veBpRew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bldhN0SB7z4wcZ;
	Mon, 21 Jul 2025 08:37:39 +1000 (AEST)
Date: Mon, 21 Jul 2025 08:40:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hector Martin <marcan@marcan.st>
Cc: Sven@web.codeaurora.org, "Peter <sven"@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the asahi-soc tree
Message-ID: <20250721084007.341abfe2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vYUuiPlJEEvrPDUOS9sRtQK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vYUuiPlJEEvrPDUOS9sRtQK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a622259af9eb ("arm64: dts: apple: Add bit offset to PMIC NVMEM node names=
")

Fixes tag

  Fixes: 14b7178a76e2 ("arm64: dts: apple: Add PMIC NVMEM")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d8bf82081c9e ("arm64: dts: apple: Add PMIC NVMEM")

--=20
Cheers,
Stephen Rothwell

--Sig_/vYUuiPlJEEvrPDUOS9sRtQK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmh9cEcACgkQAVBC80lX
0GyKEgf+K4EF0VRD+ohVOaJsixvq/zhlYPW2YgyeMNICBQyoBHeY1tWvszLguuIX
nvGoK35Ivcg8X3pS8AHBE86QrqoRfl6ctOVMht4v/dfXHtTNJKmo7sgHia1Otx21
ddSkfbAvvZAROuC3xyR/QlNBO41+fABgfbNEoHspLa+e9EzsArOXXNATWNMBer2S
3ns0RuH+YX3Emuvx2vbD3tGLxOh9qSORrEzxPOKPV8Dr9gPO21Ol79pXFFfviXUf
67OfO920UA5pQQ8PYEWTieVWENsYEG/jU4LM93JvCfweuV73nShadylXpONKnlYf
VrVwq23X4NBGS4tkg60iN2JCoKz0lQ==
=akJT
-----END PGP SIGNATURE-----

--Sig_/vYUuiPlJEEvrPDUOS9sRtQK--

