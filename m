Return-Path: <linux-kernel+bounces-894211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FEDC497BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7A134E7EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794F2F6582;
	Mon, 10 Nov 2025 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHwNLLb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22572D6605;
	Mon, 10 Nov 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812374; cv=none; b=QYnrlUtFfozoTA31Pr6VWDijJmQaULyEIo9jvFuMSd16Uu7JEH6SdnAmREk2rI8BR/BSmOGZ2pOELPC0dAFqSTxWDnoRc+aYnhqQciLcE+w03r7Nwcds7TvAoRLBl7USYO8HjCh2gWH8KhkUN7cBM8do6NKF7/DXty9D0KpiEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812374; c=relaxed/simple;
	bh=ANbHoAoxXFqFOwqzSzLfvjdSSMJWajzcDa95+kDS2s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNBX0xIhXx7l+iFhQ5F+os49oB309U77NjcmHj8B6TAmc8xum0U3voSGAxLR7jkWxkNqAoS/2yh1XcQE64HxYFGvco1pK2oT7pL5vIS74GEW3uI71kSvsFhmGC6FIMXU7CCTZl2QdvtlNkkbot1wQo+J3P/8NHnwK4kHCukMMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHwNLLb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B1DC19424;
	Mon, 10 Nov 2025 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762812373;
	bh=ANbHoAoxXFqFOwqzSzLfvjdSSMJWajzcDa95+kDS2s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHwNLLb9zWuTURbZGIRD48rB/Di+bP62dlO9Tg4mblA7Cbrptfo5W832oIEwE2aqV
	 BQp2jZtEpMKH+cOnCAZRPKnI4PG9Rg9H1KQ4U0xpMVUtja3fRru5m+VQAHUbTSVvOj
	 qt45nJ0KxrsNpFIPUSJ1J/vERRVZ5INczOA7vaMMWEWARr1lHrpd+mPldP3U95b+Ql
	 vojHRk0K9uFFeli/VQ/KOkQsmkeD+mbdbpYdQPB+/h/LrAIbxB/I8jfbbX4st4lQ50
	 8clcY5KfY1AxZOfPXuHbp/B6UYSspc941HtKxg5p2uxIE3PO3cc5JjC+Jy4lBQQjuq
	 Vawpzf2lSDAcA==
Date: Mon, 10 Nov 2025 23:06:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Marco Elver <elver@google.com>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 2/3] mm: Fix benign off-by-one bugs
Message-ID: <6vzrgu2gei2g2445cuwod37gmxz3zejnhegrqseymb6gofydum@agw3bgic3v52>
References: <87445e701574058b142e036c3b8a0f505086ab64.1758806023.git.alx@kernel.org>
 <202511110100.9uPtQqN1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="spgz4wpgupnke5j7"
Content-Disposition: inline
In-Reply-To: <202511110100.9uPtQqN1-lkp@intel.com>


--spgz4wpgupnke5j7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Marco Elver <elver@google.com>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 2/3] mm: Fix benign off-by-one bugs
Message-ID: <6vzrgu2gei2g2445cuwod37gmxz3zejnhegrqseymb6gofydum@agw3bgic3v52>
References: <87445e701574058b142e036c3b8a0f505086ab64.1758806023.git.alx@kernel.org>
 <202511110100.9uPtQqN1-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202511110100.9uPtQqN1-lkp@intel.com>

Hi,

On Tue, Nov 11, 2025 at 01:47:19AM +0800, kernel test robot wrote:
> kernel test robot noticed the following build errors:

[...]

> >> mm/kfence/kfence_test.c:113:8: error: call to undeclared function 'END=
OF'; ISO C99 and later do not support implicit function declarations [-Wimp=
licit-function-declaration]
>      113 |         end =3D ENDOF(expect[0]);
>          |               ^
> >> mm/kfence/kfence_test.c:113:6: error: incompatible integer to pointer =
conversion assigning to 'const char *' from 'int' [-Wint-conversion]
>      113 |         end =3D ENDOF(expect[0]);
>          |             ^ ~~~~~~~~~~~~~~~~
>    mm/kfence/kfence_test.c:143:6: error: incompatible integer to pointer =
conversion assigning to 'const char *' from 'int' [-Wint-conversion]
>      143 |         end =3D ENDOF(expect[1]);
>          |             ^ ~~~~~~~~~~~~~~~~
>    3 errors generated.

I'm pretty sure I tested this some months ago.  I'll test again...


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--spgz4wpgupnke5j7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkSYckACgkQ64mZXMKQ
wqmJCQ/+JJ2uBd3GqMbPFAmeC+dhFJE0AjE6nWO7TvCPfIJRmNhY6MfqRWqVH4Lv
fM5+eLBctHCg42qsiN4tbMPfnQzL3KmXomqza7VW79aUDtTrHPTSd16HH43jlOiX
5PzfxVGkVEO3bK9ABpHu6LQpcNJY9C7hsAcX5QSA8evg2YCRO51XgoG5Y8OpYBAX
s7hm2VSassXxPTpcPcJ1SXeXfq6oC0CkF+ZCr/a+PfpyWTHtJEBkcxDiqCSB9Aur
1HIBIzggzAS1OgeDY3L5iNIPYW3js+2P3ROSL3OffA/cgZ/cqR8iWmRs/VBqVyXn
knPLFrT6qrznvPQdbSm0IO5njxAJAkO6C2KwnvIlZd4KX0qbhlb1vR8OgGhJXdVH
r7C5+1OWGAvb/62+Bl3Tea7kFxr1jzN2MKW2Jwt/ao1e2rvCnnanHhvtsfE2x7Mu
JTb048s4EmnqenWqK8l+KfQdmw+SMQBIGMpBI0e0AnZ+yGeceWZ7nZdIvI2neDKa
bM30oIXekTNxuMRxGqoQSb7E0PCpK+/ozxuOkM7xnU2RYsv9+v5dXetWmKaXMxAd
Av35yX6RRaSca2tKpWj4DkaLqvrOCtDuyscryk9fY/qxwP/ELG0Yw6ebctmDPPFT
kXrvRSuvWv6AvE9JlWSG+MH490uxGWkqBYHrrIJKSKVHZy68HJk=
=5BWZ
-----END PGP SIGNATURE-----

--spgz4wpgupnke5j7--

