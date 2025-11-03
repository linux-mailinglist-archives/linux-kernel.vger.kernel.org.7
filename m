Return-Path: <linux-kernel+bounces-882645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5486DC2B030
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7503B5FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63612FDC24;
	Mon,  3 Nov 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CS8dHnLk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01862FD679
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165199; cv=none; b=WeSGLx9t0vF+0sU0few41ZmbBoN03ZG0W8HXhtwTX1eBLldDC1WYT3bZypaS6GgrMWxdZ23PiGnhXWifCAx/Q6J+K1S/njkRqDTZshLJhkZKc8fDHkYvKatUhXrpUQd5kEfvPahohRtcJUuBFfBuV0dqVuqPLD+vwgMFHg4aO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165199; c=relaxed/simple;
	bh=4QMq9wjSZaDTE+ctoXegsLcWF3J0EDdGYn1winwZ61w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/coBDWucAPSUGBCb6biCunvCIDexAEM1ucr0EYy4h9PP6LkAyQKKltVLdWxFrpeiAmXEpckx1SYzrZmuag7tq9XFaOdKABuvZFOIWfBUkEx/TB95q7WsktlhdtlGDRMw3484Q25HMvHouBt0E3NHBzD42lHomKtTN4xzMl/h3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CS8dHnLk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471b80b994bso54915515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762165194; x=1762769994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk/MqQKqZE9ciR/f+72baGg6dFC+oYSceyoJ97PjXtQ=;
        b=CS8dHnLk9I+TPjQEvFGtO1XW0yiFar5JN3nb+Uzjob/rc8We19Pr+7sPhHDMvX4fBn
         ViwAN6sV0Aez+d9wqaHeNn5xrmj4xLagcL/LB3MD2pW4w08KqUgsUfApS3YWFnTSkfHJ
         tkmcs6qzd02rDWIS5xgMz82VXvhQP1G8yqNgz51V2piUbMMMRTSqYh2cxprRJ0RL4VEl
         IM094tOWZifZM5JEWhr/F+jnlNhe5g+x9fHzfW7xdm7LedQ/ZXZP2G/C8ip2bb9RfyBO
         zeKaffvWzThn1F+x+EqyTCRJRTlyEi1x7PIqcO9rLAxQb4/Or4WV8c60cckxNifGXCPP
         Hh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165194; x=1762769994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk/MqQKqZE9ciR/f+72baGg6dFC+oYSceyoJ97PjXtQ=;
        b=QbjSbNtaafOoRIUXq9qNZCUMuL+ws2GpUBR9MGak5ny7xRSa+l2NQuXaPJBL5zLGyv
         +pxYrDod3gve2vv1j0WztVpO6Ns6p5y/9XCy1uBUdHF+N0Kt/lBUzCSGQwE13G3xcMH/
         ej4yle5JDRgs3w2+LSikV4zhDgN9DoS6sfo4t6hM30My28TSfLQFf0spCg/tsoEn9sEM
         6JuzY3oaAp7G36/iRjvklJLbc1XrNUbqO686o0+cRUKMFHikRCh4q7vi6BZDDgLft0y8
         FpBgGYlgT6CPofS1W0GA7HaUvfx2iVyDoFLd8Q5EJSXzLRHXGCcuDO22DqtCzKbpDnde
         3isA==
X-Forwarded-Encrypted: i=1; AJvYcCW0iCKOgyKdQe/rnt3rQ7NnqdJ8LEJbFjUECjj8sEPU77DS81IM3iAbSkhaUEyd8MltmBV3ZEiKNC79ZQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFqXT1lPut01W9TDhpvhHUs9ED6cAkU7ah9RmEksV43dVPtSj
	o53IayST0Na2HFztEsZ1DshKyE4kdT2FRknLqyJ9hcRz9byH4fydF8K3qNiYhcIyp58=
X-Gm-Gg: ASbGncvx8wkxje+7ouaxWnnwi0q/BzMy9gGy6ICFlnYx+/v36JPBvddV+J36tI6bxrb
	4OJ9wnyeQtBNy0Yk6993q7CBkahuqoITW1+TkmfvewRdz+4OUjfzBUVyBxrPNKWjKXCIIrrw2/X
	JJuaondge4jl2Ny4L4w6AitUVcvaV8Rg7fZoi+IWphnu/L5SuoLvAZ93X8lWybwgl12a8IrPe0b
	EEfI+wRum3ulUk4KlMUBTA94/E5xhhOFQFpMuvJWK5wVG1ZDhVTqcG197KvtPDUdsj7jr049+v5
	2rOeRouRIUqKcGKhl5Wh+VouTOtqJRXkWo3Kk8vPTTWcfkkfQnvoRFlPPqKOSd9hbAmyazIMzaM
	dAvOZjU5NLPk864dWE5i4pp/nlFQLBtL419d1gKAJgLUOfF/fdBjtv3fuTkMGEMHF4biIHFMdpz
	na+c3Me0zc24Ft41P5Q1XOnHdPcNmrC/o9rhgTcG529EBdFfhhh58OW1ZgE6BptT8FHeOS/YZ6K
	g==
