Return-Path: <linux-kernel+bounces-737046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B2B0A6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4FE3AF9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53D2DCBF7;
	Fri, 18 Jul 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFHev97Q"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D342192E5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852055; cv=none; b=iE0BysXbuKMaFXntkBfkcHHLdR3K7fhUCSFkX+1I0W/WN2lTqXGzNe0cONJ2xhZuTd9x2qeIXUSEXNQbL1HUXaxPRLcFxYXDIFugXAbb6yHQUUgFnW527ken2adbet7+FD60iW5hyyLwNao5dOEizAoWaqgiq4pEpq7SoucgqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852055; c=relaxed/simple;
	bh=W22QNFlT9cO0iyVYgql62b8k0K9WDUNp8XceCjFP1bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaAc2USGA2HzahIngiEUglQTLH7w9cDHs0udwVXOYj//Ywq09fXYBBe4EBFaRDLY2TeLvVqqjHHHLQ8Eqs6AJnHrT9TmRkqjMzDG0DJbWo9htYgBN7S/sohVD0odShQGW/IOHHqISSvUHZxTRTKG/hnCwLJxpFjnU0w4+UiKen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CFHev97Q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7494999de5cso1629531b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752852051; x=1753456851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwe3p1qor/XYL1F45tt7pYoZyFpjoxAKetD8WTum46M=;
        b=CFHev97QOeFLYqzvWjBoUcWkIlwGosOk9U2ESBMwNtCPuSAybGZxD3OQ/vWso+nthU
         yOWuSw3pe0RWI/iZfzYWqT6Tch9aMvGtIYDWsp0fL/RKExaxAZwvmLZ4MdgkhUeElqs6
         6O03l1lRtUFCUrdOiU5CAnqnZGeX2GsiFhLxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852051; x=1753456851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwe3p1qor/XYL1F45tt7pYoZyFpjoxAKetD8WTum46M=;
        b=utFYPCqqwJRiHOUh4DW+d8vtTJaxPZbYzyOngNybjUQVh6tzj7Yg1q5O7lu+cQJTma
         IuB21AGPWoxn4CW5PiRgQop8z/LhcfMKd9iuGjoORFUmdJ0MFSMjZ6f3en5N2ftshjmI
         igmckn/XjPxuJibHL6AKIRTuOlIlZ6q8/IQOAPvuxHtEYg1AWhsi98S/oWFn2OholMoW
         LQ61xeP+5ABUmvyxdT3SybBVvb4I4fZGFQwEHL+0OXfGKjGqnN11hb8qFFuUt/GsP4sL
         8pIOjtRfgGsflMHKaMYTOfANUmZo5rFWt6TWoQlLltL77cCT21709rn6alezHdcx/N13
         U0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1HOv22EU/owZmoO0D4lCIG72pL5xjWHBBcskuKuWBU3pDFWb7GuCqKxCZtTlpVTnu7gveYUtAS+2ueEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbKPBdFJrYFGWaQyJ/sf1X3lqTPwlPkaQhGsiV3fBWUvEUEgP
	JiIL6nYL/svDVZMkVmO/hjB5blE1KBnUqqxmTPfD7FNQF8JSdtVMPrYa/8C1vurmOUd6lyOiQut
	0u8U=
X-Gm-Gg: ASbGncvt3vRgGmWEyxKC6MmErXxZA7yRBBGTVeq8fD7sG7WMkec2LmYyE4JMEBRchja
	J8mS79PzTN3OgTDyJxLR0PVnYvhmurCzyYoRuhLQZpY+hn/8CWOd69BZNFfpjabM4UAcVPaJyXA
	fcWprWcb5JVrMCGqftJRshC+RWVtrY8uTQSbEGiWn5njfQEG2zIM7ZyJzipdO2Fu1NXvZfGlm8d
	G/8uzlBeKYP1XRMBAsyk1DUr1whMsa3612zsMAN5vVt48V9LDy+EjhitJWGkxKlSvsfGiOfcbY9
	jVBEEOyQUxoCjwmyDwV672V/laBFgOZFzdaApTH12oxrUqMhKyzAGGon3LmGkS1hNAegXebrX+x
	xDxcGNyXu/i2b+iMFRFnIH00yLFJtNxBxfg+4K5Tpgqzh+cP+LkY=
X-Google-Smtp-Source: AGHT+IG/ENxgBy+2kmdu78shQtNsfUa5P+Q8I1bOo0AFjEFR+7QUkS/92AYj8mRkChCAyuE3vkGqgA==
X-Received: by 2002:a05:6a00:985:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-756e80a82bemr17363043b3a.4.1752852048257;
        Fri, 18 Jul 2025 08:20:48 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb157b49sm1435513b3a.96.2025.07.18.08.20.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 08:20:45 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1589536a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:20:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMYzWcdvvroyAtyKptBycJD5PZpg240xdISCxJOHhFezHxWen1fpaek6zeyqREBXJd+zGK9jxPD3jxEpI=@vger.kernel.org
X-Received: by 2002:a17:90b:50c7:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-31c9e7707e5mr16601949a91.24.1752852044700; Fri, 18 Jul 2025
 08:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-3-cuiyunhui@bytedance.com> <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
 <84cyauq2nc.fsf@jogness.linutronix.de> <CAEEQ3w==dO2i+ZSsRZG0L1S+ccHSJQ-aUa9KE638MwnBM4+Jvw@mail.gmail.com>
 <84ikjqaoqi.fsf@jogness.linutronix.de>
