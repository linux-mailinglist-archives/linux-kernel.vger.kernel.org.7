Return-Path: <linux-kernel+bounces-854205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBAFBDDD19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E623B4F632A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7F31A078;
	Wed, 15 Oct 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq3Eic35"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE331A80D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521167; cv=none; b=OcUIgpN6/P1sfRrINhY5122D1Km287glVOxKxDMxfj3dIhud2HgZnU3nivvCULXWoLWMUjL2iFqVwWcvLcOhjMqMG4qBM+tTHU7FA60UB2xYeJrbPGj4D+dMMI9WxyPvO2M6OVcmqb78CxfgMVPV0zn3hdXxjEiXjuLoykKYPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521167; c=relaxed/simple;
	bh=u1eJKOWwZghNRxJv0zHXChCsSqbn7vM9VucZ50DOiNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AogwfCXmGIZxMrJ1bj4OOzI/+b51ZnN1iahqTwwi7t742Oxrc1L1MB2NPcKBryroolL/beeFpIpO8uardTWMxrZK1ZQqXuszTHa2wfs49rEmIu3zg9KF704es6sfYMv/9dmkuSPDFwQjzGKiW4mV3Ik/zduvUaXgXm0BV003qzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq3Eic35; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7930132f59aso8466066b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760521163; x=1761125963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1eJKOWwZghNRxJv0zHXChCsSqbn7vM9VucZ50DOiNI=;
        b=Vq3Eic35swbvt2ENzbXRVyv1LJm3HT1Q6CIPfG6OhGknsJqgFtyB/Nm0AJjW9+2ol7
         1yg9WGpzjeNIyl0VnFs/Qs9eg+GOB5UCWGQeXshJgu5GHrPg/79lO2hdqRC+QOczPtc4
         SMxxBq2KroDP+DEBeaLJDMwcbv1WaGz0HvptQrQz6jF7WyHO1xOf6hpa6EVzIwo8VPca
         8CfJpfM0QtgLAh1cKAaH6HefVDzW/SqZw68Vcc8bBtmD64BIOMmwDMRv9MPZHIhOomhQ
         s1mkc3v0qUiVLcN4H4PuxkCpN9xDw1VsyattjVd1FjG40LR68Ln6nFua6dXuyx2gz4rL
         nVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521163; x=1761125963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1eJKOWwZghNRxJv0zHXChCsSqbn7vM9VucZ50DOiNI=;
        b=GJuXVxt9btpWgWRLFmCJCGl24DG0FkRJQvmnKBiZHAlCcjVXHcLvso6rHwUODRQkvb
         F+I6WqXWUfAoh3Aa6Xiu7RpLOy1ItiKDxY1x8Hn+9NMmSGK4ZbNo7TnBL/8vWkICt88o
         nUBRa10QcweyJPw0LU3TDmtuMLBxNy0ptEs0kEG9C64XC3sgyIknKhr3rigCvaqhXgS7
         VDvEa3fD7ielaNx0+i7MOFaI9MYrspxf+s4OF5jMLc3iBSbj/3QbCComI8E2GeI1T7KC
         /m9KDxBQw/Dzb0ZGm3q8yN/9cnwN8rdD54Nc9zhdPD8UiLG46SIaieD7oqiqozcwLvQx
         oA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsbJ7IIYt/OJmXoqRV0NfMxvBvK/H6FXRFBS5XExLgP57O/mLAp9L/cBXkouG96rcT/ap9VfIIMcUrKpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCvFa93rh8axFG8tBRIH6dCGfq2i6KUt9jHg3SEUsksrbvCBM
	feABKwUi7MEme5saF1rJXW9y8tbbPFcveDvwRsn5bj6/6CVA6Aw+YHgO
X-Gm-Gg: ASbGncuAQh5B/lYxTlNRCYmZhmegVxxUDaOCgPbg2HKRWEJswWBWbCL7v/G9A+QRGbo
	3M0nAe6AvF3TV5CqhwSgIiazgAQJMOJ4ds7NMGgcZR8f/AAYMroan3azl7WQiWid5P4b1djvv1V
	HMbhf/lK4eDQmnyFzgQnnHbMONadmYA0txkUweC461ha+f9kTQk9xifobykqdnp/PGrqSXMG5+e
	k/bMTvOlI8Ii1DC120OSs4qI8zvJIq0f5Fu1HV6OQVOfhSp0nKuwfPqW+JTyzluvrm1Qtfe8I4n
	gw3LWR/E70mvoTmIIqCINeLq0d5C88GmOQO4HVcxJ0EaqQ/i4qievGQcenS86YD6Xj834imWYE5
	aH4WqvWruzJh28+i3hPPeWU2c2O80Urd+mT2OEWdCfj/zMqFdT5RX/1M=
X-Google-Smtp-Source: AGHT+IElgVwNPxXRA/tImitB//ntptdYiVe7d9RWZ80dKHs5si0bLCs+yLDawiIS/352iKLuIDMl8A==
X-Received: by 2002:a05:6a00:4fd4:b0:78a:f784:e8cf with SMTP id d2e1a72fcca58-79387829619mr30080478b3a.27.1760521163332;
        Wed, 15 Oct 2025 02:39:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060962sm18269938b3a.1.2025.10.15.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:39:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6907D452891F; Wed, 15 Oct 2025 16:39:20 +0700 (WIB)
Date: Wed, 15 Oct 2025 16:39:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
Message-ID: <aO9ryPohDdkoFykR@archie.me>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
 <87wm4xbkim.fsf@trenco.lwn.net>
 <d6cd375c-dad6-4047-9574-bac7dfc24315@infradead.org>
 <aO7mnXCajeIdUYON@archie.me>
 <0cc09ea7-d4f7-4e1c-9cd0-bf310faba217@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fSCHwCyZlDgbl+8D"
Content-Disposition: inline
In-Reply-To: <0cc09ea7-d4f7-4e1c-9cd0-bf310faba217@kernel.org>


--fSCHwCyZlDgbl+8D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 08:18:44AM +0200, Jiri Slaby wrote:
> On 15. 10. 25, 2:11, Bagas Sanjaya wrote:
> > I guess the whole "On all" description can be rewritten like:
> >=20
> > Write a single character to /proc/sysrq-trigger, e.g.::
> >=20
> > <snipped>...
> >=20
> > If a string (multiple characters) is written instead, only the first ch=
aracter
> > is processed unless the string is prepended by an underscore, like::
> >=20
> > <snipped>...
>=20
> Some kind of, yes. So Either:
> * you write no underscore and a character -- the rest is ignored and you
> should not write more than one.
> * you prepend underscore and write more of them -- all are processed.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--fSCHwCyZlDgbl+8D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaO9ryAAKCRD2uYlJVVFO
o9OUAP9UtfDuga5xwT18A5agR7OavUEpIPgMB3t54ZaS3LQLdAD9FOa3EizTUaQP
UG9Pgb7JUNguv5lAowSSyRLyW2sECQk=
=+4Vu
-----END PGP SIGNATURE-----

--fSCHwCyZlDgbl+8D--

