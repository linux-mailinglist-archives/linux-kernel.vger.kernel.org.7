Return-Path: <linux-kernel+bounces-830470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B2B99BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007D51B24925
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9E2D5940;
	Wed, 24 Sep 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIl/oEgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC41F428C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715386; cv=none; b=DU282HAZOW4PsRgSJwYpTeNubUJ2Ka00vEHwfX0Y4FndWeoCWkwQVCf5vACdYF5WZhcJoFCxdrKIKiuO612e98yXGV5AD8Ys+pF5VV4GtC1TuGqpVf2pvSttkGp+C0EtnsliW+4NI8QKnR8l5IllMt5dKOC/f1ZpoH1ck8OkeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715386; c=relaxed/simple;
	bh=+B+OUhZLRp5+DRENRW7wYa36d4OKd15N5WpwYCavEfY=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Qk5+wrzZX3wkTOJT8yPVvEln4CKmKjzsUs4Pq4WPUPfhPeLOCqodbe8xlEf/5Zi367gl4HKWQirXUJEGLFRjuRxXAik7AGXDZ2IcWI1NVxNJ7XO/XI8umL7H2ELpU5FxrylhmOzl8EoXkEPohraIvIsObLEmeebA0P9yq2phn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIl/oEgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F62C4CEE7;
	Wed, 24 Sep 2025 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758715385;
	bh=+B+OUhZLRp5+DRENRW7wYa36d4OKd15N5WpwYCavEfY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=GIl/oEgjiQWlSVEcLI/9NArayrrZAoMUU3Z+tIkjUX/s4WYgLvYf0D4iE4xhIdp2b
	 kA5I0Xw+i8UyJPgVwnsakxFoDYtC68D0VxqenNPz4YwZL1RWHjpH4zCR/QkaFiCJdQ
	 SWY7jKRQMHeIDDjxyMkhuuN39oa9sWFC+UYBLXK2PfSVBLJcEqQaOr6Tke6Tq/ySFf
	 5+ELWbvm06BPolc29fw1B+qC2Gm9Muha8egxrA5YYn0nhX3GUXRJb8viL+MYJ5PS7G
	 kFR4aNOj6mIWKK/4cIE1xicxOS9VffzOlZ9tmp+7c3Q95uQ5Q+AcySpJq34AHB6z4A
	 niknm7OEMYSzA==
Content-Type: multipart/signed;
 boundary=ffb5be01501268f325e693a8443cb813f8a298cbd0b29ab9e4f70b750bdd;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 24 Sep 2025 13:57:34 +0200
Message-Id: <DD10GE4EOCD7.CPTN7198QFUV@kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: macronix: use RDCR opcode 0x15
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Boris Brezillon" <bbrezillon@kernel.org>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <chengminglin@mxic.com.tw>
From: "Michael Walle" <mwalle@kernel.org>
To: "Maarten Zanders" <maarten@zanders.be>
X-Mailer: aerc 0.16.0
References: <20250922155635.749975-1-maarten@zanders.be>
 <20250922155635.749975-3-maarten@zanders.be>
 <DD08QRGQSU2G.1GB9CNQJV82CW@kernel.org>
 <CAPB_pELazUPccKa72_m7vb80Z7wLRO+PpgfeY-afDHSgg4eVNg@mail.gmail.com>
In-Reply-To: <CAPB_pELazUPccKa72_m7vb80Z7wLRO+PpgfeY-afDHSgg4eVNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--ffb5be01501268f325e693a8443cb813f8a298cbd0b29ab9e4f70b750bdd
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Maarten, Hi Cheng,

On Wed Sep 24, 2025 at 11:00 AM CEST, Maarten Zanders wrote:
> > Why isn't that also true for this device? It supports SFDP. Does it
> > have a wrong value there?
>
> You're right. I started working on this issue in an older kernel and
> didn't check the full error path again on the most recent version. I
> noted that the CR opcode was still wrong and went ahead forward
> porting my patches without checking the erroneous behavior in the
> latest kernel. My bad!
>
> My particular part (MX25L12833F) has been working (by doing 8 bit SR
> writes) since 947c86e481a0 ("mtd: spi-nor: macronix: Drop the
> redundant flash info fields", 2025-04-07). This ensures that SFDP data
> is read and behavior after that is OK. Before that commit, the SFDP
> data wouldn't be read because the .size was filled in (and before that
> because of .no_sfdp_flags). That in turn triggered the 16 bit writes.

A missing size only *mandates* a configuration by SFDP. But that's
not true the other way around. If there is a size, SFDP might still
be evaluated and will overwrite any static configuration. But for
your flash, that's not the case, because of legacy behavior this is
only done for flashes which are multi i/o, see
spi_nor_init_params_deprecated(). Sigh. What a mess.

