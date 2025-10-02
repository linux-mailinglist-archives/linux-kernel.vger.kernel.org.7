Return-Path: <linux-kernel+bounces-839926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58828BB2BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D147319238FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F942D1936;
	Thu,  2 Oct 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhH7DwF0"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CE2D0275
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391798; cv=none; b=DMMYYHV0shhNw3G7gWGfU4PYO+ct/L+7DL8YQZRjn/e9M5t6O+uuWBziiJ+2/R80dE0y3ZQuodWOcy82GXbRzHAaRIEtfWaryHVEaPi+sFlTPM7ts0KFeFH1qg607cRpJflD893eGV9IOUEyhrAlPe50Pbl1MifrFuD9rlhiPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391798; c=relaxed/simple;
	bh=wHGHoUTxZ8/q5LpqcYE4E/xawGh5qOXuVWGlHHtxmes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6oUzoNwhPSXGrat0q1k2Cz7oyZqP+W0E+lUEXUtY0cqYXcOttTa1QrjUwJoOKFuol8Bdw0SAukfImrmb2TrJ61eoTMiQQ7Aht5KMCStsRsWGq2eVrvafteUwGkvY96OnCIC53zAwuAq9SRDGng4us/Ya4dxIR5CEROBe6ZUKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhH7DwF0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so5813671fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759391795; x=1759996595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaHwMph3ZBwLKTj5c4KEuQWp7W+qEZyA5EHQKhPy2B0=;
        b=BhH7DwF0icBZw/gtspbQ1o9CM0jY2eY5enYUaneRoGc/pFsvyTDPPJTbATSZDkRpn/
         lCpa6kY5P/qhsUPWU4E6V1E4POAoGz6DTp8eQCNT6olfr+36SdZQDhQzQzI2h+R1ioVL
         mneciSsD8//1wp7uqB4KaSmhyYck2aE2BMLcKzhXQHb0xJKrPirDQaaO9qGvaWO/6wE/
         bCoYoG7t/94tlWVedvNXn+p2Ndt0FHeUL5aREtgT2Qw8bkcPoObc2LJTc7N+9IicSOZM
         PD2OHP6np+VJg1kxMnqfiaeYDUtAktgttXQRc2ALOfx3KS9jlDj9Tadt54IPcGPrjOnu
         JI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391795; x=1759996595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaHwMph3ZBwLKTj5c4KEuQWp7W+qEZyA5EHQKhPy2B0=;
        b=c9jfZR5UlqluS1mFAvKLlvfnI7zQkbjt5IGwUpgCCNV7UbyaI6/ksYJ+OWD86twlxK
         +D+OdvF44BH3BDrXnVkBTSIw2z5ylGIw3EIIvOYbPlRR/0VF8MYxqkvd+GL8b6TUb+R2
         rR4FKnQcRwwMsWzYS9bcOgT1nMvdglQCgt9oZCpZAJz9G720a8Ose2uw2hN8LRNWDW9N
         VIMOebRWg/Xt5kp/71sLwgB3LISuXRhQ1VdYZf/uip0wnpC8MorRYJ0xQZSorRDJV2hE
         Vt9qfNEXMpMHgusryYRWYCLB8L12ljDEn/EPrrSi2MRq77TqRCceUrCLATesvFDxjf1w
         ZO1A==
X-Forwarded-Encrypted: i=1; AJvYcCWw9zQ8YgwZQesDgDqEJnx0Ou5ZB3OwgLZbwOJenLbbHLihP8Dt0iiSMAWS7LlFV+utpCCv5/t9JDGCGAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cRXfpKz33uNJGq9l0WqKBkw+AOTfNd3hTL3xYzxaXgGXjcTy
	+5VutzJlzNamDHLTT75CRE3tlb/ejHLlPiWfa5CzUyctf5S9DF/pXvr+
X-Gm-Gg: ASbGnct+ja4ryl9Efey8PdRIItJu5GbOe9YgtkZY4r9//by60DdM9yh9k9PdR0l3853
	WG+5sF+4OjIxf+4cCfpE6LyLUCJ0lbFpiJWT29oaKmGJiP/y6YWbzC01Mm5ztdPzT7TQHBPaoMx
	GSIWImPMtYAPlt8HkaIKlWj337YkMFB18XgHEWrYYt48J42xyEXspRU4c8oZn4auNjQI+M+/2wK
	zrKirAadgg4DwkhB8yM+4lUliZsyTCkrhFNlxr7FBEazbD2/gCWwcj1AvYd0KTdqkBI60bqR6d+
	4RITUA+JIjXEHGfCKJjFjybonbKumOeBwGvaaauMjn4oSuPATiVz+pTEJOpxnNGZeerj0YrBvBA
	LLFO5N/6LVcO1GhaR7wP2Q1tkp7/HJmhk7DjAwh+4yCAJ8bE6JtBeOJOqisdRwQ5ROJAvCAwhrO
	1+KXvVmVk=
X-Google-Smtp-Source: AGHT+IGkev+Mxei7+TnjDbDqGDvSyJKY2uCDnErH9kyeWxPuql06/bapC4LZNwOxoPBQliawN+8jFg==
X-Received: by 2002:a2e:bc04:0:b0:336:b941:4ab1 with SMTP id 38308e7fff4ca-373a71257f4mr16701741fa.17.1759391794665;
        Thu, 02 Oct 2025 00:56:34 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2739ccsm5012481fa.10.2025.10.02.00.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:56:34 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:56:32 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Axel Lin <axel.lin@ingics.com>,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: da9052-spi: change read-mask to write-mask
