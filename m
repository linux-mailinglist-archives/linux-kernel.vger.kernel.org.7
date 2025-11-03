Return-Path: <linux-kernel+bounces-882719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB5C2B3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFC618922D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3607301039;
	Mon,  3 Nov 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7qj4bp9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7982FF64C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167866; cv=none; b=XKC+WiqCULgOunaHUnjBAO5qJ5rGhAE5y3EYpFzjSZ6vdizm+vBaXn/s5I822BbmNl5CTwnF+kEiQD0X3ETEl1pAYNmFDIiOU4hn5mWHRZR2Q2m+SEilKwDAPKcnmoH0rAWkt1AC8hpC/U2RHeLjn4l96XMZBjlzt22uo5qPshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167866; c=relaxed/simple;
	bh=YmXJRtzOufvUHPwELRF0zdL2TiwoBzb3Znnmr9vFFPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLTz1zZc2qyFgnDF7fp5q1Pb6sorNzG+68Dnicbjvf38l1VnOf3nNDY7EQn0dYwfUJT1HZgKW61KZGl46SGT9DIAeRpKmaE5f215B4IUBy18hPhUTjoC2m13+ave4ltwmU76WeIZwjX3sHUx4CL6hAUHUP/5IlMty1tTQc17yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7qj4bp9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so38093755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762167862; x=1762772662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KswR4Jh4x5x2b1p6DA2Aa6YMOayJHkPhM0EO8G3PYyc=;
        b=g7qj4bp9OZdgxwa6ziAdEvMThqlPTjoThuGJ/5Z4AGK6Q2wRCz/jhtonxBtTsdTzmq
         zFxNTsoAarkXx1T9N0Mns3YRC/qmu2jy3UyMmSCAWWzUwJj1UdAwH6XfRCU0UOSOAHO+
         T+aKV5OEFRLLEWx9nDDsR8TNAuLcatUQWddM98UAAtqLsftkKSDyU3bdREp8hTgW1gDO
         UaVx+6ORQPsmqjO0QFoLW4BlBIG9y6i5ZIwMqzVdq2X+biZ8aXmYFPSO9Skmr/8b7B4/
         dOXyUPyGprsQmrxVyFzaH7gb2vJTCBFiJarvtQDnX2adUY0tGuCTkeXKH7zFU36WChQ6
         4ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167862; x=1762772662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KswR4Jh4x5x2b1p6DA2Aa6YMOayJHkPhM0EO8G3PYyc=;
        b=qgapvRDdSuq2QyXu5BEz3nsskHZLPcVohzMUPV5jfkiDoPcyCgUpJOG9fLhu6qth6D
         yirLAk6eaA7MFrwgre+tun3HTblKtHib9a/QxX6zQlzUvrPrP9LmZ21rgYzqxB0kJEJv
         ShJ4I4vhRYyd+Qa66vpHz+68EnJmY7+JYPqfUGJ/O6+h0uZSa0sdzX2nsvnp5p9Ulfzr
         P+AegJk9Bt6S3nbiYSwqVYTQAfMSAgXIfBaABIbFYHNflNKGFycMUrN838i/iyhzwUwQ
         3wN5RdMZjAwlZik2fLpvzUasWAlyWpR0tM6gYm3Ov9kegD1n60fwSybXn/06olp/ySdX
         QcWA==
X-Forwarded-Encrypted: i=1; AJvYcCXGChibiw+qP/QOI/XiofOhbDnuTvK7szC2+pYvKXcsjKbadR534y/G13QzlJeWpEQeUrHaaYifBUwNCXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzIOHh9rdA2BMeaXfnkFt/+/9u89pgVnWP7t91d37nnx+kFwi
	rREfzxoDosYKalcf9SMbhhFuYG2fqqcZO5JR4mxRv+etG2J8OaMpJ0W8
X-Gm-Gg: ASbGncunbkzT1qUIGMg4ZzQAjcJGMRTKq1VNwW0ATb2FI+52LCNNYdtn5lKKVJRHhUo
	UpgJDC1UC4SeczpPZcZsi6q5BG1x6CxFyfpM55q5A4XSXIP/l9FrlWxSeJTYYHi+6bRc46VjxnU
	AY0mMNCxcPMc5PHDdQ9Y6haFwfH+Txmfqyhz6CwGod7gvTycNDiBcczYm245TXuZfT37QPqDtIi
	joLhg9eVrzqh0ZJEVTZn3YI6otjsTDdQLj7bwCBja6QCZHGBxXBRvX1USRUpfC3UcW+S7jr1+YX
	wAWRuSIGAgqVeg9bqk88yg5S4j16knDdqQ7F0VC691gtI9d/WuYXmNYWcdystMXi7tnxHJeqUxN
	Pdvedr0ipCp4XdMLK2XI5cme0z0M8gwQYLAigQeC00EGWQjs/XGKFQW1U6o++rDomvKaQYos8Cp
	mH85ciwhUb
