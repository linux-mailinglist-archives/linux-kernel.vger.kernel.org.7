Return-Path: <linux-kernel+bounces-809150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95EB5093E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5254F681874
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5928726B;
	Tue,  9 Sep 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGa9aIS1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A185287262;
	Tue,  9 Sep 2025 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460530; cv=none; b=MbZbMGz9vjzXwMrMW0H2meFpqB411g9Dg++u8NpFKLissaZiYz5sAmjQo7ijYymfQyplw/G4wbIRGf/cv1DqWGn5nglkoNBKiAlGZlreli3FL8DG21dhEg9/WKz0SakhO8egFIxrEiOn5ee085jrshmjPI8eKohzlIRWc5Q0U1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460530; c=relaxed/simple;
	bh=aP32tY/7gzIP/DubLKct8s8WemhrgWLqsffY5Vv1N34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdOsgVv+lw+qijW8RYQKvWw7SAVnKbIS7M1IYCAdZgKQtYnOakXAtGUM2ybD6pfgtaztqlINipu3MtiOnyHpYBHn01okc3qTm/aQg7klsOcmTm8arWdHfx3sICgVxFQU9+9j+3QFBZttiDUBm1igaGpzq3rimodGmLQydJ/wq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGa9aIS1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24eb713b2dfso41623195ad.0;
        Tue, 09 Sep 2025 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757460528; x=1758065328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1py8/Jv9TkRWmTtTOdiRKj2ug1E6J/3gf1mMsVDV/8=;
        b=ZGa9aIS1LNkiZJw+lNNTMaTVdlXS0N3EO9VGogDWBdoZSdFcrF4fvFynyRzNvtIhHm
         YbT/mCroE9aq2b3q/lTU39zW7X8GjNHyNQ/mTIWToWTdeQSLmjolSH7o5YKxmoQB3kCM
         UhK4YKvITvclDcuYofkeacmaiBNDi3Zlum9dTgXutwI5/or0zfMQERt1Mp9cWYvjP+Uq
         dnpquwljcIJwCxZW76VT0+bDcfrvkGVjQb24+bMBxnjobgC2mmGtpySIgnPeqb4923xx
         l2YueaYlpb+8cAxyC8Kc+HT5vYoG+Mv30TXXc9ukxo+2M/7cAbn2UkHkqkeAIs5armTc
         vYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460528; x=1758065328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1py8/Jv9TkRWmTtTOdiRKj2ug1E6J/3gf1mMsVDV/8=;
        b=GdDDqqo03ootEipRqc9f2nFYPeyjk1fyNV7OM1QrDKHIOShSvX0w/ohuEVsov3ToGO
         +x52TkLA3cgBiJdVEkZh6zG+mcIBEAgxAZcWfkSfpUbuQM2OOwk7lErgObEhXp6grB43
         bv9k3/4ijq4wVFx0bEA5H1OrjM0whqEOO8/bu3ILyx43jmierNqu2wAl64z9negz0XDv
         J3WRYUUk2XKLKqMApuWmapNPo6Y86G/dNekxjr3R6gjmsHaYxVl1lRtAonqavLdfpGKv
         XESMrPDjSez9ccqXr+gp8ti5WCeKg1p61bz1x1VVwb8X5u4sQRVX4vVix617TUEZ/zNj
         O2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNbjVe3o+lckYz2wrGLk8Y6Unwn1TlTXv3mEYckKzAxgIO7K9ts9lU65obNPSJ6RNB+XW9Br6yzpES7Vci@vger.kernel.org, AJvYcCXf1B3I5ddyF7IBsyT7AJVjhj+T9ejoB2CgUJ9rbrprhBaOsoZe28MtEeVt+hniBRuyG7LKJIjQApw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIS9+RL5e11qTHfUGrxo2odC/dt/NSVxmpmuu+BRDj3X+y4XZy
	c+A+r8D/ckcbJARdRn3vvf+EZjajHG0JJcdO/2UiKUV1taqkZRadQwx8
