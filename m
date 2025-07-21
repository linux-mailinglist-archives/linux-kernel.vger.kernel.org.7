Return-Path: <linux-kernel+bounces-739825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADAB0CB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EFB3AF1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF223A9AA;
	Mon, 21 Jul 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cb8wpCL6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EA1A23B5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129007; cv=none; b=YUqMiALHh3/vehYmGfQTeeHMevXJQjR5KSWU9ZTdW629f53Q/TA8JXGBbIZRb5zeePAvnnQpml3NurRm1jIvq9rzFYeag8ke9qJll62DZRk+UE0ZAfrWCNrdWEdPh8WFMCGQQC+umRtR3+MRMq8IwFMTJcVZrtxe+bgF4wManxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129007; c=relaxed/simple;
	bh=6TDKShXcONz3NcwGsZb8SaxSJAbRNtMv2L+xwChhNT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSnjLj54Plj/haUMsWxAgoc24A7X+6WV7Z66I4l6jX8kjOE/6K5uBLQ/25kpzB+v2YyHBZWPWnPtJr/KZggNCRtFtL/L5lunWQRgsg6kOTPAelLBbazkFd58lsd4OJ/xvLXQhV6sXEhuXaDB5Uh8Bh7nY1KyzvPXQWuscF3zgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cb8wpCL6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dea2e01e4so54938435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753129005; x=1753733805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgpqx2m845uLW+JeBVNSuYCmRgFn5O1Bzp6CJmeS42g=;
        b=cb8wpCL6u41/lB4TZMQKmFnZUkDHsSYq0woNKyHVZOzirEncX6D0hvA1paONWZaJYL
         5PO5AxQmoWFki18dmmgR4cp+MLMGXIZtiAhBA3or83oFwJgO+fFWpqDt9w2QZAdd7w/d
         xwYZ8SSGUyZWlw7On5sjLvZ81dB8S3WJVOeX5WAIchdgaj55FyuCndmFOvn2O3i9/JST
         X1yNfHOONCgM0vubYQMiPgwwKFUTwKmgnl+e2VLDTehm+U7FAV+6AMMDRoLqCCMxdO4A
         /mieME2yo9FSlBBx8nDcR1d1sHLcl8LT51ib3eldbXVWqw6Cna8ZTmlM7m24Bj1VPiW9
         NrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129005; x=1753733805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgpqx2m845uLW+JeBVNSuYCmRgFn5O1Bzp6CJmeS42g=;
        b=il9/uSYn1s2OlTQHiLjqZoRKH+tPxj2ay5HrY1pTysTCMwzzWnOQQ9cvxMnXjZ2/6t
         kZ7/uF84AfXfVUCU69fXfSGGKJdR/wtAn8Ch573U22KKJoxbfimuKaRQ1RpXQWnYFw2G
         sg5BE005Yc+/YL2CBMjgxVJKAmAPLN/rqAzOwRzBnQ4G2CrxCp9HUd8XshwPch5osRm9
         UQvIjK9Dkkkxg1qmFe2CS5/8f49/kPPAJLeE16yMO/ARBXF4KV5KNfPBQPUGvsEZsyzG
         wtJwZGcNW/lf+7ZwMhdmdvUBlu4mx7AQgBmt4LEJySrf1p9ehMEjrzbVEYhpM1m9qSAV
         ptdw==
X-Forwarded-Encrypted: i=1; AJvYcCWct1oRdBW8Ky9lClajXrrXyNDKPlPLp2McY1/H5Q0Lupd0m0ONo8ogpt/HlZRHXsPscSRJ7RR/M5FY9Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3V+/48rRduZpUG15TDaPWZi09NIbWWHEtZMcGz7r0vCFEH87Z
	3VsZCPiUCJpaBYnOSZuVKEPhScMTHszzOX58X09IouvcgEYraVWwTpBrT2mERby7Ucg+Wmnt45Y
	5CnX5NvrhYPsxZFGapbXEBnGiKMe94rQ=
X-Gm-Gg: ASbGncuXbsew5JxHHbW8O59DgKTbIbAB/AKyOLLw+Anun7wx40CzLeGKCR0YCzeJC0S
	bNRS9lW6hUO+s9EeC4Mgyeja+l7NEJNep9+dKfraYO7l62bg4AhRTsEo+iSaJ0KHU9yjFs5PgH9
	jTTOglT7ifMe3slziP6IOasgf/AZgTD7E9mHOaXc3c1u1ni7jvHiB94RWQuWSVnbsEnuqMTMKqB
	RSvC51qmwBH9NWT0Vb3gg==
X-Google-Smtp-Source: AGHT+IEhqRr7CdR9k19OYUc7jR748HGVgZNXD2c2iGAiOAD8tt2Y5vTG48a6wynS3HB30PHpt1YoNuo+jd0SaVpgE2s=
X-Received: by 2002:a17:902:e0d4:b0:23f:8bcc:e4f3 with SMTP id
 d9443c01a7336-23f8bcce86emr2555465ad.32.1753129005382; Mon, 21 Jul 2025
 13:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com>
 <CAFBinCDyjf7MOE6f_AGEEwqV8z68qRv6JAUxn7zt5ZZqwFLkPg@mail.gmail.com> <7fbd3743-cfda-4877-888d-bdeb28d4972f@amlogic.com>
