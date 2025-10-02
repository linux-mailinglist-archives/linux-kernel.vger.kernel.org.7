Return-Path: <linux-kernel+bounces-839898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AA6BB2AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41503B8D03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EBC2C08C5;
	Thu,  2 Oct 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muGJ1NKL"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FA33F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389808; cv=none; b=NY1sB91FsUeLB0fpxzyZxeSrJ0zS2/oNusIfpSSxGty52p6XY6FoCJ9tk/x/Rre0OgizyY3nhfHjeO8UuhnIk6+dorVSfQgFH5ofugHDjXZZjsGX7JCsKHC2MeNjvu0HfREtFTepyzPPYLJq0UvhiBZ7xbCy+hIo9Mqtz71hz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389808; c=relaxed/simple;
	bh=0jrxUGe+DCeQ4sbhNFaXXLwbyGeD+xuIir+V8mpTt9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2rCEkChYJLGk9TwACF8bV/guAdHAVCFEq70HzhDMyye6CdpmX7RJfvHcOsmmxmYwpg2+pRnhW9P68eTtCfuBpo2/92NgHn6M5Oss4zrGcLFEc2ogVvJDpmuHMho9myRKpv83bmj3YZcUjQZkFFDzIca1NO+ey0pf1OjPqeETQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muGJ1NKL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57a604fecb4so823291e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759389805; x=1759994605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAezsa5jylxA+PINsCrvcHdmkFqkFvmdtbApYsRrjjQ=;
        b=muGJ1NKLj8pBy1ct6df7bM9/YiTD1dXuWQOr7hZc3CFGlO7WFE9iE6yaM/oUALy6JH
         7DU4q9ZRC+ooSWpXeYZ4R9lngytUKQulYRoShagOtL82BRjfZpe+4UKS7jSNLEC6wIaL
         Yqukp2W9oNrpneuglEXgrgR3Sa6QGkzPuBI7nuz0UjFCpzgZmj6dMfNTxH+6xgkREr62
         L6zlECbCbBiSIkANm96myqvY7pAVxlp6lKGmc5zcVw0xSQUTEfEl1CIGvd/SPEGTxEHe
         YFGgyN7C+XahEOij5TchNaZL3ljGovnwrLgXoKAAwZv97mrsBHziUyiy33QlK1XqkMew
         BUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389805; x=1759994605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAezsa5jylxA+PINsCrvcHdmkFqkFvmdtbApYsRrjjQ=;
        b=TgnasQmfvvPe5+NczrA2qVJ6RAmY7gmlXlCfjiHBGIxfh2v7Hs8S+7+Dfjf1TtMtvP
         JA2tNM9ZdatTlb8Ugs8uDr2RtJQXJ3nKNtHJlyEfa1wJxasmf5uFGbbzA60y0hn9AGHW
         UOjC5c+VTS2feJ205dJak2pYp8VR4TFL7iweVBQ8DcR1PulZyrpcRofNCNnE+O2x2yIl
         4Q2PFjwaVnxU/NJ8yg1ByFBsLdf1gDGpAWYiffLwshUgRJgfj6TF8K5SOFc9qkXpedUQ
         6pWQ0DvRplWKuMqzWFHWdGgLGTWhf0G0yBWDQYAPrMVowyJMKqw1g6nbs0I5WyogylKe
         tVZA==
X-Forwarded-Encrypted: i=1; AJvYcCXl6RY8CmpNoi5s2hoqj84rruIJAw7u4+U0iyvp1wcZJ3f237a9cinVYqt+LyMV5brjcA4jPv1Q+UQTomw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULL9TyasAoRqtwQvodpMGZG1SMeWkBX2ln0gAZIZssVB8iDxo
	0E3ZgYmNu8Fw/I6nobo9uWchRE9u8ThSmo47JPqFDwwMC0ZMW6JKwcRs
X-Gm-Gg: ASbGncsfgm2itwb6Bi3UwuDFNR+elIOZOY90mbxvK75PtJvWX/BoVwnTML2wIY9NNkA
	LUhiIP5cnPGS4+rKl5iYRAAKYeFneJgJKfav1FenbfdF38tvhag+eFW+dkTN/0VBQQjRZbAdPkc
	BM0FZNZEFJ5wuDvMNjy8Z6pdhzEilqzkMYvabUv9b929Yu+VOMvsFaMEtSmrTn/j1pbG2komAAI
	qkElvIYNgs5oRsEqeub57MNy46PUT2clSRtImU7dW5ef7PqFRj2OXVYbfbDslb2OZRTHPRt/pzI
	VnnKOgOvzhP3dFwLJ9DRIo77TbQlzrklWvv1U6csyghvr+e1oaMeZb1k2OuZ+ejYLJ6vuLo/KYV
	0r95vzw2uxas6wGOOynlZT0vQ6yJ6VHLiNnC2pEdtp1Q7yZhgwWwNoNs55POSOJS1TOIh3NMQTi
	9Xb8HGol4=
