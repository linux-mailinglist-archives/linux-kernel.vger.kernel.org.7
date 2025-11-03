Return-Path: <linux-kernel+bounces-883054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F152FC2C641
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D538E3A1DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF318C933;
	Mon,  3 Nov 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDfJi9cI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2A27B4F7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179331; cv=none; b=EUtd4thpIvqCvH1dmoeTWm7br4paAFp2BkQ7zGF7cQKgacznib75xUrweN5kkXROGyFiHze8MwTnQcVt40tBP9sJW1LR5uAGGad+GOjYCm7pZcuHuL61RS6lSBXgekMPE+kjCDoflbVfdq9vbSJWQtWyzH1tO5KBC/FMgXrrjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179331; c=relaxed/simple;
	bh=tJd57umSrSrMkwMZ4jsEEr5dXkJRBQnG/iLqH9kTtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LneB08S3OR9pDFlZNUTtl63oxA6mTXcrbnLARGb2iZSteWmXL2HZ7y4AoXDh/zj0o+UxeSrb9469nXPEHBx2px8QiM8NzLHyeFB9gJyXId0yww4/u8GWxDBEzrVmJSfBS9/N55Te5oK86r/UU2vBnzTaSDM9jFZ073i+BWYfRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDfJi9cI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47117f92e32so36325095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179328; x=1762784128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xis5fSul0gQO0a8v8x/O3Qgi2bVvhMEH98mMW3na7kE=;
        b=KDfJi9cIGcm3MKYPmtf/mSweRhDOVoXILgEMEpRmjCZOL4ldidPDclPG1E1GfWDF6+
         NglG5WxTayeklzJGuZoj4De0sg0nNscMyFCtblzoyKGJ8Voy1XmvtZZgvUY2lALhvzGW
         P7w0gxSXrphHEOaGXBxP7DEX+XIYdQVI+dHMy+WfAT/bN1DWd4eH9pTOVE7SUJEUT6mx
         Qbcgsxfu7BFZITIfmD9r7KLixRYruRwlrFQP413a0SESldQ/pZ+MyYq0DIm8Mp5PXoE1
         ig1ob1cqCOwzMYEo77pUZ6V9vJ2xUD0059W3855RF/zmdsAxHiU1dvtfIEIB5con5l3e
         i5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179328; x=1762784128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xis5fSul0gQO0a8v8x/O3Qgi2bVvhMEH98mMW3na7kE=;
        b=MEDJ7KcADfjEGDqDgZeWmG/zW5vis3il0IIy69+M54RRu/mQUiWOr3xokMjAszGyn/
         OPuUAGol+CX8Z15P0XJID0TkJPhu0mjGzBqf/BfLb8j51zjKjne9l+sSG2PsvHA6nZ+R
         SdHuxDnockS0+H/1VsVqIWdnur7wmMe4KyW9zDZWr5I5PpS9cyhGJJxTgsy70I7LTEXi
         4hYZXtIUAswtVMAwusKLnPlVogEUN85TY8JOqmv+CoLNHgc9ehlZLWAVQe2lXl1+fSfS
         O0PDOlxgs/B4zAwkKvBEkb5nbt7gJN/mzfdFiNk24L08dBGdnerpesx+q9rG1P3a9A9k
         RMhg==
X-Forwarded-Encrypted: i=1; AJvYcCUaXmjlbSVnRZTSaxdfdk7LS9ZRj1CRYSDxUCPUZV14cANfPPTSd6S5u1nKf3FG7OsjjAsVSE4V/eMN/FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKZiJA1pgvSnjN9NgKtlK5BfrHSNOSQTazsHuZhWZ/TZ0M7TU
	0riqsswm+yn//wSPISyaJxlTDR2Xvx6uf7l63Ptstx9Gzh+pxVbkUHT2
