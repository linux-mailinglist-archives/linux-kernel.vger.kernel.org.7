Return-Path: <linux-kernel+bounces-865248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38001BFC96C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46944EABC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6734D4F2;
	Wed, 22 Oct 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP9wbkEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6855354AF5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143656; cv=none; b=sYct1M2KTONIthzF+AJ3k2VZm57FbccmvfjMVBiGtqR2IAnWs56C3WMp832YtJztdksvmEjOMEUni3gOiWic0UWQwPv5UEOQJIw8Jmgnfj9MVhnCJEhaGAgur/dRtUelrRkb9JUAhmFSTXN82UEd0JxGYzNHrXuez2FD02+3sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143656; c=relaxed/simple;
	bh=PE0w9weBA06UY1ADMvuQ7RDRF1VFjwoEQh225hRpYZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvUQfaFZQUX30gO3Y9Tv092GJXasxdqDwsQLgwwsLwly/aSEpMqDoVOtKQGsLJvBRdV3VTCk4b3nXhfJg2Os3BMVUA6aQHG1oUJ5ijwc1d5VYDsvqMHP+lA25d/CV/GU1pIk3EYulKuJWWBFXVw/X2liqo2ICIZHZxvmvQMTwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP9wbkEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96649C4CEE7;
	Wed, 22 Oct 2025 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143655;
	bh=PE0w9weBA06UY1ADMvuQ7RDRF1VFjwoEQh225hRpYZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cP9wbkEhPM5LIDakVffo66AHNLBN+38mt7kw0Nz1jjGM2DTXe/G7XuJ/6OFlVBDOR
	 13ysGZEgl7Yl6Kk7OLgtMXAGd+Rc/TAHxOWT5ohaXNSYIWzV1lGviaTtyV/yQXdjhq
	 kh6G0Dujl3w7LOIfgQW/e/jH/m9lfkPmqFaif4OrMHSPse4klWA1BdT76iUoBIHvKL
	 qkzYWKIk6slN1bfOqe+4G2oUCFmRrjagLn1fpxjjhAFqCvjDzlIZd/Jpt7HIfH+a/D
	 XkxNnpKeeolCDTKG2t0QQK573TSGGgDAGoOHy62RkvYg1tvs9a4RfHZbeRybsew7qp
	 NBpmfpZajkRGA==
Date: Wed, 22 Oct 2025 15:34:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v8] hugetlbfs: move lock assertions after early returns
 in huge_pmd_unshare()
Message-ID: <080b64d6-7bc3-4ba6-ab76-e1fe728bff88@sirena.org.uk>
References: <20251014113344.21194-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A/QWAtEIee2YEtfF"
Content-Disposition: inline
In-Reply-To: <20251014113344.21194-1-kartikey406@gmail.com>
X-Cookie: Thank God I'm an atheist.


--A/QWAtEIee2YEtfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2025 at 05:03:44PM +0530, Deepanshu Kartikey wrote:
> When hugetlb_vmdelete_list() processes VMAs during truncate operations,
> it may encounter VMAs where huge_pmd_unshare() is called without the
> required shareable lock. This triggers an assertion failure in
> hugetlb_vma_assert_locked().

On current mainline this translates the test from a fail to a skip on
the Raspberry Pi 4:

# # -------------------------
# # running ./hugetlb-madvise
# # -------------------------
# # [SKIP]
# ok 6 hugetlb-madvise # SKIP
# # hugepages not supported

due to:

[    0.000000] Kernel command line: console=ttyS1,115200n8 root=/dev/nfs rw nfsroot=172.16.0.2:/var/lib/lava/dispatcher/tmp/1991635/extract-nfsrootfs-9ik0m73w,tcp,hard secretmem.enable hugepagesz=32M hugepages=0:4 default_hugepagesz=2M hugepages=0:128 hugepagesz=64K hugepages=0:4 kpti=off ip=dhcp
[    0.000000] Unknown kernel command line parameters "hugepagesz=64K hugepages=0:4 default_hugepagesz=2M", will be passed to user space.

which used to DTRT but I doubt is due to this specific patch...

--A/QWAtEIee2YEtfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj462EACgkQJNaLcl1U
h9C5YQf8DzoRtaemjFkXnj0s/9uWQGFbpRQHBXfRESoB/flbWhlkLXd4iI9D82Nc
Aaeg06+b4foXvsPsacRLjZTnd65mH73P5gFN35MInqU2RvSb1RCNP8/8eJJyieeu
s+r+EaPtFciPovmHxXaHkA4xvBVUz0q5Fty7Ndz2perwfPSWryAXyonZyw1cqJFk
e7gtvXR7FwlZs2KyRl7XPq6RJBpN+jTHUJPMtlNsdlYgaV9n/8LyKAqL6YBHL3QT
w9wYuSt1ijYYYCcH/xhMbUk02MD+ntabLMMTFs/4kefCvvFCDVZB9u2ucfJ0pE9e
9oLnPQ3QJ2uo91+tvTbJWhsAEWHsfQ==
=5pOg
-----END PGP SIGNATURE-----

--A/QWAtEIee2YEtfF--

