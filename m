Return-Path: <linux-kernel+bounces-866107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86021BFEE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607593A6F58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41092AD0D;
	Thu, 23 Oct 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkUoTsaJ"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BF1E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761185460; cv=none; b=F7QcQUy2SuMwM+lMTtSUuzCGLbBzdsxE5faBpDAvODIq3BHb0j8Yv70oBiem1jbsft9WADajnPkQvmYoo39JptOcfkDtwZnJ8fPX166v4bK4VfGt0o/pLZ3IAjUeAw2E78jY1cQGYl1wmYxD98MImwilIJjF+56Sxc9GNkLipOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761185460; c=relaxed/simple;
	bh=LK/MCU545iyIlJWNJBzuC2+l7bxB3Gjk5BZcNhGZT8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwlAuOjCMWzzb+YVE12o62GEYQLF50SQqNg5lG1qao5JA2XT8sufSxZcLdC2bUx7bBKeTd79pdxZhYKeMOFnXrfKU76WtSPaSANTZ0vDfr+7PMxKL0NetZGfJZgL6SoaskpQLR+UJnwC8Jgw1dwa6r1HCON6IOLdhe8bX0DCWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkUoTsaJ; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3307de086d8so302254a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761185458; x=1761790258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQXqtV/1uWQfXNewiRPXkUhRGITyK5eGr00S9JX7C5g=;
        b=dkUoTsaJp29Fc5639V+e+Fgu9ZJGD1dyn7MxQrj6sJjFGEM1xifjpnRqPozZf1R+NV
         fAKiwjH7ra4wmQaTFzhLiuB1v9gkSNXCSmJXjB+JcUsTUTEaf9mBaBgI9bqAI4N+PZTg
         eftCfzhO6t+NfejE4soQNgAj74o8uJIlU0hpl+L1X1rqm0EJBQBPhbE9lFdcsXPtduq9
         h2RayMWVaK3FJl0obUj1R88Gp3v/4VoLFVoc+I0so7/STO/MDD5Y72W//ukuaBoRv48i
         vI3QV8j8+8hzzdMMSlbWVKaoM7co1ksujhx9GG1G7WvIve96pcltvg+o7hYxipNXmdKB
         yJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761185458; x=1761790258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQXqtV/1uWQfXNewiRPXkUhRGITyK5eGr00S9JX7C5g=;
        b=M5aiMGvYdR3oVx8Qbmmh6VQGg5bdGfbVJnZOnXrqD7/BdXAuEYq9etaOWDu+AwX7WM
         M+81m2U6jXT3GN2jiZdTffTO7G6OWAzUiAcSVnOgR0EEXxqnTdn16OwJwEbpmQbYF17a
         r1M2q0Q+WECcjADAgN8blp2pec96FrIJmLwTXp9DDSGmxqeS5GJk3+dtchvRgziVNztO
         VFAw+mj/Fb/hS39abV2BCDcyLXrhQANjSAdkfVX7YkyRRKxaxAKO/ACP4bXfPX/TnwUU
         oZcjn3kRhh0qpuZhcTVY1uutZ5FZKfprx4e6SM4A1o4tHU3yOjfSDRCKzrZUGD0Oncez
         Ktww==
X-Forwarded-Encrypted: i=1; AJvYcCWIZwYBBpQr76UId1n/2xdt+kr77kx16AN4ePY+pBRqUnqdMTZORj/3bR2RmaAUgnEP2gtltrHpwuJCQ+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVS4s5SmEognwe6L1d4kF6v/Z+QMmkTi/+Z6HDauiRD4zNmW0
	dS0e0ehDlFW6xa75Xdlz9YR13BeTyZsEfimsd8uiMsNVLHClgLb3pRBKAsX62Z4MaPSXI7QT4MO
	gRGtwqUZ78ZgEn4N4KauMHe9NMqqYurg=
X-Gm-Gg: ASbGncsCMa/qqdrn7Y5boB2jHa5pcbMVYAAZGSWqEYr7vMF+0JTsDJTn4n6mLlBCxah
	N+wLFFG78ye54/NcEux6iKkMiACIZzBw9/09+kuaG3x00PpOlKw2oCb7eQFv1WSl6+SoyqNwLJ6
	gTp8Cv7b/IAfdmy5pjsG4LShjLjgj1AJNyl6NJQqIPsW16cxv02KwNWMYftwKZkUpNu+ik1deeA
	JIJl6PrJlutitB7u8iw5IZcDp33ZDccCOBEz3muWGTYIe4e2bDKnpToy3ji+A==
X-Google-Smtp-Source: AGHT+IH0vgBI91tHVmBwxye51nmDErzeihIRXQW2MwwIIZ/u/A9ulgOV+5Q8k6m6BkEHOHQMF8a53huNM7TMY2ohlXs=
X-Received: by 2002:a17:90b:5386:b0:329:cb75:fef2 with SMTP id
 98e67ed59e1d1-33bcf85b45amr24269278a91.3.1761185457572; Wed, 22 Oct 2025
 19:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com> <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
In-Reply-To: <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Thu, 23 Oct 2025 10:10:46 +0800
X-Gm-Features: AS18NWDwNTU8arpSWNZRlcaFyHSGcyZrjd-l2OixTO1dXJxN-NI627aQSmAOdvo
Message-ID: <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Cixi Geng <cixi.geng@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:55=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> > for either uart or source clock, we should propagate the
> > error instead of just warning and continuing with NULL clocks.
> >
> > Currently the driver only emits a warning when clock acquisition
> > fails and proceeds with NULL clock pointers. This can lead to
> > issues later when the clocks are actually needed. More importantly,
> > when the clock provider is not ready yet and returns -EPROBE_DEFER,
> > we should return this error to allow deferred probing.
> >
> > This change adds explicit checks for -EPROBE_DEFER after both:
> > 1. devm_clk_get(uport->dev, uart)
> > 2. devm_clk_get(uport->dev, source)
> >
> > When -EPROBE_DEFER is encountered, the function now returns
> > -EPROBE_DEFER to let the driver framework retry probing
> > later when the clock dependencies are resolved.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 8c9366321f8e..092755f35683 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *uport)
> >
> >         clk_uart =3D devm_clk_get(uport->dev, "uart");
> >         if (IS_ERR(clk_uart)) {
> > +               if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > +                       return -EPROBE_DEFER;
> > +
>
> You are making this clock mandatory, sprd_serial driver could work as
> serial ports for logs output without this "uart" clock.

Hi chunyan:
   Thank you very much for your review.
   This clock is actually mandatory now=EF=BC=8Csome SPRD project use defau=
lt 26M clock,
   some new SPRD project use default 24M clock.  If driver can't parse
this clock correctly,
   driver will configure wrong baudrate and make the log garbled.

Thanks

>
> >                 dev_warn(uport->dev, "uart%d can't get uart clock\n",
> >                          uport->line);
> >                 clk_uart =3D NULL;
> > @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *uport)
> >
> >         clk_parent =3D devm_clk_get(uport->dev, "source");
> >         if (IS_ERR(clk_parent)) {
> > +               if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > +                       return -EPROBE_DEFER;
> > +
> >                 dev_warn(uport->dev, "uart%d can't get source clock\n",
> >                          uport->line);
> >                 clk_parent =3D NULL;
> > --
> > 2.34.1
> >

