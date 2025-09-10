Return-Path: <linux-kernel+bounces-810608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3723B51CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848E13A3053
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0162132ED31;
	Wed, 10 Sep 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZCQhFnec"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB068334388
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520294; cv=none; b=dUQWDilkpNcQx571AyRdhr3T3a1q0BraMJ8xZXfZYLd4Zuv+yrm6IurCFRJ8Z/r/+YPVMPuKhs71I6Wj+0/2A1RwoNmrdbyCzGsy9uIUMCcDG/vfjIQ+JvM/sukJEl0Kzf93eI+EqFohrNmpbwwR+Th5Plv6amPbQUpcsrARPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520294; c=relaxed/simple;
	bh=bfcYROp3nOWPfcKF+eBB/i1XpyBWo0K81TMw0EgV9XE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CE20/M8hp30qcnF4Q4ZPdKyd8v4sHCsB294h8Y4KBctJayoxYG0KN8H77i1C3nbc2z6jRjPAWMpWhzobR0u/LR0XSodeKy8tmaM5+HWRzRUVRPlREz1A8Y5A4QZAh0cRkOYyreJDHYUyBZph7Qu/KvAMvbklFXJvciA7KUu7D/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZCQhFnec; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso37173105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757520289; x=1758125089; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hGeYkkCyhbWvnGsOGOmQB2DEVGcZda1GrGWoDfFd2/4=;
        b=ZCQhFneczC27793KW41N7pgR7CIbVPPhjh+9bpxrHX54JpAL4yvqZRkVhe0rY17zbo
         +hQkMKjz8lSoMdOBsIO4WSSlBEhzUOet1nHOTdae05KZ8xem8YiumY2J5SKAJwLXwsAl
         riMPtIfUHVy15GRJ0HHZkZlUwBRWfSVhKI6gPCdFYl4WqJkITR+s7eMngCrbK7IJK1JZ
         /xa83c6mMbvnCj75SAt2WPNX7pyJOTkh1NulLfvTkn6Aso7jFBI5upUyOwBn+AThCbbE
         TiAMSNefSBYf29pE8f1xs+hZoMDU3A0VQs2kqDtAPmyW/MUdvv1pPISh7Q8ZcejwuS48
         xD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520289; x=1758125089;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGeYkkCyhbWvnGsOGOmQB2DEVGcZda1GrGWoDfFd2/4=;
        b=hzAog91r7E32Wk20Pq5Q4sDC8dsfWkN4EJIqkDQWk0fu5j6ZC/w8/aEihlIY6YNgrM
         LAmu4yrkuKdZXPc7LFg2M7Rz/x3rckTXorUxyMJWuf5sP44eBTCdmFAu/tdAvxQU2ZKO
         MhX1kwNnLfhHEbI2oRQbcznzD83dVaBSVEC45j5zlL/YGupt6oh4AxbiRJrOgHFKLbVo
         cMjqSPz8+nqwS2Cyv70pympea4GEBzrgm1AhHJtbXhUkqpElopwA9Bj7diwSft75Zl0r
         ReNqQelWN1wmHK6QkmBH9Y8I8Plkv/myeHKAzPAMKPWpMn6UW5HIlNuEUhCXhKbBOF5c
         yuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+N0Gje968xVIkUAO4pgTXLWWapd//hKY63RN2Mj8t23wi8H8qoME6GH54B9B/FlPuFne+8c0HnmuHRrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsa8bw0Id0AH8acRQidf6pOuJRgZW4bjuOF4HTqvUI3BQPUanB
	sA5ZpzL2HwqWnxfMKAYqhoC87BDWYPDD00QNO1vflm3n+F6HNWY+BeCm29I0V0LwO64=
X-Gm-Gg: ASbGncu7S6UyNZ0J4xP+LGXFSVu99o9enX8sGa3HQg04BwtCAI233AY/Ae11WYK20jr
	C7+Ht1E/BJ6R6jGzDU+A3Yo/IQOor6jK2jcNXa8DxsfJL/agMC/XVVnXKmdaWCHO6fxYxEXf2/G
	YQo5edPnCYz92jZ/7sn5/S/ACFVpdOQjQBZy++LMrtHN88/R30p+iiaueJpzehC+ne5MM7j6jhj
	OYW0wh9N1QPJgN4MQbkgqvotxT+hG80AMbJaWZ292DXmXfb5VJ1auU5w1BYnxL54qIfSVRgsDok
	utw8+OMJztD9nPvBoo80B8Hvegosah+0YB/Oy8ZztRByAVMNY6SoXVFF8IBfUiw6ivPYXHV/Emm
	1GthWkAZsRRDUdm8=
X-Google-Smtp-Source: AGHT+IFBGsM0+aGh9prGOhjZRdXEv3BvH81qNwYAQY8uvBoXaDb/4UZN8fjEWRN6cS1gZjzm0WKp3g==
X-Received: by 2002:a05:600c:3b92:b0:45d:98be:ee92 with SMTP id 5b1f17b1804b1-45ddde6acfdmr165607395e9.8.1757520288985;
        Wed, 10 Sep 2025 09:04:48 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521bfd08sm7267516f8f.4.2025.09.10.09.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0a1d633d47d77071a4f47eb2f182d9acda266a404397c83e7cd2df23231f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 18:04:38 +0200
