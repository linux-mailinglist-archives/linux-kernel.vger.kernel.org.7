Return-Path: <linux-kernel+bounces-844188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43007BC1416
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629413BE8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B81A9F8D;
	Tue,  7 Oct 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FALJvdlw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239962DAFAA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837641; cv=none; b=uLL73Kty2JucJZcAU8vmuE28Zvir7Fcm9eBozsFBPFM3g5jwWCKESiNUSlWY1WNpycgHRVEMT8ksii3CNLwz3UzaBnEF71UfIS7eDIhI3UThTCoFQ1rKy4gEi/W4IVPNP7zyYk6fg5+rYJNBHG9wdwXg32eHwhrDHyIBM3eY/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837641; c=relaxed/simple;
	bh=tHybA+sPs/+b+P0zGrwAATn7fve3huRWbNvhgJc3ask=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQUyHGGUkxW3m59CyyT8h4YEg67g4TETBjsDWD9KJ2WgET7EPfhkvH/CfPEDkrMuxGqGzBYMKmWurHLjof7fMJogPSgZ6tsupeWBEOoDAt/Ygi3SqSzx1SDxTqpzKKqk7j274ppIgbQ8atwdjz2XFElTWlVMgwocDoKIZ2dc4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FALJvdlw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78118e163e5so5633685b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759837639; x=1760442439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpCgxhORN6lEa4s+DNPc1Y/IXSmA220J4nQ7qgIWmeM=;
        b=FALJvdlw0f6fzKMr7jGOs52hp5cx3iDizPSBm+MFhbWxTyGAtKKWoUBJ3vOl+XSlt+
         FLEWhGCrxqFQAMK3Kf5M9njSA29MACI4m6OPcJ8upInIkLMsJd4ZN4VyOpYMpz+rptD8
         ensBm8xczJrCLErPMhVUOXKyGiyrGML1q+8X4uSXJYr3Sl6BWLCf7Z4fL5Nq8bJBGmBD
         vqIK35NOHrPLbf4AldCLcFdVXM1yumgz+y3hyn9mw1985uLxa/45PHAIoe5C7VgV1Ewc
         FExDBn9o/NrdAWpsMktsvupJ6oXCOpwTzhujb2XcxLpyqq4osTiVOkVv1oBdc9AiUkv9
         s6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837639; x=1760442439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpCgxhORN6lEa4s+DNPc1Y/IXSmA220J4nQ7qgIWmeM=;
        b=KnLyqIWeWd6XU/mwjEOPtFCTTwKakbCrpWC3rRNvmnZqRAV3oRKXVCg1EjEMwz1HFb
         LtzaSFwSXlwhqBmEJqP1f6CT7MBvvZmUXTMM7n9LxhnsceLeLmm+0WykA8ZP+PReD9HU
         a1UMlLE9zQ9HzJfVGsDtpiBZJYLy2KXZBCzgkNuvbt20YAHM0HK/IC8svsVwVCaporGJ
         QrCicJ4WFu/CBavUVn79uQ5u0tH+Las3xbviwAASQ6DPs6y/C2A5u/74qpWcVsuhN+xM
         9BdHO2Hb2ONkoOa/buej1AXDx7OWV4bD5jXlwFfnlNeTDbc8QnmE1ohyxCVO53aGCdXQ
         OKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcv3Dkk0aKhTE6e1qjpqxO1dQ1VOvssY/z3LG0Cf4Dv3SDwHdMekOmAw7s5eh/KhLbWRuo8ubLphlA37Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7O/GdQeeCb9Xgg/GBvD9ZGu6i6ycYpIfO2pOA54qgkIHSBGOq
	adAW1PJadzXyMbB8Ex0y1V+7aTutrZiINEnpR0E0y/foPSKCqB58WCkz
