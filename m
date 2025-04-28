Return-Path: <linux-kernel+bounces-622379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B2A9E64E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 04:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB97189B1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2217B418;
	Mon, 28 Apr 2025 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IUFsNo/g"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75612B73;
	Mon, 28 Apr 2025 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745807912; cv=none; b=RQMLCmjnZr9bF+679WyZdHrI5RR/0b1Qu5nUJgE+i/RffZevSSQdZJvmEiESFl3V8x3jIuntPWgxNM/Gd9Z6N/8UNWAaETp8no6bumxCJfRNvetCTP3WcSmopPHFgb9uoSM4lGJiI4b7gmUIMix7flDaq9y60bStqNUhlJDPmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745807912; c=relaxed/simple;
	bh=mHf/zw7mQSMZguicwqDXduGzfh4/U/r0pk7dYBh1O+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ghmZ1zhaO+l39qXnfHLksPino+CamqPWl3zRC16k7uvR94YGGf5+cMNQETsvIgx5cZUyH9egFmVsTedDwTj1k3hlwYTSagovrVwYyvu3dvc6aqsFpUFy2V+56A4n+EMOEPu1uP+Vo+vwcn2YohBXP4MEIl10JmRnP4HDf3zzouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IUFsNo/g; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1745807906;
	bh=3IVxS0/zvP44BT1vEJB/sgh1jgp6US0kzW5JEunxS8w=;
	h=Date:From:To:Cc:Subject:From;
	b=IUFsNo/gLNOFGweF8gyTvEEEPo3Fzg/7vLDOC2K4mGA8a66jE4ZDjhLcGRwPHYE9P
	 awYbtOIfsaqlE1ppbzgpsJpHgz7RjYVW8WdqilMjj2uSmVUfBOHPNgG8dAqxR3B5zq
	 R6c0TXYI/cgMgFExH8nRuPShvQ8RWQcAuxwf4yi3KoRtff8YTOltEMUg0ywH/Hxp8v
	 499MFdEV51bKj5YCD1gb9N0LQF4DvIHdWZ21ksKF9mXDtcGV50zzsitYPbWvXP4ldn
	 q9oEwnTWWR6q1Tg9RwXnScWui3olUOVeNu4SNFBicfdytMXsmfGe/FZ0ecsEdXZrLe
	 ZjY7JcwePh8pA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Zm70y1mffz4w2Q;
	Mon, 28 Apr 2025 12:38:26 +1000 (AEST)
Date: Mon, 28 Apr 2025 12:38:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Asahi Lina <lina+kernel@asahilina.net>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Subject: linux-next: manual merge of the drm-nova tree with Linus' tree
Message-ID: <20250428123825.4acf2499@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DaiD9nHtSXgpD5Ab9QoQ4Qc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/DaiD9nHtSXgpD5Ab9QoQ4Qc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-nova tree got a conflict in:

  rust/helpers/helpers.c

between commit:

  c1b4071ec3a6 ("rust: helpers: Add dma_alloc_attrs() and dma_free_attrs()")

from Linus' tree and commit:

  be8d1a24798f ("rust: drm: gem: Add GEM object abstraction")

from the drm-nova tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc rust/helpers/helpers.c
index 0aea103c16be,6c205454a18e..000000000000
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@@ -14,7 -15,7 +15,8 @@@
  #include "cpumask.c"
  #include "cred.c"
  #include "device.c"
 +#include "dma.c"
+ #include "drm.c"
  #include "err.c"
  #include "fs.c"
  #include "io.c"

--Sig_/DaiD9nHtSXgpD5Ab9QoQ4Qc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgO6iEACgkQAVBC80lX
0Gzzegf+NzdWRHFnhInSeRntLYKxwJQk3wnw1ggQVBuJkUkJpeT56ZDmzUS4IpcJ
AVfmjXe242oglG7T/gamtDg8zBfquY6fgT83ppnYkuPH1iHQLxPGkxQgyqj9DD1G
1pV8+yt1p2n915zaOCu1NV5eC1qW7ktL62cqgb9NLKlz0aw4aq6oDZWkyq+PtHYI
XeJoFb7U2RPpjh0c8QGgVF/jQyctLhx746OTvxQi2zcMAZI9vzmSneCBTh6qKe1j
lzeQ6JataERo4C0wQiZsgkEnt4KvibqYjOT7Txpp9q5pkphntzv4pWXFOIrkWkTT
GorQmaEThU/YQa7qegzqeCdEONxtBA==
=/Q7c
-----END PGP SIGNATURE-----

--Sig_/DaiD9nHtSXgpD5Ab9QoQ4Qc--