X-Google-Smtp-Source: AGHT+IHOtduNrRBMSHOgFwat+JbsvBQbjZA2f2jjaeArzvIV58w9j8NgIBsWYYESYm2z3s+D+nQH/A==
X-Received: by 2002:a05:600c:34d0:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47730872aaamr92764025e9.24.1762165194241;
        Mon, 03 Nov 2025 02:19:54 -0800 (PST)
Received: from localhost (p200300f65f19f5043df592b151413282.dip0.t-ipconnect.de. [2003:f6:5f19:f504:3df5:92b1:5141:3282])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c569390sm144870105e9.16.2025.11.03.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:19:53 -0800 (PST)
Date: Mon, 3 Nov 2025 11:19:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Krebs, Olaf" <Olaf.Krebs@emh-metering.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Fix IMX PWM period setting
Message-ID: <vi2hrue6l5g5ihoa3rh2u3pitgbwiyvr5su6dhztg6iowajwfw@6rj6lh5fbtb4>
References: <20251103064813.522840-1-user@jenkins>
 <1b071599b84c4519a81990fbfe09782b@emh-metering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cs2lqjurbk5vnplp"
Content-Disposition: inline
In-Reply-To: <1b071599b84c4519a81990fbfe09782b@emh-metering.com>


--cs2lqjurbk5vnplp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] Fix IMX PWM period setting
MIME-Version: 1.0

Hello Olaf,

On Mon, Nov 03, 2025 at 06:50:20AM +0000, Krebs, Olaf wrote:
> From: Olaf Krebs <okr@smgw.emh-meter.de>
>=20
> If a second PWM is requested by a driver before the first is configured, =
trying to configure any of these results in .user_count > 1 and thus the co=
nfiguration fails.
> Fix that by only erroring out by additionally checking if the period is a=
ctually configured.
>=20
> Exapmle: Using of 3 PWM channels to control a RGB LED.
>=20
> DTS-Config for an imx93-Board:
> 	...
> 	led-controller {
> 		compatible =3D "pwm-leds-multicolor";
> 		multi-led {
> 			label =3D "RGBled";
> 			color =3D <LED_COLOR_ID_RGB>;
> 			function =3D LED_FUNCTION_INDICATOR;
> 			max-brightness =3D <255>;
> 			led-red {
> 				pwms =3D <&tpm5 0 1000000 PWM_POLARITY_INVERTED>;
> 				color =3D <LED_COLOR_ID_RED>;
> 			};
> 			led-green {
> 				pwms =3D <&tpm6 2 1000000 PWM_POLARITY_INVERTED>;
> 				color =3D <LED_COLOR_ID_GREEN>;
> 			};
> 			led-blue {
> 				pwms =3D <&tpm5 1 1000000 PWM_POLARITY_INVERTED>;
> 				color =3D <LED_COLOR_ID_BLUE>;
> 			};
> 		};
> 	};
> 	...
>=20
> Without this patch, an BUSY-error message is generated during initializat=
ion.
>=20
> [    7.395326] leds_pwm_multicolor led-controller: error -EBUSY: failed t=
o set led PWM value for (null)
> [    7.405167] leds_pwm_multicolor led-controller: probe with driver leds=
_pwm_multicolor failed with error -16
>=20
> Signed-off-by: Olaf krebs <olaf.krebs@emh-metering.com>

checkpatch is still unhappy with your patch. That might be (at least
partially) the fault of your MUA or MTA.

> ---
>  drivers/pwm/pwm-imx-tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c index =
5b399de16d60..411daa7711f1 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -190,7 +190,7 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
>  		 * there are multiple channels in use with different
>  		 * period settings.
>  		 */
> -		if (tpm->user_count > 1)
> +		if ((tpm->user_count > 1) && (tpm->real_period !=3D 0))
>  			return -EBUSY;

Repeating my review for v2:
> Please drop the added parenthesis.

Have you considered "I wonder if a saner check would involve
enable_count instead of user_count."?

Best regards
Uwe

--cs2lqjurbk5vnplp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkIgcUACgkQj4D7WH0S
/k5zegf/ayuI0k1O/rvOwqgY2KX2snbmVt0zQXx+wWSvSz644LtOFQR+LgsDyy7u
SlZmCAUgG9sTXIZk8uCCI9YhccesU/1Tybc5sca7brEOjTlWzWVGhzliodTxVbYI
95iNCr3aNm6Lkhf6mfDO9FEVvfn7oTSZlDmeiBQyDaD9LDEVKyrHBbFC0GaEINLT
GFLi3KqbLbvJu5df5v2xnsLIwH0zaWj13fMV1oocCylH9tp+YB5tGLMl4/3Ygq9b
4R+YiqcoeL8cupykXBd0WR9S3lqUcIfME9FivoDTC3UDCTeNiMrDNgbF8mxOwd4+
39agoAx03n2Cq66N/ZG21wkBHiffjA==
=DpDO
-----END PGP SIGNATURE-----

--cs2lqjurbk5vnplp--

