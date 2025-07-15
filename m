Return-Path: <linux-kernel+bounces-730940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A3B04CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100F94A6C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B212DDA1;
	Tue, 15 Jul 2025 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcYRmuCN"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4A2E3710;
	Tue, 15 Jul 2025 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538837; cv=none; b=lOSSIcNSh1nOxMBOXLpaXnQDzxrmVQOPBiM47RduAf0aFIdLta37Cl9+0B0YZFCIeuGr+9huDPOXq/6ARpcbWOn7dx/eOV2klONfY0Z7gqqAUi6xJMtMvHLY8Sg2OULwe8paeb5oUaGlsy1nN6xLpoFnMlcnZpbrrGyUBkgEKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538837; c=relaxed/simple;
	bh=zX5HDhRZBsfnBQ8n7II0ArrW4Y8+F4lzmsuIH4Ux5sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/UyYSB3zvj6MXBHovbALXRXd6a4WoSMcTukVibH1+Q3bYZTap17iD6tAGmuMbUWyA7UVtZLwQLMVNpPLYUDo+ISfoKsYLvAdg+S+V3De2zRPPfSmKWp9PlHD/KcF3Xrn0X7dAqPFnmjliN9xFBqzCAMuZQPx/Cb+f09162fU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcYRmuCN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2515999f8f.2;
        Mon, 14 Jul 2025 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752538834; x=1753143634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGayLpNEL++lOl2Fgrmv50BthvjOjmBUXESOFqQSrIQ=;
        b=IcYRmuCNzmbNrORPv3t2UKwyP7GkVTO1+zowybE0D3y5XT0AUkA5Pe88ag64+Xf4Cu
         x0SS+Ib/WcX0KGzFA9wycP/y4LKSqIlzY69Zq7apVd47TSe5zGP7TNacoB3cb7htjGj0
         F9MDsU0Pcdy+dGG+4QBmW2RLG2iYpmGMGASxAPgWkSbP6p6ZSHsVnCIW7EOb8gTSqbPi
         8OqcOGNKUiYeViZfid5fz1/Gkh687GxElVpy5f2pyo1jBtk1LkIofmKZcemRTosegxjT
         g8T9ZYRXZjRxNuFkz5u7dmXjtwPJnLjv79Mlz6ZdaEANNEFYROZV7/RBTU6CzChUJMMA
         UtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752538834; x=1753143634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGayLpNEL++lOl2Fgrmv50BthvjOjmBUXESOFqQSrIQ=;
        b=hRVSUunoqZwmw4JxM5ME6gXgdQamvcICKxBy2LBVq/7kHh/c91NvSlbPzF6JQVpsVi
         xE10guX4hXrsDfOZfTrRYUkUotBYsIcXPDmqWQ2plKGJ33h73EsqlCIb86MWewgtZAqn
         vWg8BmbYTugqxTHMlwQeaxqL/tIfrXZsU8xgBNOeL7iH2uPAZEoMQzK47TAqNUA9e4ux
         co7hh4rU+EiARvV9grm5PJr2ytDL79zfCobKgI/PTkkP1DkIay4I94rxjBfUAS86eKHg
         F92P64rW1jBbwuk6g5TOdFGBN/7PbARNmR+foMR6YqnvEe5urYYgz6Gl/PPG1qw1NmOC
         yDmw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+N6hAbXqW0O1kUAdqOyp/TDtYXx59N5Da8vlnICvUGhkD0CteVXx1ABzPmEtoLeYRxVxBkDQWuc=@vger.kernel.org, AJvYcCXcS13snkxefjsRKMw9rxvMsNHTuwSdVOMTqmsM0hzIPrWHOaqaHwm/XwFAWfv4dw5YtdSVpuK4uqjGN2An@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zlkeV4qFjyv4xTwZz0l2k+n5gQ/MZ7hB7n9vNhgQHsZ6YHU5
	UXzjsSlMkEZ97yOGSeiFMsusvn33Bx+9S52qxf18PfgxFMLqLEhjg4pZ