Message-ID: <aN4wMMY5Jq4zdd6e@gmail.com>
References: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
 <aN0mqU75onKEYSDg@zeus>
 <aN4oad5e7YUNaR8w@gmail.com>
 <aN4ujFg_uRufUXn-@zeus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fALL9UhP4IJsq69l"
Content-Disposition: inline
In-Reply-To: <aN4ujFg_uRufUXn-@zeus>


--fALL9UhP4IJsq69l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Thu, Oct 02, 2025 at 10:49:32AM +0300, Ian Ray wrote:
> On Thu, Oct 02, 2025 at 09:23:21AM +0200, Marcus Folkesson wrote:
> > Hello Ian,
> >=20
> > On Wed, Oct 01, 2025 at 04:03:37PM +0300, Ian Ray wrote:
> > > Hello Marcus,
> > >=20
> > > On Wed, Sep 25, 2024 at 12:19:53PM +0200, Marcus Folkesson wrote:
> > > > Driver has mixed up the R/W bit.
> > > > The LSB bit is set on write rather than read.
> > > > Change it to avoid nasty things to happen.
> > > >=20
> > > > Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for=
 da9052-i2c driver")
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > >=20
> > > Your patch breaks DA9053 SPI communication (for me, at least) on the
> > > 6.1.y branch (I have not tested on master).
> > >=20
> > > The datasheets [1] and [2] both refer to R/Wn in the SPI signalling.
> > >=20
> > > What led to the assertion that "The LSB bit is set on write rather
> > > than read."?
> > >=20
> > > In the original code "config.read_flag_mask =3D 1;", is OR'd into the
> > > buffer in regmap_set_work_buf_flag_mask.  This sets the "R" bit as
> > > expected.
> >=20
> > Hrm.
> >=20
> > I follow you and agree with what you say.
> > Could you please read out R19 INTERFACE register?
> > Bit 3, R/W POL, deviates from the default value (1) in my setup, which
> > is probably the reason why it doesn't work for me without the patch.
>=20
> -- >8 --=20
> # cat /sys/kernel/debug/regmap/spi2.0/registers |grep "^13:"
> 13: 88
> -- >8 --=20
>=20
> >=20
> > Your datasheet revision is later than mine, could you plese verify that
> > the default value is still 1 for DA9052 in your revision?
>=20
> Yes it is still 1 (the complete set of defaults for R19 is 10011000).
>=20
> >=20
> > If that is the case, either the datasheet is wrong or my chips must
> > somehow been preloaded with some values.
>=20
> Yes, in my understanding these PMICs are highly configurable via OTP.
> (Almost every register can be customized.)
>=20
> >=20
> > As nobody else has reported any issue I guess it is safer to revert
> > this patch.
>=20
> Agree -- following the datasheet default is probably the right thing to
> do here.
>=20
> For the future, we could consider an optional device tree property to
> describe this read/write bit polarity.

Yes, I'm actually working on a patch for this, I will send it out
shortly.

>=20
> Thanks,
> Ian
>=20
> >=20
> > >=20
> > > [1] DA9052 CFR0011-120-00 Rev 5, Revision 2.5, 13-Feb-2017, page 67.
> > > [2] DA9053 DA9053-00-IDS2n_131017, page 54.
> > >=20
> > > Blue skies,
> > > Ian
> >=20
> >=20
> > Best regards,
> > Marcus Folkesson

Best regards,
Marcus Folkesson

--fALL9UhP4IJsq69l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmjeMCgACgkQiIBOb1ld
UjIMEA/8DD8DLsYdTX5OUX1f0IHA9/8s0DWhIb2D9iMjw6aqocfv7ZSaF4d092BH
snRPXvH3B10SFBCKa8FTCKbBFJU+N3+kEDKaXMAZJ/SjhHXXxaO3Ctdbid0zOPUP
LKW8c/fZU1hAvsygp9sHzcpbPk4HvGy/K07IPvtMB6MicUS8QPxL2Cv7POc9Ar0S
JODT6lBOF8sh5Vfj8WRSMa4/2ndXwbISKXIOv1q05egQbL6UEKSvaNyhlmGEI1fb
M6EzizrxB86O/vl4um4IYSMIIzmK5ks5MvWk/xAzDy0qj1IXw3b8hSJ7Q1+urvIF
xRKZbgLDBWRFINR8Qq8haNxnl4p6r5CBFXpiSEOK+rbvutK6YItse/s/zbwMDLpf
Zbj9kXzoFQzfvYYqH+f3+Z99mBzszKuUaCcPPUgsAE6RTQ+9M+0flxjtyr/D13Kg
k5Kw6XQwctjbOdHzEIn23qkykjL5zSdcdqN+9jK+QJFmYorXpQZiDXNw/9WNMM+t
Yamw6YtYC4maWjMxT1LTWC6u1k7WzpEzxvLNi7uBWAS+9YE6nzYqOcroEkm/Pk0c
Uvgu6amMQl7CY3mrgP4RagapNUbNPXo4+JyWODWlUVxTdVd07wN6DKCcCxipa7Bn
6tFbjVIcaFZLz+/DN4ZlzX3oTjeu//9QjMwJzwp71NEynacqrWk=
=TTNz
-----END PGP SIGNATURE-----

--fALL9UhP4IJsq69l--

