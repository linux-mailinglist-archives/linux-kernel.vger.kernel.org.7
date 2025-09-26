Return-Path: <linux-kernel+bounces-833775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DE0BA309B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B3C385130
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D627587D;
	Fri, 26 Sep 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPD5je9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0672608
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877218; cv=none; b=gBQ7gGMcRy3P63497/HrzNs1n7wgAE4DJh4fwVhDuDh1aKDB7r4H9OIJ9XeF7knU00z9drS8H2zMUWMuUo40gCxqBVKe74AiN4Hqs5dhclkR9zUABZEw/xK5sfp6i55SP+auM+cU1BvXKjhyPciHCMbSEB+z83Y6/Xmff+mgyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877218; c=relaxed/simple;
	bh=Lq0FsZycQzh8JDhkJkDs9ZbQ4dlQIBZlKIbwpkVD72M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKToLsd8n/UP1xOP8zX7TkQWC2oEId7CZw1HKDml9TboG3lzDD9qzq+58vXE7kng073x4rifcBvzeo+rfcA12//Gmqc1h0IAP/a6imjR9eQvGpDvkWKcIEQBWoK5mEqEw8OKf/1mn1MLa2fRbfpXbdkfM5VuRXsRXdew1SWIT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPD5je9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA629C4CEF4;
	Fri, 26 Sep 2025 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758877217;
	bh=Lq0FsZycQzh8JDhkJkDs9ZbQ4dlQIBZlKIbwpkVD72M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPD5je9kJ9OGWOG1HVacwZ3/iqmBdpLcojlePlQXnuYHnJF4V2JWSF4YD1D5BbNX8
	 jo1kSXi8SXMHtaNj9/6fIVPurd3/wQ3k/roXWxTcLpR5rN5bnw98MMt/ZKLFCr2QvG
	 MigQeH4UGyH7sSSzRrauNWZAzR9RcpsvfhvY8HDh/faGwZX/TPJJugOakvNfCUWT77
	 MTbflMDaIprKvHyxhxXYp+zfMl7uvyUHRk9OYTXJXY1OTOYALATYL2nEJ0vaVAkXyk
	 XC6nLBWZS/PJsesvjxuo0jRxaOQSf5yHdq1vxdcuVJWimnhXlIBZg7TWmDGXJbbSAb
	 sN70Wq3aWoCOQ==
Date: Fri, 26 Sep 2025 11:00:10 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <whzecqawauwsoiaydpxsdgt55nmyi4tp5dgzvewmf4pinstdtq@z3kkqwdvscyi>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6rukh5wqzefvtiu"
Content-Disposition: inline
In-Reply-To: <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>


--p6rukh5wqzefvtiu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <whzecqawauwsoiaydpxsdgt55nmyi4tp5dgzvewmf4pinstdtq@z3kkqwdvscyi>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>

Hi Andrew,

On Thu, Sep 25, 2025 at 01:48:14PM -0700, Andrew Morton wrote:
> On Thu, 25 Sep 2025 15:20:28 +0200 Alejandro Colomar <alx@kernel.org> wro=
te:
>=20
> > I've split some of the patches from the string patch set, as these are
> > obvious bug fixes that are trivial to accept.
> >=20
> > I've reset the version number of the patch set to 1, to not conflict
> > with the version numbering of the string series.
>=20
> fyi, there's nothing here which is usable in an introductory [0/N]
> cover letter.
>=20
> Documentation/process/submitting-patches.rst should explain the
> conventions here, but it is presently silent.
>=20
> The [0/N] is an overview of the whole patchset - why it was created,
> what value it provides to our users and perhaps to kernel developers
> themselves.  It discusses alternative approaches, possible drawbacks,
> prior work, all that stuff.  And it provides a high-level description
> of the proposed implementation,
>=20
> Potentially lots of words, and it's quite important.  In the case of
> your patchset, it's one short sentence (sorry).
>=20
> The words you did include are short-term development things, unsuitable
> for inclusion in the permanent kernel record.

Thanks!  I'll keep it in mind.  BTW, I didn't know the cover letters
were stored anywhere.  By 'the permanent kernel record' you mean that
cover letters are stored in a merge commit message or something like
that?  It would be useful to have that documented.  I didn't know.

I can send a v2 with a better cover letter, if you want.

>  Such material *is*
> important and useful, but should be added after the "^---$" separator,
> to tell everyone that this material isn't for permanent inclusion.

Okay, I'll keep that in mind.

> Patchset seems reasonable, I guess.  But I'm not loving "ENDOF".  End
> of what - is that like __etext?  "ARRAY_END" matches "ARRAY_SIZE" quite
> nicely, no?  And it much better describes what the thing does.

ENDOF() matches countof(), which is the standard name for ARRAY_SIZE().

<https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3550.pdf#subsubsection.0=
=2E6.5.4.5>
<https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3550.pdf#section.0.7.21>

I've never loved ARRAY_SIZE, as I have a macro sizeof_array() which
gives me the size of an array in bytes (and guarantees that the input is
an array).  The name nelementsof() --or the shorter NELEMS()-- seems
more appropriate, IMO, since what it returns is "the number of elements
of an array".  However, the C Committee hated it so much that I couldn't
get them to standardize it.  I'm content enough with countof().


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--p6rukh5wqzefvtiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjWVhMACgkQ64mZXMKQ
wqkTyQ//c3fcJWmHIFMu8eVOzAW9WbtxAEiXfwbzyFEm7C8M77QPliGplSe7KM4R
yirn0omM2wIutNULqRhsqmz97FdfNmHTcmzFZVXFddcCH7Xccb2DcbpHQYCkevxZ
Yb5M/Cp86+4kqXLUIJFCtPAr3bdRU4qK2LIzmbiDM4pvqHrAxXSbzzYl4XkUAR0L
KC0+5+yv3rBCZFB7s4dfReopQ/kDSUnkg753Xf1/w2z8gLPNheoBvAOa3zKamcUh
2+wMOsTWs6zlEGXWf/9jbKG+lDONbVr8UW5JbroIotvwwSG6IfXvYxTWlTYkjV5L
gCAg3nK/Ypdr/RArp1hKktD5w/LaLwbbeG9a7uf2ZPbtp6seI1JHWWRa0CGwTvPE
9FNnroOKZ1iKMIc/aI5D/UZnHyujblX8M+d2f7V9b1INPhI5V6iM/d5CFGGs6qQO
eqVeBI2CekAM3vaO+tfe6gl1gxkCMDTnNSyOPIbHaRaWHEtX4Rx7PyyMAap3C1U9
zD0hl/Nzw+wbup82VkWkWgOkfV/UP9bkrgc/xvCHrPYRVEzA4eBsidTnRHnpo5KJ
w11kv1Mw1dFHGGPM0UI5sJzSRblQG80RHCz4Szzc4BebnxzK/Rmsm/le+XnbotLL
yLZrfM8uYLuobnL1AjtY4cRG1L0Dwg/UBda5A78PFjJ5QCfdU/E=
=vQOv
-----END PGP SIGNATURE-----

--p6rukh5wqzefvtiu--

