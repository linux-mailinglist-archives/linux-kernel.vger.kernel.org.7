Return-Path: <linux-kernel+bounces-777302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED76B2D802
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9AF188443B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9592DECBC;
	Wed, 20 Aug 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WQH9qx2c"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603E2F1FC3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680966; cv=none; b=eIUrRfJGjebCA0hJiSFKuhQ1g4mPi0dpJc+g4dD1y4ookcLanxssICBuLsR91tfGTqa2C8L0ekWQRNjKQkRyj9F9yC3wAwYMqh8CxG5u6Z+v8Vd+iMd/bhooc6XlnGEFT09JyEiReC1X/CxpTfC3Iwxr4qC475qBC3SiavRgZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680966; c=relaxed/simple;
	bh=b0Ve3EV0EbnS6J0OaTxdHWhcc3x/hQh592WEkpCF12Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hW8wFm/WSpcNQnrb2zYBUx/721POC05KyLWQKRvUB82nQHbYISESAgDq8JmrQbms6pMuOuPndURgH2tgRwXaKrREx3mnxrwwf1vOpLUrsEKzg/PFsXG1GlU3gvGMVziDgS2oyXcSTSUm/9jpnOggAXOUmzmoqRHCIgYNMOpA1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WQH9qx2c; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb73621fcso743179066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755680963; x=1756285763; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn3sHeJOdi0b6yWaJNMSGvIWhjZnoLiL+egoidkdFJY=;
        b=WQH9qx2cMA0ELMjivixiJo+VQOLcLlUqZaVU6LtNsh2XG7CgiEEAar3VZ+0kZDNgbm
         0VKp13DXL4kckNThN/KINKBzalq1ie4IYL/tYl5UhZneWo+cBuz3qyG7lSFFmDCabrtx
         Cy/P8AUKt0NYKJV/H45CFwQzWchVU6DI0EKvUSIl9VIqSUo2YoXnPaG61ECUas3ZxBQl
         i6A6rTOpqomON9jZgc7fLVPHzBWTixwVNwMA9QWnY4v8NzpfWkdT0/J8kxUNpi8vZAUs
         vfyxjSAiI5azphq+3oF43+0ei7N2oRIlERe9DbdFhgX6ExNAnfIJTgmIXzaI/JpXwhNF
         S8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680963; x=1756285763;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn3sHeJOdi0b6yWaJNMSGvIWhjZnoLiL+egoidkdFJY=;
        b=Xdq1WaUoyOpAR5T9DXQsQOHX5sCv9v3AedQb3v9lsL0S/OsE0bKtMKYm/ofe4jc6bq
         atoJ2pIPIPgLQAfZjLsiyAVP+qIJA0CW35hPAmx5eR3VuPPQAazQLm+MhRSyYvbto1Ne
         FO3GGjeKDY2ukaRrLWoguZTvU9TmHJs62/Mp1Vqap4aAjifqeUG0wm24BZeDRT254Wp8
         wJDzSjtrxbM7MeRvHDiY7piewxzhBxLzB4FY/yKpiUGAcMAZQCVJbYvnbsYoCuhH7CQh
         mD1nRkDRHi8kCjWC6vRqnv6NKnV1sqlwSQYoTrYxdwwALUz5+KLhUQmt1vrBewn2kRRn
         4/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrzeLXXJy6xL/SAz8+c44/Go/VUXUPLCeZMxtqYMBzH2XoLAmmzUzpfjGbKhC6BifaZHqVKvpUgE2L2wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHD2jSLnhbqLc1oUzQOW9xaMN9voiMeogBSCEgF2thGlTTweq
	9NPCEPZtIulVwHkXO2B0m99TEh/FhXo8nOZHoGxAjx0wt1QGYc/4N8ekk+R50vjBH2U=
X-Gm-Gg: ASbGnct29lANsW4gh8KfoaMw08lSzBsqvX9tQGHNS+GhorTIsYjAy/E82iGa85De1Ph
	UcnUYxooyBWdxe5RejEAUxDGEpCRMc0x9ekRYjOR0hWthVdgrHorBhA2w1iEp0w/SAXDOgboEH9
	YjNpzgSOFZnXUD+Hk6FuXWBmQTv3oyxbL5oP/3A6dMix6RCdbipGfVUJT4TSx/yA+BlXD1d/WuH
	MayRunuGuRM8UW4PB91TSzRmr1vGoEo/UEhGTsoDBHEzhn4iErpOzf2ksLjGrzYXTv9fAvpnM07
	zw0bClwlM7Yfm9x1hIIXfaZGbCkesFeGZHOIoI1SRMNNofJn3Hen86DoUV7U9RwZJ8qestQJNTn
	D/OzwITICXrkejg==
X-Google-Smtp-Source: AGHT+IEfXalOdl7tKNAt6aOs79r9FH8o74RkmYQhdlN7JRgNqLhZEIcij3pckp407AmR7lIZ0rq9dw==
X-Received: by 2002:a17:907:70a:b0:ae0:6a5a:4cd4 with SMTP id a640c23a62f3a-afdf00f90c3mr173557766b.12.1755680962720;
        Wed, 20 Aug 2025 02:09:22 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded47909asm145675566b.54.2025.08.20.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 20 Aug 2025 11:09:16 +0200
Message-Id: <DC74YGSPTL16.KG2SWZD4L3YV@baylibre.com>
Subject: Re: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>, "Patrik Flykt"
 <patrik.flykt@linux.intel.com>, "Dong Aisheng" <b29396@freescale.com>,
 "Fengguang Wu" <fengguang.wu@intel.com>, "Varka Bhadram"
 <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de> <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de> <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>