In-Reply-To: <84ikjqaoqi.fsf@jogness.linutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 08:20:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VmYK5PeGXUcbJrnwnhdyfbNJLdRjwhbj7JCN5s-JmTAw@mail.gmail.com>
X-Gm-Features: Ac12FXzOFOb-NbS_iV3QrEjhDiPv2Bc0pKC7N9uN5sAU0uoh5RMhscF-UsJKoOY
Message-ID: <CAD=FV=VmYK5PeGXUcbJrnwnhdyfbNJLdRjwhbj7JCN5s-JmTAw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: John Ogness <john.ogness@linutronix.de>
Cc: yunhui cui <cuiyunhui@bytedance.com>, arnd@arndb.de, 
	andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	jkeeping@inmusicbrands.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, markus.mayer@linaro.org, matt.porter@linaro.org, 
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com, 
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com, tim.kryger@linaro.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 17, 2025 at 7:14=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> Added Douglas Anderson, author of commit 424d79183af0 ("serial: 8250_dw:
> Avoid "too much work" from bogus rx timeout interrupt").
>
> On 2025-07-11, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >> On 2025-06-23, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >> >> The DW UART may trigger the RX_TIMEOUT interrupt without data
> >> >> present and remain stuck in this state indefinitely. The
> >> >> dw8250_handle_irq() function detects this condition by checking
> >> >> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
> >> >> detected, it performs a "dummy read" to recover the DW UART from
> >> >> this state.
> >> >>
> >> >> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
> >> >> while the FIFO is enabled and UART_LSR_DR is not set will generate =
a
> >> >> PSLVERR error, which may lead to a system panic. There are two meth=
ods
> >> >> to prevent PSLVERR: one is to check if UART_LSR_DR is set before re=
ading
> >> >> UART_RX when the FIFO is enabled, and the other is to read UART_RX =
when
> >> >> the FIFO is disabled.
> >> >>
> >> >> Given these two scenarios, the FIFO must be disabled before the
> >> >> "dummy read" operation and re-enabled afterward to maintain normal
> >> >> UART functionality.
> >> >>
> >> >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from b=
ogus rx timeout interrupt")
> >> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> >> Cc: stable@vger.kernel.org
> >> >> ---
> >> >>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
> >> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial=
/8250/8250_dw.c
> >> >> index 1902f29444a1c..082b7fcf251db 100644
> >> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> >> @@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port =
*p)
> >> >>                 uart_port_lock_irqsave(p, &flags);
> >> >>                 status =3D serial_lsr_in(up);
> >> >>
> >> >> -               if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >> >> +               if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >> >> +                       /* To avoid PSLVERR, disable the FIFO first=
. */
> >> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> >> +                               serial_out(up, UART_FCR, 0);
> >> >> +
> >> >>                         serial_port_in(p, UART_RX);
> >> >>
> >> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> >> +                               serial_out(up, UART_FCR, up->fcr);
> >> >> +               }
> >> >> +
> >> >>                 uart_port_unlock_irqrestore(p, flags);
> >> >>         }
> >>
> >> I do not know enough about the hardware. Is a dummy read really the on=
ly
> >> way to exit the RX_TIMEOUT state?
> >>
> >> What if there are bytes in the TX-FIFO. Are they in danger of being
> >> cleared?
> >>
> >> From [0] I see:
> >>
> >> "Writing a "0" to bit 0 will disable the FIFOs, in essence turning the
> >>  UART into 8250 compatibility mode. In effect this also renders the re=
st
> >>  of the settings in this register to become useless. If you write a "0=
"
> >>  here it will also stop the FIFOs from sending or receiving data, so a=
ny
> >>  data that is sent through the serial data port may be scrambled after
> >>  this setting has been changed. It would be recommended to disable FIF=
Os
> >>  only if you are trying to reset the serial communication protocol and
> >>  clearing any working buffers you may have in your application
> >>  software. Some documentation suggests that setting this bit to "0" al=
so
> >>  clears the FIFO buffers, but I would recommend explicit buffer cleari=
ng
> >>  instead using bits 1 and 2."
> >>
> >> Have you performed tests where you fill the TX-FIFO and then
> >> disable/enable the FIFO to see if the TX-bytes survive?
> >
> > Sorry, I haven't conducted relevant tests. The reason I made this
> > modification is that it clearly contradicts the logic of avoiding
> > PSLVERR. Disabling the FIFO can at least prevent the Panic() caused by
> > PSVERR.
>
> I am just wondering if there is some other way to avoid this. But since
> we are talking about a hardware quirk and it is only related to
> suspend/resume, maybe it is acceptable to risk data corruption in this
> case. (?)
>
> I am hoping Douglas can chime in.
>
> John Ogness
>
> >> [0] https://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Program=
ming

I'm not sure I have too much to add here. :( I did the investigation
and wrote the original patch over 8 years ago and I no longer have
access to the hardware where the problem first reproduced. I vaguely
remember the problem, but only because I re-read the commit message I
wrote 8 years ago. :-P

I will say that for the hardware I was working with, it wouldn't have
been the end of the world if there was a tiny bit of UART corruption
around suspend / resume. Of course, nothing about the workaround
specifically checks for suspend/resume, that was just how we were
reproducing problems. If there is ever any other way to get a "RX
timeout with no data" then we'd also potentially cause corruption with
the new patch. Still better than an interrupt storm or a panic,
though...

Not to say that I'm NAKing anything (since I'm a bit of a bystander in
this case), but I wonder if there's anything you could do better?
Ideas, maybe?

1. Could the PSLVERR be ignored in this case?

2. Could we temporarily disable generation of the PSLVERR for this read?

3. Could we detect when PSLVERR_RESP_EN=3D1 and only do the FIFO
disable/enable dance in that case?

-Doug

