Return-Path: <linux-kernel+bounces-871449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0847C0D4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3073A189B096
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B43002BB;
	Mon, 27 Oct 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOl6EGX/"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E222D3EE0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565728; cv=none; b=njAmUzffbZk9Dr66rto0uc7lBgGA6HN+LO5rwaw1L3s6eQaBUIQiCKnxoxet3WZhUB+HqGYf/0A7qKM/YhhaU+gvdZG5pc1vk2D8Mt5a+wcoM7hj/yASTdbe88FQ+TA1aWn/iNEMt/kl05vvWVvpwilj7qSUl4cGR9bG+32ymB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565728; c=relaxed/simple;
	bh=i5F5XSjM3QJPOTTHFDn4pVZhOuKFqmtvKFMtVhcqG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SASeKESng41cohOK0ecFa4w1Y3o/RU4GHAGIjLR50AUXqLsW4nERG9ve8YCw19sA2CN9TvFPOC4dMVp0HpKdPcbQhZ87BUwJwVFvykXeohOdAEYQ9+1DJvoQUxq5IoXulfiz6lH2Rk5RwhzxW4i3tiOqRONyaOcvefJzghQvZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOl6EGX/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592ff1d80feso3211952e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565724; x=1762170524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgT9stFn/poAbljDOlAYgxNBl2XctKW6jluiWQlJc8k=;
        b=DOl6EGX/+8+hk8eLbTOmrd6+VL7zsHouc81K8c5OcjjiueeAXDnY7m8eDgA5Wd8d7H
         +3wZPJo90Glu3zmfecJpvT4HxmuAuXgpuoAQkYVaF6ww0/W+xo6yjB3YdYKymx5++Sj7
         8AXOI5K+ge/VGlEJPngZhoawc2kNlWQH0coozlMTTejMMFy0adF41dEPhrNAjFxMRivZ
         3ZP7peyNbIbNQ73fOzB6RuHHbCVcO/C34cp5JIdJM1F/5q3sEfDyhBqy5s+RF+/Xc80a
         XougV/F30ZSrwg3FmpXyLLJPeqAhxPul3Gdqqzhuf5xxpcaXyubqyuqT2f3oyg3I8HGx
         WqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565724; x=1762170524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgT9stFn/poAbljDOlAYgxNBl2XctKW6jluiWQlJc8k=;
        b=BnUylTO0yjXGo1hKkeQTS3ZdS6LtvcD3uchGbuotQSRQx84uIGAhP9Jspg6QHrhtUg
         G7l5dMyVldzAS0hwINGakoo/jUeoWsPNWgH8AziDcSHmZKVhviGAP0IGVsEaaojN5IaA
         CA3DqSO1WuPCoo7pi8BIH95/DnNbBJ45KN+47s7LoapjqCwj7OTrRDyi/bLjCYhmzd8j
         wvUbzwp5WqrYLcY8aEbI69eZ/lIyeDldkZCjTVAfbmJ7TqnbXbhcmTnF2c1VGYr+k1u7
         Vd0Na0IXaWg5BeS8hxtyyAHWdAB70VAVenWGa+V5cru4eqxCEKzoXjQqd/bWSkB+M9kw
         JjVw==
X-Forwarded-Encrypted: i=1; AJvYcCWZgUY4rw4CCA2kVSOyu75YEcZY7UswBNaUp918e7fYu5VNDDHNkZ6KvkCoaKKrk9LVrOblRFS07Ucgdgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVG4654tPDAsh2WnyLeCrHeYY4GSUimbvshP36efYPW/k2eRM
	EdiiFE91k71iXM0QB0jnthepdTt9A9j9Z4IlrKMrymiRd0xWe35hD8FT