In-Reply-To: <DC74JEKBB6HL.1LJ53UZJ0T0Q9@baylibre.com>

--6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Aug 20, 2025 at 10:49 AM CEST, Markus Schneider-Pargmann wrote:
> Hi,
>
> On Tue Aug 12, 2025 at 7:36 PM CEST, Marc Kleine-Budde wrote:
>> The CAN Error State is determined by the receive and transmit error
>> counters. The CAN error counters decrease when reception/transmission
>> is successful, so that a status transition back to the Error Active
>> status is possible. This transition is not handled by
>> m_can_handle_state_errors().
>>
>> Add the missing detection of the Error Active state to
>> m_can_handle_state_errors() and extend the handling of this state in
>> m_can_handle_state_change().
>>
>> Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
>> Fixes: cd0d83eab2e0 ("can: m_can: m_can_handle_state_change(): fix state=
 change")
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/m_can/m_can.c | 48 ++++++++++++++++++++++++++----------=
-------
>>  1 file changed, 29 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can=
.c
>> index a51dc0bb8124..b485d2f3d971 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -812,6 +812,10 @@ static int m_can_handle_state_change(struct net_dev=
ice *dev,
>>  	u32 timestamp =3D 0;
>> =20
>>  	switch (new_state) {
>> +	case CAN_STATE_ERROR_ACTIVE:
>> +		/* error active state */
>
> This comment and the one below don't really help IMHO.
>
>> +		cdev->can.state =3D CAN_STATE_ERROR_ACTIVE;
>> +		break;
>>  	case CAN_STATE_ERROR_WARNING:
>>  		/* error warning state */
>>  		cdev->can.can_stats.error_warning++;
>> @@ -841,6 +845,13 @@ static int m_can_handle_state_change(struct net_dev=
ice *dev,
>>  	__m_can_get_berr_counter(dev, &bec);
>> =20
>>  	switch (new_state) {
>> +	case CAN_STATE_ERROR_ACTIVE:
>> +		/* error active state */
>> +		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
>> +		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
>> +		cf->data[6] =3D bec.txerr;
>> +		cf->data[7] =3D bec.rxerr;
>> +		break;
>>  	case CAN_STATE_ERROR_WARNING:
>>  		/* error warning state */
>>  		cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CNT;
>> @@ -877,30 +888,29 @@ static int m_can_handle_state_change(struct net_de=
vice *dev,
>>  	return 1;
>>  }
>> =20
>> +static enum can_state
>> +m_can_can_state_get_by_psr(const u32 psr)
>> +{
>> +	if (psr & PSR_BO)
>> +		return CAN_STATE_BUS_OFF;
>> +	if (psr & PSR_EP)
>> +		return CAN_STATE_ERROR_PASSIVE;
>> +	if (psr & PSR_EW)
>> +		return CAN_STATE_ERROR_WARNING;
>
> Why should m_can_handle_state_errors() should be called if none of these
> flags are set?
>
> m_can_handle_state_errors() seems to only be called if IR_ERR_STATE
> which is defined as:
>   #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
>
> This is the for the interrupt register but will the PSR register bits be
> set without the interrupt register being set?

After reading the other users of the above function, I do see why this
was added. I am still wondering if there is a way to return to
ERROR_ACTIVE once the errors are cleared from the error register.

Also looking at all the users added for the function above, could you
read the register inside the function? Currently you are adding a
reg variable and a read call for each call to this function.
m_can_handle_state_errors() also doesn't need the psr value with your
refactoring.

Best
Markus

>
> Best
> Markus
>
>> +
>> +	return CAN_STATE_ERROR_ACTIVE;
>> +}
>> +
>>  static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
>>  {
>>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>> -	int work_done =3D 0;
>> +	enum can_state new_state;
>> =20
>> -	if (psr & PSR_EW && cdev->can.state !=3D CAN_STATE_ERROR_WARNING) {
>> -		netdev_dbg(dev, "entered error warning state\n");
>> -		work_done +=3D m_can_handle_state_change(dev,
>> -						       CAN_STATE_ERROR_WARNING);
>> -	}
>> +	new_state =3D m_can_can_state_get_by_psr(psr);
>> +	if (new_state =3D=3D cdev->can.state)
>> +		return 0;
>> =20
>> -	if (psr & PSR_EP && cdev->can.state !=3D CAN_STATE_ERROR_PASSIVE) {
>> -		netdev_dbg(dev, "entered error passive state\n");
>> -		work_done +=3D m_can_handle_state_change(dev,
>> -						       CAN_STATE_ERROR_PASSIVE);
>> -	}
>> -
>> -	if (psr & PSR_BO && cdev->can.state !=3D CAN_STATE_BUS_OFF) {
>> -		netdev_dbg(dev, "entered error bus off state\n");
>> -		work_done +=3D m_can_handle_state_change(dev,
>> -						       CAN_STATE_BUS_OFF);
>> -	}
>> -
>> -	return work_done;
>> +	return m_can_handle_state_change(dev, new_state);
>>  }
>> =20
>>  static void m_can_handle_other_err(struct net_device *dev, u32 irqstatu=
s)


--6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKWQvBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlO1
5wEAp+RM3ri661F8DSVrOwkjIHNK3FRrKMGpvQ9+2ZfBboMBAP+8Apk0qQiDYemC
cBJxINhtFDZRi304P3xDyHHa0FkC
=Epp4
-----END PGP SIGNATURE-----

--6db1d471c9c250ed1ed934d67c049fe0a0019dde128316248cc74167230a--

