Return-Path: <linux-kernel+bounces-822906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0AB84F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5462546607
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F8A219A89;
	Thu, 18 Sep 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uJgbfhX6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AA1F462C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204051; cv=none; b=JqOMCVd8cJKKHzX9gV4wR9dIPROfoeZNwbCefZdxkm4cxjbXlvkgTOfO+ID+YvVpFrZPGXHKEXhFe/nOk/6IguHq1U3VqBbv4hRljplDtZUZZMQAjuQzXBHJ/kkp3EgrJA9cPaP4FZy+B60RMKVixZk4dZz2hwLw+7F0GwIzI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204051; c=relaxed/simple;
	bh=JNX/SslDgJI2zPP4a1GdXBRAxKhToRnRpTMWOCCQjEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YViG/zGtiB4bKK6OfvxW/loTHg7rHjE0btlGPGmkb1agqmmOWA6dZn3OxLDEhpJwTlnJ4Nr3qtQKN8UXqlOQEd+wqKVVcYVQ4XFT4m2XUi8jJKYmZzyy1gbywsUdW0jc1g8+NY7t2MLx+xEbSIToG2Yo8M4z3oOvOZWwLYTy6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uJgbfhX6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2400dcc55eso23714466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758204046; x=1758808846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZl1LbpajrcKcHCR4thQphAz5GFPtLa5N4YGaqlGRQM=;
        b=uJgbfhX6oAUEw2vyzdbdblxWI7cB8wMDcUwZhH1RUzcNmXAe5yjlVV4xTiDiCKgqMW
         fYvwKWvj50EHHixNFyJJ9T8EU+ratSP5apvaGaeXIzDxSNsRzbhHOUxxHrL5OeBH1zAt
         Fpn9+nxmMiFH/RM9xbDm+OlMsngpi+lK9ZcjTd4I9sd3oEv3D6xx2AO+CslJgC3h9z+n
         +7O78HQun5twfvxZEj9OlEuux0Boh7tsLSZ80IKPq+ayKksb9Jhvq9D3vW86Xejkqa/W
         mVZixlWut7ddsKZm6XhRgLREm5cOQ51a0csDlgfmKCm1qL3C3tVmcgj5HCBaY8hpnf4T
         9c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204046; x=1758808846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZl1LbpajrcKcHCR4thQphAz5GFPtLa5N4YGaqlGRQM=;
        b=c33l38z7snrxQIUBCQxEPcDSa4R10fbL3MJZtOJ38GgVC5zJBy1r4D1JNK3lJZ7Qd7
         UoXZM+WVeaNyM+wuc65mBxZnXol5d5+/j8Xx28e01rJ30I81ASoa56ma93O/2wgMuxAb
         GkZq4EmMknQWFzLkYvBlCGWYR1qq7c/pJzqES7Vt5+UtN0nQrjqHOWQqPU/00AtSfCNJ
         K1Qps4pYjU5gVQCOcNJ3g3Xq58TGg1y14NJzGl1D+CpI09+bDG2YRe6BMmdknRuSuCJF
         xwgAsHH6dCc40KvJGz8EG3Bvo9gy7nKIP/y+2yfWCZmBu8k0rinK6JBy6heVjle/jq8R
         FINw==
X-Forwarded-Encrypted: i=1; AJvYcCWcevF0Pcgqu2vRkuVabs84UNHG+iVtr+yQfnkVoM3r6X1NyYvXoCvjJR9mFuXeHiLXUuk5S9QahNdrva8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCYNbdNb3W9f0DD9rnZCwiweRdPMWaE1EOJV5meS8+//gUDHV7
	tR1srPokagUIg7piDLjRs7lGtsXk8huHTChZhUjvnH20B8IalRy/UDpFKVpX0OdOas0g1dKc1Zd
	BkrOb
X-Gm-Gg: ASbGncuLNVlL5MssuE0RsSYqOdhmykg6ZFBC2TEG9/Xg7LKT1IzTIxd2v3mA4gr/s6w
	IbM3DKHWYv0dpEzp2nEH3KNBj/ng589LYsde/Qti4senJBrnrETEA0OER5SUd5mXDVPIQkMqkyH
	si12FUpqTLjl5wQPRymPs350FwbtjT1yiSGCMS5IWTA4EkmS0ZkuHbLT20esrIePEfNK0T11Y51
	DzBbgg+PNWz1vB34gZCmASkroLlnlmmcctV9XQV014fTHE36LUTYEokEPRehAiQ75kKlU/z33Wc
	c5IKhWThIW1wGnQ11eQ/zBYo71ORyqZ/SwJvprqQfRcZSIZ85vNHU+TIdDOKGmwVrzCc7nhXMj2
	mdgJ7pXXFty2hWGYUPOvFv0mbHsE+4MqkQbrr+FRiFCM8Dw==
