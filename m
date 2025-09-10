Return-Path: <linux-kernel+bounces-809759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C4FB511AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABB44738E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40703112D0;
	Wed, 10 Sep 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zERqqMqa"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA64310658
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493712; cv=none; b=R2W8Sdh9vLG4OlDTor6Hu105mkzQxrHOsGI0IBfIFWmIehaS9puypW2QrDjG4QCLbzG48lQcJq9+avrNkKCr6WcqcxR3Cogqh04xQGv//ZRtT3RFXbls0ePVs+d4h8qBkVh2bRr77ODJLTw11dDNY+jMkQyPpN5iGWtEhRL89to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493712; c=relaxed/simple;
	bh=8BYfSHtHTpHBWXb4w05N17dIDEdh483y9XhV1TMwVBA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pLXijYi2UO8ugMVGYSCk34Ci4fz7PWRsuUz8CeNElYU1GF6estX/Yir+IT7R3QDhHhSi5BigGDHHSvW10DccDZgc1SPhMyKi2jRbSZzoXi7M1ZAQKqiHr4I30/okiJtSnGjBtZ8uriVoF3f4fLgtKJQBPR+UX+bPC5yA/oOqrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zERqqMqa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0787fc3008so81063966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757493706; x=1758098506; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSif0aXJJp0kSU7OZvdmQspKrVD0dDMIeIyzSM258Dg=;
        b=zERqqMqaJeFQzTPMs7zZauwrE3Z2PwODLFNiHoSv81BxSMsJNdeK3MROP33BON33ui
         jnkGIBUK3oUahTMbc8DT+QQSl5/O8LQpj2+5mQw5+XedAMUx8ZkklTE4edAyXfHdVeur
         GzMN8Qge7IXKPbha9pts9umXLkrrbTEZ7kyjrTv3qsDYNUNUXzIZRc3YXj7TSuy26WUD
         BBSGWLNe1Pxw4TGEEITvx6Az61Xr428kno6/FgBP8Y2QHKGpH4KtnQJ6nenTtqpGEyZU
         IS3ZR9PwXIljs5kMJ9nsXWfdPeOoFwMg/+0hp0Fux1HIw/kq71c16nhOG9VJ4PFDlMbc
         sXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493706; x=1758098506;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSif0aXJJp0kSU7OZvdmQspKrVD0dDMIeIyzSM258Dg=;
        b=qYGfQBw8kuiscEo3rHYzrPP60hx7pTAX5+FdPLLEPb8K9bm1Z0oK1oIhaVFjkOYCvZ
         NkA8OQiiQyAK8QJmQ3pQmbViWNAwxAnvZBrY7nlXJ3bfcFG4v5UDY/46PVC9CzX9evpD
         Oer8xoTNklv86uUEmCA1+RXFpnResnrzqemPcGqVCfqfQEw5AHmVeBDGHJWu2r0Podxf
         iyh50pPGlYAOIwu78pNRjRBuuwd3A6rXshnwZ+ip0Smpy4+3DxilZOmfu0beST9E/Rv7
         LHa2v1Fv/qdEcix5JQ1/Z00OFMIRSKCBDXm2M3TJQsIPbE9KFzuo6QA8zRYq0fbOktSG
         lGTw==
X-Forwarded-Encrypted: i=1; AJvYcCU1lKuoIgRzPpCVoK4ZSH485vrUXj1VOFfDTsmxVmH/T37rCDYrtErexj3KTsrYRqXvQQZEJX7KSHdt4Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVibr8PN/QLSdYI/L0tflyPoKiOFfHe+POscihLwKB0dlVmaN
	r6tGaptZb4DkyLsjcPiEXBPH25MOxNVs4pGK1sB38/H7OxPF8ayp0GMIvx3qzJDluJA=
X-Gm-Gg: ASbGncseVU8vluYGRVHWyBlmzXogIIRtnIuqj2Ch9IPhtBzfygNrBYLg7jFpGkJD3SH
	O3/7u5KhEflmpbAEY3j9Oe50hWjlOS76dn7cwkqemtGPglHLDqmac3HEwBLzB542zoPLWzkvci3
	LaK5RJhIS4oXdwGC61sdjhVrFjJrjl67aUepiRUPmovAjOX0YkIJWPg3hX/jhkikxxpHDENMsBV
	wKnIG8u3tfLht+oeZR478UYklb7tdb7vSNXOkmfIU8WzWtJl3Bt1L/m2q7OUZ0c93FD4pjicsVZ
	dyMj6VJSDhqVKiENxUBVoClpB8qsxwg/e994NoOBXGguPRMPsFw9p+JkP5v4v3MLFTLvzRptJiD
	R6zmlwVad5mGMW0w=
X-Google-Smtp-Source: AGHT+IExNmOsAnAJtqdj679s6TGYzo8sTv/XkpvZFopED68H/ezdLpRsIanj2ZU7Y2gRe1TpbDGmjQ==
X-Received: by 2002:a17:907:6092:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b04b1545011mr1444007166b.39.1757493705475;
        Wed, 10 Sep 2025 01:41:45 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07833a7cb3sm131465466b.81.2025.09.10.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 10:41:28 +0200
Message-Id: <DCOZIMAYLN8P.23PQEAFQ26ADZ@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>

--2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 7:53 PM CEST, Marc Kleine-Budde wrote:
> The M_CAN IP core has an Interrupt Register (IR) and an Interrupt
> Enable (IE) register. An interrupt is triggered if at least 1 bit is
> set in the bitwise and of IR and IE.
>
> Depending on the configuration not all interrupts are enabled in the
> IE register. However the m_can_rx_handler() IRQ handler looks at all
> interrupts not just the enabled ones. This may lead to handling of not
> activated interrupts.
>
> Fix the problem and mask the irqstatus (IR register) with the
> active_interrupts (cached value of IE register).
>
> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index fe74dbd2c966..16b38e6c3985 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1057,6 +1057,7 @@ static int m_can_poll(struct napi_struct *napi, int=
 quota)
>  	u32 irqstatus;
> =20
>  	irqstatus =3D cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
> +	irqstatus &=3D cdev->active_interrupts;
> =20
>  	work_done =3D m_can_rx_handler(dev, quota, irqstatus);
> =20
> @@ -1243,6 +1244,8 @@ static int m_can_interrupt_handler(struct m_can_cla=
ssdev *cdev)
>  	}
> =20
>  	m_can_coalescing_update(cdev, ir);
> +
> +	ir &=3D cdev->active_interrupts;

m_can_coalescing_update() can change active_interrupts, meaning the
interrupt that caused the interrupt handler to run may be disabled in
active_interrupts above and then masked in this added line. Would that
still work or does it confuse the hardware?

Best
Markus

>  	if (!ir)
>  		return IRQ_NONE;
> =20


--2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaME5uBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPh
JwD+O882FfXxbmgBdEqU131VdRliujOf0g8vLBYeCBmbUP8BAMU2SEytkBNKdis0
htuDc2xS83czxVfU4r/5EMimHwcD
=ewUL
-----END PGP SIGNATURE-----

--2e38c85892acb2a28aa9c9c170304678bd4f0f3265d646caeeeb3f8e67ff--

