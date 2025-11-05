Return-Path: <linux-kernel+bounces-886303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F1C3534F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BD6189CB3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FFF30C617;
	Wed,  5 Nov 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POeEDZA2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0476303CBB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339721; cv=none; b=nQYsLTCURYWGskKhfYSmJflJ7ZblEoFZWBai09Mw0TLj+Mse4HGOnf+MuLmhAXPboDwekLQvh0gpYYkaQx8VdUXrxscp3AUNJYRd1/1B9UUVFYqftTetBjPTC5caLilyxR9UHqpO+83vvbYtkBOKIZjGDAl9ufTOdiPxAc0Icso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339721; c=relaxed/simple;
	bh=9n5PCPACMfXax/zPMXMotFrtre6gVZMtcQ1LtgFwnKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBn3CL1c02uQM/6T/FqW5OaMf4GDTYBtFwiRbF4X7pABylj7zefrO1CuD5YaRxcPM7Rf7RlSYdUcAza4mZJNcZDIHCrz/Ab3B20fvNfiCYr6OXTvCq1m243576PJJWvBkRsL/buiksaf+tMutO6p89cxcUAjHapdA0DBN+izKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POeEDZA2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so407382f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762339718; x=1762944518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsTw7O78pnGpRy+iRtTZEzUjE+DzYQDTN2DaHetAfrk=;
        b=POeEDZA2dOh52FnAJi6nSRqx4KaBDUwdRqfrMi6Xjre0s5XK/if1WOnQtEquVSzdqn
         HCLwZxl+ttPFaVXP7MzEf+QWVCaA5y4Df4IOFZQ0qpijz5XI7WMS6uBWqNyHCDkyVL0P
         Z4B5DAKFoGu7Zzkk3Kr1Bmii+roFvsGLaNv/jOsjEqCMVkS3ItXpTvxCiXGjN/BLomrD
         WZsa6plHhdHEVuWQP9U731GT1Z7y3uY0xg8EB8XoqI0+qTqpIW9gPBE7q6t4EfLL+2ln
         fwWv8edtQWg/buQZEN/h18xLE9FNQw3Ou1sH/U+UoQl1lTKITK7GjAW9C4A7vRILf7+n
         09pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762339718; x=1762944518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsTw7O78pnGpRy+iRtTZEzUjE+DzYQDTN2DaHetAfrk=;
        b=QaOR/NIeaIzi0iZsZMQ7R2640HzAyNaiJ6U820L2Iu+rOtvC94c9pvrN+pt2sbFUSL
         VwG+AsLbOygtmFmOEgQu2A9pNzA1Y6jjXBXHlPF8d0F4bryXLWsHdfR/oufjkZ11Xt/q
         1/7t7PzpZBJfhPblRfZBka18tgjnPndrjo0KrpgmOhmJKaHZLoQEbmA9V1eHTE/Z2zVz
         /PAEK/hYAbK7MN+l8eWy+3muYhXOjbkqN011lm9khSSfL1zOjXGJoXbPkZJ0KfDoQ34f
         5rsoCCv5mFOcuynhx3mJBEDjFPwrOzHM9JLFm9gVItti33awqVyTKdk6oCoKu1FRQI+Q
         PWvw==
X-Forwarded-Encrypted: i=1; AJvYcCVGhtrJeD5QRgC5sniL7Wxb9N6e7qeeyj/xrdZlmpo/KJnSvxRSIfzjECigppm6s41j8b+wFLFy4Hmgsw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkOCs2R3qCOD79EWfFPbNZcOpjiEOwZo/SqL8JgOocOZfLoEt
	8J+EpaIoWNUpdgwMee2a6svYGCRgOR54lZ+eW34tbskN/eI79bSZkbzXQnvqpd8g6wT5Ib2IykZ
	OSideN8eLwq6gj6i2spFShuyrS9cV/pU=
X-Gm-Gg: ASbGncsrp/p1KUrOXmRi67du6iGt+f13lTpyuXjZzPolR0fVRHftfavmKeZPrO6on6S
	54Z8sBjlfVLguylXTXmZBWDbpL4EYgbCo4Byku8zfzJ8ztrub7p0LunNzud1xsjMS6vMeFLMBUI
	6xD0dBMEOot7z0R0qdmnOH0pVM2KiaBOVxj3yklPscibWnE4zkn4MtzFN9i4UtwNAd9OC6n2o6s
	P2NbmqaI7bKvM7I/nOu++xdQcYHzMuR6nDaWRfGQi3piKwf6/6VtqdoOAxl7TEUZY99