X-Gm-Gg: ASbGncvs2feKyG7iqy3Dj07hOi9/y86nHS9mkk4A+TFTQBtxdH9cYPQKE/wMTsM0EuK
	2NyP8yCExGzdAXTb9BclvJaM6ED5QfXRDs08HkSqfLdWz3+mmr0meHVTTngo6AdBv2RccFAyaz9
	zXm4DiC9sGxAMo7I7SVnLJOC0invCAQVhnGMToNnw3PCuGnUqT5tBuUPafxrHzS6DUKfbodtcmx
	B7wUpNU/m8Btu2b39MdsinfZJ4vBfOj3tfz5vIv1rjMZ92YqIUoQnaOMXKe+hE0AMLNERUdad0u
	gpKbe9sxrsvKYocgvjRouLRaOwlYrguub2MVyAsE3LdUfiD3MIXWUMqgx47Y+8fnruSVLYzg2/o
	Sd2rIi3GcfV4RXFEyj36qy7mIPzZNhlN4DSiCQhhLrWDe5tqrr06Ddmf1J2dw9sZZiEzUPfT5z8
	nYSCt4fbLT0JXfJOg0rw==
X-Google-Smtp-Source: AGHT+IGSnZ+yAlMhSP89/zGsbZ8XNjjCkf1vNfg2R/zfGqQhGr2QeTscx5csNq8cRoakqqj6FfPRlQ==
X-Received: by 2002:a05:6512:3054:b0:592:f74f:a49a with SMTP id 2adb3069b0e04-592fc9e8f2bmr2863532e87.13.1761565723504;
        Mon, 27 Oct 2025 04:48:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41cbbsm2306417e87.2.2025.10.27.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:48:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:48:37 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 15/15] MAINTAINERS: Add ROHM BD72720 PMIC
Message-ID: <a664a836ba419ea1eae1d8325f246c0955ec660a.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PVPHd8ApeQQcOqGz"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--PVPHd8ApeQQcOqGz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD72720 PMIC driver files to be maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 RFCv1 =3D>:
 - No changes
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe01aa31c58b..7e3c1eac7cda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22353,6 +22353,7 @@ S:	Supported
 F:	drivers/clk/clk-bd718x7.c
 F:	drivers/gpio/gpio-bd71815.c
 F:	drivers/gpio/gpio-bd71828.c
+F:	drivers/gpio/gpio-bd72720.c
 F:	drivers/mfd/rohm-bd71828.c
 F:	drivers/mfd/rohm-bd718x7.c
 F:	drivers/mfd/rohm-bd9576.c
@@ -22369,6 +22370,7 @@ F:	drivers/watchdog/bd96801_wdt.c
 F:	include/linux/mfd/rohm-bd71815.h
 F:	include/linux/mfd/rohm-bd71828.h
 F:	include/linux/mfd/rohm-bd718x7.h
+F:	include/linux/mfd/rohm-bd72720.h
 F:	include/linux/mfd/rohm-bd957x.h
 F:	include/linux/mfd/rohm-bd96801.h
 F:	include/linux/mfd/rohm-bd96802.h
--=20
2.51.0


--PVPHd8ApeQQcOqGz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/XBUACgkQeFA3/03a
ocX1rAf+OKqdSASLkvANGwIB/trs/JiLB0LQhsIiEMY6ZwKNN3UlkIbvSSEjJpmn
nGD+STZZhVbwJP7cpf/Uz9omS2lSQDMtoCTzkzd2+8zXQuuHU0qt/EP20le9J6V6
P/wHiPXOVDfIfD/Gr6JdPQ5XtPEhyPZdY478JbR0bQyzA1AskbLKvmRKZZfsISej
QEzG1Qvzw2hj3tke8B+M51Gf+pJ9Gw+bILA9b96+BTI/JmHENSIEHxok2bSC2oZE
0jJKnTR3LAtUkx7UCmvK8bgnaDTbHb5Es1tbd+ob6I4QuaUemtoDzgEILVMiXvx7
ZY462g3yI8d+cYed3UTXxIuDnsHC2w==
=qVnM
-----END PGP SIGNATURE-----

--PVPHd8ApeQQcOqGz--

