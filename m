Return-Path: <linux-kernel+bounces-866975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F9AC013D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6491F4E3690
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53D3148C1;
	Thu, 23 Oct 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f6yIZXKu"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4C30BB80
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224310; cv=none; b=rNhhEZ1snVJHkCU47eHIToRnqPNaB6mcA+fX3dO91qDvL59GcfQ4Ym8Li65VERBOe+Yde++8aiZqKdFnbgb7N1WtdPYioY7g3AI/ii/i4Cj4re3VVBAnToC+33YCIwl/AkxcdIjInEs9U+w7oyXUQlk9/rgLTmR24dnxW64F49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224310; c=relaxed/simple;
	bh=xjeehlY0ayWZ3bhz/kWBr2+l/5odZE4178lrQkJI3IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQo+f80R6Bwf5LtKUSV8Mjp3O/XhE4Lo+SsJQnOjn6jWUeDEqsc/HVMBkPhdcZqDqNiQjs9F3+xgyyFfULykPWLW2FK5aMXi1M6sSh+3haj7Hz87ewMxh09ixBh8qISs9K6mUBDSzV5AsnIvEpApSpW7dY0AscP0tX2qXqbzmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f6yIZXKu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5c18993b73so144578966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761224306; x=1761829106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjeehlY0ayWZ3bhz/kWBr2+l/5odZE4178lrQkJI3IY=;
        b=f6yIZXKuOJEWRW81QXwDzxPRtSUgK2O3Dq48iDRNZ2098e5Yd7PsPoXHoTk8r6hj/H
         msU7FG9vGt3rG6/EYfn7ZlPopXpbw+/9/9q8GPkANeB8EGJFhDaR6DgPVQOPUPjI0QOp
         CXFayOUmIxrkE0FQb3hn/KJh/yPL+SUnKNf63tWkgR3BN6uEFdNoKCZyq764Vw5XW6i6
         tgcrw1jlGTzaJbcpuT1b+BXyZUg+sTDdPhNGII2fZn2LxRBYuBNAVpGv5ZT5naRf8cdA
         luLvA7bMae9nYU85kIg/IiN+SGrDNMw9IK7j3T1WASg34ZsZt51hkNgmuHzxn/Z3QHes
         rcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224306; x=1761829106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjeehlY0ayWZ3bhz/kWBr2+l/5odZE4178lrQkJI3IY=;
        b=WZPY6N2rDXCXd7pB7AVSZTeH1L8owyllqdSuxetPJMW3Qg4GLwGTGUm3N4OaMbvalA
         na9VlJVZMniXlEOWq3etgRdNeXDb0d+7+lHCGCgc3R+r9p8Xl4YtzXgcrGdZfJMC8ZAx
         wfu8EqpNqcaBY+YxmbYNjhoSVtb8097XzTN+zPyVGlhLEVvbpGKME++t13E4/3kaVw6O
         Zrpl4WzlKmsWp4L2Xrh+dYywI+EHB19gRJqSANMg91BWmNndAZKEkZLDPwYTWSIO7oqR
         q/RhguOe0w0Rd0SuhQdHPv5nO8O2JOl225nYtLYWzjQKEmCc3GypVW3D9LHdNd2QbcKP
         2n/w==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZfMLL+eBHQBt9Bp3DehhH9qxZ2PtEbvGrDGYtiL7tnmls2Zw4bmX3cGeChzMq9azO541UDIPuNUCndk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRHp02R+bRyC1kU1Wxc0Co2gigP/DuT+Pw18JoBk9KhI6SGXx
	ASN4qS9lzNN4E59RmQMsjvvtVZlJH6MQ80u13SSSFJXiu6Dd1n4FSJDymnHqokTlg5w=
