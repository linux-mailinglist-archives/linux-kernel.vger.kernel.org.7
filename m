Return-Path: <linux-kernel+bounces-727402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEAEB0199E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F311C47A36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BC28033E;
	Fri, 11 Jul 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BFT9BjnE"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6827FD45
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229374; cv=none; b=IsWXebgxxq/vVR+QhqcJt4hZS9F9ofYTz0RTqI6JuznKbPJ3MNpiTOaOi1LgpUghF4ei5JU0eZ+1Wbj7cdh2maVfcmFxnHz64ELhhoJCOZb1DY+irw4OCUWfM2rq2i/FMOHmdv29PMosuH6fNZVrquI9KHr5gcqFb2Cl6ooUN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229374; c=relaxed/simple;
	bh=JGW8MvKUfKhaOjVnbMWj91aDHU9szYu+5s37tDdARUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTb2K6qtw3IeApR7qIGeHwYEH1UyqQEV/CrcvRjOHSWcIr94eds7+zlExT2+v5WlDXbyJ5KJ8P+VPjRq5Wzwc/bH1McbRLLCsBtcg4srJEUDVbq1dxeM/lh+OFFBL8GNYuQdJJpeUMCx7nJ4nVFVQ39ePc/TjTImnaTdHkrJKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BFT9BjnE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b10594812so1981952e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752229371; x=1752834171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGW8MvKUfKhaOjVnbMWj91aDHU9szYu+5s37tDdARUA=;
        b=BFT9BjnE7QmCOOxJAYTlvWOQexW2T+QvVHwhTpzS3+hHKSzLqHWqP8pMmz4awqmoQo
         mpqgjbm8j4LTXt6qIGw1jsWSseURD0ej5IFU27RcWmF7qg28wYTp4Ehlm0Wy1r5/YZtx
         5rJEehzDlH6q3svoT01BV2x03anMSMSvB3/nVjGntNTcu3RdzQ2tJCISpymvbjlwdmwR
         ZUa9aPGDXQqc18jgRewC4FCrfzsGvSUCJabFm+FG6z6IafuA2qljm4UfkJxarEeLXP/e
         v+WRPtuRKbTJK6hY63MQUCTiz7p1Yq9uNhl32Nf0FwGedXdclYWA5gg0SpEyg34Py1Wo
         IFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229371; x=1752834171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGW8MvKUfKhaOjVnbMWj91aDHU9szYu+5s37tDdARUA=;
        b=fVl813C7+yHvuAmc21KW2IBJ69FoFuwF/IVK1e0HyjQnL+Wu8LnU0Q2GjS6UM5kkcD
         E8ex5woHZypRVlAd817046ZoHCLQuFHrLar79JvcMn3v4fFbsd2VkROz0XuRrRlBCxCr
         pLcc/HKmxhzD7p207wk19D9QyPnv74xZAmY/YO5TM0TCby6Y1vuUDfO61w7WC9akM/Xe
         YmlDMtjQrCNU4Epad3a8DfWz9LfbYizn9qACHoqT8nmP5dloJCXT/9d5EmxZJyo9q43j
         nv28VvQEQT8t+SEaEu3YXyeDkbInA1PDohezzyAI6WKv4PKUYMca2ipyVhJ0842+xZBu
         KGDg==
X-Forwarded-Encrypted: i=1; AJvYcCUtPCr0h4U8Lxrvg91XRJfYIYa/iPmPx6D58fEx0v3yogD1LrRNuRqjKNgJAlSUE1XC/EvZN0/6dSfwoiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFmIHt+OLLv6thzWtnF0VnWSNA4hC0kQQqz44RfM52Jxp0UVH
	hKWP2BqVESn1UkbCFQMKxgytuEtc1v7wokKBw9u8u4S5P4KQsOteOyAYvDAT1YQySLbeIWte1Y7
	oWT4ojABDYhhsrAAtToFlxgaPi8GbgSsuwWgAx5yr1A==
X-Gm-Gg: ASbGnctLYiuOByEIt/AYhE9mfxW2gZEcZIgmYo7FxeuC5rab37GstpxOy35PsH8Azpl
	i0L/YJpfwYEgkNZXPvhKIuEhe+HomIjC0HuagPYlMaKfzFxrLtuQAqrGFD5SM9SYHji7Pqo92Fs
	pU4fgfRpV9jGY/W0NAnFKv605n+rHLOrPjg8dWjQW5safajyZVEzgaA4liC/7R7Sn9jqgVHqKmv
	HE7knEEQ4rgUwTQDgWzd7SMg1k8z1oyaK8L2scjxb9hAkfe
X-Google-Smtp-Source: AGHT+IErWz8+Owck/Svh0/uZ+pVAPhKAf17395GWgH3vgmlAH8ppyvsQp+0Fhf/VpR4wd9Akgu08i+W2C6AnG8M3FpI=
X-Received: by 2002:a05:6512:3091:b0:553:2375:c6d9 with SMTP id
 2adb3069b0e04-55a04646a60mr740650e87.55.1752229371037; Fri, 11 Jul 2025
 03:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709201028.2175903-1-hugo@hugovil.com>
In-Reply-To: <20250709201028.2175903-1-hugo@hugovil.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 12:22:40 +0200
X-Gm-Features: Ac12FXyPqcMLXdEsGxj8xKlPSpc2z1povCiPDwzBYexnq2JfIGWR0RRUr218NtI
Message-ID: <CAMRc=MeJh2H0zYg5mfkuZreNoRAOWar9oR68+xrAar+-W2gJqg@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: use regmap_update_bits() to improve efficiency
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:10=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Using regmap_update_bits() allows to reduce the number of I2C transfers
> when updating bits that haven't changed on non-volatile registers.
>
> For example on a PCAL6416, when changing a GPIO direction from input to
> output, the number of I2C transfers can be reduced from 4 to just 1 if
> the pull resistors configuration hasn't changed and the output value
> is the same as before.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---

Nice! Can you rebase it on top of gpio/for-next, it doesn't apply
after recent changes to the driver.

Thanks!
Bart

