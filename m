Return-Path: <linux-kernel+bounces-714528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A962AF68FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 06:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EE617B501
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 04:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3D8289816;
	Thu,  3 Jul 2025 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BrCv7q1+"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A06272E4A;
	Thu,  3 Jul 2025 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515543; cv=none; b=QVtgyIww7MrIjibtzCs9syuth4ft6xpbSFnKKsxcpI8YrO1wTRzjFjF1/Xe2kWONtfsKAab6BihRzko3XO4rGfuqc7LVQNUmFYyannURaF1/n5ODQLjI5r25OsjSd7SwjdMyAMNBiqPKF0A/TcACOZlzfLS1UGKgfyLIfoZiRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515543; c=relaxed/simple;
	bh=fl1tp60tDZir5VCDfyLZeFwQmbnFi3gUNsrd+fXpQwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0Wfnibog8+1x7s5UkWNmo3fs9Lrr4ezAa47ax6nnDpmGC1kolG6RCfdL74vBS7Tf34gyKoNInqrEsvjUrHAiZm224F7QRS9268Om3e8lYoAy6bPcUDoEn0JTYMFfi31DMDPmVtm/n1C7kIf414GHUND1FGK5fsPNHfK0nF1pHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BrCv7q1+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751515518;
	bh=fl1tp60tDZir5VCDfyLZeFwQmbnFi3gUNsrd+fXpQwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BrCv7q1+ou0CI6drMiTXRFirdtHdclwuQjmWLv/gatEUIE+020Cx3NEu88/27kxq4
	 7rQyUNQRY0L4Axlmc3jynHDa3VRuFyNyJaQNjGrghfiezXAFn0l1AN8DdQpv7Cv0Sp
	 l2MLaf77Rk0i3bGa22KUzagDrFI3owWVCsUGutrCiT2rvOO9OfIuGb4Aov0+eYkmOh
	 TdF6cPF+VYfq2FThvRRjuewU4Rz+NIkbvOCMicpzmErghyDEkG6QwY5K304IaCvjIJ
	 4iFkXUGOTTaGvkOqPMc5iPqD6czu4KONZpc4TM8D0PPyc/EiRgOzycH+lhndvEr/it
	 nlgTgm/5/CmFA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bXjpk4vczz4wbX;
	Thu,  3 Jul 2025 14:05:18 +1000 (AEST)
Date: Thu, 3 Jul 2025 14:05:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the bmc tree
Message-ID: <20250703140538.1d48c8d3@canb.auug.org.au>
In-Reply-To: <CACPK8XeQyZA0OgF_o1vujgu9AdR3aXKjNPGQ1djUSyk6RVhh6Q@mail.gmail.com>
References: <20250702174054.383aef05@canb.auug.org.au>
	<CACPK8XeQyZA0OgF_o1vujgu9AdR3aXKjNPGQ1djUSyk6RVhh6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZkKb+.JpGlmUGOU0Fmnw6/L";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZkKb+.JpGlmUGOU0Fmnw6/L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Thu, 3 Jul 2025 12:47:29 +0930 Joel Stanley <joel@jms.id.au> wrote:
>
> Please remove the joel/bmc.git from next. Andrew has added a new shared
> tree that will take it's place for BMC patches.

No worries, I will remove it tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZkKb+.JpGlmUGOU0Fmnw6/L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhmAZIACgkQAVBC80lX
0Gy//Qf/Y6rJDAxlt/BYDjnBI+IYkY0RQ/Cn2m/MjeQdXamev94CfQ5CLk5Mu1MF
+4NjwDhj0gBFXwmJinjVW8OkTAXks8/yXKWFMBQpfYiIVb8bPYFm/YPyhoeMI+N5
4hHRK+nuI8e2UFOkQgLRId8NkZANFMtEaZdMUQVe/k57HFjvc/aAlwxJymDOkSTQ
+5k3pzpEfew90emY7jaZb6NuikmdLipIHdjZIggQ+jsnSSic0o3Lha7lF8T48wQO
D2k9k+u00ygP83fnY1T/rumdW/m5jnH4Tq0kEgaBpMMMI+yPN81lrkaRVHrfL/YT
zXJolqNCYysn0gt6pt2/tgXtxAbmKQ==
=jtqV
-----END PGP SIGNATURE-----

--Sig_/ZkKb+.JpGlmUGOU0Fmnw6/L--