X-Google-Smtp-Source: AGHT+IGRXtPlRCze14TWLiPoffmVUCfzc62R00mariBM2Y0aUT/gJK67BJa3O83yh9SFO9vGANCX2Q==
X-Received: by 2002:a05:600c:628e:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-477346ee158mr99537455e9.23.1762167862299;
        Mon, 03 Nov 2025 03:04:22 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e677csm149685925e9.3.2025.11.03.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:04:21 -0800 (PST)
Message-ID: <e56fce0f5e89037cab3889135d150fd4f28b4c31.camel@gmail.com>
Subject: Re: [PATCH v5 2/2] regulator: max77675: Add MAX77675 regulator
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Joan Na <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Joan Na	 <joan.na@analog.com>
Date: Mon, 03 Nov 2025 11:04:57 +0000
In-Reply-To: <aQgXWGzUW720mH+P@HYB-iPCgmhaB8Cy.ad.analog.com>
References: <20251029023253.150257-1-joan.na@analog.com>
	 <20251029023253.150257-3-joan.na@analog.com>
	 <3a9441f01e82dfcbdf146a809ba4a6f9604c63d7.camel@gmail.com>
	 <aQgXWGzUW720mH+P@HYB-iPCgmhaB8Cy.ad.analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 11:45 +0900, Joan Na wrote:
> On Wed, Oct 29, 2025 at 09:55:53AM +0000, Nuno S=C3=A1 wrote:
> > On Wed, 2025-10-29 at 11:32 +0900, Joan-Na-adi wrote:
> > > From: Joan Na <joan.na@analog.com>
> > >=20
> > > Add support for the Maxim Integrated MAX77675 PMIC regulator.
> > >=20
> > > The MAX77675 is a compact, highly efficient SIMO (Single Inductor Mul=
tiple Output)
> > > power management IC that provides four programmable buck-boost switch=
ing regulators
> > > with only one inductor. It supports up to 700mA total output current =
and operates
> > > from a single-cell Li-ion battery.
> > >=20
> > > An integrated power-up sequencer and I2C interface allow flexible sta=
rtup
> > > configuration and runtime control.
> > >=20
> > > Signed-off-by: Joan Na <joan.na@analog.com>
> > > ---
> >=20
> > Hi Joan,
> >=20
> > Some comments from me...=20
> >=20
>=20
> Hello Nuno,
>=20
> Thank you for taking the time to review.
> Please refer to my response below.
>=20

...

> >=20
>=20
> > > +
> > > +static int max77675_apply_config(struct max77675_regulator *maxreg)
> > > +{
> > > +	const struct max77675_config *config =3D &maxreg->config;
> > > +	int ret;
> > > +
> > > +	ret =3D max77675_set_en_mode(maxreg, config->en_mode);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set EN mode: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_latency_mode(maxreg, config->voltage_change_la=
tency);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set latency mode: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_drv_sbb_strength(maxreg, config->drv_sbb_stren=
gth);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set drive strength: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_dvs_slew_rate(maxreg, config->dvs_slew_rate);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set DVS slew rate: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_debounce_time(maxreg, config->debounce_time);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set EN debounce time: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_manual_reset_time(maxreg, config->manual_reset=
_time);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set manual reset time: %d\n", ret)=
;
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_en_pullup_disable(maxreg, config->en_pullup_di=
sable);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set EN pull-up disable: %d\n", ret=
);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_bias_low_power_request(maxreg, config->bias_lo=
w_power_request);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set bias low-power request: %d\n",=
 ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D max77675_set_simo_int_ldo_always_on(maxreg, config->simo_in=
t_ldo_always_on);
> > > +	if (ret) {
> > > +		dev_err(maxreg->dev, "Failed to set SIMO internal LDO always-on: %=
d\n", ret);
> > > +		return ret;
> > > +	}
> >=20
> > This seems to called during probe. All the above can be return dev_err_=
probe()...
> >=20
>=20
> I=E2=80=99m thinking of handling it directly where the return value is ch=
ecked. What are your thoughts?
>=20
> ret =3D max77675_apply_config(maxreg);
> =C2=A0=C2=A0=C2=A0 if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0	return dev_err_probe(maxreg->dev, ret, "Failed t=
o apply config\n");

Up to you. You'll have less details if you encounter some issue though...

- Nuno S=C3=A1

>=20

