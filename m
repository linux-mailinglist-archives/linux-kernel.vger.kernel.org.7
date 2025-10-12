Return-Path: <linux-kernel+bounces-849474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F6BD0333
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEEB84E79CF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349C27F4D4;
	Sun, 12 Oct 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a4WFHAvK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AC27F74C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278552; cv=none; b=OhcQWoyAweyntvZgH81usye+qdSHXFlnv29h0IXd1GmOmEvbHa0wlrI2DJCYgwtd62/uh/29EKKbkW+h7HQuh8ulcKwFNfnmj3+VDl9Mu1/EWyVuv6iiHpmMO/FCUxIZIBOdyOwVrfkC0PYSqjf89ttEfW/oRkJYUXr+lXL+Z8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278552; c=relaxed/simple;
	bh=pQYo3AL0hKKQM74twJtSkHbfx6sfxE/SN/JlvBlE2gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPqxIQ4T+oOugXfzIjTFIHXSlfTxcf7g/EwqHIj4H/ZIePT7YDsVTaWwYwGRYwSOXpKF2oUOt8CsD8K4DW/oulm5vJAyRd3P6sr178mvMjv2t+vItp49VwwmI8+/0gUOuY1o6dKpDwUrwGTkgszbnuTTXCm58vFmmvRbmf0Ax24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a4WFHAvK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso573764766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760278547; x=1760883347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XMzMC6esunaiQcFjYreM2qMVnAAkLc/iCHafaRbgJo=;
        b=a4WFHAvKBM/vx4qIGm03nVdgZ6+kSgoVDywWL9wLYkTVLBcIbtasVQta1yRDXbZDld
         giw91L0vkW30QGKMwW3Y2Qr1MdQAQF0Tn2fArjjhEK+YLkAgHpWAynYSmp1/+15lGGve
         2/4OdG/gs1/CsEYo4nbLgjz/QOR9IB7sBX5ZpbWD6fEZswQA0cTSBlWBGn+Lavm2vQhq
         LOobt5vkoY/WKVvKxJqZy5pmMjrB1zFBr+JG37tPcNSUwmYb4qUmZoLXJwI4abinCOR9
         WkBLs0L2Q6YbBrmQnc/1LU6YCnlxLcqbcfalSM3O+gY3PHMSWfO+IMnVDL+CyH/GTttc
         0QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278547; x=1760883347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XMzMC6esunaiQcFjYreM2qMVnAAkLc/iCHafaRbgJo=;
        b=ViQLliR0d5Ae8rfkHKC4MYOa9jFOYXmC656rqbCGmibqzm6T9R87xll4Ws7oliLtqj
         h5iejLeJSwu1RKh6DFzGU6MiKamhvbQhbyusjVTfxi6CEE/5+/DN0VyCijsXs7wDstAZ
         DcPgH8/flCoxH+pwA/YQLCskFRKBgYDX8IZNXSMrZmpHKm2IsRLzQxl/yAJLnk7OUAO1
         EmqkkOPTF+SSRbXCwTiFdTuVeBTrYCC/MixgLrqSEzuOZcD9mmIr7kRM+SjJblGdh30E
         efaaTnBeGqUBqQAeCeNOqmcbRUCfkZq3pTNpJ1hLugKE/6qbPcEerQQycqKuMgoojYHL
         +qlA==
X-Forwarded-Encrypted: i=1; AJvYcCXj2EIHSA7/WH4L+Jktm18318lz31aaYJghABGYutTTQ9/S1A3BYzq+yAAmuti6g3sZ6PMz5wg4JPLaIG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMVsSX//ksKwTDoPMxI9M4HiS/UuCW848TW5texhg5SCMmAwC
	VlVC86aWO/3PJRfnobaX2DUt1rKpk9WFLvB5uULVi8709m9GJgOtjqfdbZ8cszxxY8U=
X-Gm-Gg: ASbGnctc9vFuzxj14GnKWxPEeeWHcXfynwWywRz84e5dE0Ke34TFF3M1ATwZYTZUzYO
	D70OFX71pEX6Bt24+1ynup+7qN98HyPSqngmVJQsC7lJkuAoqkIvS061K+2qzRupuBLTlHJeJaP
	JDvJMzyX7R0t4dIbZ0sn0S3749euvGpzVGBG7GC/ebsYQbldo22AeLI8ZMToHzq2bjzXSXRoWgo
	uwoLOEGYV19WouK5G+ihRvzbd7h+s3hRXiXxro8ud2dVkQcKnVUK6RHE00Eyfej+Qa04+460DsY
	l76fMQMbVWoidIWbti2fPLwAfZzdVUgGh73CYB69fJrehXqiOv0cZgM9E7dF1C/xE6b5u+0y6v7
	uEYJqkLNJLHiavhnWgUwxbLFC77Gs5zwuDHISta5fD03bKg==
