Return-Path: <linux-kernel+bounces-828756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F8B95623
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9BF1901334
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E628A3EF;
	Tue, 23 Sep 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb098zEg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F1258EFF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621932; cv=none; b=GarTJcV7ZyVAuSjPiQP4+sS4I2qo097H3P7JsaEemZNVvmlvo36vpH1eAQ94nsjNenZHBck2i3KEt9qt+LB+4l63hCwSLNP0oy0VxL4edhOQMv5P1dwUCJNP4yAby49mtUH7dcmb7edQ+d3BntkAwDorjV1WX87+j/XYvD4dJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621932; c=relaxed/simple;
	bh=seZKVt+CB+k7Mas/mFiiVxa4+/v/4YNrXuxIJTyDwm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7Yd6wggVpYo2j5qcFQj+nXtJTuJAZJu5siF37SQA9/A5Wni570PRpZoxezrbnIoEfTdlBGulYl5TV6tb3oyOIB5JFkL+6s+ZME36hW9EI4lEa29oxFGvyBjIUDKZPMLDpzzYMWWPa0jbK2WPnluPM9onueUmsSqCRhD9ZVAEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb098zEg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3019630f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758621928; x=1759226728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Xs+So4MvDnUaVFG+Q6oG/T6yZ5oFXdVTaeJcgoYjs=;
        b=eb098zEg9hMWFVDPenA2juV6hBsABv+UljqGJHn5D9dQNXpGJDor8E4pVnylwrz6At
         r0zCnvALrmTS7gPr7PgoZmtmz2mXawtExEkEGQGMpmdNSfwOdPI5pkLeC5qEoMid6vbg
         B4ljFdejXQVerRouWgydg6Mif9AjijfXpr1G802mfaaBzKq3iSTF0mQ6rNmenqC2R8lr
         bGFqS7NP/OW/4DXR8zMp4WEFDiQWqhIBCUtAZ8V834JrF4325nN4kKzLJIFf8AkCz/WO
         1lZR6clhj7w0Nu0/3DOUsk/TcWgv7ojk0jMbpeWab+cMe27Q42R2Pw9LfBWJodXnHSAb
         pv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621928; x=1759226728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7Xs+So4MvDnUaVFG+Q6oG/T6yZ5oFXdVTaeJcgoYjs=;
        b=ZZzexgZcJEiORQWXaGg4q84SD9LA2fIGm+CJjKccXjiLn9ttK9JTU7L5C+Zwn3Km0a
         zQkf1c+Uh69wAPpPX/HHIXGaE0KtEmoJhWfGhCmA3mubfXk78JoIheAEKht9TFNuIIgo
         tGH296yiaeHWyXU7y9eobJl4ffgUepNGE7TIu2GST0N9rSSrqfjBMnCeRpFNdL1UOWs4
         eTySTrV7d7C5cMY1l9IfhUGwQAUDUZCiOYlGf8GyYOo25B3OYiTiG/qc3v/he/Emby4u
         ajboXad6+gR8VmVuKaMVo9GnsqndDZhY5bVeQzpIT4Ly26i+ATmgnOndeb5wyIOYj4SE
         Ywzw==
X-Forwarded-Encrypted: i=1; AJvYcCWBKsKSC/0qx+ViqADOJyTEFoV/YwwIWbGAC3OAhy6SQT+sl3COdoaCR9G/pLE64IlXWfDCO1/gvnbZ4n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yLhRD2tY/KFKJC0z0qfBqhotFumJeQgi7Fm6M88dUm2I2Qhi
	43ccNtcnYjCjGPn3mgSBwXDTL4ygGwQ6nbs3GKQd9qmcwkYds+Z9nxxIQgEeko0AP93c/H8wsBG
	HY98cl21YwWRPjSGsWXIJvr2UfqR6hlk=
X-Gm-Gg: ASbGncvgRSyUT0u6w/jhC1s3nrUiqkLhjFd3VZwimQmaCJb0Ds49LF+NtkwxHQzuyCO
	gH2W6lxKCHV2BaiLiSWzNtkwrpKFVPzSWkX15D4ukemcfJ8AXIfjQbo2MSZE1galELnFDX1muwa
	RD9w883O4fppLqLh4kjPlRSr44alh+S8EOYXtN82oOkPL51Fu8lgviR2YdNYI7t+D4fHf2+4d1b
	NbW1HQs
X-Google-Smtp-Source: AGHT+IEmfUOWv3qbc8Ohx4AaGaG7HewCyVbyN4002SXkqm3XHR6/YgMnu50wP/YGQJQxCgT0YYdAXH6LHlAhjgjNMsk=
X-Received: by 2002:a05:6000:1789:b0:3fe:34ec:2fab with SMTP id
 ffacd0b85a97d-405cb3e61a9mr1619335f8f.63.1758621928300; Tue, 23 Sep 2025
 03:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923092846.74517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2025092311-espresso-collector-5f4d@gregkh> <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
In-Reply-To: <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Sep 2025 11:05:01 +0100
X-Gm-Features: AS18NWCi66XhZ5MUL-jzRAWBA37LuUHnLVXt5X9xQycFYilsn6M_AddZZJIo5qk
Message-ID: <CA+V-a8uhrOZSXih7ays+0nTJ_gPOAs7sn5=cUkpvwZR3c7EQHA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Add missing header guard
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Sep 23, 2025 at 10:59=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Greg,
>
> On Tue, 23 Sept 2025 at 11:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Sep 23, 2025 at 10:28:46AM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add header guard to sh-sci.h to prevent multiple inclusions of the
> > > header file.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > >  drivers/tty/serial/sh-sci.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.=
h
> > > index 951681aba586..22f877e2a17e 100644
> > > --- a/drivers/tty/serial/sh-sci.h
> >
> > Why is this a .h file at all?  It's so small, why not just put it all i=
n
> > the .c file and then there's no need for it anymore.
>
> Until commit e76fe57447e88916 ("sh: Remove old early serial console code
> V2") in v2.6.33, it was also included by arch/sh/kernel/early_printk.c.
> Those days are long gone, so the time has come for assimilation...
>
You beat me. I was about to ask if you are OK moving this to `sh-sci.c`.

I'll drop this patch and merge the sh-sci.h header into sh-sci.c.

Cheers,
Prabhakar

