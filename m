Return-Path: <linux-kernel+bounces-833749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAFBA2F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80652623988
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3E296BC5;
	Fri, 26 Sep 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzfOP+xm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D6291C13
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875399; cv=none; b=nJl8MYEX0R3kJSduen1HbciD17C6/PlAs58cUzF9qiWUW3fuBDem0ku3wq0CQCsEI/3hHRn3bGh4/cdfx0RY1VLGA56Brskfxy1H1TrqMNjB+7T2vhye7kYZk3cz+icHZSVSVm7vVggwT0M5wEI1O2f5daS7tM9ShqD2d6Tl8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875399; c=relaxed/simple;
	bh=2O2Eis/AQxoQlx2boLmGaVYgY6FUanSnJshyf0XdjwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCbST7/wLABVg4Ow9zjy0szJeKI7bWbmWQ6XnMl6QbiC1AdIvdWtPjbMaDD8o2ck9Lvhc6ER1tXlZVWVzeF0hQtcHNZD63puaiC3JklxmkWIFT577jZqPPX/hfnz/Jf+3KDDjQvUzHSFhNw2+FE44HEPjKrbfUbntXpdU5kgORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzfOP+xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA14EC4CEF5;
	Fri, 26 Sep 2025 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758875399;
	bh=2O2Eis/AQxoQlx2boLmGaVYgY6FUanSnJshyf0XdjwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzfOP+xmoc9M4NPmCBGhZ6SkKwuQD42poOqwgfwyRa32F0sttzUhsLot48i6tzg7f
	 gnK8YT2i6Wh7VoC7CmSCMbkVVHCk2r0Skws5vjbvsOwnMCdICMxyvZvb2xhjFub3Eq
	 Uuc8mr5Ios/9ZeSVCfeeK5TQHcjMDpLZYn1TMP2xRjpOGJusN46qiV13MH2F1a0Cyk
	 raRh4y7GtzvFvrJTDPI8ZioieVE/d2ybjLtshLIXad3sknq+1/4KlrcfDW+CpsOegE
	 OJjwlAweHoCyDButmlWPYD3g/ulQ9PmzRT7aiZEe3aKRlRFBi3j9kcIOFUdUHAs5u7
	 i734WYfUouw7w==
Date: Fri, 26 Sep 2025 10:29:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <s6fgd3jzckxv3lrylph5cl4l3ykk7qdrnjwlvwe3pxxc2zgch5@2jgoh5lkoh5b>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook>
 <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
 <202509251823.1B974C7@keescook>
 <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktuk3iap3hmygfsz"
Content-Disposition: inline
In-Reply-To: <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>


--ktuk3iap3hmygfsz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <s6fgd3jzckxv3lrylph5cl4l3ykk7qdrnjwlvwe3pxxc2zgch5@2jgoh5lkoh5b>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook>
 <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
 <202509251823.1B974C7@keescook>
 <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=witf7e1QRp29tAeHLB34HuBSO5G7q82cmd-mAPSt+0JVg@mail.gmail.com>

Hi Linus, Kees, Andrew,

On Thu, Sep 25, 2025 at 05:00:30PM -0700, Kees Cook wrote:
> On Thu, Sep 25, 2025 at 01:48:14PM -0700, Andrew Morton wrote:
> > Patchset seems reasonable, I guess.  But I'm not loving "ENDOF".  End
> > of what - is that like __etext?  "ARRAY_END" matches "ARRAY_SIZE" quite
> > nicely, no?  And it much better describes what the thing does.
>
> And it's really ARRAY_BEYOND. ;) I don't really like having APIs that
> require holding pointers that are actively invalid, either.

The name END has some conventions.  It's not arbitrarily chosen.

The C standard is quite consistent in referring to the last addressable
element of an array as the LAST element.

For what we're dealing with, which is a pointer to one after that thing,
the C standard is also consistent in calling it 'one past the last
element'.  It doesn't have a single-word term, though.

However, C++ does have a single term: 'std::end'.

And many projects, when having to come up with a single-word term for
this thing, natural evolution shows it converges to 'end'.  Even in the
kernel, as your local pointer variables are actually called 'end' and
not 'beyond'.

> u8 array[10];
> u8 *first =3D array; // valid address
> u8 *last =3D &array[ARRAY_SIZE(array) - 1]; // valid address

This last is correctly used, as a term, but quite dangerous, as Linus
points out.

LASTOF() would be something quite more dangerous than ENDOF().  First of
all, because it's not guaranteed to exist, as Linus points out.
LASTOF() applied to a zero-length array would be Undefined Behavior
straight away.  That's indeed why we have guarantees that the end always
exists and can be held.

>
> for (u8 *c =3D first; c <=3D last; c++)

Secondly, loops with <=3D are weird and error prone.

>   putc(*c);
> // c would now be invalid but has left scope so it cannot be used
>
> --
> Kees Cook


