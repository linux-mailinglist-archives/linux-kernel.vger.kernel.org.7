Return-Path: <linux-kernel+bounces-801217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F8B4423A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920415A212C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D82D3EE0;
	Thu,  4 Sep 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rqhxcr1L"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A372367CE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002082; cv=none; b=OdMvyd7LVc15Sj6LUxogSZvO8BsEgSH4hCnUrcJO3f6TiZxx9g8K/B3VgER/tIhhKANjW7CkDZtnfyOg257HMvXMQIDn86iQsa9UDMSVWe3AgSIuSeSZu1QZatdSoqmJEp1KQ/0eeG45qLJXMS5AjYqUbkcvXv0Z1gp5/CrMMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002082; c=relaxed/simple;
	bh=cnXHYCpRCNjx5SUFDPlawJkSPyB4ySmqM9hVB3TT2RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJGdm/YbeABt2gP6I4BX7VffG5aFzJqojA8yeOEluvhkLQs5asCdI9kY9powKswudI68FcvGBpVpDw0Jy2yy/fNWUlNVsgp8zPXBpB0SQOrockafwKYocm4Tl5CkNq/LLc+i3xVxYUrQI7CdHECVo7MCSEXNNb2Wka7U0bn7nCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rqhxcr1L; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603cebd9so15189237b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757002080; x=1757606880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngovn7ElXG+7WyoV0hjjDgFN9akcGWmEQfLRohWixno=;
        b=Rqhxcr1LH0GBWIxBEVrDsRajEAUrXouW8oKXT2/eoZeoIbDMfa0L7f8Evbz/9faa7F
         7Bt7tljzTJIO/vfaFG6Cp2dYgKYyaSy3RwnE+8GCKa07ctgP32wyxDiH/gcWHfYjNB5K
         7N6C1nNS79eHY2c1DGGIIDFOHzCslTiUVn2XID5qBRoh4rIN/d5i8bU/uSS1f8qiszzw
         t8M0gd9/HDtUMjdKYOax5vk9Hc5u07Q1VYeS+K8AScUifnnd/o/BB7l5uAksB+ZTb+iC
         lUUdwpLFhHY1bquLOw0VSPcljUiuTKutaAwqlABPh8NlPxdE3gWG92gtnRBS73KzyZwz
         6SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002080; x=1757606880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngovn7ElXG+7WyoV0hjjDgFN9akcGWmEQfLRohWixno=;
        b=cCV9pjn/Ikwe/tOg89AmEQjWPXfhYK602dyJdelXAIhIiGI3DeAhvz7rBVN6Pd0/b1
         QHg93p01qMTH9mSuuxv5A5CUUqBpe6BtYhy76mfPzB8mME1HE8tBsz9lhkcjbNgzVhcS
         b1YECeB6uFH8icOMXEKbcQgK7+6wEERLcuB+5uLBPdFSUmPQ+yzqiyEyY9pWaFjlMLrP
         EbREWxjRvk1act1yHq5ldmdYng4ZxcEcEACVSmzF4iKnyakbGy/VsavZPIq/Ni/Ei9IK
         ZWFYZo/eE6cTWVmzFisGR4whlKUknchqDqr2KbX2pvjN5q8eUwIC470qPMaIHTJ05Aki
         0sCg==
X-Forwarded-Encrypted: i=1; AJvYcCUjLL9K83fl1E/geQleS//4obJdwqz9uZHbWlt+hbcbBD0J2J0tq3+C0MkjDIrDWXHC9WeKzGXzUo3VSw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WeAdHkAdvNQ9+StpKmd5LNGx2C2k+Vyq+J4uTZDX3HXll3dR
	b+Nb4Q/1PvjTN/rCJSSpXq+xE1QPAAEuhjiwBgci6V2FhEjtxpXH0wtczUjuM0KVhAcCfb6Wly8
	fDjGyLgM1x13OBi0fgAgJGy6NzC5Ilb6yKfpAx5ZU1g==