In-Reply-To: <7fbd3743-cfda-4877-888d-bdeb28d4972f@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 21 Jul 2025 22:16:34 +0200
X-Gm-Features: Ac12FXwjzjGUO3kzYO-EgF4dY1ZYcLeDPum6VbXKfiPgtZh-GpYns-HcHy-gvj8
Message-ID: <CAFBinCBdCiNKWoXrL0tw1+_0BL_9XyYfuqQrRNePyzmUh=PX3Q@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: clk-measure: Optimize measurement accuracy
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 8:14=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com> w=
rote:
>
> hi Marti:
>
>
> On 7/17/2025 11:43 PM, Martin Blumenstingl wrote:
> > [ EXTERNAL EMAIL ]
> >
> > Hello,
> >
> > thank you for this patch!
> >
> > On Thu, Jul 17, 2025 at 5:08=E2=80=AFAM Chuan Liu via B4 Relay
> > <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> >> From: Chuan Liu <chuan.liu@amlogic.com>
> >>
> >> The cycle count register has a 20-bit effective width, but the driver
> >> only utilizes 16 bits. This reduces the sampling window when measuring
> >> high-frequency clocks, resulting in (slightly) degraded measurement
> >> accuracy.
> > I checked the Meson8 downstream code [0] and it uses 0x000FFFFF to
> > mask the register value -> this means that old SoCs also have a 20-bit
> > wide width.
> >
> > [...]
> >> Here are the test comparisons based on C3:
> > [...]
> >> Here are the test comparisons based on C3:
> > I have tested this patch with Meson8b based Odroid-C1:
> > pre-optimization:
> > # time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v " =
 0  "
> >    clock                     rate    precision
> > ---------------------------------------------
> >   clk81                 159372396    +/-5208Hz
> >   a9_clk_div16           24000000    +/-3125Hz
> >   rtc_osc_clk_out           31250    +/-3125Hz
> >   hdmi_ch0_tmds         146399038    +/-4807Hz
> >   sar_adc                 1140625    +/-3125Hz
> >   sdhc_rx                94443750    +/-3125Hz
> >   sdhc_sd                94443750    +/-3125Hz
> >   pwm_d                 849921875    +/-31250Hz
> >   pwm_c                 849921875    +/-31250Hz
> >
> > real    0m0.102s
> > user    0m0.005s
> > sys     0m0.069s
> >
> >
> > post-optimization:
> > # time cat /sys/kernel/debug/meson-clk-msr/measure_summary | grep -v " =
 0  "
> >    clock                     rate    precision
> > ---------------------------------------------
> >   clk81                 159373438    +/-1562Hz
> >   a9_clk_div16           12000000    +/-1562Hz
> >   rtc_osc_clk_out           32813    +/-1562Hz
> >   hdmi_ch0_tmds         146398438    +/-1562Hz
> >   sar_adc                 1143750    +/-1562Hz
> >   sdhc_rx                94443750    +/-1562Hz
> >   sdhc_sd                94443750    +/-1562Hz
> >   pwm_d                 849992188    +/-1562Hz
> >   pwm_c                 849992188    +/-1562Hz
> >
> > real    0m0.173s
> > user    0m0.008s
> > sys     0m0.109s
> >
> > So there's also an improvement in accuracy. The only downside I'm
> > seeing is that it takes 75% extra time for the measurement. For me
> > this is irrelevant since we use this for debugging.
> >
> > [...]
> >> +       /*
> >> +        * HACK: The input clock signal path from gate (Controlled by =
MSR_RUN)
> >> +        * to internal sampling circuit in clk-measure has a propagati=
on delay
> >> +        * requirement: 24 clock cycles must elapse after mux selectio=
n before
> >> +        * sampling.
> >> +        *
> >> +        * For a 30kHz measurement clock, this translates to an 800=CE=
=BCs delay:
> >> +        * 800us =3D 24 / 30000Hz.
> >> +        */
> >> +       fsleep(800);
> > What is needed to make this not a HACK anymore? Is there a register
> > that we can poll for the number of clock cycles that have passed?
>
>
> The required delay duration is frequency-dependent on the measurement
> clock source. The current 800=CE=BCs delay is calculated based on a
> minimum input clock frequency of 30kHz. At higher input frequencies,
> this delay could be proportionally reduced. Applying a uniform 800=CE=BCs
> delay therefore appears overly conservative for general use cases.
>
>
> The IP currently lacks a status register to detect whether the input
> clock signal has successfully propagated to the internal measurement
> circuitry.
>
>
> The design of this IP has been maintained for many years. From a
> hardware design perspective, there is room for optimization in this
> signal propagation delay. Future IP updates may not require such a
> long delay.
Thanks for the detailed description. To me this doesn't seem like a
"hack" then, it's just something that's needed to interface with the
hardware correctly.
My suggestion is to replace the word "HACK" with "NOTE".

What do you think?


Best regards,
Martin

