Return-Path: <linux-kernel+bounces-764253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5CB2207F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD74B3A5B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772E2DECC6;
	Tue, 12 Aug 2025 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t7VDAG16"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1241D52B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986567; cv=none; b=Qu+hfSrP8FlHb7rApe4Z+jUVV75DPVvwVCju9cSVOtdmdtHViY1WCqvpxJSy0rCTeUFN6rU2GRlgMbvaYbcdalkYn+UrGL1Knqr1Z8I06ztyymaTP0daNGVh9GjH9m7t8WtD+exGs0kHAFOxoGjcZ6QHxE57aiX8EMiOtl2aBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986567; c=relaxed/simple;
	bh=S+lb7e7I7HDCbUrpJr4L+oW1fVzuwt4YV1OTP2C4QtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwi79uWYYfD7RZ+T+62v/ZYR9Qwx3x2KE8PJEY+oylc/Er6X2v8tEe0DSxZV5LYDI38gsYwkc1xxXGvpAzjLhYNegOG/8ERs+9zf4mX41EbtCqPv1NdfpLNOMGx2L7Cc3MPt7NE2Vl7/59VjhZ82hBuhBao5//h+wwJHOqaDmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t7VDAG16; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso31173935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754986561; x=1755591361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+lb7e7I7HDCbUrpJr4L+oW1fVzuwt4YV1OTP2C4QtY=;
        b=t7VDAG16UtJ+yDFOikdHCZDG3565lItxjwil96crcy0QrvpZ9g0E4FTvBbQx4VBoje
         ylWclP3BOV+tLY6dXXhySWNUE+eOVFxmxh5o94dVMY+h0wqVC7Ywr/qP0jXEdnipJeQ0
         Ro+t6NYwoTa1YCheucE/qfdgt84yKw1EcGDi3q6iOsK8w0IaSylVU7NBQRCYIkYNTbhS
         xACVBsV2U34JdXTKOuagP9/RUyWg6HqVKUXKJPbACn4HGHAQ5awuUon1jze6JMPm/NfP
         yMn/CV5cCGkc8JirzriDHsu+k9uvZc6IIR/YQWh8XFRSu3VZlSC9y9XPzknEdemcLiHo
         uIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986561; x=1755591361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+lb7e7I7HDCbUrpJr4L+oW1fVzuwt4YV1OTP2C4QtY=;
        b=OaGFXPc7Oq5NAqU9nx7gILGWaXae9GEucR3L3F8QQd597W0zRWlEyrnT1v9XZEtjpQ
         9YAf6Qd/atkxaSY3+D2jB+UN/c1HpHGpcNXufjp5H30/IwV1lAl97UBWpgvIg7uC0tJE
         BhXGLOOJUnxGet7J19nnWYzl1ngYzGhZoRisRgNEXI6/scLdtplqwsysJSflUeHjibLI
         6Iw4SQz9PCq1mt77JP1zUGvRCcIT8THm3B1m/OIp9T7UaH503n9IjTuCgo5Gn+9okl+p
         xqrKrzAGjxuztIn3WZlrGky+fw8MZKgWtLZEdYdgYDquvbx9ph2hTcz4Xi1JH/cweqd+
         GLjw==
X-Forwarded-Encrypted: i=1; AJvYcCVYWBNP7amMX9ntKesGwD2uGZ/+xX/mZ/BmNRdbmpwlO7Eg8RcnHAgQZ/7pjn07CS51Zgod8XECgSK3ciA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuViafbOkhEr6LSSLAMHbmORqOuawByQkat9dzDRzCf6kaauVg
	xAiNpRnQsAjDDWEXlGmNeYczpPtZel/2pSj0lOvCVkwcb+TGns8vYuhBpPg1YL+9KkyMIAUqfES
	35rtR
X-Gm-Gg: ASbGncuuurzpkHImfTFXYe02i681htW3JCa+aPgtSMp7143jKS4lVsFGQXdZu4v+RqF
	dPSd+B+LCYnQdV3nO2MYGwxSYY0s4Q77Uhs2PWFRRbgTa/NIb3c/CoKLgcGNtPP/qzUZkbF1ZgN
	eUMCmJxgsV1uX5dVA/biJ1jU9XEJ3GYFgMezhlRYsMgJQ9vtGM2WDBax8Cpok6ymEjPDPzEA9if
	n6brOZ0Xw3t2tODCf59MK83zUGIbfke0pemKslJMoaetQZaypHtiI3dRgOjpUUCQ2m5iEnyLRG5
	QMdqX/C5vPTWun7jHOj8WebtPKpc6LnnHO7mvCMVeLXUFVftW1SCo9qTDrv/LTNU2uBUm96+bD/
	ZtU3+4mN+9myy3g1Ij0Pmt/Y0D8168QB7Ub85ggJQy8XW5f83DxLCgL+PIupd+lnO
X-Google-Smtp-Source: AGHT+IFMjR+00EDdOD6rhFQCUHKXMjPDPPRWGKN32vMvFQ0zf5DUnDDq8q3x3Roq+P+e/3ML/0DhsQ==
X-Received: by 2002:a05:600c:c8a:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-459f4f128ddmr108054675e9.20.1754986560743;
        Tue, 12 Aug 2025 01:16:00 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e587e154sm308312825e9.27.2025.08.12.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:16:00 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:15:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alexander Kurz <akurz@blala.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.or, 
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] Drivers: mc13783: remove deprecated mc13xxx_irq_ack()
Message-ID: <lvknzes7sza4bw3onufckk3pd6rixljfqdzivzqdp6v5ef3wgi@reulh66444v3>
References: <20250811064358.1659-1-akurz@blala.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5q76xnetgyya73u"
Content-Disposition: inline
In-Reply-To: <20250811064358.1659-1-akurz@blala.de>


--z5q76xnetgyya73u
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Drivers: mc13783: remove deprecated mc13xxx_irq_ack()
MIME-Version: 1.0

On Mon, Aug 11, 2025 at 06:43:58AM +0000, Alexander Kurz wrote:
> mc13xxx_irq_ack() got deprecated and became dead code with commit
> 10f9edaeaa30 ("mfd: mc13xxx: Use regmap irq framework for interrupts").
> It should be safe to remove it now.
>=20
> Signed-off-by: Alexander Kurz <akurz@blala.de>

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--z5q76xnetgyya73u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmia+DwACgkQj4D7WH0S
/k6TSwf/fIffU4zXR76BKmjAwlFIXK++70fQAT5/s1+PF+b0xcV6OkM9UA7m9HNf
2IlMRtHwcLjCUaFlK9AGJ2wQab2VGrtuJndl219UU18VU2waKdUzXwvHPcHr14f3
XBH7brhCLgPNuPZHMce4zZYBHdJXSQm6zwIjyvm8W4ItCf9v3+Bi1qf9zBBsYmSt
LfT43Sk4UTyn7RHySz9vJqFSyU+YqYxfVynm4v1LCAtCfhHQmDD1sYM/Wfb68vwJ
lwWd8A5NAf5ybthrEbloUTF02W7vythkY5GAHSy1MuOIBoZdvga2eKC/PD/dzquS
PuLwudoi6gZ7ivGg7RZsnyiP2w3XeQ==
=igOJ
-----END PGP SIGNATURE-----

--z5q76xnetgyya73u--