X-Google-Smtp-Source: AGHT+IHW9hfSXC3QTPqo0OscrZQ5y9QPHTSmHKiSG71n5Gr9WACU3hTAEq7OXxbr/C9bpmT+R4SoBg==
X-Received: by 2002:a17:907:7290:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b50acc2f5bemr2022051166b.57.1760278547399;
        Sun, 12 Oct 2025 07:15:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b55d9526885sm722816166b.84.2025.10.12.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:15:46 -0700 (PDT)
Date: Sun, 12 Oct 2025 16:15:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Khalid Aziz <khalid@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	lkp@intel.com, skhan@linuxfoundation.org, ulf.hansson@linaro.org, 
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
References: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
 <20251009152744.9734-1-rakuram.e96@gmail.com>
 <aliep4j5jmbdixu5cmqztoxwp3jv4r4hi63qpvhughepsepzb3@qh3mwgryf5ny>
 <3a73daeb-1353-463d-a1f1-22cdece1326b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aiu3n4mecyew6rsx"
Content-Disposition: inline
In-Reply-To: <3a73daeb-1353-463d-a1f1-22cdece1326b@kernel.org>


--aiu3n4mecyew6rsx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
MIME-Version: 1.0

On Fri, Oct 10, 2025 at 11:59:57AM -0600, Khalid Aziz wrote:
> On 10/10/25 3:59 AM, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Rakuram,
> >=20
> > On Thu, Oct 09, 2025 at 08:57:38PM +0530, Rakuram Eswaran wrote:
> > > Your suggestion makes perfect sense =E2=80=94 since host is devm-mana=
ged,
> > > explicitly assigning its members to NULL has no effect.
> > > I=E2=80=99ll remove those two redundant lines in v2 as you suggested.
> > >=20
> > > I had one small clarification regarding the remaining host->dma_chan_=
tx =3D NULL;
> > > in the TX DMA error path. Since that branch uses goto out,
> > > the cleanup section below may call dma_release_channel() on both RX
> > > and TX pointers. Setting TX to NULL there seems like a defensive step
> > > to avoid accidentally passing an ERR_PTR() to dma_release_channel()
> > > =E2=80=94 is that understanding correct?
> >=20
> > Ah right, so either keep host->dma_chan_tx =3D NULL or improve the error
> > handling like:
> >=20
> > diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> > index 26d03352af63..e5068cc55fb2 100644
> > --- a/drivers/mmc/host/pxamci.c
> > +++ b/drivers/mmc/host/pxamci.c
> > @@ -715,7 +715,7 @@ static int pxamci_probe(struct platform_device *pde=
v)
> >   		dev_err(dev, "unable to request tx dma channel\n");
> >   		ret =3D PTR_ERR(host->dma_chan_tx);
> >   		host->dma_chan_tx =3D NULL;
> > -		goto out;
> > +		goto out_dma_tx;
> >   	}
> >   	if (host->pdata) {
> > @@ -765,10 +765,11 @@ static int pxamci_probe(struct platform_device *p=
dev)
> >   	return 0;
> >   out:
> > -	if (host->dma_chan_rx)
> > -		dma_release_channel(host->dma_chan_rx);
> >   	if (host->dma_chan_tx)
> >   		dma_release_channel(host->dma_chan_tx);
> > +out_dma_tx:
> > +	if (host->dma_chan_rx)
> > +		dma_release_channel(host->dma_chan_rx);
> >   	return ret;
> >   }
>=20
> I do not see the need for this code change. "if (host->dma_chan_tx)" will
> skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is already
> NULL. This code change does not add anything.

Yes, stand alone this change doesn't make sense, but if we want to drop

	host->dma_chan_tx =3D NULL

in the error path above, this change is needed. Maybe then even

	if (host->dma_chan_rx)

and

	if (host->dma_chan_rx)

can be dropped.

Best regards
Uwe

--aiu3n4mecyew6rsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjruA0ACgkQj4D7WH0S
/k5xlggAgtLA7I1LRrMqGE2N6WwAa5nB4GYA3H8oaIjnY1v1N7b2t/tjbdECN/3m
wmWnIH7UeQIHQYMkvrgbI6mM04/6cozbV1BQIZoC6ZfrO19YNVaUHiSdSkVa884A
XAD/t/z+4zSPlD9pjhAg+619Ub8KrPG7yPyARwRCN2g47NG+M0nRRjk30Y7POueH
YY+3vQFFxB0F5dDqz1PDyrNZUrMiEOCbzVOulU03FaMyCEK5P2LFNKurm3yhO975
Zx9pxi/JnDAw2slWZEnq+7VcuGgzpCvACFWXwM8f5jycbwnkp5/SzyNRu9x1iwRh
6gMBuzVYVkazusRPTkjGRghdLSedgw==
=AexD
-----END PGP SIGNATURE-----

--aiu3n4mecyew6rsx--

