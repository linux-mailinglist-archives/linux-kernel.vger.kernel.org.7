Return-Path: <linux-kernel+bounces-809774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B4B511E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C0F3A75C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF79D311595;
	Wed, 10 Sep 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WjVvp14w"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42831D39A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494648; cv=none; b=YqtsQpFLJV53MyGqFQZeR9raSoqjHUWaWyWPECjkcojo+Z2eqjetxiRpKcEoOaR2Xw694ra1b+IS/5dMJ8ZojGINFqAKmmNj0Ue7MNve9+mJo13/r5I0Om5G7HM70MXQIDxlj2WRsz/WCgtcpuqTrBl5/hgIYyIum4QYddDMjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494648; c=relaxed/simple;
	bh=qoU3pKTQTic8pv+RfjHcpe00Wy+NEhUJEG/5b653yUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=deXG6kiQe9XAXC80Z+bTLgb9NHzV/3DJepyjGGLXU1zsZhB0ZbGbAZQ4c+rzJkBUzagyWpoj14QsiZ8Hi0nIrdYh6VS+W4mXkP0XZL0K/jH+7QAYBiav/mXqYik84GMnAIXuL2H8zEi6QpV1NemggzrCiqOpTUAYs/S3KJPgJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WjVvp14w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0787fc3008so83657666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757494643; x=1758099443; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=heZhxHLHkvE/mBdXQ2bJ/hfBM5y74AYhJs78IlNsTHo=;
        b=WjVvp14wZZ1DaTZ/bSlVHnr3h1ulIADB8FMF9bn2IL+5AXYsAIrCjU8wKACgwXAQKA
         O+5HfVNBDLwETPn94bb84f2fukiLG517lwvxlifn/EPQaKivwEt1+Tzjjk0gZAsrLRgG
         MXMkD8rxoGm4PNW4tdYewzk7mWu+lmTjGTbM9tF4mYLgLFIK3oh3WHNmCR4ETzmCEqui
         QTqdr6GvED4o7V7Q29oiL0p33TzHC+I0O2qDwXoojAYeMQfVdHIp5+sjARD3noDErDYm
         DaABmS0znOfKT7G89uaPI/MtXvS4AsZKj10O3HiLt3adCj6kt8H2GbQumETarvxCxLLp
         YWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494643; x=1758099443;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heZhxHLHkvE/mBdXQ2bJ/hfBM5y74AYhJs78IlNsTHo=;
        b=gU5USoVCrrx2WFtjeuqYyU3PLjF0sUDMsXf4I3/HTpEPd7mOyEUduewVBcojdg1fmS
         bcQyH+Nal6WLWYqgroBiZrcICwxqkVSxCApzO1NUz/+Or9wgo+8nfLFSF6bltYOrzz0b
         itMeW08hynmEg97Y5DCtz0QfC85y+/gsO8hfY+ekBeJtxSlfT8CVqi4KlhrmIyD55uz4
         p0fdwtDc8NhErul8/e8U696nVrvbMXGtlMRAPQ3GBX+djfXwym1husmC6p+ptXPTfgVT
         qc9aa+RJ49159rPlhPhKHry4qdu47CenMQ6UmzE6CB3IUaonlMgHM9frg7hWbAVGmVz4
         SYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkfklpC/ZwAhzWEcdOMxZWICHMKMn0ndH36y3s6drrs5d8J+xs2+Mr8scmmp+N+2wkzmBu+MASvOKY/PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYj4JThvNTLI0sKudIJFdkOoPH5J05tr9uJ9YiWd1lKaXQ1w7u
	NPQTffZpFwivUCvUE9eIPsInGsyV7sPdrme6Ox6C43402JWw4RP722xLI639q0l3bFQ=
X-Gm-Gg: ASbGncs3zM2PDaBYTSLEDrnrl1icFP7W0Udo+BCDjoOBvSfv2p0GtIQtx3/hub4Yxxj
	el3wDRHQGNvWzAvksBsO+T15F5p0ic75vtB5CRa6Fx+DsT1+/ETPs+ZBK0/c3hIeVCIpcFuWotu
	b161HC0XZjT33eClxQuIO4aYAmIwLvUKwcTJ2C/QK1bIVBcyVxhpBwQInICAXc5znczS933jRjy
	rcEdtpfK/wUdYxP6FbLv2zSaJbDckgW1Yo6fX36q37RwWoskm10mC03pk/gnkQAhKza169BCaSt
	SVZpAtcC0gd1MjkNhPyN9sfGNkV8W1d3J/BkoFOL1d4UU5ds983xTz1O5jDQ34e/YDYEnUoOxwh
	0j12FSVy/0b9AelFozE/O3Xv6nA==
X-Google-Smtp-Source: AGHT+IEt2vwUHtHjKBZF2us6O9DmadgnAagqk9KkLFli/Ox9nZChWE5tuK6SmcWYPMKeP8iB58R8VQ==
X-Received: by 2002:a17:906:6a17:b0:b04:25e6:2dc7 with SMTP id a640c23a62f3a-b04b140a60dmr1468322066b.18.1757494642610;
        Wed, 10 Sep 2025 01:57:22 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62c01bdb977sm2946470a12.53.2025.09.10.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 10:57:13 +0200
Message-Id: <DCOZUOS67P02.1SZS876C49XTP@baylibre.com>
Subject: Re: [PATCH v2 4/7] can: m_can: m_can_chip_config(): bring up
 interface in correct state
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-4-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-4-af9fa240b68a@pengutronix.de>

--e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 7:53 PM CEST, Marc Kleine-Budde wrote:
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
> CAN state and CAN error counters over an internal reset cycle. An
> external reset is not always possible, due to the shared reset with
> the other CAN core. This caused the core not always be in Error Active
> state when bringing up the controller.
>
> Instead of always setting the CAN state to Error Active in
> m_can_chip_config(), fix this by reading and decoding the Protocol
> Status Regitser (PSR) and set the CAN state accordingly.
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 3edf01b098a4..efd9c23edd4a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1620,7 +1620,7 @@ static int m_can_start(struct net_device *dev)
>  	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
>  				       cdev->tx_max_coalesced_frames);
> =20
> -	cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	cdev->can.state =3D m_can_state_get_by_psr(cdev);
> =20
>  	m_can_enable_all_interrupts(cdev);
> =20


--e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaME9aRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOP
pAEA/xv1ypzQcN1eVWohScU7gQS0TJo8V0ZWJ2NMrajS0FQBAKSDGYrugKKXCpN/
5Ie6QRWTjmoM1bXa34OObYQzZK0G
=z0YW
-----END PGP SIGNATURE-----

--e839a8b678f6ec040c6f11d995a891083537e68a99b38219f0c9d06ab188--

