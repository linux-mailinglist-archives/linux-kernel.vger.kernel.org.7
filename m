Return-Path: <linux-kernel+bounces-790740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E5B3AC70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4053A7C7E92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10112D6409;
	Thu, 28 Aug 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JcBLfOTU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABF305075
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414952; cv=none; b=LaxXSsfnQ8+5hvQRcygefLwQSJM1dSvnyXneb5xxP9ed3fIZ0outCDxfz+SpnJ+BlygYsmBboVJD68sSRbAw9M1gCaIhPHfDFB+pXTH2xVhbVTCtYoV/q4WOXPI7sQ2glbRbh+RD+AE0cJMDoM9/RVbvqkIWQZDb8qTtUGbI1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414952; c=relaxed/simple;
	bh=+uhGjh7Bn3uOymHdOEWWzg7tt6DiT6h7ooyNGhpADVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7RxjJo02PEyqceQYGi/Od5SR+dcbohbCqdwg6oXMkHhC8B8FJrH9eqdWBRP7lsqKJAMDy8/tJoq4ltr8ZJFmYZeEOU2mv6CGBwY7OYiSjZWbFxkYKX0lBsbrSEn78z672B0heYQQnb59Tz6dbk96NvXToPHnvs0jgkNAGhTL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JcBLfOTU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1756414946;
	bh=n1G3l3//V3/ZMhJKkM/EbLpc11PG2PTLkGdW4WQeIYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JcBLfOTUBPHP/Z0EzP9AhF9TR3uPHdo9FDKKBVowPVhRA1GOn1aFZgWjNcwIZlArP
	 YX15lAxxH/mDDNfFvmzE+FC5jnlX9S42sVc6q7cULlnm9mSUtoMBCeJqH0kJFOOZPY
	 /gp+roJC83mBw/ALdEKbyA81VmddPg1hxwX+ix9B8VYWQRWtQqZvRaSSh1spJ36v6y
	 YW1vAUCTIdTcTXNbFJXPv7kJ/KTFpeumtul4P8DWOphXXuRo9dq9oZXnKkidUrR68F
	 yz9XMSfziK0RDno2otrN25xmcGlJ6f9Ttkg55PBJs3VcXIY+HwFXkbC5xEd6UAn74I
	 5rtTc9h7YUhWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cCYkT37Rvz4wfq;
	Fri, 29 Aug 2025 07:02:25 +1000 (AEST)
Date: Fri, 29 Aug 2025 07:02:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [for-next][PATCH 0/3] tracing: Trigger a warning on build if a
 tracepoint is defined but unused
Message-ID: <20250829070224.503ddc8a@canb.auug.org.au>
In-Reply-To: <20250828182754.733989525@kernel.org>
References: <20250828182754.733989525@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k6.s4V9GhcxwPSBgRWnSwy6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/k6.s4V9GhcxwPSBgRWnSwy6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, 28 Aug 2025 14:27:54 -0400 Steven Rostedt <rostedt@kernel.org> wrot=
e:
>
> I built this against all archs in my tree (26 of them) with a allyesconfi=
g.
> Unfortunately, only 10 build successfully with that (they all build
> successfully with defconfig and this option with tracing enabled). This
> detected 178 unique tracepoints that are defined and not used:
>=20
> $ grep '^warning:' /work/autotest/cross-unused-traceevnts.log | sort -u |=
wc -l
> 178
>=20
> Among them, 78 tracepoints were created and never referenced.
>=20
> $ grep '^warning:' /work/autotest/cross-unused-traceevents.log | sort -u =
|cut -d"'" -f2 |
>     while read a ; do if ! git grep -q trace_$a ; then echo $a; fi ; done=
 | wc -l
> 78
>=20
> The 100 remaining are likely in strange #ifdef CONFIG combinations where =
an
> allyesconfig defines the tracepoint but doesn't enable the code that uses
> them.

[Pretending to be Linus :-)]

So, have you fixed up the 178 new warnings you know about?  I cannot
possibly do that, or even notify the offenders.  Please do that before
adding this code to linux-next.

But, really, these known warnings can just make it so much harder to
notice new ones.
--=20
Cheers,
Stephen Rothwell

--Sig_/k6.s4V9GhcxwPSBgRWnSwy6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiww+AACgkQAVBC80lX
0GxH7Af+PI41gk/is+FpGOfBJDFaasIeXr4ZDlczAaI5kkS4C+72BM4wtcyPgJpe
4CB13SjYMl7NcT+BxGa7JeQl2Ab+ipt6ZcUfAp+mlsz7Pew5S0xMBwCHx0JMMptY
udB+Y8o76dV9ddAiBAn7ROWtqZ67sUUaEHnCJ8ylBnK5PabgcnwVvqTWbcMAfwnk
GDblBg+M/EUNqv7h+egNLASbFxbifUHK2KAkyYcC5znWyK+YIX6we0dBznBdMHOL
lSUgbgUn/bcxt+xd8AUMpb0AGJsGhVD0j/T785XlT+eETH1E1ZiIo0lVMa5qJH5e
7EfNxZJ60uwb4KVqQfeQrMioMc34Kg==
=k72E
-----END PGP SIGNATURE-----

--Sig_/k6.s4V9GhcxwPSBgRWnSwy6--