X-Gm-Gg: ASbGncvjCfHVjrqeH8UzERULCsNizXTbeggyWwRixvJj1ygfI1xwvlz+8mJrOOXJJE5
	2Uj5TRloWLztzn5uyq7HJcoxIaOIj1K8+isMA3oQUVo8AkPKK8WkL4w4osiX/D64/eQcw7ABSC2
	CeR0NG2ITbSmI+VBa2eYYlBk+udXf6BghkKlK/z6vn8bNlzpLDBJWuOinMa4yDFwYjjj/hZklsC
	Btuzbc8JcLMMRmQYvzzoo+EzPopqodmtfayZwi3VMZWorljZ7xt8uOm+tpkoLbkfixfEjV+PH5B
	xJsGEwguACzpdhNwkR7lwKKew5QG+R3vtEGsc+3pnft9fQaJvnbyNSKy42rhXmZlS4bc3Z89/0z
	JsQfCdWHpUJakopKq7Wu0Fkw0YvZhOb7vC3TyuWjizuu6480Exg==
X-Google-Smtp-Source: AGHT+IH44vhk9d17Lw4GXZ5yzA6My6EceoSjc9zLI8SRcAEeP+70+Ts8xj+ACG9aEOYyI9bijbzveA==
X-Received: by 2002:a17:902:ce0a:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-28ec9c97565mr36083695ad.16.1759837639170;
        Tue, 07 Oct 2025 04:47:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d12608fsm164155715ad.33.2025.10.07.04.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:47:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 865214233431; Tue, 07 Oct 2025 18:47:15 +0700 (WIB)
Date: Tue, 7 Oct 2025 18:47:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] Documentation/rtla: fix htmldocs build error by renaming
 common_options.rst
Message-ID: <aOT9wttB8cQvFDdj@archie.me>
References: <20251007083228.17319-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YjlEHS0UDQisqRua"
Content-Disposition: inline
In-Reply-To: <20251007083228.17319-1-krishnagopi487@gmail.com>


--YjlEHS0UDQisqRua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 02:02:26PM +0530, Gopi Krishna Menon wrote:
> diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/=
tools/rtla/common_options.txt
> similarity index 100%
> rename from Documentation/tools/rtla/common_options.rst
> rename to Documentation/tools/rtla/common_options.txt
> diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/to=
ols/rtla/rtla-hwnoise.rst
> index 3a7163c02ac8..cc2721315552 100644
> --- a/Documentation/tools/rtla/rtla-hwnoise.rst
> +++ b/Documentation/tools/rtla/rtla-hwnoise.rst
> @@ -33,7 +33,7 @@ OPTIONS
> =20
>  .. include:: common_top_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  EXAMPLE
>  =3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentati=
on/tools/rtla/rtla-osnoise-hist.rst
> index 1fc60ef26106..a11c485f127a 100644
> --- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
> +++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
> @@ -28,7 +28,7 @@ OPTIONS
> =20
>  .. include:: common_hist_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt

For consistency, though, you may want (in separate patches) also rename
other common_*.rst files.

> =20
>  EXAMPLE
>  =3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentatio=
n/tools/rtla/rtla-osnoise-top.rst
> index b1cbd7bcd4ae..c7bc716b2899 100644
> --- a/Documentation/tools/rtla/rtla-osnoise-top.rst
> +++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
> @@ -30,7 +30,7 @@ OPTIONS
> =20
>  .. include:: common_top_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  EXAMPLE
>  =3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentat=
ion/tools/rtla/rtla-timerlat-hist.rst
> index 4923a362129b..547dfc7ace58 100644
> --- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
> @@ -29,7 +29,7 @@ OPTIONS
> =20
>  .. include:: common_hist_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  .. include:: common_timerlat_aa.rst
> =20
> diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentati=
on/tools/rtla/rtla-timerlat-top.rst
> index 50968cdd2095..3740fd386ea8 100644
> --- a/Documentation/tools/rtla/rtla-timerlat-top.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
> @@ -30,7 +30,7 @@ OPTIONS
> =20
>  .. include:: common_top_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  .. include:: common_timerlat_aa.rst
> =20

For this patch's scope, LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--YjlEHS0UDQisqRua
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOT9uwAKCRD2uYlJVVFO
o26DAPwO4e7EjANEwcmc6zau/qLSOmqV1xhe8ihZQO2SN2a7QgEA2X3LzAtWqe1I
Kid1Ufu3MBRc5B/abDTix3q8NM7L6Q8=
=FDcR
-----END PGP SIGNATURE-----

--YjlEHS0UDQisqRua--

