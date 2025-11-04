Return-Path: <linux-kernel+bounces-884480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F40BCC303C4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1964B4F827A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55538314A8B;
	Tue,  4 Nov 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPKzyHdG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3632313E05
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247648; cv=none; b=RKFPBkmU+W9IDXyCLHMB0csODRRs4lwEdNWb0qp5f56H1DwqkIcFMUILy+crz4NzxKyLtA5wSxtqXk2I1sxtb0VPaQX5rt0MMuM86GwyJSgHIlbfLjF/F5z7SoTZ9yxfq3BLgQL5EhL+9E6tt8j9oV/K68/f6liK6dx4p/uqzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247648; c=relaxed/simple;
	bh=NTI32YtO6boA3PFAR50owYzOohdk89mtdX8esBS+KQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDo3QoifXC4/i9DmX9w4SDtjCdY1M9cxGe37JjZawj3rh7tByChB8a+Or6nJ5qnu7qBGBl5kmjP3zYCpRwkR+DQ0nHJS+wcHiwfBCgPOvRm3+0EYICsm7Zg8n+ULDf0ADxH++HTiB62pPal70tQlXbrENyQRLPDKHfWtQaBtANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPKzyHdG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477442b1de0so16416945e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762247644; x=1762852444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHpJf3YpGpHL64afQKbWAVrsw8giWZr/mzkQU6vPIk0=;
        b=SPKzyHdGuR+B1nYY0Xj8W0sdaGFDd7qKuPQvN4Q+Zw7D7xmgn+Ckn6H49OuRS5V30o
         8Ie4tffAm8+c5ujuvvi+yECq8BSwYOWwfsOEqAiTCj+5MtrwiM8ujJGZ3EBQC/0DS1Dx
         SqQtYoJNWmA1VPmtERSYMNmT2OAt7LtIc4Hgi4MIfDXlvcikPIr4zinyhJQ0REnfxSUp
         ZFm69g4bdlqe/QRk+gUtapCN7YFTkgtU/lauTt38wHHCutfGrcmjdeunjcChI8eXzei/
         HMMQKrovfKVjZYfmCmGH2UPKo+FO0bgwJNjC3y463eJphIbtVWXpYoOxXA2BZ+wfbTQ0
         t5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247644; x=1762852444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHpJf3YpGpHL64afQKbWAVrsw8giWZr/mzkQU6vPIk0=;
        b=DyJgGpGhpSoo7lGVh4JP6NhANvfYa3BT6p+nbRI0GJOHQujPyAXEt1ZbR5b/3vFrIa
         LPMOOYEkTO2yOhWNLJ2H8+NnpQjcwLTLcNRHG/syeR+nDTYtYg3wdOl8Ev4CJF7C3Ice
         LZNxIWNDFVA5J6L4dGlTdLtOm2HnA+xZkMJM0FOicd7hBbiFWLE7yD5QcACU6ajaN+N/
         Sx9f8jOwxugeaHEdnJx/0Cnf+jtfvyGMMKY0YWDtlmvA3Z6PXg44ducwSUsL4aknmccE
         RFOOZqa/q5Auz4VThxfMge8QNtGyTXQ8RxR0aTFulMdvNH4KwBx40l+VW4lbsCnzsi5s
         S6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXckUg84CsjJW9CD66rpdwd6ioCNjlss7/ixVi2n6OIf54QA3ZTUoX9ah3Z9/roAuf3EXF9Xy4sCpzNsH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/c4B7CiLlyatvA96KqyIX0Xer5F+/sm/V4FGzMbh5NxO95MU
	FWttX2lUjejxoR/q+YweyHDaWoSf/9QcIATgdZKohznBPwwNNFSsb3gj
X-Gm-Gg: ASbGncuDXrLTgMM0/pkQJw9qnOSfWJAylAsRuhr9cpY8FPoFMrU7YWFDSlqdwdX8C13
	wgf1FKfuxADvAArXcmMOJCDZrnNki7hD6CXCT46sUbUNZ53tMRuRJVQIF+GBeslAsSBhuYT3ZoC
	bcAN5SLcD9ZUcxILxovsyom+xKufMJv4AlbKWefWIawV0AI9deRVHpabFb/3rPmuqGCU02FxI6N
	05QjxaxYSfOhlgCzDKeq90DLjPXhGOYnDEJdHcIrVH+oTpMe7jL+pELLXkDEZV6HFD7R6MUfEsp
	fi6nqNZgE9i7PP63qbk9kbwBYyrrWe9ezZdCv9U4cYfc/r0SvlWjc+6N9zu9oGN20TyyRDKJu8s
	QD44mUENT1yi9k5qpr1lPdkPEtaZOg7ifrjMLI+HQ+zqsRsp7hPyT7kDx/5voobFH81ZX94hPpf
	FlRhK/eaHpKcy2ETErQUTgNbmu5/x9nUf9umjjVXqJah8CBLuEqNpxu6R4fab6bBI=