X-Gm-Gg: ASbGncuVOW+yQRr8C70ybJZfnb5keguuByx+/eJg35fHf+0djKcUd0Aad4uZSzjVvSv
	y5NU1b2LIrSDwQEB0leSlmgv4OGi8WUu1Px4iI/qcXHSeF072drwYbq5aDd0XjsC1QjHQeYe0Cx
	dEhRUn4bcaTNb7n08WcLIS83lhWV2FDoxugewlQMpBpVhztrh1gwtRz3nVkpk3HNoeKw5U7wGtq
	8/wKKpV+moXxiy9qLU=
X-Google-Smtp-Source: AGHT+IEqH74Cg4iFEkHgdi0JpstCrWnwWXCtc1QVg5UcVB0OzflJy4/ZXz5pYBSrJ2p+olLRHuT9lTjmfhHY5q+VLGI=
X-Received: by 2002:a05:690c:4513:b0:721:6a43:c960 with SMTP id
 00721157ae682-722763cfc0amr205545067b3.21.1757002079724; Thu, 04 Sep 2025
 09:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <117136352.nniJfEyVGO@diego> <878503621.0ifERbkFSE@diego>
In-Reply-To: <878503621.0ifERbkFSE@diego>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 18:07:23 +0200
X-Gm-Features: Ac12FXygP8QcUyXMTTe5VNxf5L6rnNsUUgEJRbWZ5YyIweFbnGJhrePkXqyAfZM
Message-ID: <CAPDyKFpZOgrOtAcpopkk0s+OYr6f+_yFz1v1E+4NHgUsnDhLtg@mail.gmail.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, linux-rockchip@lists.infradead.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Sept 2025 at 17:55, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 4. September 2025, 17:49:16 Mitteleurop=C3=A4ische Sommerz=
eit schrieb Heiko St=C3=BCbner:
> > Hi,
> >
> > Am Dienstag, 2. September 2025, 20:23:04 Mitteleurop=C3=A4ische Sommerz=
eit schrieb Nicolas Frattaroli:
> > > This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
> > >
> > > On RK3576, the UFS controller's power domain has a quirk that require=
s
> > > it to stay enabled, infrastricture for which was added in Commit
> > > cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()=
").
> > >
> > > Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> > > genpds on until sync_state") appears to break this quirk wholesale. T=
he
> > > result is that RK3576 devices with the UFS controller enabled but unu=
sed
> > > will freeze once pmdomain shuts off unused domains.
> > >
> > > Revert it until a better fix can be found.
> > >
> > > Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on unti=
l sync_state")
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >
> > just an observation independent of the conversation in the other thread=
.
> > This patch/revert whatever fixes an actual issue for me.
>
> ah and just saw Nicolas' mail from 6 minutes earlier.
>
> So I guess what saves me here is the rocket driver being built as a
> module, power-domain getting turned off early, rocket probes with
> pd off and then gets its supplies as expected.

Okay, so to follow up on your analysis.

I am thinking that the PM domain "looks like" it's properly powered-on
during boot/init, while in-fact it may not.

In other words, calling pm_genpd_init() and stating that the genpd is
powered-on seems to be the problem here. Could a proper power-off be
done before calling pm_genpd_init() and then leaving it off until
later?

Kind regards
Uffe

>
>
> Heiko
>
>
> >
> > On the rk3588 the NPU power-domains are a hirarchy of
> >
> > PD_NPU
> >       PD_NPUTOP (core0)
> >               PD_NPU1 (core1)
> >               PD_NPU2 (core2)
> >
> > and the PD_NPU does need a supply regulator.
> >
> > (1) With "just" v6.17-rc + the rocket driver probing and then idling, I=
 get:
> >
> > # cat /sys/kernel/debug/regulator/regulator_summary
> >  regulator                      use open bypass  opmode voltage current=
     min     max
> > -----------------------------------------------------------------------=
----------------
> >  dc_12v                           4    3      0 unknown 12000mV     0mA=
 12000mV 12000mV
> > [...]
> >     vcc5v0_baseboard              2    1      0 unknown  5000mV     0mA=
  5000mV  5000mV
> >        vcc5v0_sys                18   18      0 unknown  5000mV     0mA=
  5000mV  5000mV