Message-Id: <DCP8XXYDW0EI.2QLN0NYPOWXVJ@baylibre.com>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Vincent Mailhol"
 <mailhol.vincent@wanadoo.fr>, "Patrik Flykt"
 <patrik.flykt@linux.intel.com>, "Dong Aisheng" <b29396@freescale.com>,
 "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo" <wubo.oduw@gmail.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/7] can: m_can: only handle active interrupts
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de> <DCOZIMAYLN8P.23PQEAFQ26ADZ@baylibre.com> <20250910-fair-fast-uakari-4f734e-mkl@pengutronix.de> <20250910-strange-hopeful-chamois-6c4b6f-mkl@pengutronix.de>
In-Reply-To: <20250910-strange-hopeful-chamois-6c4b6f-mkl@pengutronix.de>

--0a1d633d47d77071a4f47eb2f182d9acda266a404397c83e7cd2df23231f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Sep 10, 2025 at 5:06 PM CEST, Marc Kleine-Budde wrote:
> On 10.09.2025 16:28:54, Marc Kleine-Budde wrote:
>> On 10.09.2025 10:41:28, Markus Schneider-Pargmann wrote:
>> > > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m=
_can.c
>> > > index fe74dbd2c966..16b38e6c3985 100644
>> > > --- a/drivers/net/can/m_can/m_can.c
>> > > +++ b/drivers/net/can/m_can/m_can.c
>> > > @@ -1057,6 +1057,7 @@ static int m_can_poll(struct napi_struct *napi=
, int quota)
>> > >  	u32 irqstatus;
>> > > =20
>> > >  	irqstatus =3D cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
>> > > +	irqstatus &=3D cdev->active_interrupts;
>> > > =20
>> > >  	work_done =3D m_can_rx_handler(dev, quota, irqstatus);
>> > > =20
>> > > @@ -1243,6 +1244,8 @@ static int m_can_interrupt_handler(struct m_ca=
n_classdev *cdev)
>> > >  	}
>> > > =20
>> > >  	m_can_coalescing_update(cdev, ir);
>> > > +
>> > > +	ir &=3D cdev->active_interrupts;
>> >=20
>> > m_can_coalescing_update() can change active_interrupts, meaning the
>> > interrupt that caused the interrupt handler to run may be disabled in
>> > active_interrupts above and then masked in this added line. Would that
>> > still work or does it confuse the hardware?
>>=20
>> I think m_can_coalescing_update() expects the RX/TX will be cleared. Are
>> the following comments OK...
>>=20
>> | diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_c=
an.c
>> | index 16b38e6c3985..8cb9cc1cddbf 100644
>> | --- a/drivers/net/can/m_can/m_can.c
>> | +++ b/drivers/net/can/m_can/m_can.c
>> | @@ -1188,28 +1188,39 @@ static int m_can_echo_tx_event(struct net_devi=
ce *dev)
>> | =20
>> |  static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 =
ir)
>> |  {
>> |          u32 new_interrupts =3D cdev->active_interrupts;
>> |          bool enable_rx_timer =3D false;
>> |          bool enable_tx_timer =3D false;
>> | =20
>> |          if (!cdev->net->irq)
>> |                  return;
>> | =20
>> | +        /* If there is a packet in the FIFO then:
>> | +         * - start timer
>> | +         * - disable not empty IRQ
>> | +         * - handle FIFO
>>                 ^^^^^^^^^^^
>>=20
>> ...especially this one?
>>=20
>> | +         */
>> |          if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF=
0W))) {
>> |                  enable_rx_timer =3D true;
>> |                  new_interrupts &=3D ~IR_RF0N;
>> |          }
>> |          if (cdev->tx_coalesce_usecs_irq > 0 && (ir & (IR_TEFN | IR_TE=
FW))) {
>> |                  enable_tx_timer =3D true;
>> |                  new_interrupts &=3D ~IR_TEFN;
>> |          }
>> | +
>> | +        /* If:
>> | +         * - timer is not going to be start
>> | +         * - and timer is not active
>> | +         * -> then enable FIFO empty IRQ
>> | +         */
>> |          if (!enable_rx_timer && !hrtimer_active(&cdev->hrtimer))
>> |                  new_interrupts |=3D IR_RF0N;
>> |          if (!enable_tx_timer && !hrtimer_active(&cdev->hrtimer))
>> |                  new_interrupts |=3D IR_TEFN;
>> | =20
>> |          m_can_interrupt_enable(cdev, new_interrupts);
>> |          if (enable_rx_timer | enable_tx_timer)
>> |                  hrtimer_start(&cdev->hrtimer, cdev->irq_timer_wait,
>> |                                HRTIMER_MODE_REL);
>> |  }
>
> I can't reproduce the problem I had before. I will drop this patch for
> now.
>
> In an upcoming series, however, I would still like to move
> can_coalescing_update() to the end of the IRQ handler.

The interrupts are acked just before calling m_can_coalescing_update().
I think ideally the unwanted interrupts should be disabled quick,
especially if there are SPI transfers for handling packets which take
some time.

Another point is to refresh the timer consistently so it doesn't trigger
because we are late refreshing it. The runtime of the interrupt handler
depends on the amount of work in the fifo.

Best
Markus

--0a1d633d47d77071a4f47eb2f182d9acda266a404397c83e7cd2df23231f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaMGhlxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNE
iwEA7foCDDp+3aePp8Vl/jNXkf8d4BrbsOu7UzxCgS9F6eEA+gMFJjWUBCShvOGD
yvbe0BNeCL04WKc/4wTnmTACQzwM
=g2yU
-----END PGP SIGNATURE-----

--0a1d633d47d77071a4f47eb2f182d9acda266a404397c83e7cd2df23231f--

