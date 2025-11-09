Return-Path: <linux-kernel+bounces-891763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E422EC436B5
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 773DD34850B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BBC14A91;
	Sun,  9 Nov 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk7Sevt9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E934D390
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647289; cv=none; b=RMOpjeW3Mx627++DXHztwWNGoVrCTmjD39ZKx8hb088zfce6VQtqBrEq0+2fyAYWW5eOf87WSxiJUZaxHgjmqvQ6Z6w5fCuzskf0MsMb3dAcf2L+gMA5cNnH4crMiktRZR+80PikDp6ik5RxFEme9cHTWV1p74fPibTAJsUiv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647289; c=relaxed/simple;
	bh=1FCuGcDK3XvxPrggxT7rwuFXTqjvQpQiDwQgoaP+1J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHCRGUawW5pkHUrI2lO5zHtSzH/bJHrrpY93QSqjfxrW+J4KokO1z6J0ArBauhavlLgMIdHNyYW2IMuh8OEO+pG+fF9CAkXwmon00IN7byy9+Dh3MJL/PUprPx8KSP6DcPxGO0QFjF0jIspX6UNryRtOXcRfykC4h2zvY8RlOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk7Sevt9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98983bae80so1074967a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 16:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762647287; x=1763252087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qOyZsPuzX58gtWPrYkH/jLPI7MNkAhFexJpLYJoWC4c=;
        b=Tk7Sevt9ovhY2hQen8EE2Ok3xJFhtov56KzFjXL6MlygwJSCrsxPHMiGYBbOkzyKoT
         Sxuc1Yl10I5cbmiddPTIn340HPSxC8JYR9dzZixvQ/U8HvlWfjdP30SEf87ZkcIknz2J
         o2/F1xNdk305onU0LwcvCdoe1UiBulu95aprtoiKT7S7oAK6WRIvdXP1IK5LvNBkj3Mu
         X5NWQtP7tr4qjliZjklYfD7gXkjjq7lzAIpdA3mfN/j96PCiKzCmT3pQJfZ98OZasZGS
         aas8txlqkA8QP0WiubEJ51zD2B+6EwoWydVWOMoyU36C/pKvTMYX5JswH6ENzIu5VwAj
         eUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647287; x=1763252087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOyZsPuzX58gtWPrYkH/jLPI7MNkAhFexJpLYJoWC4c=;
        b=jidsXuk5xgSXy1Wk2KJDVkrRST+O0w6oQyhr9FAhSOa366FFAl+vGfN6v1wW1s5Vh3
         +zqr67S2+FCOnTRGYBdyEfc80qg2eI1bE8UiJH/LRrFdYr6eKV7MJG7QANMRE1Ktl1h0
         8EfRRrheKYidU40cQRCHP9xV3mvFzg5pC20UtohJdam4fovmNhICdCedNV4mRyBfpleJ
         5EgXmavmjR6n8WMLd234Mv43wi1hVXcjjyRYIizzJWnTU2Vg4fy6aprVMWQ/za9WlSQ4
         Uqc5x1uZ2/b8ek06crkUqk+T3Wvggl3ePC5APsSc7w2/HKz+L5WqzK046koJ3BLni6Jz
         vysQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKXljtXzRrFUnzUE7zESNdj9JlF6kEANCNu9w1bgeS42pl9xRNesNrTYa51Rh3rpdV9NqZQ5NX0HgrDcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7kVOI7yeDd0g1pd/S/OKwqBbBu18K9Iivf8EPCX/73059NAr
	OI39hZpoDhCwGA4oGbPK8BQsox+z8k4AMmWanCGQ7BXr8ni4JLwtnPoy
X-Gm-Gg: ASbGncsXjvc9n/8lhy9+ANUEtZaJBtxBtEF9wsfxYfUASdJm2nSHi3DCUmIEvVFYIG2
	u0vOe1sg36AjXO+5fkHUOLFFWe6s5qdYuLZ0KJN6hokQAzLagHS00uE/T1vTrwUgGAvaDfBw2rp
	zHD8nc6Y8PuFrH7znC2lr4vwG3b2tJCqJrbz8vGcaP2kIFLxviNdExA13nenjIqqHCOcJM9ZcG1
	msiq/PNaKz61UaczffP4+ShPgfs5oCpUi3WK8bttOfW0EI2Ghw8lQL5EoVZTqypv7fiMVqM+wCK
	t3fX8KFIF4rPZKk52oIzg9Pp4H2ol6AAsdvU1utbdXbfFpTdQp7cT0+L/4S487j8lKWcPhIekr9
	Y24yt+V86c2bOkBU1FwEsK0eNS+SHgm7zELaGeZ/nSTwT1jpjdBUnpbllDYqCsK1NKCqq5YQW65
	PB
X-Google-Smtp-Source: AGHT+IHt4ugnoYmkZJtOdgGe/nXVblQJbMdRzISLr0DnNLkqVwecareOvsSo44fUYCtZKT8sACUBrw==
X-Received: by 2002:a17:902:ce0d:b0:295:9db1:ff41 with SMTP id d9443c01a7336-297e5647238mr47731855ad.21.1762647287029;
        Sat, 08 Nov 2025 16:14:47 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297f2d9c971sm19440425ad.55.2025.11.08.16.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 16:14:46 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 34938420A6A0; Sun, 09 Nov 2025 07:14:44 +0700 (WIB)
Date: Sun, 9 Nov 2025 07:14:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: pierwill <pierwill@gmail.com>, tglx@linutronix.de
Cc: bp@alien8.de, peterz@infradead.org, jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierwill <pierwill@users.noreply.github.com>
Subject: Re: [PATCH] docs: Fix missing word in spectre.rst
Message-ID: <aQ_c822L9lSTtwl5@archie.me>
References: <20251108192216.28534-1-pierwill@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IThEY7CiLhqP6dQ6"
Content-Disposition: inline
In-Reply-To: <20251108192216.28534-1-pierwill@users.noreply.github.com>


--IThEY7CiLhqP6dQ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 01:22:16PM -0600, pierwill wrote:
> Corrects a missing word in the hardware vulnerability docs.
>=20
> Signed-off-by: pierwill <pierwill@users.noreply.github.com>

Please use your real name in the SoB line.

> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentatio=
n/admin-guide/hw-vuln/spectre.rst
> index 991f12adef8d..4bb8549bee82 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -406,7 +406,7 @@ The possible values in this file are:
> =20
>    - Single threaded indirect branch prediction (STIBP) status for protec=
tion
>      between different hyper threads. This feature can be controlled thro=
ugh
> -    prctl per process, or through kernel command line options. This is x=
86
> +    prctl per process, or through kernel command line options. This is a=
n x86
>      only feature. For more details see below.
> =20
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

The diff looks OK, though.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IThEY7CiLhqP6dQ6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ/c8AAKCRD2uYlJVVFO
o0iBAQCmU+NZb0KYYIqdpTu7kYunqTRjcy+KI4Fqp/SVJGwxVgEAtwAdzG0GCz/R
5ipLLTmXNI5IQbzgXgY1R18NayWVcwA=
=5BpY
-----END PGP SIGNATURE-----

--IThEY7CiLhqP6dQ6--

