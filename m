Return-Path: <linux-kernel+bounces-815718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E1B56A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EB417D2C3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10CC2DC33F;
	Sun, 14 Sep 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3QdzTyS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085E2D12F1;
	Sun, 14 Sep 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864666; cv=none; b=mLCxsD6N9ijJKGkpqb7KyVPA4Uc0rJMDCkoT5eKEPrawoZaEoaPLNKXQAfZ8/0eaijNlJG8dnSqxtY2UQ0DTWAuJ+i8nM11OtzhsaErotaFN3KPX+EDbSxJmAx5Fep4OHMk9vKLR9zxmJuzgWDxekNiL5SKJoPs7W0i0inFbXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864666; c=relaxed/simple;
	bh=go4fbgG+AD8O+A1V17pC3IWuPz61hjCCsjI7QEuyln4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj0NcBcALreyNpvQJ4BZrMqbOo+KnU/Q+4gc52YpFpMMK+dZe1SbBIsC8WBQEHcRcIcGxnp6RaW/kwklaVdGV1Q3aCqLww1b7m56EmsB195yCJV/KKOkiClEpvM2vrSmlXaCL9TcYFIOkxAtQCzhqtBCWRbTfaPQVAl5LsEnCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3QdzTyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD65C4CEF0;
	Sun, 14 Sep 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757864665;
	bh=go4fbgG+AD8O+A1V17pC3IWuPz61hjCCsjI7QEuyln4=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To:From;
	b=P3QdzTyScG1lAhJeL+vFnLF5trdO/dfD/V8wu3ABJe8RIkt5zs9Y6mT8asP3B6hqL
	 zyEOPGBtd2TUkRRzLjjGr/jHqQvVIcVdBrXnQtZZ0C4N6d9sV9cpbtPOG+jyQYdr8g
	 3nX0NDo0zcGLt0Frg8yp6jpB7vAroKpMzf4XmgshC1rcYhouChYjRX3zOyLVfMwzVg
	 q6BldCdEdW9XkMfb5kRt2pMNIxqZn7UbNiGPpBxioHDaWBYj8k0lH4AJnyzrXrL4th
	 1ZlrssRfDHu/MiiFNcnvzI9pPKf5/jHp1k++z/GvrPkv6HXOULDxasu2/yH31qMmav
	 G4cMfE9L3bEAA==
Date: Sun, 14 Sep 2025 16:44:21 +0100
From: Conor Dooley <conor@kernel.org>
To: patchwork-bot+linux-riscv@kernel.org
Cc: Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, guodong@riscstar.com, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH] riscv: defconfig: run savedefconfig to reorder it
Message-ID: <20250914-rendering-afar-dd97b3a2505f@spud>
References: <20250611-01-riscv-defconfig-v1-1-b48fc3517498@gentoo.org>
 <174976442875.118664.14858626447477465303.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="piIculNeLXDMcyrI"
Content-Disposition: inline
In-Reply-To: <174976442875.118664.14858626447477465303.git-patchwork-notify@kernel.org>


--piIculNeLXDMcyrI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Paul,

On Thu, Jun 12, 2025 at 09:40:28PM +0000, patchwork-bot+linux-riscv@kernel.=
org wrote:
> Hello:
>=20
> This patch was applied to riscv/linux.git (for-next)
> by Palmer Dabbelt <palmer@dabbelt.com>:
>=20
> On Wed, 11 Jun 2025 22:56:04 +0800 you wrote:
> > Changes to defconfig should be always updated via 'make
> > savedefconfig', run this command to make it aligned again.
> >=20
> > This will ease the effort of reviewing changes of defconfig
> > in the future.
> >=20
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - riscv: defconfig: run savedefconfig to reorder it
>     https://git.kernel.org/riscv/c/d958097bdf88

This got lost in the 6.17 "incident". I applied it to my branch that I
collect defconfig stuff for SoCs on as it is a prereq for some spacemit
stuff that I was grabbing. It's up on my korg repo as a tag if you need
or want to pull it in:

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ tags/ris=
cv-savedefconfig-6.18

for you to fetch changes up to 125c62df09a3fa4143298658340f093d2bd364a6:

  riscv: defconfig: run savedefconfig to reorder it (2025-09-14 16:34:42 +0=
100)

----------------------------------------------------------------
riscv-savedefconfig-6.18

----------------------------------------------------------------
Yixun Lan (1):
      riscv: defconfig: run savedefconfig to reorder it

 arch/riscv/configs/defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--piIculNeLXDMcyrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMbi1QAKCRB4tDGHoIJi
0vquAP0U+9G5MAqk077lLuT4dfODkjR97SP5TFmveINFUmnT7AEAm8Wp/y80V3xq
l/2Bq/TK5plRQs+u3MwLDoB1EMqvHg4=
=QwpP
-----END PGP SIGNATURE-----

--piIculNeLXDMcyrI--