X-Gm-Gg: ASbGncvm7Eyqb8G8yN2QyGKOgB0laY1J3qvFD3cmCggXHOkfma3SVYWBawSo4ufT0ms
	M17+qiKTXJqdRh52Mpue/GK10lDXob9W89loOsBi9XOxpjc4CfO0hvoImkELZFuwB6A/kQUfQK4
	lLUEr/9jc/xSYsQSInqCk6yb5g0hf1D+3gjaxiAvnf5SymP6EpONDQE2w6PlYgdf85MeLrw4p3h
	gQGQb1jPOoI9f8A1LcArNY3mSSZaCB+gCILr8G2iIUEqoodNimd95PEo6ROJeugb9tR0cde+BpW
	g8SsYZKHNR0def3pM9693lm0MLD4wQvDP9XVyAU2RUD0VFE9mFuBGjEkkXLPuE1unyEnhqUSq9o
	5XClwwlB2lp3wqzx88FzcuxJouL/Im63Zpxi/wrCofUQSvqZGVrQNFjh+Tf2k37MecZyTWfVBBG
	8PwE/+QitR7bjK5rURkpbxZwOdjF30o+nEyJYgs8rhVyIOWTV+Y0DuXg3KjMaahks=
X-Google-Smtp-Source: AGHT+IG/NyKSA8+Ck+AODhZFBQsqS988o0/8irLATr+tquMGH5sogqa3ax99aZPEXnB+qAqlgcsQQw==
X-Received: by 2002:a05:600c:871a:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-477307c5165mr110192245e9.14.1762179327861;
        Mon, 03 Nov 2025 06:15:27 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fab7b79sm86939075e9.0.2025.11.03.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:15:26 -0800 (PST)
Date: Mon, 3 Nov 2025 15:15:24 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, kyarlagadda@nvidia.com, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] spi: tegra210-quad: Refactor error handling into
 helper functions
Message-ID: <w3clgkw6xt5qd2qimxltkxbzjkhokgddf454vrfbw4yhbumdpq@ahq7lte4iqdq>
References: <20251028155703.4151791-1-va@nvidia.com>
 <20251028155703.4151791-3-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lli4tbylqnpu2c6d"
Content-Disposition: inline
In-Reply-To: <20251028155703.4151791-3-va@nvidia.com>


--lli4tbylqnpu2c6d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/3] spi: tegra210-quad: Refactor error handling into
 helper functions
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 03:57:02PM +0000, Vishwaroop A wrote:
> Extract common cleanup code into dedicated helper functions to simplify
> the code and improve readability. This refactoring includes:
>=20
> - tegra_qspi_reset(): Device reset and interrupt cleanup
> - tegra_qspi_dma_stop(): DMA termination and disable
> - tegra_qspi_pio_stop(): PIO mode disable
>=20
> No functional changes. This is purely a code reorganization to prepare
> for improved timeout handling in subsequent patches.
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 84 +++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 40 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--lli4tbylqnpu2c6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkIuPwACgkQ3SOs138+
s6Gymg//YjL75UguTsHt3WntzsZXMUpzKXhNOHi3yy8b1KSppwPRFrMZM/lNtF6g
Ui6GW5VrF0uPbFBjHqiURyo2pGjw3VFohwg7B7+QTfgEByi/yQpy6npR66YDDOgr
g2xRSpi0jOzl6MWxOtfym1/K1blxXx+NSPIafkT/4ZSZ++IH/e139s+FbTzeIzF0
6nbWSalPKRzQxfJ2dJTp38VIYj74i7CTnsT/2+sERl4KryIyXZcUGikZ5DEbR1JM
dEQLZuZwmJDzulfuxskyiDPqUXYoLJXWtaG45WKHEuGkpXlVP4oSaC/IXZGxKM5C
UyU7yidPe3LipfBmuevDNkqI3FcWtR2dBE0j4Z1jcXv0ao0t2BvZcIbLP9DSi+Th
wo0rzEtydDIJKIRO+ymxJ39Ioebeoh//b4x0DuLn+pRPswwfDAupxwsR0DH+A6iD
ePZZC84a9IaHuhpKTTVwkoSximlrwvKZlSJ0r2sKHDDSvYcnXuJGI16h1bkG/sCW
FqKQnYBiBKQRw0Chl1T74+bDVt1GPjBfnMN9PV5D/R+advf1c7Yili2lYanB41jx
0BDwJNEQh/zR7D7ZAe2Ns+jBAPSlCTAmrM6oXsoOyDKqATK2kdAgfxD5K7gZzYxv
M1BhObLbr3gnEml3HLhkg5bghA+cDLdFEDd3mwxuB629o7ALZwo=
=UI7C
-----END PGP SIGNATURE-----

--lli4tbylqnpu2c6d--