On Thu, Sep 25, 2025 at 07:36:13PM -0700, Linus Torvalds wrote:
> On Thu, 25 Sept 2025 at 18:31, Kees Cook <kees@kernel.org> wrote:
> >
> > I can have an opinion about the relative safety of holding pointers that
> > can't be safely dereferenced, though. :) But yes, I've long since lost
> > the argument that C should avoid these kinds of past-the-end tokens.
>=20
> The thing is, the "start+len" model is actually *safer* than the
> "start+len-1" model.
>=20
> It's safer because it's simpler and doesn't involve the whole
> "subtract one" (and then when you have the "past the end" it's also
> easy to calculate "how much is left").
>=20
> So it's simpler, and it's explicitly supported by the standard.
>=20
> It's also more strictly correct, because "start+len-1" is technically
> not a valid pointer at all. The C standard makes the "past the end"
> case explicitly valid, but not the "before the beginning".
>=20
> Now, I'm the last person to say that the C standard is always correct
> - there's a lot of garbage in there, but in this case it also happens
> to match the notion of "this works".
>=20
> Because the "pointer to the last byte" model DOES NOT WORK.

So far, fully agree.

> In C, NULL is actually a valid pointer for zero-sized elements.

This is only valid since very recently.

Remember that 'NULL - NULL' is (or was) Undefined Behavior.  That
operation doesn't result in 0, per the standard.  NULL < NULL is (or
was) also Undefined Behavior.

Consider this innocent loop:

	end =3D ptr + size;=20

	for (p =3D ptr; p < end; p++)
		*p =3D 0;

If ptr were NULL (trying to represent a zero-size array), we'd at least
incur in one NULL < NULL operation.

However, a unique pointer, as returned by glibc malloc(0), would be
a valid pointer, and p<p would be perfectly valid.  p-p would also
perfectly result in 0.  Of course you can't access p[i] for any i>=3D0,
but that's true of any object.  If you have an array of 2, you can't
access p[i] for any i>=3D2.  Everything is consistent with unique
pointers.

So, the whole model of malloc(0) returning NULL as successfully
allocating 0 bytes is broken.

Recently, the committee decided that memcpy(3) would accept NULL if the
size is 0, and I'm not sure if they also defined the behavior for any of
NULL < NULL or NULL - NULL.  I'd still be careful using NULL to
represent a zero-size array.

> Yes, really.
>=20
> The C standard says that "malloc(0)" can return NULL, without it being
> an error. So the tuple "NULL, 0" is actually a perfectly valid
> "pointer and length" pair, and one that you may actually get thanks to
> how malloc() works.

This is something I want to change.  malloc(0) returning NULL is
terrible.  realloc(p,0) returning NULL is even more terrible.  And by
terrible, I mean it has caused remote-code-execution exploits.

<https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3621.txt>

> Obviously you cannot dereference a zero-sized object, but zero-sized
> objects aren't "wrong" per se.
>=20
> Now, I happen to believe that the "return NULL for zero sized
> allocations" it's not a great model (it also makes error checking more
> complicated). So the kernel kmalloc() function actually returns a
> different pointer that cannot be dereferenced (grep for
> ZERO_SIZE_PTR).
>=20
> But my point is that "ptr+len" actually *works* for that case.
>=20
> The "ptr+len-1" loop thing you gave as an example not only is invalid
> C for zero-sized cases, it simply does not even work at all for the
> NULL case.
>=20
> Your example loop of how things should work IS WRONG.
>=20
> Yes, it happens to work as long as you never have zero-sized things,
> but it really is a bad pattern.
>=20
> This is not "opinion". This is just a plain fact about how C works.
> "start+len" is well-defined. "start+len-1" is NOT.

Agree.


Have a lovely day!
Alex

>=20
>                Linus

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--ktuk3iap3hmygfsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjWTvkACgkQ64mZXMKQ
wqmaIw/+MAcy2ospUQpsCvwNAYYYYMXAEwWw1Sq8i5mQfXKhDEHukb3tWNfH3oM/
NxYPzYnFV9D6zlnhwg7zKfrFPyI6clhmPQ6GwQ7mbyV0V6sADePRlWZ3LzZ5sOuN
IqLLagbzzduXITCxqaJ1PiPGXtrx9vAjruxqTC0sbRxF794ZpLgpHOmxpdfm7FpQ
3AlgIzHdsyrVE0pButr3C2GACtfqh9HyI0EMvK4Wu1F0jiFubw7gOQSfD12pdhfj
SJQ681DEkUDzsZwWHcppK62sq1Nsn6LGB1aMMdsaOupBRPq8Q9IT/et/LA2a+msD
u85GVgIxjmkpBEhdu1EvEbua3oKJ+EBDLaOewK0g11W411iP6nmXq9aljoV843XZ
FGFpaQJWrrq6AqD+urgNFvzG2HynszPeywcFPGfWF+/+iZn9F/AmOmNXhFXEHGTH
9Bo2vFxCMe0cCCE1HwVUSPVNarOWie0BjlrORKtiLDDDS1daE+yNecrBt/TE0l0V
PYJat3pm1BBo0D4IzURAuimiRnTYWNW0Q9YMJIBU+ipnjxWcd1EfiIE9lRuqsIXd
3fSznKiIUw0yc+l21nLdYfgNOEsxfgwA3mFVR+11i8rAXOifbUVJ3Vc2+SsaZuNe
Ci1E2S2fGEWYCF+ObbdNBbq1P501Y16mjrMd5BID/yJWxSJXsxc=
=VLnj
-----END PGP SIGNATURE-----

--ktuk3iap3hmygfsz--

