Return-Path: <linux-kernel+bounces-886556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A4C35EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31D0B4F4B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C63325494;
	Wed,  5 Nov 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="XJqh+z8A"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8712314A93
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350689; cv=none; b=n7BU80ZjB9fgQtiBkQtzh+GqShPvQTatr+QOdSiVLq/sq93UMyWDFTes8IJE//xnQHNSsHvlAXmoyw2U06YzJDvHe/PnU4pkoRGgPaMPaLh8eXMEgRFU4FuFIgDpVCp56oFi9gGjs5PiX/acbMp3DtGNa+R4zjLMc6YkXDA14KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350689; c=relaxed/simple;
	bh=zP41Rmpn5mMZPXrAIAfE+G59N4Vqeo9bSbuVW5Vwl9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZQUc+o2Nhc+CHJDPgSXebghkn7nvR8VrqUc9K3GEHdtmyoTT3C/w3PTQk3MV1/gqNbMPJNSrUHyCa+U3H1qosSrtF6rSvUcWjr6wHbt4txKp7nh+Ndd/Sxoq1ZSDxJ2yA1aKEDb7cmrwrTf9Ynesu31S8P449mcvVQ4CAfju7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=XJqh+z8A; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-89ed2ee35bbso1013450485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762350687; x=1762955487; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zP41Rmpn5mMZPXrAIAfE+G59N4Vqeo9bSbuVW5Vwl9E=;
        b=XJqh+z8AprQdeWWVaS5BDhVHZbvRwsTpw2yaxVcGPy6Lszbpc/xb9PpgQcV6iRzHmh
         fC8gQDMzQ4cEyFcyhWYriJVTBDdTPRbvgKVQNFDzKQohrK2TBn1VBBTN803zsn89uYuk
         FEJq7AEiiNoyyMLmTpVUonDMasiPOSsAvhSLc1obGNu90ZmZIizzy7pto1qPB3hW5ASv
         9DLMewKqSwaXHbdVzAY5FyMiECtdNuY0O9b5WqkrSmG3LPa9oo+MayM5XsBKi1q/EgWk
         0CVSlnEDGJIl5l9FOnQG3CYHsz5pm5t3GiQTZqlFcEJKUUri+hb6FwETuhL8/1JuGLT3
         pXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350687; x=1762955487;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP41Rmpn5mMZPXrAIAfE+G59N4Vqeo9bSbuVW5Vwl9E=;
        b=TzOooFdNiN26P+tYVEcfuyh56QftBSORiH7+UvvjNHqeK3XB3Sxsc6tG17EXfXFVso
         pexhBRN8Oth/HwY5lUlOFTJ6dEBUqyPcJvdeM5uGoq6OEvIJQRLZ6DsE+68wdFynwEFX
         TVbeIauAAZyfpKCgg9PV/1qQysYNJNN+KsxuRNOOtFDSDtp1Jhx7WBOQMIpR//9rfES6
         MRZ7iSQI3xTVtimJ5Ks07o5iZWDGoEwk7Gb8OO63PsMshow/0cjvXnxyz5FwM0jmAgie
         k9n/E61GIaR3HBGnRJRIA3ANH2GJM09Q1C6fziaowmFN1QXmcCERJREA8p5yVYo6AFKz
         mx2A==
X-Forwarded-Encrypted: i=1; AJvYcCVdkfNvCFN4ecTHV/GcV1Q8fbx1yJNDP5POSRimT3IhWnfhBlqVtEVooB7Zb09cF94ztaqSKWFW/xIuZZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eCCDKeTr3nVTlzgRHkkBt3BKCMpHRi+cZkKsz1mh3gBrnVpZ
	Z7as51d+EzaFs7adWKOX8Z1JjQ/bvMqWxe7SKYHkfSdnKGz9W2w8JI1ePLyV637mBCo=
X-Gm-Gg: ASbGncuZMltDqfxmWsdiyl/o2E/hYzOfszZ6m77dTOMH8rBQGo/qwdBPpKarXkIK16w
	XdSkbseWlocbzSdT0j1dg3sw39LrTX3eTndxFondshm527kW7ys5RGTwFZalBhupglCgsXBcf7Q
	6XSSUsGlm1qV8ADbdZtsSgeldowR4Yqs1+DArA/rSVcaNeo2YSAt2yjrwJxQvn9yZooDrG8xvlX
	mGP66iHgRGnLwLus61MytCSB792c1TasDOwpciVP8TJqimbk0q6rJYaa16Y/P31J8F+9H5o6KlB
	4W7C5tLFviVkDg+kq0rxjJNRDkmTaWaEz08Nc7wuJzAs+HiqHm6LIz0neToJ0DuQwluYe4vhCGI
	/xPkYzprATlyL9ldh15k0JvnVEYrCY2WqDZlZCtediddg6Db9HqJdN/PVZQzYcyS/qgS+eTTi1G
	CI+rGsdA==
X-Google-Smtp-Source: AGHT+IHjDb17WJE5ovnji+ZuOA/1CxRvnHlgllSFFQ/L3BHsKI5wbhqVXzK9pnt8K5pFCIhkgw4W3A==
X-Received: by 2002:a05:620a:4045:b0:8b0:f8c4:a5fe with SMTP id af79cd13be357-8b220c001f8mr430100785a.89.1762350686452;
        Wed, 05 Nov 2025 05:51:26 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f5413f43sm432543785a.8.2025.11.05.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:51:25 -0800 (PST)
Message-ID: <6d046cef20dcef4eb14aba6fa89e30d303f6a1b5.camel@ndufresne.ca>
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Zhentao Guo <zhentao.guo@amlogic.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley	 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet	 <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Date: Wed, 05 Nov 2025 08:51:23 -0500
In-Reply-To: <174ef722-99f0-440d-8eee-5dca086e13f0@amlogic.com>
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
	 <b976b442-7d07-4fef-b851-ccd14661a233@linaro.org>
	 <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
	 <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
	 <174ef722-99f0-440d-8eee-5dca086e13f0@amlogic.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2cG765y6sSQkAAGLj2Ko"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-2cG765y6sSQkAAGLj2Ko
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 05 novembre 2025 =C3=A0 17:26 +0800, Zhentao Guo a =C3=A9crit=
=C2=A0:
>=20
> =E5=9C=A8 2025/11/5 0:13, Nicolas Dufresne =E5=86=99=E9=81=93:
> > [You don't often get email from nicolas@ndufresne.ca. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > [ EXTERNAL EMAIL ]
>=20
> Yes, we plan to support the interlaced and mbaff streams in the=20
> following stages. The decoder hardware can support interlaced/mbaff.

Perfect, let's focus on the core for now then, I have additional feedback f=
or
you on top of Neil's review, hopefully I can get these ready this week.

regards,
Nicolas

--=-2cG765y6sSQkAAGLj2Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQtWXAAKCRDZQZRRKWBy
9C7bAP9Qs1rNKbRgDkazxpbW2p5TVrPLZK8wjWZLZUY+/CCltwD+LgR3cm+8x2UQ
D82jlWcSVIKc5R+xySP7dgFgB+WISQU=
=2auc
-----END PGP SIGNATURE-----

--=-2cG765y6sSQkAAGLj2Ko--

