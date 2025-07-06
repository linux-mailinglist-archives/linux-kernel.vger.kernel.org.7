Return-Path: <linux-kernel+bounces-718545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E3AFA2E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 05:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CAF3B1804
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066D1990D9;
	Sun,  6 Jul 2025 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C6cSl0n4"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15536610D;
	Sun,  6 Jul 2025 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751774254; cv=none; b=knBsp9C6+2TXX7ZimO41FBB7yewfkLcA4iNyrdlkXTnRoJhuszUv0ElLqsFFSM2/ztxFE10XVTbF2iLSh7huWeLBal0iVyM+P7d/ub6JD9ge0zmgZ1Oms/SypMHXsGHdu2JwW/HBysjUkp56MbshAcAcvWhq9uFVWjxoabSMdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751774254; c=relaxed/simple;
	bh=Rx1JyxegzFIQK4tVItKzGHgdZz2Rc6omrsmPzvbRRCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uZnmvtG8W78USbgMSDuO1+MRDUh9F7S2kUYuFIOPfS7TrYA1v6c/u80cu0n/+BAF/tnKMZNt+IdTiTOUKMXMUMrQPoE0MDTJKLQiu5JZ4lISKGAEPIHmgXQEMRGSZ3qnKyl2vk4XH3Drvk75wBWXjGL1c+nAej6BZ9Ra3yEgBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=C6cSl0n4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751773695;
	bh=x7P/zlPuI+UXIwfl3tKst5KlD1UwibDUUwj+Izaz3Bw=;
	h=Date:From:To:Cc:Subject:From;
	b=C6cSl0n4E2PZ38swJWYO03H8GBa+UY1mmGYmc5E0wfZr5QtrvnexNyC9nnY92T9e5
	 AUgjrOEEDP+bSskkeD6LZt2Vq5RlD8irUniFvAWwENfYLumw++vC1SNBXoq7PffCX6
	 PN+jDTx6dpCl5utnZ3r0O/A0b8viVCfea6lNW5dXSJhyhK+I4wNeUDmPRKfx/zIrOU
	 YRp+0o3dy5PpJZanvkqaqq9H1r0JVDg24o+FKP2VXXk/JKmwKpKiPFA76DTFPOCYdq
	 gygNFlL0WtD9NnOQzMB/vWOcj4YfXfbxzFSugC7gn7Ud1jbGsyj5AzD5csyqdGSvVr
	 bOiRSFyOVfaOA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bZYHf6cX6z4wb0;
	Sun,  6 Jul 2025 13:48:14 +1000 (AEST)
Date: Sun, 6 Jul 2025 13:48:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: no release on Monday
Message-ID: <20250706134853.549505dd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/47rlk/C+7trYJhvAktsmM=L";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/47rlk/C+7trYJhvAktsmM=L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no release on Monday.  Normal service will resume on Tuesday.

--=20
Cheers,
Stephen Rothwell

--Sig_/47rlk/C+7trYJhvAktsmM=L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhp8iUACgkQAVBC80lX
0GxEJwf/XuPHOaytAXLwThc/ufae/k9RTRhiTHjK8SYrimQCHqHdpNaou0FgyxO5
YkXDzTwi0cnZaUp03kF9GBJ+7fi3/zfMpylzYgUAjRhFNaERv64U94g5mYuey6n0
aX0kCX7IjYM4fooIazT6sN+MvuZ49JQTFY95u/RSi2XwHOPX5y+gaBIwjHgeAE7F
4cAg+qpfYoCxVPpg5BvsR2vG8rGolr0YojdEruacHNCCSzYmThkF7Yb2RhdgX7zt
iSLKWbYNj2rvQR49X9h/oqI0o84LwxVek3n7ipXkBiaXwmtGPx06vNW0k+77jAzf
alePr0SjYaPVOkAqH8xOy+MsSUIdag==
=21Xf
-----END PGP SIGNATURE-----

--Sig_/47rlk/C+7trYJhvAktsmM=L--

