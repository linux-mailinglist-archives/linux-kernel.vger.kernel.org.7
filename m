Return-Path: <linux-kernel+bounces-891972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E7C43F35
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3D1E4E2A32
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171E2FB094;
	Sun,  9 Nov 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXUdPeIY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB11C695
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696212; cv=none; b=R5r+t96l7/+BAOqKdbXYWE6/8swGsm/DfWr/Oo0t8sFXtMHBjpIl+RmxQxvkJazuqdwAD/bZsw1nePn2Ri45i6JP+sfYDG+Zv2JbbZWWeQs8deOB3dBHfI+MR81S/VJ11USQaCooJiiEYiGouPhLedLWA2LTdtSmsl1NSQGmhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696212; c=relaxed/simple;
	bh=FkXGQJ0cT+VzRQhQb+dZvS4bvOW1XkCYlyGjGKcSZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGx5bpyjmRhLMiEjek8Y0yMsz7j7R8s5X3MvzpuHcW8Vjc4sGnPVRtnQXSqeZKZ734Q2iJkA0CD6cmCvcj8Jpd5ZaXcBn1UxHQU0LldekPYR/bF6hHKVkeK1bFc36h6I9Ky7gxS0eHL+cVrE7KRwmCjwQF0IInKTibJU9+SPUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXUdPeIY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555415c5fso27753405ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762696211; x=1763301011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkXGQJ0cT+VzRQhQb+dZvS4bvOW1XkCYlyGjGKcSZdo=;
        b=eXUdPeIY8EI+ii8BaoSagUwSjNxuGUfLJnAbTuNz2KHodVuS4kuw4GlAuIUgIypAx9
         5z/PjxIUS5lP+UlE1zLgBmr7cMnmspf+MOA75FZWLurZGudDT8FB9Xq7V4LwrOpHjQjW
         0ipw9XXuzb7wvIBUfqxeCkUFiCF9smhlFPpfnUX9geZLEaCi7n6ORWj8yjcLlHfLseLt
         sY5EMkOtPbG+DIjDu/jCpFvpz+MOcI1d95bqGmqU1xapB4I7U3bDg4ZJVEFT/IXEBBjj
         q8C7iKLBIkMKag+wJo46AQPCnMO0DoQT1D3bh/IhHgll+G9RrsBT8TlT1YRbAg34OITK
         gEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762696211; x=1763301011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkXGQJ0cT+VzRQhQb+dZvS4bvOW1XkCYlyGjGKcSZdo=;
        b=XcCu69wvEGFXZ9JWQiCEZZ1YcwaknYbmIkBFgVNSh5JSEdSn34L5ggbgDR8d4DvLEp
         LST1WAP37qMqBCgOdXKI1EWv7ICGeJTfHPGA+Sj4I2xKXv4MEbbE+aFWR+ZDXxkdm5Tb
         hMgviMRgSkd4mbFzl/Kkjl4S7SaVkJ4giIm53kKcsKRUyRJF1aMOECdOgTBHTAoBfe/m
         /bT6pPFQzOsJirIrFVZ3J/0jp5zoqNL8dj89yJVm+wuQceo/5mIR+lOkruo6058FPceC
         Et5b2T/Oe5Zy6zfnCFuVo+jxKaay3GiqOnpL4MwqvY5zwh7iphHmvw6DX/Cp5ZnAnkK4
         En5w==
X-Forwarded-Encrypted: i=1; AJvYcCUzd1LpBrolPpEBM9aMQP87g9bZgCnR/R9QdFml4owVbaPfUXsRGZ77/2iPnqAsgT6J7ERgUXn9pKj/+Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyazaZ2WNlYDWoK8Nh/SCFw7kj7bJO/guuyt7omJ/vz2JEkrlDw
	uyhlbybCWVK3QmJ/kMWG17KJBgisfLC8L8IvXjmwCTb3Hfmry83tTiUM
X-Gm-Gg: ASbGnctaFDkmz761qpJm3ynGnh8G8IjqDSvcotmv2i+R8syy+jKXx0B/UPBMLTCm9HS
	ga3mYXfOlIVfSOrsoJpHQregQK1KRdrwIcOMnvauo/ET8c7s4v/z7LVqU/7STxtN3EQ6c+0dOBM
	9RcpHJOKrr2hkHoyDVWqrfjjPr43B5BzGYAXluhlOUCn/hNTbYhSuuke8KGAVuQ5Br9imjvTcZt
	u24cOTYUlteUtndc2+QeLop6xebshKc70pz5+FeBgHdnia9Gg9inftWcrGLr6ba+9Qo4NxsF8mH
	ypz54wNRuaLLJIhb6NjPOyvlN6w0qUucTm5uqkZ5I24D9AzCarDj9gLeFriGyFdhlFAwFCF2n+I
	pdkihwyX1CVTRE7h7wia6z/hRsgT5/aeHTGXj2pJuoRrLhHnfRVvq8iqjkybiBz89hSFa3nNt4V
	OsRfz1+KQ2KNE=
