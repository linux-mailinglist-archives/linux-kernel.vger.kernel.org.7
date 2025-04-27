Return-Path: <linux-kernel+bounces-622068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CABFA9E2AA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE653B296F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43B201113;
	Sun, 27 Apr 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fqOsPg0I"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78F2459C5
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745752689; cv=none; b=MnM04f9d+3X++nt1g8solIML+1TT/+h2ywZJXWifrPeruysjb2YqAxb3SZ1fvedLUHy8iQh1zZxcxY8MpzDnLH8TWawPJtbU+dTVx4Lj2hOEFq9TFR2GOlvg+QxPuOtu7Yjl/0YJt4UF4ATtnqfFN1uNrZRu1RXoH3ygI6IvCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745752689; c=relaxed/simple;
	bh=eHhA5tnc+faC6C/bJ5+HpYMF0LeEZc76OZByQLRSITo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDanLKuqyOfgmm0YE3uL4ENKOfh3fWpGM4JQGEzZyCwpDWYf+rHuBkmqGaK5QbaBHO5kUFKpLjTv4sd8/FwmKHUuhL4pjR2A60H8AK7XU/PZm+r76F/20foaBp+1FR29hOyScCaf/3zKgVGMhl8p/M3u4cFfCNdBep5dxCLXBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fqOsPg0I; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6065803ef35so314170eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745752685; x=1746357485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MprAgNPWqGJ7CHG6RWipvBG6sPPJFir2MiaXJK5t8Ec=;
        b=fqOsPg0I4lQ79ZaRg24VyPvNY0jGQTTbU6hXTXNbV+ronr+PTDnzedtLIOwtr2deEt
         Z98wS56l55KV2hOFskhlXMZX7rumRG0/DCo5tQTLntiBZmW2czemNXlZG6+3lXodl6IZ
         VMC1juWXjoCiZ2+TFZ7eZsafxZ1+Vj9dbuQDBYAr1Ndl8Sz5GDZ/kiDEMf7+hfZuiK0I
         NoNzwgBedILUiPtvhhKfgvlddWZPbRGRMXF25psugvbJDMnFLHrpQxPOM4elkUJi1TKP
         KKYbUDL/hZme99Qc+GUQb56WklF4JG9eIEk58xa1wlWX9eWmkiB2v3LnPg+YJd3LEHnQ
         fFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745752685; x=1746357485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MprAgNPWqGJ7CHG6RWipvBG6sPPJFir2MiaXJK5t8Ec=;
        b=JLZkYf2/8FlWp/+5g/WTZXIz4y2CAtMkttF8obFRT9asRSVkfMx0R3q5H72+yTAkMS
         WYaPFXrmBM69jYlSr6RoPVVFWhvwTcOri3V+x5p4r2hL1Jg7TxdBnXagWhiy1SDyoeOA
         CY0aJullwUXlksU7q24LxweecUNGPaCduZ/3zDl+Ad3NRdHXFrs/GpG/0nGIcLOz5xwI
         l4V2cjuDoyibeZ3+XpsLZDIJJ2/JDHoVmiFNkjNrG+KnJfzhcrTjysi5Qs60Xc9bqvL8
         aj40CeQZdIXAg90+JUadUOD6AxqP9Gp9Z8r7NETmD1WC8Zirf+dMjC3PpQ88hlqiIqhT
         alTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW04L1yLQtlHa95AYhAlkYR45mhRrYVv+rcxS5l5+VOaMO0LMRGVngj/4i/KVSmeal6W9051KlZ5EkPaI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6K4wDfrlnA8OTVFBAgZ1nGhNg+SBFzUuVrbrpsY0sDHY3Ogw
	mxmHyZ8vq5tkTLq2xE2fkAHECM/OCi+6eHmk2JEskP8ZmtVbKkdn7orNPVJkEnahl+JLB+31GqD
	UVXEYUv9y7Y0oOYZiEBiXFlAR5pTIdjFEMaLyCQ==
X-Gm-Gg: ASbGnctQj9UIGp4cbQYv9Igd/f6c/0KA7E0B1hbUWVT7rGGuCBgzacoOAxxmZdYT57q
	9eKPlQqOFyTpYyhay88TghHXUDgQ0tpy4i+AzHVbfe3YIhm+xLk2Fogv4JI4UQSLVBlVQAJ+Elc
	1u7yR+Bj//ziLDfOmLOAe7oFga6RCbk6zViWz9Hos=
X-Google-Smtp-Source: AGHT+IG8fZxwzHNuZuL5P2Cv7KAs0gI3eNFTOYs+RhBLwnkpjnoQB1qDpHKnfQqP0F4gpRdFEEwyCpU317ouvssDGqY=
X-Received: by 2002:a05:6820:c83:b0:604:9c9b:d096 with SMTP id
 006d021491bc7-60658f242e1mr3557749eaf.4.1745752685422; Sun, 27 Apr 2025
 04:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
 <20250425062425.68761-4-cuiyunhui@bytedance.com> <57d75d55-81e3-445f-a705-e8c116281515@kernel.org>
 <9d4e7002-48fe-4fa0-8e23-7c2160419910@kernel.org>
In-Reply-To: <9d4e7002-48fe-4fa0-8e23-7c2160419910@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 27 Apr 2025 19:17:53 +0800
X-Gm-Features: ATxdqUGrND2eWKgTBQAFuWZ7ZU2WztQbLWkJMVgxrAn4tCVQU7wPRICwW2BvD3A
Message-ID: <CAEEQ3w=MOSU2mNo8qq8qz9KE9M0Zb55xeS9aw1263osXtP+8SA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: Jiri Slaby <jirislaby@kernel.org>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi js,


On Fri, Apr 25, 2025 at 2:43=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 25. 04. 25, 8:41, Jiri Slaby wrote:
> > On 25. 04. 25, 8:24, Yunhui Cui wrote:
> >> In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO
> >> before reading UART_RX when UART_LSR_DR is not set.
> >>
> >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from
> >> bogus rx timeout interrupt")
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> ---
> >>   drivers/tty/serial/8250/8250_dw.c | 13 ++++++++++++-
> >>   1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/
> >> serial/8250/8250_dw.c
> >> index 07f9be074b4b..1e364280a108 100644
> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> @@ -273,6 +273,7 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>       unsigned int quirks =3D d->pdata->quirks;
> >>       unsigned int status;
> >>       unsigned long flags;
> >> +    unsigned char old_fcr;
> >
> > No more unsigned char, please. Use u8.
> >
> >> @@ -288,9 +289,19 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>           uart_port_lock_irqsave(p, &flags);
> >>           status =3D serial_lsr_in(up);
> >> -        if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >> +        if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >> +            /* To avoid PSLVERR, disable the FIFO first. */
> >> +            if (up->fcr & UART_FCR_ENABLE_FIFO) {
> >> +                old_fcr =3D serial_in(up, UART_FCR);
>
> Wait, read(FCR) actually means read(IIR). FCR is write only. Or is DW
> special in this?

Indeed, the valid bits of the FCR are write-only. It seems that here
we can only do serial_out(up, UART_FCR, up->fcr); What do you think?

>
> >> +                serial_out(up, UART_FCR, old_fcr & ~1);
> >
> > s/1/UART_FCR_ENABLE_FIFO/
> >
> >> +            }
> >> +
> >>               (void) p->serial_in(p, UART_RX);
> >> +            if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> +                serial_out(up, UART_FCR, old_fcr);
> >> +        }
> >> +
> >>           uart_port_unlock_irqrestore(p, flags);
> >>       }
> >
> >
>
> --
> js
> suse labs
>

Thanks,
Yunhui

