Return-Path: <linux-kernel+bounces-727399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A0B01994
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8123A2605
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7F0279DC3;
	Fri, 11 Jul 2025 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PWZGHuam"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBC279DD7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229190; cv=none; b=qViaBIVOAf5BqWbI2FsdbfDDRaI+4p6g5l/rxCQTAaE+CZ0dHnhX1HFsaLtzKG9HSOcc3KEhoec68U5CrWdvu99iX9xhJzOCN9j1HS5y3tth+zidGxX04CS54JYZCj1qvSuaRUoebawmEVXgjA74sL0QdzwbsI0EFN3CYg1YrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229190; c=relaxed/simple;
	bh=cbmSGL/Y1Z4mlwSQSHxQV7KiqM9G9CxIi3R6tcvoELM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdvJRTN/u16lZ6ncb+lIbNCN3l291v0trUsl5/FfZNJbO5a+2Zvjma+L2UydkzOk0rz3LF/ff4Q3Ri8piNEKoBoCLaG2Y6l4YYzhJS/OYX6aHQlfzlraitDWeEXRRMmKmVU30zk67gYMpR1ssRNl09NpLK0I4g5asDwoFvbXN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PWZGHuam; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so3471928e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752229187; x=1752833987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwenZ9KMIUFAX6jrS0AK85gcymUf9NvXLhbThM1sPR4=;
        b=PWZGHuamwJUhoiK/Sou093nchqpKHXczhmhMqMA1Q/GQiOfcNxA7il9VFY7XrgWGu6
         5ogTPUFddkQEb+ca/b0xymLR76Vs5TZyyPNenmZwTc78b/tC6JKuR89hpLCbdHRAutAX
         ZhBTSmyF2dI7MuNNm2d1K5U953+XCgk3xhvizXF72huyxaP7av8zOKXwXYd2sTKTDYZJ
         TRjqehXh77I9k+57J6PP+vqCtRt93JWZfF8tKAXrvCcpTQNITOhIGRHGTmbY9HtFx1oI
         c2rVJwupwIpCsjZ8AmFGcAbesJShuD5LDVw9nCWuQAxv5xt89RHskkADfJzEtftpff/H
         7dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229187; x=1752833987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwenZ9KMIUFAX6jrS0AK85gcymUf9NvXLhbThM1sPR4=;
        b=nbc69kE/C6FC2IJ/iAjJrgjzbuUQBChXIGv1207n1XX/s6YeczMEGdn1NR/YkQU7pL
         70Jfrs9vo4ZrU86qdEjCBkyk+isgGi5bc4Uob0zALf9kU+zuyeKsFbvG9WhqJTdPVHjC
         lpeigzYRcqBwp8V3j6KMoHGWso5QsA7gXwrQOtJfGWNw9cPJy+HgaXxqaNvoD2joG/DS
         zKhSBKY+F/RDLMJC7TUWSamQDaI2pO/+VhgdzpC1LMaa2hdQtUIlOmdvC/dVP97hkb31
         Jp33MGgs56qD+Hddrtd+0t5ZwSWdFJ39QfcjmSIwQmTmPD0P+13Hzb63/NwSMFnXhDqU
         3tig==
X-Gm-Message-State: AOJu0YzUv27NsT9k/F7aMBXz+TxRrKRXa7K6e/m8VwA01mmA5Nx5D/ql
	k0arkxeQiu0nZBA3P3wVe5nhcLXzeINvq81KqzUAFJKtD1R2e61Kxe8WR0MH7M6R+96I+A90slB
	3KtPPJOJSGxt/3eKrSJXXkjTo/tSP8Mpw9ubyH64gzg==
X-Gm-Gg: ASbGnct3ab5kLS3z41iaILjgKXqjcSocYlMH8AlPmeAyIS5K2f9Jvl1W8a5vcRtQdlH
	/s54Q52O4RjTr+UU4HHgHDAHhPlll4BUpDoxUJl0rZsgrGoRU9myPxO2fY0mjRanBWxwjncnADl
	XOKhqt9sdNba4Hs1Z29K+GZXBGr00bZmFS5uN6UUXf+HzH8rRfr73604y7LnxQtvKBjWba0tCu3
	D+1undZEIaRJWcUtmXLVNvj5G+3lYOaEpH8xw==
X-Google-Smtp-Source: AGHT+IEW/M1REGVCK4E45GEKXbT3V9smSB8rKq/nvr0qctMYIRgEI+I64Yc2BwkbQM3QHr+TWvfrQBwSBy9bCPmHwSQ=
X-Received: by 2002:a05:6512:234a:b0:553:a34e:71d4 with SMTP id
 2adb3069b0e04-55a036ba994mr917962e87.0.1752229186800; Fri, 11 Jul 2025
 03:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709091542.968968-1-marcos@orca.pet>
In-Reply-To: <20250709091542.968968-1-marcos@orca.pet>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 12:19:35 +0200
X-Gm-Features: Ac12FXzsNlwwCPXmWdiqW-RqPJYd46pBsoR9iDovUEPXzuCSAy7cSpXF0__qwB8
Message-ID: <CAMRc=MdLXP=DgHEh6hoNYhDgB4aESmC29VH6hsH=AONNgsjXQQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: vortex: add new GPIO device driver
To: Marcos Del Sol Vives <marcos@orca.pet>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 11:16=E2=80=AFAM Marcos Del Sol Vives <marcos@orca.p=
et> wrote:
>
> Add a new simple GPIO device driver for Vortex86 lines of SoCs,
> implemented according to their programming reference manual [1].
>
> This is required for detecting the status of the poweroff button and
> performing the poweroff sequence on ICOP eBox computers.
>
> IRQs are not implemented as they are available for less than half the
> GPIO pins, and they are not the ones required for the poweroff stuff, so
> polling will be required anyway.
>

(...)

> +
> +static int __init vortex_gpio_init(void)
> +{
> +       if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_VORTEX) {
> +               pr_err("Not a Vortex86 CPU, refusing to load\n");
> +               return -ENODEV;
> +       }
> +
> +       pdev =3D platform_create_bundle(&vortex_gpio_driver, vortex_gpio_=
probe,
> +                       vortex_gpio_resources, ARRAY_SIZE(vortex_gpio_res=
ources),
> +                       NULL, 0);
> +       return PTR_ERR_OR_ZERO(pdev);
> +}
> +

This looks better but I admit I'm not an expert in x86 platforms so
I'll allow myself to Cc Andy. Is this how it's typically done in x86?
Is this module visible in ACPI in any way that would allow us to
leverage the platform device core? Or do we need to try to register
the device unconditionally on all Vortex platforms?

Bart