But in any case, commit 947c86e481a0 ("mtd: spi-nor: macronix: Drop the
redundant flash info fields") is clearly wrong as it will drop
support for older flashes which doesn't feature SFDP. Cheng can you
look into that please?

> > But I'm also not convinced that we should fix it that way. I just
> > had a look at a random macronix flash MX25L12805D and it doesn't
> > have that opcode. Thus, just adding that to all the macronix flashes
> > doesn't make much sense. But it also doesn't seem to have a WRSR
> > command that takes 16bits.. and the core unconditonally set
> > SNOR_F_HAS_16BIT_SR. Hum.
>
> Yes. That part (MX25L12805D) has the same ID code whilst it is not
> supporting SFDP, RDCR or 16 bit SR writes (according to the
> datasheet).
> With the current flash info & logic in core.c, it will no longer work
> at all as spi_nor_parse_sfdp() fails.

Yes! I fully agree.

> Consider a different example: 8M devices MX25L6433F, MX25L6436F and
> MX25L6473F. The ID for these is 0xC22017. Flash info for this contains
> a .size field (probably because of the legacy MX25L6405D) so SFDP will
> not be parsed and we're falling back on the defaults - so it will do
> 16 bit SR writes. CR will get corrupted due to wrong CR read opcode.

Yes, but again not because of the populated .size but because it
doesn't have any multi i/o flags set.

> So I believe this first problem boils down to the same ID representing
> both flashes with and without SFDP. If we want to keep supporting the
> old non-SFDP devices, the .size should be filled in for those ID's. Or
> we drop support for them altogether and make SFDP a hard requirement
> (solving the other issues in one go). But it should be consistent
> across the different sizes.

Honestly, Macronix is know for duplicating flash id with flashes
incompatible with each other. I have mixed feelings about reverting
the commit mentioned above. On one hand, it takes the very easy way
to just brush off support for older flashes without even mentioning
it. On the other hand, it seems that only Guenter Roeck noticed.

> > So maybe just clear the SNOR_F_HAS_16BIT_SR or add SNOR_F_NO_READ_CR
> > for the macronix flashes by default as a fix. Not sure what's better
> > here.
>
> SNOR_F_NO_READ_CR doesn't help: this will write all 0's to the CR in a
> 16 bit SR write, which is not the default state of some parts
> mentioned earlier.

Mh? You've said:

  Other Macronix parts avoid this issue because their SFDP data
  specifies that CR is not read (BFPT_DWORD15_QER_SR2_BIT1_NO_RD),
  and the driver assumes CR defaults to all zeroes which matches the
  hardware register.

Also isn't that the same behavior as with the SFDP? But I agree,
that if the clearing the SNOR_F_HAS_16BIT_SR is probably better.

> Clearing SNOR_F_HAS_16BIT_SR could indeed be a solution for letting
> these parts work properly in this non-sfdp mode. But we probably
> shouldn't do it for *all* Macronix flashes?

Well as I said it's a mess right now. Moving forward we should
probably have a static configuration and try to parse via SFDP even
on non-SFDP flashes. Pratyush, any opinions?

>
> > Then on top of that you might add the RDCR opcode, although
> > I'm not sure for what it is used then.
>
> There wouldn't be a real use until someone starts actually
> implementing the features in the Macronix CR (like top/bottom SWP). Or
> untill someone else is changing SNOR_F_HAS_16BIT_SR logic due to
> additional SFDP/BFPT parsing. Which I still consider a risk due to the
> weak link.
>
> > > Fixes: 10526d85e4c6 ("mtd: spi-nor: Move Macronix bits out of core.c"=
)
> >
> > I doubt that this is the correct Fixes tag as this only moves code
> > around.
>
> Essentially, I meant 'since the beginning of macronix introduction'.
> In such a case, should we dig further through file renames & stale
> LTS's?

Probably, the patches won't be backported automatically anyway
because of the conflicts. But it might be a good argument to have a
(manual) backported fix.

-michael

--ffb5be01501268f325e693a8443cb813f8a298cbd0b29ab9e4f70b750bdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaNPcrhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jxPgGAyj2fme+/9AWLihM5hMd39RF55aKY78Xs
JiQeGZNLHUqO6L7ok3y4ItkGMcXvPe3GAYDTFH6pCXSrAFcmDtjIdP0NAfYKfQUB
g3kxNYwgwIm9jK0jDYBNOt0Ip6SxHfkOwRg=
=Bv9D
-----END PGP SIGNATURE-----

--ffb5be01501268f325e693a8443cb813f8a298cbd0b29ab9e4f70b750bdd--

