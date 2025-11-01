Return-Path: <linux-kernel+bounces-881604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02CC288C8
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 00:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FCB3BC317
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B9284684;
	Sat,  1 Nov 2025 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwmTRJ66"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10572253F2B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762041298; cv=none; b=cKmGkC+HaYbggVmDPw6VZkVApPITePhWt3hBsezKxio37/dlM04fW3eihJz9X6hkdDRWyFRelbbxginefhSvtJTFcFqCkRqFfVXJixNyjpjre78fOCF7puQ6n0SBozWqToy83dEvqLhO5DXk/IJPqQ6BqputgjSM1yBqZNQcbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762041298; c=relaxed/simple;
	bh=xgmMHnJE9nyGfUW7qSuFmTJU4ryqeC0sODpQqSngQZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od/p+bqMgHpR78riS8tdxloUzFIEGk4snraxO8r3ujQymQ6jqwkR8kUZ2o/oy1PXXqtA3vDyz3jSSYXBJF+F19sxImmKZlEn2TX9hgYBNzrl2CEEQMPrSYUxFsluMZVWR0ZLTCGf8coBVMVwFfkfbuMqP4jRWA7f+aS8OGWjgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwmTRJ66; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-793021f348fso2828169b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762041296; x=1762646096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9hoCdewjF0s6SpozCA1ZdHeew40UYH9BAWlJjuRVuo=;
        b=XwmTRJ66PHIEe2k93n9txEt/hqE1bOCWPIXu6Pku9UaL2oGlL4S9+Oie67ou6aiPBn
         j2f5eKPvr4HfFrPzK+qRObLPZY1oTSxlrEwkHbTSN/BUp+CxbIAG/WTb2Xk+ZcLNhI5e
         b1v5OrRbAJ5YZarCuhA+lSLxluFnTP5wHL4VyrmWiJADVOdHqEbftdhRFCnRGVWEvm+V
         5BK2fF/+F3bJHe4zDDcfLSmXSgWTu4OIkLL0hjhP73HGLSgpxhzQ2Lngcg79Y18RgbAy
         nQ1Bi5A9+1LRXGn6T1QjBoFdSxlLqqnHRR+aAuk0hwx2vEldR5qQRsHyzIim4Zk7l4R6
         XTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762041296; x=1762646096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9hoCdewjF0s6SpozCA1ZdHeew40UYH9BAWlJjuRVuo=;
        b=i8q24Nok6KZB9D+oaCrryXzxmAAqYpIuW2xeiB+OhcQ7GLo7NHovX1IrtBVudRPIll
         rBxaFQ7ns3DP2UcHx1BrADi0kECTudCQ0E9YWffgSG+G4ElU0q41unQkp5jWZVR/NOyi
         88QmHbJaQe291vi2tKh3i21rIRG2NQzseaXiOwB9SKfC8NNl4sGe1bHjMRK8XOtf/WFJ
         7HEl3SvYDXKQ/+GOFmqP9ix3IRE5IRXvylbLT6X2EL9ANNJ0JGugkeTecB7v/YbD8feK
         sVT6ZbbK7Hsd61NPVxS9K52BSaipGK/bKcbnLZfqo0qdCjnFaYtevcl702EHLUpV5sMf
         35Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWc+7bxWVJRy28xo+TcMzypEYSj5uyyZkvWH4il4FocvqlCWNjQi9N94YMKGJdw375kIJ0m5BdNOJnWzmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBZRGgg5d54Y/abftzAoLfqQsz1aW/dmeUktCNzeEOSAyUY+e
	129aP/z+atLKIn4+lnTbGh6B1olrAOI/RB4ZWKbh07AHkM12yG9V+b1v
X-Gm-Gg: ASbGnctpXHKXWdRKjG0611YGe1+D1YM2Ti1WO47Qva5CpEOjFTmBI6YrNwkjaBT7tt9
	ikfS9j90YtZ3O5PEI/twiLRohQAXJzpq3Dn67zXrpW3oDbJKNmOM+wSA5s/jXIXzV/ZvSySWxhG
	VtRCrEDSnNrQuJPx8/NEgPM540DBzS7TMvs3awE4isREb96hH/+5ooJhVQjF+xTdIViFh27guFk
	z/8B/drIeZe2oEfGAUcUVwWPiPdZ0Vq5mJ6DecGCjOUh0NIU853w+lDfSIoiw1DR+kpDV2zi753
	6Zh93VRe96BdIYMg3mwXickA2zRTbfZXH0i05ZAk9l6UK+3hGO9kW+gAjVv5MEXI1zMo5g+WbqB
	tNKC0zfo+7vrsOHRTIBRk7OtI4K2K8OFAgO0r8MdyKZCzs4DcVrRZaNlwqI6fdrNfUTyQmxn2qi
	qG6Q8kjqMSBXg=
X-Google-Smtp-Source: AGHT+IETQALuNkc50yjdgSemgMAnaSbNIMYW/a7SYG7aVvrdjhVmCDIYPsGxrnhq1+Mmjh/q9Xu3WA==
X-Received: by 2002:a05:6a00:4f90:b0:7a7:2a:2ec9 with SMTP id d2e1a72fcca58-7a7790db385mr9055615b3a.23.1762041296277;
        Sat, 01 Nov 2025 16:54:56 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aa20972e6csm589226b3a.18.2025.11.01.16.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 16:54:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 773904206924; Sun, 02 Nov 2025 06:54:52 +0700 (WIB)
Date: Sun, 2 Nov 2025 06:54:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next v2 0/8] xfrm docs update
Message-ID: <aQadzN8IvCUWWHsF@archie.me>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
 <c3ee9b5d-62f4-4c7f-b6a4-9e0dd8290edc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQI/Pwj3uM/nLbG9"
Content-Disposition: inline
In-Reply-To: <c3ee9b5d-62f4-4c7f-b6a4-9e0dd8290edc@infradead.org>


--EQI/Pwj3uM/nLbG9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 11:58:37AM -0700, Randy Dunlap wrote:
>=20
>=20
> On 11/1/25 2:47 AM, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > Here are xfrm documentation patches. Patches [1-6/8] are formatting pol=
ishing;
> > [7/8] groups the docs and [8/8] adds MAINTAINERS entries for them.
> >=20
> > Enjoy!
> >=20
> > Changes since v1 [1]:
> >=20
> >   - Also polish xfrm_sync section headings (Randy)
> >   - Apply review trailers (Randy)
>=20
> Changes all look good. However, there is still one header that ends
> with ':'. Not sure it is worth fixing.
>=20
> XFRM Syscall
>   /proc/sys/net/core/xfrm_* Variables:
>=20

I'll also fix it in v3.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--EQI/Pwj3uM/nLbG9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQadwgAKCRD2uYlJVVFO
o6m6AP9q613RsOkDQM3bSTu3sb/4AXQrQAJW65J31kF1tRUVVAD+Mh0OQatN1NSk
Gu0DwhO1Oi833StX4eC1TLlq00RClgk=
=3dB/
-----END PGP SIGNATURE-----

--EQI/Pwj3uM/nLbG9--