X-Google-Smtp-Source: AGHT+IHWnjoAvUn742vG10pHl+K4VPiEg5/pZLb6TFJ7YY92HnZbEpMverzFpNjljHfa15Xs9iw6mwdMBlYmpdJVG4g=
X-Received: by 2002:a5d:5d86:0:b0:429:c6ba:d94e with SMTP id
 ffacd0b85a97d-429dbcdff98mr6718662f8f.12.1762339717846; Wed, 05 Nov 2025
 02:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com> <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de>
In-Reply-To: <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Wed, 5 Nov 2025 11:35:21 +0100
X-Gm-Features: AWmQ_blny4MHJkEILTMArhRmJjjnYH-BZbrNvJkTy3EPdDpe46AMNH6Ue6vCj7g
Message-ID: <CAGRyCJERd93kE3BsoXCVRuRAVuvubt5udcyNMuEZBTcq2r+hcw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Eric Dumazet <edumazet@google.com>, oneukum@suse.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Simon,

Il giorno mer 5 nov 2025 alle ore 11:40 Simon Schippers
<simon.schippers@tu-dortmund.de> ha scritto:
>
> On 11/4/25 18:02, Eric Dumazet wrote:
> > On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> During recent testing, I observed significant latency spikes when usin=
g
> >> Quectel 5G modems under load. Investigation revealed that the issue wa=
s
> >> caused by bufferbloat in the usbnet driver.
> >>
> >> In the current implementation, usbnet uses a fixed tx_qlen of:
> >>
> >> USB2: 60 * 1518 bytes =3D 91.08 KB
> >> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
> >>
> >> Such large transmit queues can be problematic, especially for cellular
> >> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
> >> fully occupied USB3 transmit queue results in:
> >>
> >> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
> >>
> >> of additional latency.
> >
> > Doesn't 5G need to push more packets to the driver to get good aggregat=
ion ?
> >
>
> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
> aggregate enough packets for a frame but not of several hundred ms as
> calculated in my example. And yes, there are situations where 5G,
> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
> required. But the dynamic queue limit approach of BQL should be well
> suited for these varying speeds.
>

out of curiosity, related to the test with 5G Quectel, did you test
enabling aggregation through QMAP (kernel module rmnet) or simply
qmi_wwan raw_ip ?

Regards,
Daniele

> >>
> >> To address this issue, this patch introduces support for
> >> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
> >> limits the amount of data queued in the driver, effectively reducing
> >> latency without impacting throughput.
> >> This implementation was successfully tested on several devices as
> >> described in the commit.
> >>
> >>
> >>
> >> Future work
> >>
> >> Due to offloading, TCP often produces SKBs up to 64 KB in size.
> >
> > Only for rates > 500 Mbit. After BQL, we had many more improvements in
> > the stack.
> > https://lwn.net/Articles/564978/
> >
> >
>
> I also saw these large SKBs, for example, for my USB2 Android tethering,
> which advertises a network speed of < 500 Mbit/s.
> I saw these large SKBs by looking at the file:
>
> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
>
> For UDP-only traffic, inflight always maxed out at MTU size.
>
> Thank you for your replies!
>
> >> To
> >> further decrease buffer bloat, I tried to disable TSO, GSO and LRO but=
 it
> >> did not have the intended effect in my tests. The only dirty workaroun=
d I
> >> found so far was to call netif_stop_queue() whenever BQL sets
> >> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue wou=
ld
> >> be desirable.
> >>
> >> I also plan to publish a scientific paper on this topic in the near
> >> future.
> >>
> >> Thanks,
> >> Simon
> >>
> >> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-b=
iography-61adc5730b83
> >> [2] https://lwn.net/Articles/469652/
> >>
> >> Simon Schippers (1):
> >>   usbnet: Add support for Byte Queue Limits (BQL)
> >>
> >>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> --
> >> 2.43.0
> >>
>

