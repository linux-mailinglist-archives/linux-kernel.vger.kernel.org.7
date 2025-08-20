Return-Path: <linux-kernel+bounces-776788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC9B2D17E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7BF2A8186
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C95239E63;
	Wed, 20 Aug 2025 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S6trjx5w"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76F4C79
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653793; cv=none; b=jU19+4aERTlEafD4EoR3FAaiqkN9w9ZRdC/uvOkFFwM8fac4ixxbFLPHlMRyEjNMQpxrubkSTdvMSnH2SEjDaGHkuLlEDLJg97PUCFlqJajs4y52b3neYGQhC0T7dUp6W3L03/KxAmdCQNNoa/U2hovNA5dJmsK9yZOKtG89cEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653793; c=relaxed/simple;
	bh=DO3Sgr2iojTLYzTJU0YYkvXMnN996TAle09ZPEgUksM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV1x7P6N5gm/ij24YKR+oLAWd8ZJHIt9ZqLRQkVLRuEatky18qeYT8BAMakWOGLznO61YHQuteKVekMiPxcTzajuAfn9XkGL4Y8dHRv3F50PRyB+JylrD8bPwf2R2Ol+dQ5HW7Nh75qM3l0wn42iSl+byd8kB3d0k5s/X5zYH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=S6trjx5w; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1755653788;
	bh=RzgHInsAgvM49ztTaBSUL1uReMJ2cXNxksMU+r0vjR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S6trjx5wPQBBC0OxjY7Czi65MCqJCnK25+1DjSTHKMCzWw5YuNG3GqpbutbLBcSje
	 ptwbn1GNjfehSm4T/byszrKJQUsqLnaqRH2zne3BKM6UMFzk6DjMx8krhAUXwdRlSr
	 0nUOmi0/ZBc+y/uivWnTCzbBvBTHVfAh05YVm6zWOJNBtnxKCHjsRtJy5jPoaVk1fN
	 hxUxT+h67aWwp4KTc09WPcZMUDLY78/3plI81kdiAv+lMct8VMTfoHk34uMo/f385x
	 y+B5wgrQjBhYDnJU25IB2+q+BwZJgCVWIKNc4AMKbCFrjSzVPZO52EEeO9AUXe0Kam
	 wzfqDkw3cMqfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4c68Dq5kTKz4x3q;
	Wed, 20 Aug 2025 11:36:27 +1000 (AEST)
Date: Wed, 20 Aug 2025 11:36:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Petr Mladek <pmladek@suse.com>, Harry Yoo
 <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>, Sergio Perez Gonzalez
 <sperezglz@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/vsprintf: remove redundant header files
Message-ID: <20250820113627.5779ee46@canb.auug.org.au>
In-Reply-To: <CANiq72nNnz5esQpGFsENUm4cgGOAkkkqCuHyNxfEPHUrFvaH8g@mail.gmail.com>
References: <20250819131330.153128-1-liaoyuanhong@vivo.com>
	<CANiq72nNnz5esQpGFsENUm4cgGOAkkkqCuHyNxfEPHUrFvaH8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zydvPiGP7uer=17j3.kwNOu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zydvPiGP7uer=17j3.kwNOu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 19 Aug 2025 15:37:20 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>
> On Tue, Aug 19, 2025 at 3:13=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.=
com> wrote:
> >
> > The header file <linux/stdarg.h> is already included on line 6. Remove =
the
> > redundant include.
> >
> > Fixes: 0dec7201788b9 ("sprintf.h requires stdarg.h") =20
>=20
> I don't think this fixes that commit -- `stdarg.h` was not there back the=
n.
>=20
> Instead, this commit
>=20
>     be06b53d3af0 ("lib/vsprintf: include stdarg.h from sprintf.h to
> provide va_list")
>=20
> also added the line, and I assume Stephen only needs to drop one of
> the lines in this merge resolution next time:
>=20
>     3f413b9a3770 ("Merge branch 'next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git")

I have done that today.

--=20
Cheers,
Stephen Rothwell

--Sig_/zydvPiGP7uer=17j3.kwNOu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmilJpsACgkQAVBC80lX
0Gx3XggAnE2RYMexxS/N8EpU4wPq2TSTu1Uz1dvpzLuSk6ihZigzZcHrenYoV6B/
bAdNiOsZK8xfmPPB59d02j0H3Jc/fm3GEI33ho2c/bvzwJEnL1BgTIvTfm6nHKBe
eenXnrywRNYrz4/8mRC6eLWLC20wJwh7PMPX39mHcdWYrrXVHhzKeuxZa2iC0JP/
KOfBDFRTSsR42Fkrw/jSUe0Wm0yJV+d2+x6RQnHIQrWI1HfWrsZXrdjzNOG443zx
eX3p0sMpOA5uU3Y0stex4678/pL4lzYOKPadTXuPgdZ0YKCnS4YMSRUHZY1Cvhyf
Ekn1cTsG31XdIYWsSwHWYqU/NgC64w==
=xwbX
-----END PGP SIGNATURE-----

--Sig_/zydvPiGP7uer=17j3.kwNOu--

