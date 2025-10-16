Return-Path: <linux-kernel+bounces-856053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74544BE2F22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B54E548BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD6343D62;
	Thu, 16 Oct 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL9GascR"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E7343216
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611632; cv=none; b=JJL9IPxo/Ui8qQFQS3stBD9ynJLIKK5ngvE2RhauPxKW8aFZIKQ3DIgpM20/GEEa6FWJMIAKiPCEPrZOpxHaX6hmJFtuAlU1hbycy6iJmG38c9n0ePGAqNjTX4mnr/4KOetYZQsFJ+OeYSSFEHVdHr9DFmo6pYOXLcABwT4jHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611632; c=relaxed/simple;
	bh=U4Vw9TFefxHy667IjfemK0KK0KGVnSeJFdgB3++3kP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbWLEWXpDe6kyRzSneNWcjzEy2vGXdbIZQkb6kG4VUGjFmvAwXRP5joI3lQVgkFy9vYs4onHIuy4mirgGYbqntVc1Xtq50/NZV7YgNJl04qY42GdlhD32ID4igsrWL/b6ivHJDt5RBGD0vQwXQnIaRB99JuoIeZfDzJSh+LAjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL9GascR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b62e7221351so475471a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760611630; x=1761216430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4Vw9TFefxHy667IjfemK0KK0KGVnSeJFdgB3++3kP8=;
        b=gL9GascRemtrbu/pBAvJ9Hy8Tm0TW1APBuRhTUv3keyrzLCsdkavLp8x5FTg4rgYpZ
         ohaDmNHJNLmWs7gI3HQBJ8UinogKM/qCxMt6kQ6bmEslqhdje+2W94qWZ26AUBvPV7sA
         qsO7M7o1sQz8k3NcQLXivIYC+3wyrIZoU/2B4UnBQge214J6QioT+lmgNjvnhdd9o3rB
         nKbv9TrnfkJxUJtm/oO/aH70YIq0mIfAYSmegnVMFTwyQ+9d18DAotLvIfp0vEOEkxn/
         fITZdLa+taQs8vLutThX2arM6FPOQ+zF3f3RtQR3Tsio7kY6dhWct6YcrqA0BKlE+XSw
         +/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611630; x=1761216430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Vw9TFefxHy667IjfemK0KK0KGVnSeJFdgB3++3kP8=;
        b=Qx9zP2wZc+PLBTmLZNbpTVv3aoAQSt5J7REUmSXS1YP+CPsWaIueUMwqPZYhAYSHZp
         yafc+us0eFupXlhH4QHRSV+NGaDa22irLF6N/60LQX2yIB+OpMasCmJmw3NTb7WQ336b
         ldRNBMQ2H0fC0jeHln8drGivdAskayr9z/qQ/dzRuM+Qv9l5c6Bdt24FiwCMA1sbkYhY
         +dy+rsB8d4i0/nkpbOG4ET27P3ZoykUoIvJ+YLz8cPtIkoSBxV0ceWGkBaOXcJG+NTJy
         sr6u8CFBLggPZ6fnCuEbIFqYM+ikR6MzXQwHp0rqC+9OvMLIFZJFjK7/airKHuJgJ1Ql
         r9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv1kF4Qecz04CcoWdZnYIxNvKQmHDXuZY3jTC9XOcfWMvbgrMKXwiYxUz+WnhocALubp1AMLxdbnIBVBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQtS+85qzjwzu0gOB9G5/bF4SsZB2lh4U3rAhiB0RiNTcJWsF
	DknRs8AbYOJFdFZ0JyMkK1IVa485X3GpUqNB4xG6EpEjefRecKVZ3Fqf
X-Gm-Gg: ASbGncv9F9MZTVy62E6B8r6rTAH8v+6kznRRWXbIdYa405bh4AZy2aDXMdLrJqjrxAe
	PqWw8NKfu6neG9sqE2aU1QYVsdzoYGiPZz4I09KMzOuZbwZVCNsOE35bLBNOr0YdWokhzvqGRdR
	6X62uMVo03XII2V/8ZTlKeMJeRO+cneKUdCgtaVgOqpzmwatbY+0nwmosS1WGppp5nW9+c+VoWs
	YuWoc/Or1U/kuN02zPWCamGpX8Nf8RDKk5LyX4sKxqYt3jgMb5zgGt67BU/HuQG80pF8lx6ueEr
	/peZ+zGywE8lJZ4uiiWPVcj6+sNomTqPSjw5u4BJFaqTcXtEhNe59seP2mVERA4ilgTwt4jOopP
	WVK5gc0VdSA52+rWjmUP7RjlIlLxz1cFTHvC+VZz+ixZT5w7AaEcgKplKzzdY0MD8irPTF3R0BN
	xgWBg=
X-Google-Smtp-Source: AGHT+IHTuRp5je6WAU5xPxz34jRwwCQlRmcYtd63dQHcWlBJO1BdF4M1kQCtuddlLGvoLVhgrUMy2g==
X-Received: by 2002:a17:903:ac3:b0:272:dee1:c133 with SMTP id d9443c01a7336-2902723facfmr344914025ad.22.1760611629900;
        Thu, 16 Oct 2025 03:47:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934fde5sm26007355ad.41.2025.10.16.03.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:47:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9286F40995B9; Thu, 16 Oct 2025 17:47:04 +0700 (WIB)
Date: Thu, 16 Oct 2025 17:47:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tomas Mudrunka <tomas.mudrunka@gmail.com>, corbet@lwn.net
Cc: cengiz@kernel.wtf, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, mail@anselmschueler.com
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
Message-ID: <aPDNJ3f1H_65infk@archie.me>
References: <87wm4xbkim.fsf@trenco.lwn.net>
 <20251016101758.1441349-1-tomas.mudrunka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYTqeHXCD8CdoU8f"
Content-Disposition: inline
In-Reply-To: <20251016101758.1441349-1-tomas.mudrunka@gmail.com>


--fYTqeHXCD8CdoU8f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:17:58PM +0200, Tomas Mudrunka wrote:
> Hi. I am author of that sentence and this is NACK from me.

Oops, I didn't see your review when I send v2 [1].

[1]: https://lore.kernel.org/linux-doc/20251016103609.33897-2-bagasdotme@gm=
ail.com/

>=20
> > I'm not sure this is right - there is a warning here that additional
> > characters may acquire a meaning in the future, so one should not
> > develop the habit of writing them now.
>=20
> As you've said... I don't see anything confusing about that.
> The warning was added for a reason, because there was discussion
> about some people writing extra characters in there, which might
> cause issues down the line if we refactor the code in future.

Any pointers to these discussions? Or do you have any idea on better
description on /proc/sysrq-trigger itself?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--fYTqeHXCD8CdoU8f
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPDNJwAKCRD2uYlJVVFO
o9KxAPkBTuPUaUuBs6BBHv8+0HhycpaDuHMgX2T2NaHa+3O3OQEAzy5RJ2R7rtkg
k3VhSpHck6n708zue7aH+EZxpD2w0gw=
=Kjn2
-----END PGP SIGNATURE-----

--fYTqeHXCD8CdoU8f--

