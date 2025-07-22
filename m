Return-Path: <linux-kernel+bounces-740826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C77B0D9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807B51886A74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6E2E424A;
	Tue, 22 Jul 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z25gaQon"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426820D50B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187615; cv=none; b=nw0nSJZRfifMMJFtiFTxoP7vtN3bOSGfrlgfQvGimfCU4DPT8lKCs8hewpgo1Vdm1QEx5kudp32rKSsAMxwlfOQ6N1w23l9nQJZYNYIYkH5FaaP+NoeGjRUkpDgTOKDkHWTI5M9q2aAHUX7/BQLQk9j1jhAdK5e3xtvXXsgsSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187615; c=relaxed/simple;
	bh=JQAmUAgM9/RaH27IaFC9XF/IxHkWyVVH3kpCZLC5sKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNeM29Hsk4NEgjNvXmIh4R4dtYM9Sg6mIqvvloE9F49Ckwl7bZk3AfttFhk6RnbR5CjjvIQ+og+XcZx6DV6hZDBsJNwxb9hCikUU5MQQah187H6pqO3eq0gU2wIVKKgpLfNCSO6jNNWc3pAFzz2X6zncOFRMSvk8vhag9OkrSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z25gaQon; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b31afa781so42833731fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753187612; x=1753792412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+GKZahGmDdPv5L7LZQzaZ8ms1eU9iPtW5fE1sZ1rk4=;
        b=Z25gaQonh2BcW45vaEJQp/HWqnl1+hy5QQwAsr4LcO7R1jD3F0lf9TJ9s8q3O0xoet
         TfjqgSewMU3zg2g+PeW7xYdINxU5IKTkOIMOpfXJcnxAaNsTkcuwwGPhxqzhahmhXp+1
         JN/NqyWtZnjcbRf5pud3bGg1Tp7jTN0QPHFRrVnHZ4lZ0yyhFBL7MjvYDqfQsYjrHPKO
         jNoGjeEVgZUzuIItXUvk4Ghn82w+1VE1JntmAbO/BFMtgCeXpq36CbJXObzTnVkI6bFf
         fFjSsYFy5IQvPm5ezJWhvKMYjtil04NRq8eajsJsksb23Dk7z7/mTHS8VtavSClNICTI
         3Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187612; x=1753792412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+GKZahGmDdPv5L7LZQzaZ8ms1eU9iPtW5fE1sZ1rk4=;
        b=ZmV5OygcCpXF3xRtUTy2N47mCxbxBT8I+SCaHp4ApmXbKniyaTS4Upr4WlDhv+CL4E
         ihDflShWDwbgXb/0GtfuWWuH2lYIpCeLow3qg1mXq3/scIRLRbsn6XgJojzIIKtfdiz1
         wwsFNMhmm9Irp/m0oDl1X93SXD6TiJE2tyGJlbiV8vC5zTIAn+BFwFqovnHJzRCehkmH
         w0ALK5Qoh2RuB3x5OsMfsLFhrIqAqTtYLLbdjeL46ctWSTdO+svP4up2cJ2rsuX/5nVR
         Jb4LjAYsqQq3/g7XFf0M41kYaSZM/0N3BEVtpABIfpPOaIB2VE1WSej/wo82KTuoSiJy
         nbkg==
X-Forwarded-Encrypted: i=1; AJvYcCX1k9Yvs6JARcKP8yMOZhbwwitdH1Rq0INFXsi2vnQi3yWYCBgXBW+a5PSaPf12zRmUzfUeFjrbEcnhk/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nMZwwCyQbjCMCgLTITy4uQPXqfgAz/O5lQz/R1kD9QENaO6p
	ITaoJXHdLLfyPhv6pxUDp2/C2JKpsqVT6wAJUDuYCxm0rTTKVySNSf1pAl0nJnkShXjpRkC162e
	oFOZQAyYRa7Ko6lTQXIIJleHnRb0s5DfoRPaCgY/AQw==
X-Gm-Gg: ASbGncv3bXGPvHUVpHwLv8OjLXk03laKLBoW8qtt0q7fWagjtqjTstzBk82ed6eVThb
	e+NAi/bJdcuhUZ/OhxXM6ytsXmgqW4soLaJEu7JWtn7aPhRpucGJvhX/xLX6hSYugDPqcn/+NfC
	CFLMelkmovkRM+3tRvdbPktwYYWoTEgxycKfIidPFGDRFcdIWk00XKOcpdoYes9O4MKK4wBCWkt
	4C+dTgOps+wP0GTKEnHf+rmc8baBQgFsacYqQ==
X-Google-Smtp-Source: AGHT+IE4NLh74+eaL28wuve2GVp6Fz+dzUpqyQgftU5RDfIQz6VE0xFsh7GIWHtxc9eDY44fnzPlyDiXLFQXZa1zK+k=
X-Received: by 2002:a05:651c:e13:b0:32a:6e20:7cdb with SMTP id
 38308e7fff4ca-3308f526f69mr38693341fa.17.1753187611451; Tue, 22 Jul 2025
 05:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721233146.962225-1-s-ramamoorthy@ti.com>
In-Reply-To: <20250721233146.962225-1-s-ramamoorthy@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Jul 2025 14:33:20 +0200
X-Gm-Features: Ac12FXw8rQB0btGgQIdOuuluV0bKj5UY1CC8pTxt_PxLMJg3hptyK0eG64L8UIU
Message-ID: <CAMRc=McTJnTn1sf6Kc42yePvUyP87h1utJ7B_ynWjUxxm0E4Lw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add TI TPS65214 PMIC GPIO Support
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: aaro.koskinen@iki.fi, andreas@kemnade.info, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com, linus.walleij@linaro.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, m-leonard@ti.com, praneeth@ti.com, 
	jcormier@criticallink.com, christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:32=E2=80=AFAM Shree Ramamoorthy <s-ramamoorthy@ti=
.com> wrote:
>
> The related MFD series was integrated in mainline during 6.15 cycle [0].
>
> TPS65214 is a Power Management Integrated Circuit (PMIC) that has
> significant register map overlap with TPS65219. The series introduces
> TPS65214 and restructures the existing driver to support multiple devices=
.
>
> TPS65215's GPIO specs are the same as TPS65219, so the "tps65219-gpio"
> compatible string is assigned to two devices in the TPS65219 MFD driver.
> No additional support is required in the GPIO driver for TPS65215.
>
> - TPS65214 has 1 GPIO & 1 GPO, whereas TPS65219/TPS65215 both have 1 GPIO=
 &
>   2 GPOs.
> - TPS65214' GPIO direction can be changed with register GENERAL_CONFIG an=
d
>   bit GPIO_CONFIG during device operation.
> - TPS65219's MULTI_DEVICE_ENABLE bit in register MFP_1_CFG maps to
>   TPS65214's GPIO_VSEL_CONFIG bit.
>
> TPS65214 Datasheet: https://www.ti.com/lit/gpn/TPS65214
> TPS65214 TRM: https://www.ti.com/lit/pdf/slvud30
> TPS65215 TRM: https://www.ti.com/lit/pdf/slvucw5/
>
> Tested on Jon Cormier's AM62x platform with TPS65219.
> GPIO offsets remained consistent and functional.
>
> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> Tested-by: Jonathan Cormier <jcormier@criticallink.com>
> ---

This doesn't apply on top of my gpio/for-next branch. Do you think you
can quickly submit another iteration rebased on top of it?

Bartosz