X-Gm-Gg: ASbGncsqgXvZC1cw2eNvtVyGa5RRcd0QPc/AqwChDV99sGsOxGubMl3pK35YBz3zM0A
	1/fp7IIR9r72NsXAq1rxKW48i+iQkRjEhUD8bkfpqUOJpDQvzr2LWLChj2UDcLbcDK0SZyaw6le
	gQLZj8lNXluTO3hTV8XvsBLxYkwQ3fSXWbaz6C8vH5F4gfeV1rgcv+PIYxku46U+SPJ/d2AtB6Z
	ty27Q7WR5YWEZ1M4yJYd3wzwt3ROTsdQzgt/d9ksYDYpIgIrFwhsgD0JGKDrcIAu7/A6hRsay8/
	phLbXiTXdBVPLF09GOU5ZCWzE/7lllPc/ZkzRVxyzT2gdTqHpqmI1xwOo5hQbweasLivtiHixHZ
	3mPujIUlykro5ouyYn45Az+hecMUgP5c5t8cX
X-Google-Smtp-Source: AGHT+IHzV63aqLnTtdmYIOYinkzvvWyF2KLPwY/kTRq4fanCxApLrZjpsNTQgCocL2ksNOykityyIw==
X-Received: by 2002:a17:903:2286:b0:24a:f7dc:caa3 with SMTP id d9443c01a7336-251715f33f7mr163441345ad.37.1757460528309;
        Tue, 09 Sep 2025 16:28:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422e30sm8632275ad.23.2025.09.09.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 16:28:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B3704206923; Wed, 10 Sep 2025 06:28:44 +0700 (WIB)
Date: Wed, 10 Sep 2025 06:28:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>, James Morse <james.morse@arm.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
Message-ID: <aMC4LIltHWlpF9iY@archie.me>
References: <20250909014606.15043-1-bagasdotme@gmail.com>
 <874itbv23b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yD03C9Tz4Fzfcskn"
Content-Disposition: inline
In-Reply-To: <874itbv23b.fsf@trenco.lwn.net>


--yD03C9Tz4Fzfcskn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 01:48:56PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > Documentation for GFS2 is scattered in three docs that are in
> > Documentation/filesystems/ directory. As these docs are standing out as
> > a group, move them into separate gfs2/ subdirectory.
> >
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> > Changes since v2 [1]:
> >
> >   * Do not use wildcard on MAINTAINERS file entry and add review tag (R=
andy)
> >
> > [1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdotm=
e@gmail.com/
> >
> >  .../filesystems/{gfs2-glocks.rst =3D> gfs2/glocks.rst} |  0
> >  Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
> >  .../filesystems/{gfs2.rst =3D> gfs2/overview.rst}      |  6 +++---
> >  .../{gfs2-uevents.rst =3D> gfs2/uevents.rst}           |  0
> >  Documentation/filesystems/index.rst                  |  4 +---
> >  MAINTAINERS                                          |  2 +-
> >  6 files changed, 17 insertions(+), 7 deletions(-)
> >  rename Documentation/filesystems/{gfs2-glocks.rst =3D> gfs2/glocks.rst=
} (100%)
> >  create mode 100644 Documentation/filesystems/gfs2/index.rst
> >  rename Documentation/filesystems/{gfs2.rst =3D> gfs2/overview.rst} (96=
%)
> >  rename Documentation/filesystems/{gfs2-uevents.rst =3D> gfs2/uevents.r=
st} (100%)
>=20
> I'm not sure which tree this is meant to go through ...

There's linux-gfs2 tree (see MAINTAINERS)

>=20
> I do have one suggestion: the changes seem good as far as I go, but I
> would have made gfs2.rst into the new index.rst and avoided creating an
> essentially no-content file there.

As gfs2 docs currently only has not many (only three), I'm fine with your
suggestion.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yD03C9Tz4Fzfcskn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMC4JwAKCRD2uYlJVVFO
ozEKAP4lpszupR635IazRjMRtgE7q5h0RViow552zXI2EZ9Q/AD/YsypM+DqP+sS
MEaZ4dA30h6opucVYhImfFlnHvxq+go=
=JqMA
-----END PGP SIGNATURE-----

--yD03C9Tz4Fzfcskn--

