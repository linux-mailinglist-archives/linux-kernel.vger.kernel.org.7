Return-Path: <linux-kernel+bounces-774508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD51B2B356
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9101BA4457
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADEE26FA5E;
	Mon, 18 Aug 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G72pRFXY"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2933451D0;
	Mon, 18 Aug 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552255; cv=none; b=XHJVZCzpntZ6HpRLp2DmKHlndNFQ5rkbEMf/VZz+zuszj1vfnrcBgCNJ24eeKbP9hhlMvwTP9CGSDqGSM8dkAKgD1pLqQOiKSXGQ/xD7+BIAPEB8hFF3dYEudSRh7uMfamyfaM0Di7pOCzPqJLOBKYeDmPdb3ieyn/2CcsYR2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552255; c=relaxed/simple;
	bh=ekjT8zu5mtRL34qSYlLxoND/4cFMOxhaaNd03ZHsNac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MRcOfJJi+DY12LGeDdTiIX076TchQV08uiTWlidjf+RXoXHMupUrRCt6i73Yr36GibJvhXIVX3czWfV/5ayuPs2IvA0WEA1RprDlszp/koqBMpNNOzU6QIgm7l9jIJokLuLPEKzNzteVRXC2VmXhZO8nT+DYNHIExKIBS7zK84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=G72pRFXY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1755552249;
	bh=eULIdFDx/i3XYrZXExG7p3i3YNMfjTRyAaMpr5DSuBM=;
	h=Date:From:To:Cc:Subject:From;
	b=G72pRFXY8KEYM7KZny9AfomRrK46TtNxMdKLvW01ZcnFP2XmxvQMJrXhhuwgH7GgH
	 gAp4Am9eO7g+5982n9I1zZ4Y40k/Yq2zKBgce+2koOelVBNl7JFIUCNjnmOp1NXRJT
	 Vo1PQ3mRmpxLZR15qWHxCYrO3mw7zvTNkNQSQ8ZCa+FVUSdAaYxE//BfbYEydIdVCj
	 DoZA7WF0u5M9cNja+JQx95qnCBIvkVjQnZDmTshXXpKp84P9gFVbN14OwP3EK+u7gR
	 bE/vV0vA7LDWSDUViq24tlFs3WsgJ6PRvzfvvahB6bakDuzWHW5kf7ckgAF6RP4vsy
	 /0bZhfwp5AioQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4c5Qh90M9Jz4wbc;
	Tue, 19 Aug 2025 07:24:08 +1000 (AEST)
Date: Tue, 19 Aug 2025 07:23:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-unstable tree
Message-ID: <20250819072328.509608a3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8nmMSgUskQvNoF9U_wHFGqy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8nmMSgUskQvNoF9U_wHFGqy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1ce24beaff3f ("selftests/damon: change wrong json.dump usage to json.dump=
s")

Fixes tag

  Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON stat=
us")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a0b60d083fb6 ("selftests/damon: test no-op commit broke DAMON status=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/8nmMSgUskQvNoF9U_wHFGqy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmijmdAACgkQAVBC80lX
0Gy/pAf7BcYlj+q3gxjKbx8/hg2sxWhIL8gNCLnlTeB+FFfgIlqUQDr4DCo2+WRA
kTAH8ibngjeG4b5vXljvFX3fKjvUhCMuqBkjL0/auRFTk0vG2pmKlMoVZRE5WosJ
EQxiVWsi7un5Jh6VKD+xG09ACxB/xiBKxxNRvA7vmbqPDCwWj9z/GeR0htdbj50L
PGNT/4FnbAJar2Qt0T+RBifVrCkcugl27B0ML7EvRW0wEviDEcXxEmRmZOUGFBb1
enYdim+VqssRdke71zIYkuVB03MJl2pTVFQRCN1DNJ0PfICZjTPky++8rmhSwMBp
Z627uq50zI2KKYtJFNjY7IMbLnzmqg==
=xiR1
-----END PGP SIGNATURE-----

--Sig_/8nmMSgUskQvNoF9U_wHFGqy--

