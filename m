Return-Path: <linux-kernel+bounces-834072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422EBA3C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD3B6230E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B62F5A03;
	Fri, 26 Sep 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1n01XNo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AA2512D7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892067; cv=none; b=uSmTITsqu+JIoeeIvkjVsTItoOnVb5Xd4ExlJnAac3vk38mdUE9mIqTBejw3hmV76GwOji5eTGOnq6Y1GXmWuycAZ0lBkhgiTOgZ3uF4Gwn2uZGgVVY6dBQPP3avp7TCyjxj0N53Dm+urLGt0pqSw21YEQZw8Mtcuc/HLfNTxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892067; c=relaxed/simple;
	bh=sNnNky5181T+Iim3C7ZYt71SIiOXQHrD9CaznKPFvWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGPvR3vwRVmiZZ3rXSWsZxmlJ3c2OetrBYocbGMmRj+r78ce+yEFZ83jAdOD61lRdqLMHdLib12J0LhavKVTWJpGEFbKie6JX5ZsH2TvvMlaKTydNWv1ft6Gd7KrkwMCIQZ67knNyc1nOBS2s1EVrBhZkXc0tBE92qmtRZGT5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1n01XNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B13C4CEF4;
	Fri, 26 Sep 2025 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758892066;
	bh=sNnNky5181T+Iim3C7ZYt71SIiOXQHrD9CaznKPFvWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1n01XNoYEv02a1J8/AxKjYRrb0dHsEXwMgiGIQsadJRjX0fm28ooRktzvLLUgMFS
	 Fl4Sd91E2E++UsiVuW4SQ1hg+XYfyEXLGlfrEXshFEIby3umXmG68LLd6GL0h+pndl
	 s5hTzahDC8QpPXvlJ2OlQB5mMrdyA2bpoo+hLJp+wpy5Dy5DrtDUdb8JbbQbFAs6uh
	 6/ghvt8RmVJCs+hsPRBFRR6XdnSF+DlsSAdb5DViUt2/0ITlSbAeTfn94h7M2Cdt6X
	 gfAlVw2O1aUr/ZqbC/KlHgr7QLDIKi3FUrSrbighulfsXyjPibypLySBmLVZnlOzVn
	 kJR5Z1NqVL4MA==
Date: Fri, 26 Sep 2025 15:07:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <nqhz5vtobixqzgqfei3qgrcpyvjur6onhfeezidta7mgfmg5gx@qwzw3bw3lwr4>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook>
 <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
 <202509251823.1B974C7@keescook>
 <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
 <202509252007.E9D3C14@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cb3r5bg4c4nytidf"
Content-Disposition: inline
In-Reply-To: <202509252007.E9D3C14@keescook>


--cb3r5bg4c4nytidf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <nqhz5vtobixqzgqfei3qgrcpyvjur6onhfeezidta7mgfmg5gx@qwzw3bw3lwr4>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook>
 <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
 <202509251823.1B974C7@keescook>
 <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
 <202509252007.E9D3C14@keescook>
MIME-Version: 1.0
In-Reply-To: <202509252007.E9D3C14@keescook>

Hi Kees,

On Thu, Sep 25, 2025 at 08:37:49PM -0700, Kees Cook wrote:
> On Thu, Sep 25, 2025 at 07:36:13PM -0700, Linus Torvalds wrote:
> > The thing is, the "start+len" model is actually *safer* than the
> > "start+len-1" model.
>=20
> Sure. But start + len is a vector: "start" is a pointer, and "len" is a
> size. No problems at all.
>=20
> > Obviously you cannot dereference a zero-sized object, but zero-sized
> > objects aren't "wrong" per se.
>=20
> Right, totally agreed. I'm a big fan of zero-sized objects which are
> useful in all kinds of situations (e.g. empty flexible arrays). And
> as you're saying, a zero-sized object shares the same representation:
> start + len where len is 0.
>=20
> What I dislike is having this vector collapsed into a pointer because
> it loses its explicit start/len information, and becomes ambiguous. And
> worse we have nothing that says "this pointer isn't safe to dereference".

The word END should be understood as "this isn't safe to dereference".

I'm not inventing anything new; it's something standard in a way, as
C++'s std::end is precisely that (and no, I don't like C++, but this
name is quite consistent everywhere, including the kernel itself).

> All the bounds safety work we've been doing lately is mostly centered
> around finding ways to retain the "len" part of dynamically sized object
> pointers so we can reconstruct the vector unambiguously.

END is useful in cases where you don't care about the begining.  It's
useful as a way to know where an array ends, regardless of how much
we've advanced in its contents.


Have a lovely day!
Alex

P.S.:  Please let me know if this patch set is suitable for applying, or
if I need to provide a better cover letter, or if I need to do anything
else.

>=20
> Anyway, yay for vectors. :)
>=20
> -Kees
>=20
> --=20
> Kees Cook

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--cb3r5bg4c4nytidf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjWkBIACgkQ64mZXMKQ
wqk+og//U4ZjFbRCUXrut2QhUGZsxqyDxgfqJVOY1KHnTgXL7PykoP6z6XaeyWyO
nObPdtDcDezSzH9AXfiVRIDrFMlYQBeAY2VihVWYZH6JxoIQjnVfVN64j2plxBV1
jcRf9OdI5azkJAxRhLvoyUP9kKH44W+7vsYgp14yum2PxigY88mVr+/b1eCpweAz
qN6dQc5uj6Pap9c0+OccRyxdZ91iCNIz7FJUhu+vzvJ8Brf3IcC2zu2sl8wTo9GC
eMndIi1E6hftHAWJsogvXYrUEQBuI6mWls4iY6yL5wNqd8S/MxF8WrFV+KAx1S2p
gWtdPC/XIZOm53mrdLos2tpZ6X1FyRwvM9e2KhPUL9HPLhFY9sa6eoUH+VE8FE7/
Wf7d9ew57KYspTzTno96j3Sg/x9BwgN1OGfJ84m/nhSCs0mY0VEGP3WKkPx2K8rN
cAT/BjrXJKUgWPtB3ppW6edLPrRx2Xwj6HeP/LCrUc3SyuqcoLBGgHIs6LjaGbu/
nUEWkixOB8cAGT9TUDsKAFRooOyeuYLJ/Pz9fWq8/AS94WzSDfEJjwELa1l7wN++
QQnp2paFbZb6O7RAWfD8Httm3z4fB31b5AWwviwQQANkOujx29xcWVF/ElEB8Cuo
7XX8ZTpP5UaoRYyi/3UPir8K8vdq273VImNXICrLc9mUMfiJhds=
=AHCk
-----END PGP SIGNATURE-----

--cb3r5bg4c4nytidf--

