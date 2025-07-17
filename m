Return-Path: <linux-kernel+bounces-735243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CEAB08CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A41A1631C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D427B4FA;
	Thu, 17 Jul 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HbrbVzTo"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86929ACF3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754801; cv=none; b=FGYItBbOyPD/zIAJqjtOg7jK7tPUqh1bdgELIpjESCAWQbE+UM883T6BB5ViZRS09J0YdOujaZu8HUNdttLG2mSa7pzDK0P02jVHaUPOb0RPttD4uJnIXXTTatoRF2v1c4WgEE8wRpwYlVaQvrAMHSLnByNT8UBwrNJf/LyUBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754801; c=relaxed/simple;
	bh=9BstoysraPcNdXHc1n0mia/3lc0Re5lG7hJE8+pelyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llFcXlSh9OqZLE0xK8oDg6e19Uw0qRFQhFMvdNIXYzAg7krSV71frpOnXT7E2IZM9LCaOuXxblyhnNdA8VFoy3EtGUntLD8Ohmbskvpjdgn6y9jhK78YAIPi6Rks6ORAcyXcNXNiQCgtJIk7n076biQqNz/KnznW8v/j5E0Purw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HbrbVzTo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-40a4de1753fso554235b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752754799; x=1753359599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/4/2GlFbqg9HLiAULIFmkWsYiTvbSro9cghjbjmQBg=;
        b=HbrbVzToAmyaAKLqriCpirFkAhW86rX5D9S6irC1xCmkWyVJJnDu5GEKi8nG3J6EO6
         UBPjpPWIZNhklZVgLI6pVdoO+3y3de8Qhi/OFrtc3xVVNFAX9Fo3GdrjAAqM/KxPQzK/
         qANvAcF90Rbk/1cjiEEJywVd2haeLn/8xaBFm5no1jCLA+zcDpYcGz3xpfFIY41Z803U
         5kEcDVpUldCibmnggSIJJEkfvmsdFQI+X9BHqIafDIS9Eru/mFbXllHjclll2Mns6TUZ
         un9PwlUWbh4/YzDCclyn4V9WhIQFmPaZR/2KxmLnKoMpa91C6K44kRCy+/VL4y/Np6iP
         SmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754799; x=1753359599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/4/2GlFbqg9HLiAULIFmkWsYiTvbSro9cghjbjmQBg=;
        b=qbMdgy+WADQNFh0I6kFfq3FKHBn0ovvkZHqhPQCgZ4/OrAjCdmKA1nYcd+QGkqHWWt
         cD4zhEWRbPTot11ZGM4G88KpDXHgB9vqzZBUpPde70RHNcxz45kv4BIzEUn9hi8rqiFR
         uH3j5CO/kuFS6q9Vxpaw0kL/A0z96a81dPJ/qegf6ycoOdq2NDYj0HMjV1ImFav6ag6H
         pPtFQOiG7S/fEeAHiO54WEAncGlBHPPf4jVXNy0Qjd5ypVyqqBWloEWgrA3UvxkpFzDK
         93EV1/TxO8r932oLEHA7PkPCIUJygtLEGHpUbsWuAeYDo+tnyMczsQtY0P9l8apD6egy
         5peg==
X-Forwarded-Encrypted: i=1; AJvYcCXgdp2XDSIM5taJHnZ5llDrhtOSLydg0+9LozafS01cjyuQC6xer0RLPYhFnfcdUrjhFA7Sya8/sQohOhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgDs5ZdPnDYolWniUI9t5qFOdbux953LwV08dBk3RVLhNPb/Z
	aWCVYbzuUCAEwqjc1MNr+w7PDtTH6/yQcZvK1+aVMS1o+q1cQVUe//C00HMH/GuEmVgTtxcqaWe
	Z8tMZz4SaRdSBoLn0KvhK1bJfCPf5T5U/Q2ozc+pvLw==
X-Gm-Gg: ASbGncv+kdQpJRWu5M5393UvR2B+3RQJPgxeLkKRpRttqmPJVMIW2UXMSbbBIHY70s4
	vDq70KjcgIuv0NspfDrSLTwPu0eVIdiG7t5aCKGwy//dCQz0ZtdcNlh8wauqzePSotehBvncQqu
	wP48L42vJlqPZgA+TYPh4IgGf/Fkz8rA+8XqhNaHLN4TYCiViGRxmTOjrfgFRVksyLqBb2R27Ta
	bl19ZSaHH55Mp1yyjd08phF7fdN6wI=
X-Google-Smtp-Source: AGHT+IFuE6XD5lTWOXSNH1CM5vjssmv3cQEWKz8QIIOs4ZSd6cXO1A9SSlaFR0OA4UQ7x1Dn9lJKAZEfBfctdkacNn8=
X-Received: by 2002:a05:6808:4f5f:b0:3fe:aebe:dde7 with SMTP id
 5614622812f47-41e2dcc2f2emr2171185b6e.2.1752754799043; Thu, 17 Jul 2025
 05:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-2-cuiyunhui@bytedance.com> <84bjqik6ch.fsf@jogness.linutronix.de>
In-Reply-To: <84bjqik6ch.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 17 Jul 2025 20:19:48 +0800
X-Gm-Features: Ac12FXzX-8_oUrVkjPDnBHqZHa66JwCymGHzpPdOgfG20sVHt6vV7FE1XJLHuEU
Message-ID: <CAEEQ3wnBJUjArdfs+vgrsfoQaVJPKD3uwD8hwgg963fUBaNGrA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 1/4] serial: 8250: fix panic due to PSLVERR
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, Jun 20, 2025 at 7:20=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the serial_port_in(port, UART_RX).
> > This satisfies the PSLVERR trigger condition.
> >
> > When another CPU (e.g., using printk()) is accessing the UART (UART
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> > dw8250_force_idle().
> >
> > Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->loc=
k
> > to fix this issue.
> >
> > Panic backtrace:
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > ...
> > [    0.442416] console_on_rootfs+0x26/0x70
> >
> > Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaroun=
d")
> > Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/=
T/
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

In this patchset, patch[4] has been dropped, and patch[2] may still
need discussion. Could you please pick patch[1] and patch[3] first?

Thanks,
Yunhui

