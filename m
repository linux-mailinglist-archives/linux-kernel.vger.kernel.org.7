Return-Path: <linux-kernel+bounces-790677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25D1B3ABAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F70E173534
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E97284B2F;
	Thu, 28 Aug 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F1mAmNQb"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EE1FBE9B;
	Thu, 28 Aug 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413090; cv=none; b=IAZxQ7g26dLq0cOQs0w1GMx9Kp3NBM81H7J/vF+hqsreiBRg4GmXRTVx2InwJJ3biwq9BoojtvuaP9ZBCQI644AoF//jc/f4fIYIUACXJoK7i+wA+EurkIqz8bhn/tQDiaztsXv7iMJarTYhzan+ulyC/EK8553iIPYo+vc3SlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413090; c=relaxed/simple;
	bh=30g4i9vxra0L1qqtbLzPmRnU4+I2e4Vod9mU0FHgbE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s5P9XM7xqfBUSjnGRhAIDYc64X86Kb/z+ZGVpu4lAruqNxGzgtjHwVTZhnXdFeoSXJt5GBy6GXoDSbo9wjD12/mW8zNzOOmgKw2fCymps3SxR0TljMdXX31moZqlwAqPuj2bqMCIBH/1E/9cdXA595grDDnsyFt4ebMo3KQL/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=F1mAmNQb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1756413084;
	bh=RwNJVEfGZwApTSRST6U8VUBchZFpo3v9c3UQi8VjbBU=;
	h=Date:From:To:Cc:Subject:From;
	b=F1mAmNQbXSEVGAraEdQA2i10Vz3zK3kcO20GZgYSGVTIIz38+wBRBx1ZR0jWE4VU0
	 4D0kGJFy1hQEjZYrcyE4SzdQOt6oFH/PTh0fkbs0L/tER63YDS45+uRjdksUVhSMZH
	 ot9rLzeGWgyWF3FukCARtFcbIkrWlJEGCyTSSAmX72XwueRrGo5j2U9CZWmK2znzpG
	 zU+BYdpw0HX3/hREURzmFQz+iJj09/a6oqJANPg4krOh0LUUjAMmoGkVC8GLTtphsH
	 7OJ2lvFYGF74ZFdmqmx1jdnfC68zH1sJBbeekl//r0N0S7PjWOmRn3DlZurz7LPK/9
	 bkSbyPvYhjmUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cCY2g62TVz4wfl;
	Fri, 29 Aug 2025 06:31:23 +1000 (AEST)
Date: Fri, 29 Aug 2025 06:31:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the iwlwifi tree
Message-ID: <20250829063122.44ccf475@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Da8I98XJwc4i90oIwf=y6Di";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Da8I98XJwc4i90oIwf=y6Di
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2e426ca67ea3 ("wifi: iwlwifi: cfg: restore some 1000 series configs")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Da8I98XJwc4i90oIwf=y6Di
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiwvJoACgkQAVBC80lX
0GwgpAf9H6RIcouUX1BaQ2w6UL2NnveZTmBcBGm2jK4Ek6YyTTD3oRN8gcL6NZLr
OmhMaSKxVKNbEJIvSZmEWZLA6yGep3yryLFTtiLMRoA1uF/caZTg9tJB3J4bnY53
WmAQi298+uKPQ0cdTxSgDpkVTWpbQeR7Qb85MG70jAGKd0WPOZimr8e/Tfycy/Ie
uzo3PZkTHt47cV1bIuHoWMb3Rhzpj+W3UbYOJp3SJhPOwFBubSQZ/EU32TQXf9X+
H9KnFFUgDVndu75/dG+eKrTzo9HAm+VoNVWCBLdvrds/HaVgIeYCgPYp5Tt8aw6Y
N8rz+x08Y9Ng/tjl10Ts4/6mDgVzDg==
=L+Lg
-----END PGP SIGNATURE-----

--Sig_/Da8I98XJwc4i90oIwf=y6Di--