X-Gm-Gg: ASbGnctVXERkEJBCEDAOkOA8tc3lW4HI2/CdUI9wjobfntwfsD5NxO044p/Yp7u92nW
	SPVuFK++6PldblFjCQ/PjUIZAVk4K/StLURQ2rF32vJMysT6wge0DNNbQ6nyDURZoHXkZNtKw90
	WZrxTflDY+E5p3OyUvhs5H4TB2x6deNkpWsFUT20PFbwO/hayZSsSPByHkECnsgFmlUyatMwAWK
	wVURbDRTPJER1WlRe9LNQzBI7iiZLODP+uk/Xat+Ve+7uIbXA64cVF23gHuFWOSu0KpR9wXpm0X
	kDNsaSxeZk7KZ+oc/v1E3+m/8WOqdTwn0zmpV+RZ1R3g8WCibpkEROFJMz4m8qrn+a2TPURuAjq
	e6RYawnRoj5NWx4k3MhucOg==
X-Google-Smtp-Source: AGHT+IFkMLNhACjP3PV5CG/TBvyGCSRDNzVUmNf3Zz5XfDBXAVK7FWdHsVq4y5Z4+mmrVcs194j+NA==
X-Received: by 2002:a5d:59c1:0:b0:3a4:f00b:69b6 with SMTP id ffacd0b85a97d-3b5f18fa926mr13102829f8f.54.1752538833782;
        Mon, 14 Jul 2025 17:20:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c8bsm13504143f8f.88.2025.07.14.17.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 17:20:33 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1A1124206884; Tue, 15 Jul 2025 07:20:22 +0700 (WIB)
Date: Tue, 15 Jul 2025 07:20:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, Pavel Pisa <pisa@fel.cvut.cz>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: corbet@lwn.net, alexandre.belloni@bootlin.com, ondrej.ille@gmail.com,
	mkl@pengutronix.de, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin =?utf-8?B?SmXFmcOhYmVr?= <martin.jerabek01@gmail.com>,
	=?utf-8?B?SmnFmcOtIE5vdsOhaw==?= <jnovak@fel.cvut.cz>
Subject: Re: [PATCH] docs: Fix kernel-doc indentation errors in multiple
 drivers
Message-ID: <aHWextnU5NoTDEN7@archie.me>
References: <20250703023511.82768-1-luis.hernandez093@gmail.com>
 <202507052123.55236.pisa@fel.cvut.cz>
 <b56b9602-d715-4de8-903e-7c97423bf5bb@infradead.org>
 <de23c688-bbe3-4059-a342-bd692c25cf08@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9mIgaxs14pgAuZxf"
Content-Disposition: inline
In-Reply-To: <de23c688-bbe3-4059-a342-bd692c25cf08@infradead.org>


--9mIgaxs14pgAuZxf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 05, 2025 at 02:45:47PM -0700, Randy Dunlap wrote:
> - * Return: True - Frame inserted successfully
> - *	   False - Frame was not inserted due to one of:
> - *			1. TXT Buffer is not writable (it is in wrong state)
> - *			2. Invalid TXT buffer index
> - *			3. Invalid frame length
> + * Return:
> + * * True - Frame inserted successfully
> + * * False - Frame was not inserted due to one of:
> + *		1. TXT Buffer is not writable (it is in wrong state)
> + *		2. Invalid TXT buffer index
> + *		3. Invalid frame length

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--9mIgaxs14pgAuZxf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaHWewgAKCRD2uYlJVVFO
o9x0APkBFl4i6Z3pNyBPcVS1nzgq1sTMXoTOH+aUQHsGYG/SOwD/egKqJcvM5jGo
w4cBOtjRYLoJd3UxKOirnDSQ3lLlAQ8=
=e9f5
-----END PGP SIGNATURE-----

--9mIgaxs14pgAuZxf--

