Return-Path: <linux-kernel+bounces-772731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6189FB296E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B2C189B8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857B248867;
	Mon, 18 Aug 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e0Ei1AGh"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA9221FBD;
	Mon, 18 Aug 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483659; cv=none; b=qR+jcCMT+H0OqnSZvZ3QlT1+7lCmxD5TD5ldDoxULpRXwbIKLJB5qCa3YtyTRjACrzDkec68gHYc/zvy4LWxbUZZ7Mzqw6JLYA19dc0vnGewVBlivAW4sRlyJ+saK0jGDnrOLmWcwucX3QRxLcIkLjqyyksxsWnw+VOQATcsLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483659; c=relaxed/simple;
	bh=wFFY6Y1z8mkKZV6fJ9NdHzhb9mcxeSaRV8HDOGEU2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CyHuRtBU9kwFpzraKzwOVN4K+0dGkcsH7xeY1tXIOra75sOjOobIJuDwq4si9Te54PLbNrCqGOp+huJSlL6VTVWNZFqW/NrWW33bNmUXcJxcibOnefBEBgXEx68ph/iRBtYLtoUHkdwshmPrX60sLI+Yg1ZiOz070zWb+H5JYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=e0Ei1AGh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1755483655;
	bh=e4WJeoY+sT0i+glkr2xZTCFn5C1cuz7QBLe+xX0etfY=;
	h=Date:From:To:Cc:Subject:From;
	b=e0Ei1AGhJtaW5tb6jMoMUVOsqXhkUk588paWEl9bW9Y7dIPK67l8/y9Dhi+KPLr7e
	 uK+woIf4t6PdoXRd9z2HNSsM2dTgHT64xQq1tpQYrJ9USQr4B4QEEuS2FENKStVeFg
	 4Lbnvkx6UPW9NvUAjPEb+uRanuWatGaIFHkVsIZDBcDn2aS0HNJW0kpIgoPhEFTDz9
	 MW4Q1rhBpvx1zmTBUJvy7sO4E+QX4Sv75uwZeG+0yNTdGknUsgDFK8+PH2WGS/KNBd
	 EpEuvH7xKeM6AcwKR2pHSjqF6zx4Nq0A0+4AcdBaMj+LuMD8uHh5eV+IjZQTPRjDKq
	 nOJOH+fbcWfYQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4c4xK20zG3z4wbd;
	Mon, 18 Aug 2025 12:20:54 +1000 (AEST)
Date: Mon, 18 Aug 2025 12:20:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Vitaly Wool <vitaly.wool@konsulko.se>
Subject: linux-next: manual merge of the rust-alloc tree with the
 mm-unstable tree
Message-ID: <20250818122053.355aab17@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WeXLFtwET+VHwIYR3eHxXKn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/WeXLFtwET+VHwIYR3eHxXKn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust-alloc tree got a conflict in:

  rust/kernel/alloc.rs

between commit:

  defab7872312 ("rust: add support for NUMA ids in allocations")

from the mm-unstable tree and commit:

  1b1a946dc2b5 ("rust: alloc: specify the minimum alignment of each allocat=
or")

from the rust-alloc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc rust/kernel/alloc.rs
index b39c279236f5,907301334d8c..000000000000
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@@ -164,7 -137,15 +164,15 @@@ impl NumaNode=20
  /// - Implementers must ensure that all trait functions abide by the guar=
antees documented in the
  ///   `# Guarantees` sections.
  pub unsafe trait Allocator {
+     /// The minimum alignment satisfied by all allocations from this allo=
cator.
+     ///
+     /// # Guarantees
+     ///
+     /// Any pointer allocated by this allocator is guaranteed to be align=
ed to `MIN_ALIGN` even if
+     /// the requested layout has a smaller alignment.
+     const MIN_ALIGN: usize;
+=20
 -    /// Allocate memory based on `layout` and `flags`.
 +    /// Allocate memory based on `layout`, `flags` and `nid`.
      ///
      /// On success, returns a buffer represented as `NonNull<[u8]>` that =
satisfies the layout
      /// constraints (i.e. minimum size and alignment as specified by `lay=
out`).

--Sig_/WeXLFtwET+VHwIYR3eHxXKn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiijgUACgkQAVBC80lX
0GyL+Af/R+fNw42l3RXkbAn6PlS9VG44J1v4eIchQRPgvSHkvE3IM1XPKGpEYvab
xyh8vw61mRkATJYY78X7aOFLtyd3M7KkHjsVbWpK3Vz04QiX6unVaOhKb8DrgD7S
9USGBeKxKGrJg8d1esm1vIbRCkBcR1Pjiz0UEHq+3b+Kk6H+A9fhwsHfzUhUM5ps
R7x0sw1nabZUswZhXrl3mhdJEcHbTVuZqWu4sDD75v9RzexzIQ9LyyyYsQuQ3Iv1
bek7VPcFkuTp60XDIMS/lqSEpEy15RK+PY/apS4OGiFlEWJT9+QNzyVHtd/ooZAD
iI1wPa9cBKYXVkkY49JiOMb78U3+yA==
=WX2B
-----END PGP SIGNATURE-----

--Sig_/WeXLFtwET+VHwIYR3eHxXKn--