X-Google-Smtp-Source: AGHT+IG8094rz/tIaPzHwYJZtt7A28OHv5lwMGE79saNMkPw8NLncRM6ZozuWAx3nCcLz6FMe+/v9w==
X-Received: by 2002:a05:600c:6212:b0:46e:432f:32ab with SMTP id 5b1f17b1804b1-477308a2638mr142682405e9.33.1762247643739;
        Tue, 04 Nov 2025 01:14:03 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm13607645e9.2.2025.11.04.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:14:02 -0800 (PST)
Date: Tue, 4 Nov 2025 10:14:00 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
Message-ID: <72llskwvuwyllvz24zoex4ad6v6t5skiehmwylj7exoh7bmzjo@xq3v7vja5w62>
References: <20251101-tegra-drm-cmu-v1-1-211799755ab8@gmail.com>
 <pedxgtvzfrfzihoshhfvntin3hwwi3znleilbz4abjad74nowb@un33lgiaa26z>
 <CALHNRZ9-XrMUkQE0cwjq-HUYsy5uerhOQ9sNpirp23kKoaPuYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tilmmd6na7i5rkks"
Content-Disposition: inline
In-Reply-To: <CALHNRZ9-XrMUkQE0cwjq-HUYsy5uerhOQ9sNpirp23kKoaPuYw@mail.gmail.com>


--tilmmd6na7i5rkks
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
MIME-Version: 1.0

On Mon, Nov 03, 2025 at 12:39:57PM -0600, Aaron Kling wrote:
> On Mon, Nov 3, 2025 at 5:54=E2=80=AFAM Thierry Reding <thierry.reding@gma=
il.com> wrote:
> >
> > On Sat, Nov 01, 2025 at 06:15:17PM -0500, Aaron Kling via B4 Relay wrot=
e:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > Without the cmu, nvdisplay will display colors that are notably darker
> > > than intended. The vendor bootloader and the downstream display driver
> > > enable the cmu and sets a sRGB table. Loading that table here results=
 in
> > > the intended colors.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/dc.h  |  13 +++
> > >  drivers/gpu/drm/tegra/sor.c | 206 ++++++++++++++++++++++++++++++++++=
++++++++++
> > >  2 files changed, 219 insertions(+)
> >
> > What does "darker than intended" mean? Who defines the intention? How do
> > we know what the intention is? What this patch ultimately seems to be
> > doing is define sRGB to be the default colorspace. Is that always the
> > right default choice? What if people want to specify a different
> > colorspace?
>=20
> I reported this issue almost a month ago. See kernel lore [0] and
> freedesktop issue [1]. The pictures in the latter show what nvdisplay
> looks like right now. It's nigh unusably dark. When booted into
> Android with a tv launcher that has a black background, as is default
> for LineageOS, it is really hard to read anything. Is it correct as a
> default? Well, cboot hardcodes this, so... presumably? It would be
> more ideal to expose this and csc to userspace, but I'm not sure if
> drm has a standardized interface for that or if tegra would have to
> make something vendor specific. I think that would be a separate
> change concept compared to setting this default, though.

The reason I'm asking is because I don't recall ever seeing "broken"
colors like you do. So I suspect that this may also be related to what
display is connected, or the mode that we're setting. It could perhaps
also be related to what infoframes we're sending and how these are
supported/interpreted by the attached display.

All of that is to say that maybe this looks broken on the particular
setup that you have but may works fine on other setups. Changing the
default may fix your setup and break others.

Thierry

--tilmmd6na7i5rkks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkJw9UACgkQ3SOs138+
s6EMmRAAglAOI/iYg/7zZ5w3SflGxiqrOunGokK9cFTVNpvc9STnAdZW9h/T/8Lj
qcMh44GgzLS4tifB+uMp5P6QCCQrckjqeWF6krgR+1oJqBTF6JCwk36sVHJ0rwGv
4Fk+KXEvxacQj6NcSGD1f4gYlVfT1oNYW7tIUsS8NvWW4beXZlYKsDZsQnCZgTEE
Rwoz/jKiGnP8vrPT9ODZM9ds4tvS47ml9psh173DT6RvoC1Ur/mp0Looh6ugZZc8
bs9oo9rLI73ZUfU2BMy/qJgihBk/jPn4Ms1cXCu2CVciv4SYJkKboS4t7CREw/OG
p4qwK12rXlIc8eXr8KzsVHuLS9YdtfNyK6fmK3IJ/pjtEprkD0/atFOl2xpOdu4C
TbRQ7gn0O3STa03bsTp++zeOgryGOYayZMGi2vnl6qskbz8hG03SrEqqvPtVgoYQ
z3YsySjMpo4wk1eW9BL/9yehZXBRnhQN/xzLEXKe9f8oM9eafnXt9phKgAVNhcsK
e5KQZdP65PJLJ7uWSUX/yGU+473th48dbmFDK2rhfUgdvA4BrZ8MQ1XqxlYWNIkE
iVific+hwXOMGLOnC74VIgh6vZqHSAk99D1MMvzzWnEQ+L5njnqVqq4+in0lhKAN
g9+gsXqCPPnPnE+8R6e0CSif9fqfZafL+Vtoywt6m+CVyxSHyrs=
=rr3C
-----END PGP SIGNATURE-----

--tilmmd6na7i5rkks--

