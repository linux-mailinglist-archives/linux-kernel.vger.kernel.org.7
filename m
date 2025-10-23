Return-Path: <linux-kernel+bounces-867361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83281C0263D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0747A1883A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC891F5827;
	Thu, 23 Oct 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gEcvOoHI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68E245023
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236180; cv=none; b=UGOwg5ioIPDuuEl7bSbI90ICrumLXkia6SAmukU4PJqZ9tfH8MkHN8ddsCNUeRSya+K8pcc2DLIsi7ziHAL6fa0eVGxITciRHfqf7DIfFOOTSEPvOc2iloLPLJkD0J3qExVPEicBlmz+lC5enryeJonYwbHXWXQV2X9QrO3c2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236180; c=relaxed/simple;
	bh=JeoLoOFDkGLH3tpNOyGwr72Phjp8ZAJBLXaKUeI5Gy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jezxgtTDeUvTDxchWSXIELfuNeZ3e99CEyENlSq9ZlVaBBOz7sS7sQTrnvnZtYciNbW1H4P+hlpBLTD25uQA6hdtf4h4/yzKYqkCRYnNcPeZn3SjlR1YJADnESRVj0zHVnwYK2Zwp6hMthzvVkO2SQL4mJspKQHVzlJA8BO30Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gEcvOoHI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47117e75258so7955245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761236176; x=1761840976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKZS4xgdPYgUIvIsxbmjQo0qs6j5eqmB9Z+WVlamt2o=;
        b=gEcvOoHI8/Y4wwWpqSIfq/xpFmoQBJ8nWkNDs023LDlwS5hrAXm/pyLxYX7aAgvHaJ
         7l4MDAPHU1kKaD/kaC2OO1hmx+waguBgCrTL4YLf7ON/NJpXtm+xp6cDNJ2+f6KLexYe
         USvHZsq7dpMiim9vyR0Xr/5Sfo24JYGJ+4HBXC1Zf1HagWYoyEXKO5ADKUNnnqD2vhWP
         TqjY3gXsgzSR4ucxLk93Qw4SYjWDjt6AWchxiTiITbYssaOdd67gDfqSD1JFymA141bU
         ZbffolLcvxg1thiN7Jujm01KhCPmG3yi7/h7FqAGskH//+w91maIypSS9W4eakH0HP+t
         lL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236176; x=1761840976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKZS4xgdPYgUIvIsxbmjQo0qs6j5eqmB9Z+WVlamt2o=;
        b=DHafnXXdNbRg7f1DkuxaIkkbmiGmPEXT0iMbaGyMGKmuK3zcmSsqTrgm36T+3rOAFX
         rJZBM8rjOAx9BYMn8uOiE3pC0bCm+3m8l46nRMsS83kBs0NAevpRXs14jfLDVa2jNao+
         yVyu5mD2YM58Vp2al6UZb7pO6T5Pi6Lg+G6+H+EN7ElmqcnEux3230jKx2Le5o+CWI7p
         BPI7WSQETUqids8V0SkpfHhqe7p/ToIjA5U0ZDqLRHHLCcqzCZtSlL/nAoaSbxtkHftE
         nkf7V+L29dwMfvPtaUUEPOB2JoZgqUfq9KgV/Zi9Gl8ax2hQWJFuD5GXSd/4IZ0nOrFl
         TYJA==
X-Forwarded-Encrypted: i=1; AJvYcCUtMNsiBLdu4iSdiDrJFufxZquwLSjBnIlWp9c2wmxfM1sWJ70dLquVScdDGIiM3vczbVwfYzLB/5NEurc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRyort8eiU+aAxdronFXQrV0RPWPFiKEDLBpaUvnL8/ALXFwk
	dn49Amk2SHHQYSt8f0LLNO77bAbOXrnS026jfyEfk5dm9ioqcaiSOrrSrw7y0KV9eTo=
