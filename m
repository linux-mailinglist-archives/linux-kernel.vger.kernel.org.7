Return-Path: <linux-kernel+bounces-737188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A72B0A8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3FCAA0A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89022E5B1A;
	Fri, 18 Jul 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="hCq2gHor"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D826ADD;
	Fri, 18 Jul 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857194; cv=none; b=kac2KAUMgp7MNdyfJUDOGZqL5v+4A/9S+nqDabiWCE+yuQdSgPht1SGhvyC5B9CW/y0tbh2CxjGddbgG0JDa8aY4T0ToTvm8jhO7WsK6ataYNyxdJkHQAUuzgwcrR1+/Red+oCDhERCTAYC7ymWyPzgO0alN3uffqfyckaPpuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857194; c=relaxed/simple;
	bh=Y9/HzNLHHfWUMA2navFffKgWJsVgRHpXB4KSXUWZNro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvYOj7GU2NUUVqVSTMOdyeb9Ojg7D81+RkbfWMX/syBjzX11Y14vHNmSBMnXoqL4lYU7yAlB4MczrcfnA31rixmhiWNYSAe1aoJ6GNGHtfpeAn4x/LRGMJRB20ze/X7tIRS1nnpHhrP0fKrb8JpaWqjJjN0AiMfdqZ4+BdrViCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=hCq2gHor; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 98F9ABE42E;
	Fri, 18 Jul 2025 19:38:22 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 35830BE408;
	Fri, 18 Jul 2025 19:38:22 +0300 (EEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5D13E1FDAD2;
	Fri, 18 Jul 2025 19:38:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1752856701;
	bh=T/KHd8xSTyD2a62npLK0GCGhjwX/ZOXYPvlAwzv4DnI=;
	h=Received:From:Subject:To;
	b=hCq2gHorp3QxPG8wzB7MCr6R7F0+9EjtImF1nVTQXMrdTXFdL7/bbi6wt7bmNCFDy
	 iabIXZCU4XkPIwKiTbuG8hdwz4pCK+LGXXsr3i2/Ls7qHAGN7IXUbjYLs2t4akGPS/
	 y3hrQJmSzrKwHInaVUra0294+hqYC1UbHuIerkdLP1CCZBn/1cwfjJTV5HZ9ON4sRD
	 YPYuHB5H0vEmAE3sjoc0V08Ppo6axjk5OBSLZcwF/NIMCCphQpf/xZoifxA53fwtRJ
	 g/9hG+JSlIubFlmtc/u0O176D3nXeoz+Y1JjFfu9gBZG/BPv3unggq2XVrpSNDmHVq
	 t5Nd+nZ8OxJNg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-32b595891d2so17893381fa.2;
        Fri, 18 Jul 2025 09:38:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3079P2V2AwKBo3MOg0WYRdCnB/UYR1dxqV79dSHbRvsfEgYU2sD4msgaRhm7/+IC90AIIgomi1vI=@vger.kernel.org,
 AJvYcCWqJMPaETLOd09cFp8b+4YJdrTNajiSEzs4BywsrBTo73+/GwXAMAEJPVRRXke0bNKmGiuENKzCy0FS3z0=@vger.kernel.org,
 AJvYcCXfeae9z3Ts3JXqlMtMCVr/dO9LnvzbEOA/ZNWvs+iR+Ltq5nyqvsZy+q5UFohvhxibRclU6+1S7XYIG4+v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82tVz2UyZN3w2aUdxvUDY0kKBLvLhWmjMsfVL5Itnd0V+D0Hg
	QCmAfBIM0Kgf//EwzOBDuCHZ0fuveT2Xr7BxAP9N7UhFGm2xfvxE5NZiG/t8Qo68ma6L7DLW4T7
	lLSZpMXABsC4WLAf+S1me278vxdd3dYo=
X-Google-Smtp-Source: 
 AGHT+IH2EOYwVpYNC/dzFgzHOVWnAxLuBk2IBVmgSEVg2YWME1umiaot9LuowLPm+vix6mRC2tvBW2r1o/qDyjmuZqg=
X-Received: by 2002:a05:651c:419c:b0:32b:755e:6cd4 with SMTP id
 38308e7fff4ca-330a7c5726fmr8906081fa.38.1752856700745; Fri, 18 Jul 2025
 09:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
 <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
In-Reply-To: <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 18 Jul 2025 18:38:09 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
X-Gm-Features: Ac12FXy0Tx-o6uIT1821wM3-KJwlgmKE7INI2kkaYx6M9jkGi9kwYvBZc7x-lOg
Message-ID: 
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
	someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>,
	command_block <mtf@ik.me>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175285670187.3291495.16286230662434257056@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 17 Jul 2025 at 04:32, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/13/25 13:58, Antheas Kapenekakis wrote:
> > On Thu, 13 Mar 2025 at 21:10, Cryolitia PukNgae via B4 Relay
> > <devnull+Cryolitia.gmail.com@kernel.org> wrote:
> >>
> >> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> >>
> >> Sensors driver for GPD Handhelds that expose fan reading and control via
> >> hwmon sysfs.
> >>
> >> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> >> devices. This driver implements these functions through x86 port-mapped IO.
> >>
> >> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> >> ---
> >>   MAINTAINERS             |   6 +
> >>   drivers/hwmon/Kconfig   |  10 +
> >>   drivers/hwmon/Makefile  |   1 +
> >>   drivers/hwmon/gpd-fan.c | 681 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>   4 files changed, 698 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 0fa7c5728f1e64d031f4a47b6fce1db484ce0fc2..777ba74ccb07ccc0840c3cd34e7b4d98d726f964 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -9762,6 +9762,12 @@ F:       drivers/phy/samsung/phy-gs101-ufs.c
> >>   F:     include/dt-bindings/clock/google,gs101.h
> >>   K:     [gG]oogle.?[tT]ensor
> >>
> >> +GPD FAN DRIVER
> >> +M:     Cryolitia PukNgae <Cryolitia@gmail.com>
> >> +L:     linux-hwmon@vger.kernel.org
> >> +S:     Maintained
> >> +F:     drivers/hwmon/gpd-fan.c
> >
> > A problem we had with oxp sensors is that once OneXPlayer expanded
> > their EC to include e.g., battery capacity limits, it was no longer
> > appropriate for it to reside in hwmon. I expect GPD to do the same
> > sometime in the near future. If that is the case, should we
> > futureproof the driver by moving it to platform-x86 right away?
> >
>
> My problem with platform drivers, especially with x86 platform drivers,
> including the OneXPlayer driver, is that the developers responsible for
> those drivers refrain from implementing the client drivers as auxiliary
> drivers but instead like to bundle everything into a non-subsystem
> directory. I have always wondered why that is the case. My best guess
> is that it is to limit and/or avoid subsystem maintainer oversight.
> Does that work out for you ?

Particularly for simple ECs such as OneXPlayer and GPD boards I think
keeping all the addresses in the same file makes sense. E.g., I just
sent a Fixes for the OneXPlayer G1 AMD variant and it was one commit
instead of 2 or 3. At least for me it was practical, I did not
consider having a lesser oversight as a benefit when making that
choice.

But I do understand the concern.

Antheas

> Not objecting, I am just curious.
>
> Guenter
>
>


