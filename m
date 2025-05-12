Return-Path: <linux-kernel+bounces-643556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D6AB2EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 07:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B74189A218
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 05:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D9254B05;
	Mon, 12 May 2025 05:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="egiDyI1z"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8352AE9A;
	Mon, 12 May 2025 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747026289; cv=none; b=g6St6Ui/H+6M2Sydr74ZigLJuX6xGRJx0fdlhRfQPNXTFiDIk+rxbcfEalkxXjkXklV4NnmiKJhk29k+atqhg8csab2Nhcbqh8vNEGtaGg+FiqHaqUVRfM4S6L86Fd5LYTCsvoOOg0/Fu++l4OuHy1S/otl3Jxl66FkUwtWu0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747026289; c=relaxed/simple;
	bh=XAoFjuQvQsWV+H1+kfrzlMLYjZJcKORbcZmrz3P7Oo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Hu90dmhAL79iv9n3ewGkWFTfqp5bsgGk3I+1SHkCjCZj53zjNJmm7nG7tsjQaDXOgjnELuCvtTtBnbyZ8p/RlnQEso9bmBhaDrgisWUuQzlHXNG8PPIHUyYJ/mZlcdT2pRf7bdeHaNC2PaEQ/3fDQYB1t2XoYEZ7sWqmNCTzj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=egiDyI1z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1747026285;
	bh=s05YbP8VAA5XOJBl6J4iOXa+L1O0JquzuLJRh0myjgk=;
	h=Date:From:To:Cc:Subject:From;
	b=egiDyI1z+9/7707w+yQXbI9gg4uProJsyD4rWJq6RS+6qOEt45MyoRPm9KnbocbUK
	 na0pzloG9H1oirIesOzl1FTfxb5F9BbzJMat0y7uxpRud1+FpZnXV32fF3YWn1buvb
	 XGpuagoSM48O77V7+EmyEAWf/5DmXdDidYzLWFso9A3Vb6UJ8UTfP8UWz7yiCK5Qz5
	 Dg2jyNMqv7lhOfWoscmdwT1ljkmVNMVv7divEkUcfgT08NFP0PB5xmK55Vda/Fgm0r
	 hUn16JFi66fE2rryf9S1BZX/HJ2Uz1PGvfZR9NKoAsmdpEhbZmpnv+wFI62/Hbk7x3
	 nh/rJ4heBljbQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZwnbK3tcQz4x1t;
	Mon, 12 May 2025 15:04:45 +1000 (AEST)
Date: Mon, 12 May 2025 15:04:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tip tree
Message-ID: <20250512150445.10b9b4e9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9wr023pbJA5HsfoDdY48ZPC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9wr023pbJA5HsfoDdY48ZPC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm-nonmm-unstable tree as a different
commit (but the same patch):

  3e816361e94a ("sched/tracepoints: Move and extend the sched_process_exit(=
) tracepoint")

This is commit

  594ce0161914 ("exit: move and extend sched_process_exit() tracepoint")

in the mm-nonmm-unstable tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9wr023pbJA5HsfoDdY48ZPC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmghgW0ACgkQAVBC80lX
0GzaUgf+Jpd/qQar0CZY11jQHM55uAvxpebaTbh8gG+aelqjHLczapDo1JtH1M2M
5sFIvclQGg7SqJAO6eko44YZg4FaJn1MbHiu6tnxULsMHIpmfKej4FMiXjQ+iyJb
2vY2Idx/HuJFRlfu2HMzavntlskwrS4M7YRzTj6yn40w+2q/ihh8WmAmhwyO+uUv
MuCqWbS1ILu2b1Umtgc56uklj/WoOEHL5NzmcK7JQ4god1B6eKLLHH4BB1tbxFFy
6MFlXfx7rxreQtMWlBGFxWZaGtZqTYV6bN8cyWA4taxTMAmbTJzrvyzEJFbjpZ2V
6mxRryFF27DZZ6qbdnhr17bV2oqq2A==
=5D4i
-----END PGP SIGNATURE-----

--Sig_/9wr023pbJA5HsfoDdY48ZPC--

