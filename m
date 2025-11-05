Return-Path: <linux-kernel+bounces-887486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC972C38595
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4019D3B410E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE572F5A02;
	Wed,  5 Nov 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfkuoZwz"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABE2F5A1F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385033; cv=none; b=OnbS5JIK3f8xWu/GDyoC443ILww+vD61FBtaRZKdzTB9yyMdiAj350476ZHHhvlmeF2J1af1eZolHdCXGCjiAS9QGNIfGY++PXKbrRZ7Vs/91qGp48XD2sipK2EQLYosiADNRU9cC5CUN9M5cCqTTDgaqs4eJG70iUROrUwUpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385033; c=relaxed/simple;
	bh=Al3oGioELwHK6+eex1SyHV0FyTUyYiQOvc+s/ABh5bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrXGOsKDKjaRaPbDbb5EoMulguwyMCQNMn8EatN9JkJAamlQaB92pQgaRhgfCoABqI81heftpSGe+RcLHSJrVJZLknMMqNE1niefHxH9s7s6JSmzRg8vyidSYv+pzqL05w2jzjmUb29ZHruTXUGQqCXgYuJAbRPsAnYxS+V0Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfkuoZwz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso1543161a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385030; x=1762989830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kubJeXUo3UmeVih2lAdYf2/Z0P2HnIw8/BtS+HNWHsg=;
        b=MfkuoZwzD0cXS5npPq828F5dLtwJ0Y+VmVm0uUVNnLUJddFsj8SxXIa4/T0/sgTqWG
         M3PyQvcI7Zq62Pt9JbN23MPp/+JTzxCH3SVmxv1kRmyJDJiQAiW6sA1FwmIhSMsI1w0g
         JzVbsbJCtPz7yZ7LVBdXUPq2RvYR4+cscPJyvR6kIn/PsKkE8HmJf8+HQJKx12tS65Qn
         aq71G5LzUm3+Fc3UkpNEWW0a+rn2dsujoVCaXdxU/uqu8tCpPecPKmOKxCxtbjh4pIRt
         OQXT/Dzvf9Hrfgs0utsHKMUfS6pTG9Y2yRAWcO7b4ip8yvseZDjTmHF3nuEwVJBTLVsq
         rfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385030; x=1762989830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kubJeXUo3UmeVih2lAdYf2/Z0P2HnIw8/BtS+HNWHsg=;
        b=ODGIjkor7D4SMjteOBmOBn5t7ZVLTfeh8XUXLsIZ0pvp8G3ieaE3bw+F+DL0AeOQI7
         YIypdqtzeRFCeRXuIjWTxBA1HA86ykf7VhAGvW0GVail6qlxWGXusF/HR786Pu0Br2gW
         iiLp+dcKYHxGBoCD4q1agsDa9oIRR/H7LrMqM2WIorHUVEGW6GmXj864xn/v/sM5IyUS
         ysrrwe7LJn/AzFM8jfmwcZIDfNPY5gBXorJ26zUpILj6DC1sDK4lBlPP45Qjez5l4x7y
         fllqhfs6pX5t0UGh9g7SJKE+bP7oKz9m5wraI5fW/iqmg54oHGT5proPT20dmTjgNvJo
         IIGA==
X-Forwarded-Encrypted: i=1; AJvYcCXz6NxXOEN3otr2FeCZ1XJe4WQp5OiCoKL87VE3moC1NJGXb8Q4kzdnedCshVvH6dos61mZLayk+SdT4O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxreruwlpbpWlg0a/rG/F8FK48JCVVRRvj5r5qVjSSE0/ybEmcD
	CuzKK8eBV268s5VXsFvonA5HQupspow2FX+nlCG0AeD/9ibTekUpRFAyi8vyG0cuzYI=
X-Gm-Gg: ASbGncsp0V8+YnLgzM02HyU3/sfLtW/GssBjY1kn/hzq8dZ66ZlBLgk/GWGJ13qK07c
	tdz6YGXR8VSuV9Z44PlJgxJzXTXlDUYc4pVvmX5QwcUcD/9Sthg7IgvRjOwmwufgWzSgISqqxiv
	9l6qpEloDJz4hJ9qHZsHatQ2dMAy/pfw3iI6CPc/Vd2dfFpOwIZmtD4PfWiMMK509a24W5Z+E/O
	qRvhKYLU25UCMHqY2b1eXojDZzU6PWPwmyGQrVAwm0WwrQsjsaeIaNLicRiZyE1DmlQksONEWKo
	FyYnORseF7wfbtYSGh3N7ldUDHOXBpwd3jd4ZRC8WoFI7Dg9YMEObmDIR079gT/ZFhGKxD3D8xn
	talxYff+nB6YSuXykTUyIlm4bIuXG2OmHiK0Sgy+apunuL80JzYtNqqQuUF6c1euvsnM26FwiKU
	eM1egkaZvtQem2PuHQkXO1Zg==
X-Google-Smtp-Source: AGHT+IEcGzkdAa/JmxgIi83wsydvd0gXDWv6Dhw6hmBafbUdgTVKt1GnX2x8UlV59wQ8wCiPzufLug==
X-Received: by 2002:a17:90b:180f:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-341cd0d3850mr1372807a91.6.1762385029921;
        Wed, 05 Nov 2025 15:23:49 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d048e1d9sm361918a91.6.2025.11.05.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:23:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 871BA420A685; Thu, 06 Nov 2025 06:23:46 +0700 (WIB)
Date: Thu, 6 Nov 2025 06:23:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
Message-ID: <aQvcgoOU0AHxKf9W@archie.me>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
 <50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com>
 <aQqvEsdoj0El2Dq4@archie.me>
 <a8a5b95e06e2d5d1c04aab8933f25cd07903a3e8.camel@HansenPartnership.com>
 <aQtLerZYehQRWdqe@archie.me>
 <bbba0752a40859a114bac987d279a8b268e5e5eb.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JHfvFp1iNfVh4sFH"
Content-Disposition: inline
In-Reply-To: <bbba0752a40859a114bac987d279a8b268e5e5eb.camel@HansenPartnership.com>


--JHfvFp1iNfVh4sFH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 11:33:39AM -0500, James Bottomley wrote:
> On Wed, 2025-11-05 at 20:04 +0700, Bagas Sanjaya wrote:
> > > Why might it need moving?
> >=20
> > Just to tidy up toctree then...
>=20
> I'd really rather have the files in the doc tree grouped for ease (and
> reminder of) maintenance.  The two headings belong together in one file
> because if someone updates the doc for one, there's at least a chance
> they'll notice the other might need an update as well; whereas if we do
> separate files for every heading the tree becomes very fragmented and
> the chance of something being missed increases.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--JHfvFp1iNfVh4sFH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQvcfQAKCRD2uYlJVVFO
o2ziAP9k9lD+4G6TWabjWQjhgcM0by7e5E3t2WQFaS34n6XU1QD/b+hf+htPHhCU
NSmPw4fnv0FZwoxw6cdfsOIYZV5dQA8=
=OkY8
-----END PGP SIGNATURE-----

--JHfvFp1iNfVh4sFH--

