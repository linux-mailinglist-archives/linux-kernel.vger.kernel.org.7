Return-Path: <linux-kernel+bounces-793138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0EBB3CF26
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE663B5A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287E2DF716;
	Sat, 30 Aug 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k+xd4gYP"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A52D8DA4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583401; cv=none; b=Hv1RwpLqCTgueEGaNHt84Klc0WYocXsmgbMxV1JCIx7ESv6GXwHl+5AlYKsYz5KAwYQTlqJOuIBJIY+JDDRo5loCSRJMPcgcJhJ3Ua0YGLuM3TjxhYcMoljH0pDn/WQN1XH7d3qGWawsd176uB4D6lGH7ZhAuYPyon2sIeXVk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583401; c=relaxed/simple;
	bh=RESvPL6lZSU1LVrX5w1VrBJByLVlXWsRl2ULoQXIrYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTGHrXjjfoxxkgvFHT/JwlhUvS+PeLZzI/kfMdkR448EJT0T3BsNrBYr+V2AN/xW2LwDjY24r5w2aaPJS0qj2To5x/CKaORK5Nd5FSVO5r7dblml0SnpyRGN659XP71sNAMjA2BWPWyGGJwFm6prDgvbs3+1e28ZIy8kJrxVfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k+xd4gYP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so1523117e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756583397; x=1757188197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RESvPL6lZSU1LVrX5w1VrBJByLVlXWsRl2ULoQXIrYw=;
        b=k+xd4gYPPID2fGD2mriQ/uWrl5Rij0kxv7aV+7AothtEwbuKIR5bBrefwe5my0dN0W
         dC0Hkv+TONrXPf/rhC0/LTwZTwyTex+MZ0OvVQDpGfTCkpg98DtppVN9N82cN1GwyyBr
         CO8dKAeYRXykeGNW/7N3ST2CFG8/KaYvTn82dX6grVGet5dVM3pdHzl9pJyMfJ6C1648
         iTEEw9t3Q0M9LMZEYis/KK4GTTrTnqia+fpXV1/wernfdD/fS71PwYGP2N95WmdkozYr
         TNB5i/RVoSW7R2dhUHb61ejRVeJIRqATDF0Na/enuuary5EGq/f353g9qSz0hk4FTTw0
         0nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583397; x=1757188197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RESvPL6lZSU1LVrX5w1VrBJByLVlXWsRl2ULoQXIrYw=;
        b=Dc/DC71H/XQkpiFKOPcwvmPAsL0bezIwqaAE5Mr8QG9fHgmoqZDLnMSRLBi27ERyaW
         wp1o1zdwGiYm5Kb470lc5ioKN44gWtW53oqVEKmF3i0L4XW60Emhdi+M2k4p6BAWGGo3
         fVSIc8Co2djraoY3eVCxVuyI3WT9S6PbDA+iShmWOVRCe1PDhpfqqj74qaWXQHSVJnPH
         f/o45+AUJrieSpRJqoq1ZDZgqbCuIYhVIBeMS62VxOj/XvybNpEQnh1FUhWo+kxlMRtJ
         kaV+pPGuQE9T7fAhDGtAmerWSFaNcj0js6MyPU/T5hGHXgYZRj5PRh8KQiwCelfrKGq3
         X9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUg1QGNW2Zm5MUj0Hy5QuEA5/Juh1rDP0o43ht2q3/iABTYICTieJX60a7jZFgYYDsbQfsOWi3APoNIJAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75/QHUNAT4wHQEaFwB00OiTvZQaFqODwj+4CSevgUNA1g/y/s
	m2YUP4x4p3w6III9+1YrrdfJ9F0v73MpFJ5yo4ayZYvF8bOgx+hKw2vEFYuFT7MCW2NmzxoKewO
	0Pa00mJb1O7lkR6YcdRyOpax4ZPXbt89ak+NDV8mfMw==
X-Gm-Gg: ASbGncuGbR3pXDbkokdPbvrLyKVoKZIcCnm4SvMWr/4d8fbcWZiARYB+yb7rBS7GTSu
	LWeL28IjUKFx/aEWGIDSmVeYS8m+8j76j+UYP/miitKfuwWmH6EXfIj+BkbJZGTPAlsVl0FWzto
	q14zGeAHUJGS0dqGw7i22KhK4at2QV65YoYeMEOvtuYUIotamWOOCDeLVaAK9OOjLOTr1fx1jWz
	fHoRRKPRUFWI95o95QqpqSFAp/t3ZPNsjiGnM0tCf0RMaFJZQ==
X-Google-Smtp-Source: AGHT+IE50mGD6Wsp5fjlHRmoMQ5rebLnfakE86Vnr2ujarxjBgcFlbm1KFCExKkXTA2m/S8rPEWfnwfaAxEiJLlgF8g=
X-Received: by 2002:a05:6512:3b9e:b0:55f:486b:7e44 with SMTP id
 2adb3069b0e04-55f708ecf52mr685020e87.37.1756583397500; Sat, 30 Aug 2025
 12:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816035027.11727-2-ziyao@disroot.org>
In-Reply-To: <20250816035027.11727-2-ziyao@disroot.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 30 Aug 2025 21:49:46 +0200
X-Gm-Features: Ac12FXyuG3vAb6oO4Z4zArYVmCFaF-tcxGvuqQuACijURT9dTtrTa_sARjkZMYw
Message-ID: <CAMRc=Meed_x_OODv1fw1m7rpLY4uGic=0pacjV+Mj147_WMZPg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Support GPIO controller of Loongson 2K0300 SoC
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, 
	Kexy Biscuit <kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 5:50=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> This series adds support for Loongson 2K0300's GPIO controller. While
> being mostly identical to previous implementation, its interrupt
> functionality hasn't been implemented in gpio-loongson-64bit.c. PATCH 2
> implements its interrupt support with an IRQCHIP, and the code could be
> reused for other Loongson SoCs with similar interrupt functionality like
> 2K1500 and 2K2000.
>
> Tested on CTCISZ Forever Pi, reading/writing GPIOs works correctly, and
> both level and edge interrupts could be triggered.
>
> The devicetree patch depends on series "Support reset controller of
> Loongson 2K0300 SoC"[1] for a clean apply. Thanks for your time and revie=
w.
>
> [1]: https://lore.kernel.org/all/20250816033327.11359-2-ziyao@disroot.org=
/
>

Hi!

This doesn't apply on top of current gpio/for-next. Can you please
rebase and resend?

Bart

