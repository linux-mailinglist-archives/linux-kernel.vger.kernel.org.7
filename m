Return-Path: <linux-kernel+bounces-812975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E70B53F11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E33584195
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1612F4A11;
	Thu, 11 Sep 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9f/2pv9"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14B26F2B9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633125; cv=none; b=dLtZSUua2WvB/t0hwq1gi+nFOxsKvFaPoX8A4cj8hGbGZRs0h2Mijx2VOCtSUOBJXRdVeZTXWs1s4uP8fQECWM/QYbWIrkgEua8LqjMuZsq+PtlAoe/yTKaB1W6ACtxNcjPsJvbkH/LQUmgTJtAC4WUJZCuSx8YTMVsRVxL3L/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633125; c=relaxed/simple;
	bh=j8YmKc6LA2mKda7muXVTFuHj1PHPJ5DJH2vS3PqeiKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLjPyE5DZJ1zBoG4sMG7n8r4MyEZWhTpX+rMA00w+XIqSEbvrnqYIriU1e7IPkLLcPAlnyN+ri7njQMoIpNWlVLb4WH30X/N/lgq2ZhiqztfBPDGrmJSojKFsoQhsSTEf0lfPREuV0h0yI5UJQW8S4ItFqO39oUBHXStSJ5BZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9f/2pv9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7725147ec88so842406b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757633122; x=1758237922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ0GHbXIsWeyBVWwhfEHNEV31kOGUvvbWv9Soahz7IQ=;
        b=M9f/2pv9PeeKa9bm3yYDfDA1Q8vt4mIsg5nMlz4I/UfCIrfGQ0fj8JoqxZv8klwuSn
         k6iWYvPtPEVRCEPhqzOH6T4Uc6p/DY/fyFkj55/kpFhjsju2OwtAFIWect9iNTm9Scks
         0tW+I5NfIjL6QIrdLgLUaqPtbfyjl5Hq+66JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633122; x=1758237922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ0GHbXIsWeyBVWwhfEHNEV31kOGUvvbWv9Soahz7IQ=;
        b=g+got7GRNCvCcUSnKi3ZVPwUtg1+yBcwCim34Qdj9GaP+2xMtiBmQ4DG8ftZ1l5awA
         p+DyD4hSWYlS8+IyoqeMr/NYS/xsVlASZgKFBNC2nqNo3P5GwMrB2GtYx6YZJACTzRGJ
         LxYf3wBbJWjLI4yNynytVCgYG6Bi6kv3Xaq+tLaH8h8KgqBpJPSAswu+TtxW1/NGHTZx
         1cRFu4yyNHw7byquM2QGMW2UQ9zrmpkiY66WkzEtbQ33+yh/wDWpo9aPYg8LDUmqJfkj
         QikqPq0/fCP6kN+CTUTBTms9Ez3Vx1VC12Y6q2mgP6i6wgB+TA0w3w2R6TidF+c0pzwX
         7zvA==
X-Forwarded-Encrypted: i=1; AJvYcCX8tq+jmhS/FgrYIUhf6QdHVFOgWT53UXc+rwjPx1TXH8cyNXV3u+sbUiJx3wF/U5Yw6ot4EvJSECEh+rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxNB3RkCGiRgVWJsJIrlR4wJNTNCva9F59rwrZntliXlwfjJ7
	kLUGQrbbM6xvTrXL3w53k9aKFsQXK3+tw/OQMTdQ+2BiMbLqqcZAg4YQOhJElPPmEc367hVuzX5
	axcA=
X-Gm-Gg: ASbGncuC3kIo+Zt0icq0z92z/IpSQHv7a8XkfjmFpqLx/J3fIF0+NFIyR04+xTeHirb
	1GgtnNOoFwJoND+RJkw8vM2DFzhmFxXzFfB1OUPmFS/vUZVf/edVUgrWQQnvzUK4Buv+Q4VPNHd
	iykS6XoVaP5h844TZ+dZPMPb4F+GU86lyYfORzKF3fsQ8J6Itm84P1tm2nhGAo85tc+BVPT9Wea
	wDjn7AlZHSfjMgAMXc9aUIX32+nmwgJRPdYYV+xo3FBOEueLdDTjRdWTuQw5R2+oEDAC2T26EqT
	ca47YrBxvXEEN5n05Je7pFJ2EpYN4V9u+LnKrpn3Xj+irD4O28MhYRLNCeyny62U8JkAw15FX4a
	d7tHZAOAHFuqqCY3pMgEaFjhdiHKiuRo1Zyiekz1X6wQCAiGpgivelmA5u0PuThlFiiF+4/Umqe
	TyIwERPnWxAuM=
X-Google-Smtp-Source: AGHT+IFMRR0+kpZZYLPvpDTAelKeSsh8H2CLGNsyj7jCDgfVnh0E+qiAC0FLgZEXfgFqtPXVL/qXGQ==
X-Received: by 2002:a05:6a00:3c8c:b0:772:736e:656c with SMTP id d2e1a72fcca58-7761252f1edmr937598b3a.5.1757633122136;
        Thu, 11 Sep 2025 16:25:22 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47abfsm3363072b3a.32.2025.09.11.16.25.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 16:25:20 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54a588ad96so738771a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:25:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhM3+ycoT21EVWNW+zIZP2eNGblzpDGaLFIayAl/AloPZvKB895+SBxDqEb3AIPaNcU4GEHFiQy0Z3HpQ=@vger.kernel.org
X-Received: by 2002:a17:902:a718:b0:25c:4d67:4deb with SMTP id
 d9443c01a7336-25d2ab3e054mr7308115ad.8.1757633119650; Thu, 11 Sep 2025
 16:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=FV=Um5NKHFZJJkC6eC0rnea0xSPeWVpK91PwGcrRjri28NA@mail.gmail.com>
 <20250911183928.2627172-1-john.ripple@keysight.com>
