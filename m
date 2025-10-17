Return-Path: <linux-kernel+bounces-858257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E32BE9781
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D49581107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4D32E145;
	Fri, 17 Oct 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mrLew0Rv"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D845C0B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713270; cv=none; b=mdHLU9MUnx0Ty0AgikKvv6qvM//6psfTgQbRZ90uuOqec5Kkxuzyel71g1T9QJvzIcV5/vgBPpImuIM0WayG5guyylc5oGeZA4H8nHaJ1ZdWBEOxMqw5VdcNmPEPGgYWddRuPUVfK2T6SUpHLIGNe4fNiArOdO7jmAzA5b3ojjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713270; c=relaxed/simple;
	bh=4R5c1bGrsnGkOOUnK1CszpzLqwKaTx6S7E1UKViMgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALocMH8AYVFJvITnT808F92fSLqry69Q+88m8zAxuX78sbOFk9MAbXhGoSTwbFUKkMof81YqscZmIx6Vpi3Qan4QzQ020cPagF/TCCTOzvxrh/45GvE3GATxcEUCnP9ku/JLzoEn4KZo71sc15wk1qkaS9zSDE4mWe4roNIZluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mrLew0Rv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so1078825a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760713265; x=1761318065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSuJ0ACXse9H5YfB3aq/7dIEkglg7Np8q6vNe0vp/Qg=;
        b=mrLew0Rv/a/Zs3SCFa9bmYQCKUBWcjzDoaLXzESw26n/Ve4YTblivYvSSOK9q1xTUh
         oHpv1Ab6h1ETqLmkxauM+3d3M04Rb+FdXZZ7HNt8WGRTjYgfsreOTT5hVV4TvysBM2fH
         GNVhJuzh8mjbfo8b8BnDl7laltd5hz9o1ocCFoT0qR1dIqgoGFP8YZigGmlXRh8JXpc7
         knL/WC6UStYixntWiWcDyE4YOgUGMsVRmBQ6JYCxkmokaBaebNQngljll0sNSD6WtxeG
         /gtzNM/fh5+OG4atHPixfjTA7xSbhMCROvoXk66oQBRvaGw/IVySssQFA58R2Q9xa+er
         G65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713265; x=1761318065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSuJ0ACXse9H5YfB3aq/7dIEkglg7Np8q6vNe0vp/Qg=;
        b=YkFi3yINpiYZR3BsFMDjZqZtrs/qFRIFJHnonyO+/Njfm4fWmoxWveMIEmqWopS0oz
         HrfDLgQ7ylWshsPbVQlxCSUMt8Zk99nuC78GuRWMgmEn/DFC9kjHxBczsNwtJdfrBNPg
         WtKbMkBnhg3moJbHANnD3/SbXo7KqXL/uWSnutB2L+hZNPBKUCx3Mu8v7UyEZEs1to6J
         U5wqqnOHzYSKnOoCSnQLaaLDjMI5pvfdyNl324Vc/K/RzXf7I6n68ZIalQlOMql0UaGA
         +tWObFdkPB0stb6BNoMUiYYWLhIDeAyF1DnwhVjNz7/kBpZ7umfuvtRPHYSIDhGlZ/PB
         xBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2xeQ6sDnCJgZejTLbgTunQAE5jQGKs+u3tmLs8LwhC8UeANnWtYYl5QyVlAasco33REwO9CLFY3Acapc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVNCHsPJYR4kBB3/UHC21rnMGzIRGPmxVLoNL+ppKTzNOwZdN
	dn1TJ22sCj+H8hMLWR9k+g7ilDxkf+dRe0sxJWRDVrzfVp6c1w1VLHWnsjkWRP2h968=
X-Gm-Gg: ASbGncvJucE0Z4pld/H8GMJok+DTdxBZKsN8x8q0O01hGe0PyRH9AExDDVbA127/5q+
	vT1z8Vvu6+/SKM1EgFAzZOd9jwOn2AdWijVTPGurq16SysVL43S6i2mTZciHcaBWHd0NVvkCIkh
	5QBNFAoZ94ALTIXphqkGzVObPeP4nk1D01Z78fCdgGIWlhA+2q9z8TBJecE5cNUKtion0ixLANy
	vArlgcGi5SSol6rRo7P/eq7s84OaJwvXcUasyrG3drfE/bMScf6wsORfIlXcSwnS5JmlRzo57SX
	ZC2VLNnUM1FWBYRS6ZnVSDcGMPIxO0Nc7yLlRDWz018cKuqdx+xSx543nPru5E0pelXw/S2jdoQ
	JciNQQDoXgJd8QN+wVSGm1tUjb/SlTEQsriWpbd7VW7IEvjWqnTa1VK6lI+HDeWNXjYhjtuO1VB
	NAzdkMDJg2MS0a0o8=
X-Google-Smtp-Source: AGHT+IFDFe/2+iyA5FeI+RGuDLZ1H4kJaebU9REAfIID6sqcvriuQNr4F8M74Wd8OLwWVRFHd3xISQ==
X-Received: by 2002:a05:6402:84d:b0:63c:4537:75c0 with SMTP id 4fb4d7f45d1cf-63c45377875mr654360a12.38.1760713264992;
        Fri, 17 Oct 2025 08:01:04 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c0e77b34csm4048961a12.16.2025.10.17.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:01:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:01:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
