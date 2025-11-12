Return-Path: <linux-kernel+bounces-897180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCCC52378
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 538ED4F44E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49520314A75;
	Wed, 12 Nov 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+MVu7u+"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7B1D5AC0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949249; cv=none; b=Ue1VFqp2RQoY65EE5f/TiAPH4uQ2670VIOZbrHJBw6Aa8NeFYfHjpWsr/uXonOt32gUG+f7KMESt3AxCD/VBGXIAurp4MyPV4o90bgdBUe2nEPEm0+KWnb8ZtWMGKPBJRE/T6MqjCuPMUSc1D78n7cLO+A2IgryVWAiiN73OiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949249; c=relaxed/simple;
	bh=rmaw8uxqe2EYzaqnQYDzGZ3+OW1penkChF7AR/TE5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to6P1llTilxekUYkaMz0UvWzAnMFJpv3JxJhbeIs1ncXMiMlLSfhNeGoHVoza09SLCb/2qYSq4lmFgl7sg6KjYp0wpaNSM+FQ6gTSJZny3xyOHuHmBJpQbpvD21QnkGTKjOPr0lMHjBaBwj3nXogf8puMI+SpCNCssHnUUgfimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+MVu7u+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b28f983333so82735385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762949247; x=1763554047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmaw8uxqe2EYzaqnQYDzGZ3+OW1penkChF7AR/TE5b4=;
        b=T+MVu7u+UMAI2WUUFd26WraGC3lDj+PRQi2AtwiJHtXKAwu1kEpZPZSu6z+EUkqOs1
         qSaAIasPEs+R566KAGP8osjfuHmYYt1bFp/IwTD1kYnqZnTdQEbaByFBTqIwEX4BVCyN
         fAdbirMizZlUnAPug4aVfKiPvVbCFT2Vwhw/zGe2HruhjLiYyZuFk1em7/O77p8LwrEr
         rt7Y4Op7k026U3WWlZDyfwx7pq7N/c/Qt6tSRA0RR8TdtblGDTTZBzvmvcq4e2l3Txjc
         Cu2X7tTxYPXSYkPGbScgGBWsIikHWZtpo0Wd0jjjs3Cc9e2qrNl1yB6GwJjlGgt6hUsU
         pgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949247; x=1763554047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmaw8uxqe2EYzaqnQYDzGZ3+OW1penkChF7AR/TE5b4=;
        b=X5wqzRmaOf0wW7AXARMeIfn5l6kDFrgAZR69LXKDnKqR72PB5Y6lV5ka0HYJdcBFa9
         TDiTUW5LwCtkjpCOCyq1A2q5Tj/j/48lOparg6XBmQC+o1H8XAl1nYZPzDNESCubOJoj
         yUldm4XZnjm69/xI26j6tAazFfi0bHTTW5N5vlMub7BpsRUU4qu+lNYjyXrfSFveP/uw
         UAMT6mAyOUHvGo+cWOupOwwGDAeMdxhA7z+6/wra2CxXEwyukBYIlVJAeZ2/RziHsCPn
         wzeuNqJCiL8piZqXcl5JYo0ih6S3kBBejkicA/hwyb5yBqSw0a3WgHXC7V3tRlGxW/Z4
         d3Dw==
X-Gm-Message-State: AOJu0YzY9bH0lgzwL2wqPb0xZHoijrYKoVapRt8/zdKpbgeDfkG+ut8c
	SOQhwWtF3z9UAsP8L06Y2vYG4gJyDkweG/AFHo7w8boSk3W8b557mleJ
X-Gm-Gg: ASbGnctbR8xBNBVai/kCoC+Bzm1mBXlU/z6mj+k2/yFhWpx9qvFOHLLHvJOK4ksGppc
	OaFiVpNWe1+6ve3vG35nkZxtWpHPf+bSNet67XaMaXseRm90JEHHDzrUTPzgjwq/wFSVU3wcez3
	sGplgb2B1Zfj315vTCjuDt3j23Hz8dbJoFkMkh+scd85b6zfo4co+pxal6BdfspapJLZaQdSl2q
	L6atWZ3RL1tmHeDhJO8r8QylPY8AUCn2/YS355WO5O1tLplkY/PKx/w9wcfzYaFeYdsD3AALDcl
	zRNzvcMJYSQGLqnDZflcVJ0MKVXV9GokGhz6SvqHPFUoN8CXEJYFqbhDWq1/s3niBdsWyvNegt1
	sPGAoWNG9fLhN1nssYKxlwWTnKZdayLIb17HJiRjzkFwQBD5MlURpseSTP0FIRS1oLLOsAYnxUG
	11
X-Google-Smtp-Source: AGHT+IHodS+pTxbKK//f1GSMGDWXc+XiJHZj4dNVP6EykXSirX90SEf7NOQJlws/+WQMWWTXQYW47w==
X-Received: by 2002:a05:622a:19aa:b0:4ec:f403:3019 with SMTP id d75a77b69052e-4eddbc82c32mr34381541cf.21.1762949247017;
        Wed, 12 Nov 2025 04:07:27 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda7116927sm80703501cf.13.2025.11.12.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:07:24 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 87BE14209E71; Wed, 12 Nov 2025 19:07:17 +0700 (WIB)
Date: Wed, 12 Nov 2025 19:07:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Security Module <linux-security-module@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
Message-ID: <aRR4daS-XsAFLkfe@archie.me>
References: <20251103113922.61232-2-bagasdotme@gmail.com>
 <aRKgyvrTxldlTv9t@archie.me>
 <CAHC9VhQeghqosexgOQO3==poNwsf_6mNiOqkUTUOdYnzRYzKmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kaEZR4YZ+xgx6+Vu"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQeghqosexgOQO3==poNwsf_6mNiOqkUTUOdYnzRYzKmQ@mail.gmail.com>


--kaEZR4YZ+xgx6+Vu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 07:50:56PM -0500, Paul Moore wrote:
> On Mon, Nov 10, 2025 at 9:35=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > On Mon, Nov 03, 2025 at 06:39:23PM +0700, Bagas Sanjaya wrote:
> > > Use reST grid tables for both type and permission checks tables.
> >
> > review ping
>=20
> You don't need to 'ping' for a review, your patch is in my review
> queue, but code changes take priority at this point in the dev cycle
> as I'm okay with merging documentation changes fairly late.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--kaEZR4YZ+xgx6+Vu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRR4bgAKCRD2uYlJVVFO
o9V7AQDHOga8MTEGHoVGvfFH7x5J65YayPNmGzE8rkS1swU6tAD+PMbAFNdlVCkb
PuY83h41Kn/NdSbZDx6xQS5WY2RdmgY=
=fNJb
-----END PGP SIGNATURE-----

--kaEZR4YZ+xgx6+Vu--