In-Reply-To: <20250911183928.2627172-1-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 11 Sep 2025 16:25:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WkbQeCaqHL3A3RzW9GhiLvkrZEbfLUFwfnx4LJQbUcWg@mail.gmail.com>
X-Gm-Features: Ac12FXy63C8f384F06Eg0_IkDCI5Cy8rcVbdBJeLpkWpw7PimcBa37NPwqPo22c
Message-ID: <CAD=FV=WkbQeCaqHL3A3RzW9GhiLvkrZEbfLUFwfnx4LJQbUcWg@mail.gmail.com>
Subject: Re: [PATCH V3] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 11, 2025 at 11:39=E2=80=AFAM John Ripple <john.ripple@keysight.=
com> wrote:
>
> Hi,
>
> >...and you don't need to check for "dev" being NULL because there's no
> >way "hpd_enabled" could be true with "dev" being NULL. At least this
> >is my assumption that the core DRM framework won't detach a bridge
> >while HPD is enabled. If nothing else, I guess you could call
> >ti_sn_bridge_hpd_disable() from ti_sn_bridge_detach()
>
> I don't think ti_sn_bridge_hpd_disable() needs to be in
> ti_sn_brdige_detach(). The DRM framework should run the disable for hpd
> before detaching the device. I haven't seen any issues with it so far.

Sure, that's fine with me. So I guess the result is to just remove the
check for the drm_dev being NULL.


> >> @@ -1971,6 +2075,28 @@ static int ti_sn65dsi86_probe(struct i2c_client=
 *client)
> >>         if (strncmp(id_buf, "68ISD   ", ARRAY_SIZE(id_buf)))
> >>                 return dev_err_probe(dev, -EOPNOTSUPP, "unsupported de=
vice >id\n");
> >>
> >> +       if (client->irq) {
> >> +               ret =3D devm_request_threaded_irq(pdata->dev, client->=
irq, NULL,
> >> +                                               ti_sn_bridge_interrupt=
,
> >> +                                               IRQF_TRIGGER_RISING |
> >> +                                               IRQF_TRIGGER_FALLING |
> >> +                                               IRQF_ONESHOT,
> >> +                                               "ti_sn65dsi86", pdata)=
;
> >> +
> >> +               if (ret) {
> >> +                       return dev_err_probe(dev, ret,
> >> +                                            "failed to request interr=
upt\n");
> >> +               }
> >> +
> >> +               /*
> >> +                * Cleaning status register at probe is needed because=
 if the >irq is
> >> +                * already high, the rising/falling condition will nev=
er occur
> >> +                */
> >> +               ret =3D regmap_write(pdata->regmap, SN_IRQ_STATUS_REG,=
 0xFF);
> >> +               if (ret)
> >> +                       pr_warn("Failed to clear IRQ initial state: %d=
\n", >ret);
> >
> >Actually, wait. Why do you want "rising" and "falling". Isn't this a
> >level-triggered interrupt? Then you also don't need this bogus clear
> >of interrupts here...
>
> I changed it out for a high level interrupt and it looks fine. The IRQ
> line off the check also seems to only send one pulse for about 1.09 ms
> when the IRQ is toggled, so I think its doing a level interrupt since
> 1 KHz is way slower than the refclk. For 0xE0 the documentation also
> says "the IRQ output is driven high to communicate IRQ events" so I
> think you're correct.
>
> >...and also, I seem to recall it's usually better to not specify a
> >type here and rely on the type in the device tree. I seem to remember
> >there being some weird corner cases (maybe around remove / reprobe or
> >maybe about deferred probes?) if an interrupt type is specified in
> >both code and device tree and those types don't match...
>
> I couldn't find anything about this and all the other drivers in
> drivers/gpu-drm/bridge that use the devm_request_threaded_irq just
> directly set the irq type. I couldn't find any that read in the device
> tree for it. The display-connector.c general driver also seems to just
> set the type directly. Do you have an example where this is used?
>
> The tisn65dsi86 chip also shouldn't be changing how it does its
> interrupts, so having the hardcoded high interrupt in the driver seems
> like it would be fine.

Yeah, it's probably fine and I won't yell too much if you want to just
set HIGH in the driver. I think the one argument for letting the
device tree specify this is that you could conceivably imagine a
hardware design where this signal needs to be inverted at the board
level. In that case the board could specify "level low". That's kind
of a stretch.

Let me see if I can find an example of the problems with specifying
the interrupt level, though. Hmmm, I found one old patch that removed
setting the type from source code here:

https://lore.kernel.org/all/20200310154358.39367-2-swboyd@chromium.org/

Interestingly enough that patch also suggested not hardcoding a name
and using dev_name(), which is also probably a reasonable thing to do.

...but that patch didn't actually talk about any problems being
solved. It's possible that whatever problems were there are no longer
there, but I at least found some stack overflow question that sounded
like the problems I remember when the code and DT mismatched [1],
where someone mentioned:

> do you know why if I use request_irq() or devm_request_irq() for an
> SPI device (for which spi_drv_probe does almost the same as
> i2c_device_probe does), then after unloading the module and of
> course doing free_irq or even explicitly calling devm_free_irq,
> and then trying to load the same module again, I get an
> "irq: type mismatch, failed to map hwirq..." message?

As I said, maybe the problem is fixed now, but at the same time there
is something nice about the interrupt type only being specified in one
place. ...and IIRC the device tree validator gets upset if you don't
specify the interrupt type there, so removing it from the source code
seems nice...

[1] https://stackoverflow.com/questions/40011799/mapping-device-tree-interr=
upt-flags-to-devm-request-irq


-Doug

