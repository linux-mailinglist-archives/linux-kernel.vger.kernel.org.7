Return-Path: <linux-kernel+bounces-810250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992FB517B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20562547E44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15EB1B4223;
	Wed, 10 Sep 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WWMGTWSR"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6333E7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510162; cv=none; b=VieKtCyfbgRfuE/LKOWXUycETv3OE9Hd7uYIBj6WQZHZWPjWkF1i4tEUq0m+63ptuMDL4XnKeqYmsFVweqzd1E0OR0c1tSlAhIev9w7bOfdM64Ph+seP7udLS2dTXTRNo839xWDN69a3FGmf5bQUfYQS27u7tq/yD0Gk66NR9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510162; c=relaxed/simple;
	bh=yo7Oay2v74xec488RZqxezoj+sNijMpCAf5uHiFSGPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgAt7/+3Kb1A2vFpDAgVFcwB7sDcqH8HEwfrRDhVMtQO97BsgztuIqrJ6pQPS78Gip0gdeJ1NAUH0Z0WscpVOaHQVliyBs48BNs38qVlZ2TXCDGwoELJ+x+WVwxF/R7537LNYmWKdjG/gCEwYz2Znl/a1GzmIGD5EatP/bU0gIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WWMGTWSR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-33730e1cda7so61983901fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757510158; x=1758114958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Peu4zI84KpRcObnkHpqIQWTW+16o2UvKwBzcfExZiyk=;
        b=WWMGTWSRBbC5vzrBgNnTdpLZwS3NRseV96mkzGmml4KBUKHAZKcuwYP4fmhmbGWQeK
         tVEk2RkxevMzUrxZQD9R412XOywR5iOMYqLwGwnlEfX2ULLJzkq8kwGJJG0cPAqcYZ5Z
         OfiOVtioxsqA17tStzq1ymqmBa6o3Nd9bSSZv5+ZMvKCl6IzfqZngyE1wT0Ft/YWzTv+
         HYqpg52nyJvYkpyskrb8Q4MSe+3t2fNuancSqo2C8Ndy3oQQWonat6j2Uzsok7jwCYOO
         lOMkNo5lnD/PiNGHi1XFtjUvf5Xb4StmYpvsObY4WZLJCsDrkB7VHDuUq36rikIHIl+6
         7qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757510158; x=1758114958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Peu4zI84KpRcObnkHpqIQWTW+16o2UvKwBzcfExZiyk=;
        b=nT1i793oNGQsyb0194bxCX9hQ9RhwcFWTCr4WTmzir+4/XQ0e2kRYzTurt/lKG11Eh
         Cs7xzn8OkS4wnpeOXJjcdS8VSGXMqfVhv6yt1E7vxgkRpKSoikIgxg7+mlNikmNy3hp7
         +/498Dt6hTqPE06tf25NeDYjm4gH2LgTyplyqx2CQj5cjgsOtpvw0FrlftzCZhKmkMz6
         lCYAQ+fNMOctChOWGQvi4WpW85RKyBQrb8x4/smOXS/zhWOpOtE/zmcgIQjIkmf+ZcoZ
         q2QsGbRKTyBn05LjtZjg0Nciz1kTI2SYNiSRSQGN4FypeemcTQOJudzKWVJUvf4wqCmi
         Bcqg==
X-Forwarded-Encrypted: i=1; AJvYcCU2s20NiMtk+hsZ03BN1fWfMx7PJq7lWpUgoGLGZmfhLmjvr16s93OSi61gNKLQaVy5aoT/6Mlfun3Gums=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDThPEi/uMxZ8gUNhUYPau10+fNvEpMI4mMLhqSHD1ny7jqkZw
	o9wI/InfQ4qx80OtbONwlQyfixoM6+yuonfgCeytVLjhI7/klGdwU3fRP448FpyCQHoaSzYOp2g
	RUm8MN+pX13NAZCvX4Og9Kt6hMhVHoj2gmw2lYLec7Q==
X-Gm-Gg: ASbGncsrHGZvYA5CRbY0U3hguzMLb/o8inVwWrZFX9/UPzWF4ZxbIfnOj3ckfsyXmmt
	NYMCBNxme1kOK/J2Qh0GJElocI3P4PIY+MV+wP255vhvJuarE4CXz/H/ZlPxfDosYkaLQvweHxx
	t2GeYsw2TpK4BnUNgfHIVbYDOQPYWkEi6ea9b80qKl6FRNyyi082uguMlEMk2K69bqxjQ8fl2bF
	6PlHcfkf9pIvLwHKi4mdO3g8+SfLBF5DmTOdzTQhs838wWghA==
X-Google-Smtp-Source: AGHT+IEnayP778KTGlDRKFGcnE7OiZz5Ap6nrCq5CUhddnBoMttgXnm1cRJ/L73LzdvJ7nxyXI2sQjhe/45Ih3WDiuU=
X-Received: by 2002:a2e:be91:0:b0:33b:6384:128c with SMTP id
 38308e7fff4ca-33b63841617mr51366531fa.18.1757510158259; Wed, 10 Sep 2025
 06:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173804.3816149-1-mstrodl@csh.rit.edu> <202509092305.ncd9mzaZ-lkp@intel.com>
 <aMFzTaO7zGVgWNRK@ada.csh.rit.edu>
In-Reply-To: <aMFzTaO7zGVgWNRK@ada.csh.rit.edu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 15:15:46 +0200
X-Gm-Features: Ac12FXyQUcE4PEKS9I4klpj25TQWTsxm52DQhqCNvgW7RhiFrEgsQd7rQ7d9w4s
Message-ID: <CAMRc=McBdJ16RYvJM_R7pL+u3zcs_+A0nj5_5twP7KxWhW6VDw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpsse: support bryx radio interface kit
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:47=E2=80=AFPM Mary Strodl <mstrodl@csh.rit.edu> w=
rote:
>
> On Tue, Sep 09, 2025 at 09:32:09PM +0800, kernel test robot wrote:
> >    drivers/gpio/gpio-mpsse.c: In function 'mpsse_ensure_supported':
> > >> drivers/gpio/gpio-mpsse.c:211:25: warning: format '%ld' expects argu=
ment of type 'long int', but argument 3 has type 'int' [-Wformat=3D]
> >      211 |                         "mpsse: GPIO %ld doesn't support %s\=
n",
> >          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>
> Oops. Turns out this is m68k-specific weirdness. v2 will convert the
> result to an int and use %d.
>
> I'll hold off on posting it because I'm anticipating there will be some f=
eedback
> on the actual code changes that will need a revision anyways ;)

I cannot really give you much feedback because this patch should be
first split into smaller chunks that explain what each change is
doing. As it is: it's so complex, I simply don't understand it and
don't have enough time to try and decipher it. Please try to make it
into a series of smaller patches.

Bartosz