X-Google-Smtp-Source: AGHT+IGs0sWM3AvmiVkBqksnbqDo+J8t3UXb9wWx/kLqUitBwBfi6rqqrviU2E01/4fvZyYO9G2bug==
X-Received: by 2002:a17:907:3e9f:b0:b04:b55d:46f6 with SMTP id a640c23a62f3a-b1bb7f2a42amr655756266b.42.1758204045900;
        Thu, 18 Sep 2025 07:00:45 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc73bb6ebsm196419366b.29.2025.09.18.07.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:00:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:00:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 next 05/10] lib: Add tests for
 mul_u64_u64_div_u64_roundup()
Message-ID: <tvv7kzky7wdpef2s27fpvav6a7sbkmt45v7j63y4jirgq4sf7e@znv4p7d4u7is>
References: <20250614095346.69130-1-david.laight.linux@gmail.com>
 <20250614095346.69130-6-david.laight.linux@gmail.com>
 <q168q017-9p30-69p2-o4o5-s6q1s1385o27@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sg2rnjthdlnb3kvc"
Content-Disposition: inline
In-Reply-To: <q168q017-9p30-69p2-o4o5-s6q1s1385o27@syhkavp.arg>


--sg2rnjthdlnb3kvc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 next 05/10] lib: Add tests for
 mul_u64_u64_div_u64_roundup()
MIME-Version: 1.0

Hello David,

On Tue, Jun 17, 2025 at 12:30:17AM -0400, Nicolas Pitre wrote:
> On Sat, 14 Jun 2025, David Laight wrote:
>=20
> > Replicate the existing mul_u64_u64_div_u64() test cases with round up.
> > Update the shell script that verifies the table, remove the comment
> > markers so that it can be directly pasted into a shell.
> >=20
> > Rename the divisor from 'c' to 'd' to match mul_u64_add_u64_div_u64().
> >=20
> > It any tests fail then fail the module load with -EINVAL.
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
>=20
> I must withdraw my Reviewed-by here.
>=20
> >  /*
> >   * The above table can be verified with the following shell script:
> > - *
> > - * #!/bin/sh
> > - * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \=
4/p' \
> > - *     lib/math/test_mul_u64_u64_div_u64.c |
> > - * while read a b c r; do
> > - *   expected=3D$( printf "obase=3D16; ibase=3D16; %X * %X / %X\n" $a =
$b $c | bc )
> > - *   given=3D$( printf "%X\n" $r )
> > - *   if [ "$expected" =3D "$given" ]; then
> > - *     echo "$a * $b / $c =3D $r OK"
> > - *   else
> > - *     echo "$a * $b / $c =3D $r is wrong" >&2
> > - *     echo "should be equivalent to 0x$expected" >&2
> > - *     exit 1
> > - *   fi
> > - * done
> > +
> > +#!/bin/sh
> > +sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 =
\2 \3 \4 \5/p' \
> > +    lib/math/test_mul_u64_u64_div_u64.c |
> > +while read a b d r d; do
>=20
> This "read a b d r d" is wrong and that breaks the script.

I think apart from that problem the series is fine, isn't it? Given that
I wait for some time to be able to use the mul_u64_u64_div_u64_roundup()
variant, I would very appreciate your effort to end in this patch set
going in. Do you plan to address this issue? If not, I offer to look
into it and create the next revision for this series.

Best regards
Uwe

--sg2rnjthdlnb3kvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjMEIgACgkQj4D7WH0S
/k4j6wf9GRHiFrIASf0J9p2XqcGuVVYkXMDtEfjlsrzaYnkdsbdTAUgtxVv1LJbm
0gyk0cBZV57rJLHRUh2dZnshk5wfeKLhewHUgCT+dW3T2FcYgQrEypSAEVbCxxKe
1ELmbgUVexN3OxWfyKThP7BwUEJaZaRBBJj8IP1NF+/QBSJim9wRuaVruCjYeyVi
octBBXu6x4SN+2zSfp5AZWzGy1DyZj9RSiCY0tXAZreE8pr20fCdgYPiKw5kUPcA
eXJSJliuNpQPxKxBBtQeOJUyvO4XYsAn3fiZTsIv+e+gxGQV+tAcVAvI2yRu8m9q
8MeZEFmO6yoNv4+mWGSPJrFyx4Bt/g==
=CKlj
-----END PGP SIGNATURE-----

--sg2rnjthdlnb3kvc--