Message-ID: <cdkpp74ra2ltr7h46psutkwnzyvl4iegcicnhqqj7svm5trltm@w2egfj5nryjm>
References: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxlujyqvbxqnez6y"
Content-Disposition: inline
In-Reply-To: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>


--nxlujyqvbxqnez6y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
MIME-Version: 1.0

On Thu, Oct 16, 2025 at 01:37:30PM +0200, Matthias Schiffer wrote:
> The CTS GPIO is only evaluated when the CRTSCTS termios flag is enabled;
> it should be possible to enable the flag when only GPIO and no hardware-
> controlled RTS/CTS are available. UCR2_IRTS is kept enabled in this case,
> so the hardware CTS is ignored.
>=20
> Fixes: 58362d5be352 ("serial: imx: implement handshaking using gpios with=
 the mctrl_gpio helper")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/tty/serial/imx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 500dfc009d03e..4a54a689a0603 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1117,8 +1117,8 @@ static void imx_uart_set_mctrl(struct uart_port *po=
rt, unsigned int mctrl)
>  			ucr2 |=3D UCR2_CTS;
>  			/*
>  			 * UCR2_IRTS is unset if and only if the port is
> -			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
> -			 * to get the state to restore to.
> +			 * configured for hardware-controlled CRTSCTS, so we use
> +			 * inverted UCR2_IRTS to get the state to restore to.
>  			 */
>  			if (!(ucr2 & UCR2_IRTS))
>  				ucr2 |=3D UCR2_CTSC;
> @@ -1780,7 +1780,7 @@ imx_uart_set_termios(struct uart_port *port, struct=
 ktermios *termios,
>  	if ((termios->c_cflag & CSIZE) =3D=3D CS8)
>  		ucr2 |=3D UCR2_WS;
> =20
> -	if (!sport->have_rtscts)
> +	if (!sport->have_rtscts && !sport->have_rtsgpio)
>  		termios->c_cflag &=3D ~CRTSCTS;
> =20
>  	if (port->rs485.flags & SER_RS485_ENABLED) {

This hunk makes sense.

> @@ -1794,7 +1794,7 @@ imx_uart_set_termios(struct uart_port *port, struct=
 ktermios *termios,
>  		else
>  			imx_uart_rts_inactive(sport, &ucr2);
> =20
> -	} else if (termios->c_cflag & CRTSCTS) {
> +	} else if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts) {

I agree to add the parens here and consider this more readable than the
alternative

	} else if (termios->c_cflag & CRTSCTS && sport->have_rtscts) {

=2E Note there is no real win here. If the port doesn't have RTS/CTS it
doesn't matter if it tries to control the RTS line. While you could
argue it shouldn't set the line, it only makes an externally observable
difference if one of the SoC's pads is muxed to its RTS function.
I claim it's more robust in this case (i.e. no uart-has-rtscts property
but a pinmux for the RTS line) to control the line according to the RTS
setting. This is (at least IMO) better and more expected than driving
this line to a constant level. So I oppose to this hunk.

>  		/*
>  		 * Only let receiver control RTS output if we were not requested
>  		 * to have RTS inactive (which then should take precedence).
> @@ -1803,7 +1803,7 @@ imx_uart_set_termios(struct uart_port *port, struct=
 ktermios *termios,
>  			ucr2 |=3D UCR2_CTSC;
>  	}
> =20
> -	if (termios->c_cflag & CRTSCTS)
> +	if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts)
>  		ucr2 &=3D ~UCR2_IRTS;
>  	if (termios->c_cflag & CSTOPB)
>  		ucr2 |=3D UCR2_STPB;

Hmm, not sure. On one hand the same argument applies as above, but on
the other if there are pins that are not explicitly configured but still
in their CTS function this might affect operation in a bad way.
Also this affects the (very usual) configuration where only RX, TX and
RTS are used and CTS is not. In this case have_rtscts is true (right?)
and then if there is an accidental CTS pin this is bad and not fixed by
your change. Hmmm...

So in sum the 2nd and 3rd code change is controversial. If the first one
already fixes the problem you're facing, I suggest to go for only that.
If you still think that the 3rd (and maybe even the 2nd) change is a
good idea, I'd request to do that in a separate commit as this is a
separate problem. Also the commit log only describes the first change,
doesn't it?

Best regards
Uwe

--nxlujyqvbxqnez6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjyWikACgkQj4D7WH0S
/k6wWAf/UxQyG6kZ2TILhgdrnIpfu84pODWejTX1lzvAjT7/3H/Qe8pJrRoNWf8e
/iwaPdvVerhKNiekWTz4KPUE1rm7ITBLj3fwndHy/K2BNnZngBzXt+2s+WQ+fd6f
hDZA/hvU5mimICspF0a1ZR3zFWD4VbcMqTrjs2nwFjikC77fJQHXhFAQDDt6vz1w
nOWQ4ls8DPTKU6X3ELQRiExg1Vts1gmcP4IVr9NMGtwbAmchL0brLh+mgyYRv063
enP5ezJ8VX2IV9/vb1yeSRMxN38bdLvRhmvImYwgALWjR93kiH5kbJkoy9r13fDR
oquet7e0kA4duMdCrk/t/iT8vcR4hg==
=8RNA
-----END PGP SIGNATURE-----

--nxlujyqvbxqnez6y--