X-Google-Smtp-Source: AGHT+IHjeVuYYZlBuYzCRgd/i05+TaK7Ti7RdwUSllLIV+6yjd6NQGCJEudAhYXdgoPDVyrh2s/ePw==
X-Received: by 2002:a17:903:2c03:b0:297:ea93:cc58 with SMTP id d9443c01a7336-297ea93ce1bmr58790815ad.60.1762696210761;
        Sun, 09 Nov 2025 05:50:10 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm116341295ad.43.2025.11.09.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 05:50:09 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C2CC342BF679; Sun, 09 Nov 2025 20:50:04 +0700 (WIB)
Date: Sun, 9 Nov 2025 20:50:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, dev.jain@arm.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: Guidance on contributing to MM subsystem
Message-ID: <aRCcDI3cdKLUkqur@archie.me>
References: <cb17f29e-b45a-4275-ab2b-1443d909d944@arm.com>
 <20251109141452.7097-1-swarajgaikwad1925@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o5P0qWO0UkoQwcFB"
Content-Disposition: inline
In-Reply-To: <20251109141452.7097-1-swarajgaikwad1925@gmail.com>


--o5P0qWO0UkoQwcFB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2025 at 02:14:50PM +0000, Swaraj Gaikwad wrote:
> Hi Dev,
> Thank you so much for your reply and for sharing your experience.
> I do have some basic understanding of how parts of the MM subsystem work,
> but I=E2=80=99m still struggling with how to find meaningful issues or ta=
sks to work
> on. For example, I=E2=80=99ve been trying to explore various parts of the=
 code and
> read through documentation to get a better grasp of how things fit togeth=
er.
>=20
> In other open-source projects, like on GitHub, there=E2=80=99s usually an=
 =E2=80=9CIssues=E2=80=9D
> section where contributors can easily find bugs or tasks to work on. In t=
he
> kernel, should I mainly focus on exploring TODOs, adding selftests, or
> improving documentation (especially for new or less-documented parts)? I
> also believe branches like mm-unstable and mm-new might have ongoing issu=
es
> or regressions, but how do developers usually find or detect them? Would
> simply building these branches expose such problems through compiler erro=
rs,
> or should I try building with different configurations (for example, using
> defconfig and other configs) to uncover potential issues?
>=20
> Even though I=E2=80=99m beginning to understand how different parts of th=
e subsystem
> interact, I=E2=80=99m not sure how developers usually identify new bugs o=
r feature
> ideas to work on. Once I understand the code flow better, how can I
> effectively find such issues or areas where help is actually needed?

I can only speak for the documentation subsystem as I'm regular there.

For docs, I'm usually watching linux-next mailing list and looking for new
build warnings report there. If the report says htmldocs AND the warnings a=
re
emitted from Sphinx (look for [docutils] like [1]), I reproduce them locally
(make sure to set up the environment per Documentation/doc-guide/sphinx.rst)
and fix them (in that case, I submit [2]). In absence of aforementioned, I
build htmldocs then wandered through its resulting output to see what
formatting improvements I can make and submit (e.g. [3], [4], and [5]).

Thanks.

[1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.o=
rg.au/
[2]: https://lore.kernel.org/linux-doc/20251107081300.13033-2-bagasdotme@gm=
ail.com/
[3]: https://lore.kernel.org/linux-doc/20251103093817.52764-2-bagasdotme@gm=
ail.com/
[4]: https://lore.kernel.org/linux-doc/20251017064525.28836-2-bagasdotme@gm=
ail.com/
[5]: https://lore.kernel.org/linux-doc/20251013095630.34235-2-bagasdotme@gm=
ail.com/

--=20
An old man doll... just what I always wanted! - Clara

--o5P0qWO0UkoQwcFB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRCcCAAKCRD2uYlJVVFO
o4zEAQDYl4qSeekBOaAB9zxtXScuTFp6kvkLpXjcPuU8fui+UQEA6ZcPvcSCi55k
Sqqw2oAAzD39cMDepBDho0hFAAPXrAw=
=/YTl
-----END PGP SIGNATURE-----

--o5P0qWO0UkoQwcFB--