X-Gm-Gg: ASbGncs8CPV1xATmeXWc32Bfuzki5raeysqbncqGwtp+Wqkd5V0pdxvKDO8v5UnW9l4
	tGuHTow4k/u9cJLkdWzQp83ckPz8u+/gGhWWslI0IBep2G6+AF4QF9QLF3S08KvzGq3CJGYBfIK
	I00Fj9h9HPh9Czdm1/hwK0/KPDFEg0/g5AIclEi1w8qwkPm+IYmSspF2K9P+StECUGu/xIliteI
	SUck/RYU80SppvYEw/3ixkdK4uS3NQi74AXOqAiOtDyRLRU2nOLu47uhIOPlBrJlEBWCe7duVPN
	KmsFKlvEAdsonfthZ5KcN3SK1fd4+spQMo2Dte2FoXX9UaAeRBPWNAI7LEJKGc8oMk11XpORE24
	fGvk+l6QioEV2iR5/JQXd74cYpH/PsVfoz5UirCOJvcsgNvIkJOcC8LeCMKAIjRBj8ld4MLZNkF
	ysNaRn8A0R/06k6vHHAoXwb6WFqyeZBDmBxtwBMD9LRJ6FVXN6wfRNIyQrfgXANQ==
X-Google-Smtp-Source: AGHT+IE5Qe9IouXF3wd/woap6FmjLQyoL/fvr9fm0s/tYwr/PqlztetZvIkUyLfVIXDyEdY4GBMr0w==
X-Received: by 2002:a05:600c:8b35:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-475cb065415mr23655755e9.39.1761236176026;
        Thu, 23 Oct 2025 09:16:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab04686163f49efc790a.dip0.t-ipconnect.de. [2003:f6:5f06:ab04:6861:63f4:9efc:790a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475caf2eb9csm44694105e9.14.2025.10.23.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:16:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:16:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bruno Sobreira =?utf-8?Q?Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Gabriel Somlo <gsomlo@gmail.com>, 
	Herve Codina <herve.codina@bootlin.com>, Bjorn Andersson <andersson@kernel.org>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc/tegra: Resolve a spelling error in the
 tegra194-cbb.c
Message-ID: <4cm74dubx7lzn44szaw4f73n7icd7zsszucz3kqg5imzgkev5k@yso34szyrvn6>
References: <20251022174531.1751-1-brunofrancadevsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ant7aysj5kaa6okg"
Content-Disposition: inline
In-Reply-To: <20251022174531.1751-1-brunofrancadevsec@gmail.com>


--ant7aysj5kaa6okg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] soc/tegra: Resolve a spelling error in the
 tegra194-cbb.c
MIME-Version: 1.0

Hello Bruno,

On Wed, Oct 22, 2025 at 05:45:24PM +0000, Bruno Sobreira Fran=E7a wrote:
> Hi, this commit resolves a spelling error in the tegra194-cbb.c.

Unusual commit log, I would expect something like:

	Fix a typo found by CSpell.

here. (Obviously replace CSpell by the tool you actually used, or use
something like:

	Fix a typo spotted during code reading.

if there was no tool involved.

Best regards
Uwe

--ant7aysj5kaa6okg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj6VMsACgkQj4D7WH0S
/k4giQf9HWEtod0hY+J4Y6GOFR7jqnQDvMN6LvbA/s0chjeOlInayQidq9D4rDWM
cv4WXXSmtIfmf41IlwadSo+MGmhWnV9C2T67SwKQkQoF5oGLmUmaqNRATI2/s3G3
JxcNrCLKQuk78JGPMEfuDpXG+NXIWWIRdYqgaMhDv8trpZzbaONgtjYd+AKVUg73
KX/iN4hTN/R04yQioq62AfOm6IlB0xVXnKfnNVlUGXU6sn+rJXM3yB2QGTR8A0iJ
PeGcKfC3Ow0gBlxdXeSTZ5lvCuqr8wu6lTA+56jR46vJCx7Qiv9wVrdipvrHTLkr
Tdma2wRxQW3Y5wH4fF9R05VQQFnJYQ==
=cwm4
-----END PGP SIGNATURE-----

--ant7aysj5kaa6okg--