X-Google-Smtp-Source: AGHT+IENdkkQY9tMZra6c8uGLns9ZM3JxNYebG+spH4JruxkkO3su7mpVOJS3gNQI1l1MBpIfN9sHg==
X-Received: by 2002:a05:6512:b24:b0:57a:640a:11b4 with SMTP id 2adb3069b0e04-58af9f6b0a2mr1707820e87.39.1759389804571;
        Thu, 02 Oct 2025 00:23:24 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119ed6csm564506e87.105.2025.10.02.00.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:23:23 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:23:21 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Axel Lin <axel.lin@ingics.com>,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: da9052-spi: change read-mask to write-mask
Message-ID: <aN4oad5e7YUNaR8w@gmail.com>
References: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
 <aN0mqU75onKEYSDg@zeus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LGW5TTSWjvpGa2Jb"
Content-Disposition: inline
In-Reply-To: <aN0mqU75onKEYSDg@zeus>


--LGW5TTSWjvpGa2Jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Wed, Oct 01, 2025 at 04:03:37PM +0300, Ian Ray wrote:
> Hello Marcus,
>=20
> On Wed, Sep 25, 2024 at 12:19:53PM +0200, Marcus Folkesson wrote:
> > Driver has mixed up the R/W bit.
> > The LSB bit is set on write rather than read.
> > Change it to avoid nasty things to happen.
> >=20
> > Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for da9=
052-i2c driver")
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>=20
> Your patch breaks DA9053 SPI communication (for me, at least) on the
> 6.1.y branch (I have not tested on master).
>=20
> The datasheets [1] and [2] both refer to R/Wn in the SPI signalling.
>=20
> What led to the assertion that "The LSB bit is set on write rather
> than read."?
>=20
> In the original code "config.read_flag_mask =3D 1;", is OR'd into the
> buffer in regmap_set_work_buf_flag_mask.  This sets the "R" bit as
> expected.

Hrm.

I follow you and agree with what you say.
Could you please read out R19 INTERFACE register?
Bit 3, R/W POL, deviates from the default value (1) in my setup, which
is probably the reason why it doesn't work for me without the patch.

Your datasheet revision is later than mine, could you plese verify that
the default value is still 1 for DA9052 in your revision?

If that is the case, either the datasheet is wrong or my chips must
somehow been preloaded with some values.

As nobody else has reported any issue I guess it is safer to revert
this patch.

>=20
> [1] DA9052 CFR0011-120-00 Rev 5, Revision 2.5, 13-Feb-2017, page 67.
> [2] DA9053 DA9053-00-IDS2n_131017, page 54.
>=20
> Blue skies,
> Ian


Best regards,
Marcus Folkesson

--LGW5TTSWjvpGa2Jb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmjeKGQACgkQiIBOb1ld
UjJ1QBAAnTK4n6jS33I327Pl2Q0vtynIDc6AkQI4RGSe7jh8qNvlUo/SuM30uCHt
Oq/FEmDjz6MTwBwSG8W4+rRup5IKNZ8BroWVjg5G1xwH+it5lYPr0lgU/NUl4sT3
MCzQ/jP+vdVHDUpIZ5gRmD7bIZe2PNC0strmIioNlGrRby7b5Ae90g1tGuGkHGuH
8xYQcnU6OogE2RumugzPzLinb9/ht21hb4yya656wWnL0KaySaGoVA3BSg6EJlnE
P/Cdfww77oRMSAG5CVrkZxYyUUmhqpTLO0PmLuetAdktKaJwriyyF6exRdh+e3HN
MfYMH6lv9VFNMuCJtN2DVvxMDBOAoqI+JSJxA3ALhLO6Lv6DKBExr7ovTUEwH3RV
HUawmKRMKH/VtK2Nz6YNIEpJRPDtDMJ+i0MyXSWQrRcyYl+3LybnK8k4cb6nlFmv
bsEVddlXufawUnvtXJU18ywz1WNN+RIS9meqRu7rSIO0lB6DW9VLgViNplpmVAEH
JcNqb0xrPCZod1TAjZu0fSEs112IV0bDLboLCmRB8OEWdblhgy7XECgh2il8KPvl
noy1jMrRrWEC4TpcrmTd4SZSa95TTcxgp8ygkwcwO9GPW9a4uMUgh2rlmFIUVUA5
xJm9gvY0eo6NEKTCi7t46sOPYLTi7TxqO9bSk/E42vs4GWnurw4=
=59Aq
-----END PGP SIGNATURE-----

--LGW5TTSWjvpGa2Jb--

