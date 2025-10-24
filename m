Return-Path: <linux-kernel+bounces-868497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677CC055BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076313A64D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A5309F0F;
	Fri, 24 Oct 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oMvewgqn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689153081D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298110; cv=none; b=FUI7Kzq5UE+ETF/2CFPNcb1Jlpf+MH2YCl77mRnhQfFpYvUApf4tQNMl/pknMowmLbW8QdJ+tTsDtVVUGhrVOCh9U/kz0laiHLykmzQxFFYEnmHy/W81oPR+5Qap+1yQnfgt2F3xvoEDrEB8ycLbLUxL3LAzGZL3tH3G6ZJpLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298110; c=relaxed/simple;
	bh=k1gJBxSFQTQREq4q1D3RYWBmddB3YpEygIebP8N5dbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPWnPdp4RBCmhkJNpZbKA+Hv4+XjUsahiCszsRKHCfV1mpBg2NYixFgctfTIaWDAHwRM5EtXDTVmx06M+82344tXDjh/rORhNwia4Z+PQaOVU6gReRfTpzmJab3DwpR5yvS0riq915p/bKkdoogp1Rz3IZOm0kIk/LwhXSrCrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oMvewgqn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so408931866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761298106; x=1761902906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1gJBxSFQTQREq4q1D3RYWBmddB3YpEygIebP8N5dbA=;
        b=oMvewgqnXvI82ZdvC8ff6+pRaEe4yPjLnfjvw0PwkCYsPC0a2VfQvZ//pGm4HvgBZF
         0wUsZhGrrpIOm4FwTWmFNNvHhHhit/YW2PojtDFFM0r8oQAOxz3m3oJMF6zr6u8zwcq0
         yHat4xZvFjf64pcC0QxcLwGoi6NpnT6NHEFxX573OMLDH0lyTgl8XIV6s6fghEg7SjBl
         1GVV6FkVdZdrA8USalXV0oG0U2BlBxuGCi2nXVfEwdQ1KuIQvimKB4vdXbt0GogwHQuD
         Og4rv3m89+K5Aqcie1PJWoV5C4E/Zb95kZ1524aUJCIYiNuM+xVHKDTl44wIvPTNtidS
         ue8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298106; x=1761902906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1gJBxSFQTQREq4q1D3RYWBmddB3YpEygIebP8N5dbA=;
        b=mGrsqW/WZsI5RGuFGCAxuLAWoFnCum6fAW/7y0z29YpZYQqTy9+UQY/Zwryw06Zz9N
         0xbBUWlerkxPP5WO3oSW9bzELRQ6OPUVTyhjTMkT7X0Z+Szs+ehEeOeSJlIzmhc9yBJy
         1Z+kuGRflN+iufKHonuY2+DQvxU7UAi42CG94BP90xH8Zn1AEWqnBxKXEWcTkGtumzPc
         4Z8/1tCjPg6pb/ZNqH5MYTd0tnnZpr6NHYRoRiNaxR+XPVb7JBKyvX11UailkzgzCb7Y
         RzFvCqcSqzxe62UdE+G8MNTuhdFxlq6lmQgddeswPDH6rsFnyj1Qv9JAB3/8u9Gi3oJi
         ACdA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+4wQ7668Z2mWHe1sS4xc69kW4H91R+6be0+gXjQf0kLhDwVB3uVhnxfcwoVPZePOhDYmmxWu1uJ68H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3b5XJV6AxUeByuqpM1Hn5CjJtTBZecgzY3nJc4PTtNhr1lzKA
	xPnL9UgwRv0CVpg1/HfAPF5WC4MlLRHFvW9vmA8q9oJ036KNlbUeNfZ9kkABN6WqxsA=
X-Gm-Gg: ASbGncvsHKdt0pgH7KDA6BfL9xdzyQkiRaenWKjeY4USskteDIYiDgXlYJjCU1ztDRj
	AOeywhc3NY3uu4DXjzsd+eNhFJ/ctFgeT7PqpLvJ3p8ma20w8AOBeDqcTd6+ZtvLqH/A/gsvftH
	VXqmfdm+8AbPj/sIgiOOdej8qPff6oK4WfcxjBwapDIbOEurhan5/tQzpE68Qk66jhb1u95UzXm
	HM2SKgq11ZNxRijITQd9x82rfai3jlKBzJW2AESfEwupkqzAK3CdiP7kEksb+uT+v14isozR5Ms
	zW0BI2ddDrlePKXAC4agtcMYypbQo7kTkTZ1NNtv+IB/xkFpR+FMbjU1Fd2SYY39IMpq2mmm/9i
	s97RNSHhk1yw43xQmASDRWX9gWjmC9K9a+6Je8jROlzGNTbsMAQZv7iAIvEyxSn/2GGcpXMJapQ
	DllOcFR1OzcxczMbo=
X-Google-Smtp-Source: AGHT+IF9EY6G+N+VE+TZcRK/+/SKxHmucUwBQzWUNGYGyai0UIA4pAaQQzX7Eea7bL/sH0piJFkuoA==
X-Received: by 2002:a17:907:c13:b0:b37:4f78:55b2 with SMTP id a640c23a62f3a-b6d6ffa9094mr176871866b.34.1761298105676;
        Fri, 24 Oct 2025 02:28:25 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e3f316847sm3884468a12.23.2025.10.24.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:28:25 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:28:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bruno Sobreira =?utf-8?Q?Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Gabriel Somlo <gsomlo@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] soc/tegra: Resolve a spelling error in the
 tegra194-cbb.c
Message-ID: <o5nqueofdvsfkprzdthlaqmbkv4ym7o7bf6yx73zwbb3afl7e6@kp4d75dwupvm>
References: <20251024013528.1542-1-brunofrancadevsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anpogoywq2poqzak"
Content-Disposition: inline
In-Reply-To: <20251024013528.1542-1-brunofrancadevsec@gmail.com>


--anpogoywq2poqzak
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] soc/tegra: Resolve a spelling error in the
 tegra194-cbb.c
MIME-Version: 1.0

Hello Bruno,

On Fri, Oct 24, 2025 at 01:35:14AM +0000, Bruno Sobreira Fran=E7a wrote:
> Fix a typo spotted during code reading.
>=20
> Signed-off-by: Bruno Sobreira Fran=E7a <brunofrancadevsec@gmail.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--anpogoywq2poqzak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj7RrQACgkQj4D7WH0S
/k5Gsgf6Aj1NH3aTM+mIgz7ceAGVrXoA5uajX8GtPGMXco1adpIzwwOoDv5f0n+H
nXCoIOOdXGIoqBawKTkSs9BH+DtbR/QIkuzYlqUYW3MsnNxmtEPVPjaOpGC06QS+
J7BFn2YWFFRTgwlFsQWwFYm6xU1DS54WLImOg7fA+gOS1Facb7cT05hEA3+fqVoa
gLRtkq93JnugHiJkWXnX0xmvRTA79AAa4E+SN5whV8qBi3cUmsi90AfvVp62SU23
LwJNiJcdGFlSqe86xm3sU+Qln+SiDoFpTFwj9po6lA6AVsb3jzPnSI1zqTt1M1Hh
yMAudg13gjggLVMxSI0SNnPYBSUtkg==
=Utdf
-----END PGP SIGNATURE-----

--anpogoywq2poqzak--