> > [...]
> >           vdd_npu_s0              0    0      0  normal   800mV     0mA=
   550mV   950mV
> >           vcc_1v2_s3              2    1      0 unknown  1200mV     0mA=
  1200mV  1200mV
> >              fe1b0000.ethernet-phy   1                                 =
0mA     0mV     0mV
> >           vdd_gpu_s0              1    2      0  normal   675mV     0mA=
   550mV   950mV
> >              fb000000.gpu-mali    1                                 0mA=
   675mV   850mV
> >              fd8d8000.power-management:power-controller-domain   0     =
                            0mA     0mV     0mV
> > [...]
> >
> > #  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> > domain                          status          children        perform=
ance
> >     /device                         runtime status                  man=
aged by
> > -----------------------------------------------------------------------=
-------
> > [...]
> > gpu                             off-0                           0
> >     fb000000.gpu                    suspended                   0      =
     SW
> > npu2                            off-0                           0
> >     fdada000.iommu                  suspended                   0      =
     SW
> >     fdad0000.npu                    suspended                   0      =
     SW
> > npu1                            off-0                           0
> >     fdaca000.iommu                  suspended                   0      =
     SW
> >     fdac0000.npu                    suspended                   0      =
     SW
> > nputop                          off-0                           0
> >                                                 npu1, npu2
> >     fdab9000.iommu                  suspended                   0      =
     SW
> >     fdab0000.npu                    suspended                   0      =
     SW
> > npu                             on                              0
> >                                                 nputop
> >
> > Observe that the PD_NPU never got its regulator and the domain also
> > never actually gets turned off. While the domains directly attached to
> > the cores get turned off.
> >
> >
> > (2) with Nicolas's patch applied on top, I get the correct behaviour,
> > that was also happening with v6.16 before
> >
> > # cat /sys/kernel/debug/regulator/regulator_summary
> >  regulator                      use open bypass  opmode voltage current=
     min     max
> > -----------------------------------------------------------------------=
----------------
> >  dc_12v                           4    3      0 unknown 12000mV     0mA=
 12000mV 12000mV
> > [...]
> >     vcc5v0_baseboard              2    1      0 unknown  5000mV     0mA=
  5000mV  5000mV
> >        vcc5v0_sys                18   18      0 unknown  5000mV     0mA=
  5000mV  5000mV
> > [...]
> >           vdd_npu_s0              0    1      0  normal   800mV     0mA=
   550mV   950mV
> >              fd8d8000.power-management:power-controller-domain   0     =
                            0mA     0mV     0mV
> >           vdd_cpu_big1_s0         2    1      0  normal  1000mV     0mA=
   550mV  1050mV
> >              cpu6-cpu             1                                 0mA=
  1000mV  1000mV
> >           vdd_gpu_s0              1    2      0  normal   675mV     0mA=
   550mV   950mV
> >              fb000000.gpu-mali    1                                 0mA=
   675mV   850mV
> >              fd8d8000.power-management:power-controller-domain   0     =
                            0mA     0mV     0mV
> > [...]
> >
> > # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> > domain                          status          children        perform=
ance
> >     /device                         runtime status                  man=
aged by
> > -----------------------------------------------------------------------=
-------
> > [...]
> > gpu                             off-0                           0
> >     fb000000.gpu                    suspended                   0      =
     SW
> > npu2                            off-0                           0
> >     fdada000.iommu                  suspended                   0      =
     SW
> >     fdad0000.npu                    suspended                   0      =
     SW
> > npu1                            off-0                           0
> >     fdaca000.iommu                  suspended                   0      =
     SW
> >     fdac0000.npu                    suspended                   0      =
     SW
> > nputop                          off-0                           0
> >                                                 npu1, npu2
> >     fdab9000.iommu                  suspended                   0      =
     SW
> >     fdab0000.npu                    suspended                   0      =
     SW
> > npu                             off-0                           0
> >                                                 nputop
> >
> > The regulator handling is working correctly and also the parent PD_NPU
> > domain gets turned off when its children are off.
> >
> >
> > Heiko
> >
>
>
>
>