X-Gm-Gg: ASbGncukuVjB0rV9ToZqW578yzPJpqTkVP3PcdLtztDe44/OUABhQOw8v699U9gxYe0
	D/tktwiEbPAkZvrT8LMpEUHamXCPkHCgsv/5m/GEBRilp7ryRYJPTjbisnzzjtrDjwS52ZHcawh
	uRIGj8nzp7e2/kY5ERewVsQQ1VPcCuTKNg5pLoy+zI94lTXcEp4fd+Li/hGEpCjlSQN/LLfYJZV
	Lw3vHRIzCKOPeXW1yWbGv+/xAPv3+ZV1r4aaN6nUN1h5VCA4rOdvKxWOTQB4ufptdKKF8jfI7PD
	ooHPJQ3RvP19Wk+hrjKFyrHv6OXWnlVX1qyuYyr4PXtlU38NHVJQF0ZBw9lxZjXz1LODigebGoM
	coiUzkq7GYwbKX1r3EMNM3b5jrFjASPIl+GXcVv96rxE1REp7s/84aSN1dffy4DYDeAytCUSn9E
	p9tjcVfaQ8Cy0SeIY=
X-Google-Smtp-Source: AGHT+IH8+w2hScL952t99dlA5WzytVfJZrsnO3QY3tAYI5JKTW4feC+qQ/6KlSZu1F3zvRjTIGTR4w==
X-Received: by 2002:a17:907:5c8:b0:b40:2873:a60c with SMTP id a640c23a62f3a-b6472c5c6ddmr2987323466b.3.1761224305719;
        Thu, 23 Oct 2025 05:58:25 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d511d11eesm227985566b.12.2025.10.23.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:58:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:58:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
Message-ID: <itxfh366j3yhshvp5abji6xussdk2fc7zrtvc3zzk27y5ouwpb@fvvxnpg3keus>
References: <pvid2ycmgbkbmegnnzwl4hyev6e2smusxk5olkuqxfwxzykz2e@jlvolirolrxl>
 <20251023115819.11094-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wntpsxgdxjl2stru"
Content-Disposition: inline
In-Reply-To: <20251023115819.11094-1-rakuram.e96@gmail.com>


--wntpsxgdxjl2stru
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
MIME-Version: 1.0

Hello Rakuram,

On Thu, Oct 23, 2025 at 05:28:17PM +0530, Rakuram Eswaran wrote:
> On Tue, 21 Oct 2025 at 14:01, Uwe Kleine-K=F6nig <u.kleine-koenig@baylibr=
e.com> wrote:
> > Yes, I suggest to make restructuring .remote a separate patch. (But
> > removing dma_release_channel belongs into the patch that introduces devm
> > to allocate the dma channels.)
>=20
> I believe ".remote" is a typo and you're referring to the _remove() funct=
ion.=20
> Removing if(mmc) condition check from pxamci_remove() can be handled in a=
=20
> separate cleanup patch, while removing redundant dma_release_channel()
> will be included in v3.=20
>=20
> Is my above understanding correct?

ack. remote vs. remove is one of my most-committed typos :-D

Best regards
Uwe

--wntpsxgdxjl2stru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj6JmwACgkQj4D7WH0S
/k7lgggAtXPs8vnFmq/fg2Ty175E+kYXR84uN5u6308vPn6bCdVgHaU62FeL4JO1
uCQWviLkqvGqfNYKlurKsn4vSdeRK1katvsYi6BTqanuYAMcZljEO8ht0vuTYJqr
KoFx/M7XEQun2GqDJvDr4weHJ2WgdFg4gCFuFnFxEpW2fZAaQ+MC0U0Ya69Dwf5B
dH5fBXIdpV/9HQSceLe62tE9h5Rv3Dn7tU9FcYS5dI7vS883B1BZkrOb4e7oUary
ED+3wJXueKXHod0aF0agKQSVyrJ/9d7XYfpQIIdYpnsLyZFAERarM+6OtWl3f0Zt
KM5dl0uekQzPkWrWcGV2Ig06F6bDlg==
=frsd
-----END PGP SIGNATURE-----

--wntpsxgdxjl2stru--

